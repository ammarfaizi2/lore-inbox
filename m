Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRBLJtl>; Mon, 12 Feb 2001 04:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129230AbRBLJtc>; Mon, 12 Feb 2001 04:49:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62224 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129115AbRBLJtY>; Mon, 12 Feb 2001 04:49:24 -0500
Subject: Re: [OT] Major Clock Drift
To: andrewm@uow.edu.au (Andrew Morton)
Date: Mon, 12 Feb 2001 09:48:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pavel@suse.cz (Pavel Machek),
        teastep@seattlefirewall.dyndns.org (Tom Eastep),
        fd0man@crosswinds.net (Michael B. Trausch),
        jbm@joshisanerd.com (Josh Myer), linux-kernel@vger.kernel.org
In-Reply-To: <3A871252.45974FFF@uow.edu.au> from "Andrew Morton" at Feb 11, 2001 10:29:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SFbG-0006WR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Why are interrupts being disabled for vesafb scrolling anyway ?
> 
> Console writes happen under spin_lock_irq(console_lock).
> 
> The only reason for this which I can see: the kernel
> can call printk() from interrupt context.

We certainly need to be able to call printk from interrupt context so that
bit is in itself reasonable, but not the cost.

Suppose vesafb did something like this, dropping the printk lock

	if(test_and_set_bit(0, &vesafb_lock))
	{
		if(in_interrupt())
		{
			// remember which bit of the dmesg ring to queue
			queued_writes=1;
			return;
		}
	}
	/* for the re-entry case this will block */
	down(&vesafb_mutex);
again:
	do the usual stuff 
	if(queued_writes)
	{
		dequeue_write_buffer();
		goto again;
	}
	up(&vesafb_mutex);
	clear_bit(0, &vesafb_lock);


	
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
