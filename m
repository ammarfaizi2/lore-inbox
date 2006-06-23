Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932946AbWFWJGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932946AbWFWJGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932947AbWFWJGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:06:31 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:18817 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932946AbWFWJGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:06:31 -0400
Date: Fri, 23 Jun 2006 05:06:06 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, Mattia Dongili <malattia@linux.it>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fs/binfmt_aout.o, Error: suffix or operands invalid for  `cmp'
 [was Re: 2.6.1
In-Reply-To: <449AB908.30002@zytor.com>
Message-ID: <Pine.LNX.4.58.0606230456220.1145@gandalf.stny.rr.com>
References: <200606220238_MC3-1-C321-1AC2@compuserve.com> <449AB908.30002@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have no idea why I have binfmt_aout turned on but I did and hit this
too.

On Thu, 22 Jun 2006, H. Peter Anvin wrote:

> Chuck Ebbert wrote:
> >>>>
> >>> It's complaining about this:
> >>>
> >>> #APP
> >>>         addl %ecx,%eax ; sbbl %edx,%edx; cmpl %eax,$-1073741824; sbbl $0,%edx   # dump.u_dsize, sum, flag,
> >>> #NO_APP
> >> The cmpl should have its arguments reversed.  It's quite possible some versions of the
> >> assembler accepts the form given, but they're wrong (and doubly confusing when used as
> >> input to sbb.)
> >
> > This was built with gcc 4.0.4 20060507 (prerelease).
> >
> > I don't normally build a.out support, but I just tried and it compiled
> > fine with gcc 4.1.1.  SO this is probably a compiler bug (almost certainly
> > given that it generated illegal assembler code.)
> >
>
> It's not (it's #APP, i.e. inline assembly); rather, it's an illegal
> constraint.
>

It's GCC optimizing a little too much.

The problem code is this (in binfmt_aout.c):

/* make sure we actually have a data and stack area to dump */
	set_fs(USER_DS);
#ifdef __sparc__
	if (!access_ok(VERIFY_READ, (void __user *)START_DATA(dump), dump.u_dsize))
		dump.u_dsize = 0;
	if (!access_ok(VERIFY_READ, (void __user *)START_STACK(dump), dump.u_ssize))
		dump.u_ssize = 0;
#else
	if (!access_ok(VERIFY_READ, (void __user *)START_DATA(dump), dump.u_dsize << PAGE_SHIFT))
		dump.u_dsize = 0;
	if (!access_ok(VERIFY_READ, (void __user *)START_STACK(dump), dump.u_ssize << PAGE_SHIFT))
		dump.u_ssize = 0;
#endif


Previously it did a set_fs(KERNEL_DS) so it needs to do the
set_fs(USER_DS) now.

But that is:

  #define set_fs(x)	(current_thread_info()->addr_limit = (x))

and access_ok is:

  #define access_ok(type,addr,size) (likely(__range_ok(addr,size) == 0))

where __range_ok is:

#define __range_ok(addr,size) ({ \
	unsigned long flag,sum; \
	__chk_user_ptr(addr); \
	asm("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0" \
		:"=&r" (flag), "=r" (sum) \
		:"1" (addr),"g" ((int)(size)),"g" (current_thread_info()->addr_limit.seg)); \
	flag; })

What happened was that gcc optimized the
(current_thread_info()->addre_limit.seg to be a constant. Thus cmpl
failed.

The following patch fixes this, although I don't know the intel
constraints very well, but this does compile.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-mm1/include/asm-i386/uaccess.h
===================================================================
--- linux-2.6.17-mm1.orig/include/asm-i386/uaccess.h	2006-06-23 05:02:15.000000000 -0400
+++ linux-2.6.17-mm1/include/asm-i386/uaccess.h	2006-06-23 05:02:29.000000000 -0400
@@ -58,7 +58,7 @@ extern struct movsl_mask {
 	__chk_user_ptr(addr); \
 	asm("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0" \
 		:"=&r" (flag), "=r" (sum) \
-		:"1" (addr),"g" ((int)(size)),"g" (current_thread_info()->addr_limit.seg)); \
+		:"1" (addr),"g" ((int)(size)),"r" (current_thread_info()->addr_limit.seg)); \
 	flag; })

 /**
