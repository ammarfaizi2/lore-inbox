Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTE2Hap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 03:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTE2Hap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 03:30:45 -0400
Received: from granite.he.net ([216.218.226.66]:7175 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261969AbTE2Han (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 03:30:43 -0400
Date: Thu, 29 May 2003 00:30:16 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [RFT/C 2.5.70] Input class hook up to driver model/sysfs
Message-ID: <20030529073016.GC5603@kroah.com>
References: <175110000.1054083891@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175110000.1054083891@w-hlinder>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 06:04:51PM -0700, Hanna Linder wrote:
> 
> root@w-hlinder2 root]# tree /sys/class/input
> /sys/class/input
> |-- mouse0
> |   `-- dev
> `-- mouse1
>     `-- dev

What happened to /sys/class/input/mice?  It should be present too.

Looks good, Al's point about not just calling kfree() on the kobject is
correct, but you copied my tty code which has the same bug :)

Another minor comment:
> -	devfs_remove("input/event%d", evdev->minor);
> +	input_unregister_class_dev("input/event%d", evdev->minor);
>  	evdev_table[evdev->minor] = NULL;
>  	kfree(evdev);
>  }
> @@ -94,8 +94,10 @@ static int evdev_release(struct inode * 
>  	if (!--list->evdev->open) {
>  		if (list->evdev->exist)
>  			input_close_device(&list->evdev->handle);
> -		else
> +		else{
> +			input_unregister_class_dev("input/event%d", list->evdev->minor);
>  			evdev_free(list->evdev);
> +		}
>  	}
>  
>  	kfree(list);
> @@ -374,6 +376,12 @@ static struct file_operations evdev_fops
>  	.flush =	evdev_flush
>  };
>  
> +static struct input_class_interface intf = {
> +	.name = 	"input/event%d",
> +	.mode = 	S_IFCHR | S_IRUGO | S_IWUSR,
> +	.minor_base = 	EVDEV_MINOR_BASE,
> +};
> +
>  static struct input_handle *evdev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
>  {
>  	struct evdev *evdev;
> @@ -402,8 +410,8 @@ static struct input_handle *evdev_connec
>  
>  	evdev_table[minor] = evdev;
>  
> -	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
> -			S_IFCHR|S_IRUGO|S_IWUSR, "input/event%d", minor);
> +	intf.minor = minor;
> +	input_register_class_dev(dev, &intf);
>  
>  	return &evdev->handle;
>  }
> @@ -417,8 +425,10 @@ static void evdev_disconnect(struct inpu
>  	if (evdev->open) {
>  		input_close_device(handle);
>  		wake_up_interruptible(&evdev->wait);
> -	} else
> +	} else {
> +		input_unregister_class_dev("input/event%d", evdev->minor);
>  		evdev_free(evdev);
> +	}
>  }

You use "input/event%d" 4 times in the above code.  Any way of just
passing the struct input_class_interface into
input_unregister_class_dev() so that you don't have to specify the name
more than once anywhere?

thanks,

greg k-h
