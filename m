Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967147AbWK2NuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967147AbWK2NuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935596AbWK2NuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:50:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27335 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S935588AbWK2NuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:50:19 -0500
Date: Wed, 29 Nov 2006 13:50:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: S?bastien Dugu? <sebastien.dugue@bull.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 4/5][AIO] - AIO completion signal notification
Message-ID: <20061129135012.GA24006@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	S?bastien Dugu? <sebastien.dugue@bull.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Zach Brown <zach.brown@oracle.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Ulrich Drepper <drepper@redhat.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>
References: <20061129112441.745351c9@frecb000686> <20061129113301.74a66c91@frecb000686> <20061129105150.GB1773@infradead.org> <20061129140801.1a509e37@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129140801.1a509e37@frecb000686>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 02:08:01PM +0100, S?bastien Dugu? wrote:
> On Wed, 29 Nov 2006 10:51:50 +0000, Christoph Hellwig <hch@infradead.org> wrote:
> 
> > I'm a little bit unhappy about the usage of the notify flag.  The usage
> > seems correct but very confusing:
> 
>   Well, I followed the logic from posix-timers.c, but it may be a poor
> choice ;-)
> 
>   For a start, the SIGEV_* flags are quite confusing (for me at least).
> SIGEV_SIGNAL is defined as 0, SIGEV_NONE as 1 and SIGEV_THREAD_ID as 4. I
> would rather have seen SIGEV_NONE defined as 0 to avoid all this.
> 
>   I also wish I knew why those SIGEV_* constants were defined that way.

Ah, I missed that.  It explains some of the more wierd bits.  I suspect
we should then use != SIGEV_NONE for the any kind of signal notification
bit and == SIGEV_THREAD_ID for the case where we want to deliver to
a particular thread.

But this means we only get a thread reference for SIGEV_THREAD_ID
here:

> > > +	if (notify->notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID)) {
> > > +		/*
> > > +		 * This reference will be dropped in really_put_req() when
> > > +		 * we're done with the request.
> > > +		 */
> > > +		get_task_struct(target);
> > > +	}

But even use it for SIGEV_SIGNAL without SIGEV_THREAD_ID here:

> > > +	if (notify->notify & SIGEV_THREAD_ID)
> > > +		ret = send_sigqueue(notify->signo, sigq, notify->target);
> > > +	else
> > > +		ret = send_group_sigqueue(notify->signo, sigq, notify->target);

Or do I miss something?
