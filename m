Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313588AbSDMOO6>; Sat, 13 Apr 2002 10:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313589AbSDMOO6>; Sat, 13 Apr 2002 10:14:58 -0400
Received: from mx.nlm.nih.gov ([130.14.22.48]:35211 "EHLO mx.nlm.nih.gov")
	by vger.kernel.org with ESMTP id <S313588AbSDMOO4>;
	Sat, 13 Apr 2002 10:14:56 -0400
Date: Sat, 13 Apr 2002 10:14:43 -0400 (EDT)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
Message-Id: <200204131414.g3DEEhH27768@pavo.nlm.nih.gov>
To: torvals@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [REPOST] BUG:: IPC/semop clobbers PID of the last modifier
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I repost this message because there is a bug in the kernel's IPC,
but I did not diagnoze it completely (very late in the night :-).
Let me make some corrections here:

"Wait for zero" does not reset PID to 0 but indeed clobbers it by
obtaining a PID of the last but one process which modified the semaphore.
However, in my test application there are 2 attempts to get a sem be zero
(via 'semop' being interrupted by an 'alarm') before actually getting
the PID if 'semop' failed. That is, in my particular case, after
the 2 unsuccessful 'semop' attempts, the last PID always becomes zero
due to two 16-bit rshifts in undo block of try_atomic_semop().

My initially suggested fix is in general bad, sorry. Although it works
for me because in the op array that I pass to 'semop' I first check a sem
for 0 and then increase the same sem by one. But check for zero should not
really change sem's PID. That is, the swap of condition and PID saving
has not to be done, but instead check against zero op should be added
before PID restoration in undo block:

undo: 
        while (sop >= sops) { 
                curr = sma->sem_base + sop->sem_num; 
                if (sop->sem_op) {
                        curr->semval -= sop->sem_op; 
                        curr->sempid >>= 16;
                }

Additionally, as one can see there is a potential problem
in the way of saving PID in 16 spare upper bits of sempid.
An application can vitrually make two (or even more) sem decreases
in a single semop() call on the same semaphore. If such an operation
is to be blocked, and this is discovered only at the time of the
second (or later) op check, original PID will be lost.

Thanks!
And sorry about messing up with this report.


Anton Lavrentiev 
NCBI/NLM/NIH 
Bethesda MD 20894 

--------------------------------------------------------------------------

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
                if (!sem_op && curr->semval) /*!!!!!!*/ 
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
                curr->sempid >>= 16; /*!!!!!!*/ 
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
