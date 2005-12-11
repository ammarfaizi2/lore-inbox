Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVLKTmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVLKTmw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVLKTmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:42:52 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:52493 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750830AbVLKTmv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:42:51 -0500
Date: Sun, 11 Dec 2005 20:44:58 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [PATCH] Minor change to platform_device_register_simple
 prototype
Message-Id: <20051211204458.22c60123.khali@linux-fr.org>
In-Reply-To: <20051208215257.78d7c67a.khali@linux-fr.org>
References: <20051205212337.74103b96.khali@linux-fr.org>
	<20051205202707.GH15201@flint.arm.linux.org.uk>
	<200512070105.40169.dtor_core@ameritech.net>
	<d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com>
	<20051207180842.GG6793@flint.arm.linux.org.uk>
	<d120d5000512071023u151c42f4lcc40862b2debad73@mail.gmail.com>
	<20051207190352.GI6793@flint.arm.linux.org.uk>
	<d120d5000512071418q521d2155r81759ef8993000d8@mail.gmail.com>
	<20051207225126.GA648@kroah.com>
	<d120d5000512071459s9b461d8ye7abc41d0e1950fd@mail.gmail.com>
	<20051208215257.78d7c67a.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmirty, Russell, Greg,

Quoting myself:
> I second Dmitry's request here. I can't seem to possibly build a valid
> error path during device registration with the current API. Having
> platform_device_del() would make it possible.

I since modified the platform driver I am working on, thanks to the
guidance of Alessandro Zummo, and found that the new implementation no
longer needs platform_device_del().

My original code was registering a platform_driver, but wasn't actually
using it. In particular, the driver had no probe and remove functions.
Everything was done directly through the init and exit functions of the
module.

The new code makes proper use of platform_driver's probe and remove
function pointers. This means that the initial platform_device
registration ends with a call to platform_device_add(), and as a
consequence, the error path doesn't need platform_device_del().

So, provided that my case can be extended to others, I'd guess that
platform drivers using platform_driver.probe are likely not to need
platform_device_del(), while drivers not using platform_driver.probe
may need it. This may explain why platform_device_del wasn't needed so
far.

This raises a question. For a module which registers both the
platform_device and the matching platform_driver (as is the case for
mine), is it considered better to rely on platform_driver.probe
and .remove (as my new code does)? Or is it OK to omit these and handle
initialization and cleanup phases more direclty (as my old code did),
as this is technically possible? Using .probe and .remove looks cleaner
with regards to the driver model, but it also makes things a little
more complex.

If the goal is to always use .probe and .remove, then
platform_device_del() might become unneeded again in the long run.

Thanks,
-- 
Jean Delvare
