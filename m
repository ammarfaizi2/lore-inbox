Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314002AbSDQBWz>; Tue, 16 Apr 2002 21:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314003AbSDQBWy>; Tue, 16 Apr 2002 21:22:54 -0400
Received: from ns1.crl.go.jp ([133.243.3.1]:57574 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S314002AbSDQBWw>;
	Tue, 16 Apr 2002 21:22:52 -0400
Date: Wed, 17 Apr 2002 10:22:21 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
X-X-Sender: tomh@holly.crl.go.jp
To: Andrea Arcangeli <andrea@suse.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5
In-Reply-To: <20020416164919.D29747@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0204170953070.549-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Andrea Arcangeli wrote:

> there are no mm diffs between pre1 and pre2. The first mm changes are in
> pre5.

I was referring to the changes in mm/, such as mm/filemap.c,
mm/mmap.c, mm/page_alloc.c, etc., all of which were rather extensive
in -pre2, and contained some 64 bit specific stuff.

As I mentioned to Marcelo earlier, I have been able to get ~5 sec
mouse freezes on my Alpha.  Right now I'm running -pre7, and I just
reproduced it.  The only way I know of to do it is run a certain
graphics program that's work-related, plot something, switch screens
(in the 'I have a 4x4 virtual desktop' sense), run a big filter job
that reads about 200-300 meg in, filters it, and writes it back out
(alternatively, I can scroll through a directory full of images, so
maybe it only has to have a few hundred meg read in), then switch
back to the graphics screen and hit "refresh".  It does not work every
time, but I certainly notice it when it happens.  Note that after I've
done it once, it's much harder to reproduce.  Of course, that maybe
depends on the phase of the moon, because I reproduced it twice in a
row this morning, with profiling data the second time.  Here's the
list of routines that got ticks (as reported by readprofile) during
the ~3 sec freeze I just caused:

1 alloc_skb
1 alpha_switch_to
1 cached_lookup
1 collect_sigign_sigcatch
1 copy_page
1 del_timer
1 dentry_open
1 do_no_page
1 do_page_fault
1 do_switch_stack
1 fput
1 generic_file_read
1 generic_file_write
1 get_gendisk
1 iput
1 link_path_walk
1 locks_remove_flock
1 poll_freewait
1 read_aux
1 remove_wait_queue
1 restore_all
1 schedule
1 scsi_dispatch_cmd
1 session_of_pgrp
1 sock_alloc_send_pskb
1 sys_close
1 sys_ioctl
1 sys_select
1 undo_switch_stack
1 unix_poll
1 unix_stream_sendmsg
1 vsprintf
2 clear_page
2 generic_file_readahead
2 number
2 sock_poll
2 tcp_poll
2 update_atime
3 __free_pages
3 add_wait_queue
3 kfree
3 vsnprintf
4 entSys
4 fget
5 do_select
5 handle_IRQ_event
7 __copy_user
7 sys_read
8 __divqu
10 __remqu
10 do_generic_file_read
18 entInt
19 keyboard_interrupt

I've done this quite a few times now, and add_wait_queue &
__free_pages are always there.  (Well, and keyboard_interrupt, but
that's not it.)  Other things are more random, but it's hard to judge
precisely (I'm not sure how the profiling works but I assume short
routines can be easily missed).

This is an AlphaPC 264DP 666 MHz (uniprocessor version, non-SMP
kernel).  1GB RAM.  AHA-2940U/UW SCSI on the PCI bus along
with a Permedia 2 graphics card.

