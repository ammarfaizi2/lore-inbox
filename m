Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264673AbUDVU6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264673AbUDVU6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264680AbUDVU6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:58:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:46500 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264673AbUDVU47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:56:59 -0400
Date: Thu, 22 Apr 2004 13:56:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       arjanv@redhat.com, Dave Jones <davej@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, viro@parcelfarce.linux.theplanet.co.uk,
       bfennema@falcon.csc.calpoly.edu
Subject: Re: Fix UDF-FS potentially dereferencing null
In-Reply-To: <or3c6vhi2x.fsf@free.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.58.0404221339300.19703@ppc970.osdl.org>
References: <20040416214104.GT20937@redhat.com> <Pine.LNX.4.58.0404161720450.3947@ppc970.osdl.org>
 <1082195458.4691.1.camel@laptop.fenrus.com> <200404171313.02784.ioe-lkml@rameria.de>
 <Pine.LNX.4.58.0404171009320.3947@ppc970.osdl.org> <or3c6vhi2x.fsf@free.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Apr 2004, Alexandre Oliva wrote:
> 
> > "safe" to my mind means that not only is it not NULL, it's also safe to 
> > dereference early (ie "prefetchable"), which has a lot of meaning for the 
> > back-end.
> 
> And how far back can this go?

Hey, "sparse" is some way away from actually generating code, so I don't
know what the answer will be. From a checking standpoint, it's a fairly
easy attribute: right now it is an attribute on the "pointer", not on the
thing it points to (unlike the "address space" attribute, which means that
the thing the pointer _points_ to is of a different type), and that means
that your example will not cause any warnings (a "safe" pointer and a
normal pointer are compatible as pointers - they both point to the same
thing, so assigning from one to the other is not something we'd warn
about).

>From an actual code generation standpoint, let's see if we ever get there.  
I can see several semantically meaningful barriers ("can't move it past
the assignment of the pointer" or even the very limited "can't move it
past that one syntactic expression"), but it would depend a lot on what
the back-end actually would/could do and keep track of.

In your example, both pointers were called "p", but they were obviously
two different symbols from a compiler perspective. So there's a clear
"assignment" from one "p" to the other "p" as part of the inline function
call, so it's not like the back-end doesn't see that part - it's assigning
from a non-safe pointer to a safe one _after_ doing the test on the
non-safe one.

As such it's perfectly clear to the compiler what is going on in your
example; it's just a practical matter of taking it into account at the
right time. Whether that is a realistic thing to do, and worth doing, I
really don't know.

So I'll just claim that the "safe" attribute at least in theory makes
sense. Whether it matters in practice I'll leave to others.

> GCC's nonnull attribute is indeed useless for these purposes.  Even
> though the docs say it could be used to optimize away a NULL test, its
> syntax is far too cumbersome, since you apply the nonnull attribute to
> the function, not to its argument, which makes it unusable for
> non-argument variables.

Ahh. I didn't even know how the gcc nonnull thing worked. I just knew from
the gcc lists that something like that existed, and I just stupidly
assumed that it was done the sane way (ie the way I did it - which is, of
course, the very definition of "sane" ;).

		Linus
