Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318166AbSIAXsc>; Sun, 1 Sep 2002 19:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318168AbSIAXsc>; Sun, 1 Sep 2002 19:48:32 -0400
Received: from dsl-213-023-021-067.arcor-ip.net ([213.23.21.67]:58754 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318166AbSIAXsc>;
	Sun, 1 Sep 2002 19:48:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [RFC] [PATCH] Include LRU in page count
Date: Mon, 2 Sep 2002 01:33:06 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
References: <3D644C70.6D100EA5@zip.com.au> <E17ld5N-0004cg-00@starship> <3D729DD3.AE3681C9@zip.com.au>
In-Reply-To: <3D729DD3.AE3681C9@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17leDK-0004dA-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 September 2002 01:08, Andrew Morton wrote:
> Daniel Phillips wrote:
> > Note that I changed the spin_lock in page_cache_release to a trylock, maybe
> > it's worth checking out the effect on contention.  With a little head
> > scratching we might be able to get rid of the spin_lock in lru_cache_add as
> > well.  That leaves (I think) just the two big scan loops.  I've always felt
> > it's silly to run more than one of either at the same time anyway.
> 
> No way.  Take a look at http://samba.org/~anton/linux/2.5.30/
> 
> That's 8-way power4, the workload is "dd from 7 disks
> dd if=/dev/sd* of=/dev/null bs=1024k".
> 
> The CPU load in this situation was dominated by the VM.  The LRU list and page
> reclaim.  Spending more CPU in lru_cache_add() than in copy_to_user() is
> pretty gross.

Are we looking at the same thing?  The cpu load there is dominated by cpu_idle,
89%.  Anyway, if your point is that it makes sense to run shrink_cache or
refill_inactive in parallel, I don't see it because they'll serialize on the
lru lock anyway.  What would make sense is to make shink_cache nonblocking.

> My approach was to keep the existing design and warm it up, rather than to
> redesign.

Yup.

-- 
Daniel
