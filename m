Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVAFFdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVAFFdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVAFFdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:33:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:52908 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262735AbVAFFcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:32:35 -0500
Date: Wed, 5 Jan 2005 21:32:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: andrea@suse.de, riel@redhat.com, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-Id: <20050105213207.721b1aae.akpm@osdl.org>
In-Reply-To: <41DCCA68.3020100@yahoo.com.au>
References: <41DC7D86.8050609@yahoo.com.au>
	<Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com>
	<20050105173624.5c3189b9.akpm@osdl.org>
	<Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com>
	<41DCB577.9000205@yahoo.com.au>
	<20050105202611.65eb82cf.akpm@osdl.org>
	<41DCC014.80007@yahoo.com.au>
	<20050105204706.0781d672.akpm@osdl.org>
	<20050106045932.GN4597@dualathlon.random>
	<20050105210539.19807337.akpm@osdl.org>
	<20050106051707.GP4597@dualathlon.random>
	<41DCCA68.3020100@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrea Arcangeli wrote:
> > On Wed, Jan 05, 2005 at 09:05:39PM -0800, Andrew Morton wrote:
> > 
> >>Andrea Arcangeli <andrea@suse.de> wrote:
> >>
> >>>The fix is very simple and it is to call wait_on_page_writeback on one
> >>> of the pages under writeback.
> >>
> >>eek, no.  That was causing waits of five seconds or more.  Fixing this
> >>caused the single greatest improvement in page allocator latency in early
> >>2.5.  We're totally at the mercy of the elevator algorithm this way.
> >>
> >>If we're to improve things in there we want to wait on _any_ eligible page
> >>becoming reclaimable, not on a particular page.
> > 
> > 
> > I told you one way to fix it. I didn't guarantee it was the most
> > efficient one.
> > 

And I've already described the efficient way to "fix" it.  Twice.

> > I sure agree waiting on any page to complete writeback is going to fix
> > it too. Exactly because this page was a "random" page anyway.
> > 
> > Still my point is that this is a bug, and I prefer to be slow and safe
> > like 2.4, than fast and unreliable like 2.6.
> > 
> > The slight improvement you suggested of waiting on _any_ random
> > PG_writeback to go away (instead of one particular one as I did in 2.4)

It's a HUGE improvement.

  "Example: with `mem=512m', running 4 instances of `dbench 100', 2.5.34
   took 35 minutes to compile a kernel.  With this patch, it took three
   minutes, 45 seconds."

Plus this was the change which precipitated all the I/O scheduler
development, because it caused us to keep the queues full all the time and
the old I/O scheduler collapsed.

> > is going to fix the write throttling equally too as well as the 2.4
> > logic, but without introducing slowdown that 2.4 had.
> > 
> > It's easy to demonstrate: exactly because the page we pick is random
> > anyway, we can pick the first random one that has seen PG_writeback
> > transitioning from 1 to 0. The guarantee we get is the same in terms of
> > safety of the write throttling, but we also guarantee the best possible
> > latency this way. And the HZ/x hacks to avoid deadlocks will magically
> > go away too.
> > 
> 
> This is practically what blk_congestion_wait does when the queue
> isn't congested though, isn't it?

Pretty much.  Except:

- Doing a wakeup when a write request is retired corresponds to releasing
  a batch of pages, not a single page.  Usually.

- direct-io writes could confuse it.

For the third time: "fixing" this involves delivering a wakeup to all zones
in the page's classzone in end_page_writeback(), and passing the zone* into
blk_congestion_wait().  Only deliver the wakeup on every Nth page to get a
bit of batching and to reduce CPU consumption.  Then demonstrating that the
change actually improves something.
