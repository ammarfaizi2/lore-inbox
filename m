Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263721AbTIHXKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbTIHXKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:10:35 -0400
Received: from mail.kroah.org ([65.200.24.183]:5068 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263721AbTIHXIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:08:36 -0400
Date: Mon, 8 Sep 2003 16:08:52 -0700
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6][CFT] rmmod floppy kills box fixes + default_device_remove
Message-ID: <20030908230852.GA3320@kroah.com>
References: <Pine.LNX.4.53.0309072228470.14426@montezuma.fsmlabs.com> <20030908155048.GA10879@kroah.com> <Pine.LNX.4.53.0309081722270.14426@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309081722270.14426@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 05:27:10PM -0400, Zwane Mwaikambo wrote:
> > What happens if someone grabs the struct device reference by opening a
> > sysfs file and then you unload the module?  Yeah, not nice.  Please do
> 
> Doesn't this all get taken care of by the platform_device_unregister?

No it doesn't, sorry.

> > _not_ create "empty" release() functions, unless you _really_ know what
> > you are doing (and providing a "default" one like this is just ripe for
> > abuse, that warning message in the kernel is there for a reason.)
> 
> I know it's begging for abuse, but i don't want to sprinkle empty 
> release() functions everywhere, e.g. looking at the floppy driver, i'm 
> not quite sure what i'm supposed to do with a release() function there, 
> the struct platform_device_struct is statically allocated.

You need to sleep until your release function gets called.  Take a look
at the cpufreq code for an example of this (also the i2c core does
this.)

> Basically i'd like a pointer as to what to do with these release()
> functions..

release() is called when the last reference to this device is dropped.
When it is called it is then safe to do the following:
	- free the memory of the device
	- unload the module of the device

So an empty release() function is the wrong thing to do in 99.99% of the
situations in the kernel (the one exception seems to be the mca release
function that recently got added for use when the bus is doing probing
logic.)

Does this help out?

thanks,

greg k-h
