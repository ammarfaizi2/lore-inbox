Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSLBKKp>; Mon, 2 Dec 2002 05:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbSLBKKp>; Mon, 2 Dec 2002 05:10:45 -0500
Received: from ns.javad.ru ([62.105.138.7]:9222 "EHLO ns.javad.ru")
	by vger.kernel.org with ESMTP id <S262130AbSLBKKo>;
	Mon, 2 Dec 2002 05:10:44 -0500
To: linux-kernel@vger.kernel.org
Subject: Q: problems interfacing with tty ldisc using flipbufs.
X-attribution: osv
From: Sergei Organov <osv@javad.ru>
Date: 02 Dec 2002 13:18:09 +0300
Message-ID: <87ptskafmm.fsf@osv.javad.ru>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm rather new to the Linux kernel drivers and I need some help from you.

I'm trying to design kernel module that reads data from a USB device and
transfers them to the tty ldisc. I'm interested only in the n_tty line
discipline. I have rather large internal buffer to which data from the device
are stored from the IRQ handler. The question is how to transfer the data from
this buffer to the ldisc reliably (i.e., without data loss). Currently to
transfer data from the internal buffer to the line discipline I'm scheduling a
tasklet. Assuming the `tty->low_latency' field is set to 1, the following two
problems may (and do in fact) occur when I attempt to call
`tty_flip_buffer_push':

1. Let free space in the ldisc input buffer be `F' bytes and number of bytes
   in the flipbuf be `N'. Suppose F > TTY_THRESHOLD_THROTTLE and N > F. In
   this case the buffer flips but (N - F) bytes are silently lost. To prevent
   this unfortunate situation I'm forced to never put more than
   TTY_THRESHOLD_THROTTLE bytes into flipbuf. Not only this is inefficient,
   but also error-prone as TTY_THRESHOLD_THROTTLE is private to the `n_tty.c'
   file so I need to make similar definition in my own C file. Is there a
   better method for passing data to ldisc without loss? Wouldn't it be a
   good idea to change TTY_THRESHOLD_THROTTLE to be at least as large as
   TTY_FLIPBUF_SIZE?

2. If TTY_DONT_FLIP flag is set, the buffer doesn't flip. Instead, flipping is
   queued to the tq_timer and I don't have more space to copy data to. As far
   as I understand, the only option I have at this point is to queue my own
   procedure to the tq_timer that will eventually retry to pass data through
   the flipbufs, right? If so, I'll end up with the same code running from 3
   places: 1. tasklet 2. tq_timer queue, and 3. `unthrottle' method of the
   driver. I don't know why TTY_DONT_FLIP is at all necessary, but all this
   seems rather over-complicated to me for the task of transferring data from
   one buffer to another. Is there a better way (from my side) to deal with
   it? Maybe I should better get rid of the tasklet and always queue my
   copy-to-tty routine to the tq_timer instead?


Thanks for advance for any hints.

BR,
Sergei.

