Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVCGUYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVCGUYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVCGUXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:23:12 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:10978 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261170AbVCGT4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:56:55 -0500
Date: Mon, 7 Mar 2005 20:56:54 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: XScale 8250 patches cause malfunction on AMD-8111
Message-ID: <20050307195654.GA9394@vana.vc.cvut.cz>
References: <20050307174506.GA9659@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307174506.GA9659@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 06:45:06PM +0100, Petr Vandrovec wrote:
> Hi,
>   I've just booted my new kernel, and I've noticed that my UARTs are now recognized
> as XScale and not 16550A, and I could watch characters from parport0 line coming out
> on monitor one after another, with 0.5 second spaces between them.
> 
>   I'll try to dig up what bit 6 in IER does on this chip, but it seems like that it is
> enabling some thing we do not want to have enabled...  One thing which might make difference
> is that I'm using serial console - but it worked without glitch before this change.

Well, problem is not in bit 6 in IER, but in bit 6 in high divisor byte, as DLAB is set
to one from previous probe.  This simple clear of LCR register fixes problem with (probably
all 16550A) chips being detected as XScale, and in addition to it it does not switch
my 115200Bd serial line to 7Bd mode (0x4001 divisor) anymore.
								Thanks,
									Petr Vandrovec


--- linux-2.6.11-c1994.dist/drivers/serial/8250.c	2005-03-07 17:22:21.000000000 +0100
+++ linux-2.6.11-c1994/drivers/serial/8250.c	2005-03-07 20:42:53.000000000 +0100
@@ -729,6 +729,7 @@
 	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
 	status2 = serial_in(up, UART_IIR) >> 5;
 	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+	serial_outp(up, UART_LCR, 0);
 
 	DEBUG_AUTOCONF("iir1=%d iir2=%d ", status1, status2);
 
