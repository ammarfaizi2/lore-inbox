Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbTANJZN>; Tue, 14 Jan 2003 04:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbTANJZN>; Tue, 14 Jan 2003 04:25:13 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:20103 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP
	id <S261861AbTANJZL>; Tue, 14 Jan 2003 04:25:11 -0500
Date: Tue, 14 Jan 2003 09:34:52 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein31.homenet>
To: Christoph Hellwig <hch@lst.de>
cc: Hugh Dickins <hugh@veritas.com>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't create regular files in devfs (fwd)
In-Reply-To: <Pine.LNX.4.44.0301131851060.9994-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0301140932210.1110-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I don't know about mtrr (probably does it for the same reason) but the
reason why microcode driver uses a regular file is because it needs
something that only regular files can provide --- the file size.

This is an easy external "signifier" as to whether a successfull microcode
update has occurred or not.

Regards
Tigran

On Mon, 13 Jan 2003, Hugh Dickins wrote:

> FYI...
>
> ---------- Forwarded message ----------
> Date: Sat, 11 Jan 2003 20:56:00 +0100
> From: Christoph Hellwig <hch@lst.de>
> To: torvalds@transmeta.com
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] don't create regular files in devfs
>
> Even more devfs creptomancy :)
>
> When devfs is enabled the i386 microcode and mtrr drivers try to create
> regular files in devfs in addition to their regular interfaces
> (miscdevice and procfs).  The tools work with the normal interfaces
> anyway in non-devfs systems and regular files in _dev_fs are a rather
> strange concept..
>
> Get rid of it.
>
>
> --- 1.15/arch/i386/kernel/microcode.c	Thu Dec  5 21:56:34 2002
> +++ edited/arch/i386/kernel/microcode.c	Sat Jan 11 16:50:00 2003
> @@ -65,7 +65,6 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/miscdevice.h>
> -#include <linux/devfs_fs_kernel.h>
>  #include <linux/spinlock.h>
>  #include <linux/mm.h>
>
> @@ -122,39 +121,14 @@
>  	.fops	= &microcode_fops,
>  };
>
> -static devfs_handle_t devfs_handle;
> -
>  static int __init microcode_init(void)
>  {
> -	int error;
> -
> -	error = misc_register(&microcode_dev);
> -	if (error)
> -		printk(KERN_WARNING
> -			"microcode: can't misc_register on minor=%d\n",
> -			MICROCODE_MINOR);
> -
> -	devfs_handle = devfs_register(NULL, "cpu/microcode",
> -			DEVFS_FL_DEFAULT, 0, 0, S_IFREG | S_IRUSR | S_IWUSR,
> -			&microcode_fops, NULL);
> -	if (devfs_handle == NULL && error) {
> -		printk(KERN_ERR "microcode: failed to devfs_register()\n");
> -		misc_deregister(&microcode_dev);
> -		goto out;
> -	}
> -	error = 0;
> -	printk(KERN_INFO
> -		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n",
> -		MICROCODE_VERSION);
> -
> -out:
> -	return error;
> +	return misc_register(&microcode_dev);
>  }
>
>  static void __exit microcode_exit(void)
>  {
>  	misc_deregister(&microcode_dev);
> -	devfs_unregister(devfs_handle);
>  	if (mc_applied)
>  		kfree(mc_applied);
>  	printk(KERN_INFO "IA-32 Microcode Update Driver v%s unregistered\n",
> @@ -373,7 +347,6 @@
>  		ret = (ssize_t)len;
>  	}
>  out_fsize:
> -	devfs_set_file_size(devfs_handle, mc_fsize);
>  	vfree(microcode);
>  out_unlock:
>  	up_write(&microcode_rwsem);
> @@ -389,7 +362,6 @@
>  			if (mc_applied) {
>  				int bytes = NR_CPUS * sizeof(struct microcode);
>
> -				devfs_set_file_size(devfs_handle, 0);
>  				kfree(mc_applied);
>  				mc_applied = NULL;
>  				printk(KERN_INFO "microcode: freed %d bytes\n", bytes);
> --- 1.4/arch/i386/kernel/cpu/mtrr/if.c	Sat Dec 21 22:17:44 2002
> +++ edited/arch/i386/kernel/cpu/mtrr/if.c	Sat Jan 11 16:50:35 2003
> @@ -1,6 +1,5 @@
>  #include <linux/init.h>
>  #include <linux/proc_fs.h>
> -#include <linux/devfs_fs_kernel.h>
>  #include <linux/ctype.h>
>  #include <linux/module.h>
>  #include <linux/seq_file.h>
> @@ -300,8 +299,6 @@
>
>  #  endif			/*  CONFIG_PROC_FS  */
>
> -static devfs_handle_t devfs_handle;
> -
>  char * attrib_to_str(int x)
>  {
>  	return (x <= 6) ? mtrr_strings[x] : "?";
> @@ -337,7 +334,6 @@
>  			     attrib_to_str(type), usage_table[i]);
>  		}
>  	}
> -	devfs_set_file_size(devfs_handle, len);
>  	return 0;
>  }
>
> @@ -350,11 +346,6 @@
>  		proc_root_mtrr->owner = THIS_MODULE;
>  		proc_root_mtrr->proc_fops = &mtrr_fops;
>  	}
> -#endif
> -#ifdef USERSPACE_INTERFACE
> -	devfs_handle = devfs_register(NULL, "cpu/mtrr", DEVFS_FL_DEFAULT, 0, 0,
> -				      S_IFREG | S_IRUGO | S_IWUSR,
> -				      &mtrr_fops, NULL);
>  #endif
>  	return 0;
>  }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

