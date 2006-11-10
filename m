Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946134AbWKJJVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946134AbWKJJVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946145AbWKJJVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:21:03 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:29884 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1946134AbWKJJVB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:21:01 -0500
Subject: Re: [PATCH -mm 3/3][AIO] - AIO completion signal notification
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Dave Jones <davej@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <1163100428.10295.3.camel@dyn9047017100.beaverton.ibm.com>
References: <1163087717.3879.34.camel@frecb000686>
	 <1163087946.3879.43.camel@frecb000686>
	 <20061109190843.GA20321@infradead.org>
	 <1163100428.10295.3.camel@dyn9047017100.beaverton.ibm.com>
Date: Fri, 10 Nov 2006 10:20:37 +0100
Message-Id: <1163150437.3879.59.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/11/2006 10:27:35,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/11/2006 10:27:37,
	Serialize complete at 10/11/2006 10:27:37
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 11:27 -0800, Badari Pulavarty wrote:
> On Thu, 2006-11-09 at 19:08 +0000, Christoph Hellwig wrote:
> 
> Looks much better :)

  Indeed ;-)

> 
> > 
> > static long aio_setup_sigevent(struct kiocb *iocb,
> > 			       struct sigevent __user *user_event)
> > {
> > 	sigevent_t event;
> > 	struct task_struct *target;
> > 	unsigned long flags;
> > 
> > 	if (copy_from_user(&event, user_event, sizeof (event)))
> > 		return -EFAULT;
> > 
> > 	if (event.sigev_notify == SIGEV_NONE)
> > 		return 0;
> > 
> > 	iocb->ki_notify.notify = event.sigev_notify;
> 
> Don't we want to verify to make sure that we are accepting only
> SIGEV_SIGNAL or SIGEV_THREAD_ID and return -EINVAL, if some
> one passes invalid event ? Like
> 
> 	if ((event.sigev_notify != SIGEV_SIGNAL) &&
> 		(event.sigev_notify != SIGEV_THREAD_ID)) 
> 		return -EINVAL;

  That check is done in good_sigevent() below.

> 
> > 	iocb->ki_notify.signo = event.sigev_signo;
> > 	iocb->ki_notify.value = event.sigev_value;
> > 
> > 	read_lock(&tasklist_lock);
> > 	target = good_sigevent(&event);
> > 	if (unlikely(!target || (target->flags & PF_EXITING)))
> > 		goto out_unlock;
> > 	iocb->ki_notify.target = target;
> > 
> > 	if (iocb->ki_notify.notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID)) {
> > 		/*
> > 		 * This reference will be dropped when we're done with
> > 		 * the request.
> > 		 */
> > 		get_task_struct(target);
> > 	}
> > 	read_unlock(&tasklist_lock);
> > 
> > 	/*
> > 	 * NOTE: we cannot free the sigqueue in the completion path as
> > 	 * the signal may not have been delivered to the target task.
> > 	 * Therefore it has to be freed in __sigqueue_free() when the
> > 	 * signal is collected if si_code is SI_ASYNCIO.
> > 	 */
> > 	iocb->ki_sigq = sigqueue_alloc();
> > 	if (unlikely(!iocb->ki_sigq)) {
> > 		put_task_struct(target);
> > 		return -EAGAIN;
> > 	}
> > 
> > 	return 0;
> >  out_unlock:
> > 	read_unlock(&tasklist_lock);
> > 	return -EINVAL;
> > }

  Thanks,

  Sébastien.

