Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967181AbWK2OSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967181AbWK2OSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 09:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967232AbWK2OSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 09:18:18 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:40849 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S967181AbWK2OSR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 09:18:17 -0500
Date: Wed, 29 Nov 2006 15:18:22 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 4/5][AIO] - AIO completion signal notification
Message-ID: <20061129151822.63fa13bc@frecb000686>
In-Reply-To: <20061129135012.GA24006@infradead.org>
References: <20061129112441.745351c9@frecb000686>
	<20061129113301.74a66c91@frecb000686>
	<20061129105150.GB1773@infradead.org>
	<20061129140801.1a509e37@frecb000686>
	<20061129135012.GA24006@infradead.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 15:25:27,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 15:25:28,
	Serialize complete at 29/11/2006 15:25:28
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 13:50:12 +0000, Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Nov 29, 2006 at 02:08:01PM +0100, S?bastien Dugu? wrote:
> > On Wed, 29 Nov 2006 10:51:50 +0000, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > I'm a little bit unhappy about the usage of the notify flag.  The usage
> > > seems correct but very confusing:
> > 
> >   Well, I followed the logic from posix-timers.c, but it may be a poor
> > choice ;-)
> > 
> >   For a start, the SIGEV_* flags are quite confusing (for me at least).
> > SIGEV_SIGNAL is defined as 0, SIGEV_NONE as 1 and SIGEV_THREAD_ID as 4. I
> > would rather have seen SIGEV_NONE defined as 0 to avoid all this.
> > 
> >   I also wish I knew why those SIGEV_* constants were defined that way.
> 
> Ah, I missed that.  It explains some of the more wierd bits.  I suspect
> we should then use != SIGEV_NONE for the any kind of signal notification
> bit and == SIGEV_THREAD_ID for the case where we want to deliver to
> a particular thread.

  Right, that would make things much cleaner. Will try for it.

> 
> But this means we only get a thread reference for SIGEV_THREAD_ID
> here:
> 
> > > > +	if (notify->notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID)) {
> > > > +		/*
> > > > +		 * This reference will be dropped in really_put_req() when
> > > > +		 * we're done with the request.
> > > > +		 */
> > > > +		get_task_struct(target);
> > > > +	}

  It's the way it is in posix-timers and I'm not sure I understand why. We take
a ref on the specific task if notify is SIGEV_THREAD_ID but not for
SIGEV_SIGNAL.

  I'm wondering what I'm missing here, shouldn't we also take a ref on the task
group leader in the SIGEV_SIGNAL case in posix-timers? 

> 
> But even use it for SIGEV_SIGNAL without SIGEV_THREAD_ID here:
> 
> > > > +	if (notify->notify & SIGEV_THREAD_ID)
> > > > +		ret = send_sigqueue(notify->signo, sigq, notify->target);
> > > > +	else
> > > > +		ret = send_group_sigqueue(notify->signo, sigq, notify->target);
> 
> Or do I miss something?

  I missing something too here ;-)

  If someone cared to explain why there is no ref taken on the task for the
SIGEV_SIGNAL case, it would be much appreciated. Is this a bug in posix-timers?


  Thanks,

  Sébastien.
