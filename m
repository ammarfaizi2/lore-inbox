Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUFJPEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUFJPEs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 11:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUFJPEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 11:04:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:37572 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261443AbUFJPEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 11:04:41 -0400
Date: Thu, 10 Jun 2004 08:04:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Timothy Miller <miller@techsource.com>
cc: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Al Viro <viro@math.psu.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
In-Reply-To: <40C87934.2060505@techsource.com>
Message-ID: <Pine.LNX.4.58.0406100754270.2050@ppc970.osdl.org>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu>
 <Pine.LNX.4.58.0406092059030.2050@ppc970.osdl.org> <40C87934.2060505@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Jun 2004, Timothy Miller wrote:
> 
> Are user pointers actual pointers?

Yes. They have to be. We could make them "unsigned long" or something, but 
the fact is, they do have all the pointer attributes: they are pointers to 
structures, they have _meaning_.

> That's much too tempting to dereference.

Absolutely. Which is why sparse extends the C type system so that you can 
be a pointer yet _also_ not be something you can directly dereference.

The code

        int __user * a;
        *a = 0;
        return *a;

complains about

	test.c:6:3: warning: dereference of noderef expression
	test.c:7:10: warning: dereference of noderef expression

in sparse.

> If you really want to force user space accesses to follow certain rules, 
> make them longs or structs (or at least void *) (depending on 
> architecture) so that only the proper user-space-access functions can 
> interpret them.

.. and this would be a total disaster.

Think about it. The user pointer isn't just a "value". It has a type it 
points to. We want to do

	if (get_user(len, &uiov32->iov_len) ||
		...

and yes, the above is a real example. In fact, if you grep for "get_user" 
in linux/*/*.c _most_ of the uses seem to be of this type.

In other words: user pointers _are_ pointers. You have to be able to 
access member names through them etc. It's just that you can't dereference 
them directly - but they definitely have all the other attributes of a 
pointer.

> Now, if this "handle" corresponds directly to a user space pointer, 
> someone might cast it and dereference it, but that would be easy to 
> detect, and such patches would be easy to reject.
> 
> Bad idea?

Yes. Handles are a bad idea. They make the code unreadable and totally 
type-less.

Realize that if you use just one type (the "handle") for user pointers, 
you also totally lose all C type-checking. You can't see the difference 
between a "pointer to an old-style 'struct stat'" and a "pointer to a 
new-style 'struct stat64'". So then you'd have to add your own crud to do 
type verifiations (add magic words to the handle that describe the type 
etc). 

It's a nightmare.

You want strict _static_ type analysis. Static type analysis has zero 
run-time costs, and means that you get the "right" answer at compile-time. 

And that's exactly what sparse is all about. Static type analysis.

		Linus

