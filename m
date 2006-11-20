Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966563AbWKTTjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966563AbWKTTjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966560AbWKTTjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:39:31 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:46812 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S966563AbWKTTja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:39:30 -0500
Date: Mon, 20 Nov 2006 14:39:29 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jens Axboe <jens.axboe@oracle.com>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061120175848.GD8055@kernel.dk>
Message-ID: <Pine.LNX.4.44L0.0611201436230.7569-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, Jens Axboe wrote:

> On Mon, Nov 20 2006, Alan Stern wrote:
> > Paul:
> > 
> > Here's my version of your patch from yesterday.  It's basically the same, 
> > but I cleaned up the code in a few places and fixed a bug (the sign of idx 
> > in srcu_read_unlock).  Also I changed the init routine back to void, since 
> > it's no longer an error if the per-cpu allocation fails.
> > 
> > More importantly, I added a static initializer and included the fast-path 
> > in synchronize_srcu.  It's protected by the new symbol 
> > SMP__STORE_MB_LOAD_WORKS, which should be defined in arch-specific headers 
> > for those architectures where the store-mb-load pattern is safe.
> 
> Must we introduce memory allocations in srcu_read_lock()? It makes it
> much harder and nastier for me to use. I'd much prefer a failing
> init_srcu(), seems like a much better API.

Paul agrees with you that allocation failures in init_srcu() should be 
passed back to the caller, and I certainly don't mind doing so.

However we can't remove the memory allocation in srcu_read_lock().  That
was the point which started this whole thread: the per-cpu allocation
cannot be done statically, and some users of a static SRCU structure can't
easily call init_srcu() early enough.

Once the allocation succeeds, the overhead in srcu_read_lock() is minimal.

Alan

