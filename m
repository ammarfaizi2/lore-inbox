Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161118AbWFVNcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbWFVNcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWFVNcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:32:18 -0400
Received: from aun.it.uu.se ([130.238.12.36]:18098 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751787AbWFVNcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:32:18 -0400
Date: Thu, 22 Jun 2006 15:31:56 +0200 (MEST)
Message-Id: <200606221331.k5MDVua9010794@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: linux-kernel@vger.kernel.org, snakebyte@gmx.de
Subject: Re: [Patch] Off by one in drivers/usb/serial/usb-serial.c
Cc: gregkh@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 23:28:17 +0200, Eric Sesterhenn wrote:
> this fixes coverity id #554. since serial table
> is defines as serial_table[SERIAL_TTY_MINORS] we
> should make sure we dont acess with an index
> of SERIAL_TTY_MINORS.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> --- linux-2.6.17-git2/drivers/usb/serial/usb-serial.c.orig	2006-06-21 23:24:07.000000000 +0200
> +++ linux-2.6.17-git2/drivers/usb/serial/usb-serial.c	2006-06-21 23:25:12.000000000 +0200
> @@ -83,7 +83,7 @@ static struct usb_serial *get_free_seria
>  
>  		good_spot = 1;
>  		for (j = 1; j <= num_ports-1; ++j)
> -			if ((i+j >= SERIAL_TTY_MINORS) || (serial_table[i+j])) {
> +			if ((i+j >= SERIAL_TTY_MINORS-1)||(serial_table[i+j])) {
>  				good_spot = 0;
>  				i += j;
>  				break;

Where is the access coverity complained about? If it's the serial_table[i+j]
quoted above, then the original code is OK since i+j < SERIAL_TTY_MINORS is
an invariant in that subexpression.

And the other accesses to serial_table[] in get_free_serial() are also only
done when the index is < SERIAL_TTY_MINORS.

/Mikael
