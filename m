Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318588AbSGZUVd>; Fri, 26 Jul 2002 16:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318589AbSGZUVd>; Fri, 26 Jul 2002 16:21:33 -0400
Received: from tolkor.SGI.COM ([192.48.180.13]:15531 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S318588AbSGZUVb>;
	Fri, 26 Jul 2002 16:21:31 -0400
Subject: Re: O_DIRECT read and holes in 2.5.26
From: Stephen Lord <lord@sgi.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D3B6D57.BB5C0F38@zip.com.au>
References: <1026981790.1258.17.camel@localhost.localdomain> 
	<3D3B6D57.BB5C0F38@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Jul 2002 15:22:37 -0500
Message-Id: <1027714959.1728.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 21:26, Andrew Morton wrote:
> Stephen Lord wrote:
> > 
> > Andrew,
> > 
> > Did you realize that the new O_DIRECT code in 2.5 cannot read over holes
> > in a file.
> 
> Well that was intentional, although I confess to not having
> put a lot of thought into the decision.  The user wants
> O_DIRECT and we cannot do that.  The CPU has to clear the
> memory by hand.  Bad.

What it does mean is that things which used to work on Irix and
Linux now no longer work. You can write an app on 2.4 and have
it fail on 2.5 now.

> 
> Obviously it's easy enough to put in the code to clear the
> memory out.  Do you think that should be done?
>   
> >  The old code filled the user buffer with zeros, the new code
> > returned EINVAL if the getblock function returns an unmapped buffer.
> > With this exception, XFS does work with the new code - with more cpu
> > overhead than before due to the once per page getblock calls.
> 
> OK, thanks.  Presumably XFS has a fairly heavyweight get_block()?

No, not really that expensive, especially in the read and buffered
write path. I am objecting to the extra cpu cycles which we get to
spend in the kernel doing processing we do not need, as opposed to
spending those cycles in an application. It does not really show
up as a difference when you are sitting around waiting for the 
I/O, but if you are doing processing in parallel with the I/O
I prefer to put as many cycles in user space as possible. We have
customers who like to see 99.x% of their cpu time in user space.

> 
> I'd be interested in seeing just how expensive that O_DIRECT
> I/O is, and whether we need to get down and implement
> many-block get_block() interface.  Any numbers/profiles
> available?
> 

I will try and generate some numbers once I emerge from under a
mountain of email - I cannot use the Linus approach to email
backlogs ;-)

Steve


