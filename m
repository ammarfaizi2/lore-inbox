Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVHEPHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVHEPHd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263042AbVHEPE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:04:56 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:16557 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262307AbVHEPDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:03:15 -0400
Subject: Re: lockups with netconsole on e1000 on media insertion
From: Steven Rostedt <rostedt@goodmis.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: ak@suse.de, mingo@elte.hu, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, sandos@home.se
In-Reply-To: <20050805.073607.78730729.davem@davemloft.net>
References: <1123251013.18332.28.camel@localhost.localdomain>
	 <20050805141426.GU8266@wotan.suse.de>
	 <1123252026.18332.37.camel@localhost.localdomain>
	 <20050805.073607.78730729.davem@davemloft.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 05 Aug 2005 11:02:44 -0400
Message-Id: <1123254164.18332.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 07:36 -0700, David S. Miller wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> Date: Fri, 05 Aug 2005 10:27:06 -0400
> 
> > Darn it, since this should really be reported.  Yes, the core netpoll
> > should bail out, but it is also a problem with the driver and should be
> > fixed.
> 
> I don't get how you can even remotely claim this to
> be a problem with the driver.
> 
> If there is no cable plugged in, the link never comes
> up, and that is a completely normal thing.  The netpoll
> code should simply not try forever to wait for the link
> to go up.

You're right with that case. The problem with the driver is that it
doesn't clean up the transmits if it just happened to overflow the
transmit buffer and shut down the queue.  The netpoll should at least
see that the queue can be brought up again.  That's what I have a
problem with.  

In other words, I see two bugs:

1. The bug with the netpoll.  It locks up if the driver's queue is down
and never comes up. Which is fixed with Andi's patch.

2.  The bug with the driver. Its netpoll doesn't detect that the queue
can come back up again.  With the timeout on netpoll this may no longer
be a bug, since it should clean itself up after netpoll times out and
turns interrupts back on.  But if a timeout is avoidable by netpoll
being a little smarter, then I believe that it should be fixed.

Now do you understand where I'm coming from?

-- Steve


