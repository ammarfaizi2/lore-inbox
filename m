Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTE2Mgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 08:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTE2Mgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 08:36:42 -0400
Received: from penguin.theopalgroup.com ([206.24.109.10]:14555 "EHLO
	penguin.theopalgroup.com") by vger.kernel.org with ESMTP
	id S262193AbTE2Mgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 08:36:39 -0400
Date: Thu, 29 May 2003 08:49:53 -0400 (EDT)
From: Kevin Jacobs <jacobs@penguin.theopalgroup.com>
To: akpm@digeo.com, <linux-kernel@vger.kernel.org>
Subject: Ext3 meta-data performance
Message-ID: <Pine.LNX.4.44.0305290819370.11990-100000@penguin.theopalgroup.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently upgraded our company rsync/backup server and have been running
into performance slowdowns.  The old system was a dual processor Pentium III
(Coppermine) 866MHz running Redhat 7.3 with IDE disks (ext2 filesystems). 
We have since upgraded it to Redhat 9, added a 3Ware 7500-8 RAID controller
and more disks (w/ ext3 filesystems + external journal).

The primary use for this system is to provide live rsync snapshots of
several of our primary servers.  For each system we maintain a "current"
snapshot, from which a hard-linked image is taken after each rsync update.
i.e., we rsync and then 'cp -Rl current snapshot-$DATE'.  After the update
to Redhat 9, the rsync itself was faster, but the time to make the
hard-links became an order of magnitude slower (~4min -> ~50min for a tree
with 500,000 files).  Not only was it slower, but it destroyed system
interactivity for minutes at a time.

Since these rsync backups are done in addition to traditional daily tape
backups, we've taken the system out of production use and opened the door
for experimentation.  So, the next logical step was to try a 2.5 kernel. 
After some work, I've gotten 2.5.70-mm2 booting and it is _much_ better than
the Redhat 2.4 kernels, and the system interactivity is flawless.  However,
the speed of creating hard-links is still three and a half times slower than
with the old 2.2 kernel.  It now takes ~14 minutes to create the links, and
from what I can tell, the bottlenecks is not the CPU or the disk-throughput. 
I was wondering if you could suggest any ways to tweak, tune, or otherwise
get this heap moving a little faster.

Here is some details output of system activity that may help:

'vmstat 1' output (taken from near start of cp -Rl):
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  0  0      0   5680 267472  13436    0    0   316   510  925   207  1  5 94
 1  0  1      0   6512 266992  13236    0    0   536    92 1140   290  0 14 86
 1  0  0      0   5744 267776  13132    0    0   396     0 1119   233  1 13 86
 0  1  0      0   7024 266784  13240    0    0   376   124 1119   241  1 17 82
 0  1  0      0   5424 267768  13276    0    0   492     0 1130   267  1  8 91
 0  1  0      0   5680 267896  13216    0    0   508  5120 1181   355  1 13 86
 0  1  0      0   4200 269120  13216    0    0   596    88 1243   698  7 13 80
 0  1  0      0   5992 268160  13156    0    0   496    28 1136   327  1  8 91
 0  1  0      0   4072 269184  13152    0    0   516     0 1134   272  1 16 83
 1  0  0      0   4840 268056  13260    0    0   408     8 1107   225  2 24 75
 0  1  0      0   6248 267036  13056    0    0   328  5812 1162   271  1  6 93
 0  1  0      0   5168 268236  13080    0    0   596    12 1157   322  1 10 89
 0  1  1      0   5872 267576  13060    0    0   584     8 1154   325  0  6 94
 0  1  0      0   5040 268552  13104    0    0   488     0 1132   289  1  7 92
 0  1  1      0   5872 267980  12724    0    0   508    20 1133   283  1 11 88
 0  1  0      0   4912 268976  12748    0    0   456  4928 1165   329  1 10 89
 0  1  1      0   5104 269328  12260    0    0   540     4 1140   303  1 11 88
 0  1  0      0   4080 270320  12220    0    0   496     0 1131   293  1 11 88
 0  1  0      0   4912 269844  11812    0    0   540    12 1146   323  1  9 90
 1  0  0      0   5744 269196  11712    0    0   612     0 1159   327  1 10 89
 0  1  0      0   4656 270256  11740    0    0   476  5976 1261   733  6 11 83
 0  1  0      0   5616 269424  11552    0    0   460    12 1124   282  1  8 91
 0  1  0      0   4528 270472  11524    0    0   524     0 1137   280  1  7 92
 0  1  0      0   5552 269500  11544    0    0   496     8 1134   295  0  7 93
 0  1  0      0   4592 270412  11584    0    0   452     0 1118   243  1 11 88
 0  1  1      0   5100 270000  11384    0    0   212  5804 1167   192  0 11 89
[...]

Oprofile output (from whole cp -Rl):
vma      samples  %           symbol name             image
c0108bb0 113811   25.8026     default_idle            /.../vmlinux
c016cb20 42919    9.73037     __d_lookup              /.../vmlinux
c016e260 24583    5.57333     find_inode_fast         /.../vmlinux
c0115c90 24269    5.50214     mark_offset_tsc         /.../vmlinux
c0193bf0 21395    4.85056     ext3_find_entry         /.../vmlinux
c01948a0 17107    3.87841     add_dirent_to_buf       /.../vmlinux
c0162390 12258    2.77907     link_path_walk          /.../vmlinux
42069670 11587    2.62694     getc                    /.../vmlinux
c018ccb0 10766    2.44081     ext3_check_dir_entry    /.../vmlinux
c01116e0 6523     1.47886     timer_interrupt         /.../vmlinux
00000000 5497     1.24625     (no symbol)             /bin/cp
c01bb420 5202     1.17937     atomic_dec_and_lock     /.../vmlinux
c0156830 3548     0.804384    __find_get_block        /.../vmlinux
c01baf80 2991     0.678104    strncpy_from_user       /.../vmlinux
c016c000 2449     0.555224    prune_dcache            /.../vmlinux
c016c5c0 2441     0.553411    d_alloc                 /.../vmlinux
c019b110 2200     0.498772    do_get_write_access     /.../vmlinux
c016bc00 2074     0.470206    dput                    /.../vmlinux
c0192000 2047     0.464085    ext3_read_inode         /.../vmlinux
c013f250 1977     0.448215    kmem_cache_alloc        /.../vmlinux
c0120800 1818     0.412167    profile_hook            /.../vmlinux
c01622d0 1792     0.406273    do_lookup               /.../vmlinux
c0162dd0 1738     0.39403     path_lookup             /.../vmlinux
42074170 1726     0.39131     _int_malloc             /.../vmlinux
c010b9a4 1692     0.383601    apic_timer_interrupt    /.../vmlinux
4207a6d0 1668     0.37816     strlen                  /.../vmlinux
c018f900 1654     0.374986    ext3_get_block_handle   /.../vmlinux
c011b1a0 1593     0.361157    rebalance_tick          /.../vmlinux
c013f3f0 1540     0.349141    kmem_cache_free         /.../vmlinux
c0233b30 1529     0.346647    tw_interrupt            /.../vmlinux
c018fda0 1497     0.339392    ext3_getblk             /.../vmlinux
08049204 1490     0.337805    fgetc_wrapped           /.../vmlinux
c01a2c50 1448     0.328283    journal_add_journal_head /.../vmlinux
08049244 1419     0.321708    getline_wrapped         /.../vmlinux
c0191df0 1384     0.313773    ext3_get_inode_loc      /.../vmlinux
c019be30 1379     0.31264     journal_dirty_metadata  /.../vmlinux
c0192330 1320     0.299263    ext3_do_update_inode    /.../vmlinux
[...]

tune2fs -l /dev/sdb1:

tune2fs 1.32 (09-Nov-2002)
Filesystem volume name:   /backup
Last mounted on:          <not available>
Filesystem UUID:          a8611f50-eb9d-4796-b182-84c8ce2cd0d3
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype needs_recovery sparse_super
Default mount options:    (none)
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              67862528
Block count:              135703055
Reserved block count:     1357030
Free blocks:              97698838
Free inodes:              66076067
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16384
Inode blocks per group:   512
Filesystem created:       Fri Apr 18 15:16:46 2003
Last mount time:          Thu May 29 07:41:09 2003
Last write time:          Thu May 29 07:41:09 2003
Mount count:              3
Maximum mount count:      37
Last checked:             Fri Apr 18 15:16:46 2003
Check interval:           15552000 (6 months)
Next check after:         Wed Oct 15 15:16:46 2003
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal UUID:             0b11edcb-9c08-4030-bda7-141060aefd09
Journal inode:            0
Journal device:           0x0805
First orphan inode:       0


-- 
--
Kevin Jacobs
The OPAL Group - Enterprise Systems Architect
Voice: (216) 986-0710 x 19         E-mail: jacobs@theopalgroup.com
Fax:   (216) 986-0714              WWW:    http://www.theopalgroup.com

