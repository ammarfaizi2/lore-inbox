Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311618AbSDDVdn>; Thu, 4 Apr 2002 16:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311647AbSDDVde>; Thu, 4 Apr 2002 16:33:34 -0500
Received: from mailg.telia.com ([194.22.194.26]:11250 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S311618AbSDDVdZ>;
	Thu, 4 Apr 2002 16:33:25 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Robert Love <rml@tech9.net>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at boot time
Date: Thu, 4 Apr 2002 23:34:04 +0200
X-Mailer: KMail [version 1.4]
Cc: Dave Hansen <haveblue@us.ibm.com>, "Adam J. Richter" <adam@yggdrasil.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204041113410.12895-100000@penguin.transmeta.com> <1017948383.22303.537.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204042334.04367.roger.larsson@norran.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On torsdagen den 4 april 2002 21.26, Robert Love wrote:
> On Thu, 2002-04-04 at 14:14, Linus Torvalds wrote:
> > The answer is that preempt_schedule() illegally sets
> >
> > 	current->state = TASK_RUNNING;
> >
> > without asking the process whether that's OK. The SMP code never does
> > anything like that.
>
> Well Ingo added that ;)
>
> We used to just set a flag in the preempt_count that marked the task as
> preempted and made sure on its next trip into schedule it ran again.
>

How about doing:

asmlinkage void preempt_schedule(void)
{
	unsigned long saved_state;

	if (unlikely(preempt_get_count()))
		return;

	preempt_disable(); /* or use an atomic operation */
	saved_state = current->state;
	current->state = TASK_RUNNING;
	preempt_enable_no_resched(); /* we are scheduling anyway... */
	schedule();
	current->state = saved_state;
}

It is unlikely to get preemption between schedule() and the
setting since schedule it self checks - the window is small.
And when it hits if will correctly restore the correct value.

Note this code does not need to solve the FLAG problem.

	 current->state |= FLAG
	* PREEMPT *
		current->state |= FLAG
		schedule()
		current->state &= ~FLAG
	schedule() with flag disabled


/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

