Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVAJVa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVAJVa6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVAJVaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:30:55 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:8374 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S262623AbVAJVTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:19:55 -0500
Date: Mon, 10 Jan 2005 16:19:24 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [patch] Per-sb s_all_inodes list
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk
Message-id: <41E2F15C.3010607@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_z0kYd35mo1FHhaJVKAj5XQ)"
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_z0kYd35mo1FHhaJVKAj5XQ)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following patch (against 2.6.10) adds a per super_block list of all
inodes.

Releasing a super_block requires walking all inodes for the given
superblock and releasing them. Currently, inodes are found on one of
four lists:

  - global list inode_in_use
  - global list inode_unused
  - per-sb ->s_dirty
  - per-sb ->s_io

The second list, inode_unused can potentially be quite large.
Unfortunately, it cannot be made per-sb as it is the global LRU list
used for inode cache reduction under memory pressure.

When unmounting a single filesystem, profiling shows dramatic time spent
walking inode_unused.  This because very noticeble when one is
unmounting a decently sized tree of filesystems.

The proposed solution is to create a new list per-sb, that contains all
inodes allocated.  It is maintained under the inode_lock for the sake of
simplicity, but this may prove unneccesary, and may be better done with
another global or per-sb lock.

Unfortunately, this patch also adds another list_head to each struct
inode, but failing other suggestions, I don't see how else to do this.

The following script was used to profile:

- -----------
#!/bin/sh

LOOP=100



# SETUP

for test in `seq 1 $LOOP` ; do

        mkdir /tmp/test$test

        mount -t tmpfs test$test /tmp/test$test

        for i in `seq 1 10` ; do

                mkdir /tmp/test$test/$i

                mount -t tmpfs test$test-$i /tmp/test$test/$i

        done

done



# PROFILE

/usr/local/sbin/readprofile -r

for test in `seq 1 $LOOP` ; do

        umount -l /tmp/test$test

done

/usr/local/sbin/readprofile | sort -nr +2



# CLEANUP

for test in `seq 1 $LOOP` ; do

        rmdir /tmp/test$test

done
- -----------

Before applying this patch, from a fresh boot:
- -----------
  4207 poll_idle                                 65.7344

  3611 invalidate_list                           20.5170

   121 kmem_cache_free                            0.9453

    48 kfree                                      0.3000

    15 kernel_map_pages                           0.1339

    25 seq_escape                                 0.1302

     8 _atomic_dec_and_lock                       0.1000

    30 __d_path                                   0.0938

     8 m_start                                    0.0625

     5 poison_obj                                 0.0625

     1 obj_dbghead                                0.0625

    15 d_path                                     0.0625

     5 page_remove_rmap                           0.0521

    10 kmap_atomic                                0.0521

    13 seq_path                                   0.0508

     4 seq_puts                                   0.0374

    13 show_vfsmnt                                0.0369

     1 proc_follow_link                           0.0312

     1 fput                                       0.0312

     3 change_page_attr                           0.0268

     1 system_call                                0.0227

     2 strnlen_user                               0.0208

     1 shmem_destroy_inode                        0.0208

     1 seq_putc                                   0.0208

    11 do_anonymous_page                          0.0202

     2 pte_alloc_one                              0.0179

     2 handle_IRQ_event                           0.0179

     2 d_genocide                                 0.0179

     2 sysenter_past_esp                          0.0171

     2 de_put                                     0.0156

     1 page_waitqueue                             0.0156

     1 __mntput                                   0.0156

     1 file_kill                                  0.0156

     2 iput                                       0.0139

     2 write_profile                              0.0138

     1 __vm_stat_account                          0.0125

     1 put_filesystem                             0.0125

     1 profile_handoff_task                       0.0125

     1 path_release                               0.0125

     1 name_to_int                                0.0125

     3 __pagevec_lru_add_active                   0.0117

     2 __copy_user_intel                          0.0114

     2 flush_tlb_page                             0.0104

     1 __user_walk                                0.0104

     1 find_vma_prev                              0.0104

     1 find_vma                                   0.0104

     1 find_get_page                              0.0104

     1 fget                                       0.0104
     1 d_lookup                                   0.0104

     2 __do_softirq                               0.0096

     3 release_task                               0.0089

     1 set_page_dirty                             0.0089

     1 page_add_file_rmap                         0.0089

     8 do_wp_page                                 0.0083

     2 __might_sleep                              0.0083

     1 sys_read                                   0.0078

     3 release_pages                              0.0075

     7 copy_page_range                            0.0072

     3 clear_page_tables                          0.0069

     2 vfs_read                                   0.0069

     1 zap_pmd_range                              0.0069

     1 sync_inodes_sb                             0.0069

     1 page_add_anon_rmap                         0.0069

     1 finish_task_switch                         0.0069

     1 filp_close                                 0.0069

     6 zap_pte_range                              0.0067

     1 shrink_dcache_anon                         0.0063

     1 remove_vm_struct                           0.0063

     1 dup_task_struct                            0.0063

     1 deactivate_super                           0.0063

     5 do_no_page                                 0.0060

     3 handle_mm_fault                            0.0059

     1 kmem_cache_alloc                           0.0057

     1 dnotify_flush                              0.0057

     1 generic_fillattr                           0.0052

     4 get_signal_to_deliver                      0.0049

     1 proc_lookup                                0.0048

     1 invalidate_inodes                          0.0048

     1 do_sync_read                               0.0048

     2 cache_alloc_debugcheck_after               0.0045

     1 proc_pid_make_inode                        0.0045

     1 writeback_inodes                           0.0042

     1 scsi_end_request                           0.0042

     8 do_page_fault                              0.0041

     1 pte_alloc_map                              0.0035

  8299 total                                      0.0033

     3 copy_mm                                    0.0032

     1 old_mmap                                   0.0031

     1 __d_lookup                                 0.0031

     1 cap_vm_enough_memory                       0.0031

     2 sync_sb_inodes                             0.0027

     1 prio_tree_insert                           0.0026

     2 vma_adjust                                 0.0025

     1 vfs_quota_sync                             0.0023

     1 check_poison_obj                           0.0021
     2 scsi_request_fn                            0.0019

     1 try_to_wake_up                             0.0015

     1 number                                     0.0015

     3 exit_notify                                0.0013

     1 filemap_nopage                             0.0011

     2 link_path_walk                             0.0006

     1 do_mmap_pgoff                              0.0005
- ------------

Before applying the patch, but after a 'find / > /dev/null':
- ------------
 21489 poll_idle                                335.7656

 21820 invalidate_list                          123.9773

   164 kmem_cache_free                            1.2812

    95 _atomic_dec_and_lock                       1.1875

   110 de_put                                     0.8594

   411 __sync_single_inode                        0.8027

   131 proc_lookup                                0.6298

    70 kfree                                      0.4375

   153 sync_sb_inodes                             0.2079

    23 kernel_map_pages                           0.2054

    41 writeback_inodes                           0.1708

    39 __d_path                                   0.1219

    14 m_start                                    0.1094

     3 wake_up_inode                              0.0938

     9 seq_puts                                   0.0841

    16 seq_escape                                 0.0833

    18 d_path                                     0.0750

    25 show_vfsmnt                                0.0710

     5 poison_obj                                 0.0625

     1 zone_statistics                            0.0625

    13 scsi_end_request                           0.0542

    13 seq_path                                   0.0508

     4 bit_waitqueue                              0.0500

     9 kmap_atomic                                0.0469

     2 system_call                                0.0455

     4 find_get_page                              0.0417

     6 kmem_cache_alloc                           0.0341

     1 writeback_acquire                          0.0312

     1 pmd_ctor                                   0.0312

     4 finish_task_switch                         0.0278

     2 page_remove_rmap                           0.0208

     1 m_next                                     0.0208

     1 find_task_by_pid_type                      0.0208

     1 eventpoll_init_file                        0.0208

     1 blkdev_writepage                           0.0208

     9 __mark_inode_dirty                         0.0194

     6 release_task                               0.0179

     2 change_page_attr                           0.0179

 44876 total                                      0.0177

     3 __copy_user_intel                          0.0170

     9 do_anonymous_page                          0.0165

     1 pagevec_lookup_tag                         0.0156

     1 kmem_flagcheck                             0.0156

     2 find_get_pages_tag                         0.0139

     2 write_profile                              0.0138

     3 fn_hash_lookup                             0.0125

     2 dispose_list                               0.0125

     1 __read_page_state                          0.0125
     1 current_kernel_time                        0.0125

     2 idr_remove                                 0.0114

     2 flush_tlb_page                             0.0104

     1 vm_acct_memory                             0.0104

     1 pid_base_iput                              0.0104

     1 find_vma                                   0.0104

     1 bio_destructor                             0.0104

    10 do_wp_page                                 0.0104

     5 handle_mm_fault                            0.0098

     3 generic_shutdown_super                     0.0094

     1 strncpy_from_user                          0.0089

     1 set_page_dirty                             0.0089

     1 prio_tree_replace                          0.0089

    17 do_page_fault                              0.0087

     1 sysenter_past_esp                          0.0085

     2 __might_sleep                              0.0083

     7 zap_pte_range                              0.0078

     1 unmap_page_range                           0.0078

     1 lru_cache_add_active                       0.0078

     1 flush_thread                               0.0078

     1 del_timer                                  0.0078

     4 cache_reap                                 0.0076

     2 sub_remove                                 0.0074

     1 skb_release_data                           0.0069

     1 rt_hash_code                               0.0069

     1 page_add_anon_rmap                         0.0069

     1 iput                                       0.0069

     2 __d_lookup                                 0.0063

     1 follow_mount                               0.0063

     1 deactivate_super                           0.0063

     4 seq_read                                   0.0060

     1 fsync_super                                0.0052

     5 copy_page_range                            0.0051

     2 release_pages                              0.0050

     4 do_no_page                                 0.0048

     2 do_page_cache_readahead                    0.0048

     1 locks_remove_flock                         0.0048

     2 prune_dcache                               0.0046

     2 cache_alloc_debugcheck_after               0.0045

     1 sys_mmap2                                  0.0045

     1 shmem_delete_inode                         0.0045

     2 dput                                       0.0042

     2 check_poison_obj                           0.0042

     1 rb_insert_color                            0.0039

     1 __pagevec_lru_add_active                   0.0039

     1 __find_get_block                           0.0039

     1 umount_tree                                0.0037

     1 vfs_read                                   0.0035
     1 pte_alloc_map                              0.0035

     2 ahd_linux_isr                              0.0033

     1 generic_delete_inode                       0.0031

     1 cap_vm_enough_memory                       0.0031

     1 profile_hit                                0.0030

     1 mempool_alloc                              0.0028

     1 __fput                                     0.0028

     1 path_lookup                                0.0027

     1 nf_hook_slow                               0.0027

     1 clear_inode                                0.0027

     2 get_signal_to_deliver                      0.0025

     1 exec_mmap                                  0.0024

     2 mpage_writepages                           0.0021

     1 unmap_vmas                                 0.0017

     1 try_to_wake_up                             0.0015

     1 udp_v4_mcast_deliver                       0.0014

     3 exit_notify                                0.0013

     1 vma_adjust                                 0.0012

     1 copy_mm                                    0.0011

     1 ext3_do_update_inode                       0.0010

     1 load_elf_binary                            0.0003
- ------------

After applying the patch, from a fresh boot:
- ------------
   614 poll_idle                                  9.5938

   150 kmem_cache_free                            1.1719

    39 kfree                                      0.2437

    26 kernel_map_pages                           0.2321

    21 seq_escape                                 0.1094

    32 __d_path                                   0.1000

    21 d_path                                     0.0875

    15 kmap_atomic                                0.0781

     8 seq_puts                                   0.0748

    17 seq_path                                   0.0664

     5 _atomic_dec_and_lock                       0.0625

     4 __read_page_state                          0.0500

    17 show_vfsmnt                                0.0483

     6 m_start                                    0.0469

     3 poison_obj                                 0.0375

     1 fput                                       0.0312

     3 pte_alloc_one                              0.0268

     3 page_add_file_rmap                         0.0268

     3 change_page_attr                           0.0268

     4 __copy_user_intel                          0.0227

     2 page_remove_rmap                           0.0208

     1 seq_putc                                   0.0208

     2 sysenter_past_esp                          0.0171

     1 __wake_up_bit                              0.0156

     5 release_task                               0.0149

     2 sys_readlink                               0.0139

     2 write_profile                              0.0138

     7 handle_mm_fault                            0.0137

     7 do_anonymous_page                          0.0129

     5 release_pages                              0.0125

     1 mounts_release                             0.0125

     1 inode_times_differ                         0.0125

     1 current_kernel_time                        0.0125

    21 do_page_fault                              0.0108

     2 flush_tlb_page                             0.0104

     1 strlcpy                                    0.0104

     1 strncpy_from_user                          0.0089

     1 prio_tree_replace                          0.0089

     7 do_no_page                                 0.0084
             8 do_wp_page                                 0.0083

     1 __copy_to_user_ll                          0.0078

     1 anon_vma_unlink                            0.0078

     2 pte_alloc_map                              0.0069

     1 iput                                       0.0069

     1 finish_task_switch                         0.0069

     1 filp_close                                 0.0069

     1 d_rehash                                   0.0069

     6 zap_pte_range                              0.0067
     2 setup_sigcontext                           0.0063

     2 __d_lookup                                 0.0063

     1 sched_migrate_task                         0.0063

     1 dnotify_parent                             0.0063

     1 dispose_list                               0.0063

     2 free_hot_cold_page                         0.0057

     1 kmem_cache_alloc                           0.0057

     1 free_pages_and_swap_cache                  0.0057

     1 vma_prio_tree_add                          0.0052

     1 proc_lookup                                0.0048

     2 cache_alloc_debugcheck_after               0.0045

     1 sigprocmask                                0.0045

     4 copy_page_range                            0.0041

     1 __pagevec_lru_add_active                   0.0039

     1 get_empty_filp                             0.0039

     1 expand_stack                               0.0039

     3 get_signal_to_deliver                      0.0037

     1 path_lookup                                0.0027

     1 vfs_quota_sync                             0.0023

     1 prune_dcache                               0.0023

     1 clear_page_tables                          0.0023

     2 filemap_nopage                             0.0022

     1 dput                                       0.0021

     1 buffered_rmqueue                           0.0018

     1 unmap_vmas                                 0.0017

     1 page_cache_readahead                       0.0017

     1 scsi_dispatch_cmd                          0.0016

     1 do_brk                                     0.0015

     2 exit_notify                                0.0009

     1 do_wait                                    0.0008

     1 do_mmap_pgoff                              0.0005

  1127 total                                      0.0004

     1 link_path_walk                             0.0003
- --------

After applying the patch, doing a fresh reboot and running 'find / >
/dev/null':
- --------
   630 poll_idle                                  9.8438

   167 kmem_cache_free                            1.3047

    52 kfree                                      0.3250

    24 m_start                                    0.1875

    16 kernel_map_pages                           0.1429

    40 __d_path                                   0.1250
            23 seq_escape                                 0.1198

     8 seq_puts                                   0.0748

    13 kmap_atomic                                0.0677

    16 d_path                                     0.0667

     5 _atomic_dec_and_lock                       0.0625

    16 seq_path                                   0.0625

     5 page_remove_rmap                           0.0521

    18 show_vfsmnt                                0.0511

     4 poison_obj                                 0.0500

     4 change_page_attr                           0.0357

     1 wake_up_inode                              0.0312

     1 fput                                       0.0312

    14 do_anonymous_page                          0.0257

     8 release_task                               0.0238

     2 strnlen_user                               0.0208

     2 find_get_page                              0.0208

     1 seq_putc                                   0.0208

     1 unlock_page                                0.0156

     1 mark_page_accessed                         0.0156

     2 page_add_anon_rmap                         0.0139

     2 finish_task_switch                         0.0139

     2 write_profile                              0.0138

     1 __read_page_state                          0.0125

     1 kill_anon_super                            0.0125

     1 flush_signal_handlers                      0.0125

     1 bit_waitqueue                              0.0125

     1 anon_vma_link                              0.0125

    23 do_page_fault                              0.0118

     2 __copy_user_intel                          0.0114

    10 zap_pte_range                              0.0112

     1 vm_acct_memory                             0.0104

     1 find_vma                                   0.0104

    10 do_wp_page                                 0.0104

     2 shmem_delete_inode                         0.0089

     1 strncpy_from_user                          0.0089

     1 set_page_dirty                             0.0089

     1 page_add_file_rmap                         0.0089

     1 bad_range                                  0.0089

     1 sysenter_past_esp                          0.0085

     2 __pagevec_lru_add_active                   0.0078

     1 invalidate_inodes                          0.0078

     1 __insert_vm_struct                         0.0078
     1 fget_light                                 0.0078

     3 release_pages                              0.0075

     1 lookup_mnt                                 0.0069

     1 destroy_inode                              0.0069

     3 dput                                       0.0063

     1 remove_vm_struct                           0.0063

     1 deactivate_super                           0.0063

     5 do_no_page                                 0.0060

     3 handle_mm_fault                            0.0059

     1 kmem_cache_alloc                           0.0057

     1 generic_fillattr                           0.0052

     1 flush_tlb_page                             0.0052

     5 copy_page_range                            0.0051

     2 do_page_cache_readahead                    0.0048

     1 proc_lookup                                0.0048

     2 prune_dcache                               0.0046

     2 clear_page_tables                          0.0046

     2 cache_alloc_debugcheck_after               0.0045

     1 elf_map                                    0.0045

     1 vma_link                                   0.0042

     1 __might_sleep                              0.0042

     1 cp_new_stat64                              0.0039

     3 get_signal_to_deliver                      0.0037

     1 __d_lookup                                 0.0031

     2 seq_read                                   0.0030

     1 proc_get_inode                             0.0027

     1 alloc_inode                                0.0025

     2 copy_mm                                    0.0021

     1 copy_strings                               0.0018

     1 do_generic_mapping_read                    0.0010

     1 create_elf_tables                          0.0010

     2 exit_notify                                0.0009

     2 link_path_walk                             0.0006

     1 do_mmap_pgoff                              0.0005

  1200 total                                      0.0005

     1 load_elf_binary                            0.0003
- -------

- From the profile data above, it would appear that this patch allows
unmounting to scale regardless of the size of the inode caches as well.

Please consider applying,  Thanks,

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB4vFcdQs4kOxk3/MRArK/AJ4xr7bCcum4A9CjJ1bYrJ2BiX3m0gCcCW87
z0JdXMHkwPdTeJmd4k7eLA0=
=QSPC
-----END PGP SIGNATURE-----

--Boundary_(ID_z0kYd35mo1FHhaJVKAj5XQ)
Content-type: text/x-patch; name=per_super_block_inode_list.diff
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=per_super_block_inode_list.diff

Releasing a super_block requires walking all inodes for the given superblock and
releasing them. Currently, inodes are found on one of four lists:
  - global list inode_in_use
  - global list inode_unused
  - per-sb ->s_dirty
  - per-sb ->s_io

The second list, inode_unused can potentially be quite large.  Unfortunately, it
cannot be made per-sb as it is the global LRU list used for inode cache
reduction under memory pressure.

When unmounting a single filesystem, profiling shows dramatic time spent walking
inode_unused.  This because very noticeble when one is unmounting a decently
sized tree of filesystems.

The proposed solution is to create a new list per-sb, that contains all inodes
allocated.  It is maintained under the inode_lock for the sake of simplicity,
but this may prove unneccesary, and may be better done with another global or
per-sb lock.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
Index: linux-2.6.10-quilt/fs/inode.c
===================================================================
--- linux-2.6.10-quilt.orig/fs/inode.c	2005-01-07 14:08:45.000000000 -0800
+++ linux-2.6.10-quilt/fs/inode.c	2005-01-07 14:29:16.000000000 -0800
@@ -115,6 +115,10 @@ static struct inode *alloc_inode(struct 
 		struct address_space * const mapping = &inode->i_data;
 
 		inode->i_sb = sb;
+		spin_lock(&inode_lock);
+		list_add_tail(&inode->i_all_inodes, &sb->s_all_inodes);
+		spin_unlock(&inode_lock);
+
 		inode->i_blkbits = sb->s_blocksize_bits;
 		inode->i_flags = 0;
 		atomic_set(&inode->i_count, 1);
@@ -172,6 +176,9 @@ static struct inode *alloc_inode(struct 
 
 void destroy_inode(struct inode *inode) 
 {
+	spin_lock(&inode_lock);
+	list_del(&inode->i_all_inodes);
+	spin_unlock(&inode_lock);
 	if (inode_has_buffers(inode))
 		BUG();
 	security_inode_free(inode);
@@ -296,7 +303,7 @@ static void dispose_list(struct list_hea
 /*
  * Invalidate all inodes for a device.
  */
-static int invalidate_list(struct list_head *head, struct super_block * sb, struct list_head * dispose)
+static int invalidate_list(struct list_head *head, struct list_head * dispose)
 {
 	struct list_head *next;
 	int busy = 0, count = 0;
@@ -309,9 +316,7 @@ static int invalidate_list(struct list_h
 		next = next->next;
 		if (tmp == head)
 			break;
-		inode = list_entry(tmp, struct inode, i_list);
-		if (inode->i_sb != sb)
-			continue;
+		inode = list_entry(tmp, struct inode, i_all_inodes);
 		invalidate_inode_buffers(inode);
 		if (!atomic_read(&inode->i_count)) {
 			hlist_del_init(&inode->i_hash);
@@ -350,10 +355,7 @@ int invalidate_inodes(struct super_block
 
 	down(&iprune_sem);
 	spin_lock(&inode_lock);
-	busy = invalidate_list(&inode_in_use, sb, &throw_away);
-	busy |= invalidate_list(&inode_unused, sb, &throw_away);
-	busy |= invalidate_list(&sb->s_dirty, sb, &throw_away);
-	busy |= invalidate_list(&sb->s_io, sb, &throw_away);
+	busy = invalidate_list(&sb->s_all_inodes, &throw_away);
 	spin_unlock(&inode_lock);
 
 	dispose_list(&throw_away);
Index: linux-2.6.10-quilt/fs/super.c
===================================================================
--- linux-2.6.10-quilt.orig/fs/super.c	2005-01-07 14:08:50.000000000 -0800
+++ linux-2.6.10-quilt/fs/super.c	2005-01-07 14:13:30.000000000 -0800
@@ -69,6 +69,7 @@ static struct super_block *alloc_super(v
 		INIT_LIST_HEAD(&s->s_io);
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_instances);
+		INIT_LIST_HEAD(&s->s_all_inodes);
 		INIT_HLIST_HEAD(&s->s_anon);
 		init_rwsem(&s->s_umount);
 		sema_init(&s->s_lock, 1);
Index: linux-2.6.10-quilt/include/linux/fs.h
===================================================================
--- linux-2.6.10-quilt.orig/include/linux/fs.h	2005-01-07 14:08:49.000000000 -0800
+++ linux-2.6.10-quilt/include/linux/fs.h	2005-01-07 14:29:43.000000000 -0800
@@ -459,6 +459,7 @@ struct inode {
 #ifdef CONFIG_QUOTA
 	struct dquot		*i_dquot[MAXQUOTAS];
 #endif
+	struct list_head	i_all_inodes;
 	/* These three should probably be a union */
 	struct list_head	i_devices;
 	struct pipe_inode_info	*i_pipe;
@@ -776,6 +777,7 @@ struct super_block {
 	void                    *s_security;
 	struct xattr_handler	**s_xattr;
 
+	struct list_head	s_all_inodes;	/* goes through i_all_inodes */
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_io;		/* parked for writeback */
 	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */

--Boundary_(ID_z0kYd35mo1FHhaJVKAj5XQ)--
