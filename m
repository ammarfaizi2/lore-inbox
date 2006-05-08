Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWEHEPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWEHEPF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 00:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWEHEPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 00:15:05 -0400
Received: from mail.gmx.de ([213.165.64.20]:11459 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932284AbWEHEPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 00:15:04 -0400
X-Authenticated: #14349625
Subject: Re: sched_clock() uses are broken
From: Mike Galbraith <efault@gmx.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, Christopher Friesen <cfriesen@nortel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <1147023122.13315.16.camel@homer>
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
	 <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com>
	 <200605021859.18948.ak@suse.de>  <445791D3.9060306@yahoo.com.au>
	 <1146640155.7526.27.camel@homer>  <445DE925.9010006@yahoo.com.au>
	 <1147023122.13315.16.camel@homer>
Content-Type: text/plain
Date: Mon, 08 May 2006 06:14:56 +0200
Message-Id: <1147061696.8544.12.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-07 at 19:32 +0200, Mike Galbraith wrote:
> On Sun, 2006-05-07 at 22:33 +1000, Nick Piggin wrote:
> > Mike Galbraith wrote:
> > > On Wed, 2006-05-03 at 03:07 +1000, Nick Piggin wrote:
> > > 
> > >>Other problem is that some people didn't RTFM and have started trying to
> > >>use it for precise accounting :(
> > > 
> > > 
> > > Are you talking about me perchance?  I don't really care about precision
> > > _that_ much, though I certainly do want to tighten timeslice accounting.
> > 
> > No, sched_clock is fine to be used in CPU scheduling choices, which are
> > heuristic anyway (although strictly speaking, even using it for timeslicing
> > within a single CPU could cause slight unfairness).
> > 
> > I'm talking about the update_cpu_clock() / task_struct->sched_time stuff.
> 
> Oh.  I kinda sorta agree.

Here's part of the reason why.  The below is from update_cpu_clock()
when now <= last.  I print now, last_tick, timestamp, and a total
timewarp count.  This is a UP kernel, CPU is 3GHz P4 running flat out,
no clockmod (though it is compiled in).

now: 28781601231 tick: 28781610060 stamp: 28781484480 total: 111
now: 39653939737 tick: 39653953110 stamp: 39652958475 total: 112
now: 48382789863 tick: 48382802652 stamp: 48382788437 total: 113
now: 64846190533 tick: 64846203307 stamp: 64846185356 total: 114
now: 87418287278 tick: 87418298913 stamp: 87417324842 total: 115
now: 88679398808 tick: 88679409618 stamp: 88679395865 total: 116
now: 97397256650 tick: 97397270613 stamp: 97397254208 total: 117
now: 108467457132 tick: 108467470627 stamp: 108467410356 total: 118
now: 217186858841 tick: 217186868844 stamp: 217186858049 total: 119
now: 267909122394 tick: 267909132306 stamp: 267909120976 total: 120
now: 432481173047 tick: 432481183477 stamp: 432481169893 total: 121
now: 435389124209 tick: 435389134985 stamp: 435389107999 total: 122
now: 437341748522 tick: 437341757801 stamp: 437341714053 total: 124
now: 472829745453 tick: 472829755435 stamp: 472829743083 total: 125

Most happen at boot, but they continue to happen occasionally.  Even
tossing these in the bit bucket, I've given up on timeslice accuracy,
because the numbers just don't add up right.  This and the pm timer
thing make sched_clock() fairly annoying.

	-Mike

