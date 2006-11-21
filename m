Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031320AbWKUUyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031320AbWKUUyp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031429AbWKUUyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:54:44 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:34257 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1031320AbWKUUyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:54:44 -0500
Date: Tue, 21 Nov 2006 15:54:43 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061121200441.GA341@oleg>
Message-ID: <Pine.LNX.4.44L0.0611211543490.6410-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006, Oleg Nesterov wrote:

> On 11/20, Alan Stern wrote:
> > 
> > 	Both CPUs execute their "mb" instructions.  The mb forces each
> > 	cache to wait until it receives an Acknowdgement for the 
> > 	Invalidate it sent.
> > 
> > 	Both caches send an Acknowledgement message to the other.  The
> > 	mb instructions complete.
> > 
> > 	"b = B" and "a = A" execute.  The caches return A==0 and B==0
> > 	because they haven't yet invalidated their cache lines.
> > 
> > The reason the code failed is because the mb instructions didn't force
> > the caches to wait until the Invalidate messages in their queues had been 
> > fully carried out (i.e., the lines had actually been invalidated).
> 
> However, from
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=113435711112941
> 
> Paul E. McKenney wrote:
> >
> > 2.      rmb() guarantees that any changes seen by the interconnect
> >         preceding the rmb() will be seen by any reads following the
> >         rmb().
> >
> > 3.      mb() combines the guarantees made by rmb() and wmb().
> 
> Confused :(

I'm not certain the odd behavior can occur on systems that use an
interconnect like Paul described.  In the context I was describing, rmb()  
guarantees only that any changes seen _and acknowledged_ by the cache
preceding the rmb() will be seen by any reads following the rmb().  It's a
weaker guarantee, but it still suffices to show that

	A = 1		b = B
	wmb		rmb
	B = 2		a = A

will work as expected.

Alan

