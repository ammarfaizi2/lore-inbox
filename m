Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265012AbTFCNmM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265013AbTFCNmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:42:12 -0400
Received: from hoemail2.lucent.com ([192.11.226.163]:21391 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265012AbTFCNmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:42:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16092.43199.508405.13092@gargle.gargle.HOWL>
Date: Tue, 3 Jun 2003 09:55:11 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com, support@cyclades.com
Subject: PATCH: 2.5.70 - Cyclades - Cyclom-Y/ISA locking
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've patched the cyclades driver, version 2.3.2.8 as shipped with
Linux Kernel 2.5.70, to support my Cyclom-Y/ISA board.  This is mostly
to just update the locking to support ISA probing properly, due to the
changes in the 2.5 tree.  This was based on the instructions written
in Documentation/cli-sti-removal.txt.

I've compiled and used my serial board with this patch on both SMP and
UP, running 2.5.70-mm3.

I also patched the Kconfig entries as well to better reflect the
driver support and what it offers.  

Thanks,
John

--------------------------patch here-----------------------------------

--- linux-2.5.70/drivers/char/cyclades.c        Tue Jun  3 09:43:51 2003
+++ linux-2.5.70-mm3/drivers/char/cyclades.c    Sun Jun  1 11:27:28 2003
@@ -1041,8 +1041,11 @@
   int irq;
   unsigned long irqs, flags;
   int save_xir, save_car;
+  spinlock_t        isa_card_lock;
   int index = 0; /* IRQ probing is only for ISA */
 
+    spin_lock_init(&isa_card_lock);
+
     /* forget possible initially masked and pending IRQ */
     irq = probe_irq_off(probe_irq_on());
 
@@ -1055,14 +1058,14 @@
     udelay(5000L);
 
     /* Enable the Tx interrupts on the CD1400 */
-    save_flags(flags); cli();
+    spin_lock_irqsave(&isa_card_lock,flags);
     cy_writeb((u_long)address + (CyCAR<<index), 0);
     cyy_issue_cmd(address, CyCHAN_CTL|CyENB_XMTR, index);
 
     cy_writeb((u_long)address + (CyCAR<<index), 0);
     cy_writeb((u_long)address + (CySRER<<index), 
        cy_readb(address + (CySRER<<index)) | CyTxRdy);
-    restore_flags(flags);
+    spin_unlock_irqrestore(&isa_card_lock, flags);
 
     /* Wait ... */
     udelay(5000L);
@@ -4770,7 +4773,7 @@
 #endif
 
         nboard = 0;
-
+       
 #ifdef MODULE
     /* Check for module parameters */
     for(i = 0 ; i < NR_CARDS; i++) {
@@ -5695,13 +5698,13 @@
     }
 #endif /* CONFIG_CYZ_INTR */
 
-    save_flags(flags); cli();
+    spin_lock_irqsave(&isa_card_lock, flags);
 
     if ((e1 = tty_unregister_driver(&cy_serial_driver)))
             printk("cyc: failed to unregister Cyclades serial driver(%d)\n",
        e1);
 
-    restore_flags(flags);
+    spin_unlock_irqrestore(&isa_card_lock, flags);
 
     for (i = 0; i < NR_CARDS; i++) {
         if (cy_card[i].base_addr != 0) {


--- linux-2.5.70/drivers/char/Kconfig   Sun May  4 19:52:49 2003
+++ linux-2.5.70-mm3/drivers/char/Kconfig       Sun Jun  1 10:24:27 2003
@@ -107,13 +107,14 @@
       rocket.
 
 config CYCLADES
-    tristate "Cyclades async mux support"
+    tristate "Cyclades Multiport Serial Board support"
     depends on SERIAL_NONSTANDARD
     ---help---
       This is a driver for a card that gives you many serial ports. You
       would need something like this to connect more than two modems to
       your Linux box, for instance in order to become a dial-in server.
-      For information about the Cyclades-Z card, read
+          This driver supports the Cyclom-Y (ISA/PCI) and Cyclades-Z (PCI).
+          For information about the Cyclades-Z card, read
       <file:drivers/char/README.cycladesZ>.
 
       As of 1.3.9x kernels, this driver's minor numbers start at 0 instead
------- end of forwarded message -------
