Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUBPW5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUBPWzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:55:07 -0500
Received: from galileo.bork.org ([66.11.174.156]:53381 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S265965AbUBPWy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:54:29 -0500
Date: Mon, 16 Feb 2004 17:54:27 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][2.6-mm] kernel/kmod.c kernel/kthread.c NR_CPUS fixes
Message-ID: <20040216225427.GF12142@localhost>
References: <Pine.LNX.4.58.0402161701240.11793@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402161701240.11793@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm...I sent a similar patch to Andrew a couple hours ago.  I was really
hoping there was a nicer way to fix this.

mh

On Mon, Feb 16, 2004 at 05:43:08PM -0500, Zwane Mwaikambo wrote:
> Needed to compile with high NR_CPUS, Rusty try not to cringe too much =)
> 
> Index: linux-2.6.3-rc3-mm1-test/kernel/kmod.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.3-rc3-mm1/kernel/kmod.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 kmod.c
> --- linux-2.6.3-rc3-mm1-test/kernel/kmod.c	16 Feb 2004 20:42:49 -0000	1.1.1.1
> +++ linux-2.6.3-rc3-mm1-test/kernel/kmod.c	16 Feb 2004 21:40:49 -0000
> @@ -148,6 +148,7 @@ struct subprocess_info {
>   */
>  static int ____call_usermodehelper(void *data)
>  {
> +	const cpumask_t mask = CPU_MASK_ALL;
>  	struct subprocess_info *sub_info = data;
>  	int retval;
> 
> @@ -160,7 +161,7 @@ static int ____call_usermodehelper(void
>  	spin_unlock_irq(&current->sighand->siglock);
> 
>  	/* We can run anywhere, unlike our parent keventd(). */
> -	set_cpus_allowed(current, CPU_MASK_ALL);
> +	set_cpus_allowed(current, mask);
>  	retval = -EPERM;
>  	if (current->fs->root)
>  		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
> Index: linux-2.6.3-rc3-mm1-test/kernel/kthread.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.3-rc3-mm1/kernel/kthread.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 kthread.c
> --- linux-2.6.3-rc3-mm1-test/kernel/kthread.c	16 Feb 2004 20:42:49 -0000	1.1.1.1
> +++ linux-2.6.3-rc3-mm1-test/kernel/kthread.c	16 Feb 2004 21:43:40 -0000
> @@ -29,6 +29,7 @@ struct kthread_create_info
>  /* Returns so that WEXITSTATUS(ret) == errno. */
>  static int kthread(void *_create)
>  {
> +	const cpumask_t mask = CPU_MASK_ALL;
>  	struct kthread_create_info *create = _create;
>  	int (*threadfn)(void *data);
>  	void *data;
> @@ -45,7 +46,7 @@ static int kthread(void *_create)
>  	flush_signals(current);
> 
>  	/* By default we can run anywhere, unlike keventd. */
> -	set_cpus_allowed(current, CPU_MASK_ALL);
> +	set_cpus_allowed(current, mask);
> 
>  	/* OK, tell user we're spawned, wait for stop or wakeup */
>  	__set_current_state(TASK_INTERRUPTIBLE);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296
