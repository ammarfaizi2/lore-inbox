Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUDZXlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUDZXlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 19:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbUDZXlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 19:41:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:28855 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263147AbUDZXj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 19:39:58 -0400
Date: Mon, 26 Apr 2004 16:39:55 -0700
From: Chris Wright <chrisw@osdl.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
Message-ID: <20040426163955.X21045@build.pdx.osdl.net>
References: <Pine.SGI.4.53.0404261656230.591647@subway.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SGI.4.53.0404261656230.591647@subway.americas.sgi.com>; from erikj@subway.americas.sgi.com on Mon, Apr 26, 2004 at 05:04:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Erik Jacobson (erikj@subway.americas.sgi.com) wrote:
> Here, I am proposing Process Aggregates support for the 2.6 kernel.

This looks like it's just the infrastructure, i.e. nothing is using it.
It seems like PAGG could be done on top of CKRM (albeit, with more
code).  But if the goal is to do some basic accounting, scheduling, etc.
on a resource group, wouldn't CKRM be more generic?

Couple quick comments below.

> +struct pagg_hook {
> +       struct module	*module;

doesn't seem used.

> +       char		*name;	/* Name Key - restricted to 32 characters */

why the restriction?  

> +#define attach_pagg_list_chk(ct, pt)					\
> +do {									\
> +	INIT_PAGG_LIST(&ct->pagg_list);					\
> +	if (!list_empty(&pt->pagg_list.head)) {				\
> +		if (attach_pagg_list(ct, pt) != 0)			\
> +			goto bad_fork_cleanup;				\
> +	}								\
> +} while(0)

Goto a label defined elsewhere, buried in a macro.  Please code this
openly.

> +#define detach_pagg_list_chk(t)					\
> +do {									\
> +	if (!list_empty(&t->pagg_list.head)) {				\
> +		detach_pagg_list(t);					\
> +	}								\
> +} while(0)

All these macros could be type safe inlined functions, and when config'd
off, use your alt. no-op macros.

> +#define read_lock_pagg_list(t)		down_read(&t->pagg_list.sem)
> +	/* Up the read semaphore for the task's pagg_list */
> +#define read_unlock_pagg_list(t) 	up_read(&t->pagg_list.sem)
> +	/* Down the write semaphore for the task's pagg_list */
> +#define write_lock_pagg_list(t)		down_write(&t->pagg_list.sem)
> +	/* Up the write semaphore for the task's pagg_list */
> +#define write_unlock_pagg_list(t) 	up_write(&t->pagg_list.sem)

Just open code these.  There's too much hidden in macros.

> @@ -488,11 +489,15 @@
>  
>  	struct dentry *proc_dentry;
>  	struct backing_dev_info *backing_dev_info;
> -
>  	struct io_context *io_context;
>  
>  	unsigned long ptrace_message;
>  	siginfo_t *last_siginfo; /* For ptrace use.  */
> +
> +#if defined(CONFIG_PAGG)
> +/* List of pagg (process aggregate) attachments */
> +	struct pagg_list pagg_list;
> +#endif

unused?

> +unregister_pagg_hook(struct pagg_hook *pagg_hook_old)
<snip>
> +	down_write(&pagg_hook_list_sem);
> +
> +	pagg_hook = get_pagg_hook(pagg_hook_old->name);
> +	if (pagg_hook && pagg_hook == pagg_hook_old) {
> +		/* 
> +		 * Scan through processes on system and check for  
> +		 * references to pagg containers for this pagg hook.
> +		 * 
> +		 * The module cannot be unloaded if there are references.
> +		 */
> +		read_lock(&tasklist_lock);
> +		for_each_process(task) {
> +			struct pagg *pagg = NULL;
> +
> +			read_lock_pagg_list(task);

Uh-oh, grabbing a semaphore while holding tasklist_lock.

There's too much hidden in macros (like read_lock_pagg_list).

> +attach_pagg_list(struct task_struct *to_task, struct task_struct *from_task)
<snip>
> +		to_pagg = alloc_pagg(to_task, from_pagg->hook);
> +		if (!to_pagg) {
> +			retcode = -ENOMEM;
> +			goto error_return;
> +		}
> +		retcode = attach_pagg(to_task, to_pagg, from_pagg->data);
> +		if (retcode != 0) {
> +			/* attach should issue error message */
> +			goto error_return;
> +		}

This looks like it leaks the just alloc'd to_pagg.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
