Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVLOTuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVLOTuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVLOTuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:50:46 -0500
Received: from lixom.net ([66.141.50.11]:33158 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1750990AbVLOTup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:50:45 -0500
Date: Thu, 15 Dec 2005 11:50:17 -0800
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: dtor_core@ameritech.net, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch driver
Message-ID: <20051215195017.GA7195@pb15.lixom.net>
References: <20051213223659.GB20017@hansmi.ch> <1134568620.3875.6.camel@localhost> <20051214213923.GB17548@hansmi.ch> <d120d5000512141404wc86331fo124ebd29b713b07e@mail.gmail.com> <20051214233108.GA20127@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214233108.GA20127@hansmi.ch>
User-Agent: Mutt/1.5.9i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 12:31:08AM +0100, Michael Hanselmann wrote:
> This patch adds support for relayfs to the appletouch driver to make debugging
> easier.

I think I agree with previous comments regarding debug code in the driver:
It's unlikely to ever be used by more than a couple of people at very
rare occasions (new hardware releases), and the barrier to using it is
still high; new users need to learn how to parse the data anyway. I don't
see a reason to include this in mainline.

That aside, comments on the patch below.

> diff -rup linux-2.6.15-rc5.orig/drivers/usb/input/appletouch.c b/drivers/usb/input/appletouch.c
> --- linux-2.6.15-rc5.orig/drivers/usb/input/appletouch.c	2005-12-13 22:44:24.000000000 +0100
> +++ b/drivers/usb/input/appletouch.c	2005-12-15 00:25:09.000000000 +0100
> @@ -6,6 +6,8 @@
>   * Copyright (C) 2005      Stelian Pop (stelian@popies.net)
>   * Copyright (C) 2005      Frank Arnold (frank@scirocco-5v-turbo.de)
>   * Copyright (C) 2005      Peter Osterlund (petero2@telia.com)
> + * Copyright (C) 2005      Parag Warudkar (parag.warudkar@gmail.com)
> + * Copyright (C) 2005      Michael Hanselmann (linux-kernel@hansmi.ch)
>   *
>   * Thanks to Alex Harper <basilisk@foobox.net> for his inputs.
>   *
> @@ -35,6 +37,10 @@
>  #include <linux/input.h>
>  #include <linux/usb_input.h>
>  
> +#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
> +#include <linux/relayfs_fs.h>
> +#endif
> +
>  /* Apple has powerbooks which have the keyboard with different Product IDs */
>  #define APPLE_VENDOR_ID		0x05AC
>  
> @@ -73,6 +79,7 @@ MODULE_DEVICE_TABLE (usb, atp_table);
>  
>  /* maximum pressure this driver will report */
>  #define ATP_PRESSURE	300
> +

Whitespace change

>  /*
>  
>   * multiplication factor for the X and Y coordinates.
>   * We try to keep the touchpad aspect ratio while still doing only simple
> @@ -124,7 +131,7 @@ struct atp {
>  		if (debug) printk(format, ##a);				\
>  	} while (0)
>  
> -MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold");
> +MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold, Parag Warudkar, Michael Hanselmann");
>  MODULE_DESCRIPTION("Apple PowerBooks USB touchpad driver");
>  MODULE_LICENSE("GPL");
>  
> @@ -132,6 +139,68 @@ static int debug = 1;
>  module_param(debug, int, 0644);
>  MODULE_PARM_DESC(debug, "Activate debugging output");
>  
> +#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
> +static int relayfs;
> +module_param(relayfs, int, 0444);
> +MODULE_PARM_DESC(relayfs, "Activate relayfs support");
> +
> +struct rchan *rch;
> +struct rchan_callbacks *rcb;

static, please.

> +
> +static inline void atp_relayfs_dump(struct atp *dev)
> +{
> +	/* "rch" is NULL if relayfs is disabled */
> +	if (rch && dev->data) {
> +		relay_write(rch, dev->data, dev->urb->actual_length);
> +	}
> +}
> +
> +static int appletouch_relayfs_init(void)
> +{
> +	// Make sure the variables aren't initialized to some bogus value when
> +	// relayfs is disabled
> +	rcb = NULL;
> +	rch = NULL;

Huh? BSS is initialized to 0, this is unneccessary.
(Also, the comment is C++-style, please use /* */ comments.)

> +
> +	if (relayfs) {

Please do:
	if (!relayfs)
		return 0;

To save indentation.

> +		rcb = kmalloc(sizeof(struct rchan_callbacks), GFP_KERNEL);
> +		if (!rcb)
> +			return -ENOMEM;
> +
> +		rcb->subbuf_start = NULL;
> +		rcb->buf_mapped = NULL;
> +		rcb->buf_unmapped = NULL;
> +
> +		rch = relay_open("atpdata", NULL, 256, 256, NULL);
> +		if (!rch) {
> +			kfree(rcb);
> +			return -ENOMEM;

ENOMEM for a failed open? Seems odd to me.
Should you also set rcb = NULL?

> +		}
> +
> +		printk(KERN_INFO "appletouch: Relayfs enabled.\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void appletouch_relayfs_exit(void)
> +{
> +	if (rch) {
> +		printk(KERN_INFO "appletouch: Relayfs disabled\n");
> +		relay_close(rch);
> +		rch = NULL;
> +	}
> +	if (rcb) {
> +		kfree(rcb);
> +		rcb = NULL;

No need to check arguments to kfree.

> +	}
> +}
> +#else
> +static inline void atp_relayfs_dump(struct atp *dev) { }
> +static int appletouch_relayfs_init(void) { return 0; }
> +static void appletouch_relayfs_exit(void) { }
> +#endif
> +
>  static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
>  			     int *z, int *fingers)
>  {
> @@ -194,6 +263,8 @@ static void atp_complete(struct urb* urb
>  		goto exit;
>  	}
>  
> +	atp_relayfs_dump(dev);
> +
>  	/* reorder the sensors values */
>  	for (i = 0; i < 8; i++) {
>  		/* X values */
> @@ -297,6 +368,11 @@ exit:
>  static int atp_open(struct input_dev *input)
>  {
>  	struct atp *dev = input->private;
> +	int result;
> +
> +	result = appletouch_relayfs_init();
> +	if (result < 0)
> +		return result;

Sounds harsh to deny USB open just because relayfs couldn't be setup.

Actually, this way you could just make the init function not return
anything; it doesn't matter if it fails or not -- life will go on.

>  
>  	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
>  		return -EIO;
> @@ -310,6 +386,8 @@ static void atp_close(struct input_dev *
>  	struct atp *dev = input->private;
>  
>  	usb_kill_urb(dev->urb);
> +	appletouch_relayfs_exit();
> +
>  	dev->open = 0;
>  }
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
