Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWC2DpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWC2DpU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 22:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWC2DpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 22:45:20 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:33988 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S1750735AbWC2DpT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 22:45:19 -0500
Date: Tue, 28 Mar 2006 22:45:10 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>,
       Ian Campbell <icampbell@arcom.com>
Subject: Re: I2C_PCA_ISA causes boot delays (was re: sis96x compiled in by error: delay of one minute at boot)
Message-ID: <20060329034510.GA8309@jupiter.solarsys.private>
References: <20060317042019.GC3446@jupiter.solarsys.private> <20060320230037.29764.qmail@web26902.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320230037.29764.qmail@web26902.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Etienne, Ian:

Etienne: sorry for the delay... I have't forgotten about you.

Recap for Ian: Etienne was suffering very long delays at boot time due
to some combination of I2C / hwmon drivers built-in (not modular) to
his kernel.

* Etienne Lorrain <etienne_lorrain@yahoo.fr> [2006-03-21 00:00:37 +0100]:
> --- "Mark M. Hoffman" wrote:
> > * Etienne Lorrain [2006-03-16 11:53:32 +0100]:
> > >  I did not built with all hwmon drivers because I could determine what I
> > >  had on my mainboard.
> > 
> > Really?  If you don't have all the hwmon drivers built in, then I'm not
> > sure how the i2c subsystem could take so long to init.  Can we see the
> > entire kernel config please?
> 
>    That is the real 2.6.16 with only CONFIG_I2C_VIAPRO=y (the only I2C module loaded
>  using Knoppix on my motherboard) (full .config attached):

OK: you didn't have all the hwmon/sensors drivers built in, just seven of
them.  ;)  This really is not a good idea.  In an ideal world, these drivers
would notice that the hardware is not present and move on.  But I2C/SMBus is
not like PCI.  There is no single ID to read and test.  This hardware is only
recognized based on heuristics.  And the probing itself takes time: especially
if you have a very slow I2C bus.  More on that later...

> 885c885
> < # CONFIG_I2C_PCA_ISA is not set
> ---
> > CONFIG_I2C_PCA_ISA=y

This alone is the cause of the delay.  (I have confirmed it by running some
similar .configs here.)  You almost certainly don't own this specialized
piece of hardware.  Worse still, that particular driver has no code to detect
whether or not the hardware is present.  I cc'ed the listed driver author
(Ian) just in case this might be corrected... but I guess there is no way
to fix it.

So the delay is (1) an I2C bus driver that is not actually present, trying to
probe for (2) seven different sensors chip drivers that certainly aren't present
on the nonexistent bus.  Timeouts ensue.

So unless Ian knows a better way to detect that bus driver... the best I can
advise is to *not* build in those drivers for hardware that you do not have.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

