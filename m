Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbUKIOju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbUKIOju (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUKIOju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:39:50 -0500
Received: from [213.146.154.40] ([213.146.154.40]:58851 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261543AbUKIOjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:39:35 -0500
Subject: Re: [PATCH] Correctly flush 8250 buffers, notify ldisc of line
	status changes.
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1100006241.15742.6.camel@localhost.localdomain>
References: <1099659997.20469.71.camel@localhost.localdomain>
	 <20041109012212.463009c7.akpm@osdl.org>
	 <1099998437.6081.68.camel@localhost.localdomain>
	 <1099998926.15462.21.camel@localhost.localdomain>
	 <20041109132810.A15570@flint.arm.linux.org.uk>
	 <1100006241.15742.6.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1100011170.4542.142.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 09 Nov 2004 14:39:31 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 13:17 +0000, Alan Cox wrote:
> What the callback does is provide a notification *before* the data
> arrives, and easily 2mS out which calls a line discipline function that
> cannot sleep and cannot viably interact with the data stream.

Actually I needed it to respond to CTS going away, and it provides a
notification *before* the data are *sent*. Which lets me know that the
first bytes of my packet were dropped by the automatic contention
detection circuitry and I need to flush the rest of the packet from the
FIFO rather than letting the hardware driver wait for CTS to come back
then then send a corrupt half-packet.

> Now when you add it to the flip buffer as another event like errors the
> line discipline knows the approximate time it occurred, has defined
> semantics for ordering and queuing and can respond by flipping its modem
> signals. You can actually *use* it to implement things like half-duplex 
> and multidrop.

That solves a different problem, and isn't quite as useful to me. I want
to be able to respond to CTS going low as quickly as possible, by
flushing the rest of the characters from the outgoing queue. I was happy
enough with using a tasklet to actually call the flush method, to avoid
the deadlock you pointed out without changing the locking of all the
hardware drivers). 

> Andrew - please reject the patch.

I'll submit the bit which makes the flush_buffer method work on its own.
Alan, would you care to offer a viable alternative which solves the
problem I'm interested in?

-- 
dwmw2

