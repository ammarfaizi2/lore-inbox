Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264225AbTIIQTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 12:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264222AbTIIQTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 12:19:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18442 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264219AbTIIQTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 12:19:05 -0400
Date: Tue, 9 Sep 2003 17:18:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: tytso@mit.edu, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-serial@vger.kernel.org, gallen@arlut.utexas.edu
Subject: Re: [PATCH] Make the Startech UART detection 'more correct'.
Message-ID: <20030909171859.D4216@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>, tytso@mit.edu,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-serial@vger.kernel.org, gallen@arlut.utexas.edu
References: <20030908205431.GB3888@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030908205431.GB3888@ip68-0-152-218.tc.ph.cox.net>; from trini@kernel.crashing.org on Mon, Sep 08, 2003 at 01:54:31PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 01:54:31PM -0700, Tom Rini wrote:
> Hello.  The following patches (vs 2.4 and 2.6) make the Startech UART
> detection 'more correct'  The problem is that on with the Motorola
> MPC82xx line (8245 for example) it has an internal DUART that it claims
> to be PC16550D compatible, and it has an additional EFR (Enhanced
> Feature Register) at offset 0x2, like on the Startech UARTS.  However,
> it is not a Startech, and when it's detected as such, FIFOs don't work.
> The fix for this is that the Startech UARTs have a 32 byte FIFO [1] and
> the MPC82xx DUARTs have a 16-byte FIFO [2], to check that the FIFO size
> is correct for a Startech.

size_fifo() is claimed to be unreliable at detecting the FIFO size,
so I don't feel safe about using it here.

I'd suggest something like:

	serial_outp(port, UART_LCR, UART_LCR_DLAB);
	efr = serial_in(port, UART_EFR);
	if ((efr & 0xfc) == 0) {
		serial_out(port, UART_EFR, 0xac | (efr & 3));
		/* if top 6 bits return zero, its motorola */
		if (serial_in(port, UART_EFR) == (efr & 3)) {
			/* motorola port */
		} else {
			/* ST16C650V1 port */
		}
		/* restore old value */
		serial_outb(port, UART_EFR, efr);
	}

If you can guarantee that the lower two bits will always be zero, you can
drop the frobbing to ignore/preseve the lower two bits.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
