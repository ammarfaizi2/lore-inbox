Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbWBEJje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbWBEJje (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 04:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWBEJje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 04:39:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54405 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751691AbWBEJjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 04:39:33 -0500
Date: Sun, 5 Feb 2006 01:38:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, nigel@suspend2.net
Subject: Re: [PATCH -mm] swsusp: freeze user space processes first
Message-Id: <20060205013859.60a6e5ab.akpm@osdl.org>
In-Reply-To: <200602051014.43938.rjw@sisk.pl>
References: <200602051014.43938.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Hi,
> 
> This patch allows swsusp to freeze processes successfully under heavy load
> by freezing userspace processes before kernel threads.
> 
> ...
>
>  /* 0 = success, else # of processes that we failed to stop */
>  int freeze_processes(void)
>  {
> -	int todo;
> +	int todo, nr_user, user_frozen;
>  	unsigned long start_time;
>  	struct task_struct *g, *p;
>  	unsigned long flags;
>  
>  	printk( "Stopping tasks: " );
>  	start_time = jiffies;
> +	user_frozen = 0;
>  	do {
> -		todo = 0;
> +		nr_user = todo = 0;
>  		read_lock(&tasklist_lock);
>  		do_each_thread(g, p) {
>  			if (!freezeable(p))
>  				continue;
>  			if (frozen(p))
>  				continue;
> -
> -			freeze(p);
> -			spin_lock_irqsave(&p->sighand->siglock, flags);
> -			signal_wake_up(p, 0);
> -			spin_unlock_irqrestore(&p->sighand->siglock, flags);
> -			todo++;
> +			if (p->mm && !(p->flags & PF_BORROWED_MM)) {
> +				/* The task is a user-space one.
> +				 * Freeze it unless there's a vfork completion
> +				 * pending
> +				 */
> +				if (!p->vfork_done)
> +					freeze_process(p);
> +				nr_user++;
> +			} else {
> +				/* Freeze only if the user space is frozen */
> +				if (user_frozen)
> +					freeze_process(p);
> +				todo++;
> +			}
>  		} while_each_thread(g, p);
>  		read_unlock(&tasklist_lock);
> +		todo += nr_user;
> +		if (!user_frozen && !nr_user) {
> +			sys_sync();
> +			start_time = jiffies;
> +		}
> +		user_frozen = !nr_user;
>  		yield();			/* Yield is okay here */
> -		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
> -			printk( "\n" );
> -			printk(KERN_ERR " stopping tasks timed out (%d tasks remaining)\n", todo );
> +		if (todo && time_after(jiffies, start_time + TIMEOUT))
>  			break;

The logic in that loop makes my brain burst.

What happens if a process does vfork();sleep(100000000)?

