Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbTEHRyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 13:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTEHRyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 13:54:10 -0400
Received: from hypatia.llnl.gov ([134.9.11.73]:2688 "EHLO hypatia.llnl.gov")
	by vger.kernel.org with ESMTP id S261971AbTEHRyI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 13:54:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Peterson <dsp@llnl.gov>
Organization: Lawrence Livermore National Laboratory
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] fixes for linked list bugs in block I/O code
Date: Thu, 8 May 2003 11:06:38 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, davej@suse.de
References: <200305071622.36352.dsp@llnl.gov> <20030508062942.GB823@suse.de>
In-Reply-To: <20030508062942.GB823@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305081106.38002.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 11:29 pm, Jens Axboe wrote:
> This is convoluted nonsense, bhtail->b_reqnext is NULL by definition. So
> a simple
>
> 	bh->b_reqnext = NULL;
>
> is much clearer.

Ok, that's fine with me.  Setting it explicitly to NULL is also correct
and perhaps a bit more clear.

> >                         req->bhtail->b_reqnext = bh;
> >                         req->bhtail = bh;
> >                         req->nr_sectors = req->hard_nr_sectors += count;
> > @@ -1061,6 +1062,7 @@
> >         req->waiting = NULL;
> >         req->bh = bh;
> >         req->bhtail = bh;
> > +       bh->b_reqnext = NULL;
> >         req->rq_dev = bh->b_rdev;
> >         req->start_time = jiffies;
> >         req_new_io(req, 0, count);
>
> Bart already covered why 2.5 definitely does not need it. I dunno what
> to say for 2.4, to me it looks like a BUG if you pass in a buffer_head
> with uninitialized b_reqnext. Why should that member be any different?

Ok, agreed that 2.5 does not need the patch.

> In fact, from where did you see this buffer_head coming from? Who is
> submitting IO on a not properly inited bh? To me, that sounds like not a
> block layer bug but an fs bug.

I would argue that __make_request() is where the insertion of the buffer_head
into the request structure is performed, and setting the b_reqnext field of
the buffer_head to its proper value is an integral part of performing the
insertion.  Why not keep all of the insertion logic in one place rather than
distribuing it throughout the code and requiring all callers of
__make_request() to remember to initialize b_reqnext?  Localizing the
insertion logic makes the code clearer, more compact, and easier to maintain.

-Dave
