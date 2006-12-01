Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936498AbWLANxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936498AbWLANxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936501AbWLANxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:53:24 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:33037 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S936498AbWLANxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:53:23 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <mrmacman_g4@mac.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Date: Fri, 1 Dec 2006 05:52:51 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEEAABAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: <0BE44B2C-6589-4CFB-AE3A-F62317C355B8@mac.com>
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 01 Dec 2006 06:56:16 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 01 Dec 2006 06:56:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No, it can't.  If you leave the prototype alone and the function when
> called in sequence returns the same list of values, then by
> definition the internals can have no effect on the code which uses
> that function.  As further proof, if you wrapped my "my_func()" with
> this in some C file:
> int my_other_func(int a)
> {
> 	return my_func(a);
> }

This is an extremely strange position to take. If the function is in some
sense broken or invokes undefined or platform-defined behavior, it most
certainly can affect the code that uses that function.

In this case, the code invokes implementation-defined behavior and is
inlined. As a result, the outcome of the code is implementation-defined.

> Next you stick a my_other_func declaration in a header and use
> my_other_func instead of my_func() in the main function.  Now the
> result is that the compiler has no damn clue what my_other_func()
> contains so it can't optimize it out of the loop with either
> version.  You cannot treat "volatile" the way you are saying it is
> treated without severely violating both the C99 spec *and* common sense.

The compiler *happens* to have no damn clue because such inter-module
optimizations don't exist. That doesn't make the code correct, just not
likely to demonstrate its brokenness.

> > In some cases, it's very unlikely that compilers will ever become
> > smart enough to demonstrate that our code is broken, but that
> > doesn't make the code any less broken, just less likely to fail.

> No, the code is not broken because the language simply isn't defined
> that way.  Essentially when the compiler is looking at any volatile
> data it cannot ignore or optimize-away any operations on that data.

Agreed. But it's not looking at any volatile data. (What data is volatile? A
pointer is only *cast* to volatile, but then it's cast to a non-volatile
type.)

> On the other hand, when you cast volatile data into non-volatile
> data, the compiler must preserve linearity of program execution.  If
> you call a function in a loop which dereferences a pointer to a
> volatile then the compiler *MUST* always dereference the pointer,
> even if it later discards the result and continues on its merry way.

I agree, but that's not what happens. It does not discard the result, it
casts the volatile away.

> >> Actually, no.  The reason for the volatile in the pointer
> >> dereference is to force the memory access to *always* happen.
> >
> > That's why it was placed there, however it was thrown away right
> > after it was placed, in the same step it was supposed to force a
> > memory access.

> Doesn't matter if you throw away the result.  The C standard defines
> this:
>    (void)( *(volatile int *)0xABCD1234 );
> to imply that the code reads an integer from that memory location and
> then discards the result.  The whole point of volatile is you still
> MUST do the read.

The C standard, AFAICT, doesn't cover this case. The cast to void means that
no volatile object is ever accessed. One is named, but then the compiler is
explicitly told to treat it like it's not volatile. The cast does not come
after the reference, there is no sequence point here.

> Feel free to read the bugzilla entry mentioned in
> this thread as it even quotes all the pertinent sections of the C
> standard for you.

The bugzilla entry is about a different issue. If there are sections of the
C standard that you think affect the case where the volatile is discarded by
cast or conversion and never stored in any volatile-qualified variable,
please tell me what they are.

> > The problem is that '*(volatile unsigned int *)' results in a
> > 'volatile unsigned int'. The *assignment* occurs in the return
> > operation, after the 'volatile unsigned int' is *cast* to a plain
> > 'unsigned int'. The assignment is *not* in any sense volatile or
> > inviolate, so neither is the return value.
>
> No, the assignment is irrelevant but the pointer dereference in
> rvalue context *is* relevant.  The dereference forces a read operation.

The dereference forces a read operation if and only if it results in a
volatile value or is assigned to a volatile variable. That's what the
standard says. In this case, you specifically ask the compiler to pretend
the result is not volatile prior to *any* assignment.

For example, the C standard talks about "accessing a volatile object", but
there is no volatile object here. Only an object asked to be treated as
volatile in the same sequence it is asked to be treated as not volatile.
Accesses to volatile objects may not be reordered across sequence points and
must be stable at sequence points, but there is no sequence point here
between the cast to volatile and the coversion away from volatile.

In fact, when the underlying objects are non-volatile, casting a pointer to
volatile and dereferencing it does not provide *any* guarantees from the C
standard. The C standard talks about accesses to volatile objects, not
accesses no non-volatile objects through pointers that claim the object is
volatile.

> > One solution would be this:
> >
> > static inline unsigned int readl(const volatile void __iomem *addr)
> > {
> >  volatile unsigned int j;
> >  j=*(volatile unsigned int __force *) addr;
> >  return j;
> > }

> This is no different from the current code.

Yes it is, for two reasons. One is that sequence point occurs between the
volatile access and any cast away from volatile. The other is that the value
is assigned to a volatile-qualified variable, which is what the standard
says cannot be elided.

To put it another way, in the existing code, no volatile objects exist and
hence none are accessed. In the code above, an assignment is made to a
volatile object, and that assignment cannot be elided.

> You cast the pointer to
> a volatile unsigned int, you dereference that pointer, and you cast
> the result to an unsigned int.  C does not have the same "assignment"
> distinctions that C++ has.

You are pretending there are sequence points in sequential casts in C. There
are not. If a cast had a side-effect, there is nothing in the C standard
that would require the side-effects to occur in the order of the casts (C++
is different). You do not dereference the pointer and then cast the result
to an unsigned int. You dereference the pointer and get an unsigned int in
some arbitrary order or method. There is no assurance that the volatile
takes effect before it is cast away.

> > (This may or may not fix the issue though. There is at least one
> > known compiler issue that might be causing the breakage. However,
> > correct compiler optimizations should be ruled out first.)

> Nope, any GCC behavior requiring code such as the above is broken,
> not just in my opinion but in the opinion of the GCC developers
> themselves, as you'd notice if you took the time to read down to the
> end of the bugzilla discussion.

I read the bugzilla discussion. It's about a different issue. It may be that
the fix for that issue happens to fix this too, because the compiler
actually is not smart enough to make the optimization I am claiming it is
legal for it to make.

In fact, I think the compiler is trying to make a different optimization
entirely and is thinking this case is that case. But that doesn't change the
fact that this code is broken and a future compiler that does make the
optimizations I am claiming are legal may show the problem.

Unfortunately, the problem may be that I'm too right. If you only follow the
C standard, there is no difference between:

*(volatile int *)foo;
and
*(int *)foo;

If 'foo' is volatile, the access is to a volatile object in both cases. If
'foo' is not volatile, the access is to a non-volatile object in both cases.

That would obviously be a pretty useless implementation of 'volatile'. And
since I cannot suggest any change that fixes the problem without making the
code worse, it comes down to a compiler QOI issue. If there's no right way
to do something this simple, the compiler is broken no matter what the
standard says.

DS


