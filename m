Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUCRUQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUCRUQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:16:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:15771 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262909AbUCRUQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:16:21 -0500
Date: Thu, 18 Mar 2004 12:18:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Armin Schindler <armin@melware.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 2.6] serialization of kernelcapi work
Message-Id: <20040318121826.61c9f145.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.31.0403181117350.10499-100000@phoenix.one.melware.de>
References: <Pine.LNX.4.31.0403181117350.10499-100000@phoenix.one.melware.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Armin Schindler <armin@melware.de> wrote:
>
> Hi all,
> 
> the ISDN kernelcapi function recv_handler() is triggered by
> schedule_work() and dispatches the CAPI messages to the applications.
> 
> Since a workqueue function may run on another CPU at the same time,
> reordering of CAPI messages may occur.

TCP has the same problem.

> For serialization I suggest a mutex semaphore in recv_handler(),
> patch is appended (yet untested).

It will work OK.  It isn't very scalable of course, but I assume you're
dealing with relatively low bandwidths.

I would suggest that you look at avoiding the global semaphore.  Suppose
someone has 64 interfaces or something.  Is that possible?  It might be
better to put the semaphore into struct capi_ctr so you can at least
process frames from separate cards in parallel.

> Is there a better way to do user-context work serialized ?

Not really - you've been bitten by the compulsory per-cpuness of the
workqueue handlers.

You could have a standalone kernel thread or always queue the work onto CPU
#0 (the function to do this isn't merged, but exists).  But both these are
unscalable.

So apart from moving recv_handler_lock into struct capi_ctr I can't think
of anything clever.


