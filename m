Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTEJDiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 23:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263643AbTEJDiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 23:38:10 -0400
Received: from tomts19-srv.bellnexxia.net ([209.226.175.73]:62601 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263638AbTEJDiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 23:38:04 -0400
Subject: Re: Can't find CDR device in -mm only
From: Shane Shrybman <shrybman@sympatico.ca>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
In-Reply-To: <20030509204131.1294aeb1.akpm@digeo.com>
References: <1052537820.2441.113.camel@mars.goatskin.org>
	 <20030509204131.1294aeb1.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052538641.2442.115.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 May 2003 23:50:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thats already backed out due to LVM issues.

On Fri, 2003-05-09 at 23:41, Andrew Morton wrote:
> Shane Shrybman <shrybman@sympatico.ca> wrote:
> >
> > The problem first appeared in 2.5.68-mm3 and is not in mainline 2.5.69.
> >  It is present in all -mm releases since.
> 
> Could you try reverting the 64-bit dev_t patch?  Do a `patch -p1 -R'
> of the below.    Thanks.
> 
> 
> diff -puN drivers/s390/block/dasd_int.h~64-bit-dev_t-kdev_t drivers/s390/block/dasd_int.h
> --- 25/drivers/s390/block/dasd_int.h~64-bit-dev_t-kdev_t	2003-05-03 15:06:44.000000000 -0700
> +++ 25-akpm/drivers/s390/block/dasd_int.h	2003-05-03 15:06:44.000000000 -0700
> @@ -14,7 +14,8 @@
>  
>  #ifdef __KERNEL__
>  
> -#define DASD_PER_MAJOR ( 1U<<(MINORBITS-DASD_PARTN_BITS))
> +#define DASD_MINORBITS 8
> +#define DASD_PER_MAJOR ( 1U<<(DASD_MINORBITS-DASD_PARTN_BITS))
>  #define DASD_PARTN_MASK ((1 << DASD_PARTN_BITS) - 1)
>  
>  /*
> diff -puN drivers/scsi/sg.c~64-bit-dev_t-kdev_t drivers/scsi/sg.c
> --- 25/drivers/scsi/sg.c~64-bit-dev_t-kdev_t	2003-05-03 15:06:44.000000000 -0700
> +++ 25-akpm/drivers/scsi/sg.c	2003-05-03 15:06:44.000000000 -0700
> @@ -80,7 +80,7 @@ static void sg_proc_cleanup(void);
>  #define SG_ALLOW_DIO_DEF 0
>  #define SG_ALLOW_DIO_CODE /* compile out by commenting this define */
>  
> -#define SG_MAX_DEVS_MASK ((1U << KDEV_MINOR_BITS) - 1)
> +#define SG_MAX_DEVS_MASK 255
>  
>  /*
>   * Suppose you want to calculate the formula muldiv(x,m,d)=int(x * m / d)
> @@ -1331,8 +1331,8 @@ static ssize_t
>  sg_device_kdev_read(struct device *driverfs_dev, char *page)
>  {
>  	Sg_device *sdp = list_entry(driverfs_dev, Sg_device, sg_driverfs_dev);
> -	return sprintf(page, "%x\n", MKDEV(sdp->disk->major,
> -					   sdp->disk->first_minor));
> +	dev_t dev = MKDEV(sdp->disk->major, sdp->disk->first_minor);
> +	return sprintf(page, "%llx\n", (unsigned long long) dev);
>  }
>  static DEVICE_ATTR(kdev,S_IRUGO,sg_device_kdev_read,NULL);
>  
> diff -puN drivers/scsi/sr.c~64-bit-dev_t-kdev_t drivers/scsi/sr.c
> --- 25/drivers/scsi/sr.c~64-bit-dev_t-kdev_t	2003-05-03 15:06:44.000000000 -0700
> +++ 25-akpm/drivers/scsi/sr.c	2003-05-03 15:06:44.000000000 -0700
> @@ -56,7 +56,7 @@
>  MODULE_PARM(xa_test, "i");	/* see sr_ioctl.c */
>  
> 
> -#define SR_DISKS	(1 << KDEV_MINOR_BITS)
> +#define SR_DISKS	256
>  
>  #define MAX_RETRIES	3
>  #define SR_TIMEOUT	(30 * HZ)
> diff -puN fs/xfs/linux/xfs_super.c~64-bit-dev_t-kdev_t fs/xfs/linux/xfs_super.c
> --- 25/fs/xfs/linux/xfs_super.c~64-bit-dev_t-kdev_t	2003-05-03 15:06:44.000000000 -0700
> +++ 25-akpm/fs/xfs/linux/xfs_super.c	2003-05-03 15:06:44.000000000 -0700
> @@ -251,8 +251,8 @@ xfs_setsize_buftarg(
>  
>  	if (set_blocksize(btp->pbr_bdev, sectorsize)) {
>  		printk(KERN_WARNING
> -			"XFS: Cannot set_blocksize to %u on device 0x%x\n",
> -			sectorsize, btp->pbr_dev);
> +			"XFS: Cannot set_blocksize to %u on device 0x%llx\n",
> +			sectorsize, (unsigned long long) btp->pbr_dev);
>  	}
>  }
>  
> diff -puN include/asm-i386/posix_types.h~64-bit-dev_t-kdev_t include/asm-i386/posix_types.h
> --- 25/include/asm-i386/posix_types.h~64-bit-dev_t-kdev_t	2003-05-03 15:06:44.000000000 -0700
> +++ 25-akpm/include/asm-i386/posix_types.h	2003-05-03 15:06:44.000000000 -0700
> @@ -7,7 +7,9 @@
>   * assume GCC is being used.
>   */
>  
> -typedef unsigned short	__kernel_dev_t;
> +#ifdef __GNUC__
> +typedef unsigned long long	__kernel_dev_t;
> +#endif
>  typedef unsigned long	__kernel_ino_t;
>  typedef unsigned short	__kernel_mode_t;
>  typedef unsigned short	__kernel_nlink_t;
> diff -puN include/linux/kdev_t.h~64-bit-dev_t-kdev_t include/linux/kdev_t.h
> --- 25/include/linux/kdev_t.h~64-bit-dev_t-kdev_t	2003-05-03 15:06:44.000000000 -0700
> +++ 25-akpm/include/linux/kdev_t.h	2003-05-03 15:06:44.000000000 -0700
> @@ -1,82 +1,14 @@
>  #ifndef _LINUX_KDEV_T_H
>  #define _LINUX_KDEV_T_H
>  #ifdef __KERNEL__
> -/*
> -As a preparation for the introduction of larger device numbers,
> -we introduce a type kdev_t to hold them. No information about
> -this type is known outside of this include file.
> -
> -Objects of type kdev_t designate a device. Outside of the kernel
> -the corresponding things are objects of type dev_t - usually an
> -integral type with the device major and minor in the high and low
> -bits, respectively. Conversion is done by
> -
> -extern kdev_t to_kdev_t(int);
> -
> -It is up to the various file systems to decide how objects of type
> -dev_t are stored on disk.
> -The only other point of contact between kernel and outside world
> -are the system calls stat and mknod, new versions of which will
> -eventually have to be used in libc.
> -
> -[Unfortunately, the floppy control ioctls fail to hide the internal
> -kernel structures, and the fd_device field of a struct floppy_drive_struct
> -is user-visible. So, it remains a dev_t for the moment, with some ugly
> -conversions in floppy.c.]
> -
> -Inside the kernel, we aim for a kdev_t type that is a pointer
> -to a structure with information about the device (like major,
> -minor, size, blocksize, sectorsize, name, read-only flag,
> -struct file_operations etc.).
> -
> -However, for the time being we let kdev_t be almost the same as dev_t:
> -
> -typedef struct { unsigned short major, minor; } kdev_t;
> -
> -Admissible operations on an object of type kdev_t:
> -- passing it along
> -- comparing it for equality with another such object
> -- storing it in inode->i_rdev or tty->device
> -- using its bit pattern as argument in a hash function
> -- finding its major and minor
> -- complaining about it
> -
> -An object of type kdev_t is created only by the function MKDEV(),
> -with the single exception of the constant 0 (no device).
> -
> -Right now the other information mentioned above is usually found
> -in static arrays indexed by major or major,minor.
> -
> -An obstacle to immediately using
> -    typedef struct { ... (* lots of information *) } *kdev_t
> -is the case of mknod used to create a block device that the
> -kernel doesn't know about at present (but first learns about
> -when some module is inserted).
> -
> -aeb - 950811
> -*/
>  
> +#include <linux/types.h>       /* for dev_t */
>  
> -/*
> - * NOTE NOTE NOTE!
> - *
> - * The kernel-internal "kdev_t" will eventually have
> - * 20 bits for minor numbers, and 12 bits for majors.
> - *
> - * HOWEVER, the external representation is still 8+8
> - * bits, and there is no way to generate the extended
> - * "kdev_t" format yet. Which is just as well, since
> - * we still use "minor" as an index into various
> - * static arrays, and they are sized for a 8-bit index.
> - */
>  typedef struct {
> -	unsigned short value;
> +	unsigned long long value;
>  } kdev_t;
>  
> -#define KDEV_MINOR_BITS		8
> -#define KDEV_MAJOR_BITS		8
> -
> -#define __mkdev(major,minor)	(((major) << KDEV_MINOR_BITS) + (minor))
> +#define __mkdev(major, minor)	(((unsigned long long)(major) << 32) + (minor))
>  
>  #define mk_kdev(major, minor)	((kdev_t) { __mkdev(major,minor) } )
>  
> @@ -85,12 +17,12 @@ typedef struct {
>   * internal equality comparisons and for things
>   * like NFS filehandle conversion.
>   */
> -static inline unsigned int kdev_val(kdev_t dev)
> +static inline unsigned long long kdev_val(kdev_t dev)
>  {
>  	return dev.value;
>  }
>  
> -static inline kdev_t val_to_kdev(unsigned int val)
> +static inline kdev_t val_to_kdev(unsigned long long val)
>  {
>  	kdev_t dev;
>  	dev.value = val;
> @@ -107,30 +39,68 @@ static inline int kdev_same(kdev_t dev1,
>  
>  #define kdev_none(d1)	(!kdev_val(d1))
>  
> -/* Mask off the high bits for now.. */
> -#define minor(dev)	((dev).value & 0xff)
> -#define major(dev)	(((dev).value >> KDEV_MINOR_BITS) & 0xff)
> +#define minor(dev)	(unsigned int)((dev).value & 0xffffffff)
> +#define major(dev)	(unsigned int)((dev).value >> 32)
>  
>  /* These are for user-level "dev_t" */
> -#define MINORBITS	8
> -#define MINORMASK	((1U << MINORBITS) - 1)
> +/* Going back and forth between dev and (ma,mi) is one-to-one
> +   provided ma is nonzero or ma is zero and mi is 8-bit only.
> +   Never use major 0 together with a minor larger than 255. */
> +#if 0
> +/* readable versions */
> +static inline unsigned int
> +MAJOR(dev_t dev) {
> +        return (dev & ~0xffffffffULL) ? (dev >> 32) :
> +                (dev & ~0xffff) ? (dev >> 16) : (dev >> 8);
> +}
> +
> +static inline unsigned int
> +MINOR(dev_t dev) {
> +        return (dev & ~0xffffffffULL) ? (dev & 0xffffffff) :
> +                (dev & ~0xffff) ? (dev & 0xffff) : (dev & 0xff);
> +}
>  
> -#define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
> -#define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
> -#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
> +static inline dev_t
> +MKDEV(unsigned int major, unsigned int minor) {
> +        unsigned int both = (major | minor);
> +        return ((both & ~0xffff) ? (((dev_t) major) << 32) :
> +                (both & ~0xff) ? (((dev_t) major) << 16) :
> +                (((dev_t) major) << 8) ) | minor;
> +}
> +#else
> +/* ugly macro versions */
> +#define MAJOR(dev) ((unsigned int)({ dev_t __dev = dev; \
> +   (__dev & ~0xffffffffULL) ? (__dev >> 32) : \
> +   (__dev & ~0xffff) ? (__dev >> 16) : (__dev >> 8); }))
> +#define MINOR(dev) ((unsigned int)({ dev_t __dev = dev; \
> +   (__dev & ~0xffffffffULL) ? (__dev & 0xffffffff) : \
> +   (__dev & ~0xffff) ? (__dev & 0xffff) : (__dev & 0xff); }))
> +#define constant_MKDEV(ma, mi) \
> +   ((((ma)|(mi)) & ~0xffff) ? ((ma) << 32) | (mi) : \
> +    (((ma)|(mi)) & ~0xff) ? ((ma) << 16) | (mi) : ((ma) << 8) | (mi))
> +#define MKDEV(major, minor) ({ \
> +   unsigned int __ma = major, __mi = minor, __both = (__ma | __mi); \
> +   ((sizeof(dev_t) > 4 && (__both & ~0xffff)) ? (((dev_t) __ma) << 32) : \
> +    (__both & ~0xff) ? (((dev_t) __ma) << 16) : (((dev_t) __ma) << 8) \
> +   ) | __mi; })
> +#endif
>  
>  /*
>   * Conversion functions
>   */
>  
> -static inline int kdev_t_to_nr(kdev_t dev)
> +static inline dev_t kdev_t_to_nr(kdev_t dev)
>  {
> -	return MKDEV(major(dev), minor(dev));
> +	unsigned int ma = major(dev);
> +	unsigned int mi = minor(dev);
> +	return MKDEV(ma, mi);
>  }
>  
> -static inline kdev_t to_kdev_t(int dev)
> +static inline kdev_t to_kdev_t(dev_t dev)
>  {
> -	return mk_kdev(MAJOR(dev),MINOR(dev));
> +	unsigned int ma = MAJOR(dev);
> +	unsigned int mi = MINOR(dev);
> +	return mk_kdev(ma, mi);
>  }
>  
>  #else /* __KERNEL__ */
> @@ -138,6 +108,7 @@ static inline kdev_t to_kdev_t(int dev)
>  /*
>  Some programs want their definitions of MAJOR and MINOR and MKDEV
>  from the kernel sources. These must be the externally visible ones.
> +Of course such programs should be updated.
>  */
>  #define MAJOR(dev)	((dev)>>8)
>  #define MINOR(dev)	((dev) & 0xff)
> diff -puN include/linux/raid/md_k.h~64-bit-dev_t-kdev_t include/linux/raid/md_k.h
> --- 25/include/linux/raid/md_k.h~64-bit-dev_t-kdev_t	2003-05-03 15:06:44.000000000 -0700
> +++ 25-akpm/include/linux/raid/md_k.h	2003-05-03 15:06:44.000000000 -0700
> @@ -64,11 +64,7 @@ static inline int level_to_pers (int lev
>  typedef struct mddev_s mddev_t;
>  typedef struct mdk_rdev_s mdk_rdev_t;
>  
> -#if (MINORBITS != 8)
> -#error MD does not handle bigger kdev yet
> -#endif
> -
> -#define MAX_MD_DEVS  (1<<MINORBITS)	/* Max number of md dev */
> +#define MAX_MD_DEVS  256	/* Max number of md dev */
>  
>  /*
>   * options passed in raidrun:
> diff -puN include/linux/root_dev.h~64-bit-dev_t-kdev_t include/linux/root_dev.h
> --- 25/include/linux/root_dev.h~64-bit-dev_t-kdev_t	2003-05-03 15:06:44.000000000 -0700
> +++ 25-akpm/include/linux/root_dev.h	2003-05-03 15:06:44.000000000 -0700
> @@ -1,18 +1,16 @@
>  #ifndef _ROOT_DEV_H_
>  #define _ROOT_DEV_H_
>  
> -enum {
> -	Root_NFS = MKDEV(UNNAMED_MAJOR, 255),
> -	Root_RAM0 = MKDEV(RAMDISK_MAJOR, 0),
> -	Root_RAM1 = MKDEV(RAMDISK_MAJOR, 1),
> -	Root_FD0 = MKDEV(FLOPPY_MAJOR, 0),
> -	Root_HDA1 = MKDEV(IDE0_MAJOR, 1),
> -	Root_HDA2 = MKDEV(IDE0_MAJOR, 2),
> -	Root_SDA1 = MKDEV(SCSI_DISK0_MAJOR, 1),
> -	Root_SDA2 = MKDEV(SCSI_DISK0_MAJOR, 2),
> -	Root_HDC1 = MKDEV(IDE1_MAJOR, 1),
> -	Root_SR0 = MKDEV(SCSI_CDROM_MAJOR, 0),
> -};
> +#define	Root_NFS	MKDEV(UNNAMED_MAJOR, 255)
> +#define	Root_RAM0	MKDEV(RAMDISK_MAJOR, 0)
> +#define	Root_RAM1	MKDEV(RAMDISK_MAJOR, 1)
> +#define	Root_FD0	MKDEV(FLOPPY_MAJOR, 0)
> +#define	Root_HDA1	MKDEV(IDE0_MAJOR, 1)
> +#define	Root_HDA2	MKDEV(IDE0_MAJOR, 2)
> +#define	Root_SDA1	MKDEV(SCSI_DISK0_MAJOR, 1)
> +#define	Root_SDA2	MKDEV(SCSI_DISK0_MAJOR, 2)
> +#define	Root_HDC1	MKDEV(IDE1_MAJOR, 1)
> +#define	Root_SR0	MKDEV(SCSI_CDROM_MAJOR, 0)
>  
>  extern dev_t ROOT_DEV;
>  
> 
> _
> 

