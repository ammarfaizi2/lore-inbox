Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbTDHKQt (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 06:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbTDHKQt (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 06:16:49 -0400
Received: from [12.47.58.221] ([12.47.58.221]:14980 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261290AbTDHKQs (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 06:16:48 -0400
Date: Tue, 8 Apr 2003 03:28:32 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Marco d'Itri" <md@Linux.IT>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.67] BUG at kernel/softirq.c:105
Message-Id: <20030408032832.6d7732be.akpm@digeo.com>
In-Reply-To: <20030408101332.GC1738@wonderland.linux.it>
References: <20030408101332.GC1738@wonderland.linux.it>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2003 10:28:18.0848 (UTC) FILETIME=[9280B200:01C2FDB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marco d'Itri" <md@Linux.IT> wrote:
>
> I think this happened after killing pppd, but I'm not 100% sure.

It is due to this stuff, in drivers/char/tty_io.c:

	/* FIXME! What are the locking issues here? This may me overdoing things..
	* this question is especially important now that we've removed the irqlock. */
	{
		unsigned long flags;

		local_irq_save(flags); // FIXME: is this safe?
		if (tty->ldisc.flush_buffer)
			tty->ldisc.flush_buffer(tty);
		if (tty->driver.flush_buffer)
			tty->driver.flush_buffer(tty);
		if ((test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) &&
		    tty->ldisc.write_wakeup)
			(tty->ldisc.write_wakeup)(tty);
		local_irq_restore(flags); // FIXME: is this safe?
	}

We end up calling local_bh_enable(), which goes BUG if local interrupts are
disabled.  It goes BUG because local_bh_enable() will enable interrupts
unconditionally, therefore calling it with interrupts disabled is deadlocky
and wrong.

So our hand is forced.  We have to fix that crap up.  I wonder how?


