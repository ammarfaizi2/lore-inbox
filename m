Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbSJUUDk>; Mon, 21 Oct 2002 16:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261606AbSJUUDj>; Mon, 21 Oct 2002 16:03:39 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:43416 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S261288AbSJUUDj>; Mon, 21 Oct 2002 16:03:39 -0400
Date: Mon, 21 Oct 2002 21:10:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Manfred Spraul <manfred@colorfullife.com>
cc: mingming cao <cmm@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]IPC locks breaking down with RCU
In-Reply-To: <3DB4544B.806@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0210212056390.17270-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Manfred Spraul wrote:
> 
> Probably the best approach is to add a "deleted" flag into the ipc_id 
> structure, and to check that flag after acquiring the spinlock. And 
> perform the actual free operations for the ipc element in a rcu callback.

Yes, that's what I was proposing.

> At which context do the rcu callbacks run? The semaphore sets are 
> allocated with vmalloc for large sets, and that function is only 
> permitted from process context, not from bh or irq context. According to 
> a comment in rcupdate.c, rcu_process_callbacks runs in a tasklet, i.e. 
> at bh context.

Hah!  Very good point.  Seems we need to think again.

> For example, should a spinlock and the data it protects be in the same 
> cacheline, or in different cachelines?
> I guess that "same cacheline" means that only one cacheline is 
> transfered if a cpu acquires the spinlock and touches the data.
> But OTHO a spinning cpu would probably force the cacheline into shared 
> state, and that'll slow down the data access for the cpu that owns the 
> spinlock.

Well, yes, but that's not the issue as I understand it.  There you're
thinking of contention on the spinlock, and its effect spreading to
the data protected by that lock.  Whereas the more pernicious effect
of cacheline bouncing is when there is no particular contention on
a spinlock, but data is (mis)distributed in such a way that mods to
the same cacheline are likely to occur from different cpus at at about
the same time.

In the original design, Mingming nicely split up the locks (greatly
reducing contention), but had them in an array (causing lots of bounce,
I believe): I'm resisting a return to that design.

Hugh

