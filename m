Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131826AbQKVQQ6>; Wed, 22 Nov 2000 11:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131998AbQKVQQs>; Wed, 22 Nov 2000 11:16:48 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:6420 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S131826AbQKVQQp>; Wed, 22 Nov 2000 11:16:45 -0500
Date: Wed, 22 Nov 2000 16:44:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Stone <daniel@kabuki.eyep.net>, linux-kernel@vger.kernel.org
Subject: Re: Rik's bad process killer - how to kill _IT_?
Message-ID: <20001122164443.C6106@athlon.random>
In-Reply-To: <20001122123115Z129851-8303+80@vger.kernel.org> <Pine.LNX.4.21.0011221205320.12459-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0011221205320.12459-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Nov 22, 2000 at 12:07:48PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2000 at 12:07:48PM -0200, Rik van Riel wrote:
>    judging from your lack of error messages you're running
>    2.2 [..]

Recent 2.2.x:

	if (error_code & 4)
	{
		if (tsk->oom_kill_try++ > 10 ||
		    !((regs->eflags >> 12) & 3))
		{
			printk("VM: killing process %s\n", tsk->comm);
				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
			do_exit(SIGKILL);
		}
		else
		{
			/*
			 * The task is running with privilegies and so we
			 * trust it and we give it a chance to die gracefully.
			 */
			printk("VM: terminating process %s\n", tsk->comm);
				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
			force_sig(SIGTERM, current);
			if (tsk->oom_kill_try > 1)
			{
				tsk->policy |= SCHED_YIELD;
				schedule();
			}
			return;
		}
	}

Older 2.2.x:

	void oom(struct task_struct * task)
	{
       		printk("\nOut of memory for %s.\n", task->comm);
			  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	        force_sig(SIGKILL, task);
	}

In short if he doesn't get any message from the kernel (and the machine doesn't
soft-lockup :) it's not an oom issue.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
