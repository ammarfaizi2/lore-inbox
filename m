Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWKCUBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWKCUBg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753518AbWKCUBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:01:35 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:46561 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1753520AbWKCUBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:01:25 -0500
Date: Fri, 3 Nov 2006 12:02:34 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org, ego@in.ibm.com
Subject: Re: New filesystem for Linux
Message-ID: <20061103200234.GA2610@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0611021458240.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611021458240.25218@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 03:15:33PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 2 Nov 2006, Mikulas Patocka wrote:
> > 
> > * There is a rw semaphore that is locked for read for nearly all operations
> > and locked for write only rarely. However locking for read causes cache line
> > pingpong on SMP systems. Do you have an idea how to make it better?

[ . . . ]

> (Seqlocks could be changed to drop the first requirement, although it 
> could cause some serious starvation issues, so I'm not sure it's a good 
> idea. For RCU the atomic nature is pretty much designed-in.)

I can't help putting in a plug for SRCU, which is in the 2.6.19-rc series,
and which allows readers to sleep.  (http://lwn.net/Articles/202847/)

SRCU allows readers and writers to run concurrently (as do all forms of
RCU).  If this is a problem, it might be worth looking into Gautham
Shenoy's reader-writer lock built on top of RCU.  (A version for hotplug
may be found at http://lkml.org/lkml/2006/10/26/73.)  This approach
keeps the reader-writer-lock semantics, but gets rid of cache thrashing.
That said, writers have to wait for a grace period.

And as Linus pointed out, if you have disk I/O involved, you probably
won't notice normal reader-writer-lock overhead.

							Thanx, Paul
