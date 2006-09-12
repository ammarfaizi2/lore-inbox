Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWILD5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWILD5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 23:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWILD5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 23:57:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:44251 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964993AbWILD5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 23:57:18 -0400
Date: Mon, 11 Sep 2006 20:51:31 -0700
From: Greg KH <greg@kroah.com>
To: Miguel Ojeda <maxextreme@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17.13] display: Driver ks0108 and cfag12864b
Message-ID: <20060912035131.GA27472@kroah.com>
References: <653402b90609111627q661cded8l757129311fbe92d4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653402b90609111627q661cded8l757129311fbe92d4@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 01:27:30AM +0200, Miguel Ojeda wrote:
> Miguel Ojeda Sandonis
> 
> Adds support for additional "display" devices, like small LCD screens.
> Adds support for the ks0108 LCD Controller.
> Adds support for the cfag12864b LCD.
> 
> Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
> ---
> diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
> linux-2.6.17.13-vanilla/Documentation/drivers/display/cfag12864b
> linux-2.6.17.13/Documentation/drivers/display/cfag12864b
> --- linux-2.6.17.13-vanilla/Documentation/drivers/display/cfag12864b 
> 1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.17.13/Documentation/drivers/display/cfag12864b	2006-09-12
> 00:10:43.000000000 +0200

The patch is linewrapped :(


> +If you compiled the device as a module, don't remember to
> +update udev to get the new device node at /dev.

Why would you need to touch udev?  It will handle stuff loaded at any
point in time automatically.  You don't have to "update udev" at all.

> +Open the device for writing, /dev/cfag12864b0:
> +
> +	int fd = open("/dev/cfag12864b0",O_WRONLY);
> +
> +Then use simple ioctl calls to control it:
> +
> +	ioctl(fdisplay,CFAG12864B_IOCOFF);	/* Turn off (don't clear) */
> +	ioctl(fdisplay,CFAG12864B_IOCON);	/* Turn on */
> +	ioctl(fdisplay,CFAG12864B_IOCCLEAR);	/* Clear the display */

No, no new ioctls for simple things like this please.  Use sysfs or
something else.


> +Declare the matrix and other one:
> +
> +	unsigned char MyDrawing[CFAG12864B_WIDTH][CFAG12864B_HEIGHT];
> +
> +	unsigned char Buffer[CFAG12864B_FORMATSIZE];
> +
> +Copy the 2d matrix to the buffer , like:
> +
> +	for(i=0;i<CFAG12864B_WIDTH;++i)
> +		for(j=0;j<CFAG12864B_HEIGHT;++j)
> +			Buffer[i+j*CFAG12864B_WIDTH]=MyDrawing[i][j];
> +
> +Call the ioctl:
> +
> +	ioctl(fdisplay,CFAG12864B_IOCFORMAT,Buffer);
> +
> +Voila! Your drawing should appear on the screen.

No, again use sysfs.  We already have one other device in the kernel
tree that is a LCD display that works just fine with no ioctls needed at
all.  Just write the text you wish to see to the sysfs file and it shows
up.  Is usable from _any_ type of program, not just one that is able to
call ioctls (like shell scripts, scripting languages, command lines,
etc.)


> +You can use a copy of this header in your user-space programs.
> +
> +---
> +/*
> + *    Filename: cfag12864b.h
> + *     Version: 0.1.0
> + * Description: cfag12864b LCD Display Driver Header for user-space apps
> + *     License: GPL

Do you really mean for your header file to be under the GPL for
userspace programs?

> linux-2.6.17.13/drivers/display/cfag12864b.c
> --- linux-2.6.17.13-vanilla/drivers/display/cfag12864b.c	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.17.13/drivers/display/cfag12864b.c	2006-09-11
> 23:48:59.000000000 +0200
> @@ -0,0 +1,585 @@
> +/*
> + *    Filename: cfag12864b.c
> + *     Version: 0.1.0
> + * Description: cfag12864b LCD Display Driver
> + *     License: GPL

Which version of the GPL?

> + *     Depends: display ks0108
> + *
> + *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
> + *        Date: 2006-09-10
> + */
> +
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/display.h>
> +#include <linux/ks0108.h>
> +#include <linux/cfag12864b.h>
> +#include <asm/uaccess.h>
> +
> +#define NAME "cfag12864b"
> +#define PRINTK_PREFIX  KERN_INFO NAME ": "
> +
> +
> +
> +//
> +// Device
> +//

No C++ comments please.

> +
> +static const unsigned int FirstMinor = 0;
> +static const unsigned int nDevices = 1;
> +static const char * Name = NAME;
> +
> +static int Major;
> +static dev_t FirstDevice;

No InterCaps for variable names.  Please see Documentation/CodingStyle.

> +void cfag12864b_Write(
> +	unsigned short _Offset,
> +	unsigned char * _Buffer,
> +	unsigned short _Count)

Please run the code through sparse and fix up all of the warnings it
give you.

And does this really need to be a global symbol?

> +int cfag12864b_init(void)
> +{
> +	unsigned int i;
> +	int Result;
> +
> +	printk(PRINTK_PREFIX "Init... ");

Is this really needed?

> +	Result = alloc_chrdev_region(&FirstDevice, FirstMinor, nDevices, 
> Name);
> +	if(Result < 0) {
> +		printk("ERROR - alloc_chrdev_region\n");
> +		return Result;
> +	}
> +	Major = MAJOR(FirstDevice);
> +
> +	Devices = kmalloc(nDevices * sizeof(struct cfag12864b), GFP_KERNEL);
> +	if(Devices == NULL) {
> +		printk("ERROR - kmalloc\n");
> +		return -ENOMEM;
> +	}
> +	memset(Devices, 0, nDevices * sizeof(struct cfag12864b));
> +
> +	for(i=0; i<nDevices; ++i) {
> +		Devices[i].Minor = FirstMinor+i;
> +		Devices[i].Device = MKDEV(Major,Devices[i].Minor);
> +
> +		cdev_init(&(Devices[i].CharDevice), &Fops);
> +		Devices[i].CharDevice.owner = THIS_MODULE;
> +		Devices[i].CharDevice.ops = &Fops;
> +		Result = cdev_add(&(Devices[i].CharDevice),
> +			Devices[i].Device, 1);
> +		if(Result < 0) {
> +			printk("ERROR - cdev_add\n");
> +			kfree(Devices);
> +			return Result;
> +		}
> +
> +		class_device_create(
> +			display_class,NULL,MKDEV(Major,Devices[i].Minor),
> +			NULL,"cfag12864b%d",Devices[i].Minor);

No, just use a "device_create" call, no new class_devices should be
created in the kernel, sorry.  I'm working to remove it from the tree
entirely (look at the -mm tree for those patches.)

> @@ -0,0 +1,60 @@
> +/*
> + *    Filename: display.c
> + *     Version: 0.1.0
> + * Description: Display Class
> + *     License: GPL
> + *     Depends: -
> + *
> + *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
> + *        Date: 2006-09-10
> + */
> +
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/fs.h>
> +#include <linux/device.h>
> +#include <linux/display.h>
> +
> +#define NAME "display"
> +#define PRINTK_PREFIX KERN_INFO NAME ": "
> +
> +static char * Name = NAME;
> +
> +//
> +// Exported Display Data
> +//
> +
> +struct class * display_class;
> +EXPORT_SYMBOL_GPL(display_class);
> +
> +
> +//
> +// Module Init & Exit
> +//
> +
> +int display_init(void)
> +{
> +	display_class = class_create(THIS_MODULE,Name);
> +	if(IS_ERR(display_class)) {
> +		printk(PRINTK_PREFIX "ERROR: class_simple_create\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +void display_exit(void)
> +{
> +	class_destroy(display_class);
> +}
> +
> +module_init(display_init);
> +module_exit(display_exit);
> +
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
> +MODULE_DESCRIPTION("display");

Why do you need a whole new class for this?

"Display" is very generic, people will think it is for video stuff too.
LCD perhaps might be better?

thanks,

greg k-h

