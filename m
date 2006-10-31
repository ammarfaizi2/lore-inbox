Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946019AbWJaVX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946019AbWJaVX3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946020AbWJaVX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:23:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:26752 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1946019AbWJaVX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:23:28 -0500
Date: Tue, 31 Oct 2006 13:22:05 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       harald@redhat.com
Subject: Re: RFC: libusual piggybacks the class mechanism
Message-ID: <20061031212205.GA21611@kroah.com>
References: <20061016163722.cb9427c0.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016163722.cb9427c0.zaitcev@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 04:37:22PM -0700, Pete Zaitcev wrote:
> Hi, Greg:
> 
> I would like you to opine about a fix which I wrote for libusual.
> First, the patch:
> 
> diff -urp -X dontdiff linux-2.6.18/drivers/usb/storage/libusual.c linux-2.6.18-ub/drivers/usb/storage/libusual.c
> --- linux-2.6.18/drivers/usb/storage/libusual.c	2006-04-10 23:26:03.000000000 -0700
> +++ linux-2.6.18-ub/drivers/usb/storage/libusual.c	2006-10-15 23:46:52.000000000 -0700
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/device.h>
>  #include <linux/usb.h>
>  #include <linux/usb_usual.h>
>  #include <linux/vmalloc.h>
> @@ -13,6 +14,7 @@
>   */
>  #define USU_MOD_FL_THREAD   1	/* Thread is running */
>  #define USU_MOD_FL_PRESENT  2	/* The module is loaded */
> +#define USU_MOD_FL_FAILED   3	/* The module failed to load */
>  
>  struct mod_status {
>  	unsigned long fls;
> @@ -33,8 +35,12 @@ static DECLARE_MUTEX_LOCKED(usu_init_not
>  static DECLARE_COMPLETION(usu_end_notify);
>  static atomic_t total_threads = ATOMIC_INIT(0);
>  
> +static int usu_kick(unsigned long type);
>  static int usu_probe_thread(void *arg);
>  
> +static struct class *usu_class;
> +static struct class_device *usu_class_device;

Use a "struct device" instead please.  class_device is going away.

>  /*
>   * The table.
>   */
> @@ -113,16 +119,44 @@ EXPORT_SYMBOL_GPL(usb_usual_check_type);
>  
>  /*
>   */
> +static int usu_uevent(struct class_device *class_dev,
> +    char **envp, int num_envp, char *buffer, int buffer_size)
> +{
> +	unsigned long flags;
> +	int i;
> +
> + /* P3 */ printk("libusual: uevent\n");
> +	for (i = 1; i < 3; i++) {
> +		spin_lock_irqsave(&usu_lock, flags);
> +		if (stat[i].fls & USU_MOD_FL_FAILED) {
> + /* P3 */ printk("libusual: kicking %s\n", bias_names[i]);
> +			stat[i].fls &= ~USU_MOD_FL_FAILED;
> +			spin_unlock_irqrestore(&usu_lock, flags);
> +			usu_kick(i);
> +		} else {
> +			spin_unlock_irqrestore(&usu_lock, flags);
> +		}
> +	}
> +	return 0;
> +}
> +
> +/*
> + */
>  static int usu_probe(struct usb_interface *intf,
>  			 const struct usb_device_id *id)
>  {
>  	unsigned long type;
> -	int rc;
> -	unsigned long flags;
>  
>  	type = USB_US_TYPE(id->driver_info);
>  	if (type == 0)
>  		type = atomic_read(&usu_bias);
> +	return usu_kick(type);
> +}
> +
> +static int usu_kick(unsigned long type)
> +{
> +	int rc;
> +	unsigned long flags;
>  
>  	spin_lock_irqsave(&usu_lock, flags);
>  	if ((stat[type].fls & (USU_MOD_FL_THREAD|USU_MOD_FL_PRESENT)) != 0) {
> @@ -186,10 +220,14 @@ static int usu_probe_thread(void *arg)
>  	if (rc == 0 && (st->fls & USU_MOD_FL_PRESENT) == 0) {
>  		/*
>  		 * This should not happen, but let us keep tabs on it.
> +		 * One common source of this a user who builds USB statically,
> +		 * then uses initrd, and has a USB device. When static devices
> +		 * are probed, request_module() calls a fake modprobe and fails.
>  		 */
>  		printk(KERN_NOTICE "libusual: "
> -		    "modprobe for %s succeeded, but module is not present\n",
> +		    "request for %s succeeded, but module is not present\n",
>  		    bias_names[type]);
> +		st->fls |= USU_MOD_FL_FAILED;
>  	}
>  	st->fls &= ~USU_MOD_FL_THREAD;
>  	spin_unlock_irqrestore(&usu_lock, flags);
> @@ -203,9 +241,27 @@ static int __init usb_usual_init(void)
>  {
>  	int rc;
>  
> +	usu_class = class_create(THIS_MODULE, "libusual");
> +	if (IS_ERR(usu_class)) {
> +		rc = PTR_ERR(usu_class_device);
> +		goto err_class;
> +	}
> +	usu_class_device = class_device_create(usu_class, NULL, 0, NULL, "0");
> +	if (IS_ERR(usu_class_device)) {
> +		rc = PTR_ERR(usu_class_device);
> +		goto err_classdev;
> +	}
> +	usu_class_device->uevent = usu_uevent;
> +
>  	rc = usb_register(&usu_driver);
>  	up(&usu_init_notify);
>  	return rc;
> +
> +	// class_device_destroy(usu_class, 0);
> +err_classdev:
> +	class_destroy(usu_class);
> +err_class:
> +	return rc;
>  }
>  
>  static void __exit usb_usual_exit(void)
> @@ -221,6 +277,9 @@ static void __exit usb_usual_exit(void)
>  		wait_for_completion(&usu_end_notify);
>  		atomic_dec(&total_threads);
>  	}
> +
> +	class_device_destroy(usu_class, 0);
> +	class_destroy(usu_class);
>  }
>  
>  /*
> 
> This is a patch for our bug 204396:
>  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=204396
> The summary is: a USB storage device is not recognized if plugged in
> before a reboot on a Fedora Core 6 Test 3.
> 
> As usual, several circumstances have to occur for this to happen.
> What makes Fedora differend is how its USB core is built in statically.
> This makes libusual to be static (it's an artefact of my ineptness with
> Kconfig language, and also nash's modprobe not loading dependencies),
> and this splits it off storage (sub)modules.
> 
> The patch abuses the class mechanism to receive a signal from udev
> when it's ready and thus request_module can be retried.
> 
> How acceptable is this?

It's a hack and you know it :)

I don't think this is what you need to do here, sorry.  I suggest fixing
your boot scrips to load the dependant modules properly.  Or something
else, but abusing sysfs for something like this isn't very nice.

thanks,

greg k-h
