Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVDLLeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVDLLeU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVDLLdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:33:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39362 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262239AbVDLLTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:19:09 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1113288087.4319.49.camel@localhost.localdomain>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 12 Apr 2005 12:18:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-04-12 at 07:41, Mingming Cao wrote:

> > Note that this may improve average case latencies, but it's not likely
> > to improve worst-case ones.  We still need a write lock to install a new
> > window, and that's going to have to wait for us to finish finding a free
> > bit even if that operation starts using a read lock.  
> > 
> Yes indeed. However nothing is free and there are always trade-offs.:) 
> 
> By worse case you mean multiple writes trying to allocate blocks around
> same area?

It doesn't matter where they are; multiple new file opens will all be
looking for a write lock.  You only need one long-held read lock and all
the writers still block.  The worst-case latencies can't be properly
solved with r/w locks --- those let the readers go more quickly
(assuming they are in the majority), which helps the average case, but
writers still have to wait for exclusive access.  We only really help
them by dropping the lock entirely.

> Even if we take out the whole
> reservation, we still possibility run into this kind of latency: the
> bitmap on disk and on journal are extremely inconsistent so we need to
> keep searching them both until we find a free bit on both map.

Quite possibly.  But as long as that code is running without locks, it's
much easier to deal with those latencies: they won't impact other CPUs,
cond_resched() is easier, and there's even CONFIG_PREEMPT.

> > I'm not really sure what to do about worst-case here.  For that, we
> > really do want to drop the lock entirely while we do the bitmap scan.

> Hmm...if we drop the lock entirely while scan the bitmap, assuming you
> mean drop the read lock, then I am afraid we have to re-check the tree
> (require a read or write lock ) to see if the new window space is still
> there after the scan succeed.

Sure.  You basically start off with a provisional window, and then if
necessary roll it forward just the same way you roll normal windows
forward when they get to their end.  That means you can still drop the
lock while you search for new space.  When you get there, reacquire the
lock and check that the intervening space is still available.

That's really cheap for the common case.  The difficulty is when you
have many parallel allocations hitting the same bg: they allocate
provisional windows, find the same free area later on in the bg, and
then stomp on each other as they try to move their windows there.

I wonder if there's not a simple solution for this --- mark the window
as "provisional", and if any other task tries to allocate in the space
immediately following such a window, it needs to block until that window
is released.

--Stephen

