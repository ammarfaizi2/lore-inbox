Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269477AbUJAIrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269477AbUJAIrA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 04:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbUJAIrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 04:47:00 -0400
Received: from ozlabs.org ([203.10.76.45]:11756 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269532AbUJAIqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 04:46:52 -0400
Date: Fri, 1 Oct 2004 18:45:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Olaf Hering <olh@suse.de>,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PPC64] Change bad choice of VSID_MULTIPLIER
Message-ID: <20041001084514.GB19046@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Anton Blanchard <anton@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Olaf Hering <olh@suse.de>,
	linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew/Linus, please apply:

We recently changed the VSID allocation on PPC64 to use a new scheme
based on a multiplicative hash.  It turns out our choice of multiplier
(the largest 28-bit prime) wasn't so great: with large contiguous
mappings, we can get very poor hash scattering.  In particular earlier
machines (without 16M pages) which had a reasonable about of RAM (>2G
or so) wouldn't boot, because the linear mapping overflowed some hash
buckets.

This patch changes the multiplier to something which seems to work
better (it is, rather arbitrarily, the median of the primes between
2^27 and 2^28).  Some more theory should almost certainly go into the
choice of this constant, to avoid more pathological cases.  But for
now, this choice fixes a serious bug, and seems to do at least as well
at scattering as the old choice on a handful of simple testcases.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/include/asm-ppc64/mmu_context.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu_context.h	2004-09-20 10:12:50.000000000 +1000
+++ working-2.6/include/asm-ppc64/mmu_context.h	2004-10-01 18:28:01.565963320 +1000
@@ -108,11 +108,10 @@
  *
  * This scramble is only well defined for proto-VSIDs below
  * 0xFFFFFFFFF, so both proto-VSID and actual VSID 0xFFFFFFFFF are
- * reserved.  VSID_MULTIPLIER is prime (the largest 28-bit prime, in
- * fact), so in particular it is co-prime to VSID_MODULUS, making this
- * a 1:1 scrambling function.  Because the modulus is 2^n-1 we can
- * compute it efficiently without a divide or extra multiply (see
- * below).
+ * reserved.  VSID_MULTIPLIER is prime, so in particular it is
+ * co-prime to VSID_MODULUS, making this a 1:1 scrambling function.
+ * Because the modulus is 2^n-1 we can compute it efficiently without
+ * a divide or extra multiply (see below).
  *
  * This scheme has several advantages over older methods:
  *
Index: working-2.6/include/asm-ppc64/mmu.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu.h	2004-09-20 10:12:50.000000000 +1000
+++ working-2.6/include/asm-ppc64/mmu.h	2004-10-01 18:28:01.566963168 +1000
@@ -202,7 +202,7 @@
 #define SLB_VSID_KERNEL		(SLB_VSID_KP|SLB_VSID_C)
 #define SLB_VSID_USER		(SLB_VSID_KP|SLB_VSID_KS)
 
-#define VSID_MULTIPLIER	ASM_CONST(268435399)	/* largest 28-bit prime */
+#define VSID_MULTIPLIER	ASM_CONST(200730139)	/* 28-bit prime */
 #define VSID_BITS	36
 #define VSID_MODULUS	((1UL<<VSID_BITS)-1)
 
Index: working-2.6/arch/ppc64/kernel/head.S
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/head.S	2004-09-24 10:14:09.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/head.S	2004-10-01 18:34:48.870941232 +1000
@@ -551,14 +551,14 @@
 	.llong	0		/* Reserved */
 	.llong	0		/* Reserved */
 	.llong	(KERNELBASE>>SID_SHIFT)
-	.llong	0x40bffffd5	/* KERNELBASE VSID */
+	.llong	0x408f92c94	/* KERNELBASE VSID */
 	/* We have to list the bolted VMALLOC segment here, too, so that it
 	 * will be restored on shared processor switch */
 	.llong	(VMALLOCBASE>>SID_SHIFT)
-	.llong	0xb0cffffd1	/* VMALLOCBASE VSID */
+	.llong	0xf09b89af5	/* VMALLOCBASE VSID */
 	.llong	8192		/* # pages to map (32 MB) */
 	.llong	0		/* Offset from start of loadarea to start of map */
-	.llong	0x40bffffd50000	/* VPN of first page to map */
+	.llong	0x408f92c940000	/* VPN of first page to map */
 
 	. = 0x6100
 



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
