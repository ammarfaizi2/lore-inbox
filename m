Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264614AbTFKWPs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264618AbTFKWPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:15:48 -0400
Received: from air-2.osdl.org ([65.172.181.6]:28115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264614AbTFKWPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:15:39 -0400
Date: Wed, 11 Jun 2003 15:31:07 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sysfs: Initialization order and system devices
In-Reply-To: <1055369924.4071.19.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306111529260.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Jun 2003, Jeremy Fitzhardinge wrote:

> With the current system device changes (I picked them up in 2.5.70-mm8),
> the system device class assumes that all system device drivers are
> registered before any system devices are registered.
> 
> Unfortunately, this is often not the case.  CPU devices are registered
> very early, but cpufreq registers drivers for them; since cpufreq
> drivers can be loaded as modules, they clearly can't be registered
> before the device is.
> 
> This patch keeps a list of all registered devices hanging off the system
> device class.  When a new driver is registered, it calls the driver's
> add() function with all existing devices.
> 
> Conversely, when a driver is unregistered, it calls the driver's
> remove() function for all existing devices so the driver can clean up.

D'oh. I meant to add this piece for precisely this reason. Thanks, though 
there is one thing: 

+
+       /* If devices of this class already exist, tell the driver */
+       if (drv->add) {
+               struct sys_device *dev;
+               list_for_each_entry(dev, &cls->devices, entry)
+                       drv->add(dev);
+       }
+

in sysdev_driver_register(). You must check that cls is not NULL. I've 
fixed it up and applied it.

Thanks,


	-pat

