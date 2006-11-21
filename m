Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030816AbWKUKkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030816AbWKUKkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 05:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030841AbWKUKkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 05:40:25 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:63959 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1030816AbWKUKkY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 05:40:24 -0500
Date: Tue, 21 Nov 2006 11:40:21 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 3/4][AIO] - AIO completion signal notification
Message-ID: <20061121114021.30911dec@frecb000686>
In-Reply-To: <4561C60B.5000106@oracle.com>
References: <20061120151700.4a4f9407@frecb000686>
	<20061120152252.7e5a4229@frecb000686>
	<4561C60B.5000106@oracle.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/11/2006 11:47:22,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/11/2006 11:47:23,
	Serialize complete at 21/11/2006 11:47:23
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zach Brown <zach.brown@oracle.com> wrote:

> Sébastien Dugué wrote:
> >                       AIO completion signal notification
> 
> This is looking a lot better, thanks for keeping at it.
> 
> > +static long aio_setup_sigevent(struct aio_notify *notify,
> > +			       struct sigevent __user *user_event)
> > +{
> > +	sigevent_t event;
> > +	struct task_struct *target;
> > +
> > +	if (copy_from_user(&event, user_event, sizeof (event)))
> > +		return -EFAULT;
> 
> Last time we talked about this needing to call get_compat_sigevent().  I
> think it still needs to.

  Yes, I could not find an elegant way to tackle this, so I left it
float for a while.

> 
> I think we should avoid the examples set by the current
> compat_sys_io_submit() and get_compat_sigevent() callers.  They copy
> translated data on to the userspace stack and pass it to the syscalls.
> That will get crazy for compat_sys_io_submit() because it would have to
> rewrite the iocb and the pointer to the iocb to get sys_io_submit() to
> find a copied sigevent on the stack.

  Right, that's what I really wanted to avoid at all costs.

> 
> I think the model is compat_do_readv_writev().  Hoist some of the
> syscall logic up into the compat layer so that one copying and
> translating pass is made instead of trying to fool the syscall logic
> into thinking that it's being called from a native word size caller.

  Yes, but you end up duplicating a lot of code, but if it's the price to
pay, I'm all for it.

> 
> So io_submit_one() should be given the kernel copies of the userspace
> structures it needs.  sys_io_submit() will pass it the copies it made
> for native word size callers.  compat_sys_io_submit() will pass in the
> copies it made after translating from 32bit arguments.  io_submit_one()
> and lookup_kioctx() will have to be made available to kernel/compat.c
> (via linux/aio.h, surely.).  aio_setup_sigevent() will be called from
> *_io_submit() and given the kernel sigevent, not a userspace pointer.
> 
> Reworking things this way should have the added benefit of making 32/64
> sys_io_submit() more efficient than it is today.

  I completely aggree. I will look into this.

  Thanks,

  Sébastien.
