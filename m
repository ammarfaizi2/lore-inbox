Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318142AbSG2Vqw>; Mon, 29 Jul 2002 17:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318141AbSG2Vqw>; Mon, 29 Jul 2002 17:46:52 -0400
Received: from dsl-213-023-043-226.arcor-ip.net ([213.23.43.226]:52372 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318140AbSG2Vqt>;
	Mon, 29 Jul 2002 17:46:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch 1/13] misc fixes
Date: Mon, 29 Jul 2002 23:51:24 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
References: <3D439E09.3348E8D6@zip.com.au> <E17Z4v0-0002io-00@starship> <3D459ECE.C5BD53DE@zip.com.au>
In-Reply-To: <3D459ECE.C5BD53DE@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ZIQH-0004Wo-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 July 2002 22:00, Andrew Morton wrote:
> > The idea I'm playing with now is to address an array of locks based on
> > something like:
> > 
> >         spin_lock(pte_chain_locks + ((page->index >> 4) & 0xff));
> > 
> > so that 16 consecutive filemap pages use the same lock and there is a limited
> > total number of locks to keep cache pressure down.  Since we are creating the
> > vast majority of the pte chain nodes while walking across page tables, this
> > should give nice locality.
> 
> Something like that could help.
> 
> At some point, when the reverse map is as CPU efficient as we can make it,
> we need to decide whether the remaining cost is worth the benefit.  I
> wonder how to do that.

We need measurements for a few other loads I think.

> > For this to work, anon pages will need to have something in page->index.
> > This isn't too much of a challenge.  A reasonable value to put in there is
> > the creator's virtual address, shifted right, and perhaps mangled a little to
> > reduce contention.
> 
> Well you want the likely-to-be-temporally-adjacent anon pages to
> use the same lock.  So maybe
> 
> 	page->index = some_global_int++;

Yes, that's better.

> Except ->index gets stomped on when the page gets added to swapcache.
> Which means that the address of its lock will change.  I can't immediately
> think of a fix for that.

We'd have to hold the lock while changing the page->index.  Pte_chain_lock
would additionally have to check the page->index after acquiring the lock
and, if changed, drop it and take the new one.  I don't think the overhead 
for this check is significant.

Add_to_page_cache would want new flavor that shortens up the pte chain lock 
hold time, but it looks like it should have a swap-specific variant anyway.

-- 
Daniel
