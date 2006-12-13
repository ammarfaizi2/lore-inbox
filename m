Return-Path: <linux-kernel-owner+w=401wt.eu-S932630AbWLMJOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWLMJOM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 04:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWLMJOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 04:14:12 -0500
Received: from gw-eur5.philips.com ([161.85.125.12]:46362 "EHLO
	gw-eur5.philips.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627AbWLMJOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 04:14:06 -0500
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Fw: RFC [PATCH] 1/2 disable initramfs
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.0.3 September 26, 2003
Message-ID: <OF6500F21E.801A8DEB-ONC1257243.002FA006-C1257243.00300003@philips.com>
From: Jean-Paul Saman <jean-paul.saman@nxp.com>
Date: Wed, 13 Dec 2006 09:44:13 +0100
X-MIMETrack: Serialize by Router on ehvrmh02/H/SERVER/PHILIPS(Release 6.5.5HF805 | August
 26, 2006) at 13/12/2006 09:44:15,
	Serialize complete at 13/12/2006 09:44:15
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al,

Thank you for reviewing my other patch and telling me it was wrong. I am 
working for an embedded HW manufacturer doing linux kernel ports to their 
arm platforms. In an attempt to minimize the amount of code that needs to 
be loaded from flash in an embedded system I identified 60 Kbytes of code 
(init/initramfs.c) that was not used in our products. So I would like to 
add an option to the kernel to disable the use of initrd/initramfs when it 
isn't used at all. Saving 60Kbytes of code in memory and on flashdisk.

Are you the one I should ask to review it? Or can you suggest someone 
else?

Kind greetings,

Jean-Paul Saman

NXP Semiconductors CTO/RTG DesignIP

----- Forwarded by Jean-Paul Saman/EHV/SC/PHILIPS on 13-12-2006 09:40 
-----

linux-kernel-owner@vger.kernel.org wrote on 06-12-2006 17:39:48:

> The file init/initramfs.c is always compiled and linked in the kernel 
> vmlinux even when BLK_DEV_RAM and BLK_DEV_INITRD are disabled and the 
> system isn't using any form of an initramfs or initrd. In this situation 

> the code is only used to unpack a (static) default initial 
rootfilesystem. 
> The init/initramfs.c code compiles to a size of 60 kbytes.
> 
> This patch makes it configurable (CONFIG_BLK_DEV_INITRAMFS) to disable 
the 
> use of a initramfs (60 kbytes of code). Instead of the init/initramfs.c 
> code it uses a small routine in init/main.c to setup an initial static 
> environment for mounting a rootfilesystem later on in the kernel 
> initialisation process.
> 
> Signed-off-by: Jean-Paul Saman <jean-paul.saman@nxp.com>
> 
> Index: linux-2.6.git/drivers/block/Kconfig
> ===================================================================
> --- linux-2.6.git.orig/drivers/block/Kconfig    2006-12-06 
> 15:27:51.000000000 +0100
> +++ linux-2.6.git/drivers/block/Kconfig 2006-12-06 16:35:40.000000000 
> +0100
> @@ -411,19 +411,32 @@ config BLK_DEV_RAM_BLOCKSIZE
>           setups function - apparently needed by the rd_load_image 
routine
>           that supposes the filesystem in the image uses a 1024 
blocksize.
> 
> +config BLK_DEV_INITRAMFS
> +       bool "Enable RAM filesystem (initramfs) support"
> +       default y
> +       help
> +         The initial RAM filesystem is a ramfs filesystem which can be
> +         linked in the kernel and that is mounted as root before the 
> normal
> +         boot procedure. It is typically used to load modules needed to 

> mount
> +         the "real" root file system, etc. See 
> <file:Documentation/initrd.txt>
> +         for details.
> +
> +         Enabling BLK_DEV_RAM and BLK_DEV_INITRD adds 60 kbytes size to 

> your kernel.
> +
> +         If unsure say Y.
> +
>  config BLK_DEV_INITRD
> -       bool "Initial RAM filesystem and RAM disk (initramfs/initrd) 
> support"
> -       depends on BROKEN || !FRV
> +       bool "Check for Initial RAM disk (initrd/initramfs) on kernel 
> boot"
> +       depends on BLK_DEV_INITRAMFS && ( BROKEN || !FRV )
>         help
> -         The initial RAM filesystem is a ramfs which is loaded by the
> +         The initial RAM disk is a ramfs filesystem which is loaded by 
> the
>           boot loader (loadlin or lilo) and that is mounted as root
>           before the normal boot procedure. It is typically used to
>           load modules needed to mount the "real" root file system,
>           etc. See <file:Documentation/initrd.txt> for details.
> 
>           If RAM disk support (BLK_DEV_RAM) is also included, this
> -         also enables initial RAM disk (initrd) support.
> -
> +         also enable initial RAM filesystem disk support as initrd.
> 
>  config CDROM_PKTCDVD
>         tristate "Packet writing on CD/DVD media"
> Index: linux-2.6.git/init/Makefile
> ===================================================================
> --- linux-2.6.git.orig/init/Makefile    2006-12-06 15:27:51.000000000 
> +0100
> +++ linux-2.6.git/init/Makefile 2006-12-06 15:27:54.000000000 +0100
> @@ -2,7 +2,8 @@
>  # Makefile for the linux kernel.
>  #
> 
> -obj-y                          := main.o version.o mounts.o initramfs.o
> +obj-y                          := main.o version.o mounts.o
> +obj-$(CONFIG_BLK_DEV_INITRAMFS) := initramfs.o
>  obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
> 
>  mounts-y                       := do_mounts.o
> Index: linux-2.6.git/init/main.c
> ===================================================================
> --- linux-2.6.git.orig/init/main.c      2006-12-06 15:27:51.000000000 
> +0100
> +++ linux-2.6.git/init/main.c   2006-12-06 15:27:54.000000000 +0100
> @@ -86,7 +86,9 @@ extern void pidmap_init(void);
>  extern void prio_tree_init(void);
>  extern void radix_tree_init(void);
>  extern void free_initmem(void);
> +#ifdef CONFIG_BLK_DEV_INITRAMFS
>  extern void populate_rootfs(void);
> +#endif
>  extern void driver_init(void);
>  extern void prepare_namespace(void);
>  #ifdef CONFIG_ACPI
> @@ -705,6 +707,22 @@ static void run_init_process(char *init_
>         kernel_execve(init_filename, argv_init, envp_init);
>  }
> 
> +#ifndef CONFIG_BLK_DEV_INITRAMFS
> +/*
> + * Create a simple rootfs that is similar to the default initramfs
> + */
> +static void populate_rootfs(void)
> +{
> +        int mkdir_err = sys_mkdir("/dev", 0755);
> +        int err = sys_mknod((const char __user *) "/dev/console",
> +                                S_IFCHR | S_IRUSR | S_IWUSR,
> +                                new_encode_dev(MKDEV(5, 1)));
> +        if (err == -EROFS )
> +               printk( "Warning: Failed to create a rootfs\n" );
> +        mkdir_err = sys_mkdir("/root", 0700);
> +}
> +#endif
> +
>  static int init(void * unused)
>  {
>         lock_kernel();
> @@ -741,6 +759,7 @@ static int init(void * unused)
> 
>         do_basic_setup();
> 
> +#ifdef CONFIG_BLK_DEV_INITRAMFS
>         /*
>          * check if there is an early userspace init.  If yes, let it do 

> all
>          * the work
> @@ -753,7 +772,10 @@ static int init(void * unused)
>                 ramdisk_execute_command = NULL;
>                 prepare_namespace();
>         }
> -
> +#else
> +       ramdisk_execute_command = NULL;
> +       prepare_namespace();
> +#endif
>         /*
>          * Ok, we have completed the initial bootup, and
>          * we're essentially up and running. Get rid of the
> Index: linux-2.6.git/usr/Makefile
> ===================================================================
> --- linux-2.6.git.orig/usr/Makefile     2006-12-06 15:27:51.000000000 
> +0100
> +++ linux-2.6.git/usr/Makefile  2006-12-06 15:27:54.000000000 +0100
> @@ -7,7 +7,7 @@ PHONY += klibcdirs
> 
> 
>  # Generate builtin.o based on initramfs_data.o
> -obj-y := initramfs_data.o
> +obj-$(CONFIG_BLK_DEV_INITRAMFS) := initramfs_data.o
> 
>  # initramfs_data.o contains the initramfs_data.cpio.gz image.
>  # The image is included using .incbin, a dependency which is not
> Index: linux-2.6.git/init/Kconfig
> ===================================================================
> --- linux-2.6.git.orig/init/Kconfig     2006-12-06 15:27:51.000000000 
> +0100
> +++ linux-2.6.git/init/Kconfig  2006-12-06 15:27:54.000000000 +0100
> @@ -280,8 +280,12 @@ config RELAY
> 
>           If unsure, say N.
> 
> +if CONFIG_BLK_DEV_INITRAMFS
> +
>  source "usr/Kconfig"
> 
> +endif
> +
>  config CC_OPTIMIZE_FOR_SIZE
>         bool "Optimize for size (Look out for broken compilers!)"
>         default y
> 
> --------
> Kind greetings,
> 
> Jean-Paul Saman
> 
> NXP Semiconductors CTO/RTG DesignIP
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

