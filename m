Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269176AbRHLN32>; Sun, 12 Aug 2001 09:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269179AbRHLN3S>; Sun, 12 Aug 2001 09:29:18 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:9811 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S269176AbRHLN3I>; Sun, 12 Aug 2001 09:29:08 -0400
Date: Sun, 12 Aug 2001 14:16:55 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: alloc_area_pte: page already exists
In-Reply-To: <20010809190434.P4895@athlon.random>
Message-ID: <Pine.LNX.3.96.1010812140743.1163B-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Andrea Arcangeli wrote:
> > IOW I want the irq to "trigger" the freeing of the iovecs but it's ok if
> > it's done later, as long as it's done without any races :)
> 
> Your design looks suspect, but you can do that safely (at least as far
> as vfree is concerned) with keventd's schedule_task().

I looked into this and I can't figure out how to actually use this. It
seems as if schedule_task doesn't take a copy of the incoming tq_struct
but actually uses it as-is - and this poses a problem of creating the
tq_struct in the first place.

You can't kmalloc it, because then the task called by the tq_struct will
need to kfree itself and I'm pretty sure the kernel won't enjoy that.

You can't have it on the stack because the frame will exit long before
it's used.

You can't have it static because you might need to enqueue more than one
(with different "arguments" possibly)

In fact, looking at how it's used in the kernel today highlights the
problem: drivers/char/tty_io.c:

1866  * The tq handling here is a little racy - tty->SAK_tq may already be
queued.
1867  * But there's no mechanism to fix that without futzing with
tqueue_lock.
1868  * Fortunately we don't need to worry, because if ->SAK_tq is already
queued,
1869  * the values which we write to it will be identical to the values
which it
1870  * already has. --akpm
1871  */
1872 void do_SAK(struct tty_struct *tty)
1873 {
1874         PREPARE_TQUEUE(&tty->SAK_tq, __do_SAK, tty);
1875         schedule_task(&tty->SAK_tq);
1876 }

I'm obviously in a loosing situation here :(

/Bjorn

