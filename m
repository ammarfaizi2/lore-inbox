Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbUBPN1X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbUBPN1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:27:23 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:51897 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265515AbUBPN1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:27:06 -0500
Subject: Re: kthread vs. dm-daemon (was: Oopsing cryptoapi (or loop
	device?) on 2.6.*)
From: Christophe Saout <christophe@saout.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Joe Thornber <thornber@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040216034250.EDCC82C053@lists.samba.org>
References: <20040216034250.EDCC82C053@lists.samba.org>
Content-Type: text/plain
Message-Id: <1076938020.7350.18.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 14:27:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 16.02.2004 schrieb Rusty Russell um 04:02:

> Yes, looks like dm-daemon is a workqueue.

The only small difference is that you don't need a work_struct and the
work function is only called once, if there is work. The work function
has process all the work that has been queued.

> > There seems to beg a small race conditition that can appear when using
> > only wake_up for notifies so dm-daemon uses an additional atomic_t
> > variable to make sure nothing gets missed. Just see the function
> > ``daemon'' in dm-daemon.c.
> 
> This is why using a workqueue, rather than having everyone invent
> their own methods, is a good idea.

The only downside on using a workqueue here is that you have to put the
work_struct somewhere. If you have just bio structures floating around
this means you need an additional mempool, etc... In my case I already
had a structure that I could use (I was using bio->bi_next
concatenation), it just means that I can't do per-clone-queueing only
per-original-bio-queueing but in my case this doesn't make a difference.

> > It seems to me that this functionality could perhaps be somehow added to
> > kthread without changing it too much... ?
> 
> You could build it on top of kthread probably.

dm-daemon? That would make it a really stupid 10-line-wrapper.

I moved my dm-crypt target from dm-daemon to kthread and used
set_current_state/schedule/wakeup_process and the
bio->bi_next-concatenation. Fine.

Switching to kthread+semaphores and removing only a single bio from the
queue at a time made the code simpler (but adds a very small overhead
because of the spinlock every time a bio gets popped).

And finally a workqueue instead of kthread made the code even more
simple.

> You could also change
> workqueues to resize dynamically, rather than be one per cpu (but
> that's some fairly tricky code).

I think that's overkill. The threads don't waste too much resources. And
things would get complicated if you want to make the work function run
on the same cpu but don't have enough threads for this. You would have
to always change the affinity...?

Another question:

The workqueue code currently always executes the work function on the
same cpu. Would it be a good idea to add the possibility to make it run
on the next free cpu?

Assuming dm-crypt gets a lot of reads returned and has to decrypt them.
Decrypting the buffers on all CPUs in parallel would probably be faster.
This was done in order to avoid cache trashing?


