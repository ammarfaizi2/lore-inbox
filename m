Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbTBTRyd>; Thu, 20 Feb 2003 12:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbTBTRyd>; Thu, 20 Feb 2003 12:54:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51981 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266638AbTBTRya>; Thu, 20 Feb 2003 12:54:30 -0500
Date: Thu, 20 Feb 2003 10:01:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302201830580.474-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302200949520.1385-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Ingo Molnar wrote:
> 
> a true heisenbug. I cannot reproduce it anymore. Anyway, from the serial
> console i collected 3 instances of crashes - whatever it's worth.

Pretty much every single time, release_task() has been there on the
backtrace.

In fact, I bet you this code in do_exit() is the cause:

        preempt_disable();

        if (tsk->exit_signal == -1)
***             release_task(tsk);	***

        schedule();

Note how "release_task()" will be releasing the stack that the process is 
running on right now. And the reason it doesn't crash _every_ time is 
simply that you need to have:

 - another memory allocation that picks up that page and fills it with
   something else in order to get a corrupted stack
 - and something delays schedule() so that you have time to race _and_ you 
   need the stack. Which is why most of the oopses have an interrupt come 
   in inside schedule (see the "common_interrupt()" thing

In other words, I think we need to have schedule_tail() do the 
release_task(), otherwise we'd release it too early while the task 
structure (and the stack) are both still in use.

You owe me a patch.

			Linus

---

>  [<c01219fd>] release_task+0x17d/0x200
>  [<c011e70f>] mmput+0x1f/0xc0
>  [<c0122cad>] do_exit+0x31d/0x3b0

>  [<c010a594>] common_interrupt+0x18/0x20
>  [<c010a691>] error_code+0x2d/0x38
>  [<c011b881>] schedule+0x3a1/0x3d0
>  [<c01219fd>] release_task+0x17d/0x200
>  [<c011e70f>] mmput+0x1f/0xc0
>  [<c0122cad>] do_exit+0x31d/0x3b0

>  [<c010bc28>] handle_IRQ_event+0x38/0x60
>  [<c010bf6b>] do_IRQ+0x14b/0x1e0
>  [<c010a594>] common_interrupt+0x18/0x20
>  [<c010a691>] error_code+0x2d/0x38
>  [<c011b881>] schedule+0x3a1/0x3d0
>  [<c01219fd>] release_task+0x17d/0x200
>  [<c011e70f>] mmput+0x1f/0xc0
>  [<c0122cad>] do_exit+0x31d/0x3b0

>  [<c010bf6b>] do_IRQ+0x14b/0x1e0
>  [<c010a594>] common_interrupt+0x18/0x20
>  [<c010a691>] error_code+0x2d/0x38
>  [<c011b881>] schedule+0x3a1/0x3d0
>  [<c01219fd>] release_task+0x17d/0x200
>  [<c011e70f>] mmput+0x1f/0xc0
>  [<c0122cad>] do_exit+0x31d/0x3b0


>  [<c010bf6b>] do_IRQ+0x14b/0x1e0
>  [<c010a594>] common_interrupt+0x18/0x20
>  [<c010a691>] error_code+0x2d/0x38
>  [<c011b881>] schedule+0x3a1/0x3d0
>  [<c01219fd>] release_task+0x17d/0x200
>  [<c011e70f>] mmput+0x1f/0xc0
>  [<c0122cad>] do_exit+0x31d/0x3b0

>  [<c011e06c>] __put_task_struct+0x7c/0x90
>  [<c0122cad>] do_exit+0x31d/0x3b0

>  [<c010bc28>] handle_IRQ_event+0x38/0x60
>  [<c010bf6b>] do_IRQ+0x14b/0x1e0
>  [<c010a594>] common_interrupt+0x18/0x20
>  [<c010a691>] error_code+0x2d/0x38
>  [<c011b881>] schedule+0x3a1/0x3d0
>  [<c01219fd>] release_task+0x17d/0x200
>  [<c011e70f>] mmput+0x1f/0xc0
>  [<c0122cad>] do_exit+0x31d/0x3b0

>  [<c010bc28>] handle_IRQ_event+0x38/0x60
>  [<c010bf6b>] do_IRQ+0x14b/0x1e0
>  [<c010a594>] common_interrupt+0x18/0x20
>  [<c010a691>] error_code+0x2d/0x38
>  [<c011b881>] schedule+0x3a1/0x3d0
>  [<c01219fd>] release_task+0x17d/0x200
>  [<c011e70f>] mmput+0x1f/0xc0
>  [<c0122cad>] do_exit+0x31d/0x3b0



