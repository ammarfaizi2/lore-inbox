Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSHFUwR>; Tue, 6 Aug 2002 16:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSHFUvJ>; Tue, 6 Aug 2002 16:51:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:30945 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316187AbSHFUup>;
	Tue, 6 Aug 2002 16:50:45 -0400
Message-ID: <3D50367E.85EF0968@us.ibm.com>
Date: Tue, 06 Aug 2002 13:50:06 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Breaking down the global IPC locks
References: <Pine.LNX.4.44.0208061556160.1545-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> 1. To reduce dirty cacheline bouncing, shouldn't the per-id spinlock
>    be in the kern_ipc_perm structure pointed to by entries[lid], not
>    mixed in with the pointers of the entries array?  I expect a few
>    areas would need to be reworked if that change were made, easy to
>    imagine wanting the lock/unlock before/after the structure is there.
> 
You are right at the cacheline bouncing issue.  I will make that change.

> 2. I worry more about the msg_ids.sem, sem_ids.sem, shm_ids.sem which
>    guard these areas too.  Yes, there are some paths where the ipc_lock
>    is taken without the down(&ipc_ids.sem) (perhaps those are even the
>    significant paths, I haven't determined); but I suspect there's more
>    to be gained by avoiding those (kernel)semaphores than by splitting
>    the spinlocks.
>
I don't worry the ipc_ids.sem very much.  They are used to protect the
IPC info, which is not updated quiet often (by operation such as
semctl()). Significant IPC operations, like semop(), msgsnd() and
msgrcv(), need the access to the IPC ID, where only the ipc_lock() is
needed.
 
> 3. You've added yet another level of locking, the read/write-locking
>    on ary_lock.  That may be the right way to go, but I think there's
>    now huge redundancy between that and the ipc_ids.sem - should be
>    possible to get rid of one or the other.
>
They look similar at the first glance. But they serve for different
purposes.  The ipc_ids.sem is used to protect the IPC infos, while the
ary_lock is used to protect the IPC ID array.  This way we could do
semctl() and semop() in parallel.
 
> 4. You've retained the ids->ary field when you should have removed it;
>    presumably retained so ipc_lockall,ipc_unlockall compile, but note
>    that now ipc_lockall only locks against another ipc_lockall, which
>    is certainly not its intent.  If it's essential (it's only used for
>    SHM_INFO), then I think you need to convert it to a lock on ary_lock.
> 
Thanks for point this out to me. I need to get ipc_lockall/ipc_unlockall
fixed.

Mingming
