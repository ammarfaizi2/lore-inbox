Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933299AbWKSVJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933299AbWKSVJT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933316AbWKSVJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:09:18 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:3293 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S933299AbWKSVJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:09:17 -0500
Date: Sun, 19 Nov 2006 16:09:17 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Jens Axboe <jens.axboe@oracle.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, <manfred@colorfullife.com>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061119205516.GA117@oleg>
Message-ID: <Pine.LNX.4.44L0.0611191606580.20262-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2006, Oleg Nesterov wrote:

> > What happens if synchronize_xxx manages to execute inbetween 
> > xxx_read_lock's
> > 
> >  		idx = sp->completed & 0x1;
> >  		atomic_inc(sp->ctr + idx);
> > 
> > statements?
> 
> Oops. I forgot about explicit mb() before sp->completed++ in synchronize_xxx().
> 
> So synchronize_xxx() should do
> 
> 	smp_mb();
> 	idx = sp->completed++ & 0x1;
> 
> 	for (;;) { ... }
> 
> >               You see, there's no way around using synchronize_sched().
> 
> With this change I think we are safe.
> 
> If synchronize_xxx() increments ->completed in between, the caller of
> xxx_read_lock() will see all memory ops (started before synchronize_xxx())
> completed. It is ok that synchronize_xxx() returns immediately.

Yes, the reader will see a consistent picture, but it will have 
incremented the wrong element of sp->ctr[].  What happens if another 
synchronize_xxx() occurs while the reader is still running?

Alan

