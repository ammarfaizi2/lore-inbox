Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266203AbSLCJ0B>; Tue, 3 Dec 2002 04:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266218AbSLCJ0A>; Tue, 3 Dec 2002 04:26:00 -0500
Received: from mta2n.bluewin.ch ([195.186.4.220]:34190 "EHLO mta2n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S266203AbSLCJZ7>;
	Tue, 3 Dec 2002 04:25:59 -0500
Date: Tue, 3 Dec 2002 10:33:23 +0100
From: Martin Buck <mb-kernel0212@gromit.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Race condition in tty_flip_buffer_push/flush_to_ldisc?
Message-ID: <20021203093323.GA25957@gromit.at.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I've stumbled over a race condition in drivers/char/tty_io.c,
tty_flip_buffer_push()/flush_to_ldisc(). I noticed it in 2.4.19, but the
code in 2.5.49 looks similar.

Suppose I'm running a serial port with low_latency enabled. The low-level
serial interrupt handler will call tty_flip_buffer_push() which will
immediately call flush_to_ldisc() due to low_latency being set. In
flush_to_ldisc(), if the TTY_DONT_FLIP bit is set, it will add itself to
the timer task queue and return. When the task queue gets processed,
processing might get interrupted by another serial interrupt or vice versa,
resulting in 2 concurrent calls to flush_to_ldisc(). This time, the
TTY_DONT_FLIP bit probably isn't set, so they both will try to process the
same flip buffer.

Note that reading the current flip buffer pointers isn't protected by
cli(), only modifying them is. And even if it were, we could end up calling
tty->ldisc.receive_buf() twice for the same tty which probably isn't safe
either.

Any ideas on how to fix this?

And before you ask - yes, I do need low_latency. Not because of the low
latecy, but because I'm trying to use 921600 bps. At this speed, a 512
Bytes flip buffer gets filled in 5.5ms while timer task queue flip buffer
processing only flushes it every 10ms, resulting in slighly more characters
lost than I can accept :-)

Thanks,
Martin

