Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263753AbTH0Rd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 13:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263759AbTH0Rd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 13:33:28 -0400
Received: from hoemail2.lucent.com ([192.11.226.163]:7046 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263753AbTH0RdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 13:33:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16204.60256.756215.90139@gargle.gargle.HOWL>
Date: Wed, 27 Aug 2003 13:33:20 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] Patch to for Cyclades ISA serial board under 2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quick patch to get my 8 port Cyclades Cyclom-Y ISA card to work under
2.6.0-test3 and higher:

--- linux-2.6.0-test3/drivers/char/cyclades.c   Sat Aug  9 00:33:22 2003
+++ linux-2.6.0-test1-mm2/drivers/char/cyclades.c       Tue Jul 22 23:19:19 2003
@@ -867,6 +867,7 @@
 static int cyz_issue_cmd(struct cyclades_card *, uclong, ucchar, uclong);
 #ifdef CONFIG_ISA
 static unsigned detect_isa_irq (volatile ucchar *);
+spinlock_t isa_card_lock = SPIN_LOCK_UNLOCKED;
 #endif /* CONFIG_ISA */
 
 static int cyclades_get_proc_info(char *, char **, off_t , int , int *, void *;
@@ -1050,14 +1051,14 @@
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
@@ -5665,7 +5666,7 @@
 cy_cleanup_module(void)
 {
     int i;
-    int e1;
+    int e1, e2;
     unsigned long flags;
 
 #ifndef CONFIG_CYZ_INTR
@@ -5675,13 +5676,10 @@
     }
 #endif /* CONFIG_CYZ_INTR */
 
-    save_flags(flags); cli();
-
     if ((e1 = tty_unregister_driver(cy_serial_driver)))
             printk("cyc: failed to unregister Cyclades serial driver(%d)\n",
                e1);
 
-    restore_flags(flags);
     put_tty_driver(cy_serial_driver);
 
     for (i = 0; i < NR_CARDS; i++) {
