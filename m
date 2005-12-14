Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVLNTzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVLNTzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVLNTzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:55:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9993 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964907AbVLNTzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:55:05 -0500
Date: Wed, 14 Dec 2005 19:55:00 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
Message-ID: <20051214195459.GG7124@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <1134573803.25663.35.camel@localhost.localdomain> <20051214165549.GE7124@flint.arm.linux.org.uk> <1134587288.25663.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134587288.25663.61.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 07:08:08PM +0000, Alan Cox wrote:
> On Mer, 2005-12-14 at 16:55 +0000, Russell King wrote:
> > If we trigger this, we can assume that the port is dead anyway, or
> > we're in a situation where the host CPU can not keep up with the
> > data stream.
> 
> Not actually true in some cases.
> 
> - When your UART has a large FIFO and pretends to be an 8250 you can get
> a 256 byte burst triggered by the box sleeping for a moment or the BIOS
> SMI crap going to chat to the battery

In which case the receive_chars() function gobbles up to 255 characters
from the device before relinquishing to the main interrupt loop.  The
main interrupt loop has two exit conditions - no further interrupts
are pending from any device, or we run this loop 256 times.

In the case where further characters are waiting, we will re-run the
receive_chars() function.

Hence, we will check the device up to 256 times and each will potentially
receive 255 characters, which gives about 64K of character reception
before the warning triggers.

Therefore, this scenario is _very_ _very_ unlikely.

> - On a virtualised system this trap can trigger because the emulations
> don't emulate the bit arrival and baud rate.

Again, only if there's more than about 64K of data waiting.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
