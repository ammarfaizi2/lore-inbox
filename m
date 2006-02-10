Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWBJWSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWBJWSy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 17:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWBJWSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 17:18:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:43230 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932215AbWBJWSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 17:18:54 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200602102218.k1AMIelr069357@fsgi900.americas.sgi.com>
Subject: [PATCH] 2.6 Altix : more ioc3 cleanups
To: akpm@osdl.org
Date: Fri, 10 Feb 2006 16:18:39 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some "inline" removing that Andrew suggested, removed some locking on
add/remove at this level - we'll let the callees decide.

This is a resend.


Signed-off-by: Patrick Gefre <pfg@sgi.com>


 ioc3.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)



Index: linux-2.6/drivers/sn/ioc3.c
===================================================================
--- linux-2.6.orig/drivers/sn/ioc3.c	2006-02-10 14:45:25.644934864 -0600
+++ linux-2.6/drivers/sn/ioc3.c	2006-02-10 14:48:59.455007147 -0600
@@ -62,7 +62,7 @@
         return presence;
 }
 
-static inline int nic_read_bit(struct ioc3_driver_data *idd)
+static int nic_read_bit(struct ioc3_driver_data *idd)
 {
 	int result;
 	unsigned long flags;
@@ -77,7 +77,7 @@
 	return result;
 }
 
-static inline void nic_write_bit(struct ioc3_driver_data *idd, int bit)
+static void nic_write_bit(struct ioc3_driver_data *idd, int bit)
 {
 	if (bit)
 		idd->vma->mcr = mcr_pack(6, 110);
@@ -371,8 +371,7 @@
 
 /* Interrupts */
 
-static inline void
-write_ireg(struct ioc3_driver_data *idd, uint32_t val, int which)
+static void write_ireg(struct ioc3_driver_data *idd, uint32_t val, int which)
 {
 	unsigned long flags;
 
@@ -735,14 +734,12 @@
 	}
 
 	/* Add this IOC3 to all submodules */
-	read_lock(&ioc3_submodules_lock);
 	for(id=0;id<IOC3_MAX_SUBMODULES;id++)
 		if(ioc3_submodules[id] && ioc3_submodules[id]->probe) {
 			idd->active[id] = 1;
 			idd->active[id] = !ioc3_submodules[id]->probe
 						(ioc3_submodules[id], idd);
 		}
-	read_unlock(&ioc3_submodules_lock);
 
 	printk(KERN_INFO "IOC3 Master Driver loaded for %s\n", pci_name(pdev));
 
@@ -767,7 +764,6 @@
 	idd = pci_get_drvdata(pdev);
 
 	/* Remove this IOC3 from all submodules */
-	read_lock(&ioc3_submodules_lock);
 	for(id=0;id<IOC3_MAX_SUBMODULES;id++)
 		if(idd->active[id]) {
 			if(ioc3_submodules[id] && ioc3_submodules[id]->remove)
@@ -781,7 +777,6 @@
 					        pci_name(pdev));
 			idd->active[id] = 0;
 		}
-	read_unlock(&ioc3_submodules_lock);
 
 	/* Clear and disable all IRQs */
 	write_ireg(idd, ~0, IOC3_W_IEC);
