Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbUB0S0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbUB0S0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:26:51 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:56961 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262921AbUB0SZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:25:27 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16447.35731.535168.298454@laputa.namesys.com>
Date: Fri, 27 Feb 2004 21:25:23 +0300
To: markw@osdl.org
Cc: piggin@cyberone.com.au, reiserfs-list@Namesys.COM,
       linux-kernel@vger.kernel.org
Subject: Re: AS performance with reiser4 on 2.6.3
In-Reply-To: <200402271656.i1RGuME16838@mail.osdl.org>
References: <16446.13520.5837.193556@laputa.namesys.com>
	<200402271656.i1RGuME16838@mail.osdl.org>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

markw@osdl.org writes:
 > On 26 Feb, Nikita Danilov wrote:
 > > markw@osdl.org writes:
 > >  > Hi Nick,
 > >  > 
 > >  > I started getting some results with dbt-2 on 2.6.3 and saw that reiser4
 > >  > is doing a bit worse with the AS elevator.  Although reiser4 wasn't
 > >  > doing well to begin with, compared to the other filesystems.  I have
 > >  > links to the STP results on our 4-ways and 8-ways here:
 > >  > 	http://developer.osdl.org/markw/fs/dbt2_stp_results.html
 > > 
 > > There were no changes between 2.6.2 and 2.6.3 that could affect reiser4
 > > performance, so it is not clear why numbers are so different. Probably
 > > results should be averaged over several runs. Also can you run test with
 > > 
 > > http://www.namesys.com/snapshots/2004.02.25/extra/e_05-proc-sleep.patch
 > > 
 > > applied? To use it turn CONFIG_PROC_SLEEP on (depends on
 > > CONFIG_FRAME_POINTER), and do "cat /proc/sleep" before and after test
 > > run.
 > 
 > http://khack.osdl.org/stp/288905/results/
 > 
 > There are a set of /proc/sleep files there from a 4-way system.

fsync indeed accounts for a significant fraction of the time. Below are
excerpts from /proc/sleep output. Each stack trace is preceded by three
numbers: number of times schedule() was called in this path, total time
(in microseconds) of sleep for this path, and maximal time of sleep:

157033 310799027 68714
	0 0xc011d651 schedule+0x421/0x720
	1 0xc010831b __down+0x9b/0x120
	2 0xc010858b __down_failed+0xb/0x14
	3 0xc01be5df .text.lock.flush_queue+0x5/0x16
	4 0xc01bdbd1 finish_fq+0x21/0x50
	5 0xc01bdc80 finish_all_fq+0x80/0xd0
	6 0xc01bdd03 current_atom_finish_all_fq+0x33/0x80
	7 0xc01b8536 reiser4_write_logs+0x1c6/0x300
	8 0xc01af43d commit_current_atom+0x17d/0x270
	9 0xc01affed try_commit_txnh+0xed/0x1b0
	10 0xc01b00e8 commit_txnh+0x38/0xd0
	11 0xc01ae60f txn_end+0x3f/0x50
	12 0xc01af580 force_commit_atom_nolock+0x50/0x80
	13 0xc01af76e txnmgr_force_commit_all+0x15e/0x1a0
	14 0xc01c64d6 reiser4_fsync+0x46/0x70

1497 341033905 4655702
	0 0xc011d651 schedule+0x421/0x720
	1 0xc010831b __down+0x9b/0x120
	2 0xc010858b __down_failed+0xb/0x14
	3 0xc01a8487 .text.lock.lock+0x19/0x22
	4 0xc01b18f5 capture_fuse_wait+0x1a5/0x1e0
	5 0xc01b14c2 capture_assign_txnh+0x112/0x190
	6 0xc01b02b7 try_capture_block+0x137/0x210
	7 0xc01b042c try_capture+0x6c/0xf0
	8 0xc01a7dd0 longterm_lock_znode+0x2d0/0x3e0
	9 0xc01baa70 cbk_cache_scan_slots+0x170/0x340
	10 0xc01bac7b cbk_cache_search+0x3b/0x60
	11 0xc01b9b34 coord_by_handle+0x14/0x30
	12 0xc01b9af3 object_lookup+0x93/0xc0
	13 0xc01ee925 find_file_item+0x125/0x1d0
	14 0xc01f09f4 append_and_or_overwrite+0xf4/0x3c0
	15 0xc01f0d39 write_flow+0x79/0x80
	16 0xc01f101e write_file+0x6e/0xa0
	17 0xc01f118e write_unix_file+0x13e/0x230
	18 0xc01c635b reiser4_write+0x6b/0xc0
	19 0xc0161b5f vfs_write+0xaf/0x120

1264 343750692 4655702
	0 0xc011d651 schedule+0x421/0x720
	1 0xc010831b __down+0x9b/0x120
	2 0xc010858b __down_failed+0xb/0x14
	3 0xc01a8487 .text.lock.lock+0x19/0x22
	4 0xc01b18f5 capture_fuse_wait+0x1a5/0x1e0
	5 0xc01b14c2 capture_assign_txnh+0x112/0x190
	6 0xc01b02b7 try_capture_block+0x137/0x210
	7 0xc01b042c try_capture+0x6c/0xf0
	8 0xc01a7a0d longterm_lock_tryfast+0x8d/0x180
	9 0xc01a7ec0 longterm_lock_znode+0x3c0/0x3e0
	10 0xc01baa70 cbk_cache_scan_slots+0x170/0x340
	11 0xc01bac7b cbk_cache_search+0x3b/0x60
	12 0xc01b9b34 coord_by_handle+0x14/0x30
	13 0xc01b9af3 object_lookup+0x93/0xc0
	14 0xc01ee925 find_file_item+0x125/0x1d0
	15 0xc01f0629 read_unix_file+0x2a9/0x580
	16 0xc01c62ab reiser4_read+0x6b/0xb0

208578 728986555 265426
	0 0xc011d651 schedule+0x421/0x720
	1 0xc010831b __down+0x9b/0x120
	2 0xc010858b __down_failed+0xb/0x14
	3 0xc01a8487 .text.lock.lock+0x19/0x22
	4 0xc01a7ce1 longterm_lock_znode+0x1e1/0x3e0
	5 0xc01ba4cb cbk_level_lookup+0x7b/0x300
	6 0xc01ba2b4 traverse_tree+0x104/0x2a0
	7 0xc01b9af3 object_lookup+0x93/0xc0
	8 0xc01ee925 find_file_item+0x125/0x1d0
	9 0xc01f09f4 append_and_or_overwrite+0xf4/0x3c0
	10 0xc01f0d39 write_flow+0x79/0x80
	11 0xc01f101e write_file+0x6e/0xa0
	12 0xc01f118e write_unix_file+0x13e/0x230
	13 0xc01c635b reiser4_write+0x6b/0xc0

271390 16275938018 12639906
	0 0xc011d651 schedule+0x421/0x720
	1 0xc010831b __down+0x9b/0x120
	2 0xc010858b __down_failed+0xb/0x14
	3 0xc01f2026 .text.lock.file+0x19/0x43
	4 0xc01c635b reiser4_write+0x6b/0xc0

1714303 9013881956 329456
	0 0xc011d651 schedule+0x421/0x720
	1 0xc011ecc8 io_schedule+0x28/0x40
	2 0xc0141120 __lock_page+0xb0/0xe0
	3 0xc0142997 read_cache_page+0x187/0x250
	4 0xc01e1ed6 read_extent+0x96/0x2b0
	5 0xc01f06eb read_unix_file+0x36b/0x580
	6 0xc01c62ab reiser4_read+0x6b/0xb0

First three traces can be attributed to the liberal use of fsync that
incurs frequent transaction commits.

The rest is not that clear. Probably you workload results in highly
fragmented file(s). This is consistent with high CPU consumption by
lookup_extent (http://khack.osdl.org/stp/288741/profile/profile-tick.sort).

If test doesn't delete its working files before exiting, can you execute

measurefs.reiser4 -T /device-with-reiser4
measurefs.reiser4 -D /device-with-reiser4

and, if number of files on the file system is sane

measurefs.reiser4 -D -E /device-with-reiser4

?

 > 
 > Mark

Nikita.
