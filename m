Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263259AbTCNGcp>; Fri, 14 Mar 2003 01:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263261AbTCNGco>; Fri, 14 Mar 2003 01:32:44 -0500
Received: from mail-7.tiscali.it ([195.130.225.153]:1227 "EHLO mail.tiscali.it")
	by vger.kernel.org with ESMTP id <S263259AbTCNGcm>;
	Fri, 14 Mar 2003 01:32:42 -0500
Date: Fri, 14 Mar 2003 07:42:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, mikulas@artax.karlin.mff.cuni.cz, pavel@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
Message-ID: <20030314064255.GE32250@dualathlon.random>
References: <Pine.LNX.4.44.0302101723540.32095-100000@artax.karlin.mff.cuni.cz> <Pine.LNX.4.44.0302100846090.2127-100000@home.transmeta.com> <20030210124000.456318e7.akpm@digeo.com> <20030210211806.GA22275@dualathlon.random> <20030210134434.72a59aed.akpm@digeo.com> <20030210215940.GC22275@dualathlon.random> <20030311135831.GA1501@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311135831.GA1501@dualathlon.random>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> mutt          D 00000292     0 14627  24890                     (NOTLB)
> Call Trace:    [__wait_on_buffer+86/144] [ext3_free_inode+391/1248] [ll_rw_block+309/464] [ext3_find_entry+828/864] [ext3_lookup+65/208]
>   [lookup_hash+194/288] [sys_unlink+139/288] [system_call+51/56]
> tee           D ECD560C0     0   111  11445                 110 (NOTLB)
> Call Trace:    [journal_dirty_metadata+420/608] [__wait_on_buffer+86/144] [__cleanup_transaction+362/368] [journal_cancel_revoke+91/448] [log_do_checkpoint+299/448]
>   [n_tty_receive_buf+400/1808] [journal_dirty_metadata+420/608] [n_tty_receive_buf+400/1808] [journal_dirty_metadata+420/608] [ext3_do_update_inode+375/992] [__jbd_kmalloc+35/176]
>   [log_wait_for_space+130/144] [start_this_handle+191/864] [new_handle+75/112] [journal_start+165/208] [ext3_prepare_write+567/576] [write_chan+335/512]
>   [generic_file_write_nolock+1023/2032] [pipe_wait+125/160] [generic_file_write+77/112] [ext3_file_write+57/224] [sys_write+163/336] [system_call+51/56]
> python        D 00000180     0 21334    112 21336   21335       (NOTLB)
> Call Trace:    [start_request+409/544] [__down+105/192] [__down_failed+8/12] [.text.lock.checkpoint+15/173] [start_this_handle+191/864]
>   [new_handle+75/112] [journal_start+165/208] [ext3_lookup+0/208] [ext3_create+300/320] [vfs_create+153/304] [open_namei+1301/1456]
>   [filp_open+62/112] [sys_open+83/192] [system_call+51/56]
> python        D E2EB302C  2388 21335    112 21337         21334 (NOTLB)
> Call Trace:    [dput+33/320] [__down+105/192] [__down_failed+8/12] [.text.lock.namei+265/988] [filp_open+62/112]
>   [sys_open+83/192] [system_call+51/56]
> procmail      D E51AC016     0 21378      1               19102 (NOTLB)
> Call Trace:    [dput+33/320] [__down+105/192] [__down_failed+8/12] [.text.lock.namei+265/988] [filp_open+62/112]
>   [sys_open+83/192] [system_call+51/56]
> python        D C01186FF     0 21470    107         21471       (NOTLB)
> Call Trace:    [do_page_fault+463/1530] [__down+105/192] [__jbd_kmalloc+35/176] [__down_failed+8/12] [.text.lock.checkpoint+15/173]
>   [start_this_handle+191/864] [new_handle+75/112] [journal_start+165/208] [do_wp_page+416/1088] [ext3_dirty_inode+336/368] [__mark_inode_dirty+195/208]
>   [update_inode_times+39/64] [generic_file_write_nolock+630/2032] [generic_file_write+77/112] [ext3_file_write+57/224] [sys_write+163/336] [system_call+51/56]
> python        D C01186FF     0 21471    107               21470 (NOTLB)
> Call Trace:    [do_page_fault+463/1530] [__down+105/192] [__jbd_kmalloc+35/176] [__down_failed+8/12] [.text.lock.checkpoint+15/173]
>   [start_this_handle+191/864] [new_handle+75/112] [journal_start+165/208] [do_wp_page+416/1088] [ext3_dirty_inode+336/368] [__mark_inode_dirty+195/208]
>   [update_inode_times+39/64] [generic_file_write_nolock+630/2032] [generic_file_write+77/112] [ext3_file_write+57/224] [sys_write+163/336] [system_call+51/56]
> python        D 000001E0     0 21732  21731                     (NOTLB)
> Call Trace:    [bread+32/160] [__down+105/192] [__jbd_kmalloc+35/176] [__down_failed+8/12] [.text.lock.checkpoint+15/173]
>   [start_this_handle+191/864] [new_handle+75/112] [journal_start+165/208] [dput+33/320] [ext3_unlink+440/448] [vfs_unlink+233/480]
>   [sys_unlink+183/288] [system_call+51/56]
> procmail      D D0E13016     0 21914  21913                     (NOTLB)
> Call Trace:    [dput+33/320] [__down+105/192] [__down_failed+8/12] [.text.lock.namei+265/988] [filp_open+62/112]
>   [sys_open+83/192] [system_call+51/56]
> procmail      D E39F3016     0 21999  21998                     (NOTLB)
> Call Trace:    [dput+33/320] [__down+105/192] [__down_failed+8/12] [.text.lock.namei+265/988] [filp_open+62/112]
>   [sys_open+83/192] [system_call+51/56]

never mind, I found the real bug and it's not the fsync fix or in ext3.

This other more recent cleanedup trace made the real bug more obvious
since less stuff was involved on the fs side (because it wasn't an fs
problem after all):

gzip          D CEAE5740  1616  1234   1229                     (NOTLB)
Call Trace:    [ext3_new_block+1062/2448] [do_schedule+284/416] [__wait_on_buffer+84/144] [__cleanup_transaction+252/256] [log_do_checkpoint+286/432]
  [ide_build_sglist+156/512] [__ide_dma_begin+57/80] [__ide_dma_count+22/32] [__ide_dma_write+326/352] [dma_timer_expiry+0/224] [do_rw_disk+884/1712]
  [context_switch+131/320] [ide_wait_stat+159/304] [start_request+409/544] [__jbd_kmalloc+35/176] [log_wait_for_space+108/128] [start_this_handle+184/848]
  [new_handle+75/112] [journal_start+165/208] [__alloc_pages+100/624] [ext3_prepare_write+336/352] [lru_cache_add+99/112] [generic_file_write_nolock+999/1856]
  [generic_file_write+76/112] [ext3_file_write+57/224] [sys_write+163/304] [system_call+51/56]
shutdown      D DFE7D940     0  2308      1  2309          2169 (NOTLB)
Call Trace:    [do_schedule+284/416] [__wait_on_buffer+84/144] [__refile_buffer+86/112] [wait_for_buffers+172/176] [wait_for_locked_buffers+35/48]
  [sync_buffers+106/112] [fsync_dev+68/80] [sys_sync+15/32] [system_call+51/56]
sshd          D D0CC93DC     0  2338    601  2339    2340  1226 (NOTLB)
Call Trace:    [do_schedule+284/416] [__down+90/160] [__jbd_kmalloc+35/176] [__down_failed+8/12] [.text.lock.checkpoint+15/109]
  [start_this_handle+184/848] [new_handle+75/112] [journal_start+165/208] [ext3_dirty_inode+276/288] [__mark_inode_dirty+150/160] [update_atime+94/96]
  [generic_file_read+174/352] [file_read_actor+0/144] [sys_read+163/304] [sys_fstat64+73/128] [system_call+51/56]
sync          D DFF858C0    80  2422   2394                     (NOTLB)
Call Trace:    [do_schedule+284/416] [__wait_on_buffer+84/144] [wait_for_buffers+172/176] [wait_for_locked_buffers+35/48] [sync_buffers+106/112]
  [fsync_dev+68/80] [sys_sync+15/32] [system_call+51/56]

sshd waits for gzip on the journal lock, gzip and shutdown waits on a
buffer that was supposed to be submitted by `sync`, but really `sync`
never submitted it, it only locked it. This bug is present only in
2.4.21pre4aa3 (all previous didn't had this problem). This was extremely
hard to trigger, so it's not surprising few people noticed it,
expecially on fast machines. The lowlatency improvements in
write_some_buffers zeroed out 'count' at the second pass, and so we lost
track of those bh if need_resched was set during the write_some_buffers
pass. this will be fixed in my next tree that I can now release
confortably back in rock solid state with also the fsync-race fix
re-added ;)

here the untested fix against 2.4.21pre4aa3 that I will include in
2.4.21pre5aa1:

--- x/fs/buffer.c.~1~	2003-03-13 06:15:29.000000000 +0100
+++ x/fs/buffer.c	2003-03-14 07:36:40.000000000 +0100
@@ -236,10 +236,10 @@ static int write_some_buffers(kdev_t dev
 	unsigned int count;
 	int nr, num_sched = 0;
 
+	count = 0;
  restart:
 	next = lru_list[BUF_DIRTY];
 	nr = nr_buffers_type[BUF_DIRTY];
-	count = 0;
 	while (next && --nr >= 0) {
 		struct buffer_head * bh = next;
 		next = bh->b_next_free;

Sorry for the noise.

Andrea
