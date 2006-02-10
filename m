Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWBJGrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWBJGrl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 01:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWBJGrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 01:47:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56490 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751166AbWBJGrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 01:47:40 -0500
Date: Thu, 9 Feb 2006 22:46:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com,
       torvalds@osdl.org
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20060209224656.7533ce2b.akpm@osdl.org>
In-Reply-To: <43EC3326.4080706@yahoo.com.au>
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
	<20060209221324.53089938.akpm@osdl.org>
	<43EC3326.4080706@yahoo.com.au>
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
> >>and had no need for a MS_SYNC anywhere in the meantime.
> >>If you did have the need for MS_SYNC, then kicking off the IO
> >>ASAP is going to be more efficient.
> > 
> > 
> > Of course these sorts of applications don't know what they'll be doing in
> > the future.  Often the location of the next update is driven by something
> > which came across the network.
> > 
> 
> If there is no actual need for the application to start a write (eg
> for data integrity) then why would it ever do that?

To get the data sent to disk in a reasonable amount of time - don't leave it
floating about in memory for hours or days.

> > 
> > There's no need to do that.   Look:
> > 
> > msync(MS_ASYNC): propagate pte dirty flags into pagecache
> > 
> > LINUX_FADV_ASYNC_WRITE: start writeback on all pages in region which are
> > dirty and which aren't presently under writeback.
> > 
> > LINUX_FADV_WRITE_WAIT: wait on writeback of all pages in range.
> > 
> > I think that covers all conceivable scenarios.  One thing per operation,
> > leave the decisions and tuning up to the application.  And it gives us two
> > operations which are also useful in association with regular write().
> > 
> 
> Oh yeah it is easy if you want to define some more APIs and do
> it in a Linux specific way.
> 
> But the main function of msync(MS_ASYNC) AFAIK is to *start* IO.
> Why do we care so much if some application goes stupid with it?

Because delaying the writeback to permit combining is a good optimisation.

The alternative of not starting new writeout of a dirty page if that page
happens to be under writeout at the time is neither one nor the other. 
With that proposal, if the application really wants IO started right now,
then it's going to have to use msync(MS_SYNC).

> Why not introduce a linux specific MS_flag to propogate pte dirty
> bits?

That's what MS_ASYNC already does.  We're agreed that something needs to
change and we're just discussing what that is.  I'm proposing something
which is complete and flexible.



Another point here is that msync(MS_SYNC) starts writeout of _all_ dirty
pages in the file (as MS_ASYNC used to do) and it waits upon writeback of
the whole file.  That's quite inefficient for an app which has lots of
threads writing to and msync()ing the same MAP_SHARED file.

We could easily enough convert msync() to only operate on the affected
region of the (non-linearly-mapped) file.  But I don't think we can do that
now, because people might be relying upon the side-effects.

The fadvise() extensions allow us to fix this.  And we've needed them for
some time for regular write()s anyway.  
