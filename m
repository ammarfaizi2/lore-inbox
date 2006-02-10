Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWBJGWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWBJGWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 01:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWBJGWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 01:22:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15271 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751157AbWBJGWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 01:22:34 -0500
Date: Thu, 9 Feb 2006 22:13:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com,
       torvalds@osdl.org
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20060209221324.53089938.akpm@osdl.org>
In-Reply-To: <43EC2C9A.7000507@yahoo.com.au>
References: <20060209071832.10500.qmail@science.horizon.com>
	<20060209001850.18ca135f.akpm@osdl.org>
	<43EAFEB9.2060000@yahoo.com.au>
	<20060209004208.0ada27ef.akpm@osdl.org>
	<43EB3801.70903@yahoo.com.au>
	<20060209094815.75041932.akpm@osdl.org>
	<43EC0A44.1020302@yahoo.com.au>
	<20060209195035.5403ce95.akpm@osdl.org>
	<43EC0F3F.1000805@yahoo.com.au>
	<20060209201333.62db0e24.akpm@osdl.org>
	<43EC16D8.8030300@yahoo.com.au>
	<20060209204314.2dae2814.akpm@osdl.org>
	<43EC1BFF.1080808@yahoo.com.au>
	<20060209211356.6c3a641a.akpm@osdl.org>
	<43EC24B1.9010104@yahoo.com.au>
	<20060209215040.0dcb36b1.akpm@osdl.org>
	<43EC2C9A.7000507@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew Morton wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> >>But I've explained that they only matter for people using it in stupid ways.
> >>fsync also poses a performance problem for programs that call it after every
> >>write(2).
> > 
> > 
> > There's absolutely nothing stupid about
> > 
> > 	*p = <expr>
> > 	msync(p, sizeof(*p), MS_ASYNC);
> > 
> 
> There really is if you're expecting a short time later to do
> 
> 	*p = <expr2>
> 
> and had no need for a MS_SYNC anywhere in the meantime.
> If you did have the need for MS_SYNC, then kicking off the IO
> ASAP is going to be more efficient.

Of course these sorts of applications don't know what they'll be doing in
the future.  Often the location of the next update is driven by something
which came across the network.

> >>
> >>Is a more efficient implementation know-problematic?
> > 
> > 
> > It's less efficient for some things.  A lot.
> > 
> 
> But only for stupid things, right?

No.

> > 
> >>What applications did
> >>you observe problems with, can you remember?
> > 
> > 
> > Linus has some application which was doing the above.  It ran extremely
> > slowly, so we changed MS_ASYNC (ie: made it "more efficient"...)
> 
> Can he remember what it is? It sounds like it is broken.
> 
> OTOH, it could have been blocking on pages already under writeout
> but a smarter implementation could ignore those (at the cost of
> worse IO efficiency in these rare cases).

There's no need to do that.   Look:

msync(MS_ASYNC): propagate pte dirty flags into pagecache

LINUX_FADV_ASYNC_WRITE: start writeback on all pages in region which are
dirty and which aren't presently under writeback.

LINUX_FADV_WRITE_WAIT: wait on writeback of all pages in range.

I think that covers all conceivable scenarios.  One thing per operation,
leave the decisions and tuning up to the application.  And it gives us two
operations which are also useful in association with regular write().
