Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQKMPOg>; Mon, 13 Nov 2000 10:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129249AbQKMPO1>; Mon, 13 Nov 2000 10:14:27 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:45552 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129044AbQKMPOP>;
	Mon, 13 Nov 2000 10:14:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A10031B.79D8A9B5@mandrakesoft.com> 
In-Reply-To: <3A10031B.79D8A9B5@mandrakesoft.com>  <3A0FF138.A510B45@mandrakesoft.com> <7572.974120930@redhat.com> <20554.974126251@redhat.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: torvalds@transmeta.com, dhinds@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Nov 2000 15:14:04 +0000
Message-ID: <26373.974128444@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
> Doh, totally forgot about that.  Will this work:
> 	save_current = current;
> 	current = find_task_by_pid(1);
> 	waitpid(...);
> 	current = save_current;

Changing the thread's parent to current->pid would be better than modifying 
current. Still sucks though.... 

> In any case, we -really- need a wait_for_kernel_thread_to_die()
> function. 

up_and_exit() would do it. Or preferably passing the address of the 
semaphore as an extra argument to kernel_thread() in the first place.

In the meantime, enough other places in the kernel have this same race that
I'm not too concerned about it. Hopefully, we'll get the extra arg to
kernel_thread before the final cut of 2.4, and this code can get converted
along with everything else.

> > +        spin_lock_irq(&current->sigmask_lock);
> > +        sigfillset(&current->blocked);
> > +        recalc_sigpending(current);
> > +        spin_unlock_irq(&current->sigmask_lock);

> what does this do?

Well, I _hope_ it blocks all signals, so that we can sleep in 
TASK_INTERRUPTIBLE without adding 1 to the load average, and without having 
to worry about the pesky things actually interrupting us.


jgarzik@mandrakesoft.com said:
> why do you store the event_thread_pid but never use it?

Because I got half way through doing waitpid() before I realised it was 
sucky. We store it short-term so we can print it. No reason why we can't 
shift the static declaration into init_pcmcia_cs() though.



--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
