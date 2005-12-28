Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVL1LrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVL1LrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 06:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbVL1LrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 06:47:08 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:60553 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932477AbVL1LrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 06:47:07 -0500
Date: Wed, 28 Dec 2005 12:46:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Matt Mackall <mpm@selenic.com>
Subject: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051228114637.GA3003@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patchset (for the 2.6.16 tree) consists of two patches:

  gcc-no-forced-inlining.patch
  gcc-unit-at-a-time.patch

the purpose of these patches is to reduce the kernel's .text size, in 
particular if CONFIG_CC_OPTIMIZE_FOR_SIZE is specified. The effect of 
the patches on x86 is:

    text    data     bss     dec     hex filename
 3286166  869852  387260 4543278  45532e vmlinux-orig
 3194123  955168  387260 4536551  4538e7 vmlinux-inline
 3119495  884960  387748 4392203  43050b vmlinux-inline+units
  437271   77646   32192  547109   85925 vmlinux-tiny-orig
  452694   77646   32192  562532   89564 vmlinux-tiny-inline
  431891   77422   32128  541441   84301 vmlinux-tiny-inline+units

i.e. a 5.3% .text reduction (!) with a larger .config, and a 1.2% .text 
reduction with a smaller .config.

i've also done test-builds with CC_OPTIMIZE_FOR_SIZE disabled:

   text    data     bss     dec     hex filename
4080998  870384  387260 5338642  517612 vmlinux-speed-orig
4084421  872024  387260 5343705  5189d9 vmlinux-speed-inline
4010957  834048  387748 5232753  4fd871 vmlinux-speed-inline+units

so the more flexible inlining did not result in many changes [which is 
good, we want gcc to inline those in the optimized-for-speed case], but 
unit-at-a-time optimization resulted in smaller code - very likely 
meaning speed advantages as well.

unit-at-a-time still increases the kernel stack footprint somewhat (by 
about 5% in the CC_OPTIMIZE_FOR_SIZE case), but not by the insane degree 
gcc3 used to, which prompted the original -fno-unit-at-a-time addition.

so i think the combination of the two patches is a win both for small 
and for large systems. In fact the 5.3% .text reduction for embedded 
kernels is very significant.

the patches are against -git, and were test-built and test-booted on 
x86, using gcc 4.0.2.

	Ingo
