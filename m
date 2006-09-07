Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWIGVZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWIGVZy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 17:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWIGVZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 17:25:54 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51467 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751387AbWIGVZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 17:25:53 -0400
Date: Thu, 7 Sep 2006 17:25:51 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Uses for memory barriers
Message-ID: <Pine.LNX.4.44L0.0609071549340.6535-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul:

Here's something I had been thinking about back in July but never got 
around to discussing:  Under what circumstances would one ever want to use 
"mb()" rather than "rmb()" or "wmb()"?

The canonical application for memory barriers is where one CPU writes two 
locations and another reads them, to make certain that the ordering is 
preserved (assume everything is initially equal to 0):

	CPU 0			CPU 1
	-----			-----
	a = 1;			y = b;
	wmb();			rmb();
	b = 1;			x = a;
				assert(x==1 || y==0);

In this situation the first CPU only needs wmb() and the second only needs 
rmb().  So when would we need a full mb()?...

The obvious extension of the canonical example is to have CPU 0 write
one location and read another, while CPU 1 reads and writes the same
locations.  Example:

	CPU 0			CPU 1
	-----			-----
	while (y==0) relax();	y = -1;
	a = 1;			b = 1;
	mb();			mb();
	y = b;			x = a;
				while (y < 0) relax();
				assert(x==1 || y==1);	//???

Apart from the extra stuff needed to make sure that CPU 1 sees the proper
value stored in y by CPU 0, this is just like the first example except for
the pattern of reads and writes.  Naively one would think that if the
first half of the assertion fails, so x==0, then CPU 1 must have completed
all of the first four lines above by the time CPU 0 completed its mb().  
Hence the assignment to b would have to be visible to CPU 0, since the
read of b occurs after the mb().  But of course we know that naive 
reasoning isn't always right when it comes to the operation of memory 
caches.

The opposite approach would use reads followed by writes:

	CPU 0			CPU 1
	-----			-----
	while (x==0) relax();	x = -1;
	x = a;			y = b;
	mb();			mb();
	b = 1;			a = 1;
				while (x < 0) relax();
				assert(x==0 || y==0);	//???

Similar reasoning can be applied here.  However IIRC, you decided that
neither of these assertions is actually guaranteed to hold.  If that's the
case, then it looks like mb() is useless for coordinating two CPUs.

Am I correct?  Or are there some easily-explained situations where mb()  
really should be used for inter-CPU synchronization?

Alan

