Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934276AbWKTXQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934276AbWKTXQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934283AbWKTXQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:16:27 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:38713 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S934276AbWKTXQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:16:26 -0500
Message-ID: <4561C60B.5000106@oracle.com>
Date: Mon, 20 Nov 2006 07:13:15 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 3/4][AIO] - AIO completion signal notification
References: <20061120151700.4a4f9407@frecb000686> <20061120152252.7e5a4229@frecb000686>
In-Reply-To: <20061120152252.7e5a4229@frecb000686>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sébastien Dugué wrote:
>                       AIO completion signal notification

This is looking a lot better, thanks for keeping at it.

> +static long aio_setup_sigevent(struct aio_notify *notify,
> +			       struct sigevent __user *user_event)
> +{
> +	sigevent_t event;
> +	struct task_struct *target;
> +
> +	if (copy_from_user(&event, user_event, sizeof (event)))
> +		return -EFAULT;

Last time we talked about this needing to call get_compat_sigevent().  I
think it still needs to.

I think we should avoid the examples set by the current
compat_sys_io_submit() and get_compat_sigevent() callers.  They copy
translated data on to the userspace stack and pass it to the syscalls.
That will get crazy for compat_sys_io_submit() because it would have to
rewrite the iocb and the pointer to the iocb to get sys_io_submit() to
find a copied sigevent on the stack.

I think the model is compat_do_readv_writev().  Hoist some of the
syscall logic up into the compat layer so that one copying and
translating pass is made instead of trying to fool the syscall logic
into thinking that it's being called from a native word size caller.

So io_submit_one() should be given the kernel copies of the userspace
structures it needs.  sys_io_submit() will pass it the copies it made
for native word size callers.  compat_sys_io_submit() will pass in the
copies it made after translating from 32bit arguments.  io_submit_one()
and lookup_kioctx() will have to be made available to kernel/compat.c
(via linux/aio.h, surely.).  aio_setup_sigevent() will be called from
*_io_submit() and given the kernel sigevent, not a userspace pointer.

Reworking things this way should have the added benefit of making 32/64
sys_io_submit() more efficient than it is today.

- z
