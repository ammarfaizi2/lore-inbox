Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbVKPSKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbVKPSKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbVKPSKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:10:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39688 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030335AbVKPSKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:10:50 -0500
Date: Wed, 16 Nov 2005 17:54:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <gregkh@suse.de>
Cc: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] - Fixes NULL pointer deference in usb-serial driver.
Message-ID: <20051116175409.GA30894@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20051116151634.20661b0f.lcapitulino@mandriva.com.br> <20051116172416.GA6310@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116172416.GA6310@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 09:24:16AM -0800, Greg KH wrote:
> On Wed, Nov 16, 2005 at 03:16:34PM -0200, Luiz Fernando Capitulino wrote:
> > 1. Process A calls open() and tcgetattr(). When it calls close(), the specific
> > driver function put it to sleep at usb_serial.c:242 (I'm using pl2303 driver)
> > 
> > 2. Process B calls open() and before the call to tcgetattr() it is put to
> > sleep.
> > 
> > 3. Process A wakes up and finish the close procedure (which resets
> > 'port->tty->driver_data')
> > 
> > 4. Process B wakes up, executes serial_ioctl() and gets a NULL pointer in
> > 'port->tty->driver_data'.
> 
> Ugh, the tty core should really protect us from stuff like this,
> unfortunately, there is no locking there, yet.  People are working on
> it...

No.  It is quite correct to have an overlapping open and close with
TTYs.  In fact, it's something which is rather fundamental to TTYs.

Consider: you have a modem connected to a serial like.  You want to
use it for both callin and dial out.

Your box runs a getty on the line.  The getty opens the port in non-
blocking mode, configures it, closes it and then re-opens it in blocking
mode.  The open call waits for the DCD line to become active.

Meanwhile, you want to use the modem to call out, so you open the port
in non-blocking mode.  This succeeds, and you eventually finish using
the port.  You close it.  This triggers a hang up in the usual way and
_then_ causes the first open call to return an EAGAIN error.

Hint: there's a VERY good reason the serial_core layer exists and
it's to get these kind of semantics (and bugs) centralised in one
place rather than spread across thousands of drivers.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
