Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266171AbRGLQgZ>; Thu, 12 Jul 2001 12:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266177AbRGLQgQ>; Thu, 12 Jul 2001 12:36:16 -0400
Received: from uunet-gw.macroscoop.nl ([195.193.201.73]:38160 "EHLO
	mondriaan.macroscoop.nl") by vger.kernel.org with ESMTP
	id <S266171AbRGLQgD>; Thu, 12 Jul 2001 12:36:03 -0400
From: Pim Zandbergen <P.Zandbergen@macroscoop.nl>
To: David Monro <davidm@amberdata.demon.co.uk>, linux-kernel@vger.kernel.org
Newsgroups: comp.os.linux.powerpc
Subject: IBM E15 framebuffer patch for kernel 2.4.6
Date: Thu, 12 Jul 2001 18:35:53 +0200
Organization: Macroscoop BV
Message-ID: <0firktsi53rv7qudvo36p8tlvuldk0lbgd@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just finished installing SuSE 7.1 for PowerPC on an IBM 7248-100
PReP based machine.

SuSE only provides kernel 2.2.18 for these machines.
That's a pity, as neither the 2.2.18 kernel, nor the 7248 firmware
will initialize "unsupported" PCI cards.

So I tried to compile the latest 2.4.6 kernel and succeeded.
My eepr0100 NIC and the hisax ISDN card work.

But, now there is no framebuffer support, and hence no X. Even text
mode suffers from that, I sometimes get garbage when switching VC's.


I took the plain 2.4.6 kernel plus *some* of the patches in
http://www.amberdata.demon.co.uk/carolina/caro-min-2.4.2.diff.gz
Applying the i8259.c patch produced a kernel that would not boot.


Now the E15 frambuffer patches for kernel 2.2.18 that SuSE use
(http://www.amberdata.demon.co.uk/carolina/ibm_e15fb.diff.gz)
won't apply at all to kernel 2.4. And it also seems the
interface has changed.

So, has anyone ported this framebuffer code to kernel 2.4?

Thanks.

Here are the patches I applied. They probably break other PPC
platforms.
------------------------------------------------------------
diff -ur old/include/asm-ppc/ide.h new/include/asm-ppc/ide.h
--- old/include/asm-ppc/ide.h	Sun Mar 25 18:19:01 2001
+++ new/include/asm-ppc/ide.h	Sun Mar 25 18:19:01 2001
@@ -65,6 +65,7 @@
 void ide_outsw(ide_ioreg_t port, void *buf, int ns);
 void ppc_generic_ide_fix_driveid(struct hd_driveid *id);
 
+#if 0
 #undef insw
 #define insw(port, buf, ns) 	do {				\
 	ppc_ide_md.insw((port), (buf), (ns));			\
@@ -74,6 +75,7 @@
 #define outsw(port, buf, ns) 	do {				\
 	ppc_ide_md.outsw((port), (buf), (ns));			\
 } while (0)
+#endif
 
 #undef	SUPPORT_SLOW_DATA_PORTS
 #define	SUPPORT_SLOW_DATA_PORTS	0

diff -ur linux/arch/ppc/kernel/pmac_pci.c.orig
linux/arch/ppc/kernel/pmac_pci.c
--- linux/arch/ppc/kernel/pmac_pci.c.orig	Wed Jul 11 14:06:39
2001
+++ linux/arch/ppc/kernel/pmac_pci.c	Wed Jul 11 14:54:48 2001
@@ -244,7 +244,7 @@
 {
 	unsigned int vendev, magic;
 	int rev;
-
+#if 0
 	/* read the word at offset 0 in config space for device 11 */
 	out_le32(bp->cfg_addr, (1UL << BANDIT_DEVNUM) +
PCI_VENDOR_ID);
 	udelay(2);
@@ -284,6 +284,7 @@
 	out_le32((volatile unsigned int *)bp->cfg_data, magic);
 	printk(KERN_INFO "Cache coherency enabled for bandit/PSX at
%08lx\n",
 	       bp->io_base_phys);
+#endif
 }
 

------------------------------------------------------------

