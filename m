Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTEUHmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbTEUHlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:41:24 -0400
Received: from zeus.kernel.org ([204.152.189.113]:38870 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261414AbTEUHlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:41:05 -0400
Date: Wed, 21 May 2003 00:23:18 -0700
From: Greg KH <greg@kroah.com>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030521072318.GA12973@kroah.com>
References: <20030517221921.GA28077@ranty.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030517221921.GA28077@ranty.ddts.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, forgot to respond to this, sorry...

On Sun, May 18, 2003 at 12:19:22AM +0200, Manuel Estrada Sainz wrote:
>  Hi,
> 
>  There is some new stuff:
>  -----------------------
> 
>  - 'struct device *device' is used instead of 'char *device'. So we now
>    have the device symlink :)

Nice.

>  - request_firmware_nowait is implemented, please comment on it.

Looks sane.

>  - It doesn't abuse the stack any more, or at least not that much :)

Thanks.

>  - There is a timeout, changeable from userspace. Feedback on a
>    reasonable default value appreciated.

Is this really needed?  Especially as you now have:

>  - Extended 'loading' semantics:
>  	echo 1 > loading:
> 		start a new load, and flush any data from a previous
> 		partial load.
> 	echo 0 > loading:
> 		finish load.
> 	echo -1 > loading:
> 		cancel load and give an error to the driver.

Looks good.

I'd recommend sending the sysfs patches to Pat Mochel.  He's the one to
take those.

Some minor comments about the code:

> diff --exclude=CVS -urN linux-2.5.orig/drivers/base/Makefile linux-2.5.mine/drivers/base/Makefile
> --- linux-2.5.orig/drivers/base/Makefile	2003-05-17 20:44:03.000000000 +0200
> +++ linux-2.5.mine/drivers/base/Makefile	2003-05-17 23:17:21.000000000 +0200
> @@ -3,4 +3,6 @@
>  obj-y			:= core.o sys.o interface.o power.o bus.o \
>  			   driver.o class.o platform.o \
>  			   cpu.o firmware.o init.o
> +obj-m			:= firmware_class.o firmware_sample_driver.o \
> +			   firmware_sample_firmware_class.o

Why make the firmware_class.o always a module?  Shouldn't it only be
included in the core, if a driver that uses it is selected?

> +static inline struct class_device *to_class_dev(struct kobject *obj)
> +{
> +	return container_of(obj,struct class_device,kobj);
> +}
> +static inline
> +struct class_device_attribute *to_class_dev_attr(struct attribute *_attr)
> +{
> +	return container_of(_attr,struct class_device_attribute,attr);
> +}

Move these two to drivers/base/base.h as they shouldn't be defined in
two different files.

> +int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
> +int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);

If you need these, add them to include/linux/sysfs.h.

> +struct firmware_priv {
> +	char fw_id[FIRMWARE_NAME_MAX];
> +	struct completion completion;
> +	struct bin_attribute attr_data;
> +	struct firmware *fw;
> +	s32 loading:2;
> +	u32 abort:1;

Why s32 and u32?  Why not just ints for both of them?

> +struct class firmware_class = {
> +        .name           = "firmware",
> +	.hotplug        = firmware_class_hotplug,
> +};

Oops, forgot tabs there...

> +	switch(fw_priv->loading){

Please add a space before the '{'.

> +	case 0:
> +		if(prev_loading==1)

And a space after the if.  You do this in lots of places.

Other than those very minor things, this looks quite good.

thanks,

greg k-h
