Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVCGVtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVCGVtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVCGVsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:48:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:786 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261819AbVCGVbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:31:53 -0500
Date: Mon, 7 Mar 2005 21:31:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>, Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XScale 8250 patches cause malfunction on AMD-8111
Message-ID: <20050307213148.B29948@flint.arm.linux.org.uk>
Mail-Followup-To: Petr Vandrovec <vandrove@vc.cvut.cz>,
	Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
References: <20050307174506.GA9659@vana.vc.cvut.cz> <20050307195654.GA9394@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050307195654.GA9394@vana.vc.cvut.cz>; from vandrove@vc.cvut.cz on Mon, Mar 07, 2005 at 08:56:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 08:56:54PM +0100, Petr Vandrovec wrote:
> Well, problem is not in bit 6 in IER, but in bit 6 in high divisor byte,
> as DLAB is set to one from previous probe.  This simple clear of LCR
> register fixes problem with (probably all 16550A) chips being detected
> as XScale, and in addition to it it does not switch my 115200Bd serial
> line to 7Bd mode (0x4001 divisor) anymore.

Good catch, thanks.  I'd preferably like to see Chris Wedgwood test this
before applying it - I'm sure it'll fix his problem as well, but I'd
like to be sure.

--- linux-2.6.11-c1994.dist/drivers/serial/8250.c	2005-03-07 17:22:21.000000000 +0100
+++ linux-2.6.11-c1994/drivers/serial/8250.c	2005-03-07 20:42:53.000000000 +0100
@@ -729,6 +729,7 @@
 	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
 	status2 = serial_in(up, UART_IIR) >> 5;
 	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+	serial_outp(up, UART_LCR, 0);
 
 	DEBUG_AUTOCONF("iir1=%d iir2=%d ", status1, status2);
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
