Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318188AbSIBAph>; Sun, 1 Sep 2002 20:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318190AbSIBAph>; Sun, 1 Sep 2002 20:45:37 -0400
Received: from dsl-213-023-021-067.arcor-ip.net ([213.23.21.67]:26243 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318188AbSIBApg>;
	Sun, 1 Sep 2002 20:45:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [RFC] [PATCH] Include LRU in page count
Date: Mon, 2 Sep 2002 02:30:10 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
References: <3D644C70.6D100EA5@zip.com.au> <E17leDK-0004dA-00@starship> <3D72AE2C.F1806BDD@zip.com.au>
In-Reply-To: <3D72AE2C.F1806BDD@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lf6Y-0004dV-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 September 2002 02:17, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > On Monday 02 September 2002 01:08, Andrew Morton wrote:
> > > Daniel Phillips wrote:
> > > > Note that I changed the spin_lock in page_cache_release to a trylock, maybe
> > > > it's worth checking out the effect on contention.  With a little head
> > > > scratching we might be able to get rid of the spin_lock in lru_cache_add as
> > > > well.  That leaves (I think) just the two big scan loops.  I've always felt
> > > > it's silly to run more than one of either at the same time anyway.
> > >
> > > No way.  Take a look at http://samba.org/~anton/linux/2.5.30/
> > >
> > > That's 8-way power4, the workload is "dd from 7 disks
> > > dd if=/dev/sd* of=/dev/null bs=1024k".
> > >
> > > The CPU load in this situation was dominated by the VM.  The LRU list and page
> > > reclaim.  Spending more CPU in lru_cache_add() than in copy_to_user() is
> > > pretty gross.
> > 
> > Are we looking at the same thing?  The cpu load there is dominated by cpu_idle,
> > 89%.
> 
> Apart from that, dummy ;)  The absolute numbers are proportional
> to IO bandwidth.  And 7/8ths of a scsi disk per CPU isn't much.

OK, fine, my point here is that there's no real excuse for contention on the
lru lock.  Without departing radically from the current design the most you
can possibly spend on page reclaiming is 100% of one cpu, and we ought to
simply aim at getting the most bang for the buck out of that one cpu.  It
follows that we want only one copy of shrink_cache or refill_inactive running
at a time, otherwise we're tossing away cycles spinning on locks and getting
nothing back.

If lru_cache_add is costly then we can kill both the lock contention and the
cacheline pingponging by feeding the new pages into a local list, then
grafting the whole list onto the inactive list when we start to scan.  We
want to do something like that for nonsucky readahead as well.

-- 
Daniel
