Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbVLKWK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVLKWK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 17:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbVLKWK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 17:10:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2833 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750878AbVLKWK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 17:10:59 -0500
Date: Sun, 11 Dec 2005 22:10:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: More platform driver questions
Message-ID: <20051211221034.GE22537@flint.arm.linux.org.uk>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>
References: <20051211220023.19820e47.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211220023.19820e47.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 10:00:23PM +0100, Jean Delvare wrote:
> 1* What are the actual differences between device.platform_data and
> device.driver_data? I had never been using .platform_data so far. Are
> there rules to determine what data belongs to each?

platform_data should contain platform specific data which is relevant
to the device in question, and which the device driver may read in
order to adapt itself for driving the device on the platform.  eg,
configuration information.

driver_data is data which is owned by the driver, for use in driving
the device.  Eg, a pointer to the struct net_device structure for
network device drivers.

> My own platform device has the following data:
> * base I/O address
> * chip name
> * 2 semaphores
> * class device pointer
> * cached register values and cache management variables
> 
> The base I/O address seemed to belong to .platform_data, as this is the
> only way I have to pass the information through the .probe mechanism
> (or should I use platform_get_resource instead?) All the rest I have
> put in .driver_data. Actually, I even duplicated the base I/O address
> there, as it made the rest of the code much more simple.

You should generally use the resources to pass address information.

> Alessandro Zummo, who helped me convert my driver at first, had put
> almost everything in .platform_data and only the class device pointer
> in .driver_data. That worked too. Question is, what is the proper way
> of splitting things, if such a way has been defined?

That doesn't sound quite right, but it depends on what the platform
driver is doign.

> 2* Is it OK to tag platform_driver.probe and .remove __devinit and
> __devexit, respectively?

Yes, provided that you only have one platform device which is never
removed independently of being a module or hotplug.

> It seems to make sense conceptually, but as
> almost no platform driver seem to actually do that, I'm wondering. It
> might even make sense to tag them __init and __exit when the same
> module registers and unregisters both the platform_device and the
> matching platform_driver. Is it acceptable?

See above, but omit the "hotplug" case - having the platform device
in with the driver does mean that the only time _that_ device gets
unregistered is when you remove the module, in which case the __exit
code will be retained.  So the condition comes down to "only have
one platform device for this driver".

> 3* Not related to platform drivers in particular, but that's where I
> saw it for the first time...
> 
> It seems that in most .remove functions, we explicitely set the driver
> data pointer to NULL before freeing the associated memory. I am
> wondering why. Can someone explain? Given that the device is just being
> deleted anyway, I don't quite see the benefit in doing so. But I guess
> I am once again missing something obvious.

This depends on your point of view - whether you think there's a
possibility that the driver_data might be accessed somehow after
you've freed the pointer.  Having a NULL pointer will give you a
very deterministic failure.

Of course, it can also be viewed as needless code and therefore not
required.  Again, it's an opinion thing.

> [patch]

Looks fine, though see above comments concerning the platform data
vs the resources.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
