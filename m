Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbVIMLxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbVIMLxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 07:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbVIMLxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 07:53:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24078 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932611AbVIMLxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 07:53:35 -0400
Date: Tue, 13 Sep 2005 12:53:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hironobu Ishii <hishii@soft.fujitsu.com>
Cc: Taku Izumi <izumi2005@soft.fujitsu.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: performance-improvement-of-serial-console-via-virtual.patch added to -mm tree
Message-ID: <20050913125326.A14342@flint.arm.linux.org.uk>
Mail-Followup-To: Hironobu Ishii <hishii@soft.fujitsu.com>,
	Taku Izumi <izumi2005@soft.fujitsu.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200509072146.j87LkNv8004076@shell0.pdx.osdl.net> <20050907224911.H19199@flint.arm.linux.org.uk> <4394.10.124.102.246.1126165652.squirrel@dominion> <20050913091740.A8256@flint.arm.linux.org.uk> <00b601c5b858$8a8c4ad0$dba0220a@CARREN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00b601c5b858$8a8c4ad0$dba0220a@CARREN>; from hishii@soft.fujitsu.com on Tue, Sep 13, 2005 at 08:44:37PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 08:44:37PM +0900, Hironobu Ishii wrote:
> Hi Russel,
> 
> I am working with Taku,
> 
> > On Thu, Sep 08, 2005 at 04:47:32PM +0900, Taku Izumi wrote:
> >> >I don't think we want this.  With early serial console, tx_loadsz is
> >> >not guaranteed to be initialised, and may in fact be zero.
> >> 
> >> >Plus there's no guarantee that the FIFOs will actually be enabled, so
> >> >I think it's better that this patch doesn't go to mainline.
> >> 
> >> Our server has a virtual serial port, but its performance seems to be poor.
> >> It takes 10 seconds to output 4000 characters (from kernel) to serial
> >> console. By applying my patch, its peformance could be improved. ( 0.4
> >> seconds / 4000 characters output), so I think it is useful to use FIFO at
> >> serial8250_console_write function like transmit_chars function. Where
> >> should I correct in order to use FIFO?
> > 
> > The problem is that we don't know:
> > 
> > * if there is a FIFO
> > * what size the FIFO is
> 
> I understand tx_loadsz is practical TX FIFO size. 
> If there is no FIFO, tx_loadsz becomes 1.
> Is it wrong?
>   
>  - tx_loadsz is properly initilized in autoconfig().
>  - FIFO is enabled in serial8250_clear_fifo() called from autoconfig(),
>    if FIFO exist.
>  - autoconfig() is called from serial8250_isa_init_ports().
>  - serial8250_isa_init_ports() is called from serial8250_console_init() etc.
>  
> I can't find the problem you are pointing out.

autoconfig() is _not_ called from serial8250_isa_init_ports().

The problem is that the console write method may be called prior to
autoconfig() being run for the port in question, so tx_loadsz may be
uninitialised.

> > * if it has been initialised
> > * how much data is already contained in the FIFO
> 
> Right, we can't know how many byte exist in the FIFO.
> So this patch is waiting the FIFO becomes empty at first
> by calling "wait_for_xmitr(up)".
> (This is the same logic with original.)
> 
> After TX FIFO become empty, we can decide the available 
> TX FIFO depth by up->tx_loadsize.

Only if you ignore the fact that tx_loadsz may not be initialised.

The only things which the console code can rely on being initialised
is the port address description (iobase / membase / iotype / regshift),
the flow control (UPF_CONS_FLOW) in flags, and in the case of Xscale
systems, the capabilities.  Everything else will be in an indeterminent
state as far as the serial console code is concerned, and therefore can
not be relied upon.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
