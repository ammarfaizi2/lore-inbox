Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVAYMcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVAYMcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 07:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVAYMcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 07:32:32 -0500
Received: from [62.216.183.222] ([62.216.183.222]:14214 "EHLO
	ehrenwerter.altkoenig.net") by vger.kernel.org with ESMTP
	id S261917AbVAYMcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 07:32:24 -0500
Subject: XFS+dm-cypt+raid5 - big data loss
From: Tillmann Steinbrecher <webmaster@heatsink-guide.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: The Heatsink Guide
Date: Tue, 25 Jan 2005 13:32:13 +0100
Message-Id: <1106656333.5032.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: webmaster@heatsink-guide.com
X-SA-Exim-Scanned: No (on ehrenwerter.altkoenig.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use a combination of software RAID5, dm-crypt, and XFS as a
filesystem. The filesystem is exported via nfs and samba (both
read-only). Yesterday I lost a large amount of data (420GB). It is
unclear to me what actually caused the problem; there was no crash or
anything. The system is using reliable hardware that never caused
problems in the past.

When I came home from work in the evening, I couldn't access my RAID5
partition - i/o errors. Looking in /var/log/messages, I found out that
at 15:11, XFS suddenly started acting up, with no apparent reason - no
crash, power failure, read error from HD, nothing!

Jan 24 14:16:55 localhost -- MARK --
Jan 24 14:36:55 localhost -- MARK --
Jan 24 14:56:55 localhost -- MARK --
Jan 24 15:06:45 localhost kernel: smb_proc_readdir_long: error=-2,
breaking
Jan 24 15:07:19 localhost kernel: smb_proc_readdir_long: error=-5,
breaking
Jan 24 15:08:38 localhost kernel: smb_proc_readdir_long: error=-2,
breaking
Jan 24 15:11:29 localhost kernel:  [xfs_da_do_buf+905/2160]
xfs_da_do_buf+0x389/0x870
Jan 24 15:11:29 localhost kernel:  [xfs_da_read_buf+88/96]
xfs_da_read_buf+0x58/0x60
Jan 24 15:11:29 localhost kernel:  [xfs_da_read_buf+88/96]
xfs_da_read_buf+0x58/0x60
Jan 24 15:11:29 localhost kernel:  [pagebuf_iostart+120/192]
pagebuf_iostart+0x78/0xc0
Jan 24 15:11:29 localhost kernel:  [kfree_skbmem+36/48] kfree_skbmem
+0x24/0x30
Jan 24 15:11:29 localhost kernel:  [xfs_da_read_buf+88/96]
xfs_da_read_buf+0x58/0x60
Jan 24 15:11:29 localhost kernel:  [xfs_dir2_block_lookup_int+82/416]
xfs_dir2_block_lookup_int+0x52/0x1a0
Jan 24 15:11:29 localhost kernel:  [xfs_dir2_block_lookup_int+82/416]
xfs_dir2_block_lookup_int+0x52/0x1a0
Jan 24 15:11:29 localhost kernel:  [sk_reset_timer+31/48] sk_reset_timer
+0x1f/0x30
Jan 24 15:11:29 localhost kernel:  [xfs_bmap_last_offset+197/304]
xfs_bmap_last_offset+0xc5/0x130
Jan 24 15:11:29 localhost kernel:  [xfs_dir2_block_lookup+47/208]
xfs_dir2_block_lookup+0x2f/0xd0
Jan 24 15:11:29 localhost kernel:  [xfs_dir2_lookup+183/352]
xfs_dir2_lookup+0xb7/0x160
Jan 24 15:11:29 localhost kernel:  [copy_to_user+62/80] copy_to_user
+0x3e/0x50

etc etc - there's countless pages like that in the logs.

I rebooted; and I could mount the partition again (XFS did recovery on
mount). The data appeared to be intact (at least what I looked at).
However, I'd still see countless XFS error messages output to the
console. So I unmounted, and ran xfs_check. Output from xfs_check was
over 200MB, including the following messages:

bad magic number 0x2b3c for inode 68753536
bad agi magic # 0x9512d08b in ag 3
bad agi version # 0x2edcb5f7 in ag 3
can't seek in filesystem at bb 16183039256
can't read btree block 3/2000906443
agi_count 1975555954, counted 0 in ag 3
agi_freecount 2021644599, counted 0 in ag 3
agi unlinked bucket 0 is 1009384619 in ag 3 (inode=1009384619)
bad directory data magic # 0x4ffc0558 for dir ino 1026624136 block 0
no . entry for directory 1026624136
no .. entry for directory 1026624136

I also ran xfs_check with -s option; output is small, see end of this
mail.

Ok, so I ran xfs_repair to fix this... BAD IDEA. xfs_repair also
complained about many problems, and finally did this:

empty data block 4180 in directory inode 1663015222: junking block
bad hash table for directory inode 1663015222 (no leaf entry):
rebuilding
rebuilding directory inode 1663015222

At this point, it started using more and more memory, until main memory
(768MB) and swap (2GB) were exhausted, and xfs_check was killed by the
out-of-memory-killer, leaving behind a damaged filesystem with illegal
directory names - 420GB lost, thank you. 

I'm not sure what caused the original problem, it may be xfs, dm-crypt,
or raid; however the behavior of xfs_check is quite a desaster. I also
knew that xfs' behavior was problematic in case of power failure during
operation, but this was not what happened here. The filesystem just
corrupted itself without a reason.

Of course I have a complete backup on DVD-R/CD, but it will take days to
restore. I've now switched to reiser4 on this large data partition - at
least they ADMIT it's experimental (sorry for sounding a bit trollish in
the last sentence, but I'm VERY VERY annoyed).

Please email replies to me, I'm not subscribed. If anybody would like to
see more logs to investigate, please email me.

bye,
Till

Output of xfs_check -s :
can't seek in filesystem at bb 16183039256
bad magic number 0x880a for inode 750785168
bad magic number 0x9452 for inode 750785169
bad magic number 0xdb92 for inode 750785170
bad magic number 0x2749 for inode 750785171
bad magic number 0x5200 for inode 750785172
bad magic number 0x37fa for inode 750785173
bad magic number 0x10 for inode 750785174
bad magic number 0xd801 for inode 750785175
bad magic number 0x8aec for inode 750785176
bad magic number 0xd047 for inode 750785177
bad magic number 0x7142 for inode 750785178
bad magic number 0x76a for inode 750785179
bad magic number 0xcab8 for inode 750785180
bad magic number 0x4c91 for inode 750785181
bad magic number 0x441a for inode 750785182
bad magic number 0xb553 for inode 750785183
