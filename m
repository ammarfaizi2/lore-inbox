Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbVJEJZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbVJEJZb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 05:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbVJEJZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 05:25:31 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:31150 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S965094AbVJEJZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 05:25:30 -0400
Date: Wed, 5 Oct 2005 05:30:11 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Vitaly Wool <vwool@ru.mvista.com>, David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net,
       basicmark@yahoo.com, stephen@streetfiresound.com, dpervushin@gmail.com,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH/RFC 1/2] simple SPI framework
Message-ID: <20051005093011.GC14734@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Vitaly Wool <vwool@ru.mvista.com>,
	David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net, basicmark@yahoo.com,
	stephen@streetfiresound.com, dpervushin@gmail.com,
	Pavel Machek <pavel@ucw.cz>
References: <20051004180241.0EAA5EE8D1@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <4343898D.1060904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343898D.1060904@ru.mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 12:06:37PM +0400, Vitaly Wool wrote:
> David,
> 
> >+#ifdef	CONFIG_PM
> >+
> >+/* Suspend/resume in "struct device_driver" don't really need that
> >+ * strange third parameter, so we just make it a constant and expect
> >+ * SPI drivers to ignore it just like most platform drivers do.
> >+ *
> > 
> >
> So you just ignored my letter on that subject :(
> The fact that you don't need it doesn't mean that other people won't.
> The fact that there's no clean way to suspend USB doesn't mean that 
> there shouldn't be one for SPI.
> 
> >+ * NOTE:  the suspend() method for an spi_master controller driver
> >+ * should verify that all its child devices are marked as suspended;
> >+ * suspend requests delivered through sysfs power/state files don't
> >+ * enforce such constraints.

But we should, right?  It seems like a child device should never be in a
higher suspend state than its parents.  The rule doesn't have to hold with
driver-initiated runtime power management, but when the user requests a
suspend via power/state, it's reasonable to assume every child should
be suspended first.

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
> Especially in our case, where we *do need* preparation steps that are 
> taken in *normal* suspend sequence - i. e. we need to set up the wakeup 
> credentials for the *SPI* since the wakeup's gonna happen from a call 
> incoming through the network module residing on the SPI bus!

So...

1.) suspend all child devices
2.) calculate their wake requirements
3.) suspend the parent to a degree compatible with those requirements

Right?

Thanks,
Adam
