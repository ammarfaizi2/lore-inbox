Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWBBOKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWBBOKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 09:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWBBOKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 09:10:45 -0500
Received: from mail.renesas.com ([202.234.163.13]:21424 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751081AbWBBOKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 09:10:44 -0500
Date: Thu, 02 Feb 2006 23:10:33 +0900 (JST)
Message-Id: <20060202.231033.1059963967.takata.hirokazu@renesas.com>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
       linuxppc-dev@ozlabs.org, takata@linux-m32r.org, pfg@sgi.com
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20060202102721.GE5034@flint.arm.linux.org.uk>
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk>
	<20060202102721.GE5034@flint.arm.linux.org.uk>
X-Mailer: Mew version 3.3 on XEmacs 21.4.18 (Social Property)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On m32r,
  compile and boot test: OK

Thank you.

-- Takata

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Thu, 02 Feb 2006 10:27:21 +0000
> Ping?
> 
> On Sat, Jan 21, 2006 at 09:14:07PM +0000, Russell King wrote:
> > The serial_core layer has its own definitions for these, and I'd
> > appreciate it if folk would use them instead of the old ASYNC_* and
> > SERIAL_IO_* definitions.
> > 
> > They're compatible _at the moment_ but I make no guarantees that they
> > will stay that way.  Hence, it's in your interest to ensure that you're
> > using the correct definitions.
> > 
> > MIPS, PPC seem to be the architectures which are stuck in the past on
> > this issue, as is the M32R SIO driver.
> > 
> > The ioc4_serial driver is worse.  It assumes that it can set/clear
> > ASYNC_CTS_FLOW in the uart_info flags field, which is private to
> > serial_core.  It also seems to set TTY_IO_ERROR followed by immediately
> > clearing it (pointless), and then it writes to tty->alt_speed... which
> > isn't used by the serial layer so is also pointless.
> > 
> > So, here's a patch to fix some of this crap up.  Please test and
> > enjoy - I certainly didn't.
...
> >  drivers/serial/m32r_sio.c                  |    2 +-
> >  18 files changed, 32 insertions(+), 51 deletions(-)
...
> > +++ b/arch/mips/cobalt/setup.c
> > diff --git a/drivers/serial/m32r_sio.c b/drivers/serial/m32r_sio.c
> > --- a/drivers/serial/m32r_sio.c
> > +++ b/drivers/serial/m32r_sio.c
> > @@ -80,7 +80,7 @@
> >  #include <asm/serial.h>
> >  
> >  /* Standard COM flags */
> > -#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
> > +#define STD_COM_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST)
> >  
> >  /*
> >   * SERIAL_PORT_DFNS tells us about built-in ports that have no
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
> 
