Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317975AbSHDQGD>; Sun, 4 Aug 2002 12:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSHDQGD>; Sun, 4 Aug 2002 12:06:03 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:16904 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S317975AbSHDQGB>; Sun, 4 Aug 2002 12:06:01 -0400
Date: Sun, 4 Aug 2002 18:09:34 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: reiserfs blocks long on getdents64() during concurrent write
Message-ID: <Pine.LNX.4.44.0208041506480.31879-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel hackers!

Yesterday, Linus kindly directed me towards the filesystem implementation 
concerning this, so I produced some diagnostics in that direction. The 
task is to write a big file with dd to a hardware RAID on a dual Athlon MP 
machine, while in the meantime checking the progress with ls -l. Here's 
the relevant part of 'strace -T ls -l' (it is not always so slow)

open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3 <0.000013>
fstat64(3, {st_mode=S_IFDIR|0755, st_size=160, ...}) = 0 <0.000007>
fcntl64(0x3, 0x2, 0x1, 0x3)             = 0 <0.000011>
brk(0x805b000)                          = 0x805b000 <0.000008>
getdents64(0x3, 0x8058ac8, 0x1000, 0x8058ac8) = 176 <4.726011>
lstat64("bigfile_2", {st_mode=S_IFREG|0644, st_size=2147483648, ...}) = 0 <0.000023>
lstat64("bigfile_3", {st_mode=S_IFREG|0644, st_size=726581248, ...}) = 0 <0.000012>
lstat64("writer", {st_mode=S_IFREG|0755, st_size=58, ...}) = 0 <0.000012>
lstat64("bigfile_", {st_mode=S_IFREG|0644, st_size=2147483648, ...}) = 0 <0.000012>
getdents64(0x3, 0x8058ac8, 0x1000, 0x8058ac8) = 0 <0.000033>
close(3)                                = 0 <0.000013>

The first call to getdents64 takes 4.7s! I captured the task status and 
got this:

writer        S 00000018  4732  1652      1  1653          1242 (NOTLB)
Call Trace:    [sys_wait4+952/1008] [system_call+51/56]
dd            D 0000001A     0  1653   1652                     (NOTLB)
Call Trace:    [sleep_on+74/112]
        [do_journal_begin_r+87/544]
        [unmap_underlying_metadata+26/96]
        [__block_prepare_write+231/752]
        [call_reschedule_interrupt+5/11]
        [journal_begin+19/32]
        [reiserfs_commit_write+136/336]
        [block_prepare_write+29/64]
        [generic_file_write+1256/1776]
        [sys_write+149/272]
        [do_IRQ+197/240]
        [system_call+51/56]
ls            D 080541A4  5084  1659   1562                     (NOTLB)
Call Trace:    [sleep_on+74/112]
        [do_journal_begin_r+87/544]
        [search_by_key+2338/3552]
        [journal_begin+19/32]
        [reiserfs_dirty_inode+88/160]
        [__mark_inode_dirty+46/160]
        [update_atime+81/96]
        [reiserfs_readdir+1112/1136]
        [filemap_nopage+233/528]
        [rb_insert_color+112/240]
        [vfs_readdir+124/192]
        [filldir64+0/320]
        [sys_getdents64+79/186]
        [filldir64+0/320]
        [system_call+51/56]

writer is a shell script calling dd with a blocksize of 1M. The problem of 
course vanishes when using noatime, but it still makes me wonder why a 
single write request is delayed so long. The other possibility to avoid 
this is to use a sync mount, and there I discovered something really 
strange: 2.4.19 gives me about 17MB/s while 2.4.18-3 (RedHat) was creeping 
slow with 10kB/s!

If you have any thoughts on the cause of this behaviour and/or on how to 
fix it, I would be glad to hear them. If it's not too complicated I could 
even code something up myself, and I for sure can do any testing needed.

Thanks in advance,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

