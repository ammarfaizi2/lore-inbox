Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289069AbSAGBkF>; Sun, 6 Jan 2002 20:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289071AbSAGBjz>; Sun, 6 Jan 2002 20:39:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25425 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289069AbSAGBjm>; Sun, 6 Jan 2002 20:39:42 -0500
Date: Mon, 7 Jan 2002 02:38:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Jens Axboe <axboe@suse.de>, Matthias Hanisch <mjh@vr-web.de>,
        Mikael Pettersson <mikpe@csd.uu.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.2 scheduler code for 2.4.18-pre1 ( was 2.5.2-pre performance degradation on an old 486 )
Message-ID: <20020107023854.F1561@athlon.random>
In-Reply-To: <20020106112129.D8673@suse.de> <Pine.LNX.4.40.0201061554410.933-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.40.0201061554410.933-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Sun, Jan 06, 2002 at 03:59:05PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 03:59:05PM -0800, Davide Libenzi wrote:
> On Sun, 6 Jan 2002, Jens Axboe wrote:
> 
> > On Sat, Jan 05 2002, Davide Libenzi wrote:
> > > > > (*) 100MHz 486DX4, 28MB ram, no L2 cache, two old and slow IDE disks,
> > > > > small custom no-nonsense RedHat 7.2, kernels compiled with gcc 2.95.3.
> > > >
> > > > Is this ISA (maybe it has something to do with ISA bouncing)? Mine is:
> > > >
> > > > 486 DX/2 ISA, Adaptec 1542, two slow scsi disks and a self-made
> > > > slackware-based system.
> > > >
> > > > Can you also backout the scheduler changes to verify this? I have a
> > > > backout patch for 2.5.2-pre6, if you don't want to do this for yourself.
> > >
> > > There should be some part of the kernel that assume a certain scheduler
> > > behavior. There was a guy that reported a bad  hdparm  performance and i
> > > tried it. By running  hdparm -t  my system has a context switch of 20-30
> > > and an irq load of about 100-110.
> > > The scheduler itself, even if you code it in visual basic, cannot make
> > > this with such loads.
> > > Did you try to profile the kernel ?
> >
> > Davide,
> >
> > If this is caused by ISA bounce problems, then you should be able to
> > reproduce by doing something ala
> >
> > [ drivers/ide/ide-dma.c ]
> >
> > ide_toggle_bounce()
> > {
> > 	...
> >
> > +	addr = BLK_BOUNCE_ISA;
> > 	blk_queue_bounce_limit(&drive->queue, addr);
> > }
> >
> > pseudo-diff, just add the addr = line. Now compare performance with and
> > without your scheduler changes.
> 
> I fail to understand where the scheduler code can influence this.
> There's basically nothing inside blk_queue_bounce_limit()
> I made this patch for Andrea and it's the scheduler code for 2.4.18-pre1
> Could someone give it a try on old 486s

yes please (feel free to CC me on the answers), I'd really like to
reduce the scheduler O(N) overhead to the number of the running tasks,
rather than doing the recalculate all over the processes in the machine.
O(1) scheduler would be even better of course, but the below would
ensure not to hurt the 1 task running case, and it's way simpler to
check for correctness (so it's easier to include it as a start).

Andrea
