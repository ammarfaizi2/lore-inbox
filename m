Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937215AbWLDRHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937215AbWLDRHA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 12:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937219AbWLDRHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 12:07:00 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:36384 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937215AbWLDRG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 12:06:59 -0500
Date: Mon, 4 Dec 2006 22:43:13 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 3/5][AIO] - export good_sigevent()
Message-ID: <20061204171313.GB27379@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20061129112441.745351c9@frecb000686> <20061129113234.38c12911@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061129113234.38c12911@frecb000686>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 11:32:34AM +0100, Sébastien Dugué wrote:
> 
> <snip> 
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

Here good_sigevent() doesn't take care of SIGEV_THREAD. From this comment
from include/asm-generic/siginfo.h,

"It seems likely that SIGEV_THREAD will have to be handled from 
userspace, libpthread transmuting it to SIGEV_SIGNAL, which the
thread manager then catches and does the appropriate nonsense.
 However, everything is written out here so as to not get lost."

it looks like SIGEV_THREAD should never come into kernel. But atleast
libposix-aio does send SIGEV_THREAD all the way up to kernel.

Regards,
Bharata.
