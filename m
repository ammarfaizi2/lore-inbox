Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTEVTvh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 15:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbTEVTvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 15:51:37 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:41161 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263195AbTEVTvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 15:51:35 -0400
Date: Thu, 22 May 2003 13:07:31 -0700
From: Andrew Morton <akpm@digeo.com>
To: jjs <jjs@tmsusa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm8 improvements and one oops
Message-Id: <20030522130731.10f34d58.akpm@digeo.com>
In-Reply-To: <3ECD13A1.9060103@tmsusa.com>
References: <3ECD13A1.9060103@tmsusa.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2003 20:04:40.0028 (UTC) FILETIME=[60AB01C0:01C3209D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jjs <jjs@tmsusa.com> wrote:
>
> kernel BUG at kernel/sched.c:614!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c011d762>]    Not tainted VLI
> EFLAGS: 00010246
> EIP is at schedule_tail+0xe2/0x140
> eax: 00000008   ebx: 00000000   ecx: d65d4e40   edx: d563c000
> esi: d8fa0120   edi: d953a31c   ebp: d563dfb8   esp: d563df9c
> ds: 007b   es: 007b   ss: 0068
> Process bonobo-activati (pid: 1275, threadinfo=d563c000 task=d65d54c0)
> Stack: 43297d43 7d43297d 297d4329 43297d43 7d43297d d8fa0120 d65d54c0 
> d564ffbc
>        c010a362 d8fa0120 01200011 00000000 00000000 00000000 40018da8 
> bfffe148
>        00000000 0000007b 0000007b 00000078 ffffe410 00000073 00000202 
> bfffe0ec
> Call Trace:
>  [<c010a362>] ret_from_fork+0x6/0x14
> 

You hit the free-of-a-freed-task_struct bug.

sched.c:614 is

static inline void finish_task_switch(task_t *prev)
{
	runqueue_t *rq = this_rq();
	struct mm_struct *mm = rq->prev_mm;

	rq->prev_mm = NULL;
	finish_arch_switch(rq, prev);
	if (mm)
		mmdrop(mm);
	if (prev->state & (TASK_DEAD | TASK_ZOMBIE))
		put_task_struct(prev);			<== here
}

and my put_task_struct is:

#define put_task_struct(tsk)					\
	do {							\
		BUG_ON((tsk)->debug == 0x6b6b6b6b);		\
		if (atomic_dec_and_test(&(tsk)->usage))		\
			__put_task_struct(tsk);			\
	} while (0)

This bug has been hanging around for ages.  It is very rare and nobody
knows what causes it.

Are you running preempt?  SMP?   Is it repeatable?

