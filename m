Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968551AbWLESHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968551AbWLESHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968552AbWLESHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:07:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59690 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968551AbWLESHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:07:41 -0500
Date: Tue, 5 Dec 2006 10:07:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: Andrew Morton <akpm@osdl.org>, Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
In-Reply-To: <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.64.0612051003430.3542@woody.osdl.org>
References: <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org>
 <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2006, Maciej W. Rozycki wrote:
>
>  One way of avoiding it is calling flush_scheduled_work() from 
> phy_stop_interrupts().  This is fine as long as a caller of 
> phy_stop_interrupts() (not necessarily the immediate one calling into 
> libphy) does not hold the netlink lock.
> 
>  If a caller indeed holds the netlink lock, then a driver effectively 
> calling phy_stop_interrupts() may arrange for the function to be itself 
> scheduled through the event queue.  This has the effect of avoiding the 
> race as well, as the queue is processed in order, except it causes more 
> hassle for the driver.

I would personally be ok with "flush_scheduled_work()" _itself_ noticing 
that it is actually waiting to flush "itself", and just being a no-op in 
that case.

However, having outside code do that detection for it seems to be ugly as 
hell. And something like the network drievr layer shouldn't know about 
keventd details like this.

So if you can move that deadlock avoidance logic into 
"flush_scheduled_work()" itself, we'd avoid the stupid export, and we'd 
also avoid the driver layer having to care about these things. It would 
still be _ugly_, but I think it would be less so.

Hmm?

		Linus
