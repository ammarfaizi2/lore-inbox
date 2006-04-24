Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWDXTQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWDXTQF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWDXTQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:16:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38670 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751136AbWDXTQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:16:04 -0400
Date: Mon, 24 Apr 2006 20:15:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
Message-ID: <20060424191558.GB16464@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Stephen Hemminger <shemminger@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060424114105.113eecac@localhost.localdomain> <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 12:02:47PM -0700, Linus Torvalds wrote:
> On Mon, 24 Apr 2006, Stephen Hemminger wrote:
> > We should fail request_irq() if the SA_SHIRQ but the irq is edge-triggered.
> 
> That would be HORRIBLE.
> 
> Edge-triggered works perfectly fine for SA_SHIRQ, as long as there is just 
> one user and the driver is properly written. Making request_irq() fail 
> would break existing and working setups.

Sorry, untrue.  If you take a serial port and a network card on the same
edge triggered interrupt line, take the following sequence of events:

1. serial port receives characters, asserts interrupt.

2. interrupt handlers get called, serial starts reading characters from
   the port.  Interrupt does not change state because there's still
   characters in the FIFO to be read.

3. meanwhile, the network interface receives a packet and asserts it's
   interrupt.  Interrupt does not change state since it's already asserted.

4. serial interrupt handler continues to service serial ports until it is
   damned sure all serial ports have released the interrupt line, and
   returns.  Interrupt does not change state because the network device
   is holding it asserted.

5. network interrupt handler gets invoked next (it's next in the chain)
   but hasn't acknowledged the interrupt.  Hence, the interrupt line has
   remained asserted since step 1.

6. serial port receives another character, asserting it's interrupt output.

7. network interrupt handler services network device.  Network device is
   no longer holding the interrupt line in the asserted state.  But the
   serial device is, so still no change in interrupt line state since
   step 1.

8. all handlers complete, kernel returns to foreground task.

9. No further serial or network interrupts because there's _no_ edge to
   trigger the interrupt.  Your serial and network are dead.

If you allow shared interrupts, no matter how hard you try in a driver,
you can NOT get around this problem.  It has to be handled at a higher
level.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
