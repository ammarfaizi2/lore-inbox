Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbTEHVDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTEHVDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:03:16 -0400
Received: from smtp3.libero.it ([193.70.192.127]:51848 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S262117AbTEHVDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:03:11 -0400
Date: Thu, 8 May 2003 20:18:58 +0300
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove devfs_register
Message-ID: <20030508171858.GB468@libero.it>
References: <20030508223449.A29413@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508223449.A29413@lst.de>
User-Agent: Mutt/1.3.28i
From: Daniele Pala <dandario@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ouch! sorry i'm pretty retarded. What is used now instead of devfs_register?
Thanks,
	
	Daniele



On Thu, May 08, 2003 at 10:34:49PM +0200, Christoph Hellwig wrote:
> Whee! devfs_register isn't used anymore in the whole tree and with
> it some other devfs crap.  Kill it for good.
> 
> 
> --- 1.45/include/linux/devfs_fs_kernel.h	Fri May  2 09:55:04 2003
> +++ edited/include/linux/devfs_fs_kernel.h	Thu May  8 21:09:11 2003
> @@ -11,20 +11,7 @@
>  
>  #define DEVFS_SUPER_MAGIC                0x1373
>  
> -#define DEVFS_FL_NONE           0x000 /* This helps to make code more readable
> -				         no, it doesn't  --hch */
> -#define DEVFS_FL_DEFAULT        DEVFS_FL_NONE
> -
> -
> -typedef struct devfs_entry * devfs_handle_t;
> -
> -struct gendisk;
> -
>  #ifdef CONFIG_DEVFS_FS
> -extern devfs_handle_t devfs_register (devfs_handle_t dir, const char *name,
> -				      unsigned int flags,
> -				      unsigned int major, unsigned int minor,
> -				      umode_t mode, void *ops, void *info);
>  extern int devfs_mk_bdev(dev_t dev, umode_t mode, const char *fmt, ...)
>  	__attribute__((format (printf, 3, 4)));
>  extern int devfs_mk_cdev(dev_t dev, umode_t mode, const char *fmt, ...)
> @@ -36,19 +23,8 @@
>  	__attribute__((format (printf, 1, 2)));
>  extern int devfs_register_tape(const char *name);
>  extern void devfs_unregister_tape(int num);
> -extern void devfs_register_partition(struct gendisk *dev, int part);
>  extern void mount_devfs_fs(void);
>  #else  /*  CONFIG_DEVFS_FS  */
> -static inline devfs_handle_t devfs_register (devfs_handle_t dir,
> -					     const char *name,
> -					     unsigned int flags,
> -					     unsigned int major,
> -					     unsigned int minor,
> -					     umode_t mode,
> -					     void *ops, void *info)
> -{
> -    return NULL;
> -}
>  static inline int devfs_mk_bdev(dev_t dev, umode_t mode, const char *fmt, ...)
>  {
>  	return 0;
> @@ -73,9 +49,6 @@
>      return -1;
>  }
>  static inline void devfs_unregister_tape(int num)
> -{
> -}
> -static inline void devfs_register_partition(struct gendisk *dev, int part)
>  {
>  }
>  static inline void mount_devfs_fs (void)
> --- 1.88/fs/devfs/base.c	Fri May  2 09:55:04 2003
> +++ edited/fs/devfs/base.c	Thu May  8 21:09:58 2003
> @@ -752,6 +752,7 @@
>  #  define DPRINTK(flag, format, args...)
>  #endif
>  
> +typedef struct devfs_entry *devfs_handle_t;
>  
>  struct directory_type
>  {
> @@ -1424,98 +1425,6 @@
>  			 current->egid, &fs_info);
>  } 
>  
> -
> -/**
> - *	devfs_register - Register a device entry.
> - *	@dir: The handle to the parent devfs directory entry. If this is %NULL the
> - *		new name is relative to the root of the devfs.
> - *	@name: The name of the entry.
> - *	@flags: Must be 0
> - *	@major: The major number. Not needed for regular files.
> - *	@minor: The minor number. Not needed for regular files.
> - *	@mode: The default file mode.
> - *	@ops: The &file_operations or &block_device_operations structure.
> - *		This must not be externally deallocated.
> - *	@info: An arbitrary pointer which will be written to the @private_data
> - *		field of the &file structure passed to the device driver. You can set
> - *		this to whatever you like, and change it once the file is opened (the next
> - *		file opened will not see this change).
> - *
> - *	On failure %NULL is returned.
> - */
> -
> -devfs_handle_t devfs_register (devfs_handle_t dir, const char *name,
> -			       unsigned int flags,
> -			       unsigned int major, unsigned int minor,
> -			       umode_t mode, void *ops, void *info)
> -{
> -    int err;
> -    dev_t devnum = 0, dev = MKDEV(major, minor);
> -    struct devfs_entry *de;
> -
> -    /* we don't accept any flags anymore.  prototype will change soon. */
> -    WARN_ON(flags);
> -    WARN_ON(dir);
> -    WARN_ON(!S_ISCHR(mode));
> -
> -    if (name == NULL)
> -    {
> -	PRINTK ("(): NULL name pointer\n");
> -	return NULL;
> -    }
> -    if (ops == NULL)
> -    {
> -	PRINTK ("(%s): NULL ops pointer\n", name);
> -	return NULL;
> -    }
> -    if ( S_ISDIR (mode) )
> -    {
> -	PRINTK ("(%s): creating directories is not allowed\n", name);
> -	return NULL;
> -    }
> -    if ( S_ISLNK (mode) )
> -    {
> -	PRINTK ("(%s): creating symlinks is not allowed\n", name);
> -	return NULL;
> -    }
> -    if ( ( de = _devfs_prepare_leaf (&dir, name, mode) ) == NULL )
> -    {
> -	PRINTK ("(%s): could not prepare leaf\n", name);
> -	if (devnum) devfs_dealloc_devnum (mode, devnum);
> -	return NULL;
> -    }
> -    if (S_ISCHR (mode)) {
> -	de->u.cdev.dev = dev;
> -	de->u.cdev.autogen = devnum != 0;
> -	de->u.cdev.ops = ops;
> -    } else if (S_ISBLK (mode)) {
> -	de->u.bdev.dev = dev;
> -	de->u.cdev.autogen = devnum != 0;
> -    } else {
> -	PRINTK ("(%s): illegal mode: %x\n", name, mode);
> -	devfs_put (de);
> -	devfs_put (dir);
> -	return (NULL);
> -    }
> -    de->info = info;
> -    de->inode.uid = 0;
> -    de->inode.gid = 0;
> -    err = _devfs_append_entry(dir, de, NULL);
> -    if (err)
> -    {
> -	PRINTK ("(%s): could not append to parent, err: %d\n", name, err);
> -	devfs_put (dir);
> -	if (devnum) devfs_dealloc_devnum (mode, devnum);
> -	return NULL;
> -    }
> -    DPRINTK (DEBUG_REGISTER, "(%s): de: %p dir: %p \"%s\"  pp: %p\n",
> -	     name, de, dir, dir->name, dir->parent);
> -    devfsd_notify (de, DEVFSD_NOTIFY_REGISTERED);
> -    devfs_put (dir);
> -    return de;
> -}   /*  End Function devfs_register  */
> -
> -
>  int devfs_mk_bdev(dev_t dev, umode_t mode, const char *fmt, ...)
>  {
>  	struct devfs_entry *dir = NULL, *de;
> @@ -1935,7 +1844,6 @@
>  __setup("devfs=", devfs_setup);
>  
>  EXPORT_SYMBOL(devfs_put);
> -EXPORT_SYMBOL(devfs_register);
>  EXPORT_SYMBOL(devfs_mk_symlink);
>  EXPORT_SYMBOL(devfs_mk_dir);
>  EXPORT_SYMBOL(devfs_remove);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
