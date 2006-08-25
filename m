Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422922AbWHYXjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422922AbWHYXjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 19:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWHYXjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 19:39:04 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:41741 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932288AbWHYXjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 19:39:01 -0400
Date: Sat, 26 Aug 2006 00:38:55 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to identify serial ports (ttySn)?
Message-ID: <20060825233855.GD725@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Tokarev <mjt@tls.msk.ru>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <44EF5677.8060304@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EF5677.8060304@tls.msk.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 11:58:47PM +0400, Michael Tokarev wrote:
> For example, we've a PCI serial card (NetMos in
> this case), with, say, one serial port on it.
> Plus some ports on the motherboard (usually one
> or two).  The question is where's the NetMos port,
> on which /dev/ttySnn?

/sys/devices/pciwhatever/tty:ttyS*

> Next, with 2.6.something which was the first 2.6
> I tried, it suddenly become ttyS4.  I don't remember
> the details already.  So I reconfigured all the
> machines (it was UPS control program which is
> sitting on that port) to use another device.
> 
> At least 2.6.11 assigns ttyS3 to the device, saying
> the first two ports are reserved for the onboard
> devices.  So I again reconfigured the app to use
> ttyS3 (or ttyS2 - I'm not sure).
> 
> Now, with 2.6.17, the netmos port is ttyS1.  Because
> in reality, on the motherboard there's only one
> serial port soldered (that's the reason why we
> got the netmos card in the first place), so "next
> unused" device is ttyS1.
> 
> So the question is: how to find where's the thing
> on the running kernel, and where it will be with
> next version?  Is there a way to assign a name for
> the thing, so it will be independent of the current
> kernel?  I just want to use it, the hardware is
> *constant* for several years, but each kernel
> release gives yet another surprize, here or there.

No idea, but at a guess your kernel configuration changed in some way,
or you didn't think enough about the new options which were added.

The behaviour of serial has not changed - if the port is already known
to the kernel, it does it's damnest best to keep the same port.

If it isn't already known, it will look for the first totally unused
port and unassigned port which has not been previously used.

If it can't find one, it'll find an unused port which has been
previously used.

No idea what changed between 2.6.something and 2.6.11 - do you have the
contents of /proc/tty/driver/serial without the PCI driver loaded in
each case?  If not, can't help, sorry.

In the 2.6.11 to 2.6.17 case, you've been bitten by the "only want present
ports to appear in my kernel thankyou" udev-based lobby.  There's now a
configuration option/kernel command line/8250 module option to set the
number of ports.  It sounds like your kernel has it set to 2, causing
only ttyS0 and ttyS1 to be available.

In the kernel configuration, it's called 'SERIAL_8250_RUNTIME_UARTS'.
On the kernel command line, it's something like '8250.nr_uarts', and
the module option is 'nr_uarts'.

If you set this to 4 + number of PCI serial ports, you'll get your
PCI ports starting at ttyS4 as it was in old times.

(Note: this is not a change I approved of - I knew it would cause people
problems, so please don't direct your anger, which is obvious from your
email, at me.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
