Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753543AbWKISqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbWKISqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 13:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753932AbWKISqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 13:46:09 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:60576 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1753543AbWKISqH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 13:46:07 -0500
Subject: Re: [PATCH -mm 3/3][AIO] - AIO completion signal notification
From: Badari Pulavarty <pbadari@us.ibm.com>
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Dave Jones <davej@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <1163087946.3879.43.camel@frecb000686>
References: <1163087717.3879.34.camel@frecb000686>
	 <1163087946.3879.43.camel@frecb000686>
Content-Type: text/plain; charset=utf-8
Date: Thu, 09 Nov 2006 10:46:15 -0800
Message-Id: <1163097975.29807.18.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 16:59 +0100, Sébastien Dugué wrote:

> +
> +static long aio_setup_sigevent(struct kiocb *iocb,
> +			       struct sigevent __user *user_event)
> +{
> +	int error = 0;
> +	sigevent_t event;
> +	struct task_struct *target;
> +	unsigned long flags;
> +
> +	if (!access_ok(VERIFY_READ, user_event, sizeof(struct sigevent)))
> +		return -EFAULT;
> +
> +	if (copy_from_user(&event, user_event, sizeof (event)))
> +		return -EFAULT;
> +
> +	/* Check for the SIGEV_NONE case */
> +	if (event.sigev_notify == SIGEV_NONE)
> +		return 0;
> +
> +	/* Setup the request completion notification parameters */
> +	iocb->ki_notify.notify = event.sigev_notify;
> +	iocb->ki_notify.signo = event.sigev_signo;
> +	iocb->ki_notify.value = event.sigev_value;
> +
> +	/* Now get the notification target */
> +	read_lock(&tasklist_lock);
> +
> +	if ((target = good_sigevent(&event))) {
> +
> +		spin_lock_irqsave(&target->sighand->siglock, flags);
> +
> +		if (!(target->flags & PF_EXITING)) {
> +			iocb->ki_notify.target = target;
> +
> +			spin_unlock_irqrestore(&target->sighand->siglock, flags);
> +
> +			/*
> +			 * Get a ref on the task. It is dropped in really_put_req()
> +			 * when we're done with the iocb, be it from the normal
> +			 * completion path, the cancellation path or an error path.
> +			 */
> +			if (iocb->ki_notify.notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
> +				get_task_struct(target);
> +		} else {
> +			spin_unlock_irqrestore(&target->sighand->siglock, flags);
> +			error = -EINVAL;
> +		}
> +	} else
> +		error = -EINVAL;
> +
> +	read_unlock(&tasklist_lock);
> +
> +	if (!error) {
> +		/*
> +		 * Alloc a sigqueue for this request
> +		 *
> +		 * NOTE: we cannot free the sigqueue in the completion path as
> +		 * the signal may not have been delivered to the target task.
> +		 * Therefore it has to be freed in __sigqueue_free() when the
> +		 * signal is collected if si_code is SI_ASYNCIO.
> +		 */
> +		if (unlikely(!(iocb->ki_sigq = sigqueue_alloc())))
> +			error =  -EAGAIN;

Don't you have to do put_task_struct() here ?

> +	}
> +
> +
> +	return error;
> +}
> +

Thanks,
Badari

