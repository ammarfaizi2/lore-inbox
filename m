Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287532AbSASWJ7>; Sat, 19 Jan 2002 17:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287535AbSASWJp>; Sat, 19 Jan 2002 17:09:45 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:64219 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S287532AbSASWI4>;
	Sat, 19 Jan 2002 17:08:56 -0500
Date: Sat, 19 Jan 2002 23:08:53 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: RAID1/promise 20265 trouble on 2.4.18-pre3-ac2 (was: RAID1 oddity on 2.4.17+)
Message-ID: <20020119230852.A18674@se1.cogenit.fr>
In-Reply-To: <20020108003953.A16356@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020108003953.A16356@fafner.intra.cogenit.fr>; from romieu@cogenit.fr on Tue, Jan 08, 2002 at 12:39:53AM +0100
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Francois Romieu <romieu@cogenit.fr> :
[see <URL:http://www.cs.helsinki.fi/linux/linux-kernel/2002-01/0511.html>]

I put the same partitions on the 4 disks and built two similar RAID arrays.

o md10 is on the Intel controller and md20 on the Promise 20265
  (I've dedicated these two arrays to testing, you're welcome).

# cat /proc/mdstat
[...]
md10 : active raid1 hdc3[1] hda3[0]
      10241344 blocks [2/2] [UU]
[...]      
md20 : active raid1 hdg3[1] hde3[0]
      10241344 blocks [2/2] [UU]


o Boot-time parameters:
Kernel command line: BOOT_IMAGE=2.4.18-pre3-ac2 ro root=901 \
BOOT_FILE=/boot/bzImage-2.4.18-pre3-ac2 nmi_watchdog=1 root=/dev/md1 \
ide0=autotune ide1=autotune ide2=autotune ide3=autotune profile=2 devfs=nomount

o Some gross test:
sync; date; dd if=/dev/zero of=test bs=1024k count=500; sync; date
/dev/md10: 20s
/dev/md20: 240s+/-9s (<-- 10 times more *doh*)
Reproductibility: good.

o The first column is a difference in profile output when test is done
  againt /dev/md10 and the second when the test is done on /dev/md20.

1		1		__block_prepare_write
0		2		__brelse
2		1		__journal_file_buffer
2		0		__journal_remove_journal_head
0		1		__kfree_skb
6		12		__make_request
0		1		__put_unused_buffer_head
1		2		__rdtsc_delay
1		1		__refile_buffer
1		3		__wake_up
1		0		balance_dirty_state
1		0		block_prepare_write
0		5		bread
0		1		d_lookup
1		0		deactivate_page_nolock
5060	30630	default_idle
0		1		do_anonymous_page
4		7		do_get_write_access
32		23		do_rw_disk
0		5		do_softirq
0		1		do_wp_page
0		2		ext3_block_to_path
2		1		ext3_commit_write
1		1		ext3_dirty_inode
2		1		ext3_do_update_inode
1		0		ext3_get_block_handle
1		1		ext3_get_branch
2		0		ext3_get_group_desc
11		6		ext3_get_inode_loc
3		2		ext3_mark_inode_dirty
5		5		ext3_new_block
0		1		ext3_releasepage
0		2		ext3_reserve_inode_write
0		1		ext3_writepage_trans_blocks
122		129		generic_file_write
2		2		generic_make_request
8		7		get_hash_table
8		39		handle_IRQ_event
2		1		ide_build_dmatable
8		4		ide_build_sglist
5		8		ide_dma_intr
22		19		ide_dmaproc
0		1		ide_do_request
25		27		ide_end_request
2		1		ide_get_queue
4		52		ide_intr
11		17		ide_wait_stat
4		2		journal_add_journal_head
3		5		journal_cancel_revoke
6		4		journal_commit_transaction
1		0		journal_destroy_revoke_caches
2		0		journal_dirty_data
5		4		journal_dirty_metadata
5		1		journal_dirty_sync_data
1		0		journal_free_journal_head
2		5		journal_get_write_access
0		1		journal_start
3		1		journal_stop
0		1		journal_unlock_journal_head
10		13		kfree
17		18		kmalloc
29		19		kmem_cache_alloc
8		13		kmem_cache_free
2		1		kmem_cache_grow
0		1		kmem_slab_destroy
1		0		ll_rw_block
0		13		pdc202xx_dmaproc
0		1		prune_icache
1		0		raid1_alloc_bh
3		1		raid1_alloc_r1bh
3		2		raid1_make_request
3		0		rmqueue
1		0		schedule
0		1		set_bh_page
10		4		start_request
0		1		sys_read
1		0		sys_write
2		0		system_call
1		0		try_to_free_buffers
3		1		unlock_page
1		1		walk_page_buffers
2		0		write_some_buffers
0		1		zap_page_range
0		2		zeromap_page_range

o Nothing special in dmesg output.

o ide settings:
# diff -u /proc/ide/hda/settings  /proc/ide/hde/settings 
--- /proc/ide/hda/settings      Sat Jan 19 22:48:47 2002
+++ /proc/ide/hde/settings      Sat Jan 19 22:48:47 2002
@@ -2,8 +2,8 @@
 ----                   -----           ---             ---             ----
 acoustic                0               0               254             rw
 address                 0               0               2               rw
-bios_cyl                7476            0               65535           rw
-bios_head               255             0               255             rw
+bios_cyl                119150          0               65535           rw
+bios_head               16              0               255             rw
 bios_sect               63              0               63              rw
 breada_readahead        128             0               255             rw
 bswap                   0               0               1               r
@@ -11,7 +11,7 @@
 failures                0               0               65535           rw
 file_readahead          124             0               16384           rw
 ide_scsi                0               0               1               rw
-init_speed              69              0               69              rw
+init_speed              12              0               69              rw
 io_32bit                3               0               3               rw
 keepsettings            0               0               1               rw
 lun                     0               0               7               rw

# diff -u /proc/ide/hdc/settings  /proc/ide/hdg/settings
--- /proc/ide/hdc/settings      Sat Jan 19 22:49:35 2002
+++ /proc/ide/hdg/settings      Sat Jan 19 22:49:35 2002
@@ -2,8 +2,8 @@
 ----                   -----           ---             ---             ----
 acoustic                0               0               254             rw
 address                 0               0               2               rw
-bios_cyl                7476            0               65535           rw
-bios_head               255             0               255             rw
+bios_cyl                119150          0               65535           rw
+bios_head               16              0               255             rw
 bios_sect               63              0               63              rw
 breada_readahead        128             0               255             rw
 bswap                   0               0               1               r
@@ -11,7 +11,7 @@
 failures                0               0               65535           rw
 file_readahead          124             0               16384           rw
 ide_scsi                0               0               1               rw
-init_speed              69              0               69              rw
+init_speed              12              0               69              rw
 io_32bit                3               0               3               rw
 keepsettings            0               0               1               rw
 lun                     0               0               7               rw

o Thanks for your attention.

-- 
Ueimor
