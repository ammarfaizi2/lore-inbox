Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129117AbQJZXni>; Thu, 26 Oct 2000 19:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQJZXn2>; Thu, 26 Oct 2000 19:43:28 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:1284 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129117AbQJZXnU>; Thu, 26 Oct 2000 19:43:20 -0400
Message-ID: <39F8C0BA.CF0F284D@timpanogas.org>
Date: Thu, 26 Oct 2000 17:39:38 -0600
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: killing read_ahead[]
In-Reply-To: <39F5999B.91DDC98@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,

A lot of changes.  Have you tested this adequately?   Changes of this
magnitude this late in the 2.4 cycle could break a lot of stuff.  I'll
apply your patch, and let you know.

:-)

Jeff

Martin Dalecki wrote:
> 
> Hello!
> 
> Please have a look at the following patch and feel free to be scared
> by the fact how UTTERLY BROKEN and ARBITRARY the current usage of the
> read_ahead[] array and during the whole past decade was!
> If you really care about clean internal interfaces this should be
> one of those prio number ONE targets to shoot at...
> 
> The most amanzing thing is that the whole test10-pre5 kernel with this
> patch applied doesn't show any performance penalties for me at all!
> And of corse it's about 10k smaller...
> 
> --mdcki
> 
>   ------------------------------------------------------------------------
> diff -ur linux-test10-pre5/arch/sparc64/kernel/ioctl32.c linux/arch/sparc64/kernel/ioctl32.c
> --- linux-test10-pre5/arch/sparc64/kernel/ioctl32.c     Tue Oct 24 13:52:02 2000
> +++ linux/arch/sparc64/kernel/ioctl32.c Tue Oct 24 15:37:56 2000
> @@ -2136,7 +2136,7 @@
>         uint32_t lv_badblock;
>         uint32_t lv_allocation;
>         uint32_t lv_io_timeout;
> -       uint32_t lv_read_ahead;
> +       uint32_t lv_NOT_USED;
>         /* delta to version 1 starts here */
>         u32 lv_snapshot_org;
>         u32 lv_snapshot_prev;
> @@ -3100,7 +3100,6 @@
>  COMPATIBLE_IOCTL(BLKROGET)
>  COMPATIBLE_IOCTL(BLKRRPART)
>  COMPATIBLE_IOCTL(BLKFLSBUF)
> -COMPATIBLE_IOCTL(BLKRASET)
>  COMPATIBLE_IOCTL(BLKFRASET)
>  COMPATIBLE_IOCTL(BLKSECTSET)
>  COMPATIBLE_IOCTL(BLKSSZGET)
> @@ -3621,7 +3620,6 @@
>  HANDLE_IOCTL(SIOCRTMSG, ret_einval)
>  HANDLE_IOCTL(SIOCGSTAMP, do_siocgstamp)
>  HANDLE_IOCTL(HDIO_GETGEO, hdio_getgeo)
> -HANDLE_IOCTL(BLKRAGET, w_long)
>  HANDLE_IOCTL(BLKGETSIZE, w_long)
>  HANDLE_IOCTL(0x1260, broken_blkgetsize)
>  HANDLE_IOCTL(BLKFRAGET, w_long)
> diff -ur linux-test10-pre5/drivers/acorn/block/mfmhd.c linux/drivers/acorn/block/mfmhd.c
> --- linux-test10-pre5/drivers/acorn/block/mfmhd.c       Wed Oct  4 01:39:44 2000
> +++ linux/drivers/acorn/block/mfmhd.c   Tue Oct 24 15:35:40 2000
> @@ -1231,8 +1231,6 @@
>         case BLKFLSBUF:
>         case BLKROSET:
>         case BLKROGET:
> -       case BLKRASET:
> -       case BLKRAGET:
>         case BLKPG:
>                 return blk_ioctl(dev, cmd, arg);
> 
> @@ -1448,7 +1446,6 @@
>         hdc63463_irqpollmask    = irqmask;
> 
>         blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
> -       read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB?) read ahread */
> 
>  #ifndef MODULE
>         mfm_gendisk.next = gendisk_head;
> diff -ur linux-test10-pre5/drivers/block/DAC960.c linux/drivers/block/DAC960.c
> --- linux-test10-pre5/drivers/block/DAC960.c    Tue Oct 24 13:52:03 2000
> +++ linux/drivers/block/DAC960.c        Tue Oct 24 15:24:51 2000
> @@ -1931,10 +1931,7 @@
>    Controller->GenericDiskInfo.sizes = Controller->PartitionSizes;
>    blksize_size[MajorNumber] = Controller->BlockSizes;
>    max_sectors[MajorNumber] = Controller->MaxSectorsPerRequest;
> -  /*
> -    Initialize Read Ahead to 128 sectors.
> -  */
> -  read_ahead[MajorNumber] = 128;
> +
>    /*
>      Complete initialization of the Generic Disk Information structure.
>    */
> @@ -4964,16 +4961,6 @@
>        return put_user(Controller->GenericDiskInfo.part[MINOR(Inode->i_rdev)]
>                                                  .nr_sects,
>                       (long *) Argument);
> -    case BLKRAGET:
> -      /* Get Read-Ahead. */
> -      if ((long *) Argument == NULL) return -EINVAL;
> -      return put_user(read_ahead[MAJOR(Inode->i_rdev)], (long *) Argument);
> -    case BLKRASET:
> -      /* Set Read-Ahead. */
> -      if (!capable(CAP_SYS_ADMIN)) return -EACCES;
> -      if (Argument > 256) return -EINVAL;
> -      read_ahead[MAJOR(Inode->i_rdev)] = Argument;
> -      return 0;
>      case BLKFLSBUF:
>        /* Flush Buffers. */
>        if (!capable(CAP_SYS_ADMIN)) return -EACCES;
> diff -ur linux-test10-pre5/drivers/block/acsi.c linux/drivers/block/acsi.c
> --- linux-test10-pre5/drivers/block/acsi.c      Thu Feb 17 00:42:05 2000
> +++ linux/drivers/block/acsi.c  Tue Oct 24 15:24:13 2000
> @@ -1792,9 +1792,8 @@
>         }
>         phys_acsi_buffer = virt_to_phys( acsi_buffer );
>         STramMask = ATARIHW_PRESENT(EXTD_DMA) ? 0x00000000 : 0xff000000;
> -
> +
>         blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
> -       read_ahead[MAJOR_NR] = 8;               /* 8 sector (4kB) read-ahead */
>         acsi_gendisk.next = gendisk_head;
>         gendisk_head = &acsi_gendisk;
> 
> diff -ur linux-test10-pre5/drivers/block/ataflop.c linux/drivers/block/ataflop.c
> --- linux-test10-pre5/drivers/block/ataflop.c   Wed Jul  5 20:24:40 2000
> +++ linux/drivers/block/ataflop.c       Tue Oct 24 15:33:40 2000
> @@ -1571,8 +1571,6 @@
>         switch (cmd) {
>                 case BLKROSET:
>                 case BLKROGET:
> -               case BLKRASET:
> -               case BLKRAGET:
>                 case BLKFLSBUF:
>                         return blk_ioctl(device, cmd, param);
>         }
> diff -ur linux-test10-pre5/drivers/block/blkpg.c linux/drivers/block/blkpg.c
> --- linux-test10-pre5/drivers/block/blkpg.c     Mon Mar 13 04:32:57 2000
> +++ linux/drivers/block/blkpg.c Tue Oct 24 15:29:31 2000
> @@ -29,7 +29,7 @@
>   */
> 
>  #include <linux/errno.h>
> -#include <linux/fs.h>                  /* for BLKRASET, ... */
> +#include <linux/fs.h>
>  #include <linux/sched.h>               /* for capable() */
>  #include <linux/blk.h>                 /* for set_device_ro() */
>  #include <linux/blkpg.h>
> @@ -220,18 +220,6 @@
>                 case BLKROGET:
>                         intval = (is_read_only(dev) != 0);
>                         return put_user(intval, (int *)(arg));
> -
> -               case BLKRASET:
> -                       if(!capable(CAP_SYS_ADMIN))
> -                               return -EACCES;
> -                       if(!dev || arg > 0xff)
> -                               return -EINVAL;
> -                       read_ahead[MAJOR(dev)] = arg;
> -                       return 0;
> -               case BLKRAGET:
> -                       if (!arg)
> -                               return -EINVAL;
> -                       return put_user(read_ahead[MAJOR(dev)], (long *) arg);
> 
>                 case BLKFLSBUF:
>                         if(!capable(CAP_SYS_ADMIN))
> diff -ur linux-test10-pre5/drivers/block/cciss.c linux/drivers/block/cciss.c
> --- linux-test10-pre5/drivers/block/cciss.c     Tue Oct 24 13:52:03 2000
> +++ linux/drivers/block/cciss.c Tue Oct 24 15:34:14 2000
> @@ -395,8 +395,6 @@
>         case BLKFLSBUF:
>         case BLKROSET:
>         case BLKROGET:
> -       case BLKRASET:
> -       case BLKRAGET:
>         case BLKPG:
>                 return( blk_ioctl(inode->i_rdev, cmd, arg));
>         case CCISS_GETPCIINFO:
> @@ -1841,7 +1839,6 @@
>                 /* fill in the other Kernel structs */
>                 blksize_size[MAJOR_NR+i] = hba[i]->blocksizes;
>                  hardsect_size[MAJOR_NR+i] = hba[i]->hardsizes;
> -                read_ahead[MAJOR_NR+i] = READ_AHEAD;
> 
>                 /* Fill in the gendisk data */
>                 hba[i]->gendisk.major = MAJOR_NR + i;
> diff -ur linux-test10-pre5/drivers/block/cpqarray.c linux/drivers/block/cpqarray.c
> --- linux-test10-pre5/drivers/block/cpqarray.c  Tue Oct 24 13:52:03 2000
> +++ linux/drivers/block/cpqarray.c      Tue Oct 24 15:33:53 2000
> @@ -503,7 +503,6 @@
>                 blk_queue_headactive(BLK_DEFAULT_QUEUE(MAJOR_NR + i), 0);
>                 blksize_size[MAJOR_NR+i] = ida_blocksizes + (i*256);
>                 hardsect_size[MAJOR_NR+i] = ida_hardsizes + (i*256);
> -               read_ahead[MAJOR_NR+i] = READ_AHEAD;
> 
>                 ida_gendisk[i].major = MAJOR_NR + i;
>                 ida_gendisk[i].major_name = "ida";
> @@ -1209,8 +1208,6 @@
>         case BLKFLSBUF:
>         case BLKROSET:
>         case BLKROGET:
> -       case BLKRASET:
> -       case BLKRAGET:
>         case BLKPG:
>                 return blk_ioctl(inode->i_rdev, cmd, arg);
> 
> diff -ur linux-test10-pre5/drivers/block/floppy.c linux/drivers/block/floppy.c
> --- linux-test10-pre5/drivers/block/floppy.c    Tue Oct 24 13:52:03 2000
> +++ linux/drivers/block/floppy.c        Tue Oct 24 15:33:28 2000
> @@ -3455,8 +3455,6 @@
>         switch (cmd) {
>                 case BLKROSET:
>                 case BLKROGET:
> -               case BLKRASET:
> -               case BLKRAGET:
>                 case BLKFLSBUF:
>                         return blk_ioctl(device, cmd, param);
>         }
> diff -ur linux-test10-pre5/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
> --- linux-test10-pre5/drivers/block/ll_rw_blk.c Tue Oct 24 13:52:03 2000
> +++ linux/drivers/block/ll_rw_blk.c     Tue Oct 24 15:25:23 2000
> @@ -65,10 +65,6 @@
>   */
>  spinlock_t io_request_lock = SPIN_LOCK_UNLOCKED;
> 
> -/* This specifies how many sectors to read ahead on the disk. */
> -
> -int read_ahead[MAX_BLKDEV];
> -
>  /* blk_dev_struct is:
>   *     *request_fn
>   *     *current_request
> diff -ur linux-test10-pre5/drivers/block/paride/pcd.c linux/drivers/block/paride/pcd.c
> --- linux-test10-pre5/drivers/block/paride/pcd.c        Wed Apr  5 04:25:14 2000
> +++ linux/drivers/block/paride/pcd.c    Tue Oct 24 15:23:56 2000
> @@ -344,7 +344,6 @@
>                 if (PCD.present) register_cdrom(&PCD.info);
> 
>         blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
> -       read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
> 
>         for (i=0;i<PCD_UNITS;i++) pcd_blocksizes[i] = 1024;
>          blksize_size[MAJOR_NR] = pcd_blocksizes;
> diff -ur linux-test10-pre5/drivers/block/paride/pd.c linux/drivers/block/paride/pd.c
> --- linux-test10-pre5/drivers/block/paride/pd.c Tue Jun 20 16:24:52 2000
> +++ linux/drivers/block/paride/pd.c     Tue Oct 24 15:34:00 2000
> @@ -453,8 +453,7 @@
>         q->back_merge_fn = pd_back_merge_fn;
>         q->front_merge_fn = pd_front_merge_fn;
>         q->merge_requests_fn = pd_merge_requests_fn;
> -        read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
> -
> +
>         pd_gendisk.major = major;
>         pd_gendisk.major_name = name;
>         pd_gendisk.next = gendisk_head;
> @@ -543,8 +542,6 @@
>                  return pd_revalidate(inode->i_rdev);
>             case BLKROSET:
>             case BLKROGET:
> -           case BLKRASET:
> -           case BLKRAGET:
>             case BLKFLSBUF:
>             case BLKPG:
>                 return blk_ioctl(inode->i_rdev, cmd, arg);
> diff -ur linux-test10-pre5/drivers/block/paride/pf.c linux/drivers/block/paride/pf.c
> --- linux-test10-pre5/drivers/block/paride/pf.c Wed Apr  5 04:25:14 2000
> +++ linux/drivers/block/paride/pf.c     Tue Oct 24 15:34:06 2000
> @@ -413,8 +413,7 @@
>         q->back_merge_fn = pf_back_merge_fn;
>         q->front_merge_fn = pf_front_merge_fn;
>         q->merge_requests_fn = pf_merge_requests_fn;
> -        read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
> -
> +
>         for (i=0;i<PF_UNITS;i++) pf_blocksizes[i] = 1024;
>         blksize_size[MAJOR_NR] = pf_blocksizes;
>         for (i=0;i<PF_UNITS;i++)
> @@ -491,8 +490,6 @@
>                  return (0);
>             case BLKROSET:
>             case BLKROGET:
> -           case BLKRASET:
> -           case BLKRAGET:
>             case BLKFLSBUF:
>                 return blk_ioctl(inode->i_rdev, cmd, arg);
>              default:
> diff -ur linux-test10-pre5/drivers/block/ps2esdi.c linux/drivers/block/ps2esdi.c
> --- linux-test10-pre5/drivers/block/ps2esdi.c   Fri Jul 14 21:20:22 2000
> +++ linux/drivers/block/ps2esdi.c       Tue Oct 24 15:33:46 2000
> @@ -181,7 +181,6 @@
>         }
>         /* set up some global information - indicating device specific info */
>         blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
> -       read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
> 
>         /* some minor housekeeping - setup the global gendisk structure */
>         ps2esdi_gendisk.next = gendisk_head;
> @@ -1153,8 +1152,6 @@
> 
>                 case BLKROSET:
>                 case BLKROGET:
> -               case BLKRASET:
> -               case BLKRAGET:
>                 case BLKFLSBUF:
>                 case BLKPG:
>                         return blk_ioctl(inode->i_rdev, cmd, arg);
> diff -ur linux-test10-pre5/drivers/block/xd.c linux/drivers/block/xd.c
> --- linux-test10-pre5/drivers/block/xd.c        Tue Oct 24 13:52:03 2000
> +++ linux/drivers/block/xd.c    Tue Oct 24 15:33:35 2000
> @@ -168,7 +168,6 @@
>         }
>         devfs_handle = devfs_mk_dir (NULL, xd_gendisk.major_name, NULL);
>         blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
> -       read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
>         xd_gendisk.next = gendisk_head;
>         gendisk_head = &xd_gendisk;
>         xd_geninit();
> @@ -352,8 +351,6 @@
>                 case BLKFLSBUF:
>                 case BLKROSET:
>                 case BLKROGET:
> -               case BLKRASET:
> -               case BLKRAGET:
>                 case BLKPG:
>                         return blk_ioctl(inode->i_rdev, cmd, arg);
> 
> @@ -1116,7 +1113,6 @@
>         blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
>         blk_size[MAJOR_NR] = NULL;
>         hardsect_size[MAJOR_NR] = NULL;
> -       read_ahead[MAJOR_NR] = 0;
>         for (gdp = &gendisk_head; *gdp; gdp = &((*gdp)->next))
>                 if (*gdp == &xd_gendisk)
>                         break;
> diff -ur linux-test10-pre5/drivers/cdrom/aztcd.c linux/drivers/cdrom/aztcd.c
> --- linux-test10-pre5/drivers/cdrom/aztcd.c     Fri Jul 14 21:20:22 2000
> +++ linux/drivers/cdrom/aztcd.c Tue Oct 24 15:20:59 2000
> @@ -1803,7 +1803,6 @@
>  #ifndef AZT_KERNEL_PRIOR_2_1
>         blksize_size[MAJOR_NR] = aztcd_blocksizes;
>  #endif
> -       read_ahead[MAJOR_NR] = 4;
>         register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &azt_fops, 0);
> 
>          if ((azt_port==0x1f0)||(azt_port==0x170))
> diff -ur linux-test10-pre5/drivers/cdrom/cdu31a.c linux/drivers/cdrom/cdu31a.c
> --- linux-test10-pre5/drivers/cdrom/cdu31a.c    Wed Jul 19 06:40:47 2000
> +++ linux/drivers/cdrom/cdu31a.c        Tue Oct 24 15:20:45 2000
> @@ -3508,7 +3508,6 @@
>        is_a_cdu31a = strcmp("CD-ROM CDU31A", drive_config.product_id) == 0;
> 
>        blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
> -      read_ahead[MAJOR_NR] = CDU31A_READAHEAD;
>        cdu31a_block_size = 1024; /* 1kB default block size */
>        /* use 'mount -o block=2048' */
>        blksize_size[MAJOR_NR] = &cdu31a_block_size;
> diff -ur linux-test10-pre5/drivers/cdrom/cm206.c linux/drivers/cdrom/cm206.c
> --- linux-test10-pre5/drivers/cdrom/cm206.c     Wed Jul 19 06:40:47 2000
> +++ linux/drivers/cdrom/cm206.c Tue Oct 24 15:19:59 2000
> @@ -26,7 +26,7 @@
>   25 feb 1995: 0.21a writes also in interrupt mode, still some
>               small bugs to be found... Larger buffer.
>    2 mrt 1995: 0.22 Bug found (cd-> nowhere, interrupt was called in
> -              initialization), read_ahead of 16. Timeouts implemented.
> +              initialization), read ahead of 16. Timeouts implemented.
>               unclear if they do something...
>    7 mrt 1995: 0.23 Start of background read-ahead.
>   18 mrt 1995: 0.24 Working background read-ahead. (still problems)
> @@ -1399,7 +1399,6 @@
>    }
>    blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
>    blksize_size[MAJOR_NR] = cm206_blocksizes;
> -  read_ahead[MAJOR_NR] = 16;   /* reads ahead what? */
>    init_bh(CM206_BH, cm206_bh);
> 
>    memset(cd, 0, sizeof(*cd));  /* give'm some reasonable value */
> diff -ur linux-test10-pre5/drivers/cdrom/gscd.c linux/drivers/cdrom/gscd.c
> --- linux-test10-pre5/drivers/cdrom/gscd.c      Wed Jul 19 07:52:32 2000
> +++ linux/drivers/cdrom/gscd.c  Tue Oct 24 15:19:38 2000
> @@ -1086,8 +1086,7 @@
> 
>         blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
>         blksize_size[MAJOR_NR] = gscd_blocksizes;
> -       read_ahead[MAJOR_NR] = 4;
> -
> +
>          disk_state = 0;
>          gscdPresent = 1;
> 
> diff -ur linux-test10-pre5/drivers/cdrom/mcd.c linux/drivers/cdrom/mcd.c
> --- linux-test10-pre5/drivers/cdrom/mcd.c       Wed Oct  4 01:39:49 2000
> +++ linux/drivers/cdrom/mcd.c   Tue Oct 24 15:19:25 2000
> @@ -1194,7 +1194,6 @@
> 
>         blksize_size[MAJOR_NR] = mcd_blocksizes;
>         blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
> -       read_ahead[MAJOR_NR] = 4;
> 
>         /* check for card */
> 
> diff -ur linux-test10-pre5/drivers/cdrom/mcdx.c linux/drivers/cdrom/mcdx.c
> --- linux-test10-pre5/drivers/cdrom/mcdx.c      Wed Jul 19 06:40:47 2000
> +++ linux/drivers/cdrom/mcdx.c  Tue Oct 24 15:19:16 2000
> @@ -1118,7 +1118,6 @@
>         }
> 
>         blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
> -       read_ahead[MAJOR_NR] = READ_AHEAD;
>         blksize_size[MAJOR_NR] = mcdx_blocksizes;
> 
>         xtrace(INIT, "init() subscribe irq and i/o\n");
> diff -ur linux-test10-pre5/drivers/cdrom/optcd.c linux/drivers/cdrom/optcd.c
> --- linux-test10-pre5/drivers/cdrom/optcd.c     Wed Jul  5 22:15:19 2000
> +++ linux/drivers/cdrom/optcd.c Tue Oct 24 15:19:04 2000
> @@ -2069,7 +2069,6 @@
>         hardsect_size[MAJOR_NR] = &hsecsize;
>         blksize_size[MAJOR_NR] = &blksize;
>         blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
> -       read_ahead[MAJOR_NR] = 4;
>         request_region(optcd_port, 4, "optcd");
>         register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &opt_fops, 0);
> 
> diff -ur linux-test10-pre5/drivers/cdrom/sbpcd.c linux/drivers/cdrom/sbpcd.c
> --- linux-test10-pre5/drivers/cdrom/sbpcd.c     Tue Oct 24 13:52:03 2000
> +++ linux/drivers/cdrom/sbpcd.c Tue Oct 24 15:18:52 2000
> @@ -4508,13 +4508,7 @@
>                 msg(DBG_AUD,"read_audio: successful return.\n");
>                 RETURN_UP(0);
>         } /* end of CDROMREADAUDIO */
> -
> -       case BLKRASET:
> -               if(!capable(CAP_SYS_ADMIN)) RETURN_UP(-EACCES);
> -               if(!(cdi->dev)) RETURN_UP(-EINVAL);
> -               if(arg > 0xff) RETURN_UP(-EINVAL);
> -               read_ahead[MAJOR(cdi->dev)] = arg;
> -               RETURN_UP(0);
> +
>         default:
>                 msg(DBG_IOC,"ioctl: unknown function request %04X\n", cmd);
>                 RETURN_UP(-EINVAL);
> @@ -5816,10 +5810,8 @@
>         }
>         blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
>         blk_queue_headactive(BLK_DEFAULT_QUEUE(MAJOR_NR), 0);
> -       read_ahead[MAJOR_NR] = buffers * (CD_FRAMESIZE / 512);
> -
>         request_region(CDo_command,4,major_name);
> -
> +
>         devfs_handle = devfs_mk_dir (NULL, "sbp", NULL);
>         for (j=0;j<NR_SBPCD;j++)
>         {
> diff -ur linux-test10-pre5/drivers/cdrom/sbpcd.h linux/drivers/cdrom/sbpcd.h
> --- linux-test10-pre5/drivers/cdrom/sbpcd.h     Mon Sep 11 12:04:09 2000
> +++ linux/drivers/cdrom/sbpcd.h Tue Oct 24 15:17:49 2000
> @@ -162,7 +162,7 @@
>  /*==========================================================================*/
>  /*==========================================================================*/
>  /*
> - * driver's own read_ahead, data mode
> + * driver's own read ahead, data mode
>   */
>  #define SBP_BUFFER_FRAMES 8
> 
> diff -ur linux-test10-pre5/drivers/cdrom/sjcd.c linux/drivers/cdrom/sjcd.c
> --- linux-test10-pre5/drivers/cdrom/sjcd.c      Fri Jul 14 21:20:22 2000
> +++ linux/drivers/cdrom/sjcd.c  Tue Oct 24 15:27:12 2000
> @@ -1479,7 +1479,6 @@
>    }
> 
>    blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
> -  read_ahead[ MAJOR_NR ] = 4;
>    register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &sjcd_fops, 0);
> 
>    if( check_region( sjcd_base, 4 ) ){
> diff -ur linux-test10-pre5/drivers/cdrom/sonycd535.c linux/drivers/cdrom/sonycd535.c
> --- linux-test10-pre5/drivers/cdrom/sonycd535.c Wed Oct  4 01:39:49 2000
> +++ linux/drivers/cdrom/sonycd535.c     Tue Oct 24 15:18:00 2000
> @@ -1599,7 +1599,6 @@
>                                 }
>                                 blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
>                                 blksize_size[MAJOR_NR] = &sonycd535_block_size;
> -                               read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read-ahead */
> 
>                                 sony_toc = (struct s535_sony_toc *)
>                                         kmalloc(sizeof *sony_toc, GFP_KERNEL);
> diff -ur linux-test10-pre5/drivers/i2o/i2o_block.c linux/drivers/i2o/i2o_block.c
> --- linux-test10-pre5/drivers/i2o/i2o_block.c   Fri Jul  7 04:24:51 2000
> +++ linux/drivers/i2o/i2o_block.c       Tue Oct 24 15:35:53 2000
> @@ -963,8 +963,6 @@
>                 case BLKFLSBUF:
>                 case BLKROSET:
>                 case BLKROGET:
> -               case BLKRASET:
> -               case BLKRAGET:
>                 case BLKPG:
>                         return blk_ioctl(inode->i_rdev, cmd, arg);
> 
> diff -ur linux-test10-pre5/drivers/ide/hd.c linux/drivers/ide/hd.c
> --- linux-test10-pre5/drivers/ide/hd.c  Wed Jul  5 20:24:41 2000
> +++ linux/drivers/ide/hd.c      Tue Oct 24 15:34:53 2000
> @@ -646,8 +646,6 @@
> 
>                 case BLKROSET:
>                 case BLKROGET:
> -               case BLKRASET:
> -               case BLKRAGET:
>                 case BLKFLSBUF:
>                 case BLKPG:
>                         return blk_ioctl(inode->i_rdev, cmd, arg);
> @@ -829,7 +827,6 @@
>                 return -1;
>         }
>         blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
> -       read_ahead[MAJOR_NR] = 8;               /* 8 sector (4kB) read-ahead */
>         hd_gendisk.next = gendisk_head;
>         gendisk_head = &hd_gendisk;
>         init_timer(&device_timer);
> diff -ur linux-test10-pre5/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
> --- linux-test10-pre5/drivers/ide/ide-cd.c      Mon Sep 11 12:04:10 2000
> +++ linux/drivers/ide/ide-cd.c  Tue Oct 24 14:55:18 2000
> @@ -2402,7 +2402,6 @@
>         int major = HWIF(drive)->major;
>         int minor = drive->select.b.unit << PARTN_BITS;
> 
> -       ide_add_setting(drive,  "breada_readahead",     SETTING_RW, BLKRAGET, BLKRASET, TYPE_INT, 0, 255, 1, 2, &read_ahead[major], NULL);
>         ide_add_setting(drive,  "file_readahead",       SETTING_RW, BLKFRAGET, BLKFRASET, TYPE_INTA, 0, INT_MAX, 1, 1024, &max_readahead[major][minor], NULL);
>         ide_add_setting(drive,  "max_kb_per_request",   SETTING_RW, BLKSECTGET, BLKSECTSET, TYPE_INTA, 1, 255, 1, 2, &max_sectors[major][minor], NULL);
>         ide_add_setting(drive,  "dsc_overlap",          SETTING_RW, -1, -1, TYPE_BYTE, 0, 1, 1, 1, &drive->dsc_overlap, NULL);
> diff -ur linux-test10-pre5/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
> --- linux-test10-pre5/drivers/ide/ide-disk.c    Tue Oct 24 13:52:05 2000
> +++ linux/drivers/ide/ide-disk.c        Tue Oct 24 14:26:51 2000
> @@ -702,7 +702,6 @@
>         ide_add_setting(drive,  "bswap",                SETTING_READ,                                   -1,                     -1,                     TYPE_BYTE,      0,      1,                              1,      1,      &drive->bswap,                  NULL);
>         ide_add_setting(drive,  "multcount",            id ? SETTING_RW : SETTING_READ,                 HDIO_GET_MULTCOUNT,     HDIO_SET_MULTCOUNT,     TYPE_BYTE,      0,      id ? id->max_multsect : 0,      1,      2,      &drive->mult_count,             set_multcount);
>         ide_add_setting(drive,  "nowerr",               SETTING_RW,                                     HDIO_GET_NOWERR,        HDIO_SET_NOWERR,        TYPE_BYTE,      0,      1,                              1,      1,      &drive->nowerr,                 set_nowerr);
> -       ide_add_setting(drive,  "breada_readahead",     SETTING_RW,                                     BLKRAGET,               BLKRASET,               TYPE_INT,       0,      255,                            1,      2,      &read_ahead[major],             NULL);
>         ide_add_setting(drive,  "file_readahead",       SETTING_RW,                                     BLKFRAGET,              BLKFRASET,              TYPE_INTA,      0,      INT_MAX,                        1,      1024,   &max_readahead[major][minor],   NULL);
>         ide_add_setting(drive,  "max_kb_per_request",   SETTING_RW,                                     BLKSECTGET,             BLKSECTSET,             TYPE_INTA,      1,      255,                            1,      2,      &max_sectors[major][minor],     NULL);
>         ide_add_setting(drive,  "lun",                  SETTING_RW,                                     -1,                     -1,                     TYPE_INT,       0,      7,                              1,      1,      &drive->lun,                    NULL);
> diff -ur linux-test10-pre5/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
> --- linux-test10-pre5/drivers/ide/ide-floppy.c  Fri Apr 14 07:50:32 2000
> +++ linux/drivers/ide/ide-floppy.c      Tue Oct 24 15:17:15 2000
> @@ -1520,7 +1520,6 @@
>         ide_add_setting(drive,  "bios_cyl",             SETTING_RW,                                     -1,                     -1,                     TYPE_INT,       0,      1023,                           1,      1,      &drive->bios_cyl,               NULL);
>         ide_add_setting(drive,  "bios_head",            SETTING_RW,                                     -1,                     -1,                     TYPE_BYTE,      0,      255,                            1,      1,      &drive->bios_head,              NULL);
>         ide_add_setting(drive,  "bios_sect",            SETTING_RW,                                     -1,                     -1,                     TYPE_BYTE,      0,      63,                             1,      1,      &drive->bios_sect,              NULL);
> -       ide_add_setting(drive,  "breada_readahead",     SETTING_RW,                                     BLKRAGET,               BLKRASET,               TYPE_INT,       0,      255,                            1,      2,      &read_ahead[major],             NULL);
>         ide_add_setting(drive,  "file_readahead",       SETTING_RW,                                     BLKFRAGET,              BLKFRASET,              TYPE_INTA,      0,      INT_MAX,                        1,      1024,   &max_readahead[major][minor],   NULL);
>         ide_add_setting(drive,  "max_kb_per_request",   SETTING_RW,                                     BLKSECTGET,             BLKSECTSET,             TYPE_INTA,      1,      255,                            1,      2,      &max_sectors[major][minor],     NULL);
> 
> diff -ur linux-test10-pre5/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
> --- linux-test10-pre5/drivers/ide/ide-probe.c   Fri Aug  4 01:29:49 2000
> +++ linux/drivers/ide/ide-probe.c       Tue Oct 24 14:27:43 2000
> @@ -853,7 +853,6 @@
>         init_gendisk(hwif);
>         blk_dev[hwif->major].data = hwif;
>         blk_dev[hwif->major].queue = ide_get_queue;
> -       read_ahead[hwif->major] = 8;    /* (4kB) */
>         hwif->present = 1;      /* success */
> 
>  #if (DEBUG_SPINLOCK > 0)
> diff -ur linux-test10-pre5/drivers/md/lvm.c linux/drivers/md/lvm.c
> --- linux-test10-pre5/drivers/md/lvm.c  Wed Oct  4 01:39:52 2000
> +++ linux/drivers/md/lvm.c      Tue Oct 24 15:39:53 2000
> @@ -173,10 +173,6 @@
>  #include <linux/errno.h>
>  #include <linux/lvm.h>
> 
> -#define        LVM_CORRECT_READ_AHEAD(a)                               \
> -       (((a) < LVM_MIN_READ_AHEAD || (a) > LVM_MAX_READ_AHEAD) \
> -        ? LVM_MAX_READ_AHEAD : (a))
> -
>  #ifndef WRITEA
>  #  define WRITEA WRITE
>  #endif
> @@ -878,34 +874,6 @@
>                 invalidate_buffers(inode->i_rdev);
>                 break;
> 
> -
> -       case BLKRASET:
> -               /* set read ahead for block device */
> -               if (!capable(CAP_SYS_ADMIN)) return -EACCES;
> -
> -#ifdef DEBUG_IOCTL
> -               printk(KERN_DEBUG
> -                      "%s -- lvm_blk_ioctl -- BLKRASET: %d sectors for %02X:%02X\n",
> -                      lvm_name, (long) arg, MAJOR(inode->i_rdev), minor);
> -#endif
> -               if ((long) arg < LVM_MIN_READ_AHEAD ||
> -                   (long) arg > LVM_MAX_READ_AHEAD)
> -                       return -EINVAL;
> -               read_ahead[MAJOR_NR] = lv_ptr->lv_read_ahead = (long) arg;
> -               break;
> -
> -
> -       case BLKRAGET:
> -               /* get current read ahead setting */
> -#ifdef DEBUG_IOCTL
> -               printk(KERN_DEBUG
> -                      "%s -- lvm_blk_ioctl -- BLKRAGET\n", lvm_name);
> -#endif
> -               if (put_user(lv_ptr->lv_read_ahead, (long *)arg))
> -                       return -EFAULT;
> -               break;
> -
> -
>         case HDIO_GETGEO:
>                 /* get disk geometry */
>  #ifdef DEBUG_IOCTL
> @@ -2080,7 +2048,6 @@
>         lvm_size[MINOR(lv_ptr->lv_dev)] = lv_ptr->lv_size >> 1;
>         vg_lv_map[MINOR(lv_ptr->lv_dev)].vg_number = vg_ptr->vg_number;
>         vg_lv_map[MINOR(lv_ptr->lv_dev)].lv_number = lv_ptr->lv_number;
> -       read_ahead[MAJOR_NR] = lv_ptr->lv_read_ahead = LVM_CORRECT_READ_AHEAD(lv_ptr->lv_read_ahead);
>         vg_ptr->lv_cur++;
>         lv_ptr->lv_status = lv_status_save;
> 
> @@ -2331,7 +2298,6 @@
>         lvm_size[MINOR(lv_ptr->lv_dev)] = lv_ptr->lv_size >> 1;
>         /* vg_lv_map array doesn't have to be changed here */
> 
> -       read_ahead[MAJOR_NR] = lv_ptr->lv_read_ahead = LVM_CORRECT_READ_AHEAD(lv_ptr->lv_read_ahead);
>         lv_ptr->lv_status = lv_status_save;
> 
>         return 0;
> diff -ur linux-test10-pre5/drivers/md/md.c linux/drivers/md/md.c
> --- linux-test10-pre5/drivers/md/md.c   Tue Oct 24 13:52:05 2000
> +++ linux/drivers/md/md.c       Tue Oct 24 15:10:53 2000
> @@ -1674,7 +1674,6 @@
>         md_hd_struct[mdidx(mddev)].start_sect = 0;
>         md_hd_struct[mdidx(mddev)].nr_sects = md_size[mdidx(mddev)] << 1;
> 
> -       read_ahead[MD_MAJOR] = 1024;
>         return (0);
>  }
> 
> @@ -2561,22 +2560,6 @@
>                         invalidate_buffers(dev);
>                         goto done;
> 
> -               case BLKRASET:
> -                       if (arg > 0xff) {
> -                               err = -EINVAL;
> -                               goto abort;
> -                       }
> -                       read_ahead[MAJOR(dev)] = arg;
> -                       goto done;
> -
> -               case BLKRAGET:
> -                       if (!arg) {
> -                               err = -EINVAL;
> -                               goto abort;
> -                       }
> -                       err = md_put_user (read_ahead[
> -                               MAJOR(dev)], (long *) arg);
> -                       goto done;
>                 default:
>         }
> 
> @@ -3097,12 +3080,6 @@
>         sz += sprintf(page+sz, "\n");
> 
> 
> -       sz += sprintf(page+sz, "read_ahead ");
> -       if (read_ahead[MD_MAJOR] == INT_MAX)
> -               sz += sprintf(page+sz, "not set\n");
> -       else
> -               sz += sprintf(page+sz, "%d sectors\n", read_ahead[MD_MAJOR]);
> -
>         ITERATE_MDDEV(mddev,tmp) {
>                 sz += sprintf(page + sz, "md%d : %sactive", mdidx(mddev),
>                                                 mddev->pers ? "" : "in");
> @@ -3603,9 +3580,7 @@
> 
>         /* forward all md request to md_make_request */
>         blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR), md_make_request);
> -
> 
> -       read_ahead[MAJOR_NR] = INT_MAX;
>         md_gendisk.next = gendisk_head;
> 
>         gendisk_head = &md_gendisk;
> diff -ur linux-test10-pre5/drivers/s390/block/dasd.c linux/drivers/s390/block/dasd.c
> --- linux-test10-pre5/drivers/s390/block/dasd.c Thu Jun 22 07:31:02 2000
> +++ linux/drivers/s390/block/dasd.c     Tue Oct 24 15:15:58 2000
> @@ -385,16 +385,6 @@
>                         rc = fsync_dev (inp->i_rdev);
>                         break;
>                 }
> -       case BLKRAGET:{
> -                       rc = copy_to_user ((long *) data,
> -                                       read_ahead + MAJOR_NR, sizeof (long));
> -                       break;
> -               }
> -       case BLKRASET:{
> -                       rc = copy_from_user (read_ahead + MAJOR_NR,
> -                                            (long *) data, sizeof (long));
> -                       break;
> -               }
>         case BLKRRPART:{
>                         INTERNAL_CHECK ("BLKRPART not implemented%s", "");
>                         rc = -EINVAL;
> @@ -1460,7 +1450,6 @@
>                 return rc;
>         }
>  #endif /* DASD_PARANOIA */
> -        read_ahead[MAJOR_NR] = 8;
>          blk_size[MAJOR_NR] = dasd_blks;
>         hardsect_size[MAJOR_NR] = dasd_secsize;
>         blksize_size[MAJOR_NR] = dasd_blksize;
> diff -ur linux-test10-pre5/drivers/s390/block/mdisk.c linux/drivers/s390/block/mdisk.c
> --- linux-test10-pre5/drivers/s390/block/mdisk.c        Fri May 12 20:41:44 2000
> +++ linux/drivers/s390/block/mdisk.c    Tue Oct 24 15:15:27 2000
> @@ -221,23 +221,10 @@
>                 fsync_dev(inode->i_rdev);
>                 invalidate_buffers(inode->i_rdev);
>                 return 0;
> -
> -       case BLKRAGET: /* return the readahead value */
> -               if (!arg)  return -EINVAL;
> -               err = access_ok(VERIFY_WRITE, (long *) arg, sizeof(long));
> -               if (err) return err;
> -               put_user(read_ahead[MAJOR(inode->i_rdev)],(long *) arg);
> -               return 0;
> -
> -       case BLKRASET: /* set the readahead value */
> -               if (!suser()) return -EACCES;
> -               if (arg > 0xff) return -EINVAL; /* limit it */
> -               read_ahead[MAJOR(inode->i_rdev)] = arg;
> -               return 0;
> -
> +
>         case BLKRRPART: /* re-read partition table: can't do it */
>                 return -EINVAL;
> -
> +
>         case HDIO_GETGEO:
>                 /*
>                  * get geometry of device -> linear
> @@ -709,7 +696,6 @@
>         /*
>          * setup sizes for available devices
>          */
> -       read_ahead[MAJOR_NR] = MDISK_RAHEAD;    /* 8 sector (4kB) read-ahead */
>         blk_size[MAJOR_NR] = mdisk_sizes;       /* size of reserved mdisk    */
>         blksize_size[MAJOR_NR] = mdisk_blksizes;   /* blksize of device      */
>         hardsect_size[MAJOR_NR] = mdisk_hardsects;
> diff -ur linux-test10-pre5/drivers/s390/block/mdisk.h linux/drivers/s390/block/mdisk.h
> --- linux-test10-pre5/drivers/s390/block/mdisk.h        Fri May 12 20:41:44 2000
> +++ linux/drivers/s390/block/mdisk.h    Tue Oct 24 15:42:06 2000
> @@ -11,7 +11,6 @@
>  #include <linux/types.h>
> 
>  #define MDISK_DEVS 8                   /* for disks                        */
> -#define MDISK_RAHEAD 8                 /* read ahead                       */
>  #define MDISK_BLKSIZE 1024             /* 1k blocks                        */
>  #define MDISK_HARDSECT 512             /* FIXME -- 512 byte blocks         */
>  #define MDISK_MAXSECTORS 256           /* max sectors for one request      */
> diff -ur linux-test10-pre5/drivers/scsi/sd.c linux/drivers/scsi/sd.c
> --- linux-test10-pre5/drivers/scsi/sd.c Wed Oct  4 01:40:01 2000
> +++ linux/drivers/scsi/sd.c     Tue Oct 24 15:34:33 2000
> @@ -227,8 +227,6 @@
> 
>                 case BLKROSET:
>                 case BLKROGET:
> -               case BLKRASET:
> -               case BLKRAGET:
>                 case BLKFLSBUF:
>                 case BLKSSZGET:
>                 case BLKPG:
> @@ -1167,18 +1165,6 @@
>                                 rscsi_disks[i].has_part_table = 1;
>                         }
>                 }
> -       /* If our host adapter is capable of scatter-gather, then we increase
> -        * the read-ahead to 60 blocks (120 sectors).  If not, we use
> -        * a two block (4 sector) read ahead. We can only respect this with the
> -        * granularity of every 16 disks (one device major).
> -        */
> -       for (i = 0; i < N_USED_SD_MAJORS; i++) {
> -               read_ahead[SD_MAJOR(i)] =
> -                   (rscsi_disks[i * SCSI_DISKS_PER_MAJOR].device
> -                    && rscsi_disks[i * SCSI_DISKS_PER_MAJOR].device->host->sg_tablesize)
> -                   ? 120       /* 120 sector read-ahead */
> -                   : 4;        /* 4 sector read-ahead */
> -       }
> 
>         return;
>  }
> @@ -1386,7 +1372,6 @@
>         for (i = 0; i < N_USED_SD_MAJORS; i++) {
>                 blk_size[SD_MAJOR(i)] = NULL;
>                 hardsect_size[SD_MAJOR(i)] = NULL;
> -               read_ahead[SD_MAJOR(i)] = 0;
>         }
>         sd_template.dev_max = 0;
>         if (sd_gendisks != &sd_gendisk)
> diff -ur linux-test10-pre5/drivers/scsi/sr.c linux/drivers/scsi/sr.c
> --- linux-test10-pre5/drivers/scsi/sr.c Wed Oct  4 01:40:02 2000
> +++ linux/drivers/scsi/sr.c     Tue Oct 24 15:22:24 2000
> @@ -803,15 +803,6 @@
>                 register_cdrom(&scsi_CDs[i].cdi);
>         }
> 
> -
> -       /* If our host adapter is capable of scatter-gather, then we increase
> -        * the read-ahead to 16 blocks (32 sectors).  If not, we use
> -        * a two block (4 sector) read ahead. */
> -       if (scsi_CDs[0].device && scsi_CDs[0].device->host->sg_tablesize)
> -               read_ahead[MAJOR_NR] = 32;      /* 32 sector read-ahead.  Always removable. */
> -       else
> -               read_ahead[MAJOR_NR] = 4;       /* 4 sector read-ahead */
> -
>         return;
>  }
> 
> @@ -874,7 +865,6 @@
>         blksize_size[MAJOR_NR] = NULL;
>          hardsect_size[MAJOR_NR] = NULL;
>         blk_size[MAJOR_NR] = NULL;
> -       read_ahead[MAJOR_NR] = 0;
> 
>         sr_template.dev_max = 0;
>  }
> diff -ur linux-test10-pre5/drivers/scsi/sr_ioctl.c linux/drivers/scsi/sr_ioctl.c
> --- linux-test10-pre5/drivers/scsi/sr_ioctl.c   Mon Sep 11 12:04:13 2000
> +++ linux/drivers/scsi/sr_ioctl.c       Tue Oct 24 15:34:37 2000
> @@ -485,8 +485,6 @@
>         switch (cmd) {
>         case BLKROSET:
>         case BLKROGET:
> -       case BLKRASET:
> -       case BLKRAGET:
>         case BLKFLSBUF:
>         case BLKSSZGET:
>                 return blk_ioctl(cdi->dev, cmd, arg);
> diff -ur linux-test10-pre5/fs/block_dev.c linux/fs/block_dev.c
> --- linux-test10-pre5/fs/block_dev.c    Wed Oct  4 01:40:07 2000
> +++ linux/fs/block_dev.c        Tue Oct 24 14:50:54 2000
> @@ -27,7 +27,7 @@
>  {
>         struct inode * inode = filp->f_dentry->d_inode;
>         ssize_t blocksize, blocksize_bits, i, buffercount, write_error;
> -       ssize_t block, blocks;
> +       ssize_t block;
>         loff_t offset;
>         ssize_t chars;
>         ssize_t written;
> @@ -83,41 +83,19 @@
>                 if (!bh)
>                         return written ? written : -EIO;
> 
> -               if (!buffer_uptodate(bh))
> -               {
> -                 if (chars == blocksize)
> -                   wait_on_buffer(bh);
> -                 else
> -                 {
> -                   bhlist[0] = bh;
> -                   if (!filp->f_reada || !read_ahead[MAJOR(dev)]) {
> -                     /* We do this to force the read of a single buffer */
> -                     blocks = 1;
> -                   } else {
> -                     /* Read-ahead before write */
> -                     blocks = read_ahead[MAJOR(dev)] / (blocksize >> 9) / 2;
> -                     if (block + blocks > size) blocks = size - block;
> -                     if (blocks > NBUF) blocks=NBUF;
> -                     if (!blocks) blocks = 1;
> -                     for(i=1; i<blocks; i++)
> -                     {
> -                       bhlist[i] = getblk (dev, block+i, blocksize);
> -                       if (!bhlist[i])
> -                       {
> -                         while(i >= 0) brelse(bhlist[i--]);
> -                         return written ? written : -EIO;
> -                       }
> -                     }
> -                   }
> -                   ll_rw_block(READ, blocks, bhlist);
> -                   for(i=1; i<blocks; i++) brelse(bhlist[i]);
> -                   wait_on_buffer(bh);
> -                   if (!buffer_uptodate(bh)) {
> -                         brelse(bh);
> -                         return written ? written : -EIO;
> -                   }
> -                 };
> -               };
> +               if (!buffer_uptodate(bh)) {
> +                       if (chars == blocksize)
> +                               wait_on_buffer(bh);
> +                       else {
> +                               bhlist[0] = bh;
> +                               ll_rw_block(READ, 1, bhlist);
> +                               wait_on_buffer(bh);
> +                               if (!buffer_uptodate(bh)) {
> +                                       brelse(bh);
> +                                       return written ? written : -EIO;
> +                               }
> +                       }
> +               }
>  #endif
>                 block++;
>                 p = offset + bh->b_data;
> @@ -170,7 +148,7 @@
>         loff_t offset;
>         ssize_t blocksize;
>         ssize_t blocksize_bits, i;
> -       size_t blocks, rblocks, left;
> +       size_t blocks, left;
>         int bhrequest, uptodate;
>         struct buffer_head ** bhb, ** bhe;
>         struct buffer_head * buflist[NBUF];
> @@ -212,15 +190,8 @@
>         block = offset >> blocksize_bits;
>         offset &= blocksize-1;
>         size >>= blocksize_bits;
> -       rblocks = blocks = (left + offset + blocksize - 1) >> blocksize_bits;
> +       blocks = (left + offset + blocksize - 1) >> blocksize_bits;
>         bhb = bhe = buflist;
> -       if (filp->f_reada) {
> -               if (blocks < read_ahead[MAJOR(dev)] / (blocksize >> 9))
> -                       blocks = read_ahead[MAJOR(dev)] / (blocksize >> 9);
> -               if (rblocks > blocks)
> -                       blocks = rblocks;
> -
> -       }
>         if (block + blocks > size) {
>                 blocks = size - block;
>                 if (blocks == 0)
> @@ -274,7 +245,7 @@
>                                         left = 0;
>                                         break;
>                                 }
> -                       }
> +                       }
>                         if (left < blocksize - offset)
>                                 chars = left;
>                         else
> diff -ur linux-test10-pre5/fs/hfs/file.c linux/fs/hfs/file.c
> --- linux-test10-pre5/fs/hfs/file.c     Mon Sep 11 12:04:18 2000
> +++ linux/fs/hfs/file.c Tue Oct 24 15:25:57 2000
> @@ -312,9 +312,6 @@
> 
>         bhb = bhe = buflist;
>         if (reada) {
> -               if (blocks < read_ahead[MAJOR(dev)] / (HFS_SECTOR_SIZE>>9)) {
> -                       blocks = read_ahead[MAJOR(dev)] / (HFS_SECTOR_SIZE>>9);
> -               }
>                 if (block + blocks > size) {
>                         blocks = size - block;
>                 }
> diff -ur linux-test10-pre5/include/linux/fs.h linux/include/linux/fs.h
> --- linux-test10-pre5/include/linux/fs.h        Tue Oct 24 13:54:06 2000
> +++ linux/include/linux/fs.h    Tue Oct 24 15:32:40 2000
> @@ -166,8 +166,6 @@
>  #define BLKRRPART  _IO(0x12,95)        /* re-read partition table */
>  #define BLKGETSIZE _IO(0x12,96)        /* return device size */
>  #define BLKFLSBUF  _IO(0x12,97)        /* flush buffer cache */
> -#define BLKRASET   _IO(0x12,98)        /* Set read ahead for block device */
> -#define BLKRAGET   _IO(0x12,99)        /* get current read ahead setting */
>  #define BLKFRASET  _IO(0x12,100)/* set filesystem (mm/filemap.c) read-ahead */
>  #define BLKFRAGET  _IO(0x12,101)/* get filesystem (mm/filemap.c) read-ahead */
>  #define BLKSECTSET _IO(0x12,102)/* set max sectors per request (ll_rw_blk.c) */
> @@ -1234,7 +1232,6 @@
> 
>  extern ssize_t char_read(struct file *, char *, size_t, loff_t *);
>  extern ssize_t block_read(struct file *, char *, size_t, loff_t *);
> -extern int read_ahead[];
> 
>  extern ssize_t char_write(struct file *, const char *, size_t, loff_t *);
>  extern ssize_t block_write(struct file *, const char *, size_t, loff_t *);
> diff -ur linux-test10-pre5/include/linux/lvm.h linux/include/linux/lvm.h
> --- linux-test10-pre5/include/linux/lvm.h       Thu May 25 03:38:26 2000
> +++ linux/include/linux/lvm.h   Tue Oct 24 15:39:08 2000
> @@ -263,8 +263,6 @@
>  #define        LVM_MAX_STRIPES         128     /* max # of stripes */
>  #define        LVM_MAX_SIZE            ( 1024LU * 1024 * 1024 * 2)     /* 1TB[sectors] */
>  #define        LVM_MAX_MIRRORS         2       /* future use */
> -#define        LVM_MIN_READ_AHEAD      0       /* minimum read ahead sectors */
> -#define        LVM_MAX_READ_AHEAD      256     /* maximum read ahead sectors */
>  #define        LVM_MAX_LV_IO_TIMEOUT   60      /* seconds I/O timeout (future use) */
>  #define        LVM_PARTITION           0xfe    /* LVM partition id */
>  #define        LVM_NEW_PARTITION       0x8e    /* new LVM partition id (10/09/1999) */
> @@ -554,7 +552,6 @@
>      uint32_t lv_badblock;      /* for future use */
>      uint32_t lv_allocation;
>      uint32_t lv_io_timeout;    /* for future use */
> -    uint32_t lv_read_ahead;    /* HM, for future use */
>    }
>  lv_disk_v1_t;
> 
> @@ -585,7 +582,6 @@
>      uint32_t lv_badblock;      /* for future use */
>      uint32_t lv_allocation;
>      uint32_t lv_io_timeout;    /* for future use */
> -    uint32_t lv_read_ahead;
> 
>      /* delta to version 1 starts here */
>      struct lv_v2 *lv_snapshot_org;
> @@ -625,7 +621,6 @@
>      uint32_t lv_badblock;      /* for future use */
>      uint32_t lv_allocation;
>      uint32_t lv_io_timeout;    /* for future use */
> -    uint32_t lv_read_ahead;    /* HM, for future use */
>    }
>  lv_disk_v2_t;
> 
> diff -ur linux-test10-pre5/kernel/ksyms.c linux/kernel/ksyms.c
> --- linux-test10-pre5/kernel/ksyms.c    Wed Oct  4 01:40:16 2000
> +++ linux/kernel/ksyms.c        Tue Oct 24 14:21:29 2000
> @@ -487,7 +487,6 @@
>  EXPORT_SYMBOL(nr_async_pages);
>  EXPORT_SYMBOL(___strtok);
>  EXPORT_SYMBOL(init_special_inode);
> -EXPORT_SYMBOL(read_ahead);
>  EXPORT_SYMBOL(get_hash_table);
>  EXPORT_SYMBOL(get_empty_inode);
>  EXPORT_SYMBOL(insert_inode_hash);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
