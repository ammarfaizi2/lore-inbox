Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWFSB7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWFSB7t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWFSB7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:59:49 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:3589 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S1750755AbWFSB7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:59:49 -0400
Date: Mon, 19 Jun 2006 12:00:40 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: dm-devel@redhat.com
Subject: 2.6.16.20/dm: can't create more then one snapshot of an lv
Message-ID: <20060619020040.GX2059@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to create multiple snapshots of an lv ontop of a raid-5
software raid device and ext3+dir_index and resize_inode for the fs.
The kernel is a pure 64bit compile with Debian Sarge amd64 running on
top of it. The kernel is monolithic and I'm using lvm2 2.01.03-5 with
devmapper 1.01.

This works under 2.6.15.7. Under 2.6.16.20 I get this:

# lvcreate --snapshot --size 50G --name snap-12 --permission r --verbose /dev/backups/main
    Setting chunksize to 16 sectors.
    Finding volume group "backups"
    Creating logical volume snap-12
    Archiving volume group "backups" metadata.
    Creating volume group backup "/etc/lvm/backup/backups"
    Found volume group "backups"
    Loading backups-snap--12
    Zeroing start of logical volume "snap-12"
    Found volume group "backups"
    Removing backups-snap--12
    Found volume group "backups"
    Found volume group "backups"
    Found volume group "backups"
    Loading backups-main-real
    Loading backups-snap--12-cow
    Loading backups-snap--12
    Loading backups-main
    Creating volume group backup "/etc/lvm/backup/backups"
  Logical volume "snap-12" created
# lvcreate --snapshot --size 50G --name snap-13 --permission r --verbose /dev/backups/main
    Setting chunksize to 16 sectors.
    Finding volume group "backups"
    Creating logical volume snap-13
    Archiving volume group "backups" metadata.
    Creating volume group backup "/etc/lvm/backup/backups"
    Found volume group "backups"
    Loading backups-snap--13
    Zeroing start of logical volume "snap-13"
    Found volume group "backups"
    Removing backups-snap--13
    Found volume group "backups"
    Found volume group "backups"
    Found volume group "backups"
    Loading backups-main-real
    Loading backups-snap--12-cow
    Loading backups-snap--12
*freeze*

# ps auxww | grep lvcreate
root      1315  0.0  1.2 16000 13104 pts/2   D<L+ 11:44   0:00 lvcreate --snapshot --size 50G --name snap-13 --permission r --verbose /dev/backups/main

Nothing special in dmesg at time of lvcreate.

# lsof -n | grep 1315 | less
lvcreate  1315        root  cwd       DIR                9,0    1024       4017 /root
lvcreate  1315        root  rtd       DIR                9,0    1024          2 /
lvcreate  1315        root  txt       REG                9,0  465896     116659 /lib/lvm-200/lvm
lvcreate  1315        root  mem       REG                0,0                  0 [heap] (stat: No such file or directory)
lvcreate  1315        root  mem       REG                9,0   90288     116481 /lib/ld-2.3.2.so
lvcreate  1315        root  mem       REG                9,1  290512     458029 /usr/lib/locale/locale-archive
lvcreate  1315        root  mem       REG                9,0   34640     116657 /lib/libdevmapper.so.1.01
lvcreate  1315        root  mem       REG                9,0   12072     116489 /lib/libdl-2.3.2.so
lvcreate  1315        root  mem       REG                9,0 1295328     116487 /lib/libc-2.3.2.so
lvcreate  1315        root    0u      CHR              136,2                  4 /dev/pts/2
lvcreate  1315        root    1u      CHR              136,2                  4 /dev/pts/2
lvcreate  1315        root    2u      CHR              136,2                  4 /dev/pts/2
lvcreate  1315        root    3u      CHR              10,63              44265 /dev/mapper/control
lvcreate  1315        root    4uW     REG              253,2       0     147459 /var/lock/lvm/V_backups
lvcreate  1315        root    5u      BLK                9,0              33555 /dev/md0
lvcreate  1315        root    6u      BLK                9,1              33567 /dev/md1
lvcreate  1315        root    7u      BLK                9,2              33568 /dev/md2
lvcreate  1315        root    8u      BLK                9,3              33569 /dev/md3

MD section of .config:

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
CONFIG_MD_RAID1=y
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID5=y
# CONFIG_MD_RAID6 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_MIRROR=y
CONFIG_DM_ZERO=y
# CONFIG_DM_MULTIPATH is not set

This server is not live yet so I can test patches if need be. I wont be 
able to in approx 1 weeks time though.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
