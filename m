Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129079AbQKMPGf>; Mon, 13 Nov 2000 10:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKMPGQ>; Mon, 13 Nov 2000 10:06:16 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29956 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129079AbQKMPF5>;
	Mon, 13 Nov 2000 10:05:57 -0500
Message-ID: <3A10031B.79D8A9B5@mandrakesoft.com>
Date: Mon, 13 Nov 2000 10:04:59 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: torvalds@transmeta.com, dhinds@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <3A0FF138.A510B45@mandrakesoft.com>  <7572.974120930@redhat.com> <20554.974126251@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> jgarzik@mandrakesoft.com said:
> > Racy.  Use waitpid() in the thread killer instead.
> 
> Doesn't waitpid() require the thread we're waiting for to be child of the
> rmmod process? I suppose we could arrange that, but it's not particularly
> clean.

Doh, totally forgot about that.  Will this work:

	save_current = current;
	current = find_task_by_pid(1);
	waitpid(...);
	current = save_current;

In any case, we -really- need a wait_for_kernel_thread_to_die()
function.


> jgarzik@mandrakesoft.com said:
> > Why are you cloning _FS, _FILES, and _SIGHAND?  I don't see why the
> > third arg should not be zero.  man clone...
> 
> If we don't specify CLONE_FS | CLONE_FILES | CLONE_SIGHAND then new ones
> get allocated just for us to free them again immediately. If we clone them,
> then we just increase and decrease the use counts of the parent's ones. The
> latter is slightly more efficient, and I don't think it really matters. If
> you really care, that can be changed. I've dropped CLONE_SIGHAND because
> daemonize() doesn't free that, but left CLONE_FS and CLONE_FILES.

Cool tip, thanks.


> +        spin_lock_irq(&current->sigmask_lock);
> +        sigfillset(&current->blocked);
> +        recalc_sigpending(current);
> +        spin_unlock_irq(&current->sigmask_lock);

what does this do?


> +    /* Start the thread for handling queued events for socket drivers */
> +    event_thread_pid = kernel_thread (pcmcia_event_thread, NULL, CLONE_FS | CLONE_FILES);
> +
> +    if (event_thread_pid < 0) {
> +           printk(KERN_ERR "init_pcmcia_cs: fork failed: errno %d\n", -event_thread_pid);
> +           return event_thread_pid;
> +    }

why do you store the event_thread_pid but never use it?

regards,

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
