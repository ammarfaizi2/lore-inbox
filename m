Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVADEza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVADEza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 23:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVADEyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 23:54:44 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:30920 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262044AbVADEpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:45:06 -0500
Date: Tue, 4 Jan 2005 15:34:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/11] PPC64: remove the naca from all but iSeries
Message-Id: <20050104153445.3777e689.sfr@canb.auug.org.au>
In-Reply-To: <20050104153102.67284491.sfr@canb.auug.org.au>
References: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
	<20050104150410.199b132e.sfr@canb.auug.org.au>
	<20050104150833.5d3f3722.sfr@canb.auug.org.au>
	<20050104151229.521e8083.sfr@canb.auug.org.au>
	<20050104151906.6e50f1d2.sfr@canb.auug.org.au>
	<20050104152340.67219ccf.sfr@canb.auug.org.au>
	<20050104152705.6030abc5.sfr@canb.auug.org.au>
	<20050104153102.67284491.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_15_34_45_+1100_00DYCV2UrMsG8L=2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_15_34_45_+1100_00DYCV2UrMsG8L=2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch finally removes the naca from all architectures except legacy
iSeries and in the process makes it a structure instead of a pointer.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-naca.7/arch/ppc64/kernel/LparData.c linus-bk-naca.8/arch/ppc64/kernel/LparData.c
--- linus-bk-naca.7/arch/ppc64/kernel/LparData.c	2004-10-26 16:06:41.000000000 +1000
+++ linus-bk-naca.8/arch/ppc64/kernel/LparData.c	2004-12-11 02:49:48.000000000 +1100
@@ -44,7 +44,7 @@
 	0xc8a5d9c4,	/* desc = "HvRD" ebcdic */
 	sizeof(struct HvReleaseData),
 	offsetof(struct naca_struct, xItVpdAreas),
-	(struct naca_struct *)(NACA_VIRT_ADDR), /* 64-bit Naca address */
+	&naca,		/* 64-bit Naca address */
 	0x6000,		/* offset of LparMap within loadarea (see head.S) */
 	0,
 	1,		/* tags inactive       */
diff -ruN linus-bk-naca.7/arch/ppc64/kernel/head.S linus-bk-naca.8/arch/ppc64/kernel/head.S
--- linus-bk-naca.7/arch/ppc64/kernel/head.S	2004-12-10 18:40:24.000000000 +1100
+++ linus-bk-naca.8/arch/ppc64/kernel/head.S	2004-12-11 02:56:12.000000000 +1100
@@ -512,17 +512,15 @@
 	 */
 	. = NACA_PHYS_ADDR
 	.globl __end_interrupts
-	.globl __start_naca
 __end_interrupts:
-__start_naca:
 #ifdef CONFIG_PPC_ISERIES
+	.globl naca
+naca:
 	.llong itVpdAreas
 #endif
 
 	. = SYSTEMCFG_PHYS_ADDR
-	.globl __end_naca
 	.globl __start_systemcfg
-__end_naca:
 __start_systemcfg:
 	. = (SYSTEMCFG_PHYS_ADDR + PAGE_SIZE)
 	.globl __end_systemcfg
@@ -1270,10 +1268,6 @@
 	SET_REG_TO_CONST(r4, SYSTEMCFG_VIRT_ADDR)
 	std	r4,0(r9)		/* set the systemcfg pointer */
 
-	LOADADDR(r9,naca)
-	SET_REG_TO_CONST(r4, NACA_VIRT_ADDR)
-	std	r4,0(r9)		/* set the naca pointer */
-
 	bl	.iSeries_early_setup
 
 	/* relocation is on at this point */
@@ -1873,12 +1867,6 @@
 	li	r27,SYSTEMCFG_PHYS_ADDR
 	std	r27,0(r6)	 	/* set the value of systemcfg	*/
 
-	/* setup the naca pointer which is needed by *tab_initialize	*/
-	LOADADDR(r6,naca)
-	sub	r6,r6,r26		/* addr of the variable naca	*/
-	li	r27,NACA_PHYS_ADDR
-	std	r27,0(r6)	 	/* set the value of naca	*/
-
 #ifdef CONFIG_HMT
 	/* Start up the second thread on cpu 0 */
 	mfspr	r3,PVR
@@ -2015,11 +2003,6 @@
 	SET_REG_TO_CONST(r8, SYSTEMCFG_VIRT_ADDR)
 	std	r8,0(r9)
 
-	/* setup the naca pointer */
-	LOADADDR(r9,naca)
-	SET_REG_TO_CONST(r8, NACA_VIRT_ADDR)
-	std	r8,0(r9)		/* set the value of the naca ptr */
-
 	LOADADDR(r26, boot_cpuid)
 	lwz	r26,0(r26)
 
diff -ruN linus-bk-naca.7/arch/ppc64/kernel/iSeries_setup.c linus-bk-naca.8/arch/ppc64/kernel/iSeries_setup.c
--- linus-bk-naca.7/arch/ppc64/kernel/iSeries_setup.c	2004-12-31 14:52:14.000000000 +1100
+++ linus-bk-naca.8/arch/ppc64/kernel/iSeries_setup.c	2004-12-11 02:51:17.000000000 +1100
@@ -314,13 +314,13 @@
 	 * If the init RAM disk has been configured and there is
 	 * a non-zero starting address for it, set it up
 	 */
-	if (naca->xRamDisk) {
-		initrd_start = (unsigned long)__va(naca->xRamDisk);
-		initrd_end = initrd_start + naca->xRamDiskSize * PAGE_SIZE;
+	if (naca.xRamDisk) {
+		initrd_start = (unsigned long)__va(naca.xRamDisk);
+		initrd_end = initrd_start + naca.xRamDiskSize * PAGE_SIZE;
 		initrd_below_start_ok = 1;	// ramdisk in kernel space
 		ROOT_DEV = Root_RAM0;
-		if (((rd_size * 1024) / PAGE_SIZE) < naca->xRamDiskSize)
-			rd_size = (naca->xRamDiskSize * PAGE_SIZE) / 1024;
+		if (((rd_size * 1024) / PAGE_SIZE) < naca.xRamDiskSize)
+			rd_size = (naca.xRamDiskSize * PAGE_SIZE) / 1024;
 	} else
 #endif /* CONFIG_BLK_DEV_INITRD */
 	{
@@ -813,9 +813,9 @@
 	 * Change klimit to take into account any ram disk
 	 * that may be included
 	 */
-	if (naca->xRamDisk)
-		klimit = KERNELBASE + (u64)naca->xRamDisk +
-			(naca->xRamDiskSize * PAGE_SIZE);
+	if (naca.xRamDisk)
+		klimit = KERNELBASE + (u64)naca.xRamDisk +
+			(naca.xRamDiskSize * PAGE_SIZE);
 	else {
 		/*
 		 * No ram disk was included - check and see if there
diff -ruN linus-bk-naca.7/arch/ppc64/kernel/pacaData.c linus-bk-naca.8/arch/ppc64/kernel/pacaData.c
--- linus-bk-naca.7/arch/ppc64/kernel/pacaData.c	2004-12-31 14:52:14.000000000 +1100
+++ linus-bk-naca.8/arch/ppc64/kernel/pacaData.c	2004-12-11 02:50:23.000000000 +1100
@@ -18,11 +18,8 @@
 
 #include <asm/iSeries/ItLpPaca.h>
 #include <asm/iSeries/ItLpQueue.h>
-#include <asm/naca.h>
 #include <asm/paca.h>
 
-struct naca_struct *naca;
-EXPORT_SYMBOL(naca);
 struct systemcfg *systemcfg;
 EXPORT_SYMBOL(systemcfg);
 
diff -ruN linus-bk-naca.7/include/asm-ppc64/iSeries/HvReleaseData.h linus-bk-naca.8/include/asm-ppc64/iSeries/HvReleaseData.h
--- linus-bk-naca.7/include/asm-ppc64/iSeries/HvReleaseData.h	2004-01-20 08:20:26.000000000 +1100
+++ linus-bk-naca.8/include/asm-ppc64/iSeries/HvReleaseData.h	2004-12-11 02:52:05.000000000 +1100
@@ -26,6 +26,7 @@
 //   address of the OS's NACA).
 //
 #include <asm/types.h>
+#include <asm/naca.h>
 
 //=============================================================================
 //
diff -ruN linus-bk-naca.7/include/asm-ppc64/naca.h linus-bk-naca.8/include/asm-ppc64/naca.h
--- linus-bk-naca.7/include/asm-ppc64/naca.h	2004-12-11 02:41:18.000000000 +1100
+++ linus-bk-naca.8/include/asm-ppc64/naca.h	2004-12-11 02:54:02.000000000 +1100
@@ -21,12 +21,11 @@
 	u64   xRamDiskSize;		/* In pages                  0x10 */
 };
 
-extern struct naca_struct *naca;
+extern struct naca_struct naca;
 
 #endif /* __ASSEMBLY__ */
 
 #define NACA_PAGE      0x4
 #define NACA_PHYS_ADDR (NACA_PAGE<<PAGE_SHIFT)
-#define NACA_VIRT_ADDR (KERNELBASE+NACA_PHYS_ADDR)
 
 #endif /* _NACA_H */

--Signature=_Tue__4_Jan_2005_15_34_45_+1100_00DYCV2UrMsG8L=2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2hzl4CJfqux9a+8RAlqOAKCOE091P/Cv2lZd6dntseHFW4GTxwCcD8s8
Tz/blzsUZS9klT0XdCCurrY=
=OhYA
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_15_34_45_+1100_00DYCV2UrMsG8L=2--
