Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbQKMNtn>; Mon, 13 Nov 2000 08:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbQKMNtd>; Mon, 13 Nov 2000 08:49:33 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39441 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129488AbQKMNtP>;
	Mon, 13 Nov 2000 08:49:15 -0500
Message-ID: <3A0FF138.A510B45@mandrakesoft.com>
Date: Mon, 13 Nov 2000 08:48:40 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <7572.974120930@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> I'm not sure why we changed from the existing state machine / timer setup to
> sleeping in the PCMCIA parse_events() routine, 

I don't remember the exact reason, but Linus changed it for yenta...  
maybe because CardBus Watcher always called the state machine from user
context...


> +static int pcmcia_event_thread(void * dummy)
> +{
> +       DECLARE_WAITQUEUE(wait, current);
> +
> +       current->session = 1;
> +        current->pgrp = 1;
> +        strcpy(current->comm, "kpcmciad");
> +        current->tty = NULL;
> +        spin_lock_irq(&current->sigmask_lock);
> +        sigfillset(&current->blocked);
> +        recalc_sigpending(current);
> +        spin_unlock_irq(&current->sigmask_lock);
> +        exit_mm(current);
> +        exit_files(current);
> +        exit_sighand(current);
> +        exit_fs(current);

Replace most if not all of this crap w/ daemonize()

> +
> +       while(!event_thread_leaving) {
> +               void *active;
> +
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               add_wait_queue(&event_thread_wq, &wait);
> +
> +               /* Don't really need locking. But the implied mb() */
> +               spin_lock(&tqueue_lock);
> +               active = tq_pcmcia;
> +               spin_unlock(&tqueue_lock);
> +
> +               if (!active)
> +                       schedule();
> +
> +               set_current_state(TASK_RUNNING);
> +               remove_wait_queue(&event_thread_wq, &wait);
> +
> +               run_task_queue(&tq_pcmcia);
> +       }

it looks like the loop can be simplified to

while (1) {
	mb();
	active = tq_pcmcia;
	if (!active)
		interruptible_sleep_on(&event_thread_wq);
	if (signal_pending(current)
		break;
	run_task_queue(&tq_pcmcia);
}

> +       /* Need up_and_exit() */
> +       up(&event_thread_exit_sem);

Racy.  Use waitpid() in the thread killer instead.  You also need to
reap the process, just like in userland...


> +    /* Start the thread for handling queued events for socket drivers */
> +    kernel_thread (pcmcia_event_thread, NULL,
> +                  CLONE_FS | CLONE_FILES | CLONE_SIGHAND);

Why are you cloning _FS, _FILES, and _SIGHAND?  I don't see why the
third arg should not be zero.  man clone...


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
