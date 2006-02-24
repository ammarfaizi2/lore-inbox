Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWBXDSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWBXDSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 22:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWBXDSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 22:18:21 -0500
Received: from mx1.rowland.org ([192.131.102.7]:62220 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750742AbWBXDSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 22:18:20 -0500
Date: Thu, 23 Feb 2006 22:18:18 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Andrew Morton <akpm@osdl.org>, <sekharan@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid calling down_read and down_write during startup
In-Reply-To: <20060223161631.6f8fa41d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0602232211260.19776-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Andrew Morton wrote:

> Benjamin LaHaise <bcrl@kvack.org> wrote:
> >
> > On Thu, Feb 23, 2006 at 05:36:56PM -0500, Alan Stern wrote:
> >  > This patch (as660) changes the registration and unregistration routines 
> >  > for blocking notifier chains.  During system startup, when task switching 
> >  > is illegal, the routines will avoid calling down_write().
> > 
> >  Why is that necessary?  The down_write() will immediately succeed as no 
> >  other process can possibly be holding the lock when the system is booting, 
> >  so the special casing doesn't fix anything.
> 
> down_write() unconditionally (and reasonably) does local_irq_enable() in
> the uncontended case.  And enabling local interrupts early in boot can
> cause crashes.

Ben, earlier you expressed concern about the extra overhead due to 
cache-line contention (on SMP) in the down_read() call added to 
blocking_notifier_call_chain.  I don't remember which notifier chain in 
particular you were worried about; something to do with networking.

Does this still bother you?  I can see a couple of ways around it.

One is to make that notifier chain atomic instead of blocking.  Of course,
this is feasible only if the chain's callout routines never block.  If
they do, then perhaps there's no point worrying about cache misses.

Another possibility is to write a variant implementation of rw-semaphores,
one that wouldn't cause a cache miss in the common case of an uncontested
read lock.  It could be done.  I can write a somewhat inefficient
version easily enough; no doubt someone more experienced in this sort of
thing could do a better job.

What do you think?

Alan Stern

