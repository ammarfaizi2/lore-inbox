Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268077AbUIPOB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268077AbUIPOB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268082AbUIPOB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:01:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:26282 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268077AbUIPOB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:01:27 -0400
Date: Thu, 16 Sep 2004 07:01:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Roland Dreier <roland@topspin.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more careful about iospace accesses..
In-Reply-To: <1095337514.9144.2344.camel@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.58.0409160652460.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> 
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> 
 <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>  <52zn3rupw8.fsf@topspin.com>
  <Pine.LNX.4.58.0409151546400.2333@ppc970.osdl.org>
 <1095337514.9144.2344.camel@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Sep 2004, David Woodhouse wrote:

> On Wed, 2004-09-15 at 16:26 -0700, Linus Torvalds wrote:
> >  - if you want to go outside that bitwise type, you have to convert it 
> >    properly first. For example, if you want to add a constant to a __le16 
> >    type, you can do so, but you have to use the proper sequence:
> > 
> > 	__le16 sum, a, b;
> > 
> > 	sum = a + b;	/* INVALID! "warning: incompatible types for operation (+)" */
> > 	sum = cpu_to_le16(le16_to_cpu(a) + le16_to_cpu(b));	/* Ok */
> > 
> > See? 
> 
> Yeah right, that latter case is _so_ much more readable

It's not about readability.

It's about the first case being WRONG!

You can't add two values in the wrong byte-order. It's not an operation 
that makes sense. You _have_ to convert them to CPU byte order first.

I certainly agree that the first version "looks nicer". 

> It's even nicer when it ends up as:
> 
> 	sum = cpu_to_le16(le16_to_cpu(a) + le16_to_cpu(b));	/* Ok */
> 	sum |= c;
> 	sum = cpu_to_le16(le16_to_cpu(sum) + le16_to_cpu(d));

This is actually the strongest argument _against_ hiding endianness in the 
compiler, or hiding it behind macros. Make it very explicit, and just make 
sure there are tools (ie 'sparse') that can tell you when you do something 
wrong.

Any programmer who sees the above will go "well that's stupid", and 
rewrite it as something saner instead. You can certainly rewrite it as

	cpu_sum = le16_to_cpu(a) + le16_to_cpu(b);
	cpu_sum |= le16_to_cpu(c);
	cpu_sum += le16_to_cpu(d);
	sum = cpu_to_le16(d);

which gets rid of the double conversions. 

But if you hide the endianness in macro's, you'll never see the mess at 
all, and won't be able to fix it.

> I'd really quite like to see the real compiler know about endianness,
> too.

I would have agreed with you some time ago. Having been bitten by too damn 
many bompiler bugs I'e become convinced that the compiler doing things 
behind your back to "help" you just isn't worth it. Not in a kernel, at 
least. It's much better to build up good typechecking and the 
infrastructure to help you get the job done.

Expressions like the above might happen once or twice in a project with
several million lines of code. It's just not worth compiler infrastructure
for - that just makes people use it as if it is free, and impossible to
find the bugs when they _do_ happen. Much better to have a type system 
that can warn about the bad uses, but that doesn't actually change any of 
the code generated..

		Linus
