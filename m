Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263495AbTDCTOW 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263499AbTDCTMf 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:12:35 -0500
Received: from holomorphy.com ([66.224.33.161]:64652 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261346AbTDCTLi 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 14:11:38 -0500
Date: Thu, 3 Apr 2003 11:22:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030403192241.GB1828@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Antonio Vargas <wind@cocodriloo.com>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
References: <20030401125159.GA8005@wind.cocodriloo.com> <20030401164126.GA993@holomorphy.com> <20030401221927.GA8904@wind.cocodriloo.com> <200304021144.21924.frankeh@watson.ibm.com> <20030403125355.GA12001@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403125355.GA12001@wind.cocodriloo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 02:53:55PM +0200, Antonio Vargas wrote:
> Sorry for not answering sooner, but I had my mail pointing at
> the lkml instead of my personal email.
> Last night I continued coding up but I think I've it a deadlock:
> it seems the system stops calling schedule_tick() when there are
> no more tasks to run, and it's there where I use a workqueue so
> that I can update the user timeslices out of interrupt context.
> I think that because if I put printk's on my code, it continues to
> run OK, but if I remove them it freezes hard.

Use spin_lock_irq(&uidhash_lock) or you will deadlock if you hold it
while you take a timer tick, but it's wrong anyway. it's O(N) with
respect to number of users present. An O(1) algorithm could easily
make use of reference counts held by tasks.


On Thu, Apr 03, 2003 at 02:53:55PM +0200, Antonio Vargas wrote:
> About giving ticks to users, I've got an idea: assuming there are N
> total processes in the system and an user has got M processes, we should
> give N * max_timeslice ticks to each user every M * max_timeslice *
> num_users ticks. I've been thinking about it and it seems it would
> balance the ticks correctly.
> About the starvation for low-priority processes, I can get and
> example.. assume user A has process X Y and user B has process Z,
> and max_timeslice = 2:
> max_timeslice = 2 and 4 total processes ==>
> give 2 * 3 = 6 ticks to user A every 2 * 2 * 2 =  8 ticks
> give 2 * 3 = 6 ticks to user B every 1 * 2 * 2 =  4 ticks

This isn't right, when expiration happens needs to be tracked by both
user and task. Basically which tasks are penalized when the user
expiration happens? The prediction is the same set of tasks will always
be the target of the penalty.


-- wli
