Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSDEUCe>; Fri, 5 Apr 2002 15:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313538AbSDEUCZ>; Fri, 5 Apr 2002 15:02:25 -0500
Received: from mailb.telia.com ([194.22.194.6]:18192 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S313537AbSDEUCQ>;
	Fri, 5 Apr 2002 15:02:16 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] preemptive kernel behavior change: don't be rude
Date: Fri, 5 Apr 2002 22:03:09 +0200
X-Mailer: KMail [version 1.4]
In-Reply-To: <Pine.LNX.4.33.0204041740220.7731-100000@penguin.transmeta.com> <1017976155.22299.746.camel@phantasy>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204052203.09716.roger.larsson@norran.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

This does not look symmetrical, add and sub and bitops...

> +#define PREEMPT_ACTIVE		0x4000000


> +	/*
> +	 * if entering from preempt_schedule, off a kernel preemption,
> +	 * go straight to picking the next task.
> +	 */
> +	if (unlikely(preempt_get_count() & PREEMPT_ACTIVE))
> +		goto pick_next_task;
> +


> +	do {
> +		current_thread_info()->preempt_count += PREEMPT_ACTIVE;
> +		schedule();
> +		current_thread_info()->preempt_count -= PREEMPT_ACTIVE;
> +		barrier();

And since it has to be zero to end up in the routine anyway...

asmlinkage void preempt_schedule(void)
 {
	BUG_ON(current_thread_info()->preempt_count != 0);

	do {
		/* Problem: suppose a new interrupt happens before we got to set
		 * preempt_count... then we will call this routine recursively.
		 * innermost will select the correct process, but wont it be scheduled
		 * away in enclosing preempt_schedule() - schedule() will be called
		 * with PREEMPT_ACTIVE but not TIF_NEED_RESCHED...
		 * (goto pick_next_task) */

		current_thread_info()->preempt_count = PREEMPT_ACTIVE;

		/* interrupts here might cause calls to preempt_schedule() but those will
		   bounce off above since preempt_count != 0 */

		schedule();
		current_thread_info()->preempt_count = 0;

		/* interrupt here will possibly preempt the right process - no problem */

		/* need to check if any interrupt happened during the preemption off time,
		 * this case is in fact unlikely  */
	while (unlikely(test_thread_flag(TIF_NEED_RESCHED)));
}

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

