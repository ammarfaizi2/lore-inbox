Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVASOMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVASOMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVASOMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:12:17 -0500
Received: from ns1.coraid.com ([65.14.39.133]:3404 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261728AbVASOMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:12:10 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AOE: fix up the block device registration so that it
 actually works now.
References: <20050119000935.GA22454@kroah.com>
From: Ed L Cashin <ecashin@coraid.com>
Date: Wed, 19 Jan 2005 09:08:14 -0500
Message-ID: <87llap5x69.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> Ed, I need the following patch against the latest -bk tree in order to
> get the aoe code to load and work properly.  Does it look good to you?

I'm having trouble seeing what's in -bk.  I have a clone of
bk://linux.bkbits.net/linux-2.5, but when I "bk pull" there it says
"Nothing to pull."  And my clone doesn't have all the aoe patches I've
seen get pushed to -bk.

...
> -------------
>
> AOE: fix up the block device registration so that it actually works now.
>
> Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
>
> diff -Nru a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> --- a/drivers/block/aoe/aoeblk.c	2005-01-18 16:06:57 -08:00
> +++ b/drivers/block/aoe/aoeblk.c	2005-01-18 16:06:57 -08:00
> @@ -249,6 +249,7 @@
>  aoeblk_exit(void)
>  {
>  	kmem_cache_destroy(buf_pool_cache);
> +	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
>  }

The unregister_blkdev should already be in aoemain.c:aoe_exit.

static void
aoe_exit(void)
{
	discover_timer(TKILL);

	aoenet_exit();
	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
	aoechr_exit();
	aoedev_exit();
	aoeblk_exit();		/* free cache after de-allocating bufs */
}


>  int __init
> diff -Nru a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
> --- a/drivers/block/aoe/aoemain.c	2005-01-18 16:06:57 -08:00
> +++ b/drivers/block/aoe/aoemain.c	2005-01-18 16:06:57 -08:00
> @@ -82,11 +82,6 @@
>  	ret = aoenet_init();
>  	if (ret)
>  		goto net_fail;
> -	ret = register_blkdev(AOE_MAJOR, DEVICE_NAME);
> -	if (ret < 0) {
> -		printk(KERN_ERR "aoe: aoeblk_init: can't register major\n");
> -		goto blkreg_fail;
> -	}
>  
>  	printk(KERN_INFO
>  	       "aoe: aoe_init: AoE v2.6-%s initialised.\n",

Hmm.  I'll try to send a patch against usb, since I can pull from
there.

-- 
  Ed L Cashin <ecashin@coraid.com>

