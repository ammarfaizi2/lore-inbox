Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263677AbTDDOBW (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 09:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTDDN6k (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:58:40 -0500
Received: from holomorphy.com ([66.224.33.161]:54416 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263627AbTDDNxl (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 08:53:41 -0500
Date: Fri, 4 Apr 2003 06:04:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030404140447.GC1828@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Antonio Vargas <wind@cocodriloo.com>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
References: <20030401125159.GA8005@wind.cocodriloo.com> <20030401164126.GA993@holomorphy.com> <20030401221927.GA8904@wind.cocodriloo.com> <200304021144.21924.frankeh@watson.ibm.com> <20030403125355.GA12001@wind.cocodriloo.com> <20030403192241.GB1828@holomorphy.com> <20030404112704.GA15864@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404112704.GA15864@wind.cocodriloo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 11:22:41AM -0800, William Lee Irwin III wrote:
>> Use spin_lock_irq(&uidhash_lock) or you will deadlock if you hold it
>> while you take a timer tick, but it's wrong anyway. it's O(N) with
>> respect to number of users present. An O(1) algorithm could easily
>> make use of reference counts held by tasks.
[...]
>> This isn't right, when expiration happens needs to be tracked by both
>> user and task. Basically which tasks are penalized when the user
>> expiration happens? The prediction is the same set of tasks will always
>> be the target of the penalty.

On Fri, Apr 04, 2003 at 01:27:04PM +0200, Antonio Vargas wrote:
> Just out of experimenting, I've coded something that looks reasonable
> and would not experience starvation.
> In the normal scheduler, a non-interactive task will, when used all
> his timeslice, reset p->time_slice and queue onto the expired array.
> I'm now reseting p->reserved_time_slice instead and queuing the task
> onto a per-user pending task queue.
> A separate kernel thread walks the user list, calculates the user
> timeslice and distributes it to it's pending tasks. When a task
> receives timeslices, it's moved from the per-user pending queue to
> the expired array of the runqueue, thus preparing it to run on the
> next array-switch.

Hmm, priorities getting recalculated by a kernel thread sounds kind of
scary, but who am I to judge?


On Fri, Apr 04, 2003 at 01:27:04PM +0200, Antonio Vargas wrote:
> If the user has many timeslices, he can give timeslices to many tasks, thus
> getting more work done.
> While the implementation may not be good enough, due to locking problems and
> the use of a kernel-thread, I think the fundamental algorithm feels right.
> William, should I take the lock on the uidhash_list when adding a task
> to a per-user task list?

Possible, though I'd favor a per-user spinlock.

The code looks reasonable now, modulo that race you asked about.


-- wli
