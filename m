Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWIICZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWIICZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 22:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWIICZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 22:25:47 -0400
Received: from mx2.rowland.org ([192.131.102.7]:2058 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1750958AbWIICZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 22:25:46 -0400
Date: Fri, 8 Sep 2006 22:25:45 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: paulmck@us.ibm.com, David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <200609090049.20416.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0609082216070.8541-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Sep 2006, Oliver Neukum wrote:

> > But what _is_ the formal definition of a memory barrier?  I've never seen 
> > one that was complete and correct.
> 
> I' d say "mb();" is "rmb();wmb();"
> 
> and they work so that:
> 
> CPU 0
> 
> a = TRUE;
> wmb();
> b = TRUE;
> 
> CPU 1
> 
> if (b) {
> 	rmb();
> 	assert(a);
> }
> 
> is correct. Possibly that is not a complete definition though.

It isn't.  Paul has agreed that this assertion:

	CPU 0				CPU 1
	-----				-----
	while (x == 0) relax();		x = -1;
	x = a;				y = b;
	mb();				mb();
	b = 1;				a = 1;
					while (x < 0) relax();
					assert(x==0 || y==0);

will not fail.  I think this would not be true if either of the mb() 
statements were replaced with {rmb(); wmb();}.

To put it another way, {rmb(); wmb();} guarantees that any preceding read 
will complete before any following read and any preceding write will 
complete before any following write.  However it does not guarantee that 
any preceding read will complete before any following write, whereas mb() 
does guarantee that.  (To whatever extent these statements make sense.)

Alan

