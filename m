Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWGGNLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWGGNLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 09:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWGGNLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 09:11:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42802 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932082AbWGGNLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 09:11:47 -0400
Date: Fri, 7 Jul 2006 15:14:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Kerrisk <michael.kerrisk@gmx.net>
Cc: mtk-manpages@gmx.net, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: splice/tee bugs?
Message-ID: <20060707131403.GY4188@suse.de>
References: <20060707070703.165520@gmx.net> <20060707040749.97f8c1fc.akpm@osdl.org> <20060707114235.243260@gmx.net> <20060707120333.GR4188@suse.de> <20060707122850.GU4188@suse.de> <20060707123110.64140@gmx.net> <20060707124105.GW4188@suse.de> <20060707131247.GX4188@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707131247.GX4188@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07 2006, Jens Axboe wrote:
> On Fri, Jul 07 2006, Jens Axboe wrote:
> > On Fri, Jul 07 2006, Michael Kerrisk wrote:
> > > Jens Axboe wrote:
> > > 
> > > > > > > >    In this case I can't kill it with ^C or ^\.  This is a 
> > > > > > > >    hard-to-reproduce behaviour on my (x86) system, but I have 
> > > > > > > >    seen it several times by now.
> > > > > > > 
> > > > > > > aka local DoS.  Please capture sysrq-T output next time.
> > > [...]
> > > > > I'll see about reproducing locally.
> > > > 
> > > > With your modified ktee, I can reproduce it here. Here's the ktee and wc
> > > > output:
> > > 
> > > Good; thanks.
> > > 
> > > By the way, what about points a) and b) in my original mail
> > > in this thread?
> > 
> > I'll look at them after this.
> 
> I _think_ it was due to a bad check for ipipe->nrbufs, can you see if
> this works for you? It also changes some other things:
> 
> - instead of returning EAGAIN on nothing tee'd because of the possible
>   deadlock problem, release/regrab the ipipe/opipe mutex if we have to.
>   This makes sys_tee block for that case if SPLICE_F_NONBLOCK isn't set.
> 
> - Check that ipipe and opipe differ to avoid possible deadlock if user
>   gives the same pipe.
> 
> You can still see 0 results without SPLICE_F_NONBLOCK set, if we have no
> writers for instance. This is expected, not much we can do about that as
> we cannot block for that condition.

BTW, I'm seeing an odd lockdep message on the first invocation of the
test:

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
ktee2/6208 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<c03922c6>] mutex_lock+0x1c/0x1f

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<c03922c6>] mutex_lock+0x1c/0x1f

other info that might help us debug this:
1 lock held by ktee2/6208:
 #0:  (&inode->i_mutex){--..}, at: [<c03922c6>] mutex_lock+0x1c/0x1f

stack backtrace:
 [<c01041ab>] show_trace+0x12/0x14
 [<c0104874>] dump_stack+0x19/0x1b
 [<c01399b6>] __lock_acquire+0x645/0xc77
 [<c013a32a>] lock_acquire+0x5d/0x79
 [<c0392082>] __mutex_lock_slowpath+0x6e/0x296
 [<c03922c6>] mutex_lock+0x1c/0x1f
 [<c018d37f>] sys_tee+0x292/0x4a4
 [<c0103075>] sysenter_past_esp+0x56/0x8d

I cannot see where this could be happening, Ingo is this valid?

-- 
Jens Axboe

