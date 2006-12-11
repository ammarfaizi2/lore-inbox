Return-Path: <linux-kernel-owner+w=401wt.eu-S937116AbWLKQdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937116AbWLKQdG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936365AbWLKQdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:33:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:28186 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937119AbWLKQdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:33:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MZJsr3K2kCqi7WcO3kdK7VGbI2uz5WxcLa929v13hUEjkKHki2iNE7KqptDWlnnFOXkKrSQhx6/pFRdRI1VyoTpCsZVeG5JIoz5fPgw/gfmOQuYfdShh/wPhGWDZ+uCwtNf+79H5o1VMR+7PfaSIg/ef/fvZsNCXs0nMr6mf7a0=
Message-ID: <3f250c710612110832i337470cyc1fe0805a8aba2e6@mail.gmail.com>
Date: Mon, 11 Dec 2006 12:32:55 -0400
From: "Mauricio Lin" <mauriciolin@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [take26-resend1 7/8] kevent: Signal notifications.
Cc: "David Miller" <davem@davemloft.net>,
       "Ulrich Drepper" <drepper@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, "Zach Brown" <zach.brown@oracle.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Chase Venters" <chase.venters@clientec.com>,
       "Johann Borck" <johann.borck@densedata.com>,
       linux-kernel@vger.kernel.org, "Jeff Garzik" <jeff@garzik.org>
In-Reply-To: <11658486191971@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <116584861971@2ka.mipt.ru> <11658486191971@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeniy,

I have used kobject_uevent() to notify userspace about some events.
For instance, when memory comsumption reaches a predefined watermark,
a signal is sent to userspace to allow applications to free resources.
But I am not sure if kobject_uevent() is the more appropriate way for
that since if I have many different levels of notifications (using
kobject_uevent()) from kernel space to user space, so how the
application could know or differentiate from which level of kernel
notification the signal was sent from?

The application should perform a specific task according to different
type of received notification. So I do not know if the current kernel
provides something like that. Do you know any current kernel (2.6.19)
implementation for that?

After reading about your Kevent implementation, I guess that your
patches are able to do what I need, right? Will it be included in the
mainline kernel? Do you have examples about how can I use your socket
and/or signal notifications to establish kernel and user space
communication?

BR,

Mauricio Lin.

On 12/11/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> Signal notifications.
>
> This type of notifications allows to deliver signals through kevent queue.
> One can find example application signal.c on project homepage.
>
> If KEVENT_SIGNAL_NOMASK bit is set in raw_u64 id then signal will be
> delivered only through queue, otherwise both delivery types are used - old
> through update of mask of pending signals and through queue.
>
> If signal is delivered only through kevent queue mask of pending signals
> is not updated at all, which is equal to putting signal into blocked mask,
> but with delivery of that signal through kevent queue.
>
> Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
>
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index fc4a987..ef38a3c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -80,6 +80,7 @@ struct sched_param {
>  #include <linux/resource.h>
>  #include <linux/timer.h>
>  #include <linux/hrtimer.h>
> +#include <linux/kevent_storage.h>
>
>  #include <asm/processor.h>
>
> @@ -1013,6 +1014,10 @@ struct task_struct {
>  #ifdef CONFIG_TASK_DELAY_ACCT
>         struct task_delay_info *delays;
>  #endif
> +#ifdef CONFIG_KEVENT_SIGNAL
> +       struct kevent_storage st;
> +       u32 kevent_signals;
> +#endif
>  };
>
>  static inline pid_t process_group(struct task_struct *tsk)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1c999f3..e5b5b14 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -46,6 +46,7 @@
>  #include <linux/delayacct.h>
>  #include <linux/taskstats_kern.h>
>  #include <linux/random.h>
> +#include <linux/kevent.h>
>
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -115,6 +116,9 @@ void __put_task_struct(struct task_struct *tsk)
>         WARN_ON(atomic_read(&tsk->usage));
>         WARN_ON(tsk == current);
>
> +#ifdef CONFIG_KEVENT_SIGNAL
> +       kevent_storage_fini(&tsk->st);
> +#endif
>         security_task_free(tsk);
>         free_uid(tsk->user);
>         put_group_info(tsk->group_info);
> @@ -1121,6 +1125,10 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>         if (retval)
>                 goto bad_fork_cleanup_namespace;
>
> +#ifdef CONFIG_KEVENT_SIGNAL
> +       kevent_storage_init(p, &p->st);
> +#endif
> +
>         p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? child_tidptr : NULL;
>         /*
>          * Clear TID on mm_release()?
> diff --git a/kernel/kevent/kevent_signal.c b/kernel/kevent/kevent_signal.c
> new file mode 100644
> index 0000000..0edd2e4
> --- /dev/null
> +++ b/kernel/kevent/kevent_signal.c
> @@ -0,0 +1,92 @@
> +/*
> + *     kevent_signal.c
> + *
> + * 2006 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> + * All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/kevent.h>
> +
> +static int kevent_signal_callback(struct kevent *k)
> +{
> +       struct task_struct *tsk = k->st->origin;
> +       int sig = k->event.id.raw[0];
> +       int ret = 0;
> +
> +       if (sig == tsk->kevent_signals)
> +               ret = 1;
> +
> +       if (ret && (k->event.id.raw_u64 & KEVENT_SIGNAL_NOMASK))
> +               tsk->kevent_signals |= 0x80000000;
> +
> +       return ret;
> +}
> +
> +int kevent_signal_enqueue(struct kevent *k)
> +{
> +       int err;
> +
> +       err = kevent_storage_enqueue(&current->st, k);
> +       if (err)
> +               goto err_out_exit;
> +
> +       if (k->event.req_flags & KEVENT_REQ_ALWAYS_QUEUE) {
> +               kevent_requeue(k);
> +               err = 0;
> +       } else {
> +               err = k->callbacks.callback(k);
> +               if (err)
> +                       goto err_out_dequeue;
> +       }
> +
> +       return err;
> +
> +err_out_dequeue:
> +       kevent_storage_dequeue(k->st, k);
> +err_out_exit:
> +       return err;
> +}
> +
> +int kevent_signal_dequeue(struct kevent *k)
> +{
> +       kevent_storage_dequeue(k->st, k);
> +       return 0;
> +}
> +
> +int kevent_signal_notify(struct task_struct *tsk, int sig)
> +{
> +       tsk->kevent_signals = sig;
> +       kevent_storage_ready(&tsk->st, NULL, KEVENT_SIGNAL_DELIVERY);
> +       return (tsk->kevent_signals & 0x80000000);
> +}
> +
> +static int __init kevent_init_signal(void)
> +{
> +       struct kevent_callbacks sc = {
> +               .callback = &kevent_signal_callback,
> +               .enqueue = &kevent_signal_enqueue,
> +               .dequeue = &kevent_signal_dequeue};
> +
> +       return kevent_add_callbacks(&sc, KEVENT_SIGNAL);
> +}
> +module_init(kevent_init_signal);
> diff --git a/kernel/signal.c b/kernel/signal.c
> index fb5da6d..d3d3594 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -23,6 +23,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/signal.h>
>  #include <linux/capability.h>
> +#include <linux/kevent.h>
>  #include <asm/param.h>
>  #include <asm/uaccess.h>
>  #include <asm/unistd.h>
> @@ -703,6 +704,9 @@ static int send_signal(int sig, struct siginfo *info, struct task_struct *t,
>  {
>         struct sigqueue * q = NULL;
>         int ret = 0;
> +
> +       if (kevent_signal_notify(t, sig))
> +               return 1;
>
>         /*
>          * fast-pathed signals for kernel-internal things like SIGSTOP
> @@ -782,6 +786,17 @@ specific_send_sig_info(int sig, struct siginfo *info, struct task_struct *t)
>         ret = send_signal(sig, info, t, &t->pending);
>         if (!ret && !sigismember(&t->blocked, sig))
>                 signal_wake_up(t, sig == SIGKILL);
> +#ifdef CONFIG_KEVENT_SIGNAL
> +       /*
> +        * Kevent allows to deliver signals through kevent queue,
> +        * it is possible to setup kevent to not deliver
> +        * signal through the usual way, in that case send_signal()
> +        * returns 1 and signal is delivered only through kevent queue.
> +        * We simulate successfull delivery notification through this hack:
> +        */
> +       if (ret == 1)
> +               ret = 0;
> +#endif
>  out:
>         return ret;
>  }
> @@ -971,6 +986,17 @@ __group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
>          * to avoid several races.
>          */
>         ret = send_signal(sig, info, p, &p->signal->shared_pending);
> +#ifdef CONFIG_KEVENT_SIGNAL
> +       /*
> +        * Kevent allows to deliver signals through kevent queue,
> +        * it is possible to setup kevent to not deliver
> +        * signal through the usual way, in that case send_signal()
> +        * returns 1 and signal is delivered only through kevent queue.
> +        * We simulate successfull delivery notification through this hack:
> +        */
> +       if (ret == 1)
> +               ret = 0;
> +#endif
>         if (unlikely(ret))
>                 return ret;
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
