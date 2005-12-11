Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbVLKTot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVLKTot (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVLKTos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:44:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43276 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750828AbVLKTor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:44:47 -0500
Date: Sun, 11 Dec 2005 19:44:37 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, matthew@wil.cx, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, paulus@samba.org,
       linuxppc-dev@ozlabs.org, lethal@linux-sh.org, kkojima@rr.iij4u.or.jp,
       dwmw2@infradead.org, linux-mtd@lists.infradead.xn--org-boa
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
Message-ID: <20051211194437.GB22537@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, matthew@wil.cx,
	grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
	paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
	kkojima@rr.iij4u.or.jp, dwmw2@infradead.org,
	linux-mtd@lists.infradead.xn--org-boa
References: <20051211185212.GQ23349@stusta.de> <20051211192109.GA22537@flint.arm.linux.org.uk> <20051211193118.GR23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211193118.GR23349@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 08:31:18PM +0100, Adrian Bunk wrote:
> On Sun, Dec 11, 2005 at 07:21:10PM +0000, Russell King wrote:
> > On Sun, Dec 11, 2005 at 07:52:12PM +0100, Adrian Bunk wrote:
> > > defconfig's shouldn't set CONFIG_BROKEN=y.
> > 
> > NACK.  This changes other configuration options in addition, for example
> > in collie_defconfig:
> > 
> > -CONFIG_MTD_OBSOLETE_CHIPS=y
> > -# CONFIG_MTD_AMDSTD is not set
> > -CONFIG_MTD_SHARP=y
> > -# CONFIG_MTD_JEDEC is not set
> 
> That's not a problem introduced by my patch.

It's a problem introduced by your patch because the resulting defconfig
file becomes _wrong_ by your change, and other changes in the defconfig
are thereby hidden.

If you change any options in a defconfig file, and they're obviously not
leaf options, you should check what impact they have on other options by
running it through an "oldconfig" cycle.  That's what I just did with
this script:

#!/bin/sh -e
alias amake='make CROSS_COMPILE=arm-linux- ARCH=arm'
amake $1 O=../build/t >/dev/null 2>&1
mv ../build/t/.config ../build/t/.config.orig
sed '/CONFIG_BROKEN/d;s,^# CONFIG_CLEAN_COMPILE is not set,CONFIG_CLEAN_COMPILE=y,' < ../build/t/.config.orig > ../build/t/.config
amake oldconfig O=../build/t >/dev/null 2>&1
diff -u ../build/t/.config.orig ../build/t/.config

Hence I discovered that disabling CONFIG_BROKEN removes the above
options for the collie case.

BTW, it might be worth using something like the above script for all
the changes to the defconfig files in your patch so that it correctly
updates these files.  It will also mean that any review of it is more
meaningful because we can see the full extent of your changes.

> Either the depency of MTD_OBSOLETE_CHIPS on BROKEN is correct (in which 
> case CONFIG_MTD_OBSOLETE_CHIPS=y wouldn't bring you anything), or the 
> dependency on BROKEN is not correct and should be corrected.

That's something which collie folk need to comment on.  However, what
I can say is that the collie_defconfig builds successfully today:

http://armlinux.simtec.co.uk/kautobuild/2.6.15-rc5-git1/collie_defconfig/zimage.log

so it's quite possible that the Kconfig is out of sync with reality.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
