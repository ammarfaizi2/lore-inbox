Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314192AbSDMG13>; Sat, 13 Apr 2002 02:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314193AbSDMG12>; Sat, 13 Apr 2002 02:27:28 -0400
Received: from mx.nlm.nih.gov ([130.14.22.48]:60154 "EHLO mx.nlm.nih.gov")
	by vger.kernel.org with ESMTP id <S314192AbSDMG12>;
	Sat, 13 Apr 2002 02:27:28 -0400
Date: Sat, 13 Apr 2002 02:27:13 -0400 (EDT)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
Message-Id: <200204130627.g3D6RDS25769@pavo.nlm.nih.gov>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: BUG:: IPC/semop clobbers PID of the last modifier
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I think I found another bug in the kernel. If "wait for zero"
operation on an IPC semaphore is going to be blocked,
it then clobbers (resets to 0) PID of the process, which last
modified the semaphore (obtainable via semctl(...GETPID...)).
This bug is simply because of undo in 'try_atomic_semop' always
restores PID of the last process that modified the semaphore, while
"wait for zero" does not save that PID:

file ipc/sem.c, try_atomic_semop():
---------------------------------------------------------------------------
                if (!sem_op && curr->semval)               /*!!!!!!*/
                        goto would_block;

                curr->sempid = (curr->sempid << 16) | pid; /*!!!!!!*/

                ........

would_block:
        if (sop->sem_flg & IPC_NOWAIT)
                result = -EAGAIN;
        else
                result = 1;

undo:
        while (sop >= sops) {
                curr = sma->sem_base + sop->sem_num;
                curr->semval -= sop->sem_op;
                curr->sempid >>= 16;                      /*!!!!!!*/
---------------------------------------------------------------------------

The simplest fix is just to swap the "wait for zero" condition and
PID backup, like this:

                curr->sempid = (curr->sempid << 16) | pid;

                if (!sem_op && curr->semval)
                        goto would_block;


Cheers,

Anton Lavrentiev
NCBI/NLM/NIH
Bethesda MD 20894
