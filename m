Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVI2TLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVI2TLt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVI2TLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:11:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44994 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932224AbVI2TLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:11:48 -0400
Date: Thu, 29 Sep 2005 12:10:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>
Subject: Re: Fix broken module aliases in ieee1394
Message-Id: <20050929121038.54d4cef0.akpm@osdl.org>
In-Reply-To: <20050929185732.GA31117@redhat.com>
References: <20050929185732.GA31117@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=134047
> 
> The ieee1394 drivers have buggered module aliases.
> 
> alias:          char-major-171-0 * 16
> 
> This is because MODULE_ALIAS_CHARDEV stringifies its arguments.
> 

hm.  There are a bunch of 1394 patches in -mm which appear to remove
most/all of this stuff.

So what-the-heck I think I'll send those patches on to Linus today.  Please
review the result and send any remaining fixups on to Linus for 2.6.14. 
(I'm offline for ~10 days, starting tomorrow).


> 
> --- linux-2.6.13/drivers/ieee1394/amdtp.c~	2005-09-29 03:50:20.000000000 -0400
> +++ linux-2.6.13/drivers/ieee1394/amdtp.c	2005-09-29 03:50:54.000000000 -0400
> @@ -1234,7 +1234,7 @@ static void amdtp_add_host(struct hpsb_h
>  
>  	hpsb_set_hostinfo_key(&amdtp_highlevel, host, ah->host->id);
>  
> -	minor = IEEE1394_MINOR_BLOCK_AMDTP * 16 + ah->host->id;
> +	minor = IEEE1394_MINOR_BLOCK_AMDTP + ah->host->id;
>  
>  	INIT_LIST_HEAD(&ah->stream_list);
>  	spin_lock_init(&ah->stream_list_lock);
> @@ -1297,4 +1297,4 @@ static void __exit amdtp_exit_module (vo
>  
>  module_init(amdtp_init_module);
>  module_exit(amdtp_exit_module);
> -MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_AMDTP * 16);
> +MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_AMDTP);
> --- linux-2.6.13/drivers/ieee1394/dv1394.c~	2005-09-29 03:51:08.000000000 -0400
> +++ linux-2.6.13/drivers/ieee1394/dv1394.c	2005-09-29 03:51:26.000000000 -0400
> @@ -2344,7 +2344,7 @@ static void dv1394_remove_host (struct h
>  	} while (video != NULL);
>  
>  	class_device_destroy(hpsb_protocol_class,
> -		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_DV1394 * 16 + (id<<2)));
> +		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_DV1394 + (id<<2)));
>  	devfs_remove("ieee1394/dv/host%d/NTSC", id);
>  	devfs_remove("ieee1394/dv/host%d/PAL", id);
>  	devfs_remove("ieee1394/dv/host%d", id);
> @@ -2362,7 +2362,7 @@ static void dv1394_add_host (struct hpsb
>  	ohci = (struct ti_ohci *)host->hostdata;
>  
>  	class_device_create(hpsb_protocol_class, MKDEV(
> -		IEEE1394_MAJOR,	IEEE1394_MINOR_BLOCK_DV1394 * 16 + (id<<2)), 
> +		IEEE1394_MAJOR,	IEEE1394_MINOR_BLOCK_DV1394 + (id<<2)), 
>  		NULL, "dv1394-%d", id);
>  	devfs_mk_dir("ieee1394/dv/host%d", id);
>  	devfs_mk_dir("ieee1394/dv/host%d/NTSC", id);
> @@ -2660,4 +2660,4 @@ static int __init dv1394_init_module(voi
>  
>  module_init(dv1394_init_module);
>  module_exit(dv1394_exit_module);
> -MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_DV1394 * 16);
> +MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_DV1394);
> --- linux-2.6.13/drivers/ieee1394/raw1394.c~	2005-09-29 03:51:34.000000000 -0400
> +++ linux-2.6.13/drivers/ieee1394/raw1394.c	2005-09-29 03:51:53.000000000 -0400
> @@ -2905,14 +2905,14 @@ static int __init init_raw1394(void)
>  	hpsb_register_highlevel(&raw1394_highlevel);
>  
>  	if (IS_ERR(class_device_create(hpsb_protocol_class, MKDEV(
> -		IEEE1394_MAJOR,	IEEE1394_MINOR_BLOCK_RAW1394 * 16), 
> +		IEEE1394_MAJOR,	IEEE1394_MINOR_BLOCK_RAW1394), 
>  		NULL, RAW1394_DEVICE_NAME))) {
>  		ret = -EFAULT;
>  		goto out_unreg;
>  	}
>  	
>  	devfs_mk_cdev(MKDEV(
> -		IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16),
> +		IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394),
>  		S_IFCHR | S_IRUSR | S_IWUSR, RAW1394_DEVICE_NAME);
>  
>  	cdev_init(&raw1394_cdev, &raw1394_fops);
> @@ -2938,7 +2938,7 @@ static int __init init_raw1394(void)
>  out_dev:
>  	devfs_remove(RAW1394_DEVICE_NAME);
>  	class_device_destroy(hpsb_protocol_class,
> -		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16));
> +		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394));
>  out_unreg:
>  	hpsb_unregister_highlevel(&raw1394_highlevel);
>  out:
> @@ -2948,7 +2948,7 @@ out:
>  static void __exit cleanup_raw1394(void)
>  {
>  	class_device_destroy(hpsb_protocol_class,
> -		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16));
> +		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394));
>  	cdev_del(&raw1394_cdev);
>  	devfs_remove(RAW1394_DEVICE_NAME);
>  	hpsb_unregister_highlevel(&raw1394_highlevel);
> @@ -2958,4 +2958,4 @@ static void __exit cleanup_raw1394(void)
>  module_init(init_raw1394);
>  module_exit(cleanup_raw1394);
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16);
> +MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394);
> --- linux-2.6.13/drivers/ieee1394/video1394.c~	2005-09-29 03:51:59.000000000 -0400
> +++ linux-2.6.13/drivers/ieee1394/video1394.c	2005-09-29 03:52:10.000000000 -0400
> @@ -1369,7 +1369,7 @@ static void video1394_add_host (struct h
>  	hpsb_set_hostinfo(&video1394_highlevel, host, ohci);
>  	hpsb_set_hostinfo_key(&video1394_highlevel, host, ohci->host->id);
>  
> -	minor = IEEE1394_MINOR_BLOCK_VIDEO1394 * 16 + ohci->host->id;
> +	minor = IEEE1394_MINOR_BLOCK_VIDEO1394 + ohci->host->id;
>  	class_device_create(hpsb_protocol_class, MKDEV(
>  		IEEE1394_MAJOR,	minor), 
>  		NULL, "%s-%d", VIDEO1394_DRIVER_NAME, ohci->host->id);
> @@ -1385,7 +1385,7 @@ static void video1394_remove_host (struc
>  
>  	if (ohci) {
>  		class_device_destroy(hpsb_protocol_class, MKDEV(IEEE1394_MAJOR,
> -			IEEE1394_MINOR_BLOCK_VIDEO1394 * 16 + ohci->host->id));
> +			IEEE1394_MINOR_BLOCK_VIDEO1394 + ohci->host->id));
>  		devfs_remove("%s/%d", VIDEO1394_DRIVER_NAME, ohci->host->id);
>  	}
>  	
> @@ -1571,4 +1571,4 @@ static int __init video1394_init_module 
>  
>  module_init(video1394_init_module);
>  module_exit(video1394_exit_module);
> -MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_VIDEO1394 * 16);
> +MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_VIDEO1394);
> --- linux-2.6.13/drivers/ieee1394/ieee1394_core.h~	2005-09-29 03:52:20.000000000 -0400
> +++ linux-2.6.13/drivers/ieee1394/ieee1394_core.h	2005-09-29 03:53:14.000000000 -0400
> @@ -200,17 +200,17 @@ void hpsb_packet_received(struct hpsb_ho
>  #define IEEE1394_MAJOR               171
>  
>  #define IEEE1394_MINOR_BLOCK_RAW1394       0
> -#define IEEE1394_MINOR_BLOCK_VIDEO1394     1
> -#define IEEE1394_MINOR_BLOCK_DV1394        2
> -#define IEEE1394_MINOR_BLOCK_AMDTP         3
> +#define IEEE1394_MINOR_BLOCK_VIDEO1394     (1*16)
> +#define IEEE1394_MINOR_BLOCK_DV1394        (2*16)
> +#define IEEE1394_MINOR_BLOCK_AMDTP         (3*16)
>  #define IEEE1394_MINOR_BLOCK_EXPERIMENTAL 15
>  
>  #define IEEE1394_CORE_DEV		MKDEV(IEEE1394_MAJOR, 0)
> -#define IEEE1394_RAW1394_DEV		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16)
> -#define IEEE1394_VIDEO1394_DEV		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_VIDEO1394 * 16)
> -#define IEEE1394_DV1394_DEV		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_DV1394 * 16)
> -#define IEEE1394_AMDTP_DEV		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_AMDTP * 16)
> -#define IEEE1394_EXPERIMENTAL_DEV	MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_EXPERIMENTAL * 16)
> +#define IEEE1394_RAW1394_DEV		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394)
> +#define IEEE1394_VIDEO1394_DEV		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_VIDEO1394)
> +#define IEEE1394_DV1394_DEV		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_DV1394)
> +#define IEEE1394_AMDTP_DEV		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_AMDTP)
> +#define IEEE1394_EXPERIMENTAL_DEV	MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_EXPERIMENTAL)
>  
>  /* return the index (within a minor number block) of a file */
>  static inline unsigned char ieee1394_file_to_instance(struct file *file)
