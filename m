Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270654AbTHJUki (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270651AbTHJUki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:40:38 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32007
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S270686AbTHJUkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:40:31 -0400
Date: Sun, 10 Aug 2003 13:29:16 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill HDIO_GETGEO_BIG_RAW ioctl
In-Reply-To: <200308090124.51846.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.10.10308101327590.12816-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Besure to force all devices to LBA only because wrapping the cylinder
count tends to make a mess.

Cheers,

--a

On Sat, 9 Aug 2003, Bartlomiej Zolnierkiewicz wrote:

> 
> Against 2.6.0-test2-bk8.
> 
> --bartlomiej
> 
> 
> kill HDIO_GETGEO_BIG_RAW ioctl
> 
> HDIO_GETGEO_BIG_RAW is an ide specific hack introduced in 2.3.99-pre3.
> There are no known programs using this ioctl.
> 
> Its aim was to provide current CHS translation to the user-space,
> but very often it provides what driver thinks is a current translation
> (drive with LBA have to support only one physical translation, also
>  drive may not support chosen translation and there is no return value check).
> 
> hdparm -I can be used instead, it provides correct information
> (and bogus data is still accessible through /proc/ide/hdX/geometry).
> 
>  arch/ppc64/kernel/ioctl32.c   |   29 -----------------------------
>  arch/sparc64/kernel/ioctl32.c |   29 -----------------------------
>  drivers/ide/ide.c             |   12 ------------
>  include/linux/hdreg.h         |   10 +---------
>  4 files changed, 1 insertion(+), 79 deletions(-)
> 
> diff -puN arch/ppc64/kernel/ioctl32.c~kill-HDIO_GETGEO_BIG_RAW arch/ppc64/kernel/ioctl32.c
> --- linux-2.6.0-test2-bk7/arch/ppc64/kernel/ioctl32.c~kill-HDIO_GETGEO_BIG_RAW	2003-08-08 23:53:47.012359456 +0200
> +++ linux-2.6.0-test2-bk7-root/arch/ppc64/kernel/ioctl32.c	2003-08-08 23:53:47.024357632 +0200
> @@ -28,34 +28,6 @@
>  #define CODE
>  #include "compat_ioctl.c"
>  
> -struct hd_big_geometry32 {
> -	unsigned char heads;
> -	unsigned char sectors;
> -	unsigned int cylinders;
> -	u32 start;
> -};
> -                        
> -static int hdio_getgeo_big(unsigned int fd, unsigned int cmd, unsigned long arg)
> -{
> -	mm_segment_t old_fs = get_fs();
> -	struct hd_big_geometry geo;
> -	int err;
> -	
> -	set_fs (KERNEL_DS);
> -	err = sys_ioctl(fd, cmd, (unsigned long)&geo);
> -	set_fs (old_fs);
> -	if (!err) {
> -		struct hd_big_geometry32 *up = (struct hd_big_geometry32 *) arg;
> -
> -		if (put_user(geo.heads, &up->heads) ||
> -		    __put_user(geo.sectors, &up->sectors) ||
> -		    __put_user(geo.cylinders, &up->cylinders) ||
> -		    __put_user(((u32) geo.start), &up->start))
> -			err = -EFAULT;
> -	}
> -	return err;
> -}
> -
>  struct ncp_ioctl_request_32 {
>  	unsigned int function;
>  	unsigned int size;
> @@ -773,7 +745,6 @@ COMPATIBLE_IOCTL(_IOR('p', 20, int[7])) 
>  COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */
>  
>  /* And these ioctls need translation */
> -HANDLE_IOCTL(HDIO_GETGEO_BIG_RAW, hdio_getgeo_big)
>  
>  /* NCPFS */
>  HANDLE_IOCTL(NCP_IOC_NCPREQUEST_32, do_ncp_ncprequest)
> diff -puN arch/sparc64/kernel/ioctl32.c~kill-HDIO_GETGEO_BIG_RAW arch/sparc64/kernel/ioctl32.c
> --- linux-2.6.0-test2-bk7/arch/sparc64/kernel/ioctl32.c~kill-HDIO_GETGEO_BIG_RAW	2003-08-08 23:53:47.015359000 +0200
> +++ linux-2.6.0-test2-bk7-root/arch/sparc64/kernel/ioctl32.c	2003-08-08 23:53:47.026357328 +0200
> @@ -40,34 +40,6 @@ static __inline__ void *alloc_user_space
>  #define CODE
>  #include "compat_ioctl.c"
>  
> -struct hd_big_geometry32 {
> -	unsigned char heads;
> -	unsigned char sectors;
> -	unsigned int cylinders;
> -	u32 start;
> -};
> -                        
> -static int hdio_getgeo_big(unsigned int fd, unsigned int cmd, unsigned long arg)
> -{
> -	mm_segment_t old_fs = get_fs();
> -	struct hd_big_geometry geo;
> -	int err;
> -	
> -	set_fs (KERNEL_DS);
> -	err = sys_ioctl(fd, cmd, (unsigned long)&geo);
> -	set_fs (old_fs);
> -	if (!err) {
> -		struct hd_big_geometry32 *up = (struct hd_big_geometry32 *) arg;
> -
> -		if (put_user(geo.heads, &up->heads) ||
> -		    __put_user(geo.sectors, &up->sectors) ||
> -		    __put_user(geo.cylinders, &up->cylinders) ||
> -		    __put_user(((u32) geo.start), &up->start))
> -			err = -EFAULT;
> -	}
> -	return err;
> -}
> -
>  struct  fbcmap32 {
>  	int             index;          /* first element (0 origin) */
>  	int             count;
> @@ -1558,7 +1530,6 @@ COMPATIBLE_IOCTL(DM_DEV_STATUS)
>  COMPATIBLE_IOCTL(DM_TARGET_STATUS)
>  COMPATIBLE_IOCTL(DM_TARGET_WAIT)
>  /* And these ioctls need translation */
> -HANDLE_IOCTL(HDIO_GETGEO_BIG_RAW, hdio_getgeo_big)
>  /* NCPFS */
>  HANDLE_IOCTL(NCP_IOC_NCPREQUEST_32, do_ncp_ncprequest)
>  HANDLE_IOCTL(NCP_IOC_GETMOUNTUID2_32, do_ncp_getmountuid2)
> diff -puN drivers/ide/ide.c~kill-HDIO_GETGEO_BIG_RAW drivers/ide/ide.c
> --- linux-2.6.0-test2-bk7/drivers/ide/ide.c~kill-HDIO_GETGEO_BIG_RAW	2003-08-08 23:53:47.018358544 +0200
> +++ linux-2.6.0-test2-bk7-root/drivers/ide/ide.c	2003-08-08 23:53:47.027357176 +0200
> @@ -1619,18 +1619,6 @@ int generic_ide_ioctl(struct block_devic
>  			return 0;
>  		}
>  
> -		case HDIO_GETGEO_BIG_RAW:
> -		{
> -			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
> -			if (!loc || (drive->media != ide_disk && drive->media != ide_floppy)) return -EINVAL;
> -			if (put_user(drive->head, (u8 *) &loc->heads)) return -EFAULT;
> -			if (put_user(drive->sect, (u8 *) &loc->sectors)) return -EFAULT;
> -			if (put_user(drive->cyl, (unsigned int *) &loc->cylinders)) return -EFAULT;
> -			if (put_user((unsigned)get_start_sect(bdev),
> -				(unsigned long *) &loc->start)) return -EFAULT;
> -			return 0;
> -		}
> -
>  		case HDIO_OBSOLETE_IDENTITY:
>  		case HDIO_GET_IDENTITY:
>  			if (bdev != bdev->bd_contains)
> diff -puN include/linux/hdreg.h~kill-HDIO_GETGEO_BIG_RAW include/linux/hdreg.h
> --- linux-2.6.0-test2-bk7/include/linux/hdreg.h~kill-HDIO_GETGEO_BIG_RAW	2003-08-08 23:53:47.021358088 +0200
> +++ linux-2.6.0-test2-bk7-root/include/linux/hdreg.h	2003-08-08 23:53:47.028357024 +0200
> @@ -395,14 +395,6 @@ struct hd_geometry {
>        unsigned long start;
>  };
>  
> -/* BIG GEOMETRY - dying, used only by HDIO_GETGEO_BIG_RAW */
> -struct hd_big_geometry {
> -	unsigned char heads;
> -	unsigned char sectors;
> -	unsigned int cylinders;
> -	unsigned long start;
> -};
> -
>  /* hd/ide ctl's that pass (arg) ptrs to user space are numbered 0x030n/0x031n */
>  #define HDIO_GETGEO		0x0301	/* get device geometry */
>  #define HDIO_GET_UNMASKINTR	0x0302	/* get current unmask setting */
> @@ -456,7 +448,7 @@ enum {
>  
>  /* hd/ide ctl's that pass (arg) ptrs to user space are numbered 0x033n/0x033n */
>  /* 0x330 is reserved - used to be HDIO_GETGEO_BIG */
> -#define HDIO_GETGEO_BIG_RAW	0x0331	/* */
> +/* 0x331 is reserved - used to be HDIO_GETGEO_BIG_RAW */
>  
>  #define HDIO_SET_IDE_SCSI      0x0338
>  #define HDIO_SET_SCSI_IDE      0x0339
> 
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

