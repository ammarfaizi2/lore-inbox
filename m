Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263290AbSJTRU3>; Sun, 20 Oct 2002 13:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbSJTRU3>; Sun, 20 Oct 2002 13:20:29 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:44108 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S263290AbSJTRU2>; Sun, 20 Oct 2002 13:20:28 -0400
Date: Sun, 20 Oct 2002 18:27:25 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: mingming cao <cmm@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       <dipankar@in.ibm.com>
Subject: Re: [PATCH]IPC locks breaking down with RCU
In-Reply-To: <Pine.LNX.4.44.0210201346180.1710-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210201809490.2106-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Hugh Dickins wrote:
> 
> This looks very good to me: I'm glad you found the RCU idea works out.
> ...
> And I'd be happier to see ipc_unlock without those conditionals i.e.
> delete the "if(lid >= ids->size) return;" and the "if (out)" - they
> seem to encourage calling ipc_unlock where ipc_lock did not succeed,
> but that would be unsafe.  If you found somewhere that's being done,
> I think we need to fix that place, not work around it in ipc_unlock.

Sorry, MingMing, it doesn't look so good to me now.

The "if(lid >= ids->size) return;" still looks unnecessary,
but I think I see why you have "if (out)" in ipc_unlock: because
of ipc_rmid, which has already nulled out entries[lid].p, yes?

A minor point is, wouldn't that skipping of spin_unlock leave you
with the wrong preempt count, on a CONFIG_PREEMPT y configuration?
But that's easily dealt with.

A much more serious point: we could certainly bring the ipc_rmid
and ipc_unlock much closer together; but however close we bring them
(unlock implicit within rmid), there will still be a race with one
cpu in ipc_lock spinning on out->lock, while we in ipc_rmid null
entries[lid].p and unlock and free the structure containing that lock.

I think you're going to have to extend RCU to freeing the entry
(though this is a much less exceptional case than growing the array,
so less clear to me that RCU is appropriate here), if you're to
avoid reverting to the earlier rwlock or embedded spinlock designs.

Perhaps there's a simpler solution - ask around - but I don't see it.

Hugh

