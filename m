Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSDDTOf>; Thu, 4 Apr 2002 14:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293448AbSDDTOZ>; Thu, 4 Apr 2002 14:14:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10003 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293386AbSDDTOM>; Thu, 4 Apr 2002 14:14:12 -0500
Date: Thu, 4 Apr 2002 11:13:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
 boot time
In-Reply-To: <3CAC9B32.2050000@us.ibm.com>
Message-ID: <Pine.LNX.4.33.0204041108040.12895-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Apr 2002, Dave Hansen wrote:
>
> I've diabled preemption in the area where it used to be disabled because 
> of the old lock_kernel().  I'm sending this message from a machine with 
> that patch applied, so the patch does fix it.

I think the real fix is to make sure that preemption never hits while 
current->state == TASK_ZOMBIE.

In other words, I think the _correct_ fix is to just make 
preempt_schedule() check for something like

	if (current->state != TASK_RUNNING)
		return;

and just getting rid of the current "unconditionally set state to
running".

(Side note: if the state isn't running, we're most likely going to
reschedule in a controlled manner soon anyway. Sure, there are some loops 
which set state to non-runnable early for race avoidance, but is it a 
_problem_?)

		Linus

