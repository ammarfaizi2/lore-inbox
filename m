Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318168AbSIBACB>; Sun, 1 Sep 2002 20:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318170AbSIBACB>; Sun, 1 Sep 2002 20:02:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10769 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318168AbSIBACA>;
	Sun, 1 Sep 2002 20:02:00 -0400
Message-ID: <3D72AE2C.F1806BDD@zip.com.au>
Date: Sun, 01 Sep 2002 17:17:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Include LRU in page count
References: <3D644C70.6D100EA5@zip.com.au> <E17ld5N-0004cg-00@starship> <3D729DD3.AE3681C9@zip.com.au> <E17leDK-0004dA-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Monday 02 September 2002 01:08, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > > Note that I changed the spin_lock in page_cache_release to a trylock, maybe
> > > it's worth checking out the effect on contention.  With a little head
> > > scratching we might be able to get rid of the spin_lock in lru_cache_add as
> > > well.  That leaves (I think) just the two big scan loops.  I've always felt
> > > it's silly to run more than one of either at the same time anyway.
> >
> > No way.  Take a look at http://samba.org/~anton/linux/2.5.30/
> >
> > That's 8-way power4, the workload is "dd from 7 disks
> > dd if=/dev/sd* of=/dev/null bs=1024k".
> >
> > The CPU load in this situation was dominated by the VM.  The LRU list and page
> > reclaim.  Spending more CPU in lru_cache_add() than in copy_to_user() is
> > pretty gross.
> 
> Are we looking at the same thing?  The cpu load there is dominated by cpu_idle,
> 89%.

Apart from that, dummy ;)  The absolute numbers are proportional
to IO bandwidth.  And 7/8ths of a scsi disk per CPU isn't much.

>  Anyway, if your point is that it makes sense to run shrink_cache or
> refill_inactive in parallel, I don't see it because they'll serialize on the
> lru lock anyway.  What would make sense is to make shink_cache nonblocking.

Well shrink_list() runs locklessly now.  But there remains a significant
cost in shrink_cache(), a little of which will be due to the hopefully-removable
page_cache_get() inside the lock.
