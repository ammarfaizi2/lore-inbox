Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318107AbSHWAcu>; Thu, 22 Aug 2002 20:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318116AbSHWAcu>; Thu, 22 Aug 2002 20:32:50 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:63683 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318107AbSHWAct>; Thu, 22 Aug 2002 20:32:49 -0400
Message-ID: <3D658399.80855551@us.ibm.com>
Date: Thu, 22 Aug 2002 17:36:41 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Breaking down the global IPC locks - 2.5.31
References: <Pine.LNX.4.44.0208211702320.10682-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> Except last time around I persuaded you that ipc_lockall, ipc_unlockall
> (shm_lockall, shm_unlockall) needed updating; and now I think that they
> were redundant all along and can just be removed completely.  Only used
> by SHM_INFO, I'd expected you to make them read_locks: surprised to find
> write_locks, thought about it some more, realized you would need to use
> write_locks - except that the down(&shm_ids.sem) is already protecting
> against everything that the write_lock would protect against (the values
> reported, concurrent freeing of an entry, concurrent reallocation of the
> entries array).  If you agree, please just delete all ipc_lockall
> ipc_unlockall shm_lockall shm_unlockall lines.  Sorry for not
> noticing that earlier.
> 

Agree. I was worrried about the case when shm_destroy() is called while
trying to do a shm_get_stat().  But since shm_ids.sem is used to protect
almost every shm operations, so I think that removing the ipc_lockall()
totally should be safe.  


> You convinced me that it's not worth trying to remove the ipc_ids.sems,
> but I'm still slightly worried that you add another layer of locking.
> There's going to be no contention over those read_locks (the write_lock
> only taken when reallocating entries array), but their cachelines will
> still bounce around.  I don't know if contention or bouncing was the
> more important effect before, but if bouncing then these changes may
> be disappointing in practice.  Performance results (or an experienced
> voice, I've little experience of such tradeoffs) would help dispel doubt.
> Perhaps, if ReadCopyUpdate support is added into the kernel in future,
> RCU could be used here instead of rwlocking?

Hmm...note sure about the tradeoffs either.  Having one lock per IPC ID
does make sense to me, but the cacheline bouncing should also be avoid. 
I need to re-think about this read-write lock and the ipc_ids.sems.  
 
> Nit: I'd prefer "= RW_LOCK_UNLOCKED" instead of "=RW_LOCK_UNLOCKED".

I like it better too.:-)


Mingming
