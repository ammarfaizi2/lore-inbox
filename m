Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946078AbWKJJF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946078AbWKJJF7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946092AbWKJJF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:05:58 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:16553 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1946078AbWKJJF4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:05:56 -0500
Subject: Re: [PATCH -mm 3/3][AIO] - AIO completion signal notification
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Dave Jones <davej@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <1163097975.29807.18.camel@dyn9047017100.beaverton.ibm.com>
References: <1163087717.3879.34.camel@frecb000686>
	 <1163087946.3879.43.camel@frecb000686>
	 <1163097975.29807.18.camel@dyn9047017100.beaverton.ibm.com>
Date: Fri, 10 Nov 2006 10:05:45 +0100
Message-Id: <1163149545.3879.47.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/11/2006 10:12:41,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/11/2006 10:12:42,
	Serialize complete at 10/11/2006 10:12:42
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 10:46 -0800, Badari Pulavarty wrote:
> On Thu, 2006-11-09 at 16:59 +0100, Sébastien Dugué wrote:
> 
> > +
> > +static long aio_setup_sigevent(struct kiocb *iocb,
> > +			       struct sigevent __user *user_event)
> > +{
> > +	int error = 0;
> > +	sigevent_t event;
> > +	struct task_struct *target;
> > +	unsigned long flags;
> > +
> > +	if (!access_ok(VERIFY_READ, user_event, sizeof(struct sigevent)))
> > +		return -EFAULT;
> > +
> > +	if (copy_from_user(&event, user_event, sizeof (event)))
> > +		return -EFAULT;
> > +
> > +	/* Check for the SIGEV_NONE case */
> > +	if (event.sigev_notify == SIGEV_NONE)
> > +		return 0;
> > +
> > +	/* Setup the request completion notification parameters */
> > +	iocb->ki_notify.notify = event.sigev_notify;
> > +	iocb->ki_notify.signo = event.sigev_signo;
> > +	iocb->ki_notify.value = event.sigev_value;
> > +
> > +	/* Now get the notification target */
> > +	read_lock(&tasklist_lock);
> > +
> > +	if ((target = good_sigevent(&event))) {
> > +
> > +		spin_lock_irqsave(&target->sighand->siglock, flags);
> > +
> > +		if (!(target->flags & PF_EXITING)) {
> > +			iocb->ki_notify.target = target;
> > +
> > +			spin_unlock_irqrestore(&target->sighand->siglock, flags);
> > +
> > +			/*
> > +			 * Get a ref on the task. It is dropped in really_put_req()
> > +			 * when we're done with the iocb, be it from the normal
> > +			 * completion path, the cancellation path or an error path.
> > +			 */
> > +			if (iocb->ki_notify.notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
> > +				get_task_struct(target);
> > +		} else {
> > +			spin_unlock_irqrestore(&target->sighand->siglock, flags);
> > +			error = -EINVAL;
> > +		}
> > +	} else
> > +		error = -EINVAL;
> > +
> > +	read_unlock(&tasklist_lock);
> > +
> > +	if (!error) {
> > +		/*
> > +		 * Alloc a sigqueue for this request
> > +		 *
> > +		 * NOTE: we cannot free the sigqueue in the completion path as
> > +		 * the signal may not have been delivered to the target task.
> > +		 * Therefore it has to be freed in __sigqueue_free() when the
> > +		 * signal is collected if si_code is SI_ASYNCIO.
> > +		 */
> > +		if (unlikely(!(iocb->ki_sigq = sigqueue_alloc())))
> > +			error =  -EAGAIN;
> 
> Don't you have to do put_task_struct() here ?

  Well, put_task_struct() is called in really_put_req() when we're 
freeing the request. This should be OK unless I missed something.

  Sébastien.

