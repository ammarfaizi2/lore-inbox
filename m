Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSH3VBK>; Fri, 30 Aug 2002 17:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSH3VBK>; Fri, 30 Aug 2002 17:01:10 -0400
Received: from mx.nlm.nih.gov ([130.14.22.48]:38114 "EHLO mx.nlm.nih.gov")
	by vger.kernel.org with ESMTP id <S317512AbSH3VBJ>;
	Fri, 30 Aug 2002 17:01:09 -0400
Message-ID: <3D6FDDE9.34C86464@ncbi.nlm.nih.gov>
Date: Fri, 30 Aug 2002 17:04:41 -0400
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
Organization: NCBI NIH
X-Mailer: Mozilla 4.79 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, lavr@ncbi.nlm.nih.gov
CC: cpp-core@ncbi.nlm.nih.gov, torvalds@transmeta.com
Subject: BUG:: IPC/semop clobbers PID of the last process performed semop() on 
 the semaphore
References: <Pine.LNX.4.33.0204151000310.2259-100000@penguin.transmeta.com> <3CBB23A8.80C0550F@ncbi.nlm.nih.gov>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developers:

I reported this bug a while ago but seems that it is still there.

If "wait for zero" on the IPC semaphore is going to be blocked,
then it clobbers PID of the last process, which operated on
semaphore, actually reverting the PID to be the PID of the last but
one process that made an operation.

In particular, if the syscall was interrupted by a signal, restarted,
and interrupted again, the PID of last process operated on the semaphore
(obtainable via semctl(...GETPID...)) becomes unconditionally zero.

The bug comes from the following fragment of file (look at the lines
marked with exclamation points)

ipc/sem.c, try_atomic_semop():
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

The simplest fix (that works!) is just to swap the "wait for zero" condition
and PID backup, like this:

                 curr->sempid = (curr->sempid << 16) | pid;

                 if (!sem_op && curr->semval)
                         goto would_block;


Best regards,

Anton Lavrentiev
NCBI/NLM/NIH
Bethesda MD 20894


P.S. There is a potential bug in the very idea of temporary saving of PID in the
spare most significant word of "curr->sempid": if the user requests more that one
operation on the same semaphore in the same "sem_op" block, and the fact of blocking
is not figured out at the first operation, but later, than backup in 16 upper
bits will not work, because there will be two (or more) 16-bit rshifts in restore
operation, effectively zeroing "curr->sempid". On the other hand, this is a very
odd (and rather "theoretical") situation, cause normally the fact of blocking
is checked by "sem_op" first, prior to doing something else without further blocking.
