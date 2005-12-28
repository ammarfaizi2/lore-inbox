Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbVL1VtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbVL1VtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 16:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbVL1VtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 16:49:06 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37613 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964925AbVL1VtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 16:49:05 -0500
Date: Wed, 28 Dec 2005 22:48:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051228214845.GA7859@elte.hu>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228212313.GA4388@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> (there's a third thing that i was also playing with, -ffunction-sections 
> and -fdata-sections, but those dont seem to be reliable on the binutils 
> side yet.)
> 
> here are the isolated unit-at-a-time numbers as well:
> 
>    text    data     bss     dec     hex filename
>   3286166  869852  387260 4543278  45532e vmlinux-orig
>   3259928  833176  387748 4480852  445f54 vmlinux-units         -0.8%
>   3194123  955168  387260 4536551  4538e7 vmlinux-inline        -2.9%
>   3119495  884960  387748 4392203  43050b vmlinux-inline+units  -5.3%
> 
> so both inlining and unit-at-a-time is a win independently [although 
> inlining alone does bloat .data], but applied together they bring an 
> additional 1.6% of .text savings. All builds done with:
> 
>    gcc version 4.0.2 20051109 (Red Hat 4.0.2-6)
> 
> how about giving the inlining stuff some more exposure in -mm (if it's 
> fine with Andrew), to check for any regressions? I'd suggest the same 
> for the unit-at-a-time thing too, in any case.

another thing: i wanted to decrease the size of -Os 
(CONFIG_CC_OPTIMIZE_FOR_SIZE) kernels, which e.g. Fedora uses too (to 
keep the icache footprint down).

I think gcc should arguably not be forced to inline things when doing 
-Os, and it's also expected to mess up much less than when optimizing 
for speed. So maybe forced inlining should be dependent on 
!CONFIG_CC_OPTIMIZE_FOR_SIZE?

I.e. like the patch below?

	Ingo

----------------->
Subject: allow gcc4 to control inlining

allow gcc4 compilers to decide what to inline and what not - instead
of the kernel forcing gcc to inline all the time.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>
----

 include/linux/compiler-gcc4.h |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

Index: linux-gcc.q/include/linux/compiler-gcc4.h
===================================================================
--- linux-gcc.q.orig/include/linux/compiler-gcc4.h
+++ linux-gcc.q/include/linux/compiler-gcc4.h
@@ -3,14 +3,19 @@
 /* These definitions are for GCC v4.x.  */
 #include <linux/compiler-gcc.h>
 
-#define inline			inline		__attribute__((always_inline))
-#define __inline__		__inline__	__attribute__((always_inline))
-#define __inline		__inline	__attribute__((always_inline))
+
+#ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
+# define inline			inline		__attribute__((always_inline))
+# define __inline__		__inline__	__attribute__((always_inline))
+# define __inline		__inline	__attribute__((always_inline))
+#endif
+
 #define __deprecated		__attribute__((deprecated))
 #define __attribute_used__	__attribute__((__used__))
 #define __attribute_pure__	__attribute__((pure))
 #define __attribute_const__	__attribute__((__const__))
-#define  noinline		__attribute__((noinline))
+#define noinline		__attribute__((noinline))
+#define __always_inline		inline __attribute__((always_inline))
 #define __must_check 		__attribute__((warn_unused_result))
 #define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
 
