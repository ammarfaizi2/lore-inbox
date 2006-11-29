Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967373AbWK2Oyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967373AbWK2Oyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 09:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967375AbWK2Oyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 09:54:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42432 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S967373AbWK2Oyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 09:54:32 -0500
Date: Wed, 29 Nov 2006 14:54:25 +0000
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
Subject: Re: [PATCH -mm 3/5][AIO] - export good_sigevent()
Message-ID: <20061129145425.GA1953@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	S?bastien Dugu? <sebastien.dugue@bull.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Zach Brown <zach.brown@oracle.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Ulrich Drepper <drepper@redhat.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>
References: <20061129112441.745351c9@frecb000686> <20061129113234.38c12911@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129113234.38c12911@frecb000686>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/***
> + * good_sigevent - check and get target task from a sigevent.
> + * @event: the sigevent to be checked
> + *
> + * This function must be called with tasklist_lock held for reading.
> + */
> +struct task_struct * good_sigevent(sigevent_t * event)
> +{
> +	struct task_struct *rtn = current->group_leader;
> +
> +	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
> +		(!(rtn = find_task_by_pid(event->sigev_notify_thread_id)) ||
> +		 rtn->tgid != current->tgid ||
> +		 (event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL))
> +		return NULL;
> +
> +	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
> +	    ((event->sigev_signo <= 0) || (event->sigev_signo > SIGRTMAX)))
> +		return NULL;
> +
> +	return rtn;
> +}

And while we're at it we should badly beat up the person that wrote this
mess in the first time.  To be somewhat readable it should look like:

static struct task_struct *good_sigevent(sigevent_t *event)
{
	struct task_struct *task = current->group_leader;

	if ((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) {
		if (event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX)
			return NULL;
	}

	if (event->sigev_notify & SIGEV_THREAD_ID) {
		if ((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL)
			return NULL;
		task = find_task_by_pid(event->sigev_notify_thread_id);
		if (!task || task->tgid != current->tgid)
			return NULL;
	}

	return task;
}

And btw, looking at its currentl caller I see why we need the PF_EXITING
flag I recommended to remove easiler on, it even has a big comment that
we should copy & paste to aio.c aswell.  Still no idea why it's doing
the selectiv reference grabbing, though.
