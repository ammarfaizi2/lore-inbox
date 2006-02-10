Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWBJIpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWBJIpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 03:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWBJIpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 03:45:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36362 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751202AbWBJIpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 03:45:03 -0500
Date: Fri, 10 Feb 2006 08:44:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org, pfg@sgi.com
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Message-ID: <20060210084445.GA1947@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org, pfg@sgi.com
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121211407.GA19984@dyn-67.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 09:14:07PM +0000, Russell King wrote:
> The ioc4_serial driver is worse.  It assumes that it can set/clear
> ASYNC_CTS_FLOW in the uart_info flags field, which is private to
> serial_core.  It also seems to set TTY_IO_ERROR followed by immediately
> clearing it (pointless), and then it writes to tty->alt_speed... which
> isn't used by the serial layer so is also pointless.

Okay, the only remaining part of this patch which hasn't been applied
is this - can anyone ack it?

diff --git a/drivers/serial/ioc4_serial.c b/drivers/serial/ioc4_serial.c
--- a/drivers/serial/ioc4_serial.c
+++ b/drivers/serial/ioc4_serial.c
@@ -1717,11 +1717,9 @@ ioc4_change_speed(struct uart_port *the_
 	}
 
 	if (cflag & CRTSCTS) {
-		info->flags |= ASYNC_CTS_FLOW;
 		port->ip_sscr |= IOC4_SSCR_HFC_EN;
 	}
 	else {
-		info->flags &= ~ASYNC_CTS_FLOW;
 		port->ip_sscr &= ~IOC4_SSCR_HFC_EN;
 	}
 	writel(port->ip_sscr, &port->ip_serial_regs->sscr);
@@ -1760,18 +1758,6 @@ static inline int ic4_startup_local(stru
 
 	info = the_port->info;
 
-	if (info->tty) {
-		set_bit(TTY_IO_ERROR, &info->tty->flags);
-		clear_bit(TTY_IO_ERROR, &info->tty->flags);
-		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
-			info->tty->alt_speed = 57600;
-		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
-			info->tty->alt_speed = 115200;
-		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
-			info->tty->alt_speed = 230400;
-		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
-			info->tty->alt_speed = 460800;
-	}
 	local_open(port);
 
 	/* set the speed of the serial port */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
