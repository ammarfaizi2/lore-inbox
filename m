Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSLUSm6>; Sat, 21 Dec 2002 13:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbSLUSm6>; Sat, 21 Dec 2002 13:42:58 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:17413 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S262821AbSLUSm5>; Sat, 21 Dec 2002 13:42:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <87wum38auo.fsf@rjk.greenend.org.uk>
Date: Sat, 21 Dec 2002 18:50:55 +0000
X-Face: h[Hh-7npe<<b4/eW[]sat,I3O`t8A`(ej.H!F4\8|;ih)`7{@:A~/j1}gTt4e7-n*F?.Rl^
     F<\{jehn7.KrO{!7=:(@J~]<.[{>v9!1<qZY,{EJxg6?Er4Y7Ng2\Ft>Z&W?r\c.!4DXH5PWpga"ha
     +r0NzP?vnz:e/knOY)PI-
X-Boydie: NO
From: Richard Kettlewell <rjk@greenend.org.uk>
X-Mailer: Norman
To: andre@linux-ide.org, marcelo@conectiva.com.br
CC: linux-kernel@vger.kernel.org
Subject: 2.4.20: ideN=... option stopped working
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an inherited ancient PC with a weird IDE configuration that
requires ide1=0x170,0x376,14 specified on the kernel command line in
order to boot.  This worked fine in 2.4.18 but not in 2.4.20.  I
haven't checked 2.4.19.

After some investigation I found the relevant change and tried
reverting it.  The resulting kernel works for me.  Here's the diff:

========================================================================
--- drivers/ide/ide.c~	Thu Nov 28 23:53:13 2002
+++ drivers/ide/ide.c	Sat Dec 21 18:25:59 2002
@@ -2456,7 +2456,6 @@
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
 	hwif->irq = hw->irq;
 	hwif->noprobe = 0;
-	hwif->chipset = hw->chipset;
 
 	if (!initializing) {
 		ide_probe_module();
========================================================================

During my investigation I added some printk calls which make it
clearer what ide_setup objects to when it jumps to bad_option.
Perhaps these would be of more general use, diff below.

ttfn/rjk

========================================================================
--- drivers/ide/ide.c~	Thu Nov 28 23:53:13 2002
+++ drivers/ide/ide.c	Sat Dec 21 18:25:59 2002
@@ -3427,12 +3426,16 @@
 		 * Cryptic check to ensure chipset not already set for hwif:
 		 */
 		if (i > 0 || i <= -11) {			/* is parameter a chipset name? */
-			if (hwif->chipset != ide_unknown)
+			if (hwif->chipset != ide_unknown) {
+				printk(" -- chipset already specified");
 				goto bad_option;	/* chipset already specified */
+			}
 			if (i <= -11 && i != -18 && hw != 0)
 				goto bad_hwif;		/* chipset drivers are for "ide0=" only */
-			if (i <= -11 && i != -18 && ide_hwifs[hw+1].chipset != ide_unknown)
+			if (i <= -11 && i != -18 && ide_hwifs[hw+1].chipset != ide_unknown) {
+				printk(" -- chipset for 2nd port already specified");
 				goto bad_option;	/* chipset for 2nd port already specified */
+			}
 			printk("\n");
 		}
 
