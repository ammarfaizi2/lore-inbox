Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUGVXRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUGVXRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 19:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267369AbUGVXRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 19:17:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:56969 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267368AbUGVXRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 19:17:39 -0400
Date: Thu, 22 Jul 2004 19:16:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [announce] HVCS for inclusion in 2.6 tree
Message-Id: <20040722191637.52ab515a.akpm@osdl.org>
In-Reply-To: <1090528007.3161.7.camel@localhost>
References: <1089819720.3385.66.camel@localhost>
	<16633.55727.513217.364467@cargo.ozlabs.ibm.com>
	<1090528007.3161.7.camel@localhost>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Arnold <rsa@us.ibm.com> wrote:
>
> hvcs_to_mainline_draft2.patch  text/x-patch (80516 bytes)
>
> +int khvcsd(void *unused)
> +{
> +	struct hvcs_struct *hvcsd = NULL;
> +	struct list_head *element;
> +	struct list_head *safe_temp;
> +	int hvcs_todo_mask;
> +
> +	daemonize("khvcsd");
> +
> +	allow_signal(SIGTERM);
> +
> +	do {
> +		wait_queue_t wait = __WAITQUEUE_INITIALIZER(wait, current);
> +		hvcs_todo_mask = 0;
> +		hvcs_kicked = 0;
> +		wmb();
> +		list_for_each_safe(element, safe_temp, &hvcs_structs) {
> +			hvcsd = list_entry(element, struct hvcs_struct, next);
> +				hvcs_todo_mask |= hvcs_io(hvcsd);
> +		}
> +
> +		/* If any of the hvcs adapters want to try a write or quick read
> +		 * don't schedule(), yield a smidgen then execute the hvcs_io
> +		 * thread again for those that want the write. */
> +		 if (hvcs_todo_mask & (HVCS_TRY_WRITE | HVCS_QUICK_READ)) {
> +			yield();                 
> +			continue;
> +		}
> +
> +		add_wait_queue(&hvcs_wait_queue, &wait);
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		if (!hvcs_kicked)
> +			schedule();
> +		set_current_state(TASK_RUNNING);
> +		remove_wait_queue(&hvcs_wait_queue, &wait);
> +
> +	} while (!signal_pending(current));
> +
> +	complete_and_exit(&hvcs_exited,0);
> +}
>
 
I'm not a big fan of using signals for in-kernel IPC.  (What happens if
root accidentally does `kill -TERM $(pidof khvcsd)', btw?) And daemonize()
is deprecated.

It should be possible to use the kthread infrastructure here - it does most
of this stuff for you.  Use kthread_stop() in the killer and
kthread_should_stop() within khvcsd().  kthread_stop() is synchronous, so
you don't need to do the complete() stuff here.

It should not be necessary to re-add to the wait queue head on each pass
around the loop.

khvcsd() can have static scope.


