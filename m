Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312505AbSC3TvG>; Sat, 30 Mar 2002 14:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312509AbSC3Tuz>; Sat, 30 Mar 2002 14:50:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17671 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312505AbSC3Tue>;
	Sat, 30 Mar 2002 14:50:34 -0500
Message-ID: <3CA616B2.1F0D8A76@zip.com.au>
Date: Sat, 30 Mar 2002 11:49:06 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Linux 2.4.19-pre5
In-Reply-To: <20020330135333.A16794@rushmore>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
> 
> > This release has -aa writeout scheduling changes, which should improve IO
> > performance (and interactivity under heavy write loads).
> 
> > _Please_ test that extensively looking for any kind of problems
> > (performance, interactivity, etc).
> 
> 2.4.19-pre5 shows a lot of improvement in the tests
> I run.  dbench 128 throughput up over 50%
> 
> dbench 128 processes
> 2.4.19-pre4              8.4 ****************
> 2.4.19-pre5             13.2 **************************

dbench throughput is highly dependent upon the amount of memory
which you allow it to use.  -pre5 is throttling writers based
on the amount of dirty buffers, not the amount of dirty+locked
buffers.   Hence this change.

It's worth noting that balance_dirty() basically does this:

	if (dirty_memory > size-of-ZONE_NORMAL * ratio)
		write_stuff();

That's rather irrational, because most of the dirty buffers
will be in ZONE_HIGHMEM.  So hmmmm.  Probably we should go
across all zones and start writeout if any of them is getting
full of dirty data.  Which may not make any difference....

> Tiobench sequential writes:
> 10-20% more throughput and latency is lower.

The bdflush changes mean that we're doing more write-behind.
So possibly write throughput only *seems* to be better,
because more of it is happening after the measurement period
has ended.  It depends whether tiobench is performing an
fsync, and is including that fsync time in its reporting.
It should be.

> Tiobench Sequential reads
> Down 7-8%.

Dunno.  I can't immediately thing of anything in pre5
which would cause this.
 
> Andrew Morton's read_latency2 patch improves tiobench
> sequential reads and writes by 10-35% in the tests I've
> run.  More importantly, read_latency2 drops max latency
> with 32-128 tiobench threads from 300-600+ seconds
> down to 2-8 seconds.  (2.4.19-pre5 is still unfair
> to some read requests when threads >= 32)

These numbers are surprising.  The get_request starvation
change should have smoothed things out.   Perhaps there's
something else going on, or it's not working right.  If
you could please send me all the details to reproduce this
I'll take a look.  Thanks.

> I'm happy with pre5 and hope more chunks of -aa show
> up in pre6.  Maybe Andrew will update read_latency2 for
> inclusion in pre6. :)  It helps tiobench seq writes too.
> dbench goes down a little though.

http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre5/


Nice testing report, BTW.  As we discussed off-list, your
opinions, observations and summary are even more valuable than
columns of numbers :)

Have fun with that quad, but don't break it.

I'll get the rest of the -aa VM patches up at the above URL
soonish.  I seem to have found a nutty workload which is returning
extremely occasional allocation failures for GFP_HIGHUSER
requests, which will deliver fatal SIGBUS at pagefault time.
There's plenty of swap available, so this is a snag.

-
