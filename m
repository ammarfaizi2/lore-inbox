Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbVG3UzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbVG3UzI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbVG3UzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:55:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7946 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263174AbVG3UyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:54:15 -0400
Date: Sat, 30 Jul 2005 21:54:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050730215403.J26592@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com> <20050730210306.D26592@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507301335050.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507301335050.29650@g5.osdl.org>; from torvalds@osdl.org on Sat, Jul 30, 2005 at 01:36:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 01:36:24PM -0700, Linus Torvalds wrote:
> On Sat, 30 Jul 2005, Russell King wrote:
> > 
> > What this probably means is that we need some way to turn off interrupts
> > from devices on suspend, and on resume, keep them off until drivers
> > have had a chance to quiesce all devices, turn them back on, and then
> > do full resume.
> 
> No, we just need to suspend and resume the interrupt controller properly.  
> Which we had the technology for, and we actually used to do, but for some
> (incorrect) reason ACPI people thought it should be up to individual
> drivers.

I don't think so - I believe one of the problem cases is where you
have a screaming interrupt caused by an improperly setup device.

Consider the case where you have a shared interrupt line and you're
partially through resuming devices, when one unresumed device (setup
by the BIOS) suddenly starts asserting its interrupt.

The kernel then disables the source.  Unfortunately, that was the IRQ
for your USB host, which has your USB keyboard and mouse attached.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
