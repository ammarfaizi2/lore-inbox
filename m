Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbTEPXZN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264611AbTEPXZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:25:12 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:18321 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264610AbTEPXZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:25:08 -0400
Date: Sat, 17 May 2003 01:37:52 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030516233751.GA2045@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030515200324.GB12949@ranty.ddts.net> <20030516223624.GA16759@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20030516223624.GA16759@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 16, 2003 at 03:36:24PM -0700, Greg KH wrote:
> On Thu, May 15, 2003 at 10:03:24PM +0200, Manuel Estrada Sainz wrote:
> >  Hi all,
> > 
> >  This time, as Greg suggested, it is implemented on top of 'struct
> >  class' and 'struct class_device' but the driver interface is the same
> >  as last time.
> 
> First off, nice, this looks a lot better, good job.

 Thanks for the positive feedback.
 
> >  Attached:
> >  	firmware.h
> > 	firmware_class.c:
> > 		The firmware support itself.
> 
> Can you just send this as a patch to the current kernel next time?  It's
> much easier to read and test with that way :)

 The next one will come in that form.

> > 	firmware_sample_driver.c:
> > 		Sample code on how to use from drivers.
> 
> I didn't see this in the files you attached.

 Sorry, I thought I did, attached now.

> > 	hotplug:
> > 		A simple hotplug replacement for testing.
> > 	Makefile:
> > 		The obvious.
> > 	README:
> > 		Still pertinent pieces from the previous round.
> > 
> >  How it works:
> > 	- Driver calls request_firmware()
> 
> Yeah, I agree with your comment in the code, I think a struct device *
> should be passed here.  Or at least somewhere...

 To make compatibility with 2.4 kernel easier, I think that I'll add a
 new 'struct device *' parameter to request_firmware(). On 2.4 kernels
 it can be an unused 'void *'. Does that sound too ugly?

> > 	- 'hotplug firmware' gets called with ACCTION=add
> 
> I don't see why you need to add a new environment variable in your
> firmware_class_hotplug() call.  What is the FIRMWARE variable for, if we
> already have a device symlink back to the device that is asking for the
> firmware?  Oh, you don't have that :)

 The same device can ask for different firmware images.

 Orinoco USB devices have one image for the USB<->PCMCIA bridge, one
 secondary firmware for the hermes chipset, and if we managed to get it
 into master mode tertiary firmware for the hermes chipset. So just
 knowing which device we have doesn't tell which firmware we need.

 I guess that all three images could be packed into a single file.
 I find the FIRMWARE variable cleaner, but I really wouldn't mind.
 
> > 	- /sysfs/class/firmware/dev_name/{data,loading} show up.
> 
> If you pass a struct device to request_firmware(), then you get a
> symlink to the device for free.  You can also set the class_id to the
> device bus_id, watching out for name collisions (bus_ids are only unique
> per bus type, so different bus types can use the same bus id, but in
> reality they rarely do.)

 OK, sounds good. I'll try that.

> > 	- echo 1 > /sysfs/class/firmware/dev_name/loading
> > 	- cat whatever_fw > /sysfs/class/firmware/dev_name/data
> > 	- echo 0 > /sysfs/class/firmware/dev_name/loading
> 
> Nice, but can't you get rid of the loading file by just relying on
> open() and close()?  Oh wait, sysfs doesn't pass that down to you, hm,
> looks like you need that info.  But does the new binary interface in
> sysfs that just got merged into the tree provide that info for you?

 Nop. Although since I seam to be the first user of that interface,
 adding support for that shouldn't break anything.

> > 	- The call to request_firmware() returns with the firmware in a
> > 	  memory buffer and the driver can finish loading.
> 
> request_firmware() can't use a static struct class_device, like you have
> it, in order to work properly for multiple calls to request_firmware()
> at the same time by different drivers.  Just create a new struct
> class_device, and put it on a list, like I had to do for the tty class
> code (and i2c_dev class code, but that isn't in the kernel to look at
> yet...)

 Sorry, I don't know how that 'static' got there, I just wanted to
 allocate it on the stack. But I guess that it should be dynamically
 allocated anyway. Do I really need to put it on a list?

> Other than those very minor tweaks, I like this interface, it's looking
> very good.  I wouldn't worry about any "checksum" calcuation crud, it's
> up to the userspace tool dumping the firmware to the kernel to make sure
> it's writing correct data, not the kernel.

 That is what I thought.
 
> thanks,

 Thank you

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--vtzGhvizbBRQ85DL
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: inline; filename="firmware_sample_driver.c"

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include "firmware.h"

#define WE_CAN_NEED_FIRMWARE_BEFORE_USERSPACE_IS_AVAILABLE
#ifdef WE_CAN_NEED_FIRMWARE_BEFORE_USERSPACE_IS_AVAILABLE
char __init inkernel_firmware[] = "let's say that this is firmware\n";
#endif

static void sample_firmware_load(char *firmware, int size)
{
	printk("firmware_sample_driver: firmware: %s\n", firmware);
}

static void sample_probe_default(void)
{
	/* uses the default method to get the firmware */
        const struct firmware *fw_entry;
	printk("firmware_sample_driver: a ghost device got inserted :)\n");

        if(request_firmware(&fw_entry, "sample_driver_fw", "ghost0")!=0)
	{
		printk(KERN_ERR
		       "firmware_sample_driver: Firmware not available\n");
		return;
	}
	
	sample_firmware_load(fw_entry->data, fw_entry->size);

	release_firmware(fw_entry);

	/* finish setting up the device */
}
static void sample_probe_specific(void)
{
	/* Uses some specific hotplug support to get the firmware from
	 * userspace  directly into the hardware, or via some sysfs file */
	printk("firmware_sample_driver: a ghost device got inserted :)\n");

        if(request_firmware(NULL, "sample_driver_fw", "ghost0")!=0)
	{
		printk(KERN_ERR
		       "firmware_sample_driver: Firmware load failed\n");
		return;
	}
	
	/* request_firmware blocks until userspace finished, so at
	 * this point the firmware should be already in the device */

	/* finish setting up the device */
}

static int sample_init(void)
{
#ifdef WE_CAN_NEED_FIRMWARE_BEFORE_USERSPACE_IS_AVAILABLE
	register_firmware("sample_driver_fw", inkernel_firmware,
			  sizeof(inkernel_firmware));
#endif
	/* since there is no real hardware insertion I just call the
	 * sample probe functions here */
	sample_probe_specific();
	sample_probe_default();
	return 0;
}
static void __exit sample_exit(void)
{
}

module_init (sample_init);
module_exit (sample_exit);

MODULE_LICENSE("GPL");

--vtzGhvizbBRQ85DL--
