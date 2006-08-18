Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWHROae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWHROae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWHROae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:30:34 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:37739 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932368AbWHROad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:30:33 -0400
Date: Fri, 18 Aug 2006 08:30:50 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: R: How to avoid serial port buffer overruns?
In-reply-to: <fa.x+yVoyTCbDO6PUepCOmW0pYaloQ@ifi.uio.no>
To: Giampaolo Tomassoni <g.tomassoni@libero.it>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Message-id: <44E5CF1A.6000506@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.ZZ2a/l3Zs8tqngLkenc7k5Pc5LM@ifi.uio.no>
 <fa.x+yVoyTCbDO6PUepCOmW0pYaloQ@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giampaolo Tomassoni wrote:
> I beg your pardon: I'm not used that much to interrupts handling in Linux, but this piece of code from sound/drivers/serial-u16550.c in a linux-2.6.16:
> 
> 	static irqreturn_t snd_uart16550_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> 	{
> 	        snd_uart16550_t *uart;
> 	
> 	        uart = (snd_uart16550_t *) dev_id;
> 	        spin_lock(&uart->open_lock);
> 	        if (uart->filemode == SERIAL_MODE_NOT_OPENED) {
> 	                spin_unlock(&uart->open_lock);
> 	                return IRQ_NONE;
> 	        }
> 	        inb(uart->base + UART_IIR);             /* indicate to the UART that the interrupt has been serviced */
> 	        snd_uart16550_io_loop(uart);
> 	        spin_unlock(&uart->open_lock);
> 	        return IRQ_HANDLED;
> 	}
> 
> means to me that IRQ_HANDLED is returned even when the interrupt is not issued by the specific UART. This may lead to problems when two or more uarts share the same irq line and the irq line is edge-triggered instead of level-triggered, as is the case with ISA.
> 
> To my knowledge, IRQ_HANDLED should be returned when an interrupt had been served by that specific device handler. Returning a IRQ_HANDLED when the device didn't request for service, in the best case cuases interrupt latencies, in the worst (like in an ISA environment) impairs servicing requests from devices sharing the same IRQ line.
> 
> The byte returned from inb(uart->base + UART_IIR) can be used to detect if this is the requesting UART.
> 
> Am I wrong?

IRQ_HANDLED vs. IRQ_NONE has no effect on what interrupt handlers are 
called, etc. It is only used to detect if an interrupt is firing without 
being handled by any driver, in this case the kernel can detect this and 
disable the interrupt.

I'm not sure exactly why the driver is returning IRQ_HANDLED all the 
time, but edge-triggered interrupts are always tricky and there may be a 
case where it can't reliably detect this. Returning IRQ_HANDLED is the 
safe thing to do if you cannot be sure if your device raised an 
interrupt or not.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

