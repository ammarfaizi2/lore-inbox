Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757016AbWKWI3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757016AbWKWI3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757222AbWKWI3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:29:41 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:26070 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1757016AbWKWI3k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:29:40 -0500
Date: Thu, 23 Nov 2006 09:28:05 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 3/4][AIO] - AIO completion signal notification
Message-ID: <20061123092805.1408b0c6@frecb000686>
In-Reply-To: <20061121170228.4412b572.akpm@osdl.org>
References: <20061120151700.4a4f9407@frecb000686>
	<20061120152252.7e5a4229@frecb000686>
	<20061121170228.4412b572.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2006 09:35:07,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2006 09:35:09,
	Serialize complete at 23/11/2006 09:35:09
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 17:02:28 -0800
Andrew Morton <akpm@osdl.org> wrote:

> On Mon, 20 Nov 2006 15:22:52 +0100
> S__bastien Dugu__ <sebastien.dugue@bull.net> wrote:
> 
> > +static long aio_setup_sigevent(struct aio_notify *notify,
> > +			       struct sigevent __user *user_event)
> > +{
> > +	sigevent_t event;
> > +	struct task_struct *target;
> > +
> > +	if (copy_from_user(&event, user_event, sizeof (event)))
> > +		return -EFAULT;
> > +
> > +	if (event.sigev_notify == SIGEV_NONE)
> > +		return 0;
> > +
> > +	notify->notify = event.sigev_notify;
> > +	notify->signo = event.sigev_signo;
> > +	notify->value = event.sigev_value;
> > +
> > +	read_lock(&tasklist_lock);
> > +	target = good_sigevent(&event);
> > +
> > +	if (unlikely(!target || (target->flags & PF_EXITING)))
> > +		goto out_unlock;
> > +
> > +	
> > +
> > +	if (notify->notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID)) {
> > +		/*
> > +		 * This reference will be dropped in really_put_req() when
> > +		 * we're done with the request.
> > +		 */
> > +		get_task_struct(target);
> > +	}
> 
> It worries me that this function can save away a task_struct* without
> having taken a reference against it.
> 

  OK. Does moving 'notify->target = target;' after the get_task_struct() will
do, or am I missing something more subtle?

  Thanks,

  Sébastien.
