Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbUKIOVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbUKIOVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUKIOVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:21:54 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:32974 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261534AbUKIOUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:20:45 -0500
Subject: Re: [PATCH] Correctly flush 8250 buffers, notify ldisc of line
	status changes.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041109132810.A15570@flint.arm.linux.org.uk>
References: <1099659997.20469.71.camel@localhost.localdomain>
	 <20041109012212.463009c7.akpm@osdl.org>
	 <1099998437.6081.68.camel@localhost.localdomain>
	 <1099998926.15462.21.camel@localhost.localdomain>
	 <20041109132810.A15570@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100006241.15742.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 09 Nov 2004 13:17:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The status change and character receive are asynchronous with respect
> to each other anyway.  Consider the case where the serial port says
> "we have characters waiting" - we receive a FIFO full of characters.
> It then says that the modem status has changed.

Only to a small degree, and the fifo is configurable in software. RS485
multi
drop users do generally run with FIFO and the message boundaries mean
that the
event accuracy is good enough.

What the callback does is provide a notification *before* the data
arrives, and easily 2mS out which calls a line discipline function that
cannot sleep and cannot viably interact with the data stream.

In addition you've not defined the semantics of that function for
calling back into the tty driver. You tell me "carrier dropped", yet in
that routine you don't define what occurs if I want to respond by
lowering my carrier too.
Right now it'll deadlock if I do anything in that function of any
relevance.

So its broken, totally and utterly. Its the kind of undefined,
unserialized crap that I'm trying to get _OUT_ of the serial layer.

Now when you add it to the flip buffer as another event like errors the
line discipline knows the approximate time it occurred, has defined
semantics for ordering and queuing and can respond by flipping its modem
signals. You can
actually *use* it to implement things like half-duplex and multidrop.

Andrew - please reject the patch.

Alan

