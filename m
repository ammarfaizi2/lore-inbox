Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263511AbUCTTOf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 14:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263514AbUCTTOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 14:14:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:42205 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263511AbUCTTOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 14:14:31 -0500
Date: Sat, 20 Mar 2004 11:14:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Armin Schindler <armin@melware.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 2.6] serialization of kernelcapi work
Message-Id: <20040320111431.4ba002f1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.31.0403201139240.23993-100000@phoenix.one.melware.de>
References: <20040318121826.61c9f145.akpm@osdl.org>
	<Pine.LNX.4.31.0403201139240.23993-100000@phoenix.one.melware.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Armin Schindler <armin@melware.de> wrote:
>
> On Thu, 18 Mar 2004, Andrew Morton wrote:
> > I would suggest that you look at avoiding the global semaphore.  Suppose
> > someone has 64 interfaces or something.  Is that possible?  It might be
> > better to put the semaphore into struct capi_ctr so you can at least
> > process frames from separate cards in parallel.
> >
> > > Is there a better way to do user-context work serialized ?
> >
> > Not really - you've been bitten by the compulsory per-cpuness of the
> > workqueue handlers.
> >
> > You could have a standalone kernel thread or always queue the work onto CPU
> > #0 (the function to do this isn't merged, but exists).  But both these are
> > unscalable.
> >
> > So apart from moving recv_handler_lock into struct capi_ctr I can't think
> > of anything clever.
> 
> I think an atomic counter in the workqueue-function would be more efficient.
> What do you think about this?
> 
> 
> static atomic_t recv_work_count;
> 
> static void recv_handler(void *data)
> {
> 	if (atomic_inc_and_test(&recv_work_count)) {
> 		do {
> 			/* work to do */
> 		} while (!atomic_add_negative(-1, &recv_work_count));
> 	}
> }
> 
> static int __init kcapi_init(void)
> {
> 	atomic_set(&recv_work_count, -1);
> }
> 
> 
> A second call to the recv_handler() just results in an additional loop
> of the first one and the second CPU goes on with its work.

It doesn't need to be a counter - it can simply be a flag.  See how (say)
queue_work() does it.

However you are limiting things so only a single CPU can run `work to do'
at any time, same as with a semaphore.  
