Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261635AbSJANpU>; Tue, 1 Oct 2002 09:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261636AbSJANpU>; Tue, 1 Oct 2002 09:45:20 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:3734 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261635AbSJANpT>; Tue, 1 Oct 2002 09:45:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Jens Axboe <axboe@suse.de>
Subject: Re: [ANNOUNCE] EVMS Release 1.2.0
Date: Tue, 1 Oct 2002 08:18:19 -0500
X-Mailer: KMail [version 1.2]
Cc: evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <0209301701470A.15956@boiler> <20021001102043.GD20878@suse.de>
In-Reply-To: <20021001102043.GD20878@suse.de>
MIME-Version: 1.0
Message-Id: <02100108181900.20800@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 05:20, Jens Axboe wrote:
> On Mon, Sep 30 2002, Kevin Corry wrote:
> > The EVMS team is announcing the next stable release of the Enterprise
> > Volume Management System, which will eventually become EVMS 2.0. Package
> > 1.2.0 is now available for download at the project web site:
> > http://www.sf.net/projects/evms
>
> [evms.c]
>
> #ifndef CONFIG_SMP
> static spinlock_t evms_request_lock = SPIN_LOCK_UNLOCKED;
> #endif
>
> ...
>
> #ifdef CONFIG_SMP
>        blk_dev[EVMS_MAJOR].queue = evms_find_queue;
> #else
>        blk_init_queue(BLK_DEFAULT_QUEUE(EVMS_MAJOR),
>                       evms_do_request_fn, &evms_request_lock);
>        blk_queue_make_request(BLK_DEFAULT_QUEUE(EVMS_MAJOR),
>                               evms_make_request_fn);
> #endif
>
> ...
>
> #ifdef CONFIG_SMP
>        lv->request_lock = SPIN_LOCK_UNLOCKED;
>        blk_init_queue(&lv->request_queue,
>                       evms_do_request_fn,
>                       &lv->request_lock);
>        blk_queue_make_request(&lv->request_queue,
>                               evms_make_request_fn);
> #endif
>
> What the hell is that about?

The above code implements a single request queue for the EVMS driver on 
uniprocessor, and per-volume request queues on SMP. This was done quite some 
time ago (before 2.5), since we felt SMP was the only place where there was a 
performance advantage to having multiple queues (and thus using up all the 
extra memory on UP was wasteful). Since a lot of things have changed in 2.5 
(e.g. prempt), there might be performance advantages on UP now as well.

I was reading over the kernel Bitkeeper changelogs last night and noticed you 
made some changes to the loop driver to implement per-device queues. I talked 
this over with Mark and we decided that if this was the trend, we would 
switch to always using per-volume queues. If you take a look at our bitkeeper 
tree, you should see that change is already in. Unfortunately, this was after 
1.2.0 was released, so that change isn't available in the package I announced 
yesterday. But, the 2.5 code changes almost daily anyway, so I'm not too 
worried. And from looking over the Bitkeeper logs, it looks like there are 
more gendisk changes in 2.5.40 that may affect EVMS, so there will probably 
be additional changes today.

If you have any additional comments, please let us know.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
