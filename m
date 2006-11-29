Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758829AbWK2NH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758829AbWK2NH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758830AbWK2NH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:07:58 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:48817 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1758829AbWK2NH6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:07:58 -0500
Date: Wed, 29 Nov 2006 14:08:01 +0100
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
Subject: Re: [PATCH -mm 4/5][AIO] - AIO completion signal notification
Message-ID: <20061129140801.1a509e37@frecb000686>
In-Reply-To: <20061129105150.GB1773@infradead.org>
References: <20061129112441.745351c9@frecb000686>
	<20061129113301.74a66c91@frecb000686>
	<20061129105150.GB1773@infradead.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 14:15:07,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 14:15:08,
	Serialize complete at 29/11/2006 14:15:08
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 10:51:50 +0000, Christoph Hellwig <hch@infradead.org> wrote:

> I'm a little bit unhappy about the usage of the notify flag.  The usage
> seems correct but very confusing:

  Well, I followed the logic from posix-timers.c, but it may be a poor
choice ;-)

  For a start, the SIGEV_* flags are quite confusing (for me at least).
SIGEV_SIGNAL is defined as 0, SIGEV_NONE as 1 and SIGEV_THREAD_ID as 4. I
would rather have seen SIGEV_NONE defined as 0 to avoid all this.

  I also wish I knew why those SIGEV_* constants were defined that way.

> 
> In io_submit_one we set ki_notify.notify to SIGEV_NONE and possibly
> call aio_setup_sigevent:
> 
> > +	/* handle setting up the sigevent for POSIX AIO signals */
> > +	req->ki_notify.notify = SIGEV_NONE;
> > +
> > +	if (iocb->aio_sigeventp) {
> > +		ret = aio_setup_sigevent(&req->ki_notify,
> > +					 (struct sigevent __user *)(unsigned
> > long)
> > +					 iocb->aio_sigeventp);
> > +		if (ret)
> > +			goto out_put_req;
> > +	}
> > +
> 
> aio_setup_sigevent then checks the user passed even for which notify type
> we have, and returns if it's none or otherwise sets notify->notify to it.
> 
> > +	if (event.sigev_notify == SIGEV_NONE)
> > +		return 0;
> > +
> > +	notify->notify = event.sigev_notify;
> 
> Later aio_setup_sigevent gets a reference to the target task_structure
> if notify->notify is (SIGEV_SIGNAL|SIGEV_THREAD_ID) but _always_ stores
> the target pointer.

  Yep, as SIGEV_SIGNAL is 0, this in fact checks that notify is SIGEV_THREAD_ID.
It could have been written as:

	if (notify->notify == SIGEV_THREAD_ID)

  And the target pointer is always store because at this point notify is either
SIGEV_SIGNAL or SIGEV_THREAD_ID.

> 
> > +	if (notify->notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID)) {
> > +		/*
> > +		 * This reference will be dropped in really_put_req() when
> > +		 * we're done with the request.
> > +		 */
> > +		get_task_struct(target);
> > +	}
> > +
> > +	notify->target = target;
> 
> 
> Once we're done with the iocb aio_complete aclls aio_send_signal if
> notify.notify is not SIGEV_NONE.

  Again, if it's not SIGEV_NONE, then it's either SIGEV_SIGNAL or
SIGEV_THREAD_ID.

> 
> > +	if (iocb->ki_notify.notify != SIGEV_NONE) {
> > +		ret = aio_send_signal(&iocb->ki_notify);
> > +
> > +		/* If signal generation failed, release the sigqueue */
> > +		if (ret)
> > +			sigqueue_free(iocb->ki_notify.sigq);
> > +	}
> > +
> 
> Which then uses notify->target to send the signal:
> > +	if (notify->notify & SIGEV_THREAD_ID)
> > +		ret = send_sigqueue(notify->signo, sigq, notify->target);
> > +	else
> > +		ret = send_group_sigqueue(notify->signo, sigq, notify->target);
> 
> And finally really_put_req puts the target if notify.notify contains
> either SIGEV_SIGNAL or SIGEV_THREAD_ID.
> 
> > +	/* Release task ref */
> > +	if (req->ki_notify.notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
> > +		put_task_struct(req->ki_notify.target);

  Could have been if (req->ki_notify.notify == SIGEV_THREAD_ID)

> 
> Do you see the confusing?  I think all the notify.notify != SIGEV_NONE
> in the above code should be replaces by the much more descriptive
> notify.notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID). In addition we should
> only store the target pointer inside the (SIGEV_SIGNAL|SIGEV_THREAD_ID)
> if block that gets a reference to it.

  No, I don't think so, notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID) really means
notify == SIGEV_THREAD_ID which leaves out notify == SIGEV_SIGNAL. Or
am I grossly mistaken?

  Thanks,

  Sébastien.



> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
