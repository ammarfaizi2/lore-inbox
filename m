Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVBCC0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVBCC0K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 21:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbVBCC0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 21:26:09 -0500
Received: from netblock-66-218-40-30.dslextreme.com ([66.218.40.30]:2743 "EHLO
	mail.lowrydigital.com") by vger.kernel.org with ESMTP
	id S262454AbVBCCYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 21:24:36 -0500
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Transfer-Encoding: 7bit
Message-Id: <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Ian Godin <Ian.Godin@lowrydigital.com>
Subject: Drive performance bottleneck
Date: Wed, 2 Feb 2005 18:24:27 -0800
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I am trying to get very fast disk drive performance and I am seeing 
some interesting bottlenecks.  We are trying to get 800 MB/sec or more 
(yes, that is megabytes per second).  We are currently using 
PCI-Express with a 16 drive raid card (SATA drives).  We have achieved 
that speed, but only through the SG (SCSI generic) driver.  This is 
running the stock 2.6.10 kernel.  And the device is not mounted as a 
file system.  I also set the read ahead size on the device to 16KB 
(which speeds things up a lot):

blockdev --setra 16834 /dev/sdb

So here are the results:

$ time dd if=/dev/sdb of=/dev/null bs=64k count=1000000
1000000+0 records in
1000000+0 records out
0.27user 86.19system 2:40.68elapsed 53%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (0major+177minor)pagefaults 0swaps

64k * 1000000 / 160.68 = 398.3 MB/sec

Using sg_dd just to make sure it works the same:

$ time sg_dd if=/dev/sdb of=/dev/null bs=64k count=1000000
1000000+0 records in
1000000+0 records out
0.05user 144.27system 2:41.55elapsed 89%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (17major+5375minor)pagefaults 0swaps

   Pretty much the same speed.  Now using the SG device (sg1 is tied to 
sdb):

$ time sg_dd if=/dev/sg1 of=/dev/null bs=64k count=1000000
Reducing read to 16 blocks per loop
1000000+0 records in
1000000+0 records out
0.22user 66.21system 1:10.23elapsed 94%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (0major+2327minor)pagefaults 0swaps

64k * 1000000 / 70.23 = 911.3 MB/sec

   Now that's more like the speeds we expected.  I understand that the 
SG device uses direct I/O and/or mmap memory from the kernel.  What I 
cannot believe is that there is that much overhead in going through the 
page buffer/cache system in Linux.

   We also tried going through a file system (various ones, JFS, XFS, 
Reiser, Ext3).  They all seem to bottleneck at around 400MB/sec, much 
like /dev/sdb does.  We also have a "real" SCSI raid system which also 
bottlenecks right at 400 MB/sec.  Under Windows (XP) both of these 
systems run at 650 (SCSI) or 800 (SATA) MB/sec.

   Other variations I've tried: setting the read ahead to larger or 
smaller number (1, 2, 4, 8, 16, 32, 64 KB)... 8 or 16 seems to be 
optimal.  Using different block sizes in the dd command (again 1, 2, 4, 
8, 16, 32, 64).  16, 32, 64 are pretty much identical and fastest.

  Below is an oprofile (truncated) of (the same) dd running on /dev/sdb.

   So is the overhead really that high?  Hopefully there's a bottleneck 
in there that no one has come across yet, and it can be optimized.  
Anyone else trying to pull close to 1GB/sec from disk? :)  The kernel 
has changed a lot since the last time I really worked with it (2.2), so 
any suggestions are appreciated.

Ian Godin
Senior Software Developer
DTS/Lowry Digital Images

-----------

CPU: P4 / Xeon, speed 3402.13 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not 
stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
848185    8.3510  __copy_to_user_ll
772172    7.6026  do_anonymous_page
701579    6.9076  _spin_lock_irq
579024    5.7009  __copy_user_intel
361634    3.5606  _spin_lock
343018    3.3773  _spin_lock_irqsave
307462    3.0272  kmap_atomic
193327    1.9035  page_fault
181040    1.7825  schedule
174502    1.7181  radix_tree_delete
158967    1.5652  end_buffer_async_read
124124    1.2221  free_hot_cold_page
119057    1.1722  sysenter_past_esp
117384    1.1557  shrink_list
112762    1.1102  buffered_rmqueue
105490    1.0386  smp_call_function
101568    1.0000  kmem_cache_alloc
97404     0.9590  kmem_cache_free
95826     0.9435  __rmqueue
95443     0.9397  __copy_from_user_ll
93181     0.9174  free_pages_bulk
92732     0.9130  release_pages
86912     0.8557  shrink_cache
85896     0.8457  block_read_full_page
79629     0.7840  free_block
78304     0.7710  mempool_free
72264     0.7115  create_empty_buffers
71303     0.7020  do_syslog
70769     0.6968  emit_log_char
66413     0.6539  mark_offset_tsc
64333     0.6334  vprintk
63468     0.6249  file_read_actor
63292     0.6232  add_to_page_cache
62281     0.6132  unlock_page
61655     0.6070  _spin_unlock_irqrestore
59486     0.5857  find_get_page
58901     0.5799  drop_buffers
58775     0.5787  do_generic_mapping_read
55070     0.5422  __wake_up_bit
48681     0.4793  __end_that_request_first
47121     0.4639  bad_range
47102     0.4638  submit_bh
45009     0.4431  journal_add_journal_head
41270     0.4063  __alloc_pages
41247     0.4061  page_waitqueue
39520     0.3891  generic_file_buffered_write
38520     0.3793  __pagevec_lru_add
38142     0.3755  do_select
38105     0.3752  do_mpage_readpage
37020     0.3645  vsnprintf
36541     0.3598  __clear_page_buffers
35932     0.3538  journal_put_journal_head
35769     0.3522  radix_tree_lookup
35636     0.3509  bio_put
34904     0.3437  jfs_get_blocks
34865     0.3433  mark_page_accessed
33686     0.3317  bio_alloc
33273     0.3276  __switch_to
32928     0.3242  __generic_file_aio_write_nolock
32781     0.3228  mempool_alloc
31457     0.3097  number
31160     0.3068  do_get_write_access
30922     0.3045  sys_select
30201     0.2974  blk_rq_map_sg
29488     0.2903  smp_call_function_interrupt
28815     0.2837  do_page_fault
27654     0.2723  radix_tree_insert
27650     0.2722  __block_prepare_write
27185     0.2677  cache_alloc_refill
26910     0.2649  page_remove_rmap
26378     0.2597  handle_mm_fault
26192     0.2579  invalidate_complete_page
25762     0.2536  page_add_anon_rmap
25580     0.2519  max_block
25497     0.2510  do_gettimeofday

