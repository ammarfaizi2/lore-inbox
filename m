Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbUKIOwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbUKIOwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbUKIOwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:52:42 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:36046 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261546AbUKIOwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:52:40 -0500
Subject: Re: [PATCH] Correctly flush 8250 buffers, notify ldisc of line
	status changes.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1100011170.4542.142.camel@hades.cambridge.redhat.com>
References: <1099659997.20469.71.camel@localhost.localdomain>
	 <20041109012212.463009c7.akpm@osdl.org>
	 <1099998437.6081.68.camel@localhost.localdomain>
	 <1099998926.15462.21.camel@localhost.localdomain>
	 <20041109132810.A15570@flint.arm.linux.org.uk>
	 <1100006241.15742.6.camel@localhost.localdomain>
	 <1100011170.4542.142.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100008158.16045.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 09 Nov 2004 13:49:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-09 at 14:39, David Woodhouse wrote:
> Actually I needed it to respond to CTS going away, and it provides a
> notification *before* the data are *sent*. Which lets me know that the
> first bytes of my packet were dropped by the automatic contention
> detection circuitry and I need to flush the rest of the packet from the
> FIFO rather than letting the hardware driver wait for CTS to come back
> then then send a corrupt half-packet.

But you can't flush the fifo from that callback, you don't have any
locking on it. What are you locking semantics ? Define them, versus
open, versus close, versus other I/O.

> That solves a different problem, and isn't quite as useful to me. I want
> to be able to respond to CTS going low as quickly as possible, by
> flushing the rest of the characters from the outgoing queue. I was happy
> enough with using a tasklet to actually call the flush method, to avoid
> the deadlock you pointed out without changing the locking of all the
> hardware drivers). 

So you want to replace a tasklet that responds to the event with a
tasklet which is called by the event ? Tell me how they differ when low
latency is set on the tty - I don't see any difference in performance

> > Andrew - please reject the patch.
> 
> I'll submit the bit which makes the flush_buffer method work on its own.
> Alan, would you care to offer a viable alternative which solves the
> problem I'm interested in?

If you can't define the locking semantics, its not viable anyway. I see
two things we can do usefully here. The first is to teach
tty_flip_buffer_push more about urgency - since the new tty code I'm
running/crashing/debugging has a real packet queue not just flip buffers
we can queue a tiny message to the queue front and we can probably begin
to cheat a bit more on low_latency v immediate.


