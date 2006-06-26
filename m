Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932941AbWFZTNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932941AbWFZTNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932938AbWFZTNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:13:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:64908 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932936AbWFZTNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:13:36 -0400
Date: Mon, 26 Jun 2006 12:10:07 -0700
From: Greg KH <gregkh@suse.de>
To: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Off by one in drivers/usb/serial/usb-serial.c
Message-ID: <20060626191007.GA21925@suse.de>
References: <200606221331.k5MDVua9010794@harpo.it.uu.se> <20060625225920.GA16834@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625225920.GA16834@alice>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 12:59:21AM +0200, Eric Sesterhenn / Snakebyte wrote:
> * Mikael Pettersson (mikpe@it.uu.se) wrote:
> > On Wed, 21 Jun 2006 23:28:17 +0200, Eric Sesterhenn wrote:
> > > this fixes coverity id #554. since serial table
> > > is defines as serial_table[SERIAL_TTY_MINORS] we
> > > should make sure we dont acess with an index
> > > of SERIAL_TTY_MINORS.
> > > 
> > > Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> > > 
> > > --- linux-2.6.17-git2/drivers/usb/serial/usb-serial.c.orig	2006-06-21 23:24:07.000000000 +0200
> > > +++ linux-2.6.17-git2/drivers/usb/serial/usb-serial.c	2006-06-21 23:25:12.000000000 +0200
> > > @@ -83,7 +83,7 @@ static struct usb_serial *get_free_seria
> > >  
> > >  		good_spot = 1;
> > >  		for (j = 1; j <= num_ports-1; ++j)
> > > -			if ((i+j >= SERIAL_TTY_MINORS) || (serial_table[i+j])) {
> > > +			if ((i+j >= SERIAL_TTY_MINORS-1)||(serial_table[i+j])) {
> > >  				good_spot = 0;
> > >  				i += j;
> > >  				break;
> > 
> > Where is the access coverity complained about? If it's the serial_table[i+j]
> > quoted above, then the original code is OK since i+j < SERIAL_TTY_MINORS is
> > an invariant in that subexpression.
> > 
> > And the other accesses to serial_table[] in get_free_serial() are also only
> > done when the index is < SERIAL_TTY_MINORS.
> 
> guess i was too quick on that one, sorry. Here is the coverity
> report for completeness.
> 
> Event assignment: Assigning "1" to "j"
> Also see events: [overrun-local]
> At conditional (11): "j <= (num_ports - 1)" taking true path
> At conditional (16): "j <= (num_ports - 1)" taking true path
> 
> 85   			for (j = 1; j <= num_ports-1; ++j)
> 
> Event overrun-local: Overrun of static array "serial_table" of size 255
> at position 255 with index variable "(i + j)"
> Also see events: [assignment]
> At conditional (12): "(i + j) >= 255" taking true path
> At conditional (17): "(i + j) >= 255" taking false path
> 
> 86   				if ((i+j >= SERIAL_TTY_MINORS) ||
> (serial_table[i+j])) {
> 87   					good_spot = 0;
> 88   					i += j;
> 89   					break;
> 90   				}

So, what does this mean?  That coverity is broken, yet again?

I'm getting very tired of these false positives from them, it is getting
so that I can't trust the output of the tool at all :(

thanks,

greg k-h
