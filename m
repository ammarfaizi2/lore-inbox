Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288958AbSAFOUA>; Sun, 6 Jan 2002 09:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSAFOTv>; Sun, 6 Jan 2002 09:19:51 -0500
Received: from mail.cb.monarch.net ([24.244.11.6]:39173 "EHLO
	baca.cb.monarch.net") by vger.kernel.org with ESMTP
	id <S288958AbSAFOTb>; Sun, 6 Jan 2002 09:19:31 -0500
Date: Sun, 6 Jan 2002 06:53:20 -0700
From: "Peter J. Braam" <braam@clusterfilesystem.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: braam@clusterfs.com, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.2-pre8/fs/intermezzo kdev_t compilation fixes
Message-ID: <20020106065320.A16846@smtp.clusterfs.com>
In-Reply-To: <20020105045311.A24785@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020105045311.A24785@baldur.yggdrasil.com>; from adam@yggdrasil.com on Sat, Jan 05, 2002 at 04:53:11AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Adam, 

The latest code in CVS doesn't have the questionable behavior, and in
fact the device will entirely disappear in 2.5 timeframe.

- peter -

On Sat, Jan 05, 2002 at 04:53:11AM -0800, Adam J. Richter wrote:
> 	The following patch enables linux-2.5.2-pre8/fs/intermezzo
> to compile, adjusting it to the new kdev_t scheme.  I have not
> tested it.  I only know that it compiles.
> 
> 	In the long term, the Intermezzo team may want to look into
> whether kdev_t will reliably not use the most significant bit of
> an int (the sign bit), which seems to be the assumption in some of
> the error handling code.  I don't think that problem is imminent,
> however, as I think the currently planned kdev_t expansion is only
> to twenty bits.
> 
> -- 
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
> adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
> +1 408 261-6630         | g g d r a s i l   United States of America
> fax +1 408 261-6631      "Free Software For The Rest Of Us."

> Only in linux/fs/intermezzo: CVS
> diff -u -r linux-2.5.2-pre8/fs/intermezzo/cache.c linux/fs/intermezzo/cache.c
> --- linux-2.5.2-pre8/fs/intermezzo/cache.c	Sun Nov 11 10:20:21 2001
> +++ linux/fs/intermezzo/cache.c	Sat Jan  5 04:49:07 2002
> @@ -46,7 +46,7 @@
>  
>  static inline int presto_cache_hash(kdev_t dev)
>  {
> -        return (CACHES_MASK) & ((0x000F & (dev)) + ((0x0F00 & (dev)) >>8));
> +	return (CACHES_MASK) & ((0x000F & minor(dev)) + (0x000F & major(dev)));
>  }
>  
>  inline void presto_cache_add(struct presto_cache *cache, kdev_t dev)
> @@ -73,7 +73,7 @@
>          lh = tmp = &(presto_caches[presto_cache_hash(dev)]);
>          while ( (tmp = lh->next) != lh ) {
>                  cache = list_entry(tmp, struct presto_cache, cache_chain);
> -                if ( cache->cache_dev == dev ) {
> +                if ( kdev_same(cache->cache_dev, dev) ) {
>                          return cache;
>                  }
>          }
> @@ -89,8 +89,8 @@
>          /* find the correct presto_cache here, based on the device */
>          cache = presto_find_cache(inode->i_dev);
>          if ( !cache ) {
> -                printk("WARNING: no presto cache for dev %x, ino %ld\n",
> -                       inode->i_dev, inode->i_ino);
> +                printk("WARNING: no presto cache for dev %x:%x, ino %ld\n",
> +                       major(inode->i_dev), minor(inode->i_dev), inode->i_ino);
>                  EXIT;
>                  return NULL;
>          }
> @@ -174,7 +174,7 @@
>          cache = presto_get_cache(inode);
>          if ( !cache )
>                  return 0;
> -        return (inode->i_dev == cache->cache_dev);
> +        return kdev_same(inode->i_dev, cache->cache_dev);
>  }
>  
>  /* setup a cache structure when we need one */
> diff -u -r linux-2.5.2-pre8/fs/intermezzo/psdev.c linux/fs/intermezzo/psdev.c
> --- linux-2.5.2-pre8/fs/intermezzo/psdev.c	Fri Jan  4 19:40:37 2002
> +++ linux/fs/intermezzo/psdev.c	Sat Jan  5 04:49:07 2002
> @@ -290,7 +290,7 @@
>                  }
>  
>                  len = readmount.io_len;
> -                minor = MINOR(dev);
> +                minor = minor(dev);
>                  PRESTO_ALLOC(tmp, char *, len);
>                  if (!tmp) {
>                          EXIT;
> @@ -627,7 +627,7 @@
>                          EXIT;
>                          return error;
>                  }
> -                minor = MINOR(dev);
> +                minor = minor(dev);
>                  if (cmd == PRESTO_SETOPT)
>                          error = dosetopt(minor, &kopt);
>  
> diff -u -r linux-2.5.2-pre8/fs/intermezzo/sysctl.c linux/fs/intermezzo/sysctl.c
> --- linux-2.5.2-pre8/fs/intermezzo/sysctl.c	Fri Jan  4 19:40:37 2002
> +++ linux/fs/intermezzo/sysctl.c	Sat Jan  5 04:49:07 2002
> @@ -162,14 +162,15 @@
>  		 */
>  		int errorval = upc_comms[minor].uc_errorval;
>  		if (errorval < 0) {
> +			kdev_t dev = to_kdev_t(-errorval);
>  			if (newval == 0)
> -				set_device_ro(-errorval, 0);
> +				set_device_ro(dev, 0);
>  			else
>  				printk("device %s already read only\n",
> -				       kdevname(-errorval));
> +				       kdevname(dev));
>  		} else {
>  			if (newval < 0)
> -				set_device_ro(-newval, 1);
> +				set_device_ro(to_kdev_t(-newval), 1);
>  			upc_comms[minor].uc_errorval = newval;
>  			CDEBUG(D_PSDEV, "setting errorval to %d\n", newval);
>  		}
> @@ -224,9 +225,10 @@
>  #ifdef PSDEV_DEBUG
>  	case PSDEV_ERRORVAL: {
>  		int errorval = upc_comms[minor].uc_errorval;
> -		if (errorval < 0 && is_read_only(-errorval))
> +		kdev_t dev = to_kdev_t(-errorval);
> +		if (errorval < 0 && is_read_only(dev))
>  			printk(KERN_INFO "device %s has been set read-only\n",
> -			       kdevname(-errorval));
> +			       kdevname(dev));
>  		opt->optval = upc_comms[minor].uc_errorval;
>  		break;
>  	}
> diff -u -r linux-2.5.2-pre8/fs/intermezzo/vfs.c linux/fs/intermezzo/vfs.c
> --- linux-2.5.2-pre8/fs/intermezzo/vfs.c	Tue Nov 13 09:20:56 2001
> +++ linux/fs/intermezzo/vfs.c	Sat Jan  5 04:49:07 2002
> @@ -136,7 +136,7 @@
>          if (errorval && errorval == (long)value && !is_read_only(dev)) {
>                  CDEBUG(D_SUPER, "setting device %s read only\n", kdevname(dev));
>                  BLKDEV_FAIL(dev, 1);
> -                upc_comms[minor].uc_errorval = -dev;
> +                upc_comms[minor].uc_errorval = -kdev_t_to_nr(dev);
>          }
>  }
>  #else
> @@ -602,7 +602,7 @@
>                  goto exit_lock;
>  
>          error = -EXDEV;
> -        if (dir->d_inode->i_dev != inode->i_dev)
> +        if (!kdev_same(dir->d_inode->i_dev, inode->i_dev))
>                  goto exit_lock;
>  
>          /*
> @@ -1609,7 +1609,7 @@
>          if (error)
>                  return error;
>  
> -        if (new_dir->i_dev != old_dir->i_dev)
> +        if (!kdev_same(new_dir->i_dev, old_dir->i_dev))
>                  return -EXDEV;
>  
>          if (!new_dentry->d_inode)
> @@ -1690,7 +1690,7 @@
>          if (error)
>                  return error;
>  
> -        if (new_dir->i_dev != old_dir->i_dev)
> +        if (!kdev_same(new_dir->i_dev, old_dir->i_dev))
>                  return -EXDEV;
>  
>          if (!new_dentry->d_inode)

