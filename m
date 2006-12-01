Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030731AbWLALY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030731AbWLALY7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 06:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936460AbWLALY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 06:24:59 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:50955 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S936458AbWLALY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 06:24:58 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <mrmacman_g4@mac.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Date: Fri, 1 Dec 2006 03:24:54 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEDBABAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: <A3610BE9-66B4-452A-9EEB-D2620A4958E2@mac.com>
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 01 Dec 2006 04:27:54 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 01 Dec 2006 04:27:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Imagine we change the code to read from some auto-increment hardware
> at a specific MMIO address instead of a global:
> > static int my_func(int a)
> > {
> > 	return a + *(volatile int *)(0xABCD1234);
> > }

> But you're telling me that the change in the header file (where the
> new function returns the exact same series of values with every call
> as the old) causes the program to enter an infinite loop?
>
> How do you rationalize this again?

No, I'm not saying that. I'm saying it *can*.

We try to write code so that no matter what information the compiler has, it
will still build correct code if the compiler is correct. When we don't do
this, smarter compilers compile our code into executables that don't do what
we want.

In some cases, it's very unlikely that compilers will ever become smart
enough to demonstrate that our code is broken, but that doesn't make the
code any less broken, just less likely to fail.

> > The 'readl' function should actually assign the value to a volatile
> > variable. Assignments to volatiles cannot be cast away, but casts
> > can and assignments to non-volatile variables can be optimized out.

> Actually, no.  The reason for the volatile in the pointer dereference
> is to force the memory access to *always* happen.

That's why it was placed there, however it was thrown away right after it
was placed, in the same step it was supposed to force a memory access.

> It's a guarantee
> that the compiler will do that memory access every time it appears.

Unless you throw it away before the memory access or in the same step as the
memory access, say by casting it.

> You have a volatile int afterwards and what you do with that nobody
> cares.

You have a volatile int unless you cast it so something else.

> The point is the presence of the volatile in a single pointer-
> dereference forcibly turns off any optimization of that specific
> access, including loop unrolling and such.

It did that in the past, because optimizers weren't smart enough. Now
they're smarter, and so the breakage in the code is becoming apparent.

The code is broken because it gets rid of the volatile in the same step that
it expects the volatile to have effect. Only an assignment to a volatile
variable cannot be elided by a cast.

To put it another way:

int j=*(int *)(volatile int *)f;
is the same as
int j=*(int *)f;

Because the 'int *' cast removes the 'volatile int *' cast. This applies to
whatever is cast, and whenever it is cast or assigned.

Let's look back at 'readl':

static inline unsigned int readl(const volatile void __iomem *addr)
{
        return *(volatile unsigned int __force *) addr;
}

Notice that there is no assignment to anything volatile qualified. Notice
also that before any assignment takes place, and in the same step as the
access that you thing can't be eliminated, the result is cast to an
'unsigned int' and returned.

The problem is that '*(volatile unsigned int *)' results in a 'volatile
unsigned int'. The *assignment* occurs in the return operation, after the
'volatile unsigned int' is *cast* to a plain 'unsigned int'. The assignment
is *not* in any sense volatile or inviolate, so neither is the return value.

One solution would be this:

static inline unsigned int readl(const volatile void __iomem *addr)
{
 volatile unsigned int j;
 j=*(volatile unsigned int __force *) addr;
 return j;
}

This will probably result in an extra memory access though. There are
probably better solutions but I can't think of any at the moment.

(This may or may not fix the issue though. There is at least one known
compiler issue that might be causing the breakage. However, correct compiler
optimizations should be ruled out first.)

DS


