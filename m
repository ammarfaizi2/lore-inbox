Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbVIVT7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbVIVT7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVIVT7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:59:23 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5770 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030297AbVIVT7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:59:21 -0400
Message-Id: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc2-mm1 - ext3 wedging up
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127419158_2709P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 15:59:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127419158_2709P
Content-Type: text/plain; charset=us-ascii

Am seeing reproducible wedging up when writing large (20M+) files to an ext3
file system.  Oddly enough, if something *else* writes files to the file system
as well, it will unwedge for a while and make progress.  Also, a 'sync' command
will relieve things temporarily - but after a few megabytes it comes to a halt
again.  Looks like a borkage someplace not causing it to actually finish
pushing dirty file pages out - gkrellm reports little/no disk activity in
progress. File activity on *other* filesystems continues unimpeded.

A representative sample sysrq-t output (doing an rpm2cpio | cpio -ivdm on the
FC4 kernel.src.rpm, lsof reports the file being extracted was
linux-2.6.13.tar.bz2).  

[17187066.172000] cpio          D C3A2EC8C  1928  9299   9144                9298 (NOTLB)
[17187066.172000] c3a2eca4 00000000 c011d897 c3a2ec8c cab666a0 cab66560 a830ef00 003d0f8b 
[17187066.172000]        365c0400 00000000 00000282 c3a2ecac 001b7450 c3a2ece0 c3a2ecd0 c036e5bf 
[17187066.172000]        cb4c1f64 c04f43a8 001b7450 4b87ad6e c011e35a cab66560 c04f4120 00000019 
[17187066.172000] Call Trace:
[17187066.172000]  [<c036e5bf>] schedule_timeout+0x72/0x90
[17187066.172000]  [<c036e532>] io_schedule_timeout+0xe/0x16
[17187066.172000]  [<c02627bd>] blk_congestion_wait+0x53/0x68
[17187066.172000]  [<c0139ec8>] balance_dirty_pages+0xe8/0x142
[17187066.172000]  [<c0139fcf>] task_balance_dirty_pages+0xad/0xb6
[17187066.172000]  [<c0139fe4>] balance_dirty_pages_ratelimited+0xc/0x92
[17187066.172000]  [<c0136b2b>] generic_file_buffered_write+0x427/0x50f
[17187066.172000]  [<c0136fb0>] __generic_file_aio_write_nolock+0x39d/0x3da
[17187066.172000]  [<c01371e7>] generic_file_aio_write+0x62/0xb0
[17187066.172000]  [<c01895ad>] ext3_file_write+0x1a/0x88
[17187066.172000]  [<c014e9fc>] do_sync_write+0xb1/0xe6
[17187066.172000]  [<c014eade>] vfs_write+0xad/0x156
[17187066.172000]  [<c014ec22>] sys_write+0x3b/0x60
[17187066.172000]  [<c01026b1>] syscall_call+0x7/0xb

/proc/meminfo says:
MemTotal:       255140 kB
MemFree:         11048 kB
Buffers:         17084 kB
Cached:          43020 kB
SwapCached:      23244 kB
Active:         200156 kB
Inactive:        16128 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255140 kB
LowFree:         11048 kB
SwapTotal:     1052216 kB
SwapFree:       940176 kB
Dirty:              60 kB
Writeback:           4 kB
Mapped:         185012 kB
Slab:            19288 kB
CommitLimit:   1179784 kB
Committed_AS:   415788 kB
PageTables:       1368 kB
VmallocTotal:   777940 kB
VmallocUsed:     28268 kB
VmallocChunk:   747728 kB

Here I kept entering 'sync' in another window - each time, I'd see an immediate
read/write flurry on gkrellm for 1-3 seconds, and then nothing until the next
sync - then it would start moving again.

[~]2 l /usr/src/valdis/kern/linux-2.6.13.tar.bz2 
1244 -rw-------  1 valdis valdis 1263104 Sep 22 15:48 /usr/src/valdis/kern/linux-2.6.13.tar.bz2
[~]2 sync
[~]2 l /usr/src/valdis/kern/linux-2.6.13.tar.bz2 
7920 -rw-------  1 valdis valdis 8092672 Sep 22 15:51 /usr/src/valdis/kern/linux-2.6.13.tar.bz2
[~]2 sync
[~]2 l /usr/src/valdis/kern/linux-2.6.13.tar.bz2 
9464 -rw-------  1 valdis valdis 9669120 Sep 22 15:52 /usr/src/valdis/kern/linux-2.6.13.tar.bz2
[~]2 sync
[~]2 l /usr/src/valdis/kern/linux-2.6.13.tar.bz2 
11516 -rw-------  1 valdis valdis 11770880 Sep 22 15:52 /usr/src/valdis/kern/linux-2.6.13.tar.bz2


--==_Exmh_1127419158_2709P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDMw0WcC3lWbTT17ARArxHAKCbzZm1qDHdSbNM5rysANaHO1kotwCgi4l6
60CefDJxLgp5ooPPOZ5q6Ns=
=sslB
-----END PGP SIGNATURE-----

--==_Exmh_1127419158_2709P--
