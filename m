Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264062AbUDHINX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 04:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264180AbUDHINX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 04:13:23 -0400
Received: from witte.sonytel.be ([80.88.33.193]:62361 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264062AbUDHINS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 04:13:18 -0400
Date: Thu, 8 Apr 2004 10:12:19 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Hanna Linder <hannal@us.ibm.com>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>, noring@nocrew.org, lars@nocrew.org,
       tomas@nocrew.org
Subject: Re: [PATCH 2.6] add class support to dsp56k.c 
In-Reply-To: <61760000.1081379610@dyn318071bld.beaverton.ibm.com>
Message-ID: <Pine.GSO.4.58.0404080952171.9729@waterleaf.sonytel.be>
References: <61760000.1081379610@dyn318071bld.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004, Hanna Linder wrote:
> Here is a patch that adds sysfs class support to /drivers/char/dsp56k.c
>
> I dont have the hardware or a cross compiler... If someone could test it
> I would appreciate it.

Cross-compiles fine here, but further untested due to lack of hardware.

> Thanks.
>
> Hanna
> IBM Linux Technology Center
> -----
> diff -Nrup linux-2.6.5/drivers/char/dsp56k.c linux-2.6.5p/drivers/char/dsp56k.c
> --- linux-2.6.5/drivers/char/dsp56k.c	2004-04-03 19:37:07.000000000 -0800
> +++ linux-2.6.5p/drivers/char/dsp56k.c	2004-04-07 14:44:28.000000000 -0700
> @@ -35,6 +35,7 @@
>  #include <linux/init.h>
>  #include <linux/devfs_fs_kernel.h>
>  #include <linux/smp_lock.h>
> +#include <linux/device.h>
>
>  #include <asm/atarihw.h>
>  #include <asm/traps.h>
> @@ -149,6 +150,8 @@ static struct dsp56k_device {
>  	int tx_wsize, rx_wsize;
>  } dsp56k;
>
> +static struct class_simple *dsp56k_class;
> +
>  static int dsp56k_reset(void)
>  {
>  	u_char status;
> @@ -502,6 +505,8 @@ static char banner[] __initdata = KERN_I
>
>  static int __init dsp56k_init_driver(void)
>  {
> +	int err = 0;
> +
>  	if(!MACH_IS_ATARI || !ATARIHW_PRESENT(DSP56K)) {
>  		printk("DSP56k driver: Hardware not present\n");
>  		return -ENODEV;
> @@ -511,12 +516,28 @@ static int __init dsp56k_init_driver(voi
>  		printk("DSP56k driver: Unable to register driver\n");
>  		return -ENODEV;
>  	}
> +	dsp56k_class = class_simple_create(THIS_MODULE, "dsp56k");
> +	if (IS_ERR(dsp56k_class)) {
> +		err = PTR_ERR(dsp56k_class);
> +		goto out_chrdev;
> +	}
> +	class_simple_device_add(dsp56k_class, MKDEV(DSP56K_MAJOR, 0), NULL, "dsp56k");
>
> -	devfs_mk_cdev(MKDEV(DSP56K_MAJOR, 0),
> +	err = devfs_mk_cdev(MKDEV(DSP56K_MAJOR, 0),
>  		      S_IFCHR | S_IRUSR | S_IWUSR, "dsp56k");
> +	if(err)
> +		goto out_class;
>
>  	printk(banner);
> -	return 0;
> +	goto out;
> +
> +out_class:
> +	class_simple_device_remove(MKDEV(DSP56K_MAJOR, 0));
> +	class_simple_destroy(dsp56k_class);
> +out_chrdev:
> +	unregister_chrdev(DSP56K_MAJOR, "sdp56k");
> +out:
> +	return err;
>  }
>  module_init(dsp56k_init_driver);
>
> @@ -524,6 +545,8 @@ static void __exit dsp56k_cleanup_driver
>  {
>  	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
>  	devfs_remove("dsp56k");
> +	class_simple_device_remove(MKDEV(DSP56K_MAJOR, 0));
> +	class_simple_destroy(dsp56k_class);
>  }
>  module_exit(dsp56k_cleanup_driver);
>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
