Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271043AbTHQVe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 17:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271051AbTHQVe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 17:34:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:47769 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271043AbTHQVe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 17:34:56 -0400
Date: Sun, 17 Aug 2003 14:36:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: lists@runa.sytes.net, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: segfault when unloading module loop in 2.6.0-test3+ck patches
Message-Id: <20030817143600.1a2642a5.akpm@osdl.org>
In-Reply-To: <m24r0g56kj.fsf@p4.localdomain>
References: <20030817042751.379428cf.lists@runa.sytes.net>
	<m28yps57oi.fsf@p4.localdomain>
	<20030817135935.2790cec6.akpm@osdl.org>
	<m24r0g56kj.fsf@p4.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Peter Osterlund <petero2@telia.com> wrote:
> > >
> > > diff -puN drivers/block/loop.c~loop-oops-fix drivers/block/loop.c
> > > --- linux/drivers/block/loop.c~loop-oops-fix	2003-08-17 19:19:22.000000000 +0200
> > > +++ linux-petero/drivers/block/loop.c	2003-08-17 20:33:03.000000000 +0200
> > > @@ -1198,6 +1198,7 @@ int __init loop_init(void)
> > >  		lo->lo_queue = blk_alloc_queue(GFP_KERNEL);
> > >  		if (!lo->lo_queue)
> > >  			goto out_mem4;
> > > +		init_timer(&lo->lo_queue->unplug_timer);
> > >  		disks[i]->queue = lo->lo_queue;
> > >  		init_MUTEX(&lo->lo_ctl_mutex);
> > >  		init_MUTEX_LOCKED(&lo->lo_sem);
> > 
> > This bit should be done in ll_rw_blk.c somewhere.  Are you sure it is
> > necessary for loop?
> 
> Without this, if I insmod loop and then immediately rmmod loop,
> del_timer() calls check_timer_failed(), which generates warnings in
> the kernel log.
> 
> In normal cases, the timer is initialized in blk_queue_make_request(),
> but that function is not called if you don't use the loop device
> before unloading the module. Maybe there is a better way to get rid of
> this warning.

Yup. I moved it to blk_alloc_queue() and removed the init_timer() from
blk_queue_make_request().

