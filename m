Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261677AbSJ2ATW>; Mon, 28 Oct 2002 19:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261921AbSJ2ATW>; Mon, 28 Oct 2002 19:19:22 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:3107 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S261910AbSJ2ATO>; Mon, 28 Oct 2002 19:19:14 -0500
Date: Tue, 29 Oct 2002 00:26:27 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rusty Russell <rusty@rustcorp.com.au>
cc: mingming cao <cmm@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]updated ipc lock patch 
In-Reply-To: <20021028222738.201E02C4D6@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0210282357450.1315-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Rusty Russell wrote:
> > 
> > No bound to the number of possible OOM kills, but what problem is that?
> 
> Sorry, I'm obviously not making myself clear, since I've said this
> three times now.
> 
> 1) The memory is required for one whole RCU period (whether from
>    kmalloc or the mempool).  This can be an almost arbitrarily long
>    time (I've seen it take a good fraction of a second).

That's a very short time compared with an OOMing thrash: no worries there.

> 2) This is a problem, because other tasks could be OOM killed during
>    that period, and could also try to use this mempool.

They'll try to use the mempool, maybe some will be allowed to wait
for their kmalloc(GFP_KERNEL) memory, and others will be PF_MEMDIEd and
proceed to take a reserved mempool buffer, and others will be PF_MEMDIEd
and have to wait for a reserved mempool buffer.  Which will be released
to them in due course.  No worries there.

> 3) So, the size of the mempool which guarantees there will be enough?
>    It's equal to the number of things you might free, which means
>    you might as well allocate them together.

No, they take their turns.  It's sure not as efficient as each getting
a kmalloc'ed buffer immediately, but its failures will be rare.  And
it doesn't matter whether the failures only occur when heading for
OOM-kill or not: we just don't want failure to be the common case.
If kmalloc evolves into something that normally fails half the time,
well, I'd think that'd be called a bug.

> This is the correctness problem with the mempool IPC implementation.

No.  There may be other situations which might need at least
NR_CPUS reserved mempool buffer to avoid deadlock, but that's not
the case here.  Looks like mempool will be superseded as you wish
in the IPC context, fine; but I do think you need to take a look
at mempool_alloc: it's a different beast from what you suppose.

Hugh

