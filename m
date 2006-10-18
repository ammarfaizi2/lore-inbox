Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422690AbWJRQ4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422690AbWJRQ4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422694AbWJRQ4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:56:13 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:46540 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1422690AbWJRQ4M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:56:12 -0400
Date: Wed, 18 Oct 2006 20:55:58 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Prarit Bhargava <prarit@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH] ->signal->tty locking
Message-ID: <20061018165558.GA2062@oleg>
References: <1160992420.22727.14.camel@taijtu> <20061017081018.GA115@oleg> <1161080221.3036.38.camel@taijtu> <20061017123307.GA209@oleg> <1161090004.3036.43.camel@taijtu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161090004.3036.43.camel@taijtu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17, Peter Zijlstra wrote:
>
> How about something like this; I'm still shaky on the lifetime rules of
> tty objects, I'm about to add a refcount and spinlock/mutex to
> tty_struct, this is madness....

Sorry for delay, a couple of minor nits...

>  static void do_tty_hangup(void *data)
>  {
> @@ -1355,14 +1355,18 @@ static void do_tty_hangup(void *data)
>  	read_lock(&tasklist_lock);
>  	if (tty->session > 0) {
>  		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
> +			spin_lock_irq(&p->sighand->siglock);
>  			if (p->signal->tty == tty)
>  				p->signal->tty = NULL;
> -			if (!p->signal->leader)
> +			if (!p->signal->leader) {
> +				spin_unlock_irq(&p->sighand->siglock);
>  				continue;
> -			group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
> -			group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
> +			}
> +			__group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
> +			__group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);

So we are skipping security_task_kill() and audit_signal_info().
I don't claim this is bad, I just don't know.

> @@ -2899,6 +2919,7 @@ static int tiocsctty(struct tty_struct *
>  	 */
>  	if (!current->signal->leader || current->signal->tty)
>  		return -EPERM;
> +	mutex_lock(&tty_mutex);

This is still racy (consider 2 threads doing tiocsctty() at the same time),
probably it is better to take tty_mutex before the check?

> --- linux-2.6.18.noarch.orig/include/linux/tty.h
> +++ linux-2.6.18.noarch/include/linux/tty.h
> @@ -338,5 +338,33 @@ static inline dev_t tty_devnum(struct tt
>  	return MKDEV(tty->driver->major, tty->driver->minor_start) + tty->index;
>  }
>  
> +static inline void proc_set_tty(struct task_struct *p, struct tty_struct *tty)
> +{
> +	spin_lock_irq(&p->sighand->siglock);
> +	p->signal->tty = tty;
> +	spin_unlock_irq(&p->sighand->siglock);
> +}

Note that it is always called with tty == NULL parameter. That is why
I proposed proc_clear_tty(struct task_struct *p). We can't use this
helper for tiocsctty/tty_open anyway.

> +static inline void session_clear_tty(pid_t session)
> +{
> +	struct task_struct *p;
> +	do_each_task_pid(session, PIDTYPE_SID, p) {
> +		proc_set_tty(p, NULL);
> +	} while_each_task_pid(session, PIDTYPE_SID, p);
> +}
> +

I'd suggest to move it to tty_io.c and make it static (not inline).

> ===================================================================
> --- linux-2.6.18.noarch.orig/security/selinux/hooks.c
> +++ linux-2.6.18.noarch/security/selinux/hooks.c
> @@ -1708,9 +1708,10 @@ static inline void flush_unauthorized_fi
>  	struct tty_struct *tty;
>  	struct fdtable *fdt;
>  	long j = -1;
> +	int drop_tty = 0;
>  
>  	mutex_lock(&tty_mutex);
> -	tty = current->signal->tty;
> +	tty = current_get_tty();
>  	if (tty) {
>  		file_list_lock();
>  		file = list_entry(tty->tty_files.next, typeof(*file), f_u.fu_list);
> @@ -1723,12 +1724,18 @@ static inline void flush_unauthorized_fi
>  			struct inode *inode = file->f_dentry->d_inode;
>  			if (inode_has_perm(current, inode,
>  					   FILE__READ | FILE__WRITE, NULL)) {
> -				/* Reset controlling tty. */
> -				current->signal->tty = NULL;
> -				current->signal->tty_old_pgrp = 0;
> +				drop_tty = 1;
>  			}
>  		}
>  		file_list_unlock();
> +
> +		if (drop_tty) {
> +			/* Reset controlling tty. */
> +			spin_lock_irq(&current->sighand->siglock);
> +			current->signal->tty = NULL;
> +			current->signal->tty_old_pgrp = 0;

Probably the last line should go to proc_clear_tty() ?

On the other hand, when signal->tty != NULL, ->tty_old_pgrp
should be == 0, may be it is unneeded.

In any case, I think we should use proc_set_tty() here.

Oleg.

