Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S160881AbPFNKbA>; Mon, 14 Jun 1999 06:31:00 -0400
Received: by vger.rutgers.edu id <S160863AbPFNK04>; Mon, 14 Jun 1999 06:26:56 -0400
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:58877 "EHLO mailhost.uni-koblenz.de") by vger.rutgers.edu with ESMTP id <S160794AbPFNKZ7>; Mon, 14 Jun 1999 06:25:59 -0400
Date: Mon, 14 Jun 1999 11:22:32 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, bishop@sekure.org, daniel.kobras@student.uni-tuebingen.de, drepper@cygnus.com, linux-kernel@vger.rutgers.edu, mingo@chiara.csoma.elte.hu
Subject: Re: size of pid_t (was: Re: NR_TASKS as config option)
Message-ID: <19990614112232.C13946@uni-koblenz.de>
References: <UTC199906131847.UAA26622.aeb@eland.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <UTC199906131847.UAA26622.aeb@eland.cwi.nl>; from Andries.Brouwer@cwi.nl on Sun, Jun 13, 1999 at 08:47:08PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-kernel@vger.rutgers.edu

On Sun, Jun 13, 1999 at 08:47:08PM +0200, Andries.Brouwer@cwi.nl wrote:

> Changing the size of pid_t to 64-bit is a major operation.
> Lots of system calls have pid_t arguments or return pid_t
> results. And pid_t occurs many other places. For example,
> a struct flock has a pid_t field.
> Moreover, glibc doesnt have machinery in place to change
> the size of a pid_t. So, if I am not mistaken, this would
> require a new major number for the library.
> 
> But if pid_t is 32-bit, then why does the kernel only use 15 bits?
> We have
>         #define PID_MAX 0x8000
> in <linux/tasks.h>, and at first sight not much goes wrong
> if we pick some larger number for PID_MAX, like 0x7fffffff.
> (There are some comparisons around, so for simplicity we should
> keep PID_MAX positive.)
> 
> 
> Hmm - but then what is it that goes wrong?
> In include/asm-i386/posix_types.h we have
>         typedef unsigned short __kernel_ipc_pid_t;
> (and the same for m68k, ppc, sparc, arm).

Alpha, MIPS and Sparc64 on the other side do use a 32-bit *pid_t and
are limited by the current implementation to effectivly 15 bit.

> This is the type of the fields msg_lspid, msg_lrpid, shm_cpid, shm_lpid
> of struct msqid_ds and shmid_ds. Such structures are returned by
> the system calls msgctl() and shmctl().
> So, using larger pid's gives some trouble with SYSV IPC.
> (And again glibc is unable to cope with changes, although
> the trouble is minor in this case.)
> 
> 
> Conclusion:
> - a 64-bit pid_t is most convenient for the kernel, but
>   gives trouble with libc.

Note that I have a chance for a fresh start for MIPS64.  Binary
compatibility is therefore not an issue.  Furthermore it's a 64-bit
architecture, so the code size itself will not increase.

The biggest problem will probably be code which does things like

  int pid;

  pid = fork();

Finding them all is going to be quite a nasty problem.  Making the kernel
/ libc reject pids that are signed / unsigned expanded 32-bit numbers
except init's pid will support that, hopefully.

> - a 32-bit pid_t is what we have today, but we use only
>   15 bits because of SYSV IPC (or perhaps other reasons
>   I am unaware of).

Pids in the range of [0 ... 32000[ are pretty much tradition among
unices since about the time UNIX was born.  Linux does things slightly
more efficient by using the entire range of [0 ... 32768].

  Ralf

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
