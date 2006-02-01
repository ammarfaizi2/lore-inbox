Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWBAQGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWBAQGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422666AbWBAQGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:06:08 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:60837 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422663AbWBAQGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:06:07 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200602011605.k11G5wDG045821@fsgi900.americas.sgi.com>
Subject: [PATCH] 2.6 Altix : more ioc3 cleanups
To: linux-kernel@vger.kernel.org
Date: Wed, 1 Feb 2006 10:05:57 -0600 (CST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some "inline" removing that Andrew suggested, removed some locking on
add/remove at this level - we'll let the callees/users decide.

Signed-off-by: Patrick Gefre <pfg@sgi.com>


 ioc3.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)





Index: linux/drivers/sn/ioc3.c
===================================================================
--- linux.orig/drivers/sn/ioc3.c	2006-01-26 11:53:34.685090381 -0600
+++ linux/drivers/sn/ioc3.c	2006-01-26 22:13:13.934675505 -0600
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
