Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVCGIjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVCGIjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVCGIjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:39:41 -0500
Received: from coderock.org ([193.77.147.115]:12723 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261712AbVCGIgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:36:00 -0500
Date: Mon, 7 Mar 2005 09:35:49 +0100
From: Domen Puncer <domen@coderock.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
       nacc@us.ibm.com
Subject: Re: [patch 2/8] isdn/capi: replace interruptible_sleep_on() with wait_event_interruptible()
Message-ID: <20050307083549.GB18117@nd47.coderock.org>
References: <20050306223803.77C4F1EC90@trashy.coderock.org> <20050306194756.1d24dd0c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306194756.1d24dd0c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/05 19:47 -0800, Andrew Morton wrote:
> domen@coderock.org wrote:
> >
> > 
> > 
> > Use wait_event_interruptible() instead of the deprecated
> > interruptible_sleep_on(). Patch is straight-forward as current sleep is
> > conditionally looped. Patch is compile-tested.
> > 
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > Signed-off-by: Domen Puncer <domen@coderock.org>
> > ---
> > 
> > 
> >  kj-domen/drivers/isdn/capi/capi.c |    9 ++-------
> >  1 files changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff -puN drivers/isdn/capi/capi.c~int_sleep_on-drivers_isdn_capi_capi drivers/isdn/capi/capi.c
> > --- kj/drivers/isdn/capi/capi.c~int_sleep_on-drivers_isdn_capi_capi	2005-03-05 16:11:36.000000000 +0100
> > +++ kj-domen/drivers/isdn/capi/capi.c	2005-03-05 16:11:36.000000000 +0100
> > @@ -675,13 +675,8 @@ capi_read(struct file *file, char __user
> >  		if (file->f_flags & O_NONBLOCK)
> >  			return -EAGAIN;
> >  
> > -		for (;;) {
> > -			interruptible_sleep_on(&cdev->recvwait);
> > -			if ((skb = skb_dequeue(&cdev->recvqueue)) != 0)
> > -				break;
> > -			if (signal_pending(current))
> > -				break;
> > -		}
> > +		wait_event_interruptible(cdev->recvwait,
> > +				((skb = skb_dequeue(&cdev->recvqueue)) == 0));
> >  		if (skb == 0)
> >  			return -ERESTARTNOHAND;
> >  	}
> 
> hmm, OK.  Putting an expression with side-effect such as this into a macro
> which evaluates the expression multiple times is a bit of a worry, but it
> appears that everything will work OK.
> 
> That being said, I'd prefer that this come in via the ISDN team, after
> having been tested please.

I believe last update from ISDN team was 13 months ago. :-(
And I concur, testing would be great.


	Domen
