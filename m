Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbVIMLoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbVIMLoz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 07:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVIMLoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 07:44:55 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:62648 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932615AbVIMLoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 07:44:54 -0400
Message-ID: <00b601c5b858$8a8c4ad0$dba0220a@CARREN>
From: "Hironobu Ishii" <hishii@soft.fujitsu.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Taku Izumi" <izumi2005@soft.fujitsu.com>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
References: <200509072146.j87LkNv8004076@shell0.pdx.osdl.net> <20050907224911.H19199@flint.arm.linux.org.uk> <4394.10.124.102.246.1126165652.squirrel@dominion> <20050913091740.A8256@flint.arm.linux.org.uk>
Subject: Re: performance-improvement-of-serial-console-via-virtual.patch added to -mm tree
Date: Tue, 13 Sep 2005 20:44:37 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel,

I am working with Taku,

> On Thu, Sep 08, 2005 at 04:47:32PM +0900, Taku Izumi wrote:
>> >I don't think we want this.  With early serial console, tx_loadsz is
>> >not guaranteed to be initialised, and may in fact be zero.
>> 
>> >Plus there's no guarantee that the FIFOs will actually be enabled, so
>> >I think it's better that this patch doesn't go to mainline.
>> 
>> Our server has a virtual serial port, but its performance seems to be poor.
>> It takes 10 seconds to output 4000 characters (from kernel) to serial
>> console. By applying my patch, its peformance could be improved. ( 0.4
>> seconds / 4000 characters output), so I think it is useful to use FIFO at
>> serial8250_console_write function like transmit_chars function. Where
>> should I correct in order to use FIFO?
> 
> The problem is that we don't know:
> 
> * if there is a FIFO
> * what size the FIFO is

I understand tx_loadsz is practical TX FIFO size. 
If there is no FIFO, tx_loadsz becomes 1.
Is it wrong?
  
 - tx_loadsz is properly initilized in autoconfig().
 - FIFO is enabled in serial8250_clear_fifo() called from autoconfig(),
   if FIFO exist.
 - autoconfig() is called from serial8250_isa_init_ports().
 - serial8250_isa_init_ports() is called from serial8250_console_init() etc.
 
I can't find the problem you are pointing out.

> * if it has been initialised
> * how much data is already contained in the FIFO

Right, we can't know how many byte exist in the FIFO.
So this patch is waiting the FIFO becomes empty at first
by calling "wait_for_xmitr(up)".
(This is the same logic with original.)

After TX FIFO become empty, we can decide the available 
TX FIFO depth by up->tx_loadsize.

>        for (i = 0; i < count; ) {
>                int     fifo;
>
>                wait_for_xmitr(up);
>                fifo = up->tx_loadsz;
>                /*
>                 *      Send the character out using FIFO.
>                 *      If a LF, also do CR...
>                 */
>                do {
>                        serial_out(up, UART_TX, *s);
>                        fifo--;
>                        if (*s == 10) {
>                                if (fifo > 0) {
>                                        serial_out(up, UART_TX, 13);
>                                        fifo--;
>                                } else {
>                                        /* No room to add CR */
>                                        wait_for_xmitr(up);
>                                        fifo = up->tx_loadsz;
>                                        serial_out(up, UART_TX, 13);
>                                        fifo--;
>                                }
>                        }
>                        i++;
>                        s++;
>                } while (fifo > 0 && i < count );
>        }


> 
> So we can't really blindly initialise the FIFO in the console write
> method.  Neither can we initialise it in the console setup.  If we
> could initialise it, we can't blindly load 16 bytes into the FIFO
> at a time.
> 
> I don't think it's technically practical to use the FIFO for the
> console and still have a reliable serial port.
> 
> -- 
> Russell King
> Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
> maintainer of:  2.6 Serial core
> -

Best regards,
Hironobu Ishii
