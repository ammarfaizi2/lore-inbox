Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbUKPWwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUKPWwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUKPWuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:50:40 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:48542 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261873AbUKPWtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:49:45 -0500
Message-ID: <419A83FB.2080308@yahoo.com.au>
Date: Wed, 17 Nov 2004 09:49:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling
 bugs
References: <20041116113209.GA1890@elte.hu>
In-Reply-To: <20041116113209.GA1890@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> PREEMPT_RT on SMP systems triggered weird (very high) load average
> values rather easily, which turned out to be a mainline kernel
> ->nr_uninterruptible handling bug in try_to_wake_up().
> 
> the following code:
> 
>         if (old_state == TASK_UNINTERRUPTIBLE) {
>                 old_rq->nr_uninterruptible--;
> 
> potentially executes with old_rq potentially being != rq, and hence
> updating ->nr_uninterruptible without the lock held. Given a
> sufficiently concurrent preemption workload the count can get out of
> whack and updates might get lost, permanently skewing the global count. 
> Nothing except the load-average uses nr_uninterruptible() so this
> condition can go unnoticed quite easily.
> 

Hi Ingo,
Yes you're right.

I have another idea. Revert back to the old code, then just transfer
the nr_uninterruptible count when migrating a task. That way, the
rq's nr_uninterruptible field always is a measure of the number of
uninterruptible tasks on it. What do you think?

Nick
