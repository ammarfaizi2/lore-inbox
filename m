Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTHWJaa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 05:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTHWJa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 05:30:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:56223 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262052AbTHWJaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 05:30:21 -0400
Date: Sat, 23 Aug 2003 02:32:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]O18.1int
Message-Id: <20030823023231.6d0c8af3.akpm@osdl.org>
In-Reply-To: <200308231555.24530.kernel@kolivas.org>
References: <200308231555.24530.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a problem.   See the this analysis from Steve Pratt.


Steven Pratt <slpratt@austin.ibm.com> wrote:
>
> Mark Peloquin wrote:
> 
> > Been awhile since results where posted, therefore this is a little long.
> >
> >
> > Nightly Regression Summary for 2.6.0-test3 vs 2.6.0-test3-mm3
> >
> > Benchmark         Pass/Fail   Improvements   Regressions       
> > Results       Results   Summary
> > ---------------   ---------   ------------   -----------   
> > -----------   -----------   -------
> > dbench.ext2           P            N              N        2.6.0-test3 
> > 2.6.0-test3-mm3    report
> > dbench.ext3           P            N              Y        2.6.0-test3 
> > 2.6.0-test3-mm3    report 
> 
> The ext3 dbench regression is very significant for multi threaded 193 -> 
> 118.  Looks like this regression first showed up in mm1 and does not 
> exist in any of the bk trees.
> 
> http://ltcperf.ncsa.uiuc.edu/data/history-graphs/dbench.ext3.throughput.plot.16.png
> 
> >
> > volanomark            P            N              Y        2.6.0-test3 
> > 2.6.0-test3-mm3    report
> 
> Volanomark is significant as well.  10% drop in mm tree. This one also 
> appeared to show up in mm1 although it was a 14% drop then so mm3 
> actually looks a little better.  There were build errors on mm2 run so I 
> don't have that data at this time.
> Following link illustrates the drop in mm tree for volanomark.
> 
> http://ltcperf.ncsa.uiuc.edu/data/history-graphs/volanomark.throughput.plot.1.png
> 
> 
> SpecJBB2000 for high warehouses also took a bit hit.  Probably the same 
> root cause as volanomark.
> Here is the history plot for the 19 warehouse run.
> 
> http://ltcperf.ncsa.uiuc.edu/data/history-graphs/specjbb.results.avg.plot.19.png
> 
> Huge spike in idle time.
> http://ltcperf.ncsa.uiuc.edu/data/history-graphs/specjbb.utilization.idle.avg.plot.19.png
> 
> >
> > http://ltcperf.ncsa.uiuc.edu/data/2.6.0-test3-mm3/2.6.0-test3-vs-2.6.0-test3-mm3/ 
> >
> 

Those graphs are woeful.

Steve has done some preliminary testing which indicates that the volanomark
and specjbb regressions are due to the CPU scheduler changes.

I have verifed that the ext3 regression is mostly due to setting
PF_SYNCWRITE on kjournald.  I/O scheduler stuff.  I don't know why, but
that patch obviously bites the dust.  There is still a 10-15% regression on
dbench 16 on my 4x Xeon which is due to the CPU scheduler patches.

It's good that the reaim regression mostly went away, but it would be nice
to know why.  When I was looking into the reaim problem it appeared that
setting TIMESLICE_GRANULARITY to MAX_TIMESLICE made no difference, but more
careful testing is needed on this.

There really is no point in proceeding with this fine tuning activity when
we have these large and not understood regressions floating about.

I suggest that what we need to do is to await some more complete testing of
the CPU scheduler patch alone from Steve and co.  If it is fully confirmed
that the CPU scheduler changes are the culprit we need to either fix it or
go back to square one and start again with more careful testing and a less
ambitious set of changes.

It could be that we're looking at some sort of tradeoff here, and we're
already too far over to one side.  I don't know.

It might help if you or a buddy could get set up with volanomark on an OSDL
4-or-8-way so that you can more closely track the effect of your changes on
such benchmarks.

