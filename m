Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWICWPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWICWPf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWICWPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:15:33 -0400
Received: from xenotime.net ([66.160.160.81]:53381 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751031AbWICWOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:14:53 -0400
Date: Sun, 3 Sep 2006 15:18:23 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: balagi@justmail.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: added sysfs interface + bio write queue
 handling fix
Message-Id: <20060903151823.06544ba2.rdunlap@xenotime.net>
In-Reply-To: <op.tfbektu4iudtyh@master>
References: <op.tfbektu4iudtyh@master>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Sep 2006 20:20:43 +0200 Thomas Maier wrote:

> Hello,
> 
> this is a patch for the packet writing driver pktcdvd.
> It adds a sysfs interface to the driver and a bio write
> queue "congestion" handling.
> 
> The patch modifies following files of the Linux 2.6.17.11
> source tree:
>   Documentation/cdrom/packet-writing.txt
>   include/linux/pktcdvd.h
>   drivers/block/pktcdvd.c
>   drivers/block/Kconfig
>   block/genhd.c
> 
> (genhd.c must be changed to export the block_subsys
> symbol)
> 
> The bio write queue changes are in pktcdvd.c in functions:
>   pkt_make_request()
>   pkt_bio_finished()
> 
> Any comments and improvements are welcomed ;)

a.  send patches against the latest mainline kernel version
unless they only apply to -mm (then against -mm obviously)
or unless they are specifically being made to patch the
stable kernel releases.  However, even patches to -stable
should also have already been made to mainline.

b.  don't send *-zipped attachments.  do send text,
preferably inline, but text attachments as a last resort.

c.  anything that touches or modifies the kernel ABI should
also update Documentation/ABI/*.  See Documentation/ABI/README
for more info/details.

d.  kernel coding style does not put lots-of-spaces around if ():
not:
+			if ( pidx )
yes:
			if (pidx)

e.  do both the procfs and sysfs interfaces use the same code
for pkt_print_stat()?  The main reason that I ask is that
sysfs files are restricted (by convention) to one value per file
but pkt_print_stat() is printing lots of values.


> Why this patch?
> ===============
> This driver uses an internal bio write queue to store
> write requests from the block layer, passed to the driver
> over its own make_request function.
> I am using Linux 2.6.17 on an Athlon 64 X2, 2G RAM and while
> writing huge files (>200M) to a DVDRAM using the pktcdvd driver,
> the bio write queue raised >200000 entries! This led to
> kernel out of memory Oops! e.g.:
> 
> ----------------------------------------------------------
> Aug 14 17:42:26 master vmunix: pktcdvd: 4473408kB available on disc
> Aug 14 17:42:54 master vmunix: pktcdvd: write speed 4155kB/s
> Aug 14 17:54:24 master vmunix: oom-killer: gfp_mask=0xd0, order=1
> Aug 14 17:54:24 master vmunix:  <c014346f> out_of_memory+0x12f/0x150   
> <c01452d0> __alloc_pages+0x280/0x2e0
> Aug 14 17:54:24 master vmunix:  <c015a52a> cache_alloc_refill+0x2ea/0x500   
> <c015a7a1> __kmalloc+0x61/0x70
> Aug 14 17:54:24 master vmunix:  <c039c0b3> __alloc_skb+0x53/0x110   
> <c03985b6> sock_alloc_send_skb+0x176/0x1c0
> Aug 14 17:54:24 master vmunix:  <c0399c5b> sock_def_readable+0x7b/0x80   
> <c041262b> unix_stream_sendmsg+0x1cb/0x310
> Aug 14 17:54:24 master vmunix:  <c039502b> do_sock_write+0xab/0xc0   
> <c0395720> sock_aio_write+0x80/0x90
> Aug 14 17:54:24 master vmunix:  <c011a609> __wake_up_common+0x39/0x60   
> <c015d984> do_sync_write+0xc4/0x100
> Aug 14 17:54:47 master vmunix: printk: 10 messages suppressed.
> Aug 14 17:54:47 master vmunix: oom-killer: gfp_mask=0xd0, order=0
> Aug 14 17:54:47 master vmunix:  <c014346f> out_of_memory+0x12f/0x150   
> <c01452d0> __alloc_pages+0x280/0x2e0
> Aug 14 17:54:47 master vmunix:  <c0258de2> __next_cpu+0x12/0x30   
> <c015a52a> cache_alloc_refill+0x2ea/0x500
> Aug 14 17:54:47 master vmunix:  <c015a23a> kmem_cache_alloc+0x4a/0x50   
> <c03987ea> sk_alloc+0x2a/0x150
> Aug 14 17:54:47 master vmunix:  <c03e3f8d> inet_create+0xed/0x320   
> <c03950a2> sock_alloc_inode+0x12/0x70
> Aug 14 17:54:47 master vmunix:  <c017790e> alloc_inode+0xce/0x180   
> <c03966f3> __sock_create+0x123/0x2f0
> Aug 14 17:54:49 master vmunix: Total swap = 2152668kB
> Aug 14 17:54:49 master vmunix: Free swap:       2152436kB
> Aug 14 17:54:49 master vmunix: 524272 pages of RAM
> Aug 14 17:54:49 master vmunix: 294896 pages of HIGHMEM
> Aug 14 17:54:49 master vmunix: 5767 reserved pages
> Aug 14 17:54:49 master vmunix: 238277 pages shared
> Aug 14 17:54:49 master vmunix: 35 pages swap cached
> Aug 14 17:54:49 master vmunix: 47682 pages dirty
> Aug 14 17:54:49 master vmunix: 157861 pages writeback
> Aug 14 17:54:49 master vmunix: 17359 pages mapped
> Aug 14 17:54:49 master vmunix: 23835 pages slab
> Aug 14 17:54:49 master vmunix: 176 pages pagetables
> Aug 14 17:54:59 master vmunix:   <c0145355> __get_free_pages+0x25/0x40
> Aug 14 17:55:19 master vmunix: 294896 pages of HIGHM<6>5767 reserved pages
> ------------------------------------------------------------
> 
> It don't know exactly what is wrong in the kernel, but
> it seems it must be something with the kernels memory handling.
> 
> To be able to use the pktcdvd driver now, i created this patch.
> It simply limits the size of the bio write queue of the driver
> to save kernel memory. Does not cure the "kernel bug", but the
> symptom ;)
> If the number of bio write requests would raise the bio
> queue size over a high limit (congestion on), the
> make_request function waits till the worker thread has
> lowered the queue size below the "congestion off" mark.
> The wait is similar to the wait in get_request_wait(),
> called by the "normal" request function __make_request().
> 
> Peter Osterlund suggested to use the pair
>   clear_queue_congested()
>   blk_congestion_wait()
> here. But i am not sure if this is the right way to do
> it.
> 
> 
> Also there is now a sysfs interface for the driver and the
> procfs interface can be switched of by a kernel config
> parameter.
> 
> Here are more informations about the new features of the driver,
> that are added to packet-writing.txt by this patch:
> 
> 
> Using the pktcdvd sysfs interface
> ---------------------------------
> 
> The pktcdvd module has a sysfs interface and can be controlled
> by the tool "pktcdvd" that uses sysfs.
> 
> "pktcdvd" works similar to "pktsetup", e.g.:
> 
> 	# pktcdvd -a dev_name /dev/hdc
> 	# mkudffs /dev/pktcdvd/dev_name
> 	# mount -t udf -o rw,noatime /dev/pktcdvd/dev_name /dvdram
> 	# cp files /dvdram
> 	# umount /dvdram
> 	# pktcdvd -r dev_name
> 
> 
> The pktcdvd module exports these files in the sysfs:
> ( <pktdevname> is one of pktcdvd0..pktcdvd7 )
> ( <devid> is in format  major:minor )
> 
> /sys/block/pktcdvd/
>      add               (w)  Write a block device id to create a
>                             new pktcdvd device and map it the
>                             block device.
> 
>      remove            (w)  Write the pktcdvd device id or the
>                             mapped block device id to it, to
>                             remove the pktcdvd device.
> 
>      device_map        (r)  Shows the device mapping in format:
>                             <pktdevname> <pktdevid> <blkdevid>
> 
>      packet_buffers    (rw) Number of concurrent packets per
>                             pktcdvd device. Used for new created
>                             devices.
> 	
> 
> /sys/block/pktcdvd/<pktdevname>/packet/
>      stat              (r)  Show device status.
> 
>      reset_stat        (w)  Write any value to it to reset some
>                             pktcdvd device stat values, like
>                             bytes read/written.
> 
>      write_congestion_off (rw) If bio write queue size is below
>                                this mark, accept new bio requests
>                                from the block layer.
> 
>      write_congestion_on  (rw) If bio write queue size is higher
>                                as this mark, do no longer accept
>                                bio write requests from the block
>                                layer and wait till the pktcdvd
>                                device has processed enough bio's
>                                so that bio write queue size is
>                                below congestion off mark.
> 
>      mapped_to              Symbolic link to mapped block device
>                             in the sysfs tree.
> 
> 
> 
> 
> To use the pktcdvd sysfs interface directly, you can do:
> 
> 	# create a new pktcdvd device mapped to /dev/hdc
> 	echo "22:0" >/sys/block/pktcdvd/add
> 	cat /sys/block/pktcdvd/device_map
> 	# assuming device pktcdvd0 was created, look at stat's
> 	cat /sys/block/pktcdvd/pktcdvd0/packet/stat
> 	# print the device id of the mapped block device
> 	cat /sys/block/pktcdvd/pktcdvd0/packet/mapped_to/dev
> 	# similar to
> 	fgrep pktcdvd0 /sys/block/pktcdvd/device_map
> 	# remove device, using pktcdvd0 device id   253:0
> 	echo "253:0" >/sys/block/pktcdvd/remove
> 	# same as using the mapped block device id  22:0
> 	echo "22:0" >/sys/block/pktcdvd/remove
> 
> 
> Bio write queue congestion marks
> --------------------------------
> The pktcdvd driver allows now to adjust the behaviour of the
> internal bio write queue.
> This can be done with the two write_congestion_[on|off] marks.
> The driver does only accept up to write_congestion_on bio
> write request from the i/o block layer, and waits till the
> requests are processed by the mapped block device and
> the queue size is below the write_congestion_off mark.
> In previous versions of pktcdvd, the driver accepted all
> incoming bio write request. This led sometimes to kernel
> out of memory oops (maybe some bugs in the linux kernel ;)
> CAUTION: use this options only if you know what you do!
> The default settings for the congestion marks should be ok
> for everyone.

---
~Randy

-- 
VGER BF report: H 0
