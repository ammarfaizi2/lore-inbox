Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263655AbTCUQjr>; Fri, 21 Mar 2003 11:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263656AbTCUQjr>; Fri, 21 Mar 2003 11:39:47 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:42663 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S263655AbTCUQjq>; Fri, 21 Mar 2003 11:39:46 -0500
Message-Id: <200303211650.h2LGoAGi002595@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][ATM] nicstar doesnt count all dropped pdus (and powerpc fixup)
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 21 Mar 2003 11:50:10 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

these two issues with the nicstar have annoyed for some time now.  i
have a powerpc platform and the +=KERNELBASE doenst work/make sense.
pci_resource_start() should take care of this if necessary.  the
second gripe, when atm_charge() fails, you need to count the pdu you
are about to drop.

Index: linux/drivers/atm/nicstar.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/nicstar.c,v
retrieving revision 1.2
diff -b -B -u -r1.2 nicstar.c
--- linux/drivers/atm/nicstar.c	26 Feb 2003 02:23:53 -0000	1.2
+++ linux/drivers/atm/nicstar.c	21 Mar 2003 16:42:27 -0000
@@ -487,11 +487,6 @@
    card->atmdev = NULL;
    card->pcidev = pcidev;
    card->membase = pci_resource_start(pcidev, 1);
-#ifdef __powerpc__
-   /* Compensate for different memory map between host CPU and PCI bus.
-      Shouldn't we use a macro for this? */
-   card->membase += KERNELBASE;
-#endif /* __powerpc__ */
    card->membase = (unsigned long) ioremap(card->membase, NS_IOREMAP_SIZE);
    if (card->membase == 0)
    {
@@ -2315,6 +2310,7 @@
          {
             push_rxbufs(card, BUF_SM, (u32) skb, (u32) virt_to_bus(skb->data),
                         0, 0);
+            atomic_inc(&vcc->stats->rx_drop);
          }
          else
 	 {
@@ -2342,6 +2338,7 @@
             {
                push_rxbufs(card, BUF_SM, (u32) sb, (u32) virt_to_bus(sb->data),
                            0, 0);
+               atomic_inc(&vcc->stats->rx_drop);
             }
             else
 	    {
@@ -2366,6 +2363,7 @@
             {
                push_rxbufs(card, BUF_LG, (u32) skb,
                            (u32) virt_to_bus(skb->data), 0, 0);
+               atomic_inc(&vcc->stats->rx_drop);
             }
             else
             {
@@ -2450,6 +2448,7 @@
             }
 	    else
 	       dev_kfree_skb_any(hb);
+	    atomic_inc(&vcc->stats->rx_drop);
          }
          else
 	 {
