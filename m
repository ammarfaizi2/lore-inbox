Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWBUPaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWBUPaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWBUPaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:30:20 -0500
Received: from cust.92.104.adsl.cistron.nl ([195.64.92.104]:62355 "EHLO
	router.forgottenland.net") by vger.kernel.org with ESMTP
	id S932526AbWBUPaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:30:19 -0500
Message-ID: <43FB3208.7020303@vanalteren.nl>
Date: Tue, 21 Feb 2006 16:30:16 +0100
From: Ramon van Alteren <ramon@vanalteren.nl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051217)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: ramon@vanalteren.nl, ramon@hyves.nl
Subject: Writing to an NFS share truncates files on >8Tb Raid + LVM2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'd like to report a situation which looks like a bug in the kernelbased
nfs server implementation.

I've recently build a 9Tb NAS for our serverpark out of 24 SATA disks
& 2 3ware 9550SX controllers. The storage is exported using nfs version
3 to our servers. Writing onto the local filesystem on the NAS works
fine, copying over the network with scp/nc etc. works fine as well.

However writing to a mounted nfs-share at a different machine
truncates files at random sizes which appear to be multiples of 16K.
I can reproduce the same behaviour with a nfs-share mounted via the
loopback interface.

Following is output from a test-case:

On the server in /etc/exports:
/data/tools     10.10.0.0/24(rw,async,no_root_squash) 127.0.0.1/8
(rw,async,no_root_squash)

Kernelsymbols:
Linux spinvis 2.6.14.2 #1 SMP Wed Feb 8 23:58:06 CET 2006 i686 Intel
(R) Xeon(TM) CPU 2.80GHz GenuineIntel GNU/Linux

Similar behaviour is observed with gentoo-sources-2.6.14-r5, same
options.

gzcat /proc/config.gz | grep NFS

CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y


#root@cl36 ~ 20:29:44 > mount
<partly snipped>
10.10.0.80:/data/tools on /root/tools type nfs
(rw,intr,lock,tcp,nfsvers=3,addr=10.10.0.80)
#root@cl36 ~ 20:29:56 > for i in `seq 1 30`; do dd count=1000 if=/dev/
zero of=/root/tools/test.tst; ls -la /root/tools/test.tst ; rm /root/
tools/test.tst ; done
1000+0 records in
1000+0 records out
dd: closing output file `/root/tools/test.tst': No space left on device
-rw-r--r--  1 root root 163840 Feb  8 20:30 /root/tools/test.tst
1000+0 records in
1000+0 records out
dd: closing output file `/root/tools/test.tst': No space left on device
-rw-r--r--  1 root root 98304 Feb  8 20:30 /root/tools/test.tst
1000+0 records in
1000+0 records out
dd: closing output file `/root/tools/test.tst': No space left on device
-rw-r--r--  1 root root 98304 Feb  8 20:30 /root/tools/test.tst
1000+0 records in
1000+0 records out
dd: closing output file `/root/tools/test.tst': No space left on device
-rw-r--r--  1 root root 131072 Feb  8 20:30 /root/tools/test.tst
1000+0 records in
1000+0 records out
dd: closing output file `/root/tools/test.tst': No space left on device
-rw-r--r--  1 root root 163840 Feb  8 20:30 /root/tools/test.tst
<similar thus sniped>

I've so far found this:
http://lwn.net/Articles/150580/

Which seems to indicate that RAID + LVM + complex storage and
4KSTACKS can cause problems. However I can't find the 4KSTACK symbol
anywhere in my config. Can't find the 8KSTACK symbol anywhere either :-(

For those wondering.... no it's not out of space:

10.10.0.80:/data/tools                      9.0T  204G  8.9T   3% /
root/tools

There's nothing in syslog in either case (loopback mount or remote
machine mount or server)

We're using reiserfsv3. It's a raid-50 machine based on two raid-50
arrays of 4,55 Tb handled  by the hardware controller.

The two raid-50 arrays are "glued" together using LVM2:

--- Volume group ---
   VG Name               data-vg
   System ID
   Format                lvm2
   Metadata Areas        2
   Metadata Sequence No  2
   VG Access             read/write
   VG Status             resizable
   MAX LV                0
   Cur LV                1
   Open LV               1
   Max PV                0
   Cur PV                2
   Act PV                2
   VG Size               9.09 TB
   PE Size               4.00 MB
   Total PE              2384134
   Alloc PE / Size       2359296 / 9.00 TB
   Free  PE / Size       24838 / 97.02 GB
   VG UUID               dyDpX4-mnT5-hFS9-DX7P-jz63-KNli-iqNFTH

--- Physical volume ---
   PV Name               /dev/sda1
   VG Name               data-vg
   PV Size               4.55 TB / not usable 0
   Allocatable           yes (but full)
   PE Size (KByte)       4096
   Total PE              1192067
   Free PE               0
   Allocated PE          1192067
   PV UUID               rfOtx3-EIRR-iUx7-uCSl-h9kE-Sfgu-EJCHLR

   --- Physical volume ---
   PV Name               /dev/sdb1
   VG Name               data-vg
   PV Size               4.55 TB / not usable 0
   Allocatable           yes
   PE Size (KByte)       4096
   Total PE              1192067
   Free PE               24838
   Allocated PE          1167229
   PV UUID               5U0F3v-ZUag-pRcA-FHvo-OJeD-1q9g-IthGQg

--- Logical volume ---
   LV Name                /dev/data-vg/data-lv
   VG Name                data-vg
   LV UUID                0UUEX8-snHA-dYc8-0qLL-OSXP-kjoa-UyXtdI
   LV Write Access        read/write
   LV Status              available
   # open                 2
   LV Size                9.00 TB
   Current LE             2359296
   Segments               2
   Allocation             inherit
   Read ahead sectors     0
   Block device           253:3

Based on responses from a different mailinglist and google I tried unfsd
  the userspace nfsd implementation which appears to work fine (still
testing) The above test-case works for both loopback and remote mounted 
filesystems.

I have a small time-window to do any auxillary testing with the
kernel-based implementation because I need this thing in production as
we're running out of storage fast.

If there's any more info you need, please let me know.
I'm not on the list so please CC me.

Regards,

Ramon
--
If to err is human, I'm most certainly human.


