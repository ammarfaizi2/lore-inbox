Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUBXIaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 03:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUBXIaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 03:30:07 -0500
Received: from [195.190.190.7] ([195.190.190.7]:51117 "EHLO mail.pixelized.ch")
	by vger.kernel.org with ESMTP id S261612AbUBXI35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 03:29:57 -0500
Message-ID: <403B0B76.5050905@debian.org>
Date: Tue, 24 Feb 2004 09:29:42 +0100
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: "Giacomo A. Catenazzi" <cate@debian.org>,
       Ryan Underwood <nemesis@icequake.net>, 224355@bugs.debian.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch-2.4.25] microcode.c fix (wasRe: microcode, devfs: Wrong
    interface change in 2.4.25
References: <Pine.GSO.4.44.0402230948190.6162-100000@south.veritas.com>
In-Reply-To: <Pine.GSO.4.44.0402230948190.6162-100000@south.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:

> Hi Giacomo,
> 
> Yes, you are right. I have now looked at the driver in 2.4.25 and see that
> the latest change did break the compatibility inadvertently (because of
> wrongly backporting the changes from 2.6 --- can't remember who did it
> now, but it doesn't matter).
> 
> Please test the attached patch. I have tested it on 2.4.25 but only
> without devfs compiled into the kernel.

The patch is correct. Now devfs will create the devices in 
/dev/cpu/microcode (and in /dev/misc).

[Yesterday I had some space problem with your patch, but I think
the problem was in my MUA]

thanks!

ciao
	giacomo



> 
> Kind regards
> Tigran
> 
> PS.Notice that I also added your earlier suggestion to do compile-time
> merging of strings instead of runtime.
> 
> --- linux-2.4.25-orig/arch/i386/kernel/microcode.c	2004-02-18 13:36:30.000000000 +0000
> +++ linux-2.4.25/arch/i386/kernel/microcode.c	2004-02-23 18:07:41.000000000 +0000
> @@ -1,7 +1,7 @@
>  /*
>   *	Intel CPU Microcode Update driver for Linux
>   *
> - *	Copyright (C) 2000 Tigran Aivazian
> + *	Copyright (C) 2000-2004 Tigran Aivazian
>   *
>   *	This driver allows to upgrade microcode on Intel processors
>   *	belonging to IA-32 family - PentiumPro, Pentium II,
> @@ -64,6 +64,10 @@
>   *		Removed ->read() method and obsoleted MICROCODE_IOCFREE ioctl
>   *		because we no longer hold a copy of applied microcode
>   *		in kernel memory.
> + *	1.14	23 Feb 2004 Tigran Aivazian <tigran@veritas.com>
> + *		Restored devfs regular file entry point which was
> + *		accidentally removed when back-porting changes from the 2.6
> + *		version of the driver.
>   */
> 
> 
> @@ -73,6 +77,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/miscdevice.h>
> +#include <linux/devfs_fs_kernel.h>
>  #include <linux/spinlock.h>
>  #include <linux/mm.h>
> 
> @@ -84,8 +89,8 @@
>  MODULE_AUTHOR("Tigran Aivazian <tigran@veritas.com>");
>  MODULE_LICENSE("GPL");
> 
> -#define MICROCODE_VERSION 	"1.13"
> -#define MICRO_DEBUG 		1
> +#define MICROCODE_VERSION 	"1.14"
> +#define MICRO_DEBUG 		0
>  #if MICRO_DEBUG
>  #define dprintk(x...) printk(KERN_INFO x)
>  #else
> @@ -470,6 +475,7 @@
>  	return -EINVAL;
>  }
> 
> +/* shared between misc device and devfs regular file */
>  static struct file_operations microcode_fops = {
>  	.owner		= THIS_MODULE,
>  	.write		= microcode_write,
> @@ -483,29 +489,38 @@
>  	.fops		= &microcode_fops,
>  };
> 
> +static devfs_handle_t devfs_handle;
> +
>  static int __init microcode_init (void)
>  {
>  	int error;
> 
>  	error = misc_register(&microcode_dev);
> -	if (error) {
> +	if (error)
>  		printk(KERN_ERR
>  			"microcode: can't misc_register on minor=%d\n",
>  			MICROCODE_MINOR);
> -		return error;
> +	devfs_handle = devfs_register(NULL, "cpu/microcode",
> +			DEVFS_FL_DEFAULT, 0, 0, S_IFREG | S_IRUSR | S_IWUSR,
> +			&microcode_fops, NULL);
> +	if (devfs_handle == NULL && error) {
> +		printk(KERN_ERR "microcode: failed to devfs_register()\n");
> +		goto out;
>  	}
> -
> +	error = 0;
>  	printk(KERN_INFO
> -		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n",
> -		MICROCODE_VERSION);
> -	return 0;
> +		"IA-32 Microcode Update Driver: v"
> +		MICROCODE_VERSION " <tigran@veritas.com>\n");
> +out:
> +	return error;
>  }
> 
>  static void __exit microcode_exit (void)
>  {
>  	misc_deregister(&microcode_dev);
> -	printk(KERN_INFO "IA-32 Microcode Update Driver v%s unregistered\n",
> -			MICROCODE_VERSION);
> +	devfs_unregister(devfs_handle);
> +	printk(KERN_INFO "IA-32 Microcode Update Driver v"
> +		MICROCODE_VERSION " unregistered\n");
>  }
> 
>  module_init(microcode_init)
> 
