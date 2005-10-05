Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbVJEIFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVJEIFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 04:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVJEIFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 04:05:07 -0400
Received: from [85.21.88.2] ([85.21.88.2]:56720 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932563AbVJEIFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 04:05:06 -0400
Message-ID: <4343898D.1060904@ru.mvista.com>
Date: Wed, 05 Oct 2005 12:06:37 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net,
       basicmark@yahoo.com, stephen@streetfiresound.com, dpervushin@gmail.com,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH/RFC 1/2] simple SPI framework
References: <20051004180241.0EAA5EE8D1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20051004180241.0EAA5EE8D1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

>+#ifdef	CONFIG_PM
>+
>+/* Suspend/resume in "struct device_driver" don't really need that
>+ * strange third parameter, so we just make it a constant and expect
>+ * SPI drivers to ignore it just like most platform drivers do.
>+ *
>  
>
So you just ignored my letter on that subject :(
The fact that you don't need it doesn't mean that other people won't.
The fact that there's no clean way to suspend USB doesn't mean that 
there shouldn't be one for SPI.

>+ * NOTE:  the suspend() method for an spi_master controller driver
>+ * should verify that all its child devices are marked as suspended;
>+ * suspend requests delivered through sysfs power/state files don't
>+ * enforce such constraints.
>+ */
>+static int spi_suspend(struct device *dev, pm_message_t message)
>+{
>+	int	value;
>+
>+	if (!dev->driver || !dev->driver->suspend)
>+		return 0;
>+
>+	/* suspend will stop irqs and dma; no more i/o */
>+	value = dev->driver->suspend(dev, message, SUSPEND_POWER_DOWN);
>  
>
So driver->suspend is going to be called 3 timer with SUSPEND_POWER_DOWN 
parameter, right?
I'm afraid that won't work :(
Especially in our case, where we *do need* preparation steps that are 
taken in *normal* suspend sequence - i. e. we need to set up the wakeup 
credentials for the *SPI* since the wakeup's gonna happen from a call 
incoming through the network module residing on the SPI bus!

Vitaly
