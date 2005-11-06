Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbVKFGX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVKFGX2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 01:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbVKFGX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 01:23:28 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:14340 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751036AbVKFGX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 01:23:27 -0500
Date: Sun, 6 Nov 2005 14:22:42 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Arnd Bergmann <arnd@arndb.de>
cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       hpa@zytor.com, autofs@linux.kernel.org
Subject: Re: [PATCH 15/25] autofs: move ioctl32 to autofs{,4}/root.c
In-Reply-To: <20051105162716.551500000@b551138y.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.63.0511061407160.2621@donald.themaw.net>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
 <20051105162716.551500000@b551138y.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.87,
	required 5, BAYES_00 -2.60, DATE_IN_PAST_12_24 0.70,
	UPPERCASE_25_50 0.03)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Nov 2005, Arnd Bergmann wrote:

> All autofs ioctl calls are simple to convert for 32 bit
> compatibility. This just moves the handler into the file
> system code.

I have a couple of concerns with these patches.

I'm not sure if I like conditional compilation in the code proper but I'll 
leave it to you to make the final decision since your running with the 
change. Is there a reason the definitions can't simply be left in place?

Its been a while since I trawled through the compat ioctl code (please 
point me to the right place) but with this change I think that the 
AUTOFS_IOC_SETTIMEOUT32 is redundant. Consider a conditional define for 
AUTOFS_IOC_SETTIMEOUT in include/linux/auto_fs.h instead. Both autofs and 
autofs4 use that definition.

The lock_kernel()/unlock_kernel() in the autofs4 patch is ineffective as 
the BKL is not used for syncronisation anywhere else in autofs4. If 
removing it causes problems I need to know about'em so I can fix'em 
(hopefully).

Can't see any other obvious issues.

Ian

> 
> CC: hpa@zytor.com
  CC: raven@themaw.net ... also please
> CC: autofs@linux.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Index: linux-cg/fs/autofs/root.c
> ===================================================================
> --- linux-cg.orig/fs/autofs/root.c	2005-11-05 15:47:38.000000000 +0100
> +++ linux-cg/fs/autofs/root.c	2005-11-05 15:48:02.000000000 +0100
> @@ -10,6 +10,8 @@
>   *
>   * ------------------------------------------------------------------------- */
>  
> +#include <linux/config.h>
> +#include <linux/compat.h>
>  #include <linux/errno.h>
>  #include <linux/stat.h>
>  #include <linux/param.h>
> @@ -24,11 +26,15 @@
>  static int autofs_root_rmdir(struct inode *,struct dentry *);
>  static int autofs_root_mkdir(struct inode *,struct dentry *,int);
>  static int autofs_root_ioctl(struct inode *, struct file *,unsigned int,unsigned long);
> +static long autofs_root_compat_ioctl(struct file *,unsigned int,unsigned long);
>  
>  struct file_operations autofs_root_operations = {
>  	.read		= generic_read_dir,
>  	.readdir	= autofs_root_readdir,
>  	.ioctl		= autofs_root_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl	= autofs_root_compat_ioctl,
> +#endif
>  };
>  
>  struct inode_operations autofs_root_inode_operations = {
> @@ -562,3 +568,32 @@
>  		return -ENOSYS;
>  	}
>  }
> +
> +#ifdef CONFIG_COMPAT
> +/* AUTOFS */
> +#define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
> +
> +static long autofs_root_compat_ioctl(struct file *file, unsigned int cmd,
> +				unsigned long arg)
> +{
> +	int ret;
> +
> +	switch (cmd) {
> +	case AUTOFS_IOC_SETTIMEOUT32:
> +		cmd = AUTOFS_IOC_SETTIMEOUT;
> +	case AUTOFS_IOC_CATATONIC:
> +	case AUTOFS_IOC_PROTOVER:
> +	case AUTOFS_IOC_EXPIRE:
> +		arg = (unsigned long) compat_ptr(arg);
> +	case AUTOFS_IOC_READY:
> +	case AUTOFS_IOC_FAIL:
> +		lock_kernel();
> +		ret = autofs_root_ioctl(file->f_dentry->d_inode, file, cmd, arg);
> +		unlock_kernel();
> +		break;
> +	default:
> +		ret = -ENOIOCTLCMD;
> +	}
> +	return ret;
> +}
> +#endif
> Index: linux-cg/fs/autofs4/root.c
> ===================================================================
> --- linux-cg.orig/fs/autofs4/root.c	2005-11-05 15:47:38.000000000 +0100
> +++ linux-cg/fs/autofs4/root.c	2005-11-05 16:00:48.000000000 +0100
> @@ -12,6 +12,8 @@
>   *
>   * ------------------------------------------------------------------------- */
>  
> +#include <linux/config.h>
> +#include <linux/compat.h>
>  #include <linux/errno.h>
>  #include <linux/stat.h>
>  #include <linux/param.h>
> @@ -24,6 +26,7 @@
>  static int autofs4_dir_rmdir(struct inode *,struct dentry *);
>  static int autofs4_dir_mkdir(struct inode *,struct dentry *,int);
>  static int autofs4_root_ioctl(struct inode *, struct file *,unsigned int,unsigned long);
> +static long autofs4_root_compat_ioctl(struct file *,unsigned int,unsigned long);
>  static int autofs4_dir_open(struct inode *inode, struct file *file);
>  static int autofs4_dir_close(struct inode *inode, struct file *file);
>  static int autofs4_dir_readdir(struct file * filp, void * dirent, filldir_t filldir);
> @@ -37,6 +40,9 @@
>  	.read		= generic_read_dir,
>  	.readdir	= autofs4_root_readdir,
>  	.ioctl		= autofs4_root_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl	= autofs4_root_compat_ioctl,
> +#endif
>  };
>  
>  struct file_operations autofs4_dir_operations = {
> @@ -817,3 +823,38 @@
>  		return -ENOSYS;
>  	}
>  }
> +
> +#ifdef CONFIG_COMPAT
> +/* AUTOFS */
> +#define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
> +
> +static long autofs4_root_compat_ioctl(struct file *file, unsigned int cmd,
> +				unsigned long arg)
> +{
> +	int ret;
> +
> +	switch (cmd) {
> +	case AUTOFS_IOC_SETTIMEOUT32:
> +		cmd = AUTOFS_IOC_SETTIMEOUT;
> +	case AUTOFS_IOC_CATATONIC:
> +	case AUTOFS_IOC_PROTOVER:
> +	case AUTOFS_IOC_EXPIRE:
> +	case AUTOFS_IOC_EXPIRE_MULTI:
> +	case AUTOFS_IOC_PROTOSUBVER:
> +	case AUTOFS_IOC_ASKREGHOST:
> +	case AUTOFS_IOC_TOGGLEREGHOST:
> +	case AUTOFS_IOC_ASKUMOUNT:
> +		arg = (unsigned long) compat_ptr(arg);
> +	case AUTOFS_IOC_READY:
> +	case AUTOFS_IOC_FAIL:
> +		lock_kernel();
> +		ret = autofs4_root_ioctl(file->f_dentry->d_inode,
> +					 file, cmd, arg);
> +		unlock_kernel();
> +		break;
> +	default:
> +		ret = -ENOIOCTLCMD;
> +	}
> +	return ret;
> +}
> +#endif
> Index: linux-cg/fs/compat_ioctl.c
> ===================================================================
> --- linux-cg.orig/fs/compat_ioctl.c	2005-11-05 15:48:01.000000000 +0100
> +++ linux-cg/fs/compat_ioctl.c	2005-11-05 16:44:07.000000000 +0100
> @@ -337,11 +337,6 @@
>  	return -EINVAL;
>  }
>  
> -static int ioc_settimeout(unsigned int fd, unsigned int cmd, unsigned long arg)
> -{
> -	return rw_long(fd, AUTOFS_IOC_SETTIMEOUT, arg);
> -}
> -
>  /* Bluetooth ioctls */
>  #define HCIUARTSETPROTO	_IOW('U', 200, int)
>  #define HCIUARTGETPROTO	_IOR('U', 201, int)
> @@ -918,8 +913,6 @@
>  HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
>  HANDLE_IOCTL(CDROMREADAUDIO, cdrom_ioctl_trans)
>  HANDLE_IOCTL(CDROM_SEND_PACKET, cdrom_ioctl_trans)
> -#define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
> -HANDLE_IOCTL(AUTOFS_IOC_SETTIMEOUT32, ioc_settimeout)
>  /* vfat */
>  HANDLE_IOCTL(VFAT_IOCTL_READDIR_BOTH32, vfat_ioctl32)
>  HANDLE_IOCTL(VFAT_IOCTL_READDIR_SHORT32, vfat_ioctl32)
> Index: linux-cg/include/linux/compat_ioctl.h
> ===================================================================
> --- linux-cg.orig/include/linux/compat_ioctl.h	2005-11-05 15:48:01.000000000 +0100
> +++ linux-cg/include/linux/compat_ioctl.h	2005-11-05 16:44:07.000000000 +0100
> @@ -360,17 +360,6 @@
>  COMPATIBLE_IOCTL(SOUND_MIXER_GETLEVELS)
>  COMPATIBLE_IOCTL(SOUND_MIXER_SETLEVELS)
>  COMPATIBLE_IOCTL(OSS_GETVERSION)
> -/* AUTOFS */
> -ULONG_IOCTL(AUTOFS_IOC_READY)
> -ULONG_IOCTL(AUTOFS_IOC_FAIL)
> -COMPATIBLE_IOCTL(AUTOFS_IOC_CATATONIC)
> -COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOVER)
> -COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE)
> -COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE_MULTI)
> -COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOSUBVER)
> -COMPATIBLE_IOCTL(AUTOFS_IOC_ASKREGHOST)
> -COMPATIBLE_IOCTL(AUTOFS_IOC_TOGGLEREGHOST)
> -COMPATIBLE_IOCTL(AUTOFS_IOC_ASKUMOUNT)
>  /* DEVFS */
>  COMPATIBLE_IOCTL(DEVFSDIOC_GET_PROTO_REV)
>  COMPATIBLE_IOCTL(DEVFSDIOC_SET_EVENT_MASK)
> 
> --
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

