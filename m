Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVCYCgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVCYCgn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 21:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVCYCgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 21:36:43 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:29847
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261292AbVCYCgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 21:36:25 -0500
Date: Thu, 24 Mar 2005 18:29:16 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Christoph Lameter <clameter@sgi.com>
Cc: davidm@hpl.hp.com, ak@muc.de, clameter@sgi.com,
       vda@port.imtp.ilyichevsk.odessa.ua, haveblue@us.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, mel@csn.ul.ie, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
Message-Id: <20050324182916.661934df.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0503241449070.7119@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
	<200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
	<200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
	<20050318192808.GB38053@muc.de>
	<16963.2075.713737.485070@napali.hpl.hp.com>
	<Pine.LNX.4.58.0503241038040.5663@schroedinger.engr.sgi.com>
	<20050324110336.488241c4.davem@davemloft.net>
	<Pine.LNX.4.58.0503241449070.7119@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 14:49:55 -0800 (PST)
Christoph Lameter <clameter@engr.sgi.com> wrote:

> Could you help me fix up this patch replacing the old clear_pages patch?

Ok, first you need to mark the order and gfp arguments as unsigned
for mm/page_alloc.c:prep_zero_page() so that it matches the prototype
you added to include/linux/gfp.h else the compiler warns a lot.

Next, in the same function in mm/page_alloc.c, "PageHighmem()" is typo'd, it should be
"PageHighMem()".

The clear_cold() call on the next line needs a semicolon.

Erm... were any of your test builds done with the new CONFIG_CLEAR_COLD
option enabled? :-)

Next, replace your arch/sparc64/lib/clear_page.S diff with this one and
things would be working and we'll be using the proper temporal vs.
non-temporal stores on that platform.

===== arch/sparc64/lib/clear_page.S 1.1 vs edited =====
--- 1.1/arch/sparc64/lib/clear_page.S	2004-08-08 19:54:07 -07:00
+++ edited/arch/sparc64/lib/clear_page.S	2005-03-24 15:56:33 -08:00
@@ -72,26 +72,34 @@
 	mov		1, %o4
 
 clear_page_common:
-	VISEntryHalf
 	membar		#StoreLoad | #StoreStore | #LoadStore
-	fzero		%f0
 	sethi		%hi(PAGE_SIZE/64), %o1
 	mov		%o0, %g1		! remember vaddr for tlbflush
-	fzero		%f2
 	or		%o1, %lo(PAGE_SIZE/64), %o1
-	faddd		%f0, %f2, %f4
-	fmuld		%f0, %f2, %f6
-	faddd		%f0, %f2, %f8
-	fmuld		%f0, %f2, %f10
 
-	faddd		%f0, %f2, %f12
-	fmuld		%f0, %f2, %f14
-1:	stda		%f0, [%o0 + %g0] ASI_BLK_P
+#define PREFETCH(x, y)	prefetch x, y
+#define PREFETCH_CODE	2
+
+	PREFETCH([%o0 + 0x000], PREFETCH_CODE)
+	PREFETCH([%o0 + 0x040], PREFETCH_CODE)
+	PREFETCH([%o0 + 0x080], PREFETCH_CODE)
+	PREFETCH([%o0 + 0x0c0], PREFETCH_CODE)
+	PREFETCH([%o0 + 0x100], PREFETCH_CODE)
+	PREFETCH([%o0 + 0x140], PREFETCH_CODE)
+	PREFETCH([%o0 + 0x180], PREFETCH_CODE)
+1:
+	stx		%g0, [%o0 + 0x00]
+	stx		%g0, [%o0 + 0x08]
+	stx		%g0, [%o0 + 0x10]
+	stx		%g0, [%o0 + 0x18]
+	stx		%g0, [%o0 + 0x20]
+	stx		%g0, [%o0 + 0x28]
+	stx		%g0, [%o0 + 0x30]
+	stx		%g0, [%o0 + 0x38]
+	PREFETCH([%o0 + 0x1c0], PREFETCH_CODE)
 	subcc		%o1, 1, %o1
 	bne,pt		%icc, 1b
 	 add		%o0, 0x40, %o0
-	membar		#Sync
-	VISExitHalf
 
 	brz,pn		%o4, out
 	 nop
@@ -101,5 +109,32 @@
 	stw		%o2, [%g6 + TI_PRE_COUNT]
 
 out:	retl
+	 nop
+
+	.globl		clear_cold
+clear_cold:		/* %o0=dest, %o1=order */
+	sethi		%hi(PAGE_SIZE/64), %o2
+	clr		%o4
+	or		%o2, %lo(PAGE_SIZE/64), %o2
+	sllx		%o2, %o1, %o1
+	VISEntryHalf
+	membar		#StoreLoad | #StoreStore | #LoadStore
+	fzero		%f0
+	fzero		%f2
+	faddd		%f0, %f2, %f4
+	fmuld		%f0, %f2, %f6
+	faddd		%f0, %f2, %f8
+	fmuld		%f0, %f2, %f10
+
+	faddd		%f0, %f2, %f12
+	fmuld		%f0, %f2, %f14
+2:	stda		%f0, [%o0 + %g0] ASI_BLK_P
+	subcc		%o1, 1, %o1
+	bne,pt		%icc, 2b
+	 add		%o0, 0x40, %o0
+	membar		#Sync
+	VISExitHalf
+
+	retl
 	 nop
 

