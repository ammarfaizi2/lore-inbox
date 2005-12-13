Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVLMSF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVLMSF4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVLMSF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:05:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41486 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932460AbVLMSFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:05:55 -0500
Date: Tue, 13 Dec 2005 19:05:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Simon Richter <Simon.Richter@hogyros.de>, linux-kernel@vger.kernel.org,
       tony.luck@intel.com, linux-ia64@vger.kernel.org, matthew@wil.cx,
       grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
       paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
       kkojima@rr.iij4u.or.jp, dwmw2@infradead.org,
       linux-mtd@lists.infradead.org
Subject: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
Message-ID: <20051213180551.GN23349@stusta.de>
References: <20051211185212.GQ23349@stusta.de> <20051211192109.GA22537@flint.arm.linux.org.uk> <20051211193118.GR23349@stusta.de> <20051211194437.GB22537@flint.arm.linux.org.uk> <20051213001028.GS23349@stusta.de> <439ECDCC.80707@hogyros.de> <20051213140001.GG23349@stusta.de> <20051213173112.GA24094@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213173112.GA24094@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 05:31:12PM +0000, Russell King wrote:
> On Tue, Dec 13, 2005 at 03:00:01PM +0100, Adrian Bunk wrote:
> > defconfig files are virtually never a configuration for the kernel they 
> > are shipped with since they aren't updated every time some configuration 
> > option is changed.
> > 
> > Consider a defconfig with CONFIG_BROKEN=n, and a driver that is enabled 
> > in this defconfig gets for some reason marked as broken in the Kconfig 
> > file - this will give exactly the same result as the one you describe.
> 
> Adrian,

Hi Russell,

> The defconfig files in arch/arm/configs are for platform configurations
> and are provided by the platform maintainers as a _working_ configuration
> for their platform.  They're not "defconfigs".  They got called
> "defconfigs" as a result of the kbuild "cleanups".  Please don't confuse
> them as such.
> 
> If, in order to have a working platform configuration, they deem that
> CONFIG_BROKEN must be enabled, then that's the way it is.

if a working platform configuration configuration requires 
CONFIG_BROKEN=y, the problem is a bug that should be fixed properly.

We are talking about a class of bugs that can usually be easily fixed if 
reported - so why aren't they reported?

The MTD_SHARP case is a good example, because otherwise I might have 
soon sent a patch that would have removed this driver with the rationale
"both marked as obsolete and BROKEN can clearly be removed".

> Therefore, I request that either you leave the ARM platform configurations
> well alone, or follow the advice I've given so that we can _properly_
> assess the impact of your changes.

Unless someone can tell me a valid case for enabling BROKEN that does 
both create a working configuration and not hide real issues it seems 
the approch below might be the way to go.

Yes, you might dislike this at the first sight.

But if you consider that although this might result in a short-term 
breakage of some configurations, this will also result in proper bug 
reports and fixing of the wrong BROKEN dependency bugs, I hope you agree 
that this will actually improve the situation.

> Thanks.

cu
Adrian


<--  snip  -->


Do not allow people to create configurations with CONFIG_BROKEN=y.

The sole reason for CONFIG_BROKEN=y would be if you are working on 
fixing a broken driver, but in this case editing the Kconfig file is 
trivial.

Never ever should a user enable CONFIG_BROKEN.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc5-mm2-full/init/Kconfig.old	2005-12-13 18:48:40.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/init/Kconfig	2005-12-13 18:48:52.000000000 +0100
@@ -31,19 +31,8 @@
 	  you say Y here, you will be offered the choice of using features or
 	  drivers that are currently considered to be in the alpha-test phase.
 
-config CLEAN_COMPILE
-	bool "Select only drivers expected to compile cleanly" if EXPERIMENTAL
-	default y
-	help
-	  Select this option if you don't even want to see the option
-	  to configure known-broken drivers.
-
-	  If unsure, say Y
-
 config BROKEN
 	bool
-	depends on !CLEAN_COMPILE
-	default y
 
 config BROKEN_ON_SMP
 	bool

