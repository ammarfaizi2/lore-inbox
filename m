Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTEPWWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 18:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTEPWWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 18:22:12 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:13047 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262148AbTEPWWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 18:22:11 -0400
Date: Fri, 16 May 2003 15:36:24 -0700
From: Greg KH <greg@kroah.com>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030516223624.GA16759@kroah.com>
References: <20030515200324.GB12949@ranty.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515200324.GB12949@ranty.ddts.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 10:03:24PM +0200, Manuel Estrada Sainz wrote:
>  Hi all,
> 
>  This time, as Greg suggested, it is implemented on top of 'struct
>  class' and 'struct class_device' but the driver interface is the same
>  as last time.

First off, nice, this looks a lot better, good job.

>  Attached:
>  	firmware.h
> 	firmware_class.c:
> 		The firmware support itself.

Can you just send this as a patch to the current kernel next time?  It's
much easier to read and test with that way :)

> 	firmware_sample_driver.c:
> 		Sample code on how to use from drivers.

I didn't see this in the files you attached.

> 	hotplug:
> 		A simple hotplug replacement for testing.
> 	Makefile:
> 		The obvious.
> 	README:
> 		Still pertinent pieces from the previous round.
> 
>  How it works:
> 	- Driver calls request_firmware()

Yeah, I agree with your comment in the code, I think a struct device *
should be passed here.  Or at least somewhere...

> 	- 'hotplug firmware' gets called with ACCTION=add

I don't see why you need to add a new environment variable in your
firmware_class_hotplug() call.  What is the FIRMWARE variable for, if we
already have a device symlink back to the device that is asking for the
firmware?  Oh, you don't have that :)

> 	- /sysfs/class/firmware/dev_name/{data,loading} show up.

If you pass a struct device to request_firmware(), then you get a
symlink to the device for free.  You can also set the class_id to the
device bus_id, watching out for name collisions (bus_ids are only unique
per bus type, so different bus types can use the same bus id, but in
reality they rarely do.)

> 	- echo 1 > /sysfs/class/firmware/dev_name/loading
> 	- cat whatever_fw > /sysfs/class/firmware/dev_name/data
> 	- echo 0 > /sysfs/class/firmware/dev_name/loading

Nice, but can't you get rid of the loading file by just relying on
open() and close()?  Oh wait, sysfs doesn't pass that down to you, hm,
looks like you need that info.  But does the new binary interface in
sysfs that just got merged into the tree provide that info for you?

> 	- The call to request_firmware() returns with the firmware in a
> 	  memory buffer and the driver can finish loading.

request_firmware() can't use a static struct class_device, like you have
it, in order to work properly for multiple calls to request_firmware()
at the same time by different drivers.  Just create a new struct
class_device, and put it on a list, like I had to do for the tty class
code (and i2c_dev class code, but that isn't in the kernel to look at
yet...)

Other than those very minor tweaks, I like this interface, it's looking
very good.  I wouldn't worry about any "checksum" calcuation crud, it's
up to the userspace tool dumping the firmware to the kernel to make sure
it's writing correct data, not the kernel.

thanks,

greg k-h
