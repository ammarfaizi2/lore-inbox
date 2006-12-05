Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967477AbWLEIaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967477AbWLEIaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 03:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967466AbWLEIaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 03:30:11 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:60406 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937495AbWLEIaH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 03:30:07 -0500
Date: Tue, 5 Dec 2006 09:30:03 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: bharata@in.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 3/5][AIO] - export good_sigevent()
Message-ID: <20061205093003.620d8b1b@frecb000686>
In-Reply-To: <20061204171313.GB27379@in.ibm.com>
References: <20061129112441.745351c9@frecb000686>
	<20061129113234.38c12911@frecb000686>
	<20061204171313.GB27379@in.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 05/12/2006 09:37:20,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 05/12/2006 09:37:24,
	Serialize complete at 05/12/2006 09:37:24
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 22:43:13 +0530 Bharata B Rao <bharata@in.ibm.com> wrote:

> On Wed, Nov 29, 2006 at 11:32:34AM +0100, Sébastien Dugué wrote:
> > 
> > <snip> 
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
> Here good_sigevent() doesn't take care of SIGEV_THREAD. From this comment
> from include/asm-generic/siginfo.h,
> 
> "It seems likely that SIGEV_THREAD will have to be handled from 
> userspace, libpthread transmuting it to SIGEV_SIGNAL, which the
> thread manager then catches and does the appropriate nonsense.
>  However, everything is written out here so as to not get lost."
> 
> it looks like SIGEV_THREAD should never come into kernel. But atleast
> libposix-aio does send SIGEV_THREAD all the way up to kernel.

  That's right, I had to reflect that change into libposix-aio, i.e. transmuting
SIGEV_THREAD into SIGEV_SIGNAL.

  Sébastien.
