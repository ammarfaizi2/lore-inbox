Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbUCTUP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 15:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbUCTUPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 15:15:25 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:27878 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263523AbUCTUPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 15:15:16 -0500
Date: Sat, 20 Mar 2004 21:15:09 +0100 (MET)
From: Armin Schindler <armin@melware.de>
To: Andrew Morton <akpm@osdl.org>
cc: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
Subject: Re: [PATCH 2.6] serialization of kernelcapi work
In-Reply-To: <20040320111431.4ba002f1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.31.0403202048010.27103-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2004, Andrew Morton wrote:
> Armin Schindler <armin@melware.de> wrote:
> >
> > static atomic_t recv_work_count;
> >
> > static void recv_handler(void *data)
> > {
> > 	if (atomic_inc_and_test(&recv_work_count)) {
> > 		do {
> > 			/* work to do */
> > 		} while (!atomic_add_negative(-1, &recv_work_count));
> > 	}
> > }
> >
> > static int __init kcapi_init(void)
> > {
> > 	atomic_set(&recv_work_count, -1);
> > }
> >
> >
> > A second call to the recv_handler() just results in an additional loop
> > of the first one and the second CPU goes on with its work.
>
> It doesn't need to be a counter - it can simply be a flag.  See how (say)
> queue_work() does it.
>
> However you are limiting things so only a single CPU can run `work to do'
> at any time, same as with a semaphore.

Well, limiting the 'work to do' to one CPU is exactly what I need to do,
the code must not run on another CPU at the same time.

If just a 'flag' is used, it is possible to loose an event, the flag like in
queue_work() prevents from running twice only.
But if the first work is just finished and about to reset the flag, the
check for the flag in the second CPU results to do nothing and a possible
needed work is not done.

The idea of using an atomic counter instead of the semaphore is for
performance reasons. It's better if the second work-to-do just increments
a counter, which the first work handles afterwards, than put this thread to
sleep.

Armin


