Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTEATfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 15:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbTEATfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 15:35:06 -0400
Received: from cable50a067.usuarios.retecal.es ([212.22.50.67]:25258 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262239AbTEATe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 15:34:58 -0400
Date: Thu, 1 May 2003 21:47:02 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Gibson <david@gibson.dropbear.id.au>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Subject: request_firmware() hotplug interface.
Message-ID: <20030501194702.GA2997@ranty.ddts.net>
Reply-To: ranty@debian.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Hi all,

 After the feedback on fwfs, here is my new attempt to move the firmware
 to userspace.

 This time there is working hotplug functionality including preliminary
 firmware.* hotplug scripts.

 Attached goes the README and sample driver code for easy inspection and
 a full tarball for testing.

 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=README


 request_firmware() hotplug interface:
 ------------------------------------

 This is not finished code, but most of the functionality is already there.

 Why:
 ---

 Today, the most extended way to use firmware in the Linux kernel is linking
 it statically in a header file. Which has political and technical issues:

  1) Some firmware is not legal to redistribute.
  2) The firmware occupies memory permanently, even though it often is just
     used once.
  3) Some people, like the Debian crowd, don't consider some firmware free
     enough and remove entire drivers (e.g.: keyspan).

 What:
 ----

 My current plan consists on implementing two pieces:

 1) A simple interface for drivers to ask for a named piece of firmware via
    hotplug.
 2) A default way to get the firmware from user space into a [virtually]
    contiguous memory buffer for drivers to use with ease.
	- Currently fwfs

 Drivers should be able to use 1) without using 2) as shown in
 firmware_sample_driver.c. In that case arrangements should be made for
 hotplug scripts to do the firmware load by themselves either via sysfs or some
 way else.
 
 As much information as possible should be set on the environment so hotplug
 scripts can do the job when 1) is used without 2). Currently just an string
 provided by the driver is set as 'DEVICE'. Once ported to 2.5 'struct device'
 can be used instead and more information will be available.

 Notes:
 -----

 - Even though the Makefile has 2.5 support the code does not. I'll port it
   once we agree on how all this should be done.

 - Why I don't think any more that sysfs is good as "the default" for
   userspace to provide the firmware:
	- For drivers providing a sysfs entry for firmware:
		It will be trivial to use request_firmware() and arrange the
		hotplug scripts to get it copied to their sysfs firmware
		entry. They don't need any additional support for copying the
		firmware from userspace.
	- For drivers not providing a sysfs entry for firmware:
		They just want the appropriate firmware in a memory buffer. It
		doesn't make much sense to hack some code to get a sysfs entry
		for them and then tell hotplug where to copy the firmware.
		The driver won't know that the entry is there, and it won't
		make sense to write data to it unless requested via hotplug.

   If fwfs is finally not found appropriate, I think that a simpler more
   specific implementation should be better.
	
 - Why OPTIONALLY caching the firmware in-kernel may be a good idea sometimes:
 
	- If the device that needs the firmware is needed to access the
	  filesystem. When upon some error the device has to be reset and the
	  firmware reloaded, it won't be possible to get it from userspace.
	  e.g.:
		- A diskless client with a network card that needs firmware.
		- The filesystem is stored in a disk behind an scsi device
		  that needs firmware.
	- On embedded systems (like install floppies) where there is no
	  userspace hotplug support, 'cp firmware_file /firmware/' can be
	  handy.
	  
   And the same device can be needed to access the filesystem or not depending
   on the setup, so I think that the choice on what firmware to cache should
   be left to userspace.

 - Why register_firmware()+__init can be useful:
 	- For boot devices needing firmware.
	- To make the transition easier:
		The firmware can be declared __init and register_firmware()
		called on module_init. Then the firmware is warranted to be
		there even if "firmware hotplug userspace" is not there jet or
		it doesn't jet provide the needed firmware.
		Once the firmware is widely available in userspace, it can be
		removed from the kernel. Or made optional (CONFIG_.*_FIRMWARE).

	In either case, if firmware hotplug support is there, it can move the
	firmware out of kernel memory into the real filesystem for later
	usage (like the provided hotplug scripts do).

--yNb1oOkm5a9FJOVX
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

static int __init sample_init(void)
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

--yNb1oOkm5a9FJOVX
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="request_firmware-2003-05-01.tar.bz2"
Content-Transfer-Encoding: base64

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

--yNb1oOkm5a9FJOVX--
