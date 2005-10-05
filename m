Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbVJELnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbVJELnP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbVJELnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:43:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39645 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965123AbVJELnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:43:14 -0400
Date: Wed, 5 Oct 2005 13:10:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       spi-devel-general@lists.sourceforge.net, basicmark@yahoo.com,
       stephen@streetfiresound.com, dpervushin@gmail.com
Subject: Re: [PATCH/RFC 1/2] simple SPI framework
Message-ID: <20051005111044.GA22374@elf.ucw.cz>
References: <20051004180241.0EAA5EE8D1@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <4343898D.1060904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343898D.1060904@ru.mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >+#ifdef	CONFIG_PM
> >+
> >+/* Suspend/resume in "struct device_driver" don't really need that
> >+ * strange third parameter, so we just make it a constant and expect
> >+ * SPI drivers to ignore it just like most platform drivers do.
> >+ *
> >
> So you just ignored my letter on that subject :(
> The fact that you don't need it doesn't mean that other people won't.
> The fact that there's no clean way to suspend USB doesn't mean that 
> there shouldn't be one for SPI.

The third parameter really must die. Just because you *can* use it
does not mean you should.

> >+ * NOTE:  the suspend() method for an spi_master controller driver
> >+ * should verify that all its child devices are marked as suspended;
> >+ * suspend requests delivered through sysfs power/state files don't
> >+ * enforce such constraints.
> >+ */
> >+static int spi_suspend(struct device *dev, pm_message_t message)
> >+{
> >+	int	value;
> >+
> >+	if (!dev->driver || !dev->driver->suspend)
> >+		return 0;
> >+
> >+	/* suspend will stop irqs and dma; no more i/o */
> >+	value = dev->driver->suspend(dev, message, SUSPEND_POWER_DOWN);
> > 
> >
> So driver->suspend is going to be called 3 timer with SUSPEND_POWER_DOWN 
> parameter, right?
> I'm afraid that won't work :(

No, it is going to be called once. You perhaps should not pass it
"SUSPEND_POWER_DOWN" but something else; but drivers should really
ignore it. [You are calling it for normal suspend, right? Not just
before power down.]

> Especially in our case, where we *do need* preparation steps that are 
> taken in *normal* suspend sequence - i. e. we need to set up the wakeup 
> credentials for the *SPI* since the wakeup's gonna happen from a call 
> incoming through the network module residing on the SPI bus!

You should not need more than one phase.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
