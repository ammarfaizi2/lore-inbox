Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWAVXCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWAVXCR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 18:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWAVXCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 18:02:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24847 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932349AbWAVXCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 18:02:16 -0500
Date: Sun, 22 Jan 2006 23:02:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: anemo@mba.ocn.ne.jp, linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH] serial: serial_txx9 driver update
Message-ID: <20060122230209.GB5511@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, anemo@mba.ocn.ne.jp,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org
References: <20060118.021901.71085469.anemo@mba.ocn.ne.jp> <20060121233649.51211403.akpm@osdl.org> <20060122080015.GA10398@flint.arm.linux.org.uk> <20060122003307.738931b7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060122003307.738931b7.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 12:33:07AM -0800, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > On Sat, Jan 21, 2006 at 11:36:49PM -0800, Andrew Morton wrote:
> > > Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > > >
> > > >  serial_txx9_verify_port(struct uart_port *port, struct serial_struct *ser)
> > > >   {
> > > >  -	if (ser->irq < 0 ||
> > > >  -	    ser->baud_base < 9600 || ser->type != PORT_TXX9)
> > > >  +	unsigned long new_port = (unsigned long)ser->port +
> > > >  +		((unsigned long)ser->port_high << ((sizeof(long) - sizeof(int)) * 8));
> > > 
> > > Are you sure about this part?  Shifting something left by sizeof(something)
> > > seems very strange.  It'll give different results on 64-bit machines for
> > > the same hardware.  Are you sure it wasn't supposed to be an addition?
> > 
> > There is a definition for that constant - it's called HIGH_BITS_OFFSET.
> 
> There are two definitions, actually.  drivers/serial/serial_core.c and
> drivers/serial/8250.h.
> 
> > No need to try to buggily recreate it.
> 
> Where's the bug in the proposed code?

There isn't, but because it's wider than 80 columns, it got mis-read.
As demonstrated, the 80 column rule _still_ matters for readability.

> Can you tell us what HIGH_BITS_OFFSET actually does?  Stuffing the port
> address into the upper 32-bits of a ulong on 64-bit machines.  Am consumed
> by curiosity.

It's history.  port in serial_struct has been declared as:

        unsigned int    port;

since the year dot, and has been exposed to userland since it's
inception. I guess that 64-bit machines came along, and this was
found to be inadequate.  Rather than deprecate the current interface
and provide a sane API, whoever did this came up with this yucky
solution where

        unsigned int    port_high;

contains the address bits outside the range of "port".  Presumably
they assumed that sizeof(unsigned long) == 2 * sizeof(unsigned int)
here. If not, this silly interface again breaks on us.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
