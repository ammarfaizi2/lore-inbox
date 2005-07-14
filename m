Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVGNNqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVGNNqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 09:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVGNNqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 09:46:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60684 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261383AbVGNNqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 09:46:09 -0400
Date: Thu, 14 Jul 2005 14:46:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alex Williamson <alex.williamson@hp.com>
Cc: David Vrabel <dvrabel@arcom.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serial: 8250 fails to detect Exar XR16L2551 correctly
Message-ID: <20050714144604.A7314@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Williamson <alex.williamson@hp.com>,
	David Vrabel <dvrabel@arcom.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <42CA96FC.9000708@arcom.com> <20050706195740.A28758@flint.arm.linux.org.uk> <42CD2C16.1070308@arcom.com> <1121108408.28557.71.camel@tdi> <20050711204646.D1540@flint.arm.linux.org.uk> <1121112057.28557.91.camel@tdi> <20050711211706.E1540@flint.arm.linux.org.uk> <1121116677.28557.104.camel@tdi> <1121274296.4334.58.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1121274296.4334.58.camel@tdi>; from alex.williamson@hp.com on Wed, Jul 13, 2005 at 11:04:56AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 11:04:56AM -0600, Alex Williamson wrote:
> On Mon, 2005-07-11 at 15:17 -0600, Alex Williamson wrote:
> >    No, I think this is a problem with the broken A2 UARTs getting
> > confused in serial8250_set_sleep().  If I remove either UART_CAP_SLEEP
> > or UART_CAP_EFR from the capabilities list for this UART, it behaves
> > normally.  Also, just commenting out the UART_CAP_EFR chunks of
> > set_sleep make it behave.  I'll ping Exar for more data.  Thanks,
> 
> Hi Russell,
> 
>    I don't know enough about the extended UART programming model, but I
> notice that when UART_CAP_EFR and UART_CAP_SLEEP are set on a UART, we
> set the UART_IERX_SLEEP bit in the UART_IER immediately after it's found
> and configured.

Ah, I see what's happening.  We're detecting the port and doing the
autoconfig.  Then we're checking to see if it's the console, and if
not putting it into low power mode.

Then we try to register the console, which may result in this UART
becoming a console.  So now we have a console which is in low power
mode.  Bad bad bad.  No cookie for the serial layer today.

> Are there known working configs where a UART w/ EFR and SLEEP are
> able to be used as a serial console?

No idea - I'm completely reliant on other folk to report problems
with the 8250 driver with their random versions of UARTs which are
out in the field.  I only have 16450, 16550A and 16750 UARTs here.

Hmm, I need to consider killing register_serial() and the associated
code in serial_core.c earlier so I can sanely fix this problem.  I
think it's time to give the remaining register_serial() users an
extra push... I haven't seen _any_ activity from the remaining users,
so I might have to take the attitude that "if they don't care, I don't
care about breaking their code" which would be rather shameful as far
as the users go.  (but hey, user pressure might wake up the maintainers.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
