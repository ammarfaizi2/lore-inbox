Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966141AbWKTVjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966141AbWKTVjs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966694AbWKTVjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:39:48 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:19623 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S966141AbWKTVjs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:39:48 -0500
Date: Mon, 20 Nov 2006 16:39:47 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jens Axboe <jens.axboe@oracle.com>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061120201334.GE8055@kernel.dk>
Message-ID: <Pine.LNX.4.44L0.0611201629040.7916-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, Jens Axboe wrote:

> > > Must we introduce memory allocations in srcu_read_lock()? It makes it
> > > much harder and nastier for me to use. I'd much prefer a failing
> > > init_srcu(), seems like a much better API.
> > 
> > Paul agrees with you that allocation failures in init_srcu() should be 
> > passed back to the caller, and I certainly don't mind doing so.
> > 
> > However we can't remove the memory allocation in srcu_read_lock().  That
> > was the point which started this whole thread: the per-cpu allocation
> > cannot be done statically, and some users of a static SRCU structure can't
> > easily call init_srcu() early enough.
> > 
> > Once the allocation succeeds, the overhead in srcu_read_lock() is minimal.
> 
> It's not about the overhead, it's about a potentially problematic
> allocation.

I'm not sure what you mean by "problematic allocation".  If you
successfully call init_srcu_struct then the allocation will be taken care
of.  Later calls to srcu_read_lock won't experience any slowdowns or
problems.

If your call to init_srcu_struct isn't successful then you have to decide 
how to handle it.  You can ignore the failure and live with degraded 
performance (caused by cache-line contention and repeated attempts to do 
the per-cpu allocation), or you can give up entirely.

Does this answer your objection?  If not, can you explain in more detail 
what other features you would like?

Alan Stern

