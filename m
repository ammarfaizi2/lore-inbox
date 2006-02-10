Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWBJVA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWBJVA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWBJVA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:00:56 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29399 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751381AbWBJVAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:00:55 -0500
From: Pat Gefre <pfg@sgi.com>
Organization: SGI
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Date: Fri, 10 Feb 2006 14:57:45 -0600
User-Agent: KMail/1.7.1
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk> <20060210084445.GA1947@flint.arm.linux.org.uk>
In-Reply-To: <20060210084445.GA1947@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101457.45847.pfg@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Yeah this is something I should've fixed up... thanks

Acked-by: pfg@sgi.com



On Fri February 10 2006 2:44 am, Russell King wrote:
> On Sat, Jan 21, 2006 at 09:14:07PM +0000, Russell King wrote:
> > The ioc4_serial driver is worse.  It assumes that it can set/clear
> > ASYNC_CTS_FLOW in the uart_info flags field, which is private to
> > serial_core.  It also seems to set TTY_IO_ERROR followed by immediately
> > clearing it (pointless), and then it writes to tty->alt_speed... which
> > isn't used by the serial layer so is also pointless.
>
> Okay, the only remaining part of this patch which hasn't been applied
> is this - can anyone ack it?
>
> diff --git a/drivers/serial/ioc4_serial.c b/drivers/serial/ioc4_serial.c
> --- a/drivers/serial/ioc4_serial.c
> +++ b/drivers/serial/ioc4_serial.c
> @@ -1717,11 +1717,9 @@ ioc4_change_speed(struct uart_port *the_
>  	}
>
>  	if (cflag & CRTSCTS) {
> -		info->flags |= ASYNC_CTS_FLOW;
>  		port->ip_sscr |= IOC4_SSCR_HFC_EN;
>  	}
>  	else {
> -		info->flags &= ~ASYNC_CTS_FLOW;
>  		port->ip_sscr &= ~IOC4_SSCR_HFC_EN;
>  	}
>  	writel(port->ip_sscr, &port->ip_serial_regs->sscr);
> @@ -1760,18 +1758,6 @@ static inline int ic4_startup_local(stru
>
>  	info = the_port->info;
>
> -	if (info->tty) {
> -		set_bit(TTY_IO_ERROR, &info->tty->flags);
> -		clear_bit(TTY_IO_ERROR, &info->tty->flags);
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
> -			info->tty->alt_speed = 57600;
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
> -			info->tty->alt_speed = 115200;
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
> -			info->tty->alt_speed = 230400;
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
> -			info->tty->alt_speed = 460800;
> -	}
>  	local_open(port);
>
>  	/* set the speed of the serial port */
