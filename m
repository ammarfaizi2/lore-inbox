Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423545AbWJ0ErT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423545AbWJ0ErT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 00:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423624AbWJ0ErT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 00:47:19 -0400
Received: from pat.uio.no ([129.240.10.4]:9439 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1423545AbWJ0ErT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 00:47:19 -0400
Date: Fri, 27 Oct 2006 06:47:12 +0200 (CEST)
From: Martin Tostrup Setek <martitse@student.matnat.uio.no>
To: David Rientjes <rientjes@cs.washington.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH: 2.6.18.1] delayacct: cpu_count in taskstats updated
 correctly
In-Reply-To: <Pine.LNX.4.64N.0610262027350.12347@attu2.cs.washington.edu>
Message-ID: <Pine.LNX.4.63.0610270545000.21448@honbori.ifi.uio.no>
References: <Pine.LNX.4.63.0610270440500.21448@honbori.ifi.uio.no>
 <Pine.LNX.4.64N.0610262027350.12347@attu2.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.272, required 12,
	autolearn=disabled, AWL -0.27, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006, David Rientjes wrote:
> On Fri, 27 Oct 2006, Martin Tostrup Setek wrote:
>> from: Martin T. Setek <martitse@ifi.uio.no>
>> cpu_count in struct taskstats should be the same as the corresponding (third)
>> value found in /proc/<pid>/schedstat
>
> I disagree in favor of Documentation/accounting/taskstats-struct.txt.
> cpu_count is the number of delay values recorded, so accumulating them is
> appropriate.

Perhaps I'm mistaken, but the code accumulates the value it 
finds in sched_info.pcnt in the task_struct. Now, in sched.h I found this:

struct sched_info {
 	/* cumulative counters */
 	unsigned long	cpu_time,	/* time spent on the cpu */
 			run_delay,	/* time spent waiting on a runqueue */
 			pcnt;		/* # of timeslices run on this cpu */

The comment says that these counters are cumulative... The code that 
updates them (sched.c: sched_info_arrive()), does accumulate them.

In include/linux/taskstats.h, I found:

          * xxx_count is the number of delay values recorded
          * xxx_delay_total is the corresponding cumulative delay in nanoseconds

I interpret these comments as saying that:

cpu_delay should be the total number of nanoseconds a task has been 
waiting in a runqueue for a CPU, and cpu_count is equal to the number of 
times the task got the CPU (or waited for it). If so, then the code 
updates taskstats.cpu_delay_total incorrectly too (which my patch didn't 
fix).

If not, then the comments in taskstats.h are very confusing....

Martin
