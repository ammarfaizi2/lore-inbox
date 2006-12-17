Return-Path: <linux-kernel-owner+w=401wt.eu-S1752597AbWLQN3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbWLQN3M (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 08:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWLQN3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 08:29:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49058 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbWLQN3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 08:29:11 -0500
Subject: Re: V4L2: __ucmpdi2 undefined on ppc
From: David Woodhouse <dwmw2@infradead.org>
To: Kyle McMartin <kyle@ubuntu.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
       Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, paulus@samba.org
In-Reply-To: <20061214195842.GA14041@athena.road.mcmartin.ca>
References: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
	 <1166053317.909.19.camel@praia>
	 <20061214195842.GA14041@athena.road.mcmartin.ca>
Content-Type: text/plain
Date: Sun, 17 Dec 2006 13:29:05 +0000
Message-Id: <1166362145.6714.53.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 14:58 -0500, Kyle McMartin wrote:
> I posted a patch to Paul this week to fix this, 

Hm, I didn't see it on linuxppc-dev.

> Since ppc32 can't do a 64bit comparison on its own it seems, gcc
> will generate a call to a helper function from libgcc. What other
> arches do is link libgcc.a into libs-y, and export the symbol
> they want from it.

You still get to 'accidentally' do 64-bit arithmetic in-kernel that way
though. Might be better just to provide __ucmpdi2, just as we have for
the other functions which are required from libgcc 

It'd be better just to fix the compiler though -- which is in fact what
they've done: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=25724
              http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21237

I've applied this as a temporary hack to the Fedora kernel until the
compiler is updated there...

--- linux-2.6.19.ppc/arch/powerpc/kernel/misc_32.S~	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19.ppc/arch/powerpc/kernel/misc_32.S	2006-12-17 12:19:48.000000000 +0000
@@ -728,6 +728,27 @@ _GLOBAL(__lshrdi3)
 	or	r4,r4,r7	# LSW |= t2
 	blr
 
+/*
+ * __ucmpdi2: 64-bit comparison
+ *
+ * R3/R4 has 64 bit value A
+ * R5/R6 has 64 bit value B
+ * result in R3: 0 for A < B
+ *		 1 for A == B
+ *		 2 for A > B
+ */
+_GLOBAL(__ucmpdi2)
+	cmplw	r7,r3,r5	# compare high words
+	li	r3,0
+	blt	r7,2f		# a < b ... return 0
+	bgt	r7,1f		# a > b ... return 2
+	cmplw	r6,r4,r6	# compare low words
+	blt	r6,2f		# a < b ... return 0
+	li	r3,1
+	ble	r6,2f		# a = b ... return 1
+1:	li	r3,2
+2:	blr
+
 _GLOBAL(abs)
 	srawi	r4,r3,31
 	xor	r3,r3,r4
--- linux-2.6.19.ppc/arch/powerpc/kernel/ppc_ksyms.c~	2006-12-15 17:19:56.000000000 +0000
+++ linux-2.6.19.ppc/arch/powerpc/kernel/ppc_ksyms.c	2006-12-17 12:16:54.000000000 +0000
@@ -161,9 +161,11 @@ EXPORT_SYMBOL(to_tm);
 long long __ashrdi3(long long, int);
 long long __ashldi3(long long, int);
 long long __lshrdi3(long long, int);
+int __ucmpdi2(uint64_t, uint64_t);
 EXPORT_SYMBOL(__ashrdi3);
 EXPORT_SYMBOL(__ashldi3);
 EXPORT_SYMBOL(__lshrdi3);
+EXPORT_SYMBOL(__ucmpdi2);
 #endif
 
 EXPORT_SYMBOL(memcpy);

-- 
dwmw2

