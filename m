Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265546AbTFRVep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265547AbTFRVep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:34:45 -0400
Received: from auemail1.lucent.com ([192.11.223.161]:10487 "EHLO
	auemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265546AbTFRVen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:34:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.56865.325452.254827@gargle.gargle.HOWL>
Date: Wed, 18 Jun 2003 17:48:17 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH CYCLADES 1/2] fix cli()/sti() for ISA Cyclom-Y boards
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This trivially fixes the cyclades driver under ISA to get rid of the
cli()/sti() locking and use a spin lock as described in the
Documentation/cli-sti-removal.txt instructions.  I'm using this on an
SMP system without any problems so far.

Thanks,
John
john@stoffel.org



diff -ur l-2.5.72/drivers/char/cyclades.c l-2.5.72-cyclades/drivers/char/cyclades.c
--- l-2.5.72/drivers/char/cyclades.c	Wed Jun 18 10:26:21 2003
+++ l-2.5.72-cyclades/drivers/char/cyclades.c	Wed Jun 18 17:33:06 2003
@@ -867,6 +867,7 @@
 static int cyz_issue_cmd(struct cyclades_card *, uclong, ucchar, uclong);
 #ifdef CONFIG_ISA
 static unsigned detect_isa_irq (volatile ucchar *);
+spinlock_t isa_card_lock = SPIN_LOCK_UNLOCKED;
 #endif /* CONFIG_ISA */
 
 static int cyclades_get_proc_info(char *, char **, off_t , int , int *, void *);
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
@@ -5675,13 +5676,13 @@
     }
 #endif /* CONFIG_CYZ_INTR */
 
-    save_flags(flags); cli();
+    spin_lock_irqsave(&isa_card_lock, flags);
 
     if ((e1 = tty_unregister_driver(cy_serial_driver)))
             printk("cyc: failed to unregister Cyclades serial driver(%d)\n",
 		e1);
 
-    restore_flags(flags);
+    spin_unlock_irqrestore(&isa_card_lock,flags);
     put_tty_driver(cy_serial_driver);
 
     for (i = 0; i < NR_CARDS; i++) {
