Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946814AbWKALrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946814AbWKALrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946809AbWKALrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:47:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30915 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1946814AbWKALrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:47:09 -0500
Date: Wed, 1 Nov 2006 12:47:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH -mm] swsusp: Freeze filesystems during suspend
Message-ID: <20061101114707.GA22079@atrey.karlin.mff.cuni.cz>
References: <200611011200.18438.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611011200.18438.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Freeze all filesystems during the suspend by calling freeze_bdev() for each of
> them and thaw them during the resume using thaw_bdev().
> 
> This is needed by swsusp, because some filesystems (eg. XFS) use work queues
> and worker_threads run with PF_NOFREEZE set, so they can cause some writes
> to be performed after the suspend image has been created which may corrupt
> the filesystem.  The additional benefit of it is that if the resume fails, the
> filesystems will be in a consistent state and there won't be any journal replays
> needed.
> 
> The freezing of filesystems is carried out when processes are being frozen, so
> on the majority of architectures it also will happen during a
> suspend to RAM.


> @@ -119,7 +120,7 @@ int freeze_processes(void)
>  		read_unlock(&tasklist_lock);
>  		todo += nr_user;
>  		if (!user_frozen && !nr_user) {
> -			sys_sync();
> +			freeze_filesystems();
>  			start_time = jiffies;
>  		}
>  		user_frozen = !nr_user;


Do all filesystems implement freeze? If not, we may want to keep that
sync...


> @@ -156,28 +157,43 @@ int freeze_processes(void)
>  void thaw_some_processes(int all)
>  {
>  	struct task_struct *g, *p;
> -	int pass = 0; /* Pass 0 = Kernel space, 1 = Userspace */
>  
>  	printk("Restarting tasks... ");
>  	read_lock(&tasklist_lock);
> -	do {
> -		do_each_thread(g, p) {
> -			/*
> -			 * is_user = 0 if kernel thread or borrowed mm,
> -			 * 1 otherwise.
> -			 */
> -			int is_user = !!(p->mm && !(p->flags & PF_BORROWED_MM));
> -			if (!freezeable(p) || (is_user != pass))
> -				continue;
> -			if (!thaw_process(p))
> -				printk(KERN_INFO
> -					"Strange, %s not stopped\n", p->comm);
> -		} while_each_thread(g, p);
>  
> -		pass++;
> -	} while (pass < 2 && all);
> +	do_each_thread(g, p) {
> +		if (!freezeable(p))
> +			continue;
> +
> +		/* Don't thaw userland processes, for now */
> +		if (p->mm && !(p->flags & PF_BORROWED_MM))
> +			continue;
> +
> +		if (!thaw_process(p))
> +			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
> +	} while_each_thread(g, p);
> +
> +	read_unlock(&tasklist_lock);
> +	if (!all)
> +		goto Exit;
> +
> +	thaw_filesystems();
> +	read_lock(&tasklist_lock);
> +
> +	do_each_thread(g, p) {
> +		if (!freezeable(p))
> +			continue;
> +
> +		/* Kernel threads should have been thawed already */
> +		if (!p->mm || (p->flags & PF_BORROWED_MM))
> +			continue;
> +
> +		if (!thaw_process(p))
> +			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
> +	} while_each_thread(g, p);
>  
>  	read_unlock(&tasklist_lock);
> +Exit:
>  	schedule();
>  	printk("done.\n");


Could we do without the code duplication?
>  
> +/**
> + * freeze_filesystems - lock all filesystems and force them into a consistent
> + * state
> + */
> +void freeze_filesystems(void)
> +{
> +	struct super_block *sb;
> +
> +	lockdep_off();

You should not just turn off lockdep because you don't like its
output.

Perhaps tasklist_lock does not nest with whatever freeze_bdev needs?

						Pavel
-- 
Thanks, Sharp!
