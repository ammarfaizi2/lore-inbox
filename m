Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWFAMiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWFAMiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 08:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWFAMiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 08:38:12 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:16831 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750709AbWFAMiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 08:38:11 -0400
Message-ID: <447EDF09.5040807@aitel.hist.no>
Date: Thu, 01 Jun 2006 14:35:21 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2 md cause BUGs, and readahead speedup
References: <20060601014806.e86b3cc0.akpm@osdl.org>
In-Reply-To: <20060601014806.e86b3cc0.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The good stuff first, bootup went from 55s to 43s according to 
bootchart. :-)
Probably the readahead stuff.

I got some BUG messages in dmesg though, they
seem related to md initialization:

Freeing unused kernel memory: 236k freed
md: Autodetecting RAID arrays.
BUG: warning at fs/block_dev.c:944/do_open()
 <c015748d> do_open+0x2e8/0x2ed  <c025d905> cfb_imageblit+0x85/0x550
 <c02537e9> soft_cursor+0x13d/0x1a4  <c0166446> iget5_locked+0xe6/0x14e
 <c0157668> bdev_test+0x0/0xc  <c0156aec> bdget+0xd6/0xde
 <c015763d> open_partition_by_devnum+0x69/0x7c  <c034dcfa> 
md_import_device+0x78/0x24b
 <c023aedc> kobject_register+0x30/0x35  <c034cdf3> md_probe+0x12e/0x16b
 <c03506ef> md_ioctl+0x27a/0x154b  <c034f857> md_open+0x48/0x4f
 <c01573d2> do_open+0x22d/0x2ed  <c015c659> do_lookup+0x47/0x126
 <c02a84f4> scrup+0xca/0xd4  <c016422f> dput+0xba/0x177
 <c015cee9> __link_path_walk+0x7b1/0xc37  <c0252d37> bit_cursor+0x34d/0x5c3
 <c01674a0> mntput_no_expire+0x13/0x52  <c0350475> md_ioctl+0x0/0x154b
 <c023413c> blkdev_driver_ioctl+0x42/0x44  <c02343a9> 
blkdev_ioctl+0x242/0x759
 <c0166446> iget5_locked+0xe6/0x14e  <c0157668> bdev_test+0x0/0xc
 <c0156aec> bdget+0xd6/0xde  <c0157674> bdev_set+0x0/0x8
 <c0157492> blkdev_open+0x0/0x4c  <c01574ae> blkdev_open+0x1c/0x4c
 <c014fb0c> __dentry_open+0xe4/0x1a3  <c014fc58> nameidata_to_filp+0x31/0x3a
 <c014fc9a> do_filp_open+0x39/0x40  <c0156907> block_ioctl+0x18/0x1d
 <c01568ef> block_ioctl+0x0/0x1d  <c015f5c9> do_ioctl+0x19/0x55
 <c015f657> vfs_ioctl+0x52/0x247  <c015f880> sys_ioctl+0x34/0x50
 <c0468027> syscall_call+0x7/0xb  <c046007b> sctp_getsockopt+0x7a0/0x147f
BUG: warning at fs/block_dev.c:944/do_open()
 <c015748d> do_open+0x2e8/0x2ed  <c02ec589> ide_do_request+0x6c2/0x894
 <c0237dd7> cfq_insert_request+0x6b/0x4a5  <c0230fa3> 
blk_remove_plug+0x25/0x5c
 <c023100b> __generic_unplug_device+0x1f/0x25  <c0233e63> 
__make_request+0x108/0x395
 <c0166446> iget5_locked+0xe6/0x14e  <c0157668> bdev_test+0x0/0xc
 <c0156aec> bdget+0xd6/0xde  <c015763d> open_partition_by_devnum+0x69/0x7c
 <c034dcfa> md_import_device+0x78/0x24b  <c023aedc> 
kobject_register+0x30/0x35
 <c034cdf3> md_probe+0x12e/0x16b  <c03506ef> md_ioctl+0x27a/0x154b
 <c034f857> md_open+0x48/0x4f  <c01573d2> do_open+0x22d/0x2ed
 <c015c659> do_lookup+0x47/0x126  <c02a84f4> scrup+0xca/0xd4
 <c016422f> dput+0xba/0x177  <c015cee9> __link_path_walk+0x7b1/0xc37
 <c0252d37> bit_cursor+0x34d/0x5c3  <c01674a0> mntput_no_expire+0x13/0x52
 <c0350475> md_ioctl+0x0/0x154b  <c023413c> blkdev_driver_ioctl+0x42/0x44
 <c02343a9> blkdev_ioctl+0x242/0x759  <c0166446> iget5_locked+0xe6/0x14e
 <c0157668> bdev_test+0x0/0xc  <c0156aec> bdget+0xd6/0xde
 <c0157674> bdev_set+0x0/0x8  <c0157492> blkdev_open+0x0/0x4c
 <c01574ae> blkdev_open+0x1c/0x4c  <c014fb0c> __dentry_open+0xe4/0x1a3
 <c014fc58> nameidata_to_filp+0x31/0x3a  <c014fc9a> do_filp_open+0x39/0x40
 <c0156907> block_ioctl+0x18/0x1d  <c01568ef> block_ioctl+0x0/0x1d
 <c015f5c9> do_ioctl+0x19/0x55  <c015f657> vfs_ioctl+0x52/0x247
 <c015f880> sys_ioctl+0x34/0x50  <c0468027> syscall_call+0x7/0xb
 <c046007b> sctp_getsockopt+0x7a0/0x147f
md: autorun ...
md: considering hdb1 ...
.
.
.
hda: cache flushes not supported
hdb: cache flushes not supported
md: md_d0 stopped.
BUG: warning at fs/block_dev.c:944/do_open()
 <c015748d> do_open+0x2e8/0x2ed  <c0238ea7> cfq_set_request+0x1d3/0x33f
 <c0237dd7> cfq_insert_request+0x6b/0x4a5  <c022ffe4> elv_insert+0xdd/0x142
 <c0154561> bio_phys_segments+0x14/0x16  <c0233e49> 
__make_request+0xee/0x395
 <c016598b> find_inode+0x37/0x61  <c01661ce> ifind+0x29/0x61
 <c01663bc> iget5_locked+0x5c/0x14e  <c0157668> bdev_test+0x0/0xc
 <c0156a4c> bdget+0x36/0xde  <c015763d> open_partition_by_devnum+0x69/0x7c
 <c034dcfa> md_import_device+0x78/0x24b  <c04664f8> schedule+0x2a2/0x5ef
 <c01663bc> iget5_locked+0x5c/0x14e  <c035162f> md_ioctl+0x11ba/0x154b
 <c0231000> __generic_unplug_device+0x14/0x25  <c0466853> 
io_schedule+0xe/0x16
 <c0132a5f> find_get_pages_tag+0x27/0x66  <c0350475> md_ioctl+0x0/0x154b
 <c023413c> blkdev_driver_ioctl+0x42/0x44  <c02343a9> 
blkdev_ioctl+0x242/0x759
 <c013a42a> release_pages+0x2a/0x175  <c0132990> find_get_pages+0x19/0x49
 <c0467089> mutex_lock+0xb/0x1a  <c02f46dc> ide_disk_put+0x1c/0x27
 <c02f52bd> idedisk_release+0x45/0xc6  <c0165383> iput+0x35/0x62
 <c0156f14> __blkdev_put+0x77/0x187  <c0165383> iput+0x35/0x62
 <c0156f84> __blkdev_put+0xe7/0x187  <c0156907> block_ioctl+0x18/0x1d
 <c01568ef> block_ioctl+0x0/0x1d  <c015f5c9> do_ioctl+0x19/0x55
 <c015f657> vfs_ioctl+0x52/0x247  <c015f880> sys_ioctl+0x34/0x50
 <c0467fbd> sysenter_past_esp+0x56/0x79
md: bind<hdb2>
raid1: raid set md_d0 active with 1 out of 2 mirrors

The machine seems to work fine.  (That degraded array
is degraded on purpose.)

Helge Hafting
