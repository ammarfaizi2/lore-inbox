Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269266AbUIBXMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269266AbUIBXMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbUIBXIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:08:02 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:9168 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S269276AbUIBXGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:06:52 -0400
Message-ID: <4137A8E4.9090803@am.sony.com>
Date: Thu, 02 Sep 2004 16:12:36 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Andrew Morton <akpm@osdl.org>, ncunningham@linuxmail.org, ak@muc.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch]  kill __always_inline
References: <20040831221348.GW3466@fs.tum.de> <20040831153649.7f8a1197.akpm@osdl.org> <20040831225244.GY3466@fs.tum.de> <1093993946.8943.33.camel@laptop.cunninghams> <20040831163914.4c7c543c.akpm@osdl.org> <20040902194600.GE15358@fs.tum.de>
In-Reply-To: <20040902194600.GE15358@fs.tum.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
>>>>>>The patch below removes __always_inline again:
>>>>>

>>If the compiler supports attribute((always_inline)) then the kernel build
>>system will use that.  If the compiler doesn't support
>>attribute((always_inline)) then we just emit `inline' from cpp and hope
>>that it works out.
> 
> 
> That's exactly how `inline' is already #define'd in the Linux kernel.
> 
> And __always_inline is currently simply #define'd to `inline' ...

Sorry, but the way this is currently done in the Linux kernel is, IMHO,
braindead.

I ran into a lot of problems with inline handling while I was working
on a piece of instrumentation code that used gcc's -finstrument-functions.
I found that the kernel redefinitions for inline were not being universally
applied (see the patch below for how I fixed it for my situation). I found
that the compiler version affected whether I really got an
attribute(always_inline) or not.  Also, for some uses, the include order
(based on configuration options) affected whether I got the redefinition.

I didn't do a full survey of all inline uses.  But the errors I found
with this made me nervous.

IMHO, a better approach, if it really is desired to force always_inline,
would be to globally replace 'inline' (and friends) with kern_inline
or something similar, so you at least get a compiler error if you're
picking up the traditional gcc semantics instead of the kernel-mandated
semantics.

But my preference would be to do as Andi Kleen has suggested, which
is to revert to the use of (un-redefined) 'inline' for optional inlines,
and use '__always_inline' for those special cases that REALLY need to be
inlines.  Most (but probably not all) of these are marked with 'extern
inline' in the code today. (Unfortunately, there are a few optional
ones marked with 'extern inline' as well - which complicates things).
I realize this is riskier, but it seems to make more sense in the
long run.

Finally, I think it's bad form to change the meaning of a compiler
keyword.  It misleading for 'inline' to mean something different
in the kernel than it does everywhere else.  It means a developer
can't use standard gcc documentation to understand kernel code, without
inside knowledge.  This can be painful for casual or new kernel
developers.

Regards,
   -- Tim

diff -ruN -X ../../dontdiff linux-2.6.7/include/asm-ppc/delay.h branch_KFI/include/asm-ppc/delay.h
--- linux-2.6.7/include/asm-ppc/delay.h	2004-06-15 22:19:42.000000000 -0700
+++ branch_KFI/include/asm-ppc/delay.h	2004-08-11 15:30:22.000000000 -0700
@@ -2,6 +2,7 @@
  #ifndef _PPC_DELAY_H
  #define _PPC_DELAY_H

+#include <linux/compiler.h>	/* for inline weirdness */
  #include <asm/param.h>

  /*
diff -ruN -X ../../dontdiff linux-2.6.7/include/asm-ppc/processor.h branch_KFI/include/asm-ppc/processor.h
--- linux-2.6.7/include/asm-ppc/processor.h	2004-06-15 22:18:38.000000000 -0700
+++ branch_KFI/include/asm-ppc/processor.h	2004-08-11 15:35:25.000000000 -0700
@@ -10,6 +10,7 @@

  #include <linux/config.h>
  #include <linux/stringify.h>
+#include <linux/compiler.h>	/* for inline weirdness */

  #include <asm/ptrace.h>
  #include <asm/types.h>
diff -ruN -X ../../dontdiff linux-2.6.7/include/linux/compiler-gcc3.h branch_KFI/include/linux/compiler-gcc3.h
--- linux-2.6.7/include/linux/compiler-gcc3.h	2004-06-15 22:18:45.000000000 -0700
+++ branch_KFI/include/linux/compiler-gcc3.h	2004-08-11 14:16:34.000000000 -0700
@@ -3,7 +3,7 @@
  /* These definitions are for GCC v3.x.  */
  #include <linux/compiler-gcc.h>

-#if __GNUC_MINOR__ >= 1  && __GNUC_MINOR__ < 4
+#if __GNUC_MINOR__ >= 1
  # define inline		__inline__ __attribute__((always_inline))
  # define __inline__	__inline__ __attribute__((always_inline))
  # define __inline	__inline__ __attribute__((always_inline))


=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
