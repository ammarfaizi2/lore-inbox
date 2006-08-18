Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWHRIuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWHRIuo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWHRIuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:50:44 -0400
Received: from smtp0.libero.it ([193.70.192.33]:41450 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S1751140AbWHRIuc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:50:32 -0400
From: "Giampaolo Tomassoni" <g.tomassoni@libero.it>
To: "Linux Kernel ML" <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Paul Fulghum" <paulkf@microgate.com>,
       "Lee Revell" <rlrevell@joe-job.com>
Subject: R: How to avoid serial port buffer overruns?
Date: Fri, 18 Aug 2006 10:48:53 +0200
Message-ID: <NBBBIHMOBLOHKCGIMJMDGEIMFNAA.g.tomassoni@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1155770899.8796.21.camel@mindpipe>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2006-08-17 at 00:19 +0100, Russell King wrote:
> 
> 
> OK, thanks.  FWIW here is the serial board we are using:
> 
> http://www.moschip.com/html/MCS9845.html
> 
> The hardware guy says "The mn9845cv, have in default 2 serial ports and
> one ISA bus, where we have connected the tl16c554, quad serial port."
> 
> Hopefully Ingo's latency tracer can tell me what is holding off
> interrupts.

I beg your pardon: I'm not used that much to interrupts handling in Linux, but this piece of code from sound/drivers/serial-u16550.c in a linux-2.6.16:

	static irqreturn_t snd_uart16550_interrupt(int irq, void *dev_id, struct pt_regs *regs)
	{
	        snd_uart16550_t *uart;
	
	        uart = (snd_uart16550_t *) dev_id;
	        spin_lock(&uart->open_lock);
	        if (uart->filemode == SERIAL_MODE_NOT_OPENED) {
	                spin_unlock(&uart->open_lock);
	                return IRQ_NONE;
	        }
	        inb(uart->base + UART_IIR);             /* indicate to the UART that the interrupt has been serviced */
	        snd_uart16550_io_loop(uart);
	        spin_unlock(&uart->open_lock);
	        return IRQ_HANDLED;
	}

means to me that IRQ_HANDLED is returned even when the interrupt is not issued by the specific UART. This may lead to problems when two or more uarts share the same irq line and the irq line is edge-triggered instead of level-triggered, as is the case with ISA.

To my knowledge, IRQ_HANDLED should be returned when an interrupt had been served by that specific device handler. Returning a IRQ_HANDLED when the device didn't request for service, in the best case cuases interrupt latencies, in the worst (like in an ISA environment) impairs servicing requests from devices sharing the same IRQ line.

The byte returned from inb(uart->base + UART_IIR) can be used to detect if this is the requesting UART.

Am I wrong?

Regards,

	Giampaolo

