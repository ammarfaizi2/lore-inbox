Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265157AbUEMWaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265157AbUEMWaX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 18:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbUEMWaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 18:30:23 -0400
Received: from main.gmane.org ([80.91.224.249]:2789 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265157AbUEMW37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 18:29:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: Slow IDE disk write performance with 2.6.6-bk1 on tyan S2882 dual
 proc opteron
Date: Thu, 13 May 2004 16:29:43 -0600
Message-ID: <c80ssq$cn7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cynosure.colorado-research.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm testing out a brand new dual processor Opteron 244 system with 4GB 
RAM and Tyan S2882 motherboard and finding slow performance writing to 
the IDE disk.  Install is 64-bit Fedora Core 2 Test 3 with the latest 
development updates.  I've seen similar performance with the standard 
Fedora kernel and the 2.6.6 kernel, as well as the 2.6.6-bk1 kernel 
which these reported results are from.  I've also tried "acpi=off" 
without much effect, though I didn't disable acpi in the bios.

The following script:

opcontrol --start
dd if=/dev/zero of=/dev/hda8 bs=1M count=5000
sync
opcontrol --stop

takes the following time:

real    10m59.788s
user    0m0.077s
sys     0m22.934s

or about 7.6 MB/s which seems quite slow.

bonnie++ to an ext3 filesystem reports 16590 KB/s writing and 43606 KB/s 
reading.

hdparm -t /dev/hda reports about 40MB/s reading, so it seems to be a 
write issue.

/dev/hda:
  multcount    = 16 (on)
  IO_support   =  1 (32-bit)
  unmaskirq    =  1 (on)
  using_dma    =  1 (on)
  keepsettings =  0 (off)
  readonly     =  0 (off)
  readahead    = 256 (on)
  geometry     = 16383/255/63, sectors = 156301488, start = 0


oprofile of the test scripts gives (I hope this is useful, I've never 
run oprofile before):

CPU: AMD64 processors, speed 1792.39 MHz (estimated)
Counted RETIRED_INSNS events (Retired instructions (includes exceptions, 
interrupts, re-syncs)) with a unit mask of 0x00 (No unit mask) count 100000
RETIRED_INSNS:...|
   samples|      %|
------------------
  19896771 99.6125 vmlinux-2.6.6-bk1
     65018  0.3255 oprofiled
     11850  0.0593 oprofile
       235  0.0012 libc-2.3.3.so
       115 5.8e-04 bash
        54 2.7e-04 ld-2.3.3.so
        47 2.4e-04 ext3
        36 1.8e-04 jbd

samples  %        symbol name
19654156 98.7806  poll_idle
12981     0.0652  free_block
10297     0.0518  mempool_alloc
9860      0.0496  kmem_cache_alloc
9439      0.0474  __make_request
8722      0.0438  rb_next
8498      0.0427  ll_back_merge_fn
8380      0.0421  as_merge
7716      0.0388  .text.lock.char_dev
7578      0.0381  __block_prepare_write
7370      0.0370  .text.lock.ll_rw_blk
7209      0.0362  __block_write_full_page
6908      0.0347  kmem_cache_free
6270      0.0315  end_buffer_async_write
5973      0.0300  blk_rq_map_sg
5614      0.0282  blk_recount_segments
4866      0.0245  generic_make_request
4865      0.0245  cache_alloc_refill
4762      0.0239  mempool_free
4649      0.0234  submit_bio
4131      0.0208  as_merged_request
3835      0.0193  bio_alloc
3084      0.0155  as_latter_request
2903      0.0146  drop_buffers
2659      0.0134  radix_tree_delete
2532      0.0127  init_buffer_head
2335      0.0117  wake_up_buffer
1976      0.0099  __delay
1940      0.0098  buffered_rmqueue
1858      0.0093  __block_commit_write
1816      0.0091  radix_tree_tag_set
1813      0.0091  radix_tree_tag_clear
1759      0.0088  free_pages_bulk
1742      0.0088  end_bio_bh_io_sync
1736      0.0087  __rmqueue
1731      0.0087  drive_stat_acct
1620      0.0081  __set_page_dirty_nobuffers
1535      0.0077  create_buffers
1517      0.0076  radix_tree_insert
1447      0.0073  as_add_arq_hash
1360      0.0068  shrink_list
1335      0.0067  generic_file_aio_write_nolock
1329      0.0067  elv_latter_request
1305      0.0066  test_set_page_writeback
1271      0.0064  free_hot_cold_page
1269      0.0064  shrink_cache
1257      0.0063  cache_init_objs
1247      0.0063  page_waitqueue
1239      0.0062  release_pages
1228      0.0062  submit_bh
1210      0.0061  bio_endio
1168      0.0059  __end_that_request_first
1163      0.0058  mempool_free_slab
1153      0.0058  blkdev_get_block
1091      0.0055  elv_try_last_merge
1065      0.0054  unlock_page

System info:

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 
03) (prog-if 8a [Master SecP PriP])
         Subsystem: Advanced Micro Devices [AMD] AMD-8111 IDE
         Flags: bus master, medium devsel, latency 32
         I/O ports at ffa0 [size=16]

Disk is a WDC WD800JB-00ETA0

----------AMD BusMastering IDE Configuration----------------
Driver Version:                     2.13
South Bridge:                       0000:00:07.1
Revision:                           IDE 0x3
Highest DMA rate:                   UDMA133
BM-DMA base:                        0xffa0
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       PIO       PIO
Address Setup:       30ns     120ns     120ns     120ns
Cmd Active:          90ns      90ns     480ns     480ns
Cmd Recovery:        30ns      30ns     480ns     480ns
Data Active:         90ns     330ns     330ns     330ns
Data Recovery:       30ns     270ns     270ns     270ns
Cycle Time:          20ns     600ns     600ns     600ns
Transfer Rate:   99.9MB/s   3.3MB/s   3.3MB/s   3.3MB/s


Any help would be greatly appreciated.

- Orion

