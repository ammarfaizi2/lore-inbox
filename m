Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270480AbUJTTu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270480AbUJTTu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270476AbUJTTuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:50:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:405 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269156AbUJTTpa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:45:30 -0400
Date: Wed, 20 Oct 2004 20:45:22 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Matthew Wilcox <matthew@wil.cx>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] lockd: replace semaphore, sleep_on
Message-ID: <20041020194522.GX16153@parcelfarce.linux.theplanet.co.uk>
References: <1098299743.20821.54.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098299743.20821.54.camel@thomas>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not really my area, you want to ask Trond about this.

On Wed, Oct 20, 2004 at 09:15:43PM +0200, Thomas Gleixner wrote:
> 
> Use wait_event, completion instead of the obsolete sleep_on functions
> and the abused semaphore
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Ingo Molnar <mingo@elte.hu>
> ---
> 
>  2.6.9-bk-041020-thomas/fs/lockd/clntlock.c |   12 +++++++-----
>  2.6.9-bk-041020-thomas/fs/lockd/svc.c      |   23
> +++++++++++++----------
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff -puN fs/lockd/svc.c~lockd fs/lockd/svc.c
> --- 2.6.9-bk-041020/fs/lockd/svc.c~lockd	2004-10-20 15:56:52.000000000
> +0200
> +++ 2.6.9-bk-041020-thomas/fs/lockd/svc.c	2004-10-20 15:56:52.000000000
> +0200
> @@ -46,7 +46,7 @@ static pid_t			nlmsvc_pid;
>  int				nlmsvc_grace_period;
>  unsigned long			nlmsvc_timeout;
>  
> -static DECLARE_MUTEX_LOCKED(lockd_start);
> +static DECLARE_WAIT_QUEUE_HEAD(lockd_start);
>  static DECLARE_WAIT_QUEUE_HEAD(lockd_exit);
>  
>  /*
> @@ -109,7 +109,7 @@ lockd(struct svc_rqst *rqstp)
>  	 * Let our maker know we're running.
>  	 */
>  	nlmsvc_pid = current->pid;
> -	up(&lockd_start);
> +	wake_up(&lockd_start);
>  
>  	daemonize("lockd");
>  
> @@ -258,8 +258,15 @@ lockd_up(void)
>  			"lockd_up: create thread failed, error=%d\n", error);
>  		goto destroy_and_out;
>  	}
> -	down(&lockd_start);
> -
> +	/*
> +	 * Wait for the lockd process to start, but since we're holding
> +	 * the lockd semaphore, we can't wait around forever ...
> +	 */
> +	if (wait_event_interruptible_timeout(lockd_start,
> +					nlmsvc_pid != 0, HZ) <= 0) {
> +		printk(KERN_WARNING
> +			"lockd_down: lockd failed to start\n");
> +	}
>  	/*
>  	 * Note: svc_serv structures have an initial use count of 1,
>  	 * so we exit through here on both success and failure.
> @@ -298,16 +305,12 @@ lockd_down(void)
>  	 * Wait for the lockd process to exit, but since we're holding
>  	 * the lockd semaphore, we can't wait around forever ...
>  	 */
> -	clear_thread_flag(TIF_SIGPENDING);
> -	interruptible_sleep_on_timeout(&lockd_exit, HZ);
> -	if (nlmsvc_pid) {
> +	if (wait_event_interruptible_timeout(lockd_exit,
> +					nlmsvc_pid == 0, HZ) <= 0) {
>  		printk(KERN_WARNING 
>  			"lockd_down: lockd failed to exit, clearing pid\n");
>  		nlmsvc_pid = 0;
>  	}
> -	spin_lock_irq(&current->sighand->siglock);
> -	recalc_sigpending();
> -	spin_unlock_irq(&current->sighand->siglock);
>  out:
>  	up(&nlmsvc_sema);
>  }
> diff -puN fs/lockd/clntlock.c~lockd fs/lockd/clntlock.c
> --- 2.6.9-bk-041020/fs/lockd/clntlock.c~lockd	2004-10-20
> 15:56:52.000000000 +0200
> +++ 2.6.9-bk-041020-thomas/fs/lockd/clntlock.c	2004-10-20
> 15:56:52.000000000 +0200
> @@ -6,6 +6,7 @@
>   * Copyright (C) 1996, Olaf Kirch <okir@monad.swb.de>
>   */
>  
> +#include <linux/completion.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/time.h>
> @@ -32,7 +33,7 @@ static int			reclaimer(void *ptr);
>   */
>  struct nlm_wait {
>  	struct nlm_wait *	b_next;		/* linked list */
> -	wait_queue_head_t	b_wait;		/* where to wait on */
> +	struct completion	b_wait;		/* where to wait on */
>  	struct nlm_host *	b_host;
>  	struct file_lock *	b_lock;		/* local file lock */
>  	unsigned short		b_reclaim;	/* got to reclaim lock */
> @@ -53,7 +54,7 @@ nlmclnt_block(struct nlm_host *host, str
>  
>  	block.b_host   = host;
>  	block.b_lock   = fl;
> -	init_waitqueue_head(&block.b_wait);
> +	init_completion(&block.b_wait);
>  	block.b_status = NLM_LCK_BLOCKED;
>  	block.b_next   = nlm_blocked;
>  	nlm_blocked    = &block;
> @@ -69,7 +70,8 @@ nlmclnt_block(struct nlm_host *host, str
>  	 * a 1 minute timeout would do. See the comment before
>  	 * nlmclnt_lock for an explanation.
>  	 */
> -	sleep_on_timeout(&block.b_wait, 30*HZ);
> +
> +	wait_for_completion_timeout(&block.b_wait, 30*HZ);
>  
>  	for (head = &nlm_blocked; *head; head = &(*head)->b_next) {
>  		if (*head == &block) {
> @@ -118,7 +120,7 @@ nlmclnt_grant(struct nlm_lock *lock)
>  	 * wake up the caller.
>  	 */
>  	block->b_status = NLM_LCK_GRANTED;
> -	wake_up(&block->b_wait);
> +	complete(&block->b_wait);
>  
>  	return nlm_granted;
>  }
> @@ -233,7 +235,7 @@ restart:
>  	for (block = nlm_blocked; block; block = block->b_next) {
>  		if (block->b_host == host) {
>  			block->b_status = NLM_LCK_DENIED_GRACE_PERIOD;
> -			wake_up(&block->b_wait);
> +			complete(&block->b_wait);
>  		}
>  	}
>  
> _
> 
> 

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
