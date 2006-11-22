Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966980AbWKVBDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966980AbWKVBDL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 20:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966981AbWKVBDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 20:03:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:19869 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966980AbWKVBDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 20:03:10 -0500
Date: Tue, 21 Nov 2006 17:02:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 3/4][AIO] - AIO completion signal notification
Message-Id: <20061121170228.4412b572.akpm@osdl.org>
In-Reply-To: <20061120152252.7e5a4229@frecb000686>
References: <20061120151700.4a4f9407@frecb000686>
	<20061120152252.7e5a4229@frecb000686>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 15:22:52 +0100
S__bastien Dugu__ <sebastien.dugue@bull.net> wrote:

> +static long aio_setup_sigevent(struct aio_notify *notify,
> +			       struct sigevent __user *user_event)
> +{
> +	sigevent_t event;
> +	struct task_struct *target;
> +
> +	if (copy_from_user(&event, user_event, sizeof (event)))
> +		return -EFAULT;
> +
> +	if (event.sigev_notify == SIGEV_NONE)
> +		return 0;
> +
> +	notify->notify = event.sigev_notify;
> +	notify->signo = event.sigev_signo;
> +	notify->value = event.sigev_value;
> +
> +	read_lock(&tasklist_lock);
> +	target = good_sigevent(&event);
> +
> +	if (unlikely(!target || (target->flags & PF_EXITING)))
> +		goto out_unlock;
> +
> +	notify->target = target;
> +
> +	if (notify->notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID)) {
> +		/*
> +		 * This reference will be dropped in really_put_req() when
> +		 * we're done with the request.
> +		 */
> +		get_task_struct(target);
> +	}

It worries me that this function can save away a task_struct* without
having taken a reference against it.


> +	read_unlock(&tasklist_lock);
> +
> +	/*
> +	 * NOTE: we cannot free the sigqueue in the completion path as
> +	 * the signal may not have been delivered to the target task.
> +	 * Therefore it has to be freed in __sigqueue_free() when the
> +	 * signal is collected if si_code is SI_ASYNCIO.
> +	 */
> +	notify->sigq = sigqueue_alloc();
> +
> +	if (unlikely(!notify->sigq))
> +		return -EAGAIN;
> +
> +	return 0;
> +
> +out_unlock:
> +	read_unlock(&tasklist_lock);
> +	return -EINVAL;
> +}
