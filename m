Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbTE0VjN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbTE0VjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:39:12 -0400
Received: from franka.aracnet.com ([216.99.193.44]:22729 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264188AbTE0VjD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:39:03 -0400
Date: Tue, 27 May 2003 14:51:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>
cc: Andi Kleen <ak@suse.de>, LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Node affine NUMA scheduler extension
Message-ID: <2640000.1054072312@[10.10.2.4]>
In-Reply-To: <200305272328.27269.efocht@hpce.nec.com>
References: <200305271031.55554.efocht@hpce.nec.com> <200305271154.52608.efocht@hpce.nec.com> <10090000.1054049930@[10.10.2.4]> <200305272328.27269.efocht@hpce.nec.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Erich Focht <efocht@hpce.nec.com> wrote (on Tuesday, May 27, 2003 23:28:27 +0200):

> On Tuesday 27 May 2003 17:38, Martin J. Bligh wrote:
>> > Interesting observation, I didn't make it when I tried the lazy
>> > homenode (quite a while ago). But I was focusing on MPI jobs. So what
>> > if we add a condition to CAN_MIGRATE which disables the cache affinity
>> > before the first load balance?
> ...
>> 
>> It'd be nice not to require user intervention here ... is it OK to
>> set CAN_MIGRATE for all clone operations?
> 
> Do you think of something like:
> 
># define CAN_MIGRATE_TASK(p,rq,this_cpu)				\
> 	(HOMENODE_UNSET(p) &&					\ //<--
> 	 (jiffies - (p)->last_run > cache_decay_ticks) &&	\
> 		!task_running(rq, p) &&				\
> 		((p)->cpus_allowed & (1UL << (this_cpu))))
> 
> 	curr = curr->prev;
> 
> 	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu) 
> 	    || !numa_should_migrate(tmp, busiest, this_cpu)) {
> 		if (curr != head)
> 			goto skip_queue;
> 		idx++;
> 		goto skip_bitmap;
> 	}
> 	if (HOMENODE_UNSET(tmp))				//<--
> 		set_task_node(tmp,cpu_to_node(this_cpu));	//<--
> 	pull_task(busiest, array, tmp, this_rq, this_cpu);
> 	if (!idle && --imbalance) {
> 	...
> 
> ?
> Guess this would help a bit for multithreaded jobs. Chosing the
> homenode more carefully here would be pretty expensive.

My first instinct is that #define'ing CAN_MIGRATE_TASK in the midst
of a function needs to die a horrible death ;-) But you didn't start
that one, so other than that ...

My instinct would tell me the first expression should be ||, not &&
but I'm not 100% sure. And is this restricted to just clones? Doesn't
seem to be, unless that's implicit in homenode_unset?

M.



