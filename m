Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbTISIi4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 04:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbTISIi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 04:38:56 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:18661 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261447AbTISIiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 04:38:54 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <Pine.LNX.4.44.0309191005270.17132-100000@deadlock.et.tudelft.nl>
References: <Pine.LNX.4.44.0309191005270.17132-100000@deadlock.et.tudelft.nl>
Message-Id: <1063960697.631.54.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 19 Sep 2003 10:38:17 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: Patch: Make iBook1 work again
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > and we don't need to mess with the MLCK/XCLK any more on radeons.
> 
> Actually I think we need that urgently. I cannot have my Inspiron 4500
> laptop (Radeon 7500) on my, ehm, what's the english word, upper legs or
> something, for along time, the amount of heat generated is incredible.
> In Windows this is not a problem, only when you start playing games it gets hot.

You don't need tweaking those clock neither. The mobility chips have
dynamic clock & power management capabilities. I have code in radeonfb
to enable those, unfortunately, we (recent radeonfb's and XFree) will
disable most of those features because  of some ASIC rev. bugs. We
should ask ATI some more precise list of which revs are affected and
if there's a better workaround...

> I have some experience with that.
> 
> Because of the way the Atyfb is currently designed, mclk could be an
> artbitrary value and adding XCLK to the table would mean XCLK could be an
> arbitrary value. But without using SCLK, they need to be relative to each
> other i.e. 1/2 3/4 2/3 etc.
> 
> Luckily the BIOS on my Rage LT Pro did use SCLK to clock the engine,
> without that I would never had solved this. And I never found any other
> card that did use SCLK by default. By having the engine clocked
> by SCLK instead of MCLK, you can have both frequencies completely
> independend, just like what was needed.
> 
> It was easier said than done, everytime I did submit code to someone I got
> the reply the computer did crash. I was unable to get this resolved until
> I had a Dell laptop temporarily available to me, which did not crash
> allways, it was just completely random wether the driver would load or
> not.
> 
> As far as I believe now, after you start the SCLK, it doesn't work at
> once. You have to wait a while before a good clock signal is generated.
> Adding a primitive wait loop did solve the problem for about anyone.

Yup, a PLL need time to properly stabilize, especially older ones.

> The conclusion is that the chip cannot be without clock signal even for a
> very short time and it even locks up the AGP so the rest of the computer
> hangs.
> 
> It must be possible to stop the clock; I have a Rage IIc here with a
> broken BIOS, experiments on it show that you can enable the chip using the
> PCI registers without any clock running. Of course I never got the card to
> display anything.

By default, I think, the chip clocks itself on the PCI clock on powerup
(without BIOS). From that, you can then configure the PLLs, switch to PLL
derived clocks, initialize the memory controller, and go on...

But for mobility chips, there are additional "automatic" clock control
features, especially on r128 (M3) and radeons (M6/7/9/10) though I
suppose M1 may have similar features. Look at the code in my version
of radeonfb (2.4, it's not yet in 2.6 mainstream). I _much_ prefer
using those features than tweaking the PLLs, especially on those
new chips.

Ben.

