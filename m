Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUE1NQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUE1NQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 09:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUE1NQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 09:16:52 -0400
Received: from smtp.cogeco.net ([216.221.81.25]:9161 "EHLO fep1.cogeco.net")
	by vger.kernel.org with ESMTP id S263107AbUE1NQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:16:42 -0400
Message-ID: <003001c444b5$ff72cee0$64fda287@docbill002>
From: "Bill C. Riemers" <docbill@freeshell.org>
To: "Todd Poynor" <tpoynor@mvista.com>, <tytso@mit.edu>,
       <busybox@mail.codepoet.org>
Cc: <linux-kernel@vger.kernel.org>
References: <20040527231932.GD7176@slurryseal.ddns.mvista.com>
Subject: Re: [BusyBox] Re: [PATCH] BLKFLSBUF on ramdisks
Date: Fri, 28 May 2004 09:06:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this problem also effect the 2.4 kernels?

I'm just wondering, because it sounds like a possible explination for
strange errors occurring with /dev/cobd? in coLinux, especially when used as
swap devices.  Basically /dev/cobd? are simmular to ramdisks, but they
refere to files mmap'ed under Windows.  They work fairly reliable, until
someone does something like "swapoff -a;swapon -a".  However, coLinux is
only used with 2.4 kernels, so if the problem does not effect 2.4 kernels,
then this is not the cause.

                                               Bill

----- Original Message ----- 
From: "Todd Poynor" <tpoynor@mvista.com>
To: <tytso@mit.edu>; <busybox@mail.codepoet.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, May 27, 2004 7:19 PM
Subject: [BusyBox] Re: [PATCH] BLKFLSBUF on ramdisks


> Sounds good to me, copying the busybox folks, who would be affected.
> -- Todd
>
> ----- Forwarded message from Theodore Ts'o <tytso@mit.edu> -----
>
> Date: Thu, 27 May 2004 15:47:09 -0400
> From: "Theodore Ts'o" <tytso@mit.edu>
> To: Todd Poynor <tpoynor@mvista.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] Re: BLKFLSBUF on ramdisks
> Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
> Todd Poynor <tpoynor@mvista.com>, linux-kernel@vger.kernel.org
> In-Reply-To: <20040527020201.GC7176@slurryseal.ddns.mvista.com>
>
> On Wed, May 26, 2004 at 07:02:01PM -0700, Todd Poynor wrote:
> > The BLKFLSBUF ioctl has a different meaning on ramdisks than on other
> > block devices: the memory for the ramdisk is freed (whereas cached
> > blocks are flushed to the device for most other devices, which obviously
> > would be a NOP for ramdisks).  At least one command, freeramdisk of
> > BusyBox, expects this behavior.  If certain other commands that issue
> > BLKFLSBUF are inadvertently run on a ramdisk device (as in a script that
> > previously tested fine on other devices) then the filesystem is
> > basically corrupted instead of the normally expected result.  For
> > example, badblocks or e2fsck -F.
> >
> > While this can be initially alarming, it is easily figured out and
> > avoided in the future (no one really needs to check bad blocks or
> > filesystem integrity on a ramdisk, and I'd assume other uses of the
> > ioctl would fall into a similar category).  The two incompatible
> > definitions of the ioctl do seem unfortunate, however, and I figured I'd
> > ask here in case there's any interest in changing this situation; if so,
> > I will gladly help, thanks,
>
> Here's a patch (against 2.6-latest) which keeps the original BLKFLSBUF
> number to perform the overloaded function, and defines a new
> RAMDISKDISCARD ioctl which is reserved exclusively for discarding the
> ramdisk, and a new ioctl number for BLKFLSBUF for only flushing the
> buffer cache.
>
> This keeps full binary compatibility for old applications, but it will
> break source-level compatibility for programs lik BusyBox.  The number
> of programs that do this are extremely rare, though, so presumably
> this would be acceptable.
>
> Comments?
>
> - Ted
>
>
> ===== drivers/block/ioctl.c 1.60 vs edited =====
> --- 1.60/drivers/block/ioctl.c Sat May 15 02:11:56 2004
> +++ edited/drivers/block/ioctl.c Thu May 27 13:10:18 2004
> @@ -190,6 +190,7 @@
>   case BLKGETSIZE64:
>   return put_u64(arg, bdev->bd_inode->i_size);
>   case BLKFLSBUF:
> + case BLKFLSBUFOLD:
>   if (!capable(CAP_SYS_ADMIN))
>   return -EACCES;
>   if (disk->fops->ioctl) {
> ===== drivers/block/nbd.c 1.72 vs edited =====
> --- 1.72/drivers/block/nbd.c Mon Feb 23 00:24:11 2004
> +++ edited/drivers/block/nbd.c Thu May 27 13:10:03 2004
> @@ -108,7 +108,7 @@
>   case NBD_SET_SIZE_BLOCKS: return "set-size-blocks";
>   case NBD_DISCONNECT: return "disconnect";
>   case BLKROSET: return "set-read-only";
> - case BLKFLSBUF: return "flush-buffer-cache";
> + case BLKFLSBUFOLD: case BLKFLSBUF: return "flush-buffer-cache";
>   }
>   return "unknown";
>  }
> ===== drivers/block/rd.c 1.95 vs edited =====
> --- 1.95/drivers/block/rd.c Sat May 22 04:23:01 2004
> +++ edited/drivers/block/rd.c Thu May 27 13:14:07 2004
> @@ -290,7 +290,7 @@
>   int error;
>   struct block_device *bdev = inode->i_bdev;
>
> - if (cmd != BLKFLSBUF)
> + if (cmd != BLKFLSBUF && cmd != RAMDISKDISCARD)
>   return -ENOTTY;
>
>   /*
> ===== drivers/mtd/mtd_blkdevs.c 1.8 vs edited =====
> --- 1.8/drivers/mtd/mtd_blkdevs.c Thu Feb 26 06:26:02 2004
> +++ edited/drivers/mtd/mtd_blkdevs.c Thu May 27 13:11:30 2004
> @@ -204,6 +204,7 @@
>
>   switch (cmd) {
>   case BLKFLSBUF:
> + case BLKFLSBUFOLD:
>   if (tr->flush)
>   return tr->flush(dev);
>   /* The core code did the work, we had nothing to do. */
> ===== include/linux/compat_ioctl.h 1.26 vs edited =====
> --- 1.26/include/linux/compat_ioctl.h Tue May 25 06:39:34 2004
> +++ edited/include/linux/compat_ioctl.h Thu May 27 15:41:30 2004
> @@ -98,6 +98,8 @@
>  COMPATIBLE_IOCTL(BLKROGET)
>  COMPATIBLE_IOCTL(BLKRRPART)
>  COMPATIBLE_IOCTL(BLKFLSBUF)
> +COMPATIBLE_IOCTL(BLKFLSBUFOLD)
> +COMPATIBLE_IOCTL(RAMDISKCLEAR)
>  COMPATIBLE_IOCTL(BLKSECTSET)
>  COMPATIBLE_IOCTL(BLKSSZGET)
>  ULONG_IOCTL(BLKRASET)
> ===== include/linux/fs.h 1.325 vs edited =====
> --- 1.325/include/linux/fs.h Tue May 25 05:53:04 2004
> +++ edited/include/linux/fs.h Thu May 27 13:14:01 2004
> @@ -182,7 +182,7 @@
>  #define BLKROGET   _IO(0x12,94) /* get read-only status (0 = read_write)
*/
>  #define BLKRRPART  _IO(0x12,95) /* re-read partition table */
>  #define BLKGETSIZE _IO(0x12,96) /* return device size /512 (long *arg) */
> -#define BLKFLSBUF  _IO(0x12,97) /* flush buffer cache */
> +#define BLKFLSBUFOLD  _IO(0x12,97) /* flush buffer cache */
>  #define BLKRASET   _IO(0x12,98) /* set read ahead for block device */
>  #define BLKRAGET   _IO(0x12,99) /* get current read ahead setting */
>  #define BLKFRASET  _IO(0x12,100)/* set filesystem (mm/filemap.c)
read-ahead */
> @@ -204,6 +204,8 @@
>  #define BLKBSZGET  _IOR(0x12,112,size_t)
>  #define BLKBSZSET  _IOW(0x12,113,size_t)
>  #define BLKGETSIZE64 _IOR(0x12,114,size_t) /* return device size in bytes
(u64 *arg) */
> +#define RAMDISKDISCARD _IO(0x12,115) /* Discard ramdisk */
> +#define BLKFLSBUF _IO(0x12,116) /* flush buffer cache */
>
>  #define BMAP_IOCTL 1 /* obsolete - kept for compatibility */
>  #define FIBMAP    _IO(0x00,1) /* bmap access */
> ===== init/do_mounts_initrd.c 1.7 vs edited =====
> --- 1.7/init/do_mounts_initrd.c Sat Mar 13 20:57:41 2004
> +++ edited/init/do_mounts_initrd.c Thu May 27 13:14:18 2004
> @@ -93,7 +93,7 @@
>   if (fd < 0) {
>   error = fd;
>   } else {
> - error = sys_ioctl(fd, BLKFLSBUF, 0);
> + error = sys_ioctl(fd, RAMDISKDISCARD, 0);
>   sys_close(fd);
>   }
>   printk(!error ? "okay\n" : "failed\n");
>
>
> ----- End forwarded message -----
>


----------------------------------------------------------------------------
----


_______________________________________________
busybox mailing list
busybox@mail.busybox.net
http://codepoet.org/mailman/listinfo/busybox


