Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967016AbWK2Kvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967016AbWK2Kvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967019AbWK2Kvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:51:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57480 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S967016AbWK2Kvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:51:53 -0500
Date: Wed, 29 Nov 2006 10:51:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: S?bastien Dugu? <sebastien.dugue@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 4/5][AIO] - AIO completion signal notification
Message-ID: <20061129105150.GB1773@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	S?bastien Dugu? <sebastien.dugue@bull.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Zach Brown <zach.brown@oracle.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Ulrich Drepper <drepper@redhat.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>
References: <20061129112441.745351c9@frecb000686> <20061129113301.74a66c91@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129113301.74a66c91@frecb000686>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a little bit unhappy about the usage of the notify flag.  The usage
seems correct but very confusing:

In io_submit_one we set ki_notify.notify to SIGEV_NONE and possibly
call aio_setup_sigevent:

> +	/* handle setting up the sigevent for POSIX AIO signals */
> +	req->ki_notify.notify = SIGEV_NONE;
> +
> +	if (iocb->aio_sigeventp) {
> +		ret = aio_setup_sigevent(&req->ki_notify,
> +					 (struct sigevent __user *)(unsigned
> long)
> +					 iocb->aio_sigeventp);
> +		if (ret)
> +			goto out_put_req;
> +	}
> +

aio_setup_sigevent then checks the user passed even for which notify type
we have, and returns if it's none or otherwise sets notify->notify to it.

> +	if (event.sigev_notify == SIGEV_NONE)
> +		return 0;
> +
> +	notify->notify = event.sigev_notify;

Later aio_setup_sigevent gets a reference to the target task_structure
if notify->notify is (SIGEV_SIGNAL|SIGEV_THREAD_ID) but _always_ stores
the target pointer.

> +	if (notify->notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID)) {
> +		/*
> +		 * This reference will be dropped in really_put_req() when
> +		 * we're done with the request.
> +		 */
> +		get_task_struct(target);
> +	}
> +
> +	notify->target = target;


Once we're done with the iocb aio_complete aclls aio_send_signal if
notify.notify is not SIGEV_NONE.

> +	if (iocb->ki_notify.notify != SIGEV_NONE) {
> +		ret = aio_send_signal(&iocb->ki_notify);
> +
> +		/* If signal generation failed, release the sigqueue */
> +		if (ret)
> +			sigqueue_free(iocb->ki_notify.sigq);
> +	}
> +

Which then uses notify->target to send the signal:
> +	if (notify->notify & SIGEV_THREAD_ID)
> +		ret = send_sigqueue(notify->signo, sigq, notify->target);
> +	else
> +		ret = send_group_sigqueue(notify->signo, sigq, notify->target);

And finally really_put_req puts the target if notify.notify contains
either SIGEV_SIGNAL or SIGEV_THREAD_ID.

> +	/* Release task ref */
> +	if (req->ki_notify.notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
> +		put_task_struct(req->ki_notify.target);

Do you see the confusing?  I think all the notify.notify != SIGEV_NONE
in the above code should be replaces by the much more descriptive
notify.notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID). In addition we should
only store the target pointer inside the (SIGEV_SIGNAL|SIGEV_THREAD_ID)
if block that gets a reference to it.
