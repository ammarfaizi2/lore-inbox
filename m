Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319246AbSHUXcC>; Wed, 21 Aug 2002 19:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319247AbSHUXcC>; Wed, 21 Aug 2002 19:32:02 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:22588 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S319246AbSHUXcB>; Wed, 21 Aug 2002 19:32:01 -0400
Date: Wed, 21 Aug 2002 17:51:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: mingming cao <cmm@us.ibm.com>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>, <akpm@zip.com.au>
Subject: Re: [PATCH] Breaking down the global IPC locks - 2.5.31
In-Reply-To: <3D62817F.B2AA96AD@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0208211702320.10682-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2002, mingming cao wrote:
> > 
> > This patch breaks the three global IPC locks into one lock per IPC ID.
> > By doing so it could reduce possible lock contention in workloads which
> > make heavy use of IPC semaphores, message queues and Shared
> > memories...etc.
> 
> Here is the patch again. Fixed a typo. *_^

Looks good to me...

Except last time around I persuaded you that ipc_lockall, ipc_unlockall
(shm_lockall, shm_unlockall) needed updating; and now I think that they
were redundant all along and can just be removed completely.  Only used
by SHM_INFO, I'd expected you to make them read_locks: surprised to find
write_locks, thought about it some more, realized you would need to use
write_locks - except that the down(&shm_ids.sem) is already protecting
against everything that the write_lock would protect against (the values
reported, concurrent freeing of an entry, concurrent reallocation of the
entries array).  If you agree, please just delete all ipc_lockall
ipc_unlockall shm_lockall shm_unlockall lines.  Sorry for not
noticing that earlier.

You convinced me that it's not worth trying to remove the ipc_ids.sems,
but I'm still slightly worried that you add another layer of locking.
There's going to be no contention over those read_locks (the write_lock
only taken when reallocating entries array), but their cachelines will
still bounce around.  I don't know if contention or bouncing was the
more important effect before, but if bouncing then these changes may
be disappointing in practice.  Performance results (or an experienced
voice, I've little experience of such tradeoffs) would help dispel doubt.
Perhaps, if ReadCopyUpdate support is added into the kernel in future,
RCU could be used here instead of rwlocking?

Nit: I'd prefer "= RW_LOCK_UNLOCKED" instead of "=RW_LOCK_UNLOCKED".

Hugh

