Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbTBTPhn>; Thu, 20 Feb 2003 10:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbTBTPhn>; Thu, 20 Feb 2003 10:37:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14597 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265589AbTBTPgW>; Thu, 20 Feb 2003 10:36:22 -0500
Date: Thu, 20 Feb 2003 07:43:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302201245100.10184-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302200717230.2142-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Ingo Molnar wrote:
> 
> i think i managed to trigger a potentially useful oops, with BK-curr:

Ok, this is definitely a stack overflow:

> EIP is at do_page_fault+0x7b/0x4e4
> eax: 6b6b6b8b   ebx: 6b6b6b6b   ecx: 0000002b   edx: c02dd6ac
> esi: 6b6b6b8b   edi: ca095320   ebp: ca092170   esp: ca0920c8
> ds: 007b   es: 007b   ss: 0068
> Process start-threads (pid: 21685, threadinfo=ca090000 task=ca094ce0)

Note the "threadinfo=ca090000" and "esp: ca0920c8".

If the threadinfo isn't on the same double-page as the stack, then you're 
screwed, and you've just overwritten the _real_ threadinfo, and the stack 
is probably screwed. In fact, any recursion on do_page_fault() is 
_probably_ due to the fact that you overwrote thread-info.

This could explain Chris' problems too - my doublefault thing won't help
much if recursion on the stack has clobbered a lot of kernel state (and
the doublefault will likely happen only after enough state is clobbered 
that even the doublefault handling might have trouble).

>  [tons of pagefault recursion]
> 
>  [<c01193d0>] do_page_fault+0x0/0x4e4
>  [<c010a691>] error_code+0x2d/0x38
>  [<c011944b>] do_page_fault+0x7b/0x4e4
>  [<c01193d0>] do_page_fault+0x0/0x4e4
>  [<c010a691>] error_code+0x2d/0x38
>  [<c011944b>] do_page_fault+0x7b/0x4e4
>  [<c01294f8>] do_timer+0xc8/0xd0
>  [<c013330c>] rcu_process_callbacks+0x17c/0x1b0
>  [<c011b4bf>] scheduler_tick+0x3ff/0x410
>  [<c0125113>] tasklet_action+0x73/0xc0
>  [<c01193d0>] do_page_fault+0x0/0x4e4
>  [<c010a691>] error_code+0x2d/0x38
>  [<c011b598>] schedule+0xb8/0x3d0
>  [<c01219fd>] release_task+0x17d/0x200
>  [<c011e70f>] mmput+0x1f/0xc0
>  [<c0122cad>] do_exit+0x31d/0x3b0
>  [<c010b328>] do_nmi+0x58/0x60
>  [<c012a93e>] __dequeue_signal+0x6e/0xb0
>  [<c0122ef0>] do_group_exit+0x110/0x140
>  [<c012a9ae>] dequeue_signal+0x2e/0x60
>  [<c012c2b1>] get_signal_to_deliver+0x2b1/0x440
>  [<c01099a2>] do_signal+0xb2/0xf0
>  [<c01296c4>] schedule_timeout+0x74/0xc0
>  [<c012c4f9>] sigprocmask+0x89/0x140
>  [<c0129640>] process_timeout+0x0/0x10
>  [<c012c62d>] sys_rt_sigprocmask+0x7d/0x1a0
>  [<c0129944>] sys_nanosleep+0x154/0x180
>  [<c0109a3b>] do_notify_resume+0x5b/0x60
>  [<c0109c72>] work_notifysig+0x13/0x15

I bet the doublefaults are on "tsk->mm" accesses (specifically, 
tsk->mm->mmap_sem", which should be the first of them).

That easily happens if "tsk" is crud (either because recursion has already 
overwritten it, _or_ because %esp has recursed so far down that the 
"current()" logic ends up hitting the next page.

The stack doesn't look _that_ deep to me, but if some of these functions
have a large local frame, then that would certainly do it.. At a guess, it
Looks like a fairly deep "schedule()" coupled with deep RCU processing.

And that RCU path is reasonably new. The infrastructure was put in 2.5.43, 
which might explain Chris' case too ("somewhere before 2.5.51").

Does anybody have an up-to-date "use -gp and a special 'mcount()' 
function to check stack depth" patch? The CONFIG_DEBUG_STACKOVERFLOW thing 
is quite possibly too stupid to find things like this (it only finds 
interrupts that overflow the stack, not deep call sequences).

Guys: you could try to enable CONFIG_DEBUG_STACKOVERFLOW, and then perhaps 
make it a bit more aggressive (rigth now it does:

                if (unlikely(esp < (sizeof(struct thread_info) + 1024))) {

and I'd suggest changing it to something more like

		/* Have we used up more than half the stack? */
		if (unlikely(esp < 4096)) {

and add a "for (;;)" after doing the dump_stack() because otherwise the 
machine may reboot before you get anywhere.

		Linus

