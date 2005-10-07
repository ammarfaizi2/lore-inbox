Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030537AbVJGTnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030537AbVJGTnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 15:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030545AbVJGTnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 15:43:06 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:54255 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030537AbVJGTnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 15:43:04 -0400
Date: Fri, 7 Oct 2005 15:42:48 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: John Rigg <lk@sound-man.co.uk>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt10 crashes on boot
In-Reply-To: <E1ENxei-0001C9-F7@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510071538380.8980@localhost.localdomain>
References: <E1ENxei-0001C9-F7@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


John, Please don't strip the CC list.  Ingo may want to see what's
happening, and besides, it's not proper netiquette for LKML.

On Fri, 7 Oct 2005, John Rigg wrote:

> On Friday, October 7 Steve Rostedt wrote:
>
> >Add this patch and it will add the option for you in x86_64 (I forgot that
> >you were using that).  I even set it to be default on. I didn't add a test
> >in do_IRQ, but I believe that the tests in latency.c should be good
> >enough.
>
> Hi Steve,
>
> Thanks for the patch. I applied it to 2.6.14-rc3-rt12, looked in
> arch/x86_64/Kconfig.debug just to be sure it applied OK to -rt12,
> then ran make. It failed to compile, with the following message:
>
>   CC      kernel/rt.o
>   CC      kernel/latency.o
> kernel/latency.c: In function '__print_worst_stack':
> kernel/latency.c:336: warning: format '%d' expects type 'int', but argument 5 has type 'long unsigned int'
> kernel/latency.c:384:3: error: #error Poke the author of above asm code line !
> kernel/latency.c: In function 'debug_stackoverflow':
> kernel/latency.c:386: error: 'STACK_WARN' undeclared (first use in this function)
> kernel/latency.c:386: error: (Each undeclared identifier is reported only once
> kernel/latency.c:386: error: for each function it appears in.)
> make[1]: *** [kernel/latency.o] Error 1
> make: *** [kernel] Error 2
>
> I wonder if DEBUG_STACKOVERFLOW was left out of x86_64 for this reason.
>

Here's an addon patch to my last one.  I don't know x86_64 very well, but
I believe the the asm is pretty much the same, so this patch removes the
check for __i386__ and also defines STACK_WARN.

I'm leaving for the weekend, so you are now on your own. Unless you get
help from others. ;-)

-- Steve

Index: linux-rt-quilt/include/asm-x86_64/page.h
===================================================================
--- linux-rt-quilt.orig/include/asm-x86_64/page.h	2005-10-06 08:04:00.000000000 -0400
+++ linux-rt-quilt/include/asm-x86_64/page.h	2005-10-07 15:34:20.000000000 -0400
@@ -21,6 +21,8 @@
 #endif
 #define CURRENT_MASK (~(THREAD_SIZE-1))

+#define STACK_WARN             (THREAD_SIZE/8)
+
 #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
 #define LARGE_PAGE_SIZE (1UL << PMD_SHIFT)

Index: linux-rt-quilt/kernel/latency.c
===================================================================
--- linux-rt-quilt.orig/kernel/latency.c	2005-10-06 08:04:56.000000000 -0400
+++ linux-rt-quilt/kernel/latency.c	2005-10-07 15:31:20.000000000 -0400
@@ -377,7 +377,8 @@
 	atomic_inc(&tr->disabled);

 	/* Debugging check for stack overflow: is there less than 1KB free? */
-#ifdef __i386__
+#if 1 // def __i386__
+	/* Hopefully this works on x86_64!  */
 	__asm__ __volatile__("andl %%esp,%0" :
 				"=r" (stack_left) : "0" (THREAD_SIZE - 1));
 #else
