Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbRESBHL>; Fri, 18 May 2001 21:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbRESBHB>; Fri, 18 May 2001 21:07:01 -0400
Received: from ns4.intel.com ([192.102.198.240]:44750 "EHLO
	minos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S261615AbRESBGq>; Fri, 18 May 2001 21:06:46 -0400
Message-ID: <3B05B940.E74F4E62@intel.com>
Date: Fri, 18 May 2001 17:07:28 -0700
From: "Randy.Dunlap" <randy.dunlap@intel.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] videodev_init() -> initcall
In-Reply-To: <Pine.GSO.4.21.0105181651220.1896-100000@weyl.math.psu.edu>
Content-Type: multipart/mixed;
 boundary="------------89A987B7503B8AFCC666EBEF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------89A987B7503B8AFCC666EBEF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Al's patch gives me:

videodev.c:550: warning: static declaration for `videodev_init' follows
non-static
videodev.c: In function `videodev_exit':
videodev.c:579: warning: implicit declaration of function
`videodev_proc_destroy'

Patch to use after Al's patch is attached.

~Randy


Alexander Viro wrote:
> 
>         Alan, drivers/media/videodev.c is your code. See if you are OK
> with the patch below - it switches the thing to use of module_init()
> and removes the call of videodev_init() from chr_dev_init(). I.e. the
> only ordering change is that videodev_init() is postponed until immediately
> before the media/video/* drivers.
>         Linus, if you are OK with that and Alan will ACK the thing - please,
> consider applying it.
>                                                                 Al
> 
> diff -urN S5-pre3/drivers/char/mem.c S5-pre3-videodev/drivers/char/mem.c
> --- S5-pre3/drivers/char/mem.c  Wed May 16 16:26:36 2001
> +++ S5-pre3-videodev/drivers/char/mem.c Fri May 18 16:46:37 2001
> @@ -29,9 +29,6 @@
>  #ifdef CONFIG_I2C
>  extern int i2c_init_all(void);
>  #endif
> -#ifdef CONFIG_VIDEO_DEV
> -extern int videodev_init(void);
> -#endif
>  #ifdef CONFIG_FB
>  extern void fbmem_init(void);
>  #endif
> @@ -647,9 +644,6 @@
>  #endif
>  #if defined(CONFIG_ADB)
>         adbdev_init();
> -#endif
> -#ifdef CONFIG_VIDEO_DEV
> -       videodev_init();
>  #endif
>         return 0;
>  }
> diff -urN S5-pre3/drivers/media/video/videodev.c S5-pre3-videodev/drivers/media/video/videodev.c
> --- S5-pre3/drivers/media/video/videodev.c      Sun Apr  1 23:56:57 2001
> +++ S5-pre3-videodev/drivers/media/video/videodev.c     Fri May 18 16:48:34 2001
> @@ -546,7 +546,7 @@
>   *     Initialise video for linux
>   */
> 
> -int __init videodev_init(void)
> +static int __init videodev_init(void)
>  {
>         struct video_init *vfli = video_init_list;
> 
> @@ -573,13 +573,7 @@
>         return 0;
>  }
> 
> -#ifdef MODULE
> -int init_module(void)
> -{
> -       return videodev_init();
> -}
> -
> -void cleanup_module(void)
> +static void __exit videodev_exit(void)
>  {
>  #if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
>         videodev_proc_destroy ();
> @@ -588,7 +582,8 @@
>         devfs_unregister_chrdev(VIDEO_MAJOR, "video_capture");
>  }
> 
> -#endif
> +module_init(videodev_init)
> +module_exit(videodev_exit)
> 
>  EXPORT_SYMBOL(video_register_device);
>  EXPORT_SYMBOL(video_unregister_device);
> 
> -
--------------89A987B7503B8AFCC666EBEF
Content-Type: text/plain; charset=us-ascii;
 name="viddev2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="viddev2.patch"

--- linux/include/linux/videodev.h.org	Fri May 18 15:56:32 2001
+++ linux/include/linux/videodev.h	Fri May 18 16:45:03 2001
@@ -33,7 +33,6 @@
 	devfs_handle_t devfs_handle;
 };
 
-extern int videodev_init(void);
 #define VIDEO_MAJOR	81
 extern int video_register_device(struct video_device *, int type);
 
--- linux/drivers/media/video/videodev.c.org	Fri May 18 16:18:45 2001
+++ linux/drivers/media/video/videodev.c	Fri May 18 16:37:44 2001
@@ -575,8 +575,10 @@
 
 static void __exit videodev_exit(void)
 {
+#ifdef MODULE		
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
 	videodev_proc_destroy ();
+#endif
 #endif
 	
 	devfs_unregister_chrdev(VIDEO_MAJOR, "video_capture");

--------------89A987B7503B8AFCC666EBEF--

