Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbVICOOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbVICOOf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 10:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbVICOOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 10:14:35 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:41359 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751459AbVICOOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 10:14:35 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.13] ieee1394: sbp2: aborting sbp2 command
Date: Sat, 3 Sep 2005 16:14:14 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509031614.14729.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

I'm seeing trouble with a firewire HDD enclosure. 

precious:/sys/bus/ieee1394/devices/0001a350000154d5# cat vendor*
0x0001a3
337 COMBO
GENESYS LOGIC, INC.
precious:/sys/bus/ieee1394/devices/0001a350000154d5# cat guid*
0x0001a350000154d5
0x0001a3
GENESYS LOGIC, INC.


When plugging it and then mounting the XFS fs on the drive, this is what i get:

Sep  3 15:06:55 precious kernel: ieee1394: Node changed: 0-00:1023 -> 0-01:1023
Sep  3 15:06:55 precious kernel: ieee1394: Node resumed: ID:BUS[0-01:1023]  GUID[0001a350000154d5]
Sep  3 15:06:55 precious kernel: ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
Sep  3 15:06:55 precious kernel: ieee1394: Node changed: 0-01:1023 -> 0-00:1023
Sep  3 15:06:55 precious kernel: ieee1394: Node changed: 0-00:1023 -> 0-01:1023
Sep  3 15:06:55 precious kernel: scsi3 : SCSI emulation for IEEE-1394 SBP-2 Devices
Sep  3 15:06:56 precious kernel: ieee1394: sbp2: Logged into SBP-2 device
Sep  3 15:06:56 precious kernel: ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
Sep  3 15:06:57 precious kernel:   Vendor: Maxtor 6  Model: Y080P0            Rev: 0.01
Sep  3 15:06:57 precious kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Sep  3 15:06:57 precious kernel: SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
Sep  3 15:06:57 precious kernel: sda: got wrong page
Sep  3 15:06:57 precious kernel: sda: assuming drive cache: write through
Sep  3 15:06:57 precious kernel: SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
Sep  3 15:06:57 precious kernel: sda: got wrong page
Sep  3 15:06:57 precious kernel: sda: assuming drive cache: write through
Sep  3 15:07:01 precious kernel:  sda: sda1
Sep  3 15:07:01 precious kernel: Attached scsi disk sda at scsi3, channel 0, id 0, lun 0
Sep  3 15:07:01 precious scsi.agent[30675]:      sd_mod: loaded successfully (for disk)
Sep  3 15:13:31 precious kernel: XFS mounting filesystem sda

<insert pause here>

Sep  3 15:14:01 precious kernel: scsi3 : destination target 0, lun 0
Sep  3 15:14:01 precious kernel:         command: cdb[0]=0x2a: 2a 00 04 c5 41 04 00 00 f8 00
Sep  3 15:14:01 precious kernel: Ending clean XFS mount for filesystem: sda1

at this point, I initiated a 
# dd if=/dev/zero of=testfile bs=1024 count=1024000

after a while, this starts happening:
Sep  3 15:20:10 precious kernel: ieee1394: sbp2: aborting sbp2 command
Sep  3 15:20:10 precious kernel: scsi3 : destination target 0, lun 0
Sep  3 15:20:10 precious kernel:         command: cdb[0]=0x2a: 2a 00 00 36 3f c7 00 00 f8 00
Sep  3 15:20:10 precious kernel: Filesystem "sda1": XFS internal error xfs_btree_check_sblock at line 352 of file fs/xfs/xfs_btree.c.  Caller 0xc01c64ee
Sep  3 15:20:10 precious kernel:  [xfs_btree_check_sblock+109/256] xfs_btree_check_sblock+0x6d/0x100
Sep  3 15:20:10 precious kernel:  [xfs_alloc_lookup+782/1120] xfs_alloc_lookup+0x30e/0x460
Sep  3 15:20:10 precious kernel:  [xfs_alloc_lookup+782/1120] xfs_alloc_lookup+0x30e/0x460
Sep  3 15:20:10 precious kernel:  [xfs_alloc_fixup_trees+452/1024] xfs_alloc_fixup_trees+0x1c4/0x400
Sep  3 15:20:10 precious kernel:  [xfs_btree_init_cursor+57/448] xfs_btree_init_cursor+0x39/0x1c0
Sep  3 15:20:10 precious kernel:  [xfs_alloc_ag_vextent_size+1066/1296] xfs_alloc_ag_vextent_size+0x42a/0x510
Sep  3 15:20:10 precious kernel:  [xfs_alloc_ag_vextent+264/272] xfs_alloc_ag_vextent+0x108/0x110
Sep  3 15:20:10 precious kernel:  [xfs_alloc_vextent+536/1200] xfs_alloc_vextent+0x218/0x4b0
Sep  3 15:20:10 precious kernel: ritepage+0x74/0x120
Sep  3 15:20:10 precious kernel:  [linvfs_writepage+0/288] linvfs_writepage+0x0/0x120
Sep  3 15:20:10 precious kernel:  [mpage_writepages+567/1072] mpage_writepages+0x237/0x430
Sep  3 15:20:10 precious kernel:  [linvfs_writepage+0/288] linvfs_writepage+0x0/0x120
Sep  3 15:20:10 precious kernel:  [do_writepages+55/64] do_writepages+0x37/0x40
Sep  3 15:20:10 precious kernel:  [__sync_single_inode+134/624] __sync_single_inode+0x86/0x270
Sep  3 15:20:10 precious kernel:  [__writeback_single_inode+63/336] __writeback_single_inode+0x3f/0x150
Sep  3 15:20:10 precious kernel:  [schedule_timeout+89/192] schedule_timeout+0x59/0xc0
Sep  3 15:20:10 precious kernel:  [sync_sb_inodes+479/736] sync_sb_inodes+0x1df/0x2e0
Sep  3 15:20:10 precious kernel:  [writeback_inodes+107/304] writeback_inodes+0x6b/0x130
Sep  3 15:20:10 precious kernel:  [background_writeout+152/224] background_writeout+0x98/0xe0
Sep  3 15:20:10 precious kernel:  [__pdflush+229/464] __pdflush+0xe5/0x1d0
Sep  3 15:20:10 precious kernel:  [pdflush+0/48] pdflush+0x0/0x30
Sep  3 15:20:10 precious kernel:  [pdflush+38/48] pdflush+0x26/0x30
Sep  3 15:20:10 precious kernel:  [background_writeout+0/224] background_writeout+0x0/0xe0
Sep  3 15:20:10 precious kernel:  [kthread+182/192] kthread+0xb6/0xc0
Sep  3 15:20:10 precious kernel:  [kthread+0/192] kthread+0x0/0xc0
Sep  3 15:20:10 precious kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

and so on and on

Sep  3 15:20:40 precious kernel: ieee1394: sbp2: aborting sbp2 command
Sep  3 15:20:40 precious kernel: scsi3 : destination target 0, lun 0
Sep  3 15:20:40 precious kernel:         command: cdb[0]=0x2a: 2a 00 00 36 49 77 00 00 f8 00
Sep  3 15:20:40 precious kernel: ieee1394: sbp2: aborting sbp2 command
Sep  3 15:20:40 precious kernel: scsi3 : destination target 0, lun 0
Sep  3 15:20:40 precious kernel:         command: cdb[0]=0x2a: 2a 00 00 36 4a 6f 00 00 f8 00
Sep  3 15:20:40 precious kernel: ieee1394: sbp2: aborting sbp2 command
Sep  3 15:20:40 precious kernel: scsi3 : destination target 0, lun 0
Sep  3 15:20:40 precious kernel:         command: cdb[0]=0x2a: 2a 00 00 36 4b 67 00 00 f8 00
Sep  3 15:20:40 precious kernel: ieee1394: sbp2: aborting sbp2 command
Sep  3 15:20:40 precious kernel: scsi3 : destination target 0, lun 0
Sep  3 15:20:40 precious kernel:         command: cdb[0]=0x2a: 2a 00 00 36 4c 5f 00 00 f8 00
Sep  3 15:20:40 precious kernel: ieee1394: sbp2: aborting sbp2 command
Sep  3 15:20:40 precious kernel: scsi3 : destination target 0, lun 0
Sep  3 15:20:40 precious kernel:         command: cdb[0]=0x2a: 2a 00 00 36 4d 57 00 00 f8 00
Sep  3 15:20:40 precious kernel: ieee1394: sbp2: aborting sbp2 command
Sep  3 15:20:40 precious kernel: scsi3 : destination target 0, lun 0
Sep  3 15:20:40 precious kernel:         command: cdb[0]=0x2a: 2a 00 00 36 4e 4f 00 00 f8 00
Sep  3 15:20:40 precious kernel: ieee1394: sbp2: aborting sbp2 command
Sep  3 15:20:40 precious kernel: scsi3 : destination target 0, lun 0
Sep  3 15:20:40 precious kernel:         command: cdb[0]=0x2a: 2a 00 00 36 4f 47 00 00 f8 00
Sep  3 15:20:40 precious kernel: ieee1394: sbp2: aborting sbp2 command

at which point i killed the dd and removed the device from the bus.

Using the sbp2 module with serialize_io=1 fixes the problem, but it's also quite slow.

Is there anything else I can try? I'd love to have the full 400mb to my disposal...

Thanks in advance,

Jan

-- 

Death has been proven to be 99% fatal in laboratory rats.
