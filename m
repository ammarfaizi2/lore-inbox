Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbTH0HPs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 03:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbTH0HPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 03:15:48 -0400
Received: from holomorphy.com ([66.224.33.161]:22453 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263266AbTH0HPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 03:15:41 -0400
Date: Wed, 27 Aug 2003 00:16:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: mfedyk@matchmail.com
Cc: Andrew Morton <akpm@osdl.org>, Peter Chubb <peterc@gelato.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-ID: <20030827071648.GY1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mfedyk@matchmail.com, Andrew Morton <akpm@osdl.org>,
	Peter Chubb <peterc@gelato.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au> <20030826181807.1edb8c48.akpm@osdl.org> <20030827012914.GB5280@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827012914.GB5280@matchmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike, your MUA sucks; you unwittingly removed yourself from Reply-To:


On Tue, Aug 26, 2003 at 06:29:14PM -0700, Mike Fedyk wrote:
> Command exited with non-zero status 100
> 	Command being timed: "apt-get update"
> 	User time (seconds): 0.01
> 	System time (seconds): 0.00
> 	Percent of CPU this job got: 6%
> 	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.32
> 	Average shared text size (kbytes): 0
> 	Average unshared data size (kbytes): 0
> 	Average stack size (kbytes): 0
> 	Average total size (kbytes): 0
> The averages might be nice...

The averages themselves aren't reported with getrusage(), only direct
usage measurements. Presumably luserspace computes the averages itself.
i.e. the counters are all for non-average versions of these stats and
(because we're seeing all 0's) are not reported at all.


On Tue, Aug 26, 2003 at 06:29:14PM -0700, Mike Fedyk wrote:
> 	Maximum resident set size (kbytes): 0
> But the maximum would allow any polling app to do its polling less often.
> As well as the averages above...
> 	Average resident set size (kbytes): 0
> 	Major (requiring I/O) page faults: 320
> 	Minor (reclaiming a frame) page faults: 21

The fault counters are vaguely bogus when threads are involved. There's
a comment alluding to that nearby.


On Tue, Aug 26, 2003 at 06:29:14PM -0700, Mike Fedyk wrote:
> 	Voluntary context switches: 0
> How can you have voluntary context switches in a preemptive environment?
> 	Involuntary context switches: 0

Irrelevant to CONFIG_PREEMPT; preemptive multitasking (i.e. userspace can
be preempted) as UNIX has always done is the important issue here.


On Tue, Aug 26, 2003 at 06:29:14PM -0700, Mike Fedyk wrote:
> 	Swaps: 0
> Counting swaps would be nice too.	

This already has two counters in the task_t (no, I will not use Finnish
Hungarian notation in my general posts) that are 100% unused. Probably
the only thing preventing slab poison from showing up there outright is
the whole task_t copy in kernel/fork.c and the bss zeroing for init_task.


On Tue, Aug 26, 2003 at 06:29:14PM -0700, Mike Fedyk wrote:
> 	File system inputs: 0
> 	File system outputs: 0
> 	Socket messages sent: 0
> 	Socket messages received: 0
> 	Signals delivered: 0
> Yes, yes, yes.

These would be easy to set up, they just need counters and the ticking
of the counters dropped in.


On Tue, Aug 26, 2003 at 06:29:14PM -0700, Mike Fedyk wrote:
>      	Page size (bytes): 4096
> 	Exit status: 100
> One more thing:
> $ cat /proc/meminfo 
> MemTotal:       320628 kB
> MemFree:          5148 kB
> Buffers:          8316 kB
> Where'd shared go, and why didn't rmap start populating this value?  It
> should be there in the pte-chain lists...

Shared isn't particularly useful as a single value unqualified by
sharing level.


On Tue, Aug 26, 2003 at 06:29:14PM -0700, Mike Fedyk wrote:
> Cached:         127140 kB
> SwapCached:          0 kB
> Active:         266212 kB
> Inactive:        10608 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> Why is high(total|free) there in a non-highmem kernel?  If this file were
> more dynamic, then we wouldn't have apps that counted on the line number
> instead of the first colum's value...
> Ok, so that was two more... ;)

They could probably very well be omitted; in all likelihood just making
the format more resistant to .config changes to make luserspace's life
easier is a good reason to keep it there.


-- wli
