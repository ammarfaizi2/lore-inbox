Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVADEup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVADEup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 23:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVADEuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 23:50:14 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:26568 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262039AbVADEoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:44:17 -0500
Date: Tue, 4 Jan 2005 15:23:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/11] PPC64: remove the paca pointer form the naca
Message-Id: <20050104152340.67219ccf.sfr@canb.auug.org.au>
In-Reply-To: <20050104151906.6e50f1d2.sfr@canb.auug.org.au>
References: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
	<20050104150410.199b132e.sfr@canb.auug.org.au>
	<20050104150833.5d3f3722.sfr@canb.auug.org.au>
	<20050104151229.521e8083.sfr@canb.auug.org.au>
	<20050104151906.6e50f1d2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_15_23_40_+1100_XXc9aLlmoM0RV2dG"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_15_23_40_+1100_XXc9aLlmoM0RV2dG
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

The only place that was using the paca pointer that was in the naca was
some assembler that used it to find a parameter to pass to some C code. 
That C code did not even declare that parameter!

Remove the paca pointer.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-naca.4/arch/ppc64/kernel/asm-offsets.c linus-bk-naca.5/arch/ppc64/kernel/asm-offsets.c
--- linus-bk-naca.4/arch/ppc64/kernel/asm-offsets.c	2004-12-31 14:52:14.000000000 +1100
+++ linus-bk-naca.5/arch/ppc64/kernel/asm-offsets.c	2004-12-10 17:27:14.000000000 +1100
@@ -28,7 +28,6 @@
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 
-#include <asm/naca.h>
 #include <asm/paca.h>
 #include <asm/iSeries/ItLpPaca.h>
 #include <asm/iSeries/ItLpQueue.h>
@@ -68,8 +67,6 @@
 #endif /* CONFIG_ALTIVEC */
 	DEFINE(MM, offsetof(struct task_struct, mm));
 
-	/* naca */
-        DEFINE(PACA, offsetof(struct naca_struct, paca));
 	DEFINE(DCACHEL1LINESIZE, offsetof(struct ppc64_caches, dline_size));
 	DEFINE(DCACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_dline_size));
 	DEFINE(DCACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, dlines_per_page));
diff -ruN linus-bk-naca.4/arch/ppc64/kernel/head.S linus-bk-naca.5/arch/ppc64/kernel/head.S
--- linus-bk-naca.4/arch/ppc64/kernel/head.S	2004-11-26 12:08:51.000000000 +1100
+++ linus-bk-naca.5/arch/ppc64/kernel/head.S	2004-12-10 18:40:24.000000000 +1100
@@ -517,12 +517,7 @@
 __start_naca:
 #ifdef CONFIG_PPC_ISERIES
 	.llong itVpdAreas
-#else
-	.llong 0x0
 #endif
-	.llong 0x0
-	.llong 0x0
-	.llong paca
 
 	. = SYSTEMCFG_PHYS_ADDR
 	.globl __end_naca
@@ -1241,6 +1236,7 @@
 #endif
 #endif
 	b 	3b			/* Loop until told to go	 */
+
 #ifdef CONFIG_PPC_ISERIES
 _STATIC(__start_initialization_iSeries)
 	/* Clear out the BSS */
@@ -1278,10 +1274,6 @@
 	SET_REG_TO_CONST(r4, NACA_VIRT_ADDR)
 	std	r4,0(r9)		/* set the naca pointer */
 
-	/* Get the pointer to the segment table */
-	ld	r6,PACA(r4)		/* Get the base paca pointer	*/
-	ld	r4,PACASTABVIRT(r6)
-
 	bl	.iSeries_early_setup
 
 	/* relocation is on at this point */
diff -ruN linus-bk-naca.4/include/asm-ppc64/naca.h linus-bk-naca.5/include/asm-ppc64/naca.h
--- linus-bk-naca.4/include/asm-ppc64/naca.h	2004-12-31 14:53:21.000000000 +1100
+++ linus-bk-naca.5/include/asm-ppc64/naca.h	2004-12-10 18:42:14.000000000 +1100
@@ -11,7 +11,6 @@
  */
 
 #include <asm/types.h>
-#include <asm/systemcfg.h>
 
 #ifndef __ASSEMBLY__
 
@@ -20,7 +19,6 @@
 	void *xItVpdAreas;              /* VPD Data                  0x00 */
 	void *xRamDisk;                 /* iSeries ramdisk           0x08 */
 	u64   xRamDiskSize;		/* In pages                  0x10 */
-	struct paca_struct *paca;	/* Ptr to an array of pacas  0x18 */
 	u64 debug_switch;		/* Debug print control       0x20 */
 	u64 banner;                     /* Ptr to banner string      0x28 */
 	u64 log;                        /* Ptr to log buffer         0x30 */

--Signature=_Tue__4_Jan_2005_15_23_40_+1100_XXc9aLlmoM0RV2dG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2hpM4CJfqux9a+8RAofYAJ9/1I+lAIceK9uhCU91ntPmYudQvACfTbK2
SRCQnNqAwItq9ETjLMi+kHI=
=DSbK
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_15_23_40_+1100_XXc9aLlmoM0RV2dG--
