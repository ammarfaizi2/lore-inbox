Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbUCRT3q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUCRT3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:29:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:26087 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262899AbUCRT3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:29:42 -0500
Date: Thu, 18 Mar 2004 11:29:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: andrea@suse.de, mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-Id: <20040318112941.0221c6ac.akpm@osdl.org>
In-Reply-To: <s5hbrmuc6ed.wl@alsa2.suse.de>
References: <40591EC1.1060204@geizhals.at>
	<20040318060358.GC29530@dualathlon.random>
	<s5hlllycgz3.wl@alsa2.suse.de>
	<20040318110159.321754d8.akpm@osdl.org>
	<s5hbrmuc6ed.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> > > --- linux-2.6.4-8/fs/jbd/commit.c-dist	2004-03-16 23:00:40.000000000 +0100
> > > +++ linux-2.6.4-8/fs/jbd/commit.c	2004-03-18 02:42:41.043448624 +0100
> > > @@ -290,6 +290,9 @@ write_out_data_locked:
> > >  			commit_transaction->t_sync_datalist = jh;
> > >  			break;
> > >  		}
> > > +
> > > +		if (need_resched())
> > > +			break;
> > >  	} while (jh != last_jh);
> > >  
> > >  	if (bufs || need_resched()) {
> > 
> > This one I need to think about.  Perhaps we can remove the yield point a
> > few lines above.
> 
> yes, i'm afraid that it's also overkill to check this at every time.
> perhaps we can optimize it a bit better.  the fact that it imporives
> the latency means that there are so many locked buffers or non-dirty
> buffers in the list?

yes, lots of clean buffers.

> > One needs to be really careful with the lock-dropping trick - there are
> > weird situations in which the kernel fails to make any forward progress. 
> > I've been meaning to do another round of latency tuneups for ages, so I'll
> > check this one out, thanks.
> > 
> > There's also the SMP problem: this CPU could be spinning on a lock with
> > need_resched() true, but the other CPU is hanging on the lock for ages
> > because its need_resched() is false.
> 
> yep, i see a similar problem also in reiserfs's do_journal_end().
> it's in lock_kernel().

I have a scheduling point in journal_end() in 2.4.  But I added bugs to
reiserfs a couple of times doing this - it's pretty delicate.  Beat up on
Chris ;)

> > Last time I looked the worst-case latency is in fact over in the ext3
> > checkpoint code.  It's under spinlock and tricky to fix.
> 
> BTW, i had the worst latency in sis900's timer handler.
> it takes 3ms, and hard to fix, too :-<

networking in general can cause problems, as can the random driver, which I
hacked rather flakily in 2.4.

davem fixed the tcp_minisock reaping in 2.6, which helps.
