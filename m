Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbUCTKxm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbUCTKxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:53:42 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:38124 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263355AbUCTKxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:53:31 -0500
Date: Sat, 20 Mar 2004 11:53:25 +0100 (MET)
From: Armin Schindler <armin@melware.de>
To: Andrew Morton <akpm@osdl.org>
cc: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
Subject: Re: [PATCH 2.6] serialization of kernelcapi work
In-Reply-To: <20040318121826.61c9f145.akpm@osdl.org>
Message-ID: <Pine.LNX.4.31.0403201139240.23993-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Andrew Morton wrote:
> I would suggest that you look at avoiding the global semaphore.  Suppose
> someone has 64 interfaces or something.  Is that possible?  It might be
> better to put the semaphore into struct capi_ctr so you can at least
> process frames from separate cards in parallel.
>
> > Is there a better way to do user-context work serialized ?
>
> Not really - you've been bitten by the compulsory per-cpuness of the
> workqueue handlers.
>
> You could have a standalone kernel thread or always queue the work onto CPU
> #0 (the function to do this isn't merged, but exists).  But both these are
> unscalable.
>
> So apart from moving recv_handler_lock into struct capi_ctr I can't think
> of anything clever.

I think an atomic counter in the workqueue-function would be more efficient.
What do you think about this?


static atomic_t recv_work_count;

static void recv_handler(void *data)
{
	if (atomic_inc_and_test(&recv_work_count)) {
		do {
			/* work to do */
		} while (!atomic_add_negative(-1, &recv_work_count));
	}
}

static int __init kcapi_init(void)
{
	atomic_set(&recv_work_count, -1);
}


A second call to the recv_handler() just results in an additional loop
of the first one and the second CPU goes on with its work.

Unfortunately, the atomic functions are not available on all architechtures.

atomic_dec_and_test() is the only atomic function with return value on all
platforms, right? Which isn't enough for the loop above.

Armin


