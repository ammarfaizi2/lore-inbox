Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbWBWJd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWBWJd5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWBWJd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:33:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7440 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751082AbWBWJd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:33:56 -0500
Date: Thu, 23 Feb 2006 09:33:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: what's a platform device?
Message-ID: <20060223093348.GB6248@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <galak@kernel.crashing.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0602221517370.21264-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0602221517370.21264-100000@gate.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 03:47:40PM -0600, Kumar Gala wrote:
> The situation I have is an FPGA connected over PCI.  The FPGA implements
> various device functionality (serial ports, I2C controller, IR, etc.) as a
> single PCI device/function.  The FPGA breaks any notion of a true PCI
> device, it uses PCI as a device interconnect more than anything else.

We have at least one example where we have a single PCI function
containing more than one type of functionality which are the parallel
port and serial cards [*].  Normally, the different types of
functionality are accessible via different BARs which at least gives
some logical separation.

It's not really a good model because you have to have a special PCI
probe driver to register the various functionalities with the subsystems
rather than using the generic 8250_pci and parport_pci drivers directly.
Also it can have problems if you want to have (eg) serial built-in and
i2c as a module.

The alternative as Greg points out is to implement a pseudo bus_type, but
I start to worry about the overhead associated with doing so.

Given the choice between a small PCI "probe" driver for a small number
of functionalities and a complete driver model infrastructure, I'd
prefer the former over the latter.


* - I'm slightly biased here because it seems I've ended up "owning" the
    serial parts of parport_serial, though I don't want to admit that in
    public.  (damn, I just did!)  I think that, provided the subsystems
    are sanely written such that there is very little or no code
    duplication, this method is as good as any other method.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
