Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWJNIih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWJNIih (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 04:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbWJNIih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 04:38:37 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:43017 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752121AbWJNIif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 04:38:35 -0400
Date: Sat, 14 Oct 2006 09:38:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-serial@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: handle pci_enable_device() failure upon resume
Message-ID: <20061014083826.GA15908@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jeff@garzik.org>, linux-serial@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
References: <20061012014720.GA12935@havoc.gtf.org> <20061013075953.GC28654@flint.arm.linux.org.uk> <20061013131516.227e99ee.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013131516.227e99ee.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 01:15:16PM -0700, Andrew Morton wrote:
> On Fri, 13 Oct 2006 08:59:53 +0100
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Wed, Oct 11, 2006 at 09:47:20PM -0400, Jeff Garzik wrote:
> > > Signed-off-by: Jeff Garzik <jeff@garzik.org>
> > 
> > NAK.  What happens to the ports if pci_enable_device() fails and someone
> > has them open?
> 
> They're screwed either way.
> 
> > It's far better to leave the must_check warning behind until it can be
> > _correctly_ solved, rather than papering over the problem with bogus
> > patches to return errors without taking an appropriate additional action.
> > 
> > IOW, the warnings serve as a reminder that *proper* error handling needs
> > to be implemented.
> 
> What would that error handling do?

Whatever would be correct for the driver.

In the general case of serial drivers, we can probably get away with
removing the port, but I think it'll need a couple of changes to
serial_core to prevent any spurious accesses to the device.

In the case of 8250_pci, slightly changing the way the remove method
works will probably be sufficient, provided the above is also fixed.

So, there _are_ things which can be done, and it requires someone
knowledgeable about the driver to work them out.  Handling this case
is NOT a janitorial task by any means.

> Until that has been implemented, it would be good if we could at least spit
> a printk telling people what failed, so when the machine later goes kaput
> we know why it happened.
> 
> An appropriate place in which to perform that reporting is up in the
> high-level resume code, so Jeff's patch is appropriate.

No it isn't.  What could the high level resume code do?  Call the driver's
remove method?  Some driver remove methods hit the hardware as well, so
that wouldn't be _any_ different to the current situation of not checking
the pci_enable_device() return code.

> Right now, we get silent failure *and* a compile-time warning.  It's hard
> to see how that situation could be made worse.

As I said, an oops.  The nature of this oops could result in:
- user data being destroyed.
- prevention any driver being subsequently loaded or unloaded.

The approach that people are taking at the moment seems to be:
- let's make some random functions __must_check
- oh dear we get lots of warnings
- we must do something to shut these warnings up
- lets think of something and apply it without thought to all drivers
  introducing a lot of potential oops-creating scenarios

We are far better off with the warning - at least there is *something*
to tell driver authors that they need to fix their code.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
