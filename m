Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVGGAX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVGGAX2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVGFUEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:04:41 -0400
Received: from ns2.suse.de ([195.135.220.15]:61656 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262391AbVGFR4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:56:07 -0400
Date: Wed, 6 Jul 2005 19:56:03 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] Run PCI driver initialization on local node
Message-ID: <20050706175603.GL21330@wotan.suse.de>
References: <20050706133248.GG21330@wotan.suse.de> <Pine.LNX.4.62.0507060934360.20107@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507060934360.20107@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 09:35:32AM -0700, Christoph Lameter wrote:
> On Wed, 6 Jul 2005, Andi Kleen wrote:
> 
> > Instead of adding messy kmalloc_node()s everywhere run the 
> > PCI driver probe on the node local to the device.
> > Then the normal NUMA aware allocators do the right thing.
> 
> That depends on the architecture. Some do round robin allocs for periods 
> of time during bootup. I think it is better to explicitly place control 

slab will usually do the right thing because it has a forced
local node policy, but __gfp might not.
I agree it would be better to force the policy.

I kept the scheduling to CPU because slab still needs it.

Updated patch appended.

> structures.

Patching every driver in existence? That sounds like a lot of
work. 

The node local placement should be correct for nearly all drivers. I didn't 
see any other fancy placement in your patches. If a driver still wants to do 
fancy placement it is free to overwrite the policy. Having a good
default is good.

Greg, please consider applying.

-Andi


Run PCI driver initialization on local node

Instead of adding messy kmalloc_node()s everywhere run the 
PCI driver probe on the node local to the device.

This would not have helped for IDE, but should for 
other more clean drivers that do more initialization in probe().
It won't help for drivers that do most of the work
on first open (like many network drivers)

Signed-off-by: Andi Kleen <ak@suse.de> 
cc: christoph@lameter.com

Index: linux/drivers/pci/pci-driver.c
===================================================================
--- linux.orig/drivers/pci/pci-driver.c
+++ linux/drivers/pci/pci-driver.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/mempolicy.h>
 #include "pci.h"
 
 /*
@@ -167,6 +168,34 @@ const struct pci_device_id *pci_match_de
 	return NULL;
 }
 
+static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev, 
+			  const struct pci_device_id *id)
+{
+	int error;
+#ifdef CONFIG_NUMA
+	/* Execute driver initialization on node where the 
+	   device's bus is attached to.  This way the driver likely
+	   allocates its local memory on the right node without
+	   any need to change it. */
+	struct mempolicy *oldpol; 
+	cpumask_t oldmask = current->cpus_allowed;
+	int node = pcibus_to_node(dev->bus);
+	if (node >= 0 && node_online(node))
+	    set_cpus_allowed(current, node_to_cpumask(node));	
+	/* And set default memory allocation policy */
+	oldpol = current->mempolicy;
+	current->mempolicy = &default_policy;
+	mpol_get(current->mempolicy);
+#endif
+	error = drv->probe(dev, id);
+#ifdef CONFIG_NUMA
+	set_cpus_allowed(current, oldmask);
+	mpol_free(current->mempolicy);
+	current->mempolicy = oldpol;
+#endif
+	return error;
+}
+
 /**
  * __pci_device_probe()
  * 
@@ -184,7 +213,7 @@ __pci_device_probe(struct pci_driver *dr
 
 		id = pci_match_device(drv, pci_dev);
 		if (id)
-			error = drv->probe(pci_dev, id);
+			error = pci_call_probe(drv, pci_dev, id);
 		if (error >= 0) {
 			pci_dev->driver = drv;
 			error = 0;
Index: linux/mm/mempolicy.c
===================================================================
--- linux.orig/mm/mempolicy.c
+++ linux/mm/mempolicy.c
@@ -88,7 +88,7 @@ static kmem_cache_t *sn_cache;
    policied. */
 static int policy_zone;
 
-static struct mempolicy default_policy = {
+struct mempolicy default_policy = {
 	.refcnt = ATOMIC_INIT(1), /* never free it */
 	.policy = MPOL_DEFAULT,
 };
Index: linux/include/linux/mempolicy.h
===================================================================
--- linux.orig/include/linux/mempolicy.h
+++ linux/include/linux/mempolicy.h
@@ -152,6 +152,7 @@ struct mempolicy *mpol_shared_policy_loo
 
 extern void numa_default_policy(void);
 extern void numa_policy_init(void);
+extern struct mempolicy default_policy;
 
 #else
 




