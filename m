Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265208AbUE0UlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265208AbUE0UlP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 16:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUE0UlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 16:41:15 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:28252 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265208AbUE0UlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 16:41:12 -0400
Subject: Re: Badness in local_bh_enable at kernel/softirq.c:122
From: Paul Fulghum <paulkf@microgate.com>
To: Jurjen Oskam <jurjen@stupendous.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040527174509.GA1654@quadpro.stupendous.org>
References: <20040527174509.GA1654@quadpro.stupendous.org>
Content-Type: text/plain
Organization: 
Message-Id: <1085690466.2434.16.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 27 May 2004 15:41:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-27 at 12:45, Jurjen Oskam wrote:
> Hi there,
> 
> I'm using pptp-linux to connect to my ADSL-provider. I've been doing this
> for several years now, without significant problems. A week ago, I
> upgraded
> 
> May 27 11:35:41 calvin kernel: Badness in local_bh_enable at kernel/softirq.c:122
> May 27 11:35:41 calvin kernel: Call Trace:
> May 27 11:35:41 calvin kernel:  [<c011ac00>] local_bh_enable+0x60/0x80
> May 27 11:35:41 calvin kernel:  [<c4cc2b54>] ppp_sync_push+0x54/0x140 [ppp_synctty]
> May 27 11:35:41 calvin kernel:  [<c4cc25a5>] ppp_sync_wakeup+0x25/0x60 [ppp_synctty]
> May 27 11:35:41 calvin kernel:  [<c01f20e7>] pty_unthrottle+0x47/0x60
> May 27 11:35:41 calvin kernel:  [<c01eefb1>] check_unthrottle+0x31/0x40
> May 27 11:35:41 calvin kernel:  [<c01ef02b>] n_tty_flush_buffer+0xb/0x60
> May 27 11:35:41 calvin kernel:  [<c01f2488>] pty_flush_buffer+0x48/0x60
> May 27 11:35:41 calvin kernel:  [<c01ec116>] do_tty_hangup+0x2d6/0x340

I've been looking at this and the culprit is in
drivers/char/tty_io.c, function do_tty_hangup():

	lock_kernel();

        ...

	/* FIXME! What are the locking issues here? This may me overdoing things..
	* this question is especially important now that we've removed the irqlock. */
	{
		unsigned long flags;

		local_irq_save(flags); // FIXME: is this safe?
		if (tty->ldisc.flush_buffer)
			tty->ldisc.flush_buffer(tty);
		if (tty->driver->flush_buffer)
			tty->driver->flush_buffer(tty);
		if ((test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) &&
		    tty->ldisc.write_wakeup)
			(tty->ldisc.write_wakeup)(tty);
		local_irq_restore(flags); // FIXME: is this safe?
	}

        ...

	unlock_kernel();

I do not see that disabling the local CPU interrupts for the
flush_buffer and write_wakeup calls is needed. In fact
doing so provokes the warning message in softirq.c
when write_wakeup is called.

All of these functions are also invoked by ioctl calls
which do not disable the local IRQ (ioctl is protected
by lock_kernel/unlock_kernel just like do_tty_hangup).

So the flush_buffer/write_wakeup calls do *not*
need IRQs disabled (in fact need them enabled to
avoid the warning as is the case on ioctl).

Since the IRQ is restored immediately after these 3
calls, it does not seem to serve a purpose for the calling
function either.

The solution, in my opinion, is to remove the IRQ
disabling surrounding these 3 functions in do_tty_hangup.


-- 
Paul Fulghum
paulkf@microgate.com

