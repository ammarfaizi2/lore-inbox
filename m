Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267418AbUHJEKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267418AbUHJEKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 00:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267417AbUHJEKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 00:10:40 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23011 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267409AbUHJEK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 00:10:28 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Date: Mon, 9 Aug 2004 23:08:56 -0500
User-Agent: KMail/1.5
References: <200408092240.05287.habanero@us.ibm.com>
In-Reply-To: <200408092240.05287.habanero@us.ibm.com>
Cc: rocklind@us.ibm.com, mbligh@aracnet.com, mingo@elte.hu, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408092308.56160.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 August 2004 22:40, you wrote:
>    Rick showed me schedstats graphs of the two ... it seems to have lower
>     latency, does less rebalancing, fewer pull_tasks, etc, etc. Everything
>     looks better ... he'll send them out soon, I think (hint, hint).
>
> Okay, they're done. Here's the URL of the graphs:
>
>     http://eaglet.rain.com/rick/linux/staircase/scase-vs-noscase.html
>
> General summary: as Martin reported, we're seeing improvements in a number
> of areas, at least with sdet.  The graphs as listed there represent stats
> from four separate sdet runs run sequentially with an increasing load.
> (We're trying to see if we can get the information from each run
> separately, rather than the aggregate -- one of the hazards of an automated
> test harness :)

What's quite interesting is that there is a very noticeable surge in 
load_balance with staircase in the early stage of the test, but there appears 
to be -no- direct policy changes to load-balance at all in Con's patch (or at 
least I didn't notice it -please tell me if you did!).  You can see it in 
busy load_balance, sched_balance_exec, and pull_task.  The runslice and 
latency stats confirm this -no-staircase does not balance early on, and the 
tasks suffer, waiting on a cpu already loaded up.  I do not have an 
explanation for this; perhaps it has something to do with eliminating expired 
queue.

I would be nice to have per cpu runqueue lengths logged to see how this plays 
out -do the cpus on staircase obtain a runqueue length close to 
nr_running()/nr_online_cpus sooner than no-staircase?

Also, one big change apparent to me, the elimination of TIMESLICE_GRANULARITY.  
Do you have cswitch data?  I would not be surprised if it's a lot higher on 
-no-staircase, and cache is thrashed a lot more.  This may be something you 
can pull out of the -no-staircase kernel quite easily.

-Andrew Theurer


