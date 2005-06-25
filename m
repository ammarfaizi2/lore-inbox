Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263382AbVFYJrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263382AbVFYJrm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 05:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbVFYJrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 05:47:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2569 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263382AbVFYJrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 05:47:35 -0400
Date: Sat, 25 Jun 2005 10:47:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerass <paulus@au.ibm.com>,
       David McCullough <davidm@snapgear.com>,
       Mikael Starvik <starvik@axis.com>
Subject: Re: [PATCH] Add removal schedule of register_serial/unregister_serial to appropriate file
Message-ID: <20050625104725.A16381@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerass <paulus@au.ibm.com>,
	David McCullough <davidm@snapgear.com>,
	Mikael Starvik <starvik@axis.com>
References: <20050623142335.A5564@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050623142335.A5564@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Thu, Jun 23, 2005 at 02:23:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 02:23:35PM +0100, Russell King wrote:
> +What:	register_serial/unregister_serial
> +When:	December 2005
> +Why:	This interface does not allow serial ports to be registered against
> +	a struct device, and as such does not allow correct power management
> +	of such ports.  8250-based ports should use serial8250_register_port
> +	and serial8250_unregister_port instead.
> +Who:	Russell King <rmk@arm.linux.org.uk>

Ok, now that this is in, I guess I should arrange for register_serial &
co to throw a compiler warning.  However, this is non-trivial because
several other drivers declare this function:

drivers/macintosh/macserial.c:int register_serial(struct serial_struct *req)
drivers/macintosh/macserial.c:void unregister_serial(int line)
drivers/serial/68328serial.c:int register_serial(struct serial_struct *req)
drivers/serial/68328serial.c:void unregister_serial(int line)
drivers/serial/crisv10.c:register_serial(struct serial_struct *req)
drivers/serial/crisv10.c:void unregister_serial(int line)

Can folk who look after these drivers please comment on why these
functions are there.


Other places appear to have a prototype for these functions but do not
use them:

arch/xtensa/platform-iss/console.c:int register_serial(struct serial_struct*);
arch/xtensa/platform-iss/console.c:void unregister_serial(int);
drivers/char/amiserial.c:int register_serial(struct serial_struct *req);
drivers/char/amiserial.c:void unregister_serial(int line);

The patch which follows this message will remove these.


In terms of the use of these functions, this is the state of play as of
yesterday:

arch/frv/kernel/setup.c://      register_serial(&__frv_uart0);
arch/frv/kernel/setup.c://      register_serial(&__frv_uart1);
drivers/char/mwave/mwavedd.c:   return register_serial(&serial);
drivers/char/mwave/mwavedd.c:           unregister_serial(pDrvData->sLine);
drivers/misc/ibmasm/uart.c:     sp->serial_line = register_serial(&serial);
drivers/misc/ibmasm/uart.c:     unregister_serial(sp->serial_line);
drivers/net/ioc3-eth.c: register_serial(&req);
drivers/net/ioc3-eth.c: register_serial(&req);
drivers/parport/parport_serial.c:               line = register_serial (&serial_req);
drivers/parport/parport_serial.c:               unregister_serial (priv->line[i]);
drivers/serial/bast_sio.c:      return register_serial(&serial_req);
drivers/serial/bast_sio.c:              unregister_serial(port[0]);
drivers/serial/bast_sio.c:              unregister_serial(port[1]);

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
