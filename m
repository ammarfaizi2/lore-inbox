Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVBZQq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVBZQq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 11:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVBZQq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 11:46:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41737 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261227AbVBZQqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 11:46:19 -0500
Date: Sat, 26 Feb 2005 16:46:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] deprecate EXPORT_SYMBOL(do_settimeofday)
Message-ID: <20050226164613.E7151@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org> <20050226133337.GK3311@stusta.de> <20050226144635.B7151@flint.arm.linux.org.uk> <20050226162341.GN3311@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050226162341.GN3311@stusta.de>; from bunk@stusta.de on Sat, Feb 26, 2005 at 05:23:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 05:23:41PM +0100, Adrian Bunk wrote:
> On Sat, Feb 26, 2005 at 02:46:35PM +0000, Russell King wrote:
> > On Sat, Feb 26, 2005 at 02:33:37PM +0100, Adrian Bunk wrote:
> > 
> > Please don't deprecate this symbol.  ARM has a large variety of RTC
> > implementations, some of which reside in I2C modules which are yet
> > to be merged.
> > 
> > Firstly, these aren't accessible until the i2c subsystem has been
> > initialised.  Secondly, i2c is modular, so this function must be
> > accessible from a module in order for the system time/date to be
> > initialised from the RTC with a modular build.
> > 
> > (It can be argued that you wouldn't want to build such a thing as a
> > module in the first place, in which case removing the export would
> > of course be fine.  However, we can't sanely force I2C to be either
> > always builtin, and placing this expectation on people will eventually
> > lead other janitors to complain that the symbol is used by modules but
> > isn't exported.)
> 
> I saw drivers/acorn/char/i2c.c, but this file is always built statically 
> on ARCH_ACORN without any dependency between ARCH_ACORN and I2C.
> This is buggy.
> 
> Why can't such drivers select I2C and other required I2C_* variables?
> 
> Appropriate depends or selects are required in any case.
> If you plan to make drivers like drivers/acorn/char/i2c.c modular, my 
> patch is void.

That driver is buggy for other reasons, but thankfully doesn't show
itself very often...

However, that isn't the one I was talking about, since I was talking
about an unmerged driver.

There are a number of ARM platforms which use a Ricoh RTC chip, and
the driver for this will live in drivers/i2c/chips/ricoh-rtc.c.  This
is a stand alone driver in its own sense, handling the power management
issues (saving the time offset/restoring the time) and setting the
system time upon its initialisation.  (In turn, this requires some i2c
patches which add power management to the i2c subsystem to be merged
first.)

It's already used in some ARM platforms, including one which I was
involved in.  It just hasn't been merged.

As far as drivers/acorn/char i2c rtc stuff goes, I plan to make this
a full and proper i2c citizen, so adding breakage to the Kconfig with
random select statements for publically viewable symbols isn't the
way to go.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
