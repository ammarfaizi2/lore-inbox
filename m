Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUACDe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 22:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbUACDe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 22:34:26 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:38800 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262540AbUACDeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 22:34:05 -0500
Date: Sat, 3 Jan 2004 04:33:28 +0100
From: Tobias Diedrich <ranma@gmx.at>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Message-ID: <20040103033327.GA413@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <3FF5B3AB.5020309@wmich.edu> <200401022200.22917.ornati@lycos.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401022200.22917.ornati@lycos.it>
X-GPG-Fingerprint: 7168 1190 37D2 06E8 2496  2728 E6AF EC7A 9AC7 E0BC
X-GPG-Key: http://studserv.stud.uni-hannover.de/~ranma/gpg-key
User-Agent: Mutt/1.5.4i
X-Seen: false
X-ID: ESVv+yZLgeqdz-SOGzM0sW2s21EiQUSlvxuoAjdIjyPd07elg+ckcx@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some numbers I got on 2.4 and 2.6 with hdparm.

2.4.23-acl-preempt-lowlatency:
0: 47.18 47.18
8: 47.18 47.18
16: 47.18 47.18
32: 47.18 47.18
64: 47.18 47.02
128: 47.18 47.18

2.6.0:
0: 28.68 28.73
8: 28.87 28.76
16: 28.82 28.83
256: 43.77 44.13
512: 24.86 24.86
1024: 26.49

Note: The last number is missing because I used hdparm -a${x}t and it
      seems that it sets the readahead _after_ the measurements and I
      had to compensate for that, after I noticed it with the following
      measurement.

2.6.0 with preempt enabled, now 3 repeats and
hdparm -a${x}t /dev/hda
instead of
hdparm -a${x}tT /dev/hda

0:    28.09 28.11 28.17
128:  41.52 41.44 40.94
256:  41.07 41.39 41.32
512:  24.59 25.04 24.84
1024: 26.49 26.30

2.6.1-rc1 without preempt and corrected script to do the readahead
setting first, anticipatory scheduler:

0:    28.92 28.91 28.49
128:  33.78 33.60 33.62
256:  33.62 33.55 33.60
512:  33.54 33.54 33.41
1024: 33.60 33.60 33.43

2.6.1-rc1, noop scheduler:

0:    28.36 28.86 28.82
128:  33.45 33.50 33.52
256:  33.45 33.51 33.52
512:  33.23 33.51 33.51
1024: 33.52 33.54 33.54

Very interesting tidbit:

with 2.6.1-rc1 and "dd if=/dev/hda of=/dev/null" I get stable 28 MB/s,
but with "cat < /dev/hda > /dev/null" I get 48 MB/s according to "vmstat
5".

oprofile report for 2.6.0, the second run IIRC:
CPU: Athlon, speed 1477.56 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a unit mask of 0x00 (No unit mask) count 738778
vma      samples  %           app name                 symbol name
c01f0b3e 16325    38.9944     vmlinux                  __copy_to_user_ll
c022fdd7 3600      8.5991     vmlinux                  ide_outb
c010cb41 3374      8.0592     vmlinux                  mask_and_ack_8259A
c01117c4 2670      6.3776     vmlinux                  mark_offset_tsc
00000000 1761      4.2064     hdparm                   (no symbols)
c022fd9b 1448      3.4587     vmlinux                  ide_inb
c010ca69 1335      3.1888     vmlinux                  enable_8259A_irq
c01088b4 862       2.0590     vmlinux                  irq_entries_start
c0111a45 502       1.1991     vmlinux                  delay_tsc
c0106a8c 484       1.1561     vmlinux                  default_idle
c010ca16 414       0.9889     vmlinux                  disable_8259A_irq
c0109154 257       0.6139     vmlinux                  apic_timer_interrupt
c022fde2 217       0.5183     vmlinux                  ide_outbsync
c012fa13 206       0.4921     vmlinux                  mempool_alloc
c012da03 198       0.4729     vmlinux                  do_generic_mapping_read
c01471a4 195       0.4658     vmlinux                  drop_buffers
c013045a 191       0.4562     vmlinux                  __rmqueue
c0144515 180       0.4300     vmlinux                  unlock_buffer
c0218999 179       0.4276     vmlinux                  blk_rq_map_sg
c022fe0a 179       0.4276     vmlinux                  ide_outl
c013335f 177       0.4228     vmlinux                  kmem_cache_free
c01307bd 163       0.3893     vmlinux                  buffered_rmqueue
c0219b09 159       0.3798     vmlinux                  __make_request
c014613c 157       0.3750     vmlinux                  block_read_full_page
c0116b39 150       0.3583     vmlinux                  schedule
c01332ce 149       0.3559     vmlinux                  kmem_cache_alloc
c0144b2f 136       0.3249     vmlinux                  end_buffer_async_read
c012fb42 111       0.2651     vmlinux                  mempool_free
c014741f 110       0.2627     vmlinux                  init_buffer_head
c01ee88b 109       0.2604     vmlinux                  radix_tree_insert
c0130108 105       0.2508     vmlinux                  bad_range
c0133152 98        0.2341     vmlinux                  free_block
c01071ca 96        0.2293     vmlinux                  __switch_to
c012d71f 96        0.2293     vmlinux                  find_get_page
c014597e 93        0.2221     vmlinux                  create_empty_buffers
c022dd3a 90        0.2150     vmlinux                  ide_do_request
c01301ba 84        0.2006     vmlinux                  free_pages_bulk
c01eeab3 84        0.2006     vmlinux                  radix_tree_delete
c012d421 81        0.1935     vmlinux                  add_to_page_cache
c013236e 80        0.1911     vmlinux                  page_cache_readahead
c012d5e8 79        0.1887     vmlinux                  unlock_page
c011813c 76        0.1815     vmlinux                  prepare_to_wait
c01308e1 74        0.1768     vmlinux                  __alloc_pages
c0147512 71        0.1696     vmlinux                  bio_alloc
c0146f5a 68        0.1624     vmlinux                  submit_bh
c01ee922 67        0.1600     vmlinux                  radix_tree_lookup
c01f0729 66        0.1576     vmlinux                  fast_clear_page
c01306d4 66        0.1576     vmlinux                  free_hot_cold_page
c022d12c 66        0.1576     vmlinux                  ide_end_request
c022e349 65        0.1553     vmlinux                  ide_intr
c0116247 65        0.1553     vmlinux                  recalc_task_prio
c021e20d 61        0.1457     vmlinux                  as_merge
c012dd4d 60        0.1433     vmlinux                  file_read_actor
c012d514 60        0.1433     vmlinux                  page_waitqueue
c022db45 58        0.1385     vmlinux                  start_request
c0218800 57        0.1362     vmlinux                  blk_recount_segments
c01445f6 56        0.1338     vmlinux                  __set_page_buffers
c0148fc0 56        0.1338     vmlinux                  max_block
c010a36c 54        0.1290     vmlinux                  handle_IRQ_event
c021db03 53        0.1266     vmlinux                  as_move_to_dispatch
c0236409 53        0.1266     vmlinux                  lba_48_rw_disk
c012d8ee 52        0.1242     vmlinux                  find_get_pages
c021d4a9 51        0.1218     vmlinux                  as_update_iohist
c0146f2d 51        0.1218     vmlinux                  end_bio_bh_io_sync
c021a10c 51        0.1218     vmlinux                  submit_bio
c021a313 50        0.1194     vmlinux                  __end_that_request_first
c0116391 49        0.1170     vmlinux                  try_to_wake_up
c021e1b4 48        0.1147     vmlinux                  as_queue_empty
c01201fc 48        0.1147     vmlinux                  del_timer
c01473d5 48        0.1147     vmlinux                  free_buffer_head
c0219fdf 47        0.1123     vmlinux                  generic_make_request
c0147259 47        0.1123     vmlinux                  try_to_free_buffers
c021dc81 46        0.1099     vmlinux                  as_dispatch_request
c0219439 45        0.1075     vmlinux                  get_request
c0134795 45        0.1075     vmlinux                  invalidate_complete_page
c0218ac9 45        0.1075     vmlinux                  ll_back_merge_fn
c01161f8 43        0.1027     vmlinux                  effective_prio
c0120006 42        0.1003     vmlinux                  __mod_timer
c0132fa8 41        0.0979     vmlinux                  cache_alloc_refill
c0147393 40        0.0955     vmlinux                  alloc_buffer_head
c01451f5 39        0.0932     vmlinux                  create_buffers
c0134344 39        0.0932     vmlinux                  release_pages
c0236118 37        0.0884     vmlinux                  __ide_do_rw_disk
c021e35d 37        0.0884     vmlinux                  as_merged_request
c010a5b9 36        0.0860     vmlinux                  do_IRQ
c0134a52 36        0.0860     vmlinux                  invalidate_mapping_pages
c0111763 36        0.0860     vmlinux                  sched_clock
c012d540 36        0.0860     vmlinux                  wait_on_page_bit
c021909d 35        0.0836     vmlinux                  blk_run_queues
c021d88c 32        0.0764     vmlinux                  as_remove_queued_request
c0147c8c 32        0.0764     vmlinux                  bio_endio
c0217ddc 32        0.0764     vmlinux                  elv_try_last_merge
c023c716 32        0.0764     vmlinux                  ide_build_dmatable
00000000 31        0.0740     libc-2.3.2.so            (no symbols)
c011d0a0 31        0.0740     vmlinux                  do_softirq
c014913b 30        0.0717     vmlinux                  blkdev_get_block
00000000 29        0.0693     ld-2.3.2.so              (no symbols)
c0134517 29        0.0693     vmlinux                  __pagevec_lru_add
c01474cc 29        0.0693     vmlinux                  bio_destructor
c02311bb 29        0.0693     vmlinux                  do_rw_taskfile
c0231f7d 29        0.0693     vmlinux                  ide_cmd_type_parser
c014583c 29        0.0693     vmlinux                  set_bh_page
c0132227 27        0.0645     vmlinux                  do_page_cache_readahead
c0219805 27        0.0645     vmlinux                  drive_stat_acct
c0230a11 27        0.0645     vmlinux                  ide_execute_command
c01201b2 27        0.0645     vmlinux                  mod_timer
c021a77f 26        0.0621     vmlinux                  get_io_context
c011672e 26        0.0621     vmlinux                  scheduler_tick
00000000 25        0.0597     bash                     (no symbols)
c0217bec 25        0.0597     vmlinux                  elv_queue_empty
c012059e 24        0.0573     vmlinux                  update_one_process
c0231000 23        0.0549     vmlinux                  SELECT_DRIVE
c023cb24 23        0.0549     vmlinux                  __ide_dma_read
c021d3a2 23        0.0549     vmlinux                  as_can_break_anticipation
c0109134 23        0.0549     vmlinux                  common_interrupt
c0218fb4 23        0.0549     vmlinux                  generic_unplug_device
c01ee966 22        0.0525     vmlinux                  __lookup
c012d194 22        0.0525     vmlinux                  __remove_from_page_cache
c02001ed 22        0.0525     vmlinux                  add_timer_randomness
c021deef 22        0.0525     vmlinux                  as_add_request
c021a4dd 22        0.0525     vmlinux                  end_that_request_last
c012fbc8 22        0.0525     vmlinux                  mempool_free_slab
c0131f78 22        0.0525     vmlinux                  read_pages
c02361cd 21        0.0502     vmlinux                  get_command
c01eef2b 21        0.0502     vmlinux                  rb_next
c021cf02 20        0.0478     vmlinux                  as_add_arq_hash
c021e80b 20        0.0478     vmlinux                  as_set_request
c023c547 20        0.0478     vmlinux                  ide_build_sglist
c012fbb8 20        0.0478     vmlinux                  mempool_alloc_slab
c010da6b 20        0.0478     vmlinux                  timer_interrupt
00000000 19        0.0454     oprofiled26              (no symbols)
c021d740 19        0.0454     vmlinux                  as_completed_request
c0230231 19        0.0454     vmlinux                  drive_is_ready
c02302e1 19        0.0454     vmlinux                  ide_wait_stat
c01341c1 19        0.0454     vmlinux                  mark_page_accessed
c013055b 19        0.0454     vmlinux                  rmqueue_bulk
c012069a 19        0.0454     vmlinux                  run_timer_softirq
c021da9c 18        0.0430     vmlinux                  as_fifo_expired
c021d95f 18        0.0430     vmlinux                  as_remove_dispatched_request
c01181d7 17        0.0406     vmlinux                  finish_wait
c013246e 17        0.0406     vmlinux                  handle_ra_miss
c021e0f2 16        0.0382     vmlinux                  as_insert_request
c010ad15 16        0.0382     vmlinux                  disable_irq_nosync
c01f0785 16        0.0382     vmlinux                  fast_copy_page
c010a441 16        0.0382     vmlinux                  note_interrupt
c01ee7aa 16        0.0382     vmlinux                  radix_tree_preload
c0120817 15        0.0358     vmlinux                  do_timer
c01087ee 15        0.0358     vmlinux                  restore_all
c01f04bc 14        0.0334     vmlinux                  __delay
c021d47e 14        0.0334     vmlinux                  as_can_anticipate
c021d684 14        0.0334     vmlinux                  as_update_arq
c0147eec 14        0.0334     vmlinux                  bio_hw_segments
c011d18d 14        0.0334     vmlinux                  raise_softirq
c01086c5 14        0.0334     vmlinux                  ret_from_intr
c01204c6 14        0.0334     vmlinux                  update_wall_time_one_tick
c011702f 13        0.0311     vmlinux                  __wake_up_common
c021da16 13        0.0311     vmlinux                  as_remove_request
c0147ecf 13        0.0311     vmlinux                  bio_phys_segments
c0218e97 13        0.0311     vmlinux                  blk_plug_device
c021a7e0 13        0.0311     vmlinux                  copy_io_context
c0136cdd 13        0.0311     vmlinux                  copy_page_range
c0106ae1 13        0.0311     vmlinux                  cpu_idle
c0235577 13        0.0311     vmlinux                  default_end_request
c010938c 13        0.0311     vmlinux                  page_fault
c01eef63 13        0.0311     vmlinux                  rb_prev
c023cc6c 12        0.0287     vmlinux                  __ide_dma_begin
c021cfd8 12        0.0287     vmlinux                  as_add_arq_rb
c021d315 12        0.0287     vmlinux                  as_close_req
c013685b 12        0.0287     vmlinux                  blk_queue_bounce
c013847d 12        0.0287     vmlinux                  do_no_page
c0217a19 12        0.0287     vmlinux                  elv_merge
c0217b01 12        0.0287     vmlinux                  elv_next_request
c023c4ca 12        0.0287     vmlinux                  ide_dma_intr
c013041e 12        0.0287     vmlinux                  prep_new_page
c012d678 11        0.0263     vmlinux                  __lock_page
c021d178 11        0.0263     vmlinux                  as_find_next_arq
c01444e5 11        0.0263     vmlinux                  bh_waitq_head
c021a4af 11        0.0263     vmlinux                  end_that_request_first
c0108702 11        0.0263     vmlinux                  need_resched
c01eee3f 11        0.0263     vmlinux                  rb_erase
c0145878 11        0.0263     vmlinux                  try_to_release_page
c01444fa 11        0.0263     vmlinux                  wake_up_buffer
c0144623 10        0.0239     vmlinux                  __clear_page_buffers
c023cca4 10        0.0239     vmlinux                  __ide_dma_end
c021d07f 10        0.0239     vmlinux                  as_choose_req
c021e7c2 10        0.0239     vmlinux                  as_put_request
c0147155 10        0.0239     vmlinux                  check_ttfb_buffer
c026493f 10        0.0239     vmlinux                  i8042_interrupt
c01341ef 10        0.0239     vmlinux                  lru_cache_add
c014735a 10        0.0239     vmlinux                  recalc_bh_state
c02198b0 9         0.0215     vmlinux                  __blk_put_request
c021e1f4 9         0.0215     vmlinux                  as_latter_request
c010a503 9         0.0215     vmlinux                  enable_irq
c0231efa 9         0.0215     vmlinux                  ide_handler_parser
c0124348 9         0.0215     vmlinux                  notifier_call_chain
c013bd66 9         0.0215     vmlinux                  page_remove_rmap
c0116fdc 9         0.0215     vmlinux                  preempt_schedule
c011707a 8         0.0191     vmlinux                  __wake_up
c012d4e7 8         0.0191     vmlinux                  add_to_page_cache_lru
c014921e 8         0.0191     vmlinux                  blkdev_readpage
c0217c9d 8         0.0191     vmlinux                  elv_completed_request
c0113745 8         0.0191     vmlinux                  smp_apic_timer_interrupt
c028f61d 8         0.0191     vmlinux                  sync_buffer
c012056b 8         0.0191     vmlinux                  update_wall_time
c023cdac 7         0.0167     vmlinux                  __ide_dma_count
c0132cef 7         0.0167     vmlinux                  cache_init_objs
c0217c05 7         0.0167     vmlinux                  elv_latter_request
c0231e74 7         0.0167     vmlinux                  ide_pre_handler_parser
c023caac 7         0.0167     vmlinux                  ide_start_dma
c021a6d7 7         0.0167     vmlinux                  put_io_context
c01eec00 7         0.0167     vmlinux                  rb_insert_color
c01f0517 6         0.0143     vmlinux                  __const_udelay
c0130c1c 6         0.0143     vmlinux                  __pagevec_free
c021d259 6         0.0143     vmlinux                  as_antic_stop
c021ce97 6         0.0143     vmlinux                  as_get_io_context
c021dec8 6         0.0143     vmlinux                  as_next_request
c021cec5 6         0.0143     vmlinux                  as_remove_merge_hints
c0217bc7 6         0.0143     vmlinux                  elv_remove_request
c012d7a4 6         0.0143     vmlinux                  find_lock_page
c0236508 6         0.0143     vmlinux                  ide_do_rw_disk
c013bcba 6         0.0143     vmlinux                  page_add_rmap
c013cf5a 6         0.0143     vmlinux                  shmem_getpage
c013c39c 6         0.0143     vmlinux                  shmem_swp_alloc
c0131ba4 6         0.0143     vmlinux                  test_clear_page_dirty
00000000 5         0.0119     ISO8859-1.so             (no symbols)
c01eecce 5         0.0119     vmlinux                  __rb_erase_color
c01f05dc 5         0.0119     vmlinux                  _mmx_memcpy
c013413c 5         0.0119     vmlinux                  activate_page
c028f76c 5         0.0119     vmlinux                  add_event_entry
c011701d 5         0.0119     vmlinux                  default_wake_function
c021986e 5         0.0119     vmlinux                  disk_round_stats
c0217a35 5         0.0119     vmlinux                  elv_merged_request
c010c9e8 5         0.0119     vmlinux                  end_8259A_irq
c02193b3 5         0.0119     vmlinux                  freed_request
c011ff72 5         0.0119     vmlinux                  internal_add_timer
c01eeb7d 5         0.0119     vmlinux                  radix_tree_node_ctor
c012080d 5         0.0119     vmlinux                  run_local_timers
00000000 4         0.0096     nmbd                     (no symbols)
c023cd21 4         0.0096     vmlinux                  __ide_dma_test_irq
c013320a 4         0.0096     vmlinux                  cache_flusharray
c022e022 4         0.0096     vmlinux                  do_ide_request
c0217c4c 4         0.0096     vmlinux                  elv_set_request
c0139e36 4         0.0096     vmlinux                  find_vma
c013885e 4         0.0096     vmlinux                  handle_mm_fault
c0117c4e 4         0.0096     vmlinux                  io_schedule
c0256be8 4         0.0096     vmlinux                  uhci_hub_status_data
c0136ff3 4         0.0096     vmlinux                  zap_pte_range
c0217a99 3         0.0072     vmlinux                  __elv_add_request
c028f4ed 3         0.0072     vmlinux                  add_sample_entry
c021cfb8 3         0.0072     vmlinux                  as_find_first_arq
c0118233 3         0.0072     vmlinux                  autoremove_wake_function
c0147672 3         0.0072     vmlinux                  bio_put
c0132d68 3         0.0072     vmlinux                  cache_grow
c010920c 3         0.0072     vmlinux                  device_not_available
c0217c71 3         0.0072     vmlinux                  elv_put_request
c017f280 3         0.0072     vmlinux                  journal_switch_revoke_table
c0144ce6 3         0.0072     vmlinux                  mark_buffer_async_read
c0229b32 3         0.0072     vmlinux                  mdio_read
c0133701 3         0.0072     vmlinux                  reap_timer_fnc
c01180f8 3         0.0072     vmlinux                  remove_wait_queue
c010e4eb 3         0.0072     vmlinux                  restore_fpu
c0259c77 3         0.0072     vmlinux                  stall_callback
c01087ac 3         0.0072     vmlinux                  system_call
00000000 2         0.0048     apache                   (no symbols)
00000000 2         0.0048     cupsd                    (no symbols)
c015cadc 2         0.0048     vmlinux                  __mark_inode_dirty
c0131abc 2         0.0048     vmlinux                  __set_page_dirty_nobuffers
c0200345 2         0.0048     vmlinux                  add_disk_randomness
c0217e50 2         0.0048     vmlinux                  clear_queue_congested
c017b4da 2         0.0048     vmlinux                  do_get_write_access
c01154e7 2         0.0048     vmlinux                  do_page_fault
c0137b16 2         0.0048     vmlinux                  do_wp_page
c01555d9 2         0.0048     vmlinux                  dput
c01442a9 2         0.0048     vmlinux                  fget_light
c012e044 2         0.0048     vmlinux                  generic_file_read
c025a39b 2         0.0048     vmlinux                  hc_state_transitions
c0231f7a 2         0.0048     vmlinux                  ide_post_handler_parser
c0133391 2         0.0048     vmlinux                  kfree
c016271f 2         0.0048     vmlinux                  load_elf_binary
c025a326 2         0.0048     vmlinux                  ports_active
c013c174 2         0.0048     vmlinux                  pte_chain_alloc
c013c292 2         0.0048     vmlinux                  shmem_swp_entry
c0123389 2         0.0048     vmlinux                  sys_rt_sigprocmask
c0134735 2         0.0048     vmlinux                  truncate_complete_page
c0202375 2         0.0048     vmlinux                  tty_write
c015803a 2         0.0048     vmlinux                  update_atime
c0143527 2         0.0048     vmlinux                  vfs_read
c0242712 2         0.0048     vmlinux                  vgacon_cursor
c02436fc 2         0.0048     vmlinux                  vgacon_scroll
c012645e 2         0.0048     vmlinux                  worker_thread
c0206a54 2         0.0048     vmlinux                  write_chan
00000000 1         0.0024     gawk                     (no symbols)
00000000 1         0.0024     libc-2.3.2.so            (no symbols)
00000000 1         0.0024     ls                       (no symbols)
00000000 1         0.0024     tee                      (no symbols)
c0145d1c 1         0.0024     vmlinux                  __block_prepare_write
c01f0b94 1         0.0024     vmlinux                  __copy_from_user_ll
c01456a2 1         0.0024     vmlinux                  __find_get_block
c012de1f 1         0.0024     vmlinux                  __generic_file_aio_read
c0130b8e 1         0.0024     vmlinux                  __get_free_pages
c017c9b4 1         0.0024     vmlinux                  __journal_file_buffer
c0134483 1         0.0024     vmlinux                  __pagevec_release
c0153801 1         0.0024     vmlinux                  __posix_lock_file
c013c128 1         0.0024     vmlinux                  __pte_chain_free
c0144ec2 1         0.0024     vmlinux                  __set_page_dirty_buffers
c015cbde 1         0.0024     vmlinux                  __sync_single_inode
c028f45a 1         0.0024     vmlinux                  add_kernel_ctx_switch
c021cf4d 1         0.0024     vmlinux                  as_find_arq_hash
c0218f2f 1         0.0024     vmlinux                  blk_remove_plug
c01472f5 1         0.0024     vmlinux                  block_sync_page
c0146e4d 1         0.0024     vmlinux                  block_write_full_page
c0228b23 1         0.0024     vmlinux                  boomerang_interrupt
c014de24 1         0.0024     vmlinux                  cached_lookup
c01d0de4 1         0.0024     vmlinux                  cap_bprm_set_security
c01d10d7 1         0.0024     vmlinux                  cap_vm_enough_memory
c0136b10 1         0.0024     vmlinux                  clear_page_tables
c01f097f 1         0.0024     vmlinux                  clear_user
c01189c6 1         0.0024     vmlinux                  copy_files
c0118527 1         0.0024     vmlinux                  copy_mm
c014b52b 1         0.0024     vmlinux                  copy_strings
c0106e05 1         0.0024     vmlinux                  copy_thread
c014b4ed 1         0.0024     vmlinux                  count
c0158f04 1         0.0024     vmlinux                  dnotify_parent
c01382ac 1         0.0024     vmlinux                  do_anonymous_page
c020ef74 1         0.0024     vmlinux                  do_con_trol
c011c4f4 1         0.0024     vmlinux                  do_getitimer
c0152745 1         0.0024     vmlinux                  do_poll
c0151fbf 1         0.0024     vmlinux                  do_select
c014347f 1         0.0024     vmlinux                  do_sync_read
c0133682 1         0.0024     vmlinux                  drain_array_locked
c0118269 1         0.0024     vmlinux                  dup_task_struct
c0172d1c 1         0.0024     vmlinux                  ext3_get_inode_loc
c0171437 1         0.0024     vmlinux                  ext3_getblk
c016e989 1         0.0024     vmlinux                  ext3_new_block
c01514cf 1         0.0024     vmlinux                  fasync_helper
c014426d 1         0.0024     vmlinux                  fget
c0144342 1         0.0024     vmlinux                  file_move
c012e30a 1         0.0024     vmlinux                  filemap_nopage
c013fbab 1         0.0024     vmlinux                  free_page_and_swap_cache
c0130c70 1         0.0024     vmlinux                  free_pages
c0157d5e 1         0.0024     vmlinux                  generic_delete_inode
c014aa08 1         0.0024     vmlinux                  generic_fillattr
c028f5d5 1         0.0024     vmlinux                  get_slots
c014868c 1         0.0024     vmlinux                  get_super
c014dbb0 1         0.0024     vmlinux                  getname
c01cccfd 1         0.0024     vmlinux                  grow_ary
c0108471 1         0.0024     vmlinux                  handle_signal
c0264b57 1         0.0024     vmlinux                  i8042_timer_func
c0157ff6 1         0.0024     vmlinux                  inode_times_differ
c01cd0e4 1         0.0024     vmlinux                  ipc_lock
c017b9b0 1         0.0024     vmlinux                  journal_get_write_access
c017f8af 1         0.0024     vmlinux                  journal_write_metadata_buffer
c017f2d8 1         0.0024     vmlinux                  journal_write_revoke_records
c014e113 1         0.0024     vmlinux                  link_path_walk
c0162400 1         0.0024     vmlinux                  load_elf_interp
c0134273 1         0.0024     vmlinux                  lru_add_drain
c010a13c 1         0.0024     vmlinux                  math_state_restore
c014edfd 1         0.0024     vmlinux                  may_open
c01f0887 1         0.0024     vmlinux                  mmx_clear_page
c014ea19 1         0.0024     vmlinux                  path_lookup
c014d48b 1         0.0024     vmlinux                  pipe_poll
c0151e25 1         0.0024     vmlinux                  poll_freewait
c011aa13 1         0.0024     vmlinux                  profile_hook
c0136ba4 1         0.0024     vmlinux                  pte_alloc_map
c01262f4 1         0.0024     vmlinux                  queue_work
c01ee764 1         0.0024     vmlinux                  radix_tree_node_alloc
c0120f94 1         0.0024     vmlinux                  recalc_sigpending
c011a4d8 1         0.0024     vmlinux                  release_console_sem
c028f589 1         0.0024     vmlinux                  release_mm
c010be88 1         0.0024     vmlinux                  release_x86_irqs
c0139160 1         0.0024     vmlinux                  remove_shared_vm_struct
c01086f8 1         0.0024     vmlinux                  resume_kernel
c024a6e0 1         0.0024     vmlinux                  rh_report_status
c01268f1 1         0.0024     vmlinux                  schedule_work
c0155e2d 1         0.0024     vmlinux                  select_parent
c0107f3e 1         0.0024     vmlinux                  setup_sigcontext
c01325f3 1         0.0024     vmlinux                  slab_destroy
c017ad84 1         0.0024     vmlinux                  start_this_handle
c01f0938 1         0.0024     vmlinux                  strncpy_from_user
c01f09d2 1         0.0024     vmlinux                  strnlen_user
c015d0c2 1         0.0024     vmlinux                  sync_inodes_sb
c015ce4f 1         0.0024     vmlinux                  sync_sb_inodes
c01484e9 1         0.0024     vmlinux                  sync_supers
c0151775 1         0.0024     vmlinux                  sys_ioctl
c015226a 1         0.0024     vmlinux                  sys_select
c01371b5 1         0.0024     vmlinux                  unmap_page_range
c013a061 1         0.0024     vmlinux                  unmap_vma
c0120655 1         0.0024     vmlinux                  update_process_times
c015d031 1         0.0024     vmlinux                  writeback_inodes

HTH,

-- 
Tobias						PGP: http://9ac7e0bc.2ya.com
np: CF-Theme
