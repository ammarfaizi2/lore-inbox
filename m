Return-Path: <linux-kernel-owner+w=401wt.eu-S932446AbXAIVFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbXAIVFK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbXAIVFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:05:09 -0500
Received: from mail.parknet.jp ([210.171.160.80]:4268 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932447AbXAIVFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:05:08 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Fix the reproducible oops in scsi
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 10 Jan 2007 06:04:59 +0900
Message-ID: <878xgbhpxg.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the oops after some hotplug events. And the similar oops can
reproduce by the following step.

   plug usb-storage (e.g. scsi_host of usb is "host5", and device is sde)
   # mount /dev/sde1 /mnt
   # echo 1 > /sys/block/sde/device/delete
   # echo - - - > /sys/class/scsi_host/host5/scan
   # echo - - - > /sys/class/scsi_host/host5/scan
   # echo - - - > /sys/class/scsi_host/host5/scan
   unplug usb-storage
   # umount /mnt

general protection fault: 0000 [1] SMP 
CPU 1 
Modules linked in: nls_iso8859_1 nls_cp437 vfat fat nls_base nfsd exportfs p4_clockmod speedstep_lib cpufreq_ondemand freq_table thermal fan button processor ac battery autofs4 ipv6 nfs lockd nfs_acl sunrpc deflate zlib_deflate zlib_inflate twofish twofish_common serpent blowfish des cbc ecb blkcipher aes xcbc sha256 sha1 crypto_null hmac crypto_hash cryptomgr af_key binfmt_misc dm_snapshot dm_mirror dm_mod eth1394 usb_storage snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer r8169 snd i2c_i801 bitrev crc32 ehci_hcd uhci_hcd intel_agp ohci1394 ieee1394 rng_core usbcore soundcore snd_page_alloc i2c_core parport_pc parport evdev sg sr_mod cdrom floppy
Pid: 3780, comm: umount Not tainted 2.6.20-rc4 #1
RIP: 0010:[<ffffffff801af74b>]  [<ffffffff801af74b>] sysfs_remove_file+0x8/0x12
RSP: 0018:ffff810059703b58  EFLAGS: 00010286
RAX: ffff8100596bba50 RBX: ffff8100596bba50 RCX: ffff810059703b68
RDX: ffff810059703b48 RSI: 6b6b6b6b6b6b6b6b RDI: 6b6b6b6b6b6b6b6b
RBP: ffff810059703b58 R08: ffff8100596bbac8 R09: 0000000000000000
R10: ffff8100596bba28 R11: 0000000000000400 R12: 6b6b6b6b6b6b6b6b
R13: ffff81005e303650 R14: ffff81005e9cf1b8 R15: ffff8100596bba50
FS:  00002af1e22111d0(0000) GS:ffff81005f7a9898(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fff3c0145e8 CR3: 0000000059600000 CR4: 00000000000006e0
Process umount (pid: 3780, threadinfo ffff810059702000, task ffff81005f3997f0)
Stack:  ffff810059703b78 ffffffff8023a07a ffff8100596bba50 ffff8100596bba50
 ffff810059703ba8 ffffffff8023a110 ffff81005e303478 ffff8100596bba50
 ffff8100596bba28 ffff81005e303478 ffff810059703bd8 ffffffff80249049
Call Trace:
 [<ffffffff8023a07a>] device_remove_file+0x26/0x33
 [<ffffffff8023a110>] device_del+0x3a/0x1d1
 [<ffffffff80249049>] scsi_target_reap_usercontext+0x54/0xbb
 [<ffffffff80137f4e>] execute_in_process_context+0x27/0x56
 [<ffffffff80247fdc>] scsi_target_reap+0x98/0xac
 [<ffffffff80249290>] scsi_device_dev_release_usercontext+0xab/0xd8
 [<ffffffff80137f4e>] execute_in_process_context+0x27/0x56
 [<ffffffff802491e3>] scsi_device_dev_release+0x17/0x19
 [<ffffffff80239d9f>] device_release+0x31/0x70
 [<ffffffff801e411d>] kobject_cleanup+0x53/0x77
 [<ffffffff801e4141>] kobject_release+0x0/0xf
 [<ffffffff801e414e>] kobject_release+0xd/0xf
 [<ffffffff801e4f3f>] kref_put+0x63/0x6d
 [<ffffffff801e40c8>] kobject_put+0x19/0x1b
 [<ffffffff80239ec2>] put_device+0x15/0x17
 [<ffffffff80240610>] scsi_device_put+0x3d/0x42
 [<ffffffff8024b821>] scsi_disk_put+0x2e/0x3f
 [<ffffffff8024c21e>] sd_release+0x7b/0x82
 [<ffffffff8019243a>] __blkdev_put+0x7c/0x15e
 [<ffffffff801924e9>] __blkdev_put+0x12b/0x15e
 [<ffffffff80192527>] blkdev_put+0xb/0xd
 [<ffffffff80192542>] close_bdev_excl+0x19/0x1e
 [<ffffffff80170e3b>] kill_block_super+0x36/0x3b
 [<ffffffff80170f16>] deactivate_super+0x6f/0x84
 [<ffffffff801838f8>] mntput_no_expire+0x56/0x87
 [<ffffffff80175c02>] path_release_on_umount+0x1d/0x21
 [<ffffffff8018412c>] sys_umount+0x21f/0x254
 [<ffffffff80172361>] sys_newstat+0x22/0x3c
 [<ffffffff80109c2e>] system_call+0x7e/0x83


By "echo 1 > /sys/block/sde/device/delete", sdev->sdev_state became SDEV_DEL.

The problem is in,
    scsi_probe_and_add_lun()
        -> scsi_device_lookup_by_target()
	    -> __scsi_device_lookup_by_target()

by "echo - - - > /sys/class/scsi_host/host5/scan".

The first scan is still not problem. Since founded existence device is
already SDEV_DEL, it just adds a new device.

The problem is second re-scan, it is looking a existence device up. In
this case it is SDEV_DEL device, not newly added device by first scan.

This patch fixes the oops by excluding the SDEV_DEL devices in
__scsi_device_lookup_by_target().

What do you think of this?

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 drivers/scsi/scsi.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN drivers/scsi/scsi.c~scsi_device_lookup-fix drivers/scsi/scsi.c
--- linux-2.6/drivers/scsi/scsi.c~scsi_device_lookup-fix	2007-01-10 05:19:03.000000000 +0900
+++ linux-2.6-hirofumi/drivers/scsi/scsi.c	2007-01-10 05:19:22.000000000 +0900
@@ -959,6 +959,8 @@ struct scsi_device *__scsi_device_lookup
 	struct scsi_device *sdev;
 
 	list_for_each_entry(sdev, &starget->devices, same_target_siblings) {
+		if (sdev->sdev_state == SDEV_DEL)
+			continue;
 		if (sdev->lun ==lun)
 			return sdev;
 	}
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
