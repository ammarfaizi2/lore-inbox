Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWGYTHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWGYTHD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWGYTHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:07:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30113 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964809AbWGYTHB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:07:01 -0400
Date: Tue, 25 Jul 2006 12:06:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Magnus =?ISO-8859-1?B?VmlnZXJs9mY=?= <wigge@bigfoot.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       wigge@bigfoot.com, "Ping Cheng" <pingc@wacom.com>
Subject: Re: [RFC] input: Wacom tablet driver for simple X hotplugging
Message-Id: <20060725120645.b4dc98ab.akpm@osdl.org>
In-Reply-To: <20060721211341.5366.93270.sendpatchset@pipe>
References: <20060721211341.5366.93270.sendpatchset@pipe>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2006 23:13:41 +0200
Magnus  Vigerlöf <wigge@bigfoot.com> wrote:

> Hi,
> 
> I've been working on a device driver that simplifies hotplugging Wacom
> tablets when running X.
> 
> I've posted the driver on the linuxwacom m-l and the response so far
> has been positive as it makes hot-plugging Wacom tablets even easier,
> but questions has been rised if this couldn't be made into a generic
> module for other devices than Wacom tablets.
> 
> The 'problem' is that the normal evdev-driver removes the inputX
> device when the physical device is unplugged and this causes the
> X-server to close the device and not re-open it until the user
> switches VT.
> 
> My device driver (patch attached below) works pretty much like the
> evdev-driver except that it it registers one device when it is loaded
> and simulates a Wacom tablet even when none is connected to the
> system. This way the X-server will never notice the absence of a
> tablet and whenever a tablet is (re)connected it will work without any
> tricks.
> 
> 
> I'd appreciate whether you think this is a viable idea to make it as a
> generic driver instead or should I continue with the Wacom-specific
> one. I know the 'right' thing would be to make X truly hot-plug aware,
> but this driver is something that would be possible to use in current
> systems without any problems.
> 
> If it is a viable idea; Which other devices/types of device do you
> think could be of interest to handle in a similar fashion? Tablets of
> different makes/models are obvious, but are there any others that
> would benefit from a similar driver?
> 
> And third, should something like this be a separate driver or should
> the functionallity be included in the evdev-driver?
> 
> 
> Note, the patch is included for idea visualization and not by any
> means something I consider ready to be submitted. I know I have a few
> issues that I must sort out first, however it does work in its current
> state.
> 

The patch adds rather a lot of trailing whitespace.  I trim that off when
applying; others do not.


> +#include <asm/semaphore.h

Semaphores are deprecated.  Unless you actually _need_ the sempahore's
counting feature, please use mutexes.

> +static int exclusivegrab = 0;
> +static int debugconnect = 0;
> +static short openfailcount = 0;

Avoid the initialisation-to-zero.  The C runtime will zero these anyway,
and the explicit initialisation will move these variables into the data
section and hence into the on-disk vmlinux inage.

> +#ifdef OPENFAILCOUNT
> +module_param(openfailcount, short, 0644);
> +MODULE_PARM_DESC(openfailcount, "Number of upcoming open that will fail"
> +		 " with -ENODEV.");
> +#endif

What is this??

> +static int str_to_user(const char *str, unsigned int maxlen,
> +		       void __user *p)
> +{
> +	int len;
> +
> +	if (!str)
> +		return -ENOENT;
> +
> +	len = strlen(str) + 1;
> +	if (len > maxlen)
> +		len = maxlen;
> +
> +	return copy_to_user(p, str, len) ? -EFAULT : len;
> +}

If (len > maxlen) this will send userspace a non-null-terminated string.

> +/* ################################################################### */
> +/*                  Module File Methods                                */
> +/* ################################################################### */
> +static int wp_open(struct inode *inodp, struct file *filp)
> +{
> +	struct wp_filenode *list;
> +
> +	if (openfailcount > 0) {
> +		openfailcount--;
> +		return -ENODEV;
> +	}
> +
> +	if (!(list = kzalloc(sizeof(*list), GFP_KERNEL)))
> +		return -ENOMEM;
> +
> +	filp->private_data = list;
> +	list->tabletid = wp_proxyhndl.tabletid;
> +
> +	down(&wp_sema);
> +	list_add_tail(&list->node, &wp_users);
> +	if (wp_currenthndl != &wp_proxyhndl) {
> +		if (!(wp_currenthndl->flags & WP_FLAG_OPEN)) {
> +			if (!input_open_device(&wp_currenthndl->handle))
> +				wp_currenthndl->flags |= WP_FLAG_OPEN;
> +			else
> +				printk(KERN_WARNING WP_MODNAME
> +				       ": Failed to open '%s'\n",
> +				       wp_currenthndl->devdesc);
> +		}
> +	}
> +	up(&wp_sema);
> +	return 0;
> +}

If input_open_device() fails then the whole open() should fail.  That way
there will be no close(), flush() or release().

> +		if(copy_to_user(ip, &wp_proxydev.id, sizeof(struct input_id)))

We put a space between the `if' and the `(' (review the entire patch for
this).

> +	/* the id as all must close/reopen again anyway. */
> +	else if (!list_empty(&wp_users)) {
> +		if (!input_open_device(&devh->handle)) {
> +			devh->flags |= WP_FLAG_OPEN;
> +			if (wp_devgrabcount > 0) {
> +				if (!input_grab_device(&devh->handle))
> +					devh->flags |= WP_FLAG_GRAB;
> +				else
> +					printk(KERN_WARNING WP_MODNAME
> +					       ": Failed to grab '%s'\n",
> +					       dev->name);
> +			}
> +		}
> +		else
> +			printk(KERN_WARNING WP_MODNAME
> +			       ": Failed to open '%s'\n", dev->name);
> +	}
> +}

Again, just emitting a printk seems insufficient here.


