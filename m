Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319019AbSH1Wgp>; Wed, 28 Aug 2002 18:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319023AbSH1Wgo>; Wed, 28 Aug 2002 18:36:44 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:23260 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319019AbSH1Wgn>;
	Wed, 28 Aug 2002 18:36:43 -0400
Date: Wed, 28 Aug 2002 15:41:03 -0700
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG/PATCH] : bug in tty_default_put_char()
Message-ID: <20020828224103.GC12472@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020826180749.GA8630@bougret.hpl.hp.com> <20020826203126.C4763@flint.arm.linux.org.uk> <20020826195346.GC8749@bougret.hpl.hp.com> <20020826210159.E4763@flint.arm.linux.org.uk> <20020826201732.GE8749@bougret.hpl.hp.com> <20020826212223.H4763@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020826212223.H4763@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 09:22:23PM +0100, Russell King wrote:
> On Mon, Aug 26, 2002 at 01:17:32PM -0700, Jean Tourrilhes wrote:
> > 	It's possible that it's a bit more complex than that, but the
> > TTY stuff is a bit magic to me.
> 
> The patch appears to be in 2.5.31.
> 
> Ok, do you want me to cook up a patch to make ircomm bug() when put_char
> gets called when write_room would have returned 0 ?
> 
> Is it possible for the user who experienced the problem to try out such
> a patch?

	Hi,

	After sending you bogus path and bogus bug reports, I though
it would be time to send you a *real* patch.
	Patch below allow to set "uart=none", which is necessary for
FIR hardware. Patch for 2.5.31.

----------------------------------------------
diff -u -p linux/drivers/serial/core.r1.c linux/drivers/serial/core.c
--- linux/drivers/serial/core.r1.c      Wed Aug 28 11:54:20 2002
+++ linux/drivers/serial/core.c Wed Aug 28 11:58:21 2002
@@ -730,12 +730,17 @@ uart_set_info(struct uart_info *info, st
                 */
                if (port->type != PORT_UNKNOWN)
                        retval = port->ops->request_port(port);
+               else
+                       /* If we set the uart to unknown, we should *always*
+                        * succeed at the test below. - Jean II */
+                       retval = 0;
 
                /*
                 * If we fail to request resources for the
                 * new port, try to restore the old settings.
                 */
                if (retval && old_type != PORT_UNKNOWN) {
+                       DPRINTK("uart_set_info(%d): could not set new serial configuration, reverting to old one\n", MINOR(tty->device) - tty->driver.minor_start);
                        port->iobase = old_iobase;
                        port->type = old_type;
                        port->hub6 = old_hub6;
----------------------------------------------

	Regarding the initial bug I reported.
	The write is comming from the PPP line discipline. If PPP
can't transmit the data, it just drops it and assume higher layers
will retry. This is true for TCP, but not for "chat".
	I implemented the workaround, and the user report that it has
fixed his problem.
	I've also found a bunch of other bugs related to that in the
process, but I'll spare you the details.

	Have fun...

	Jean
