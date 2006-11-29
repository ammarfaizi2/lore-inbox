Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935738AbWK2QKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935738AbWK2QKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 11:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935812AbWK2QKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 11:10:35 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:5025 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S935738AbWK2QKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 11:10:34 -0500
Date: Wed, 29 Nov 2006 17:10:38 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 3/5][AIO] - export good_sigevent()
Message-ID: <20061129171038.425e88cc@frecb000686>
In-Reply-To: <20061129145425.GA1953@infradead.org>
References: <20061129112441.745351c9@frecb000686>
	<20061129113234.38c12911@frecb000686>
	<20061129145425.GA1953@infradead.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 17:17:44,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 17:17:45,
	Serialize complete at 29/11/2006 17:17:45
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 14:54:25 +0000, Christoph Hellwig <hch@infradead.org> wrote:

> > +/***
> > + * good_sigevent - check and get target task from a sigevent.
> > + * @event: the sigevent to be checked
> > + *
> > + * This function must be called with tasklist_lock held for reading.
> > + */
> > +struct task_struct * good_sigevent(sigevent_t * event)
> > +{
> > +	struct task_struct *rtn = current->group_leader;
> > +
> > +	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
> > +		(!(rtn = find_task_by_pid(event->sigev_notify_thread_id)) ||
> > +		 rtn->tgid != current->tgid ||
> > +		 (event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL))
> > +		return NULL;
> > +
> > +	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
> > +	    ((event->sigev_signo <= 0) || (event->sigev_signo > SIGRTMAX)))
> > +		return NULL;
> > +
> > +	return rtn;
> > +}
> 
> And while we're at it we should badly beat up the person that wrote this
> mess in the first time.

  Agreed.

>  To be somewhat readable it should look like:
> 
> static struct task_struct *good_sigevent(sigevent_t *event)
> {
> 	struct task_struct *task = current->group_leader;
> 
> 	if ((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) {
> 		if (event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX)
> 			return NULL;
> 	}
> 
> 	if (event->sigev_notify & SIGEV_THREAD_ID) {
> 		if ((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL)
> 			return NULL;
> 		task = find_task_by_pid(event->sigev_notify_thread_id);
> 		if (!task || task->tgid != current->tgid)
> 			return NULL;
> 	}
> 
> 	return task;
> }

  Yes, will incorporate this.

> 
> And btw, looking at its currentl caller I see why we need the PF_EXITING
> flag I recommended to remove easiler on, it even has a big comment that
> we should copy & paste to aio.c aswell.

  Well, I do not take the siglock anymore, so I don't think the comment
really applies here.

>  Still no idea why it's doing
> the selectiv reference grabbing, though.
