Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132414AbQKDF3A>; Sat, 4 Nov 2000 00:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132155AbQKDF2v>; Sat, 4 Nov 2000 00:28:51 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:7816 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131961AbQKDF2h>; Sat, 4 Nov 2000 00:28:37 -0500
Message-ID: <3A039E77.5DD87DF0@uow.edu.au>
Date: Sat, 04 Nov 2000 16:28:23 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jorge Nerin <comandante@zaralinux.com>
CC: Paul Gortmaker <p_gortmaker@yahoo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux SMP Mailing List <linux-smp@vger.kernel.org>
Subject: Re: [patch] NE2000
In-Reply-To: <E13pz9c-0006Jh-00@the-village.bc.nu> <39FD5433.587FF7C6@zaralinux.com> <39FFE612.2688A5AD@yahoo.com> <3A02F9AA.AFB2DB1B@zaralinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jorge Nerin wrote:
> 
> ...
> So I think that it could be a little window near sock_wait_for_wmem that
> could be SMP insecure wich is affecting me.
> 
> The code of sock_wait_for_wmem in 2.4.0-test10 is this:
> 
> static long sock_wait_for_wmem(struct sock * sk, long timeo)
> {
>         DECLARE_WAITQUEUE(wait, current);
> 
>         clear_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
>         add_wait_queue(sk->sleep, &wait);
>         for (;;) {
>                 if (signal_pending(current))
>                         break;
>                 set_bit(SOCK_NOSPACE, &sk->socket->flags);
>                 set_current_state(TASK_INTERRUPTIBLE);
>                 if (atomic_read(&sk->wmem_alloc) < sk->sndbuf)
>                         break;
>                 if (sk->shutdown & SEND_SHUTDOWN)
>                         break;
>                 if (sk->err)
>                         break;
>                 timeo = schedule_timeout(timeo);
>         }
>         __set_current_state(TASK_RUNNING);
>         remove_wait_queue(sk->sleep, &wait);
>         return timeo;
> }
> 
> Does someone see something SMP insecure? Perhaps I'm totally wrong, this
> could also be somewhere in the interrupt handling, don't know.

No, that code is correct, provided (current->state == TASK_RUNNING)
on entry.  If it isn't, there's a race window which can cause
lost wakeups.   As a check you could add:

	if ((current->state & (TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE)) == 0)
		BUG();

to the start of this function.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
