Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271021AbTHQVQP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 17:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271034AbTHQVQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 17:16:15 -0400
Received: from mailf.telia.com ([194.22.194.25]:18938 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id S271021AbTHQVQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 17:16:11 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: lists@runa.sytes.net, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: segfault when unloading module loop in 2.6.0-test3+ck patches
References: <20030817042751.379428cf.lists@runa.sytes.net>
	<m28yps57oi.fsf@p4.localdomain>
	<20030817135935.2790cec6.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 17 Aug 2003 23:15:40 +0200
In-Reply-To: <20030817135935.2790cec6.akpm@osdl.org>
Message-ID: <m24r0g56kj.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Peter Osterlund <petero2@telia.com> wrote:
> >
> > diff -puN drivers/block/loop.c~loop-oops-fix drivers/block/loop.c
> > --- linux/drivers/block/loop.c~loop-oops-fix	2003-08-17 19:19:22.000000000 +0200
> > +++ linux-petero/drivers/block/loop.c	2003-08-17 20:33:03.000000000 +0200
> > @@ -1198,6 +1198,7 @@ int __init loop_init(void)
> >  		lo->lo_queue = blk_alloc_queue(GFP_KERNEL);
> >  		if (!lo->lo_queue)
> >  			goto out_mem4;
> > +		init_timer(&lo->lo_queue->unplug_timer);
> >  		disks[i]->queue = lo->lo_queue;
> >  		init_MUTEX(&lo->lo_ctl_mutex);
> >  		init_MUTEX_LOCKED(&lo->lo_sem);
> 
> This bit should be done in ll_rw_blk.c somewhere.  Are you sure it is
> necessary for loop?

Without this, if I insmod loop and then immediately rmmod loop,
del_timer() calls check_timer_failed(), which generates warnings in
the kernel log.

In normal cases, the timer is initialized in blk_queue_make_request(),
but that function is not called if you don't use the loop device
before unloading the module. Maybe there is a better way to get rid of
this warning.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
