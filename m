Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVGMMto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVGMMto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 08:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbVGMMtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 08:49:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16915 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262841AbVGMMss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 08:48:48 -0400
Date: Wed, 13 Jul 2005 13:48:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Song <samlinuxkernel@yahoo.com>
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-git] 8250 tweaks
Message-ID: <20050713134837.B6791@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Song <samlinuxkernel@yahoo.com>, david-b@pacbell.net,
	linux-kernel@vger.kernel.org
References: <20050713071245.B19871@flint.arm.linux.org.uk> <20050713105127.59527.qmail@web32003.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050713105127.59527.qmail@web32003.mail.mud.yahoo.com>; from samlinuxkernel@yahoo.com on Wed, Jul 13, 2005 at 03:51:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 03:51:26AM -0700, Sam Song wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > However, if you merely lifted the later 8250.c and
> > put it into a previous kernel (which looks like the 
> > case), there's other changes in addition which are 
> > required.
> 
> Good catch. I tried 2.6.13-rc1 and the newest version
> 2.6.13-rc3 on the same target[MPC8241]. The whining 
> remained the same. 

v. whining

    1. To utter a plaintive, high-pitched, protracted sound, as in pain,
       fear, supplication, or complaint.
    2. To complain or protest in a childish fashion.
    3. To produce a sustained noise of relatively high pitch: jet engines
       whining.

The kernel isn't doing any of those.

Anyway, you're going to have to help me out a lot - I don't know a
thing about PPC, so I don't know what a MPC8241 is.  I don't know
your kernel configuration (could you send it please?) so I don't
know which files are trying to be built.

Also, having the contents of /sys/devices/platform or
/sys/bus/platform/* would be useful.

For some reason, it appears that the serial driver is being asked to
register two serial ports at MMIO address 0, from one platform device,
which it apparantly detects as being present.  I suspect these are
coming from some table included via asm-ppc/serial.h, but where that
is I've no idea.

It's then asked to add two more ports from the serial8250.0 device,
which doesn't exist.  These come from a platform device in arch/ppc.
Again, where these come from I don't know.

So.  The serial driver is being asked to create _four_ ports.  It's
created two, but can't create the other two, failing with error -22.
22 is EINVAL, which means there was something wrong with what was
requested.  That generally points to uartclk being zero, which would
be a bug in the PPC architecture code.  You can confirm this by
applying this patch:

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2333,6 +2333,7 @@ static int __devinit serial8250_probe(st
 			dev_err(dev, "unable to register port at index %d "
 				"(IO%lx MEM%lx IRQ%d): %d\n", i,
 				p->iobase, p->mapbase, p->irq, ret);
+			printk(KERN_ERR "uartclk was %d\n", port.uartclk);
 		}
 	}
 	return 0;

(For those cogito fanatics, the above simple patch took 1min 22sec for
cg-diff to spit out!)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
