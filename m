Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbVIIViT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbVIIViT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 17:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVIIViT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 17:38:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:7808 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030376AbVIIViS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 17:38:18 -0400
Date: Fri, 9 Sep 2005 14:16:19 -0700
From: Greg KH <greg@kroah.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Greg KH <gregkh@suse.de>, Marcel Holtmann <marcel@holtmann.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] W1 patches for 2.6.13
Message-ID: <20050909211619.GA28696@kroah.com>
References: <20050908222105.GA6633@kroah.com> <1126222209.5286.74.camel@blade> <20050909033036.GB11369@suse.de> <20050909050825.GA16668@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909050825.GA16668@2ka.mipt.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 09:08:25AM +0400, Evgeniy Polyakov wrote:
> On Thu, Sep 08, 2005 at 08:30:36PM -0700, Greg KH (gregkh@suse.de) wrote:
> > On Fri, Sep 09, 2005 at 01:30:09AM +0200, Marcel Holtmann wrote:
> > > Hi Greg,
> > > 
> > > > Here are some w1 patches that have been in the -mm tree for a while.
> > > > They add a new driver, and fix up the netlink logic a lot.  They also
> > > > add a crc16 implementation that is needed.
> > > 
> > > adding the CRC-16 is very cool. I was just about to submit one by my
> > > own, because it is also needed for the Bluetooth L2CAP retransmission
> > > and flow control support.
> > > 
> > > What about the 1-Wire notes inside the CRC-16 code. This suppose to be
> > > generic code and so this doesn't belong there.
> > 
> > Yes, those comments don't belong there.  Evgeniy, want to fix this?
> 
> No problem. Patch attached.
> 
> > thanks,
> > 
> > greg k-h
> 
> Remove w1 specific comments from generic crc16 implementation.
> 
> Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> 
> diff --git a/include/linux/crc16.h b/include/linux/crc16.h
> --- a/include/linux/crc16.h
> +++ b/include/linux/crc16.h
> @@ -1,22 +1,11 @@
>  /*
>   *	crc16.h - CRC-16 routine
>   *
> - * Implements the standard CRC-16, as used with 1-wire devices:
> + * Implements the standard CRC-16:
>   *   Width 16
>   *   Poly  0x8005 (x^16 + x^15 + x^2 + 1)
>   *   Init  0
>   *
> - * For 1-wire devices, the CRC is stored inverted, LSB-first
> - *
> - * Example buffer with the CRC attached:
> - *   31 32 33 34 35 36 37 38 39 C2 44
> - *
> - * The CRC over a buffer with the CRC attached is 0xB001.
> - * So, if (crc16(0, buf, size) == 0xB001) then the buffer is valid.
> - *
> - * Refer to "Application Note 937: Book of iButton Standards" for details.
> - * http://www.maxim-ic.com/appnotes.cfm/appnote_number/937
> - *
>   * Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
>   *
>   * This source code is licensed under the GNU General Public License,
> @@ -28,9 +17,6 @@
>  
>  #include <linux/types.h>
>  
> -#define CRC16_INIT		0
> -#define CRC16_VALID		0xb001
> -

This breaks your w1 code:
	    CC [M]  drivers/w1/w1_ds2433.o
	  drivers/w1/w1_ds2433.c: In function `w1_f23_refresh_block':
	  drivers/w1/w1_ds2433.c:84: error: `CRC16_INIT' undeclared (first use in this function)
	  drivers/w1/w1_ds2433.c:84: error: (Each undeclared identifier is reported only once
	  drivers/w1/w1_ds2433.c:84: error: for each function it appears in.)
	  drivers/w1/w1_ds2433.c:84: error: `CRC16_VALID' undeclared (first use in this function)
	  drivers/w1/w1_ds2433.c: In function `w1_f23_write_bin':
	  drivers/w1/w1_ds2433.c:224: error: `CRC16_INIT' undeclared (first use in this function)
	  drivers/w1/w1_ds2433.c:224: error: `CRC16_VALID' undeclared (first use in this function)


So I'm not going to apply this :(

thanks,

greg k-h
