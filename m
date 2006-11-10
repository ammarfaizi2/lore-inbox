Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946112AbWKJJOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946112AbWKJJOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946118AbWKJJOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:14:20 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:34484 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1946112AbWKJJOS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:14:18 -0500
Subject: Re: [PATCH -mm 3/3][AIO] - AIO completion signal notification
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Dave Jones <davej@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20061109190843.GA20321@infradead.org>
References: <1163087717.3879.34.camel@frecb000686>
	 <1163087946.3879.43.camel@frecb000686>
	 <20061109190843.GA20321@infradead.org>
Date: Fri, 10 Nov 2006 10:14:07 +0100
Message-Id: <1163150048.3879.55.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/11/2006 10:21:03,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/11/2006 10:21:05,
	Serialize complete at 10/11/2006 10:21:05
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 19:08 +0000, Christoph Hellwig wrote:
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
> 
> > +
> 
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
> 
> I don't think there's a need to have the siglock for checking PF_EXITING,
> and I also don't see why you need it for the assignment to
> iocb->ki_notify.target.  What is it intended to protect?

  Right, some remnant that managed to sneak through, will fix.

> 
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
> We leak the task reference here.

  I don't think so, the reference is dropped in really_pu_req() when
the iocb is freed, unless I missed something.

> 
> All in all aio_setup_sigevent is a big mess and the style is very odd.
> It's also overcommented on what's beeing done instead of why.
> I've attached an draft on how it should look like below.
> 
> > +	/* handle setting up the sigevent for POSIX AIO signals */
> > +	req->ki_notify.notify = SIGEV_NONE;
> > +
> > +	if (iocb->aio_sigeventp) {
> > +		ret = aio_setup_sigevent(req,
> > +				     (struct sigevent __user *)(unsigned long)
> > +				     iocb->aio_sigeventp);
> > +		if (ret)
> > +			goto out_put_req;
> > +	}
> > +
> >  	ret = aio_setup_iocb(req);
> >  
> >  	if (ret)
> > @@ -1610,6 +1729,10 @@ int fastcall io_submit_one(struct kioctx
> >  	return 0;
> >  
> >  out_put_req:
> > +	/* Undo the sigqueue alloc if someting went bad */
> > +	if (req->ki_sigq)
> > +		sigqueue_free(req->ki_sigq);
> > +
> 
> Please put this after a separate label, so only callers after
> aio_setup_sigevent try to check ki_sigq.


  Okay, cleaner that way.
> 
> 
> 
> static long aio_setup_sigevent(struct kiocb *iocb,
> 			       struct sigevent __user *user_event)
> {
> 	sigevent_t event;
> 	struct task_struct *target;
> 	unsigned long flags;
> 
> 	if (copy_from_user(&event, user_event, sizeof (event)))
> 		return -EFAULT;
> 
> 	if (event.sigev_notify == SIGEV_NONE)
> 		return 0;
> 
> 	iocb->ki_notify.notify = event.sigev_notify;
> 	iocb->ki_notify.signo = event.sigev_signo;
> 	iocb->ki_notify.value = event.sigev_value;
> 
> 	read_lock(&tasklist_lock);
> 	target = good_sigevent(&event);
> 	if (unlikely(!target || (target->flags & PF_EXITING)))
> 		goto out_unlock;
> 	iocb->ki_notify.target = target;
> 
> 	if (iocb->ki_notify.notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID)) {
> 		/*
> 		 * This reference will be dropped when we're done with
> 		 * the request.
> 		 */
> 		get_task_struct(target);
> 	}
> 	read_unlock(&tasklist_lock);
> 
> 	/*
> 	 * NOTE: we cannot free the sigqueue in the completion path as
> 	 * the signal may not have been delivered to the target task.
> 	 * Therefore it has to be freed in __sigqueue_free() when the
> 	 * signal is collected if si_code is SI_ASYNCIO.
> 	 */
> 	iocb->ki_sigq = sigqueue_alloc();
> 	if (unlikely(!iocb->ki_sigq)) {
> 		put_task_struct(target);
> 		return -EAGAIN;
> 	}
> 
> 	return 0;
>  out_unlock:
> 	read_unlock(&tasklist_lock);
> 	return -EINVAL;
> }
> 

  Cool, clearly better without taking the siglock, but again I don't 
think the put_task_struct() is needed here.

  Thanks,

  Sébastien.


