Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129189AbRBDEAy>; Sat, 3 Feb 2001 23:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129202AbRBDEAf>; Sat, 3 Feb 2001 23:00:35 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:39626 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129189AbRBDEAa>; Sat, 3 Feb 2001 23:00:30 -0500
Message-ID: <3A7CD3C9.21CC5505@Home.net>
Date: Sat, 03 Feb 2001 23:00:09 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PS hanging in 2.4.1 - HAPPENING NOW!!!
In-Reply-To: <Pine.LNX.4.10.10102031849210.9705-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding now.. I just applied 2.4.1-ac2 and now i'll add this code snipet to the source. It might take 4 days or so for the bug to show itself. At least, unless it triggers eariler (?)

Restarting...

Shawn.


Linus Torvalds wrote:

> On Sat, 3 Feb 2001, Shawn.Starr@Home.net wrote:
> >
> >Feb  3 17:57:08 coredump kernel: gnomeicu  S 0000CD17     0  9338      1        (NOTLB)    9340  9332
> >Feb  3 17:57:08 coredump kernel: Call Trace: [search_by_key+203/3232] [search_for_position_by_key+170/916] [make_cpu_key+57/64] [_get_block_create_0+136/1072] [_get_block_create_0+162/1072] [remove_wait_queue+40/48] [__wait_on_buffer+128/140]
> >Feb  3 17:57:08 coredump kernel:        [<f0000000>] [reiserfs_get_block+158/3408] [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [make_cpu_key+57/64] [kmem_cache_alloc+75/116] [get_unused_buffer_head+52/144] [create_buffers+96/444]
> >Feb  3 17:57:08 coredump kernel:        [block_read_full_page+246/552] [add_to_page_cache_unique+202/212] [reiserfs_readpage+15/20] [reiserfs_get_block+0/3408] [read_cluster_nonblocking+258/324] [filemap_nopage+332/1032] [do_no_page+77/192] [handle_mm_fault+232/340]
> >Feb  3 17:57:08 coredump kernel:        [do_page_fault+312/1020] [do_page_fault+0/1020] [start_request+388/508] [intlat_local_irq_disable+16/20] [ide_do_request+685/752] [schedule+639/964] [remove_wait_queue+40/48] [error_code+52/64]
> >Feb  3 17:57:09 coredump kernel:        [__generic_copy_from_user+52/60] [opost_block+67/384] [handle_mm_fault+232/340] [add_wait_queue+59/68] [write_chan+365/516] [tty_write+341/448] [write_chan+0/516] [sys_write+143/196]
> >Feb  3 17:57:09 coredump kernel:        [system_call+62/80]
>
> Ok, the above seems to be the culprit here.
>
> Note how the thing is in TASK_INTERRUPTIBLE (S) sleep somewhere in the
> reiserfs code..
>
> Debugging this is slightly harder than I'd like, because the "call trace"
> is really not a trace, but actually just a dump of the stack of everything
> that looks like a kernel address. And a lot of it is crap - stuff left
> over by previous calls that hasn't gotten overwritten and is visible
> because some function has a large stack footprint (lots of local variables
> that end up not being very used and let things show through).
>
> Anyway, what I _think_ is the cleaned-up stacktrace is
>
>         [reiserfs_get_block+158/3408]
>         [reiserfs_readpage+15/20]
>         [read_cluster_nonblocking+258/324]
>         [filemap_nopage+332/1032]
>         [do_no_page+77/192]
>         [handle_mm_fault+232/340]
>         [do_page_fault+312/1020]
>         [error_code+52/64]
>         [__generic_copy_from_user+52/60]
>         [opost_block+67/384]
>         [handle_mm_fault+232/340]
>         [add_wait_queue+59/68]
>         [write_chan+365/516]
>         [tty_write+341/448]
>         [write_chan+0/516]
>         [sys_write+143/196]
>         [system_call+62/80]
>
> and what is interesting is that you got a page fault while you were
> copying stuff in to the tty layer. Which happens with TASK_INTERRUPTIBLE
> sleep. Now, the page fault code never clears that, so we enter reiserfs
> still "sleeping", and reiserfs will do a
>
>         if (need_resched(current))
>                 schedule();
>
> which won't do what reiserfs _wants_ it to do at all. Because if
> task->state is TASK_INTERRUPTIBLE, the above will go to sleep, not just
> cause a nice reschedule. And we'll be sleeping with the task MM semaphore
> held - only to wake up if somebody were to signal us or something.
>
> If you can re-create this hang, could you please try to add this single
> line to the top of "handle_mm_fault()" in mm/memory.c (after the variable
> declarations, of course):
>
>         current->state = TASK_RUNNING;
>
> which just means that if we get a page fault while we're half asleep, it
> will be safe to do a schedule() without explicitly setting the process
> running again.
>
>                 Linus
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
