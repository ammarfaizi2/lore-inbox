Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSHFPtx>; Tue, 6 Aug 2002 11:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSHFPtx>; Tue, 6 Aug 2002 11:49:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:25988 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S312558AbSHFPtw>; Tue, 6 Aug 2002 11:49:52 -0400
Date: Tue, 6 Aug 2002 16:53:59 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: mingming cao <cmm@us.ibm.com>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Breaking down the global IPC locks
In-Reply-To: <3D4ED69E.ABA2C737@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0208061556160.1545-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, mingming cao wrote:
> In current implementation, the operations on any IPC semaphores are
> synchronized by one single IPC semaphore lock.  Changing the IPC locks
> from one lock per IPC resource type into one lock per IPC ID makes sense
> to me.  By doing so could reduce the possible lock contention in some
> applications where the IPC resources are heavily used.

Yes, the unused "id" argument to ipc_lock() cries out to be put to use.
However...

> Test results from the LMbench Pipe and IPC latency test shows this patch 
> improves the performance of those functions from 1% to 9%.  

I cast doubt in other mail: I don't see how LMbench gets here at all.

If it's worth changing around this SysV IPC locking,
then I think there's rather more that needs to be done:

1. To reduce dirty cacheline bouncing, shouldn't the per-id spinlock
   be in the kern_ipc_perm structure pointed to by entries[lid], not
   mixed in with the pointers of the entries array?  I expect a few
   areas would need to be reworked if that change were made, easy to
   imagine wanting the lock/unlock before/after the structure is there.

2. I worry more about the msg_ids.sem, sem_ids.sem, shm_ids.sem which
   guard these areas too.  Yes, there are some paths where the ipc_lock
   is taken without the down(&ipc_ids.sem) (perhaps those are even the
   significant paths, I haven't determined); but I suspect there's more
   to be gained by avoiding those (kernel)semaphores than by splitting
   the spinlocks.

3. You've added yet another level of locking, the read/write-locking
   on ary_lock.  That may be the right way to go, but I think there's
   now huge redundancy between that and the ipc_ids.sem - should be
   possible to get rid of one or the other.
   
4. You've retained the ids->ary field when you should have removed it;
   presumably retained so ipc_lockall,ipc_unlockall compile, but note
   that now ipc_lockall only locks against another ipc_lockall, which
   is certainly not its intent.  If it's essential (it's only used for
   SHM_INFO), then I think you need to convert it to a lock on ary_lock.

Hugh

