Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155087AbPFMSv2>; Sun, 13 Jun 1999 14:51:28 -0400
Received: by vger.rutgers.edu id <S155075AbPFMSvT>; Sun, 13 Jun 1999 14:51:19 -0400
Received: from hera.cwi.nl ([192.16.191.1]:38840 "EHLO hera.cwi.nl") by vger.rutgers.edu with ESMTP id <S155072AbPFMSvE>; Sun, 13 Jun 1999 14:51:04 -0400
Date: Sun, 13 Jun 1999 20:47:08 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC199906131847.UAA26622.aeb@eland.cwi.nl>
To: ralf@uni-koblenz.de
Subject: size of pid_t (was: Re: NR_TASKS as config option)
Cc: alan@lxorguk.ukuu.org.uk, bishop@sekure.org, daniel.kobras@student.uni-tuebingen.de, drepper@cygnus.com, linux-kernel@vger.rutgers.edu, mingo@chiara.csoma.elte.hu
Sender: owner-linux-kernel@vger.rutgers.edu

        From: Ralf Baechle <ralf@uni-koblenz.de>

        I'd actually like to see a 64-bit pid_t.
        First of all, I've already once being bitten
        by a bug caused by a re-used PID...

Yes, eventually we'll have to.
But a 32-bit pid_t is not so bad:
With a hundred new processes spawned every second
a 32-bit pid_t will wrap only after about 500 days.

(Of course the bad part is that a wrap will still occur;
as you already said, code is much simplified if we are
sure that no pid will ever be reused.)

The present situation however is much worse:
the pid_t wraps from 32767 to 300 (kernel/fork.c).
On the one hand this means that one cannot have more than 2^15
processes. On the other hand this causes some security problems.

Changing the size of pid_t to 64-bit is a major operation.
Lots of system calls have pid_t arguments or return pid_t
results. And pid_t occurs many other places. For example,
a struct flock has a pid_t field.
Moreover, glibc doesnt have machinery in place to change
the size of a pid_t. So, if I am not mistaken, this would
require a new major number for the library.

But if pid_t is 32-bit, then why does the kernel only use 15 bits?
We have
        #define PID_MAX 0x8000
in <linux/tasks.h>, and at first sight not much goes wrong
if we pick some larger number for PID_MAX, like 0x7fffffff.
(There are some comparisons around, so for simplicity we should
keep PID_MAX positive.)


Hmm - but then what is it that goes wrong?
In include/asm-i386/posix_types.h we have
        typedef unsigned short __kernel_ipc_pid_t;
(and the same for m68k, ppc, sparc, arm).
This is the type of the fields msg_lspid, msg_lrpid, shm_cpid, shm_lpid
of struct msqid_ds and shmid_ds. Such structures are returned by
the system calls msgctl() and shmctl().
So, using larger pid's gives some trouble with SYSV IPC.
(And again glibc is unable to cope with changes, although
the trouble is minor in this case.)


Conclusion:
- a 64-bit pid_t is most convenient for the kernel, but
  gives trouble with libc.
- a 32-bit pid_t is what we have today, but we use only
  15 bits because of SYSV IPC (or perhaps other reasons
  I am unaware of).



Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
