Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968522AbWLERsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968522AbWLERsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 12:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968525AbWLERsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 12:48:14 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:2933 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968522AbWLERsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 12:48:14 -0500
Date: Tue, 5 Dec 2006 17:48:05 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
cc: Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
In-Reply-To: <20061203011625.60268114.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
References: <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2006, Andrew Morton wrote:

> wtf?  That code was merged?  This bug has been known for months and after
> several unsuccessful attempts at trying to understand what on earth that
> hackery is supposed to be doing I gave up on it and asked Jeff to look after
> it.

 I am surprised it got merged too -- my understanding from the discussion 
was it was to be sorted out somehow within libphy, one way or another.

> Maciej, please, in very small words written in a very large font, explain to
> us what is going on in phy_stop_interrupts()?  Include pictures.

 Would ASCII art qualify as pictures?  Regardless, I am providing a 
textual description, which please feel free to skip to the conclusion 
below if uninterested in the details.

 Essentially there is a race when disconnecting from a PHY, because 
interrupt delivery uses the event queue for processing.  The function to 
handle interrupts that is called from the event queue is phy_change().  
It takes a pointer to a structure that is associated with the PHY.  At the 
time phy_stop_interrupts() is called there may be one or more calls to 
phy_change() still pending on the event queue.  They may not be able to be 
processed until the structure passed to phy_change() have been freed, at 
which point calling the function is wrong.

 One way of avoiding it is calling flush_scheduled_work() from 
phy_stop_interrupts().  This is fine as long as a caller of 
phy_stop_interrupts() (not necessarily the immediate one calling into 
libphy) does not hold the netlink lock.

 If a caller indeed holds the netlink lock, then a driver effectively 
calling phy_stop_interrupts() may arrange for the function to be itself 
scheduled through the event queue.  This has the effect of avoiding the 
race as well, as the queue is processed in order, except it causes more 
hassle for the driver.  Hence the choice was left to the driver's author 
-- if a driver "knows" the netlink lock is not going to be held at that 
point, it may call phy_stop_interrupts() directly, otherwise it shall use 
the event queue.

 With such an assumption in place the function has to check somehow 
whether it has been scheduled through the queue or not and act 
accordingly, which is why that "if" clause is there.

 Now I gather the conclusion was the whole mess was going to be included 
within libphy and not exposed to Ethernet MAC drivers.  This way the 
library would schedule both phy_stop_interrupts() and mdiobus_unregister() 
(which is actually the function freeing the PHY device structure) through 
the event queue as needed without a MAC driver having to know.

 And the whole question that remains is whether it is Andy (cc-ed) or me 
who is more competent to implement this change. ;-)

  Maciej
