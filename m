Return-Path: <SRS0=jlnN=ZZ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D6DC432C0
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 00:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2596C206E0
	for <io-uring@archiver.kernel.org>; Tue,  3 Dec 2019 00:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ais5o252"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfLCAdm (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Dec 2019 19:33:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36514 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLCAdm (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 2 Dec 2019 19:33:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB30TSX5186129;
        Tue, 3 Dec 2019 00:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=7gERDObCjaTUnFdyYPfe1vBXRcexsXuAkg7CwG3NUmM=;
 b=ais5o252DKTLZ22BobMs1P0JMSMtdtLOPJzvRpm9Ifdl1neKV19O+oLLpy96Re+5PAjd
 gQrSGy6h3EgsVhzrUKLURmP+kuCPfG9NznvfuyLUxWoDgCxDTAL1v+dIUJxcWikxkjIR
 VwTrbAPogzmSSsypeWPAaXgBi+17SeZo0BIZ2W97TSQ0Y8pIaAW77t7sRZEEpCtc78l2
 5dx/HUQ97nNWpsS2qEnxyZzMOu3ttHPXTgu1crFb7D59FkbuQus/xvY0apM+cQsKvd1q
 5QmxhE5cTlz3SRZPSKs4Whet3ECVF4w0Yw4V3bGWCshnKOkZDzXwukb2wEYqiqT6UVby 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wkfuu3up8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 00:33:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB30XV3I132603;
        Tue, 3 Dec 2019 00:33:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wn7pnsd4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 00:33:38 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB30Wtj7014444;
        Tue, 3 Dec 2019 00:32:55 GMT
Received: from [10.154.112.74] (/10.154.112.74)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 16:32:55 -0800
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
Subject: Kernel NULL pointer dereference when handling polled completions
Message-ID: <c227e217-9253-8cc5-9ee4-e938cc68f589@oracle.com>
Date:   Mon, 2 Dec 2019 16:32:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus: Avast (VPS 191201-0, 11/30/2019), Outbound message
X-Antivirus-Status: Clean
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030003
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi Jens,

Running the fio script included below crashes the system pretty 
consistently with different stack traces. One way to reproduce is to run 
the script twice, first time for 10 seconds, and then an arbitrary 
amount.  The second run crashes almost immediately.

Included stack trace below is one instance for v5.4-rc8.

Backing out the commit below as a workaround changes the behavior 
depending on the number of polled queues configured; either no further 
crash is seen, or a crash happens only after an nvme interrupt.  This 
behavior is not consistent, e.g., with 5+2 queues, the crash happened 
once after an nvme interrupt but didn't happen again the next time 
because no nvme interrupt was fielded.  I haven't figured out the cause 
of of the interrupt.

ncpu nvme.poll_queue hctx type          panic
                      polled+default
---- --------------- -----------------  -----
16   2               2+5                n
16   4               4+3                n
16   5               5+2                y
16   6               6+1                y
16   8               6+1                y
16   16              6+1                y

I don't understand a couple of things about the commit:

1. The assertion in the commit that for a polled request, we're by 
definition on the correct cpu:

IIUC, below is the path from blk_poll() to completion in block layer.  
First, I don't understand why the cpu issuing a request is necessarily 
the cpu that issues the poll, if that is indeed what the commit 
asserts.  Second, nvme_complete_cqes() may return more than one 
completion and I don't see how they would all have been issued from the 
same cpu.

blk_poll()
-> nvme_poll()
    -> nvme_complete_cqes()
       -> nvme_handle_cqe()
          -> nvme_end_request()
             -> blk_mq_complete_request()

2. I suspected that we eventually get in trouble in blk_mq_put_tag() 
when ctx->cpu != <current-cpu>
    however, that doesn't seem to be necessarily the case. I added an 
assertion to check for that;
    the assertion fails for scsi devices but not for nvme. I'm not clear 
as to what causes the crash.

===============================================

commit 4ab32bf3305eedb4d31f85cac68a67becab10494
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sun Nov 18 16:15:35 2018 -0700

     blk-mq: never redirect polled IO completions

     It's pointless to do so, we are by definition on the CPU we want/need
     to be, as that's the one waiting for a completion event.

     Reviewed-by: Christoph Hellwig <hch@lst.de>
     Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ba3c7b6..37674c1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -585,7 +585,12 @@ static void __blk_mq_complete_request(struct 
request *rq)
                 return;
         }

-       if (!test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
+       /*
+        * For a polled request, always complete locallly, it's pointless
+        * to redirect the completion.
+        */
+       if ((rq->cmd_flags & REQ_HIPRI) ||
+           !test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
                 q->mq_ops->complete(rq);
                 return;
         }

===============================================

CPU(s):              16
On-line CPU(s) list: 0-15
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s):           16
NUMA node(s):        1

hctx0/type:default
hctx1/type:poll
hctx2/type:poll
hctx3/type:poll
hctx4/type:poll
hctx5/type:poll
hctx6/type:poll

===============================================

fio nvme.fio --readonly --ioengine=io_uring --iodepth 1024 --fixedbufs 
--hipri --numjobs=16 --runtime=$runtime

[root@ol0 fio]# cat nvme.fio
[global]
filename=/dev/nvme0n1
rw=randread
bs=256k
direct=1
time_based=1
randrepeat=1
gtod_reduce=1
[fiotest]

===============================================

Starting 16 processes
[   89.900361] nvme 0000:00:04.0: dma_pool_free prp list page, 
0000000014f1fdca (bad vaddr)/0x000000022cdc5000
[   89.902928] nvme 0000:00:04.0: dma_pool_free prp list page, 
000000004ede1b13 (bad vaddr)/0x00000000ba4fb000
[   89.904128] nvme 0000:00:04.0: dma_pool_free prp list page, 
00000000d5bfd017 (bad vaddr)/0x00000001ffec1000
[   89.909407] nvme 0000:00:04.0: dma_pool_free prp list page, 
0000000015082637 (bad vaddr)/0x00000000aebad000
[   89.915723] nvme 0000:00:04.0: dma_pool_free prp list page, 
000000006eca5095 (bad vaddr)/0x00000000ba4fb000
[   89.918419] nvme 0000:00:04.0: dma_pool_free prp list page, 
00000000afad264b (bad vaddr)/0x00000000ba570000
[   89.919732] ------------[ cut here ]------------
[   89.919739] WARNING: CPU: 13 PID: 11642 at block/blk-mq.c:691 
blk_mq_start_request+0xa8/0x130
[   89.919740] Modules linked in: xfs dm_mod sr_mod sd_mod cdrom 
crc32c_intel ata_piix nvme nvme_core e1000 libata virtio_pci 
9pnet_virtio virtio_ring virtio 9p 9pnet
[   89.919753] CPU: 13 PID: 11642 Comm: fio Not tainted 5.4.0-rc8-bij #239
[   89.919754] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   89.919756] RIP: 0010:blk_mq_start_request+0xa8/0x130
[   89.919758] Code: 00 00 02 00 c1 e8 09 66 89 85 c0 00 00 00 49 8b 7c 
24 18 48 85 ff 74 08 48 89 ee e8 22 2f 01 00 8b 85 d0 00 00 00 85 c0 74 
02 <0f> 0b 48 89 ef e8 2e ee ff ff c7 85 d0 00 00 00 01 00 00 00 41 8b
[   89.919760] RSP: 0018:ffffc90003a1b808 EFLAGS: 00010202
[   89.919761] RAX: 0000000000000002 RBX: ffff888227e74980 RCX: 
0000000000000017
[   89.919763] RDX: 0000062d73000000 RSI: 00000000000c5ae6 RDI: 
0000000000000000
[   89.919764] RBP: ffff888227e74980 R08: 00000000df1b118a R09: 
0000000038bf4c20
[   89.919765] R10: ffffffff82523348 R11: 0000000000000000 R12: 
ffff88822826ee78
[   89.919766] R13: ffff888229c84000 R14: 0000000000000001 R15: 
0000000000000000
[   89.919768] FS:  00007fe8ce9e6740(0000) GS:ffff888236000000(0000) 
knlGS:0000000000000000
[   89.919769] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   89.919770] CR2: 00007f1c48000010 CR3: 000000014f6b6005 CR4: 
0000000000160ee0
[   89.919774] Call Trace:
[   89.919780]  nvme_queue_rq+0x5c1/0x6f0 [nvme]
[   89.919785]  ? __lock_acquire.isra.24+0x526/0x6c0
[   89.919794]  __blk_mq_try_issue_directly+0x120/0x1f0
[   89.919797]  ? __blk_mq_requeue_request+0x81/0x120
[   89.919801]  blk_mq_try_issue_directly+0x57/0xb0
[   89.919804]  blk_mq_make_request+0x4fe/0x650
[   89.919815]  generic_make_request+0xfb/0x300
[   89.919822]  submit_bio+0x136/0x180
[   89.919829]  blkdev_direct_IO+0x421/0x460
[   89.919837]  ? filemap_range_has_page+0xd4/0x110
[   89.919838]  ? filemap_range_has_page+0x68/0x110
[   89.919844]  generic_file_read_iter+0xde/0xc80
[   89.919847]  ? deactivate_slab.isra.68+0x5ee/0x660
[   89.919856]  ? _cond_resched+0x20/0x30
[   89.919867]  io_read+0xf2/0x1d0
[   89.919875]  ? io_get_req+0xa7/0x1a0
lock_read+0xd/0x20kvm_sJobchesd: _16 c(f=16)
[   89.919883]  ? __lock_acquire.isra.24+0x526/0x6c0
[   89.919886]  ? io_get_req+0xa7/0x1a0
[   89.919890]  __io_submit_sqe+0xb8/0x920
[   89.919893]  ? __fget+0xc4/0xf0
[   89.919902]  __io_queue_sqe+0x22/0x230
[   89.919907]  io_ring_submit+0x14b/0x1d0
[   89.919911]  ? startup_64+0x1/0x30
[   89.919914]  ? __lock_acquire.isra.24+0x526/0x6c0
[   89.919917]  ? __x64_sys_io_uring_enter+0x192/0x3a0
[   89.919920]  ? kvm_sched_clock_read+0xd/0x20
[   89.919923]  ? __x64_sys_io_uring_enter+0xf5/0x3a0
[   89.919929]  __x64_sys_io_uring_enter+0x1a0/0x3a0
[   89.919931]  ? __x64_sys_io_uring_enter+0x7b/0x3a0
[   89.919939]  do_syscall_64+0x63/0x190
[   89.919942]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   89.919944] RIP: 0033:0x7fe8cd9322cd
[   89.919946] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 6b 2c 00 f7 d8 64 89 01 48
[   89.919947] RSP: 002b:00007fff969c6e58 EFLAGS: 00000246 ORIG_RAX: 
00000000000001aa
[   89.919949] RAX: ffffffffffffffda RBX: 00007fe8ac5e0380 RCX: 
00007fe8cd9322cd
[   89.919950] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
0000000000000003
[   89.919951] RBP: 00007fe8ac5e0380 R08: 0000000000000000 R09: 
0000000000000000
[   89.919952] R10: 0000000000000001 R11: 0000000000000246 R12: 
00000000015aa650
[   89.919953] R13: 000000000000045b R14: 0000000000000001 R15: 
00000000016239e8
[   89.919963] ---[ end trace 1291613dbce4882d ]---
[   89.921145] general protection fault: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
[   89.925168] nvme 0000:00:04.0: dma_pool_free prp list page, 
0000000036c5e549 (bad vaddr)/0x00000000ba711000
[   89.927152] CPU: 1 PID: 11648 Comm: fio Tainted: G W         
5.4.0-rc8-bij #239
[   89.927153] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   89.927158] RIP: 0010:nvme_unmap_data+0x195/0x1e0 [nvme]
[   89.927160] Code: 75 0b 0f b7 83 c2 00 00 00 48 c1 e0 05 80 bb 40 01 
00 00 00 48 63 d5 49 8d 14 d1 48 8b 34 02 74 09 4c 8b b6 f0 0f 00 00 eb 
04 <4e> 8b 34 26 49 8b bf 58 02 00 00 4c 89 ea 83 c5 01 e8 15 27 16 e1
[   89.927162] RSP: 0018:ffffc90003a3bc78 EFLAGS: 00010246
[   89.931106] nvme 0000:00:04.0: dma_pool_free prp list page, 
0000000036a1920d (bad vaddr)/0x00000000860dd000
[   89.935299] RAX: 0000000000000020 RBX: ffff888227e74b00 RCX: 
0000000000000002
[   89.935300] RDX: ffff8880889a0000 RSI: 6b6b6b6b6b6b6b6b RDI: 
ffff8880889a0000
[   89.935301] RBP: 0000000000000000 R08: 0000000000000000 R09: 
ffff8880889a0000
[   89.935302] R10: ffffffff82474820 R11: 0000000000000000 R12: 
0000000000000ff8
[   89.935302] R13: 0000000087a06000 R14: ffff888229c2bfc0 R15: 
ffff888229c84000
[   89.935304] FS:  00007fe8ce9e6740(0000) GS:ffff888233000000(0000) 
knlGS:0000000000000000
[   89.937418] nvme 0000:00:04.0: dma_pool_free prp list page, 
00000000bb87bc5d (bad vaddr)/0x00000000ba7e6000
[   89.940622] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   89.940623] CR2: 00007ffd39009ee8 CR3: 00000001f762c003 CR4: 
0000000000160ee0
[   89.940628] Call Trace:
[   90.069935]  nvme_pci_complete_rq+0xa5/0xb0 [nvme]
[   90.071596]  blk_mq_complete_request+0x47/0xf0
[   90.073930]  nvme_poll+0x23f/0x2d0 [nvme]
[   90.075126]  blk_poll+0x24f/0x320
[   90.075970]  ? __lock_acquire.isra.24+0x526/0x6c0
[   90.077700]  ? find_held_lock+0x3c/0xa0
[   90.079921]  io_iopoll_getevents+0x115/0x380
[   90.081421]  ? __x64_sys_io_uring_enter+0x1ff/0x3a0
[   90.082481]  __io_iopoll_check+0x7e/0xb0
[   90.083746]  __x64_sys_io_uring_enter+0x20f/0x3a0
[   90.085057]  ? __x64_sys_io_uring_enter+0x7b/0x3a0
[   90.086581]  do_syscall_64+0x63/0x190
[   90.087439]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   90.089021] RIP: 0033:0x7fe8cd9322cd
[   90.090289] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 6b 2c 00 f7 d8 64 89 01 48
[   90.096453] RSP: 002b:00007fff969c6e58 EFLAGS: 00000246 ORIG_RAX: 
00000000000001aa
[   90.100486] RAX: ffffffffffffffda RBX: 00007fe8ac62b500 RCX: 
00007fe8cd9322cd
[   90.103876] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
0000000000000003
[   90.107465] RBP: 00007fe8ac62b500 R08: 0000000000000000 R09: 
0000000000000000
[   90.109534] R10: 0000000000000001 R11: 0000000000000246 R12: 
00000000015aa6b0
[   90.111646] R13: 000000000000041d R14: 0000000000000001 R15: 
00000000016239e8
[   90.113565] Modules linked in: xfs dm_mod sr_mod sd_mod cdrom 
crc32c_intel ata_piix nvme nvme_core e1000 libata virtio_pci 
9pnet_virtio virtio_ring virtio 9p 9pnet
[   90.120274] BUG: kernel NULL pointer dereference, address: 
0000000000000018
[   90.120299] ---[ end trace 1291613dbce4882e ]---
[   90.121996] #PF: supervisor read access in kernel mode
[   90.121997] #PF: error_code(0x0000) - not-present page
[   90.121999] PGD 800000020d551067 P4D 800000020d551067 PUD 1f5b59067 PMD 0
[   90.123685] RIP: 0010:nvme_unmap_data+0x195/0x1e0 [nvme]
[   90.125161] Oops: 0000 [#2] SMP DEBUG_PAGEALLOC PTI
[   90.125164] CPU: 4 PID: 11635 Comm: fio Tainted: G      D W         
5.4.0-rc8-bij #239
[   90.125165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   90.125170] RIP: 0010:dma_direct_unmap_sg+0x24/0x60
[   90.127022] Code: 75 0b 0f b7 83 c2 00 00 00 48 c1 e0 05 80 bb 40 01 
00 00 00 48 63 d5 49 8d 14 d1 48 8b 34 02 74 09 4c 8b b6 f0 0f 00 00 eb 
04 <4e> 8b 34 26 49 8b bf 58 02 00 00 4c 89 ea 83 c5 01 e8 15 27 16 e1
[   90.129164] Code: 84 00 00 00 00 00 0f 1f 44 00 00 41 57 49 89 ff 41 
56 41 89 ce 41 55 4d 89 c5 41 54 41 89 d4 55 31 ed 85 d2 53 48 89 f3 7e 
28 <8b> 53 18 48 8b 73 10 4d 89 e8 44 89 f1 4c 89 ff 83 c5 01 e8 44 ff
[   90.129165] RSP: 0018:ffffc900039e3c40 EFLAGS: 00010297
[   90.129166] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000002
[   90.129167] RDX: 00000000fffffff5 RSI: 00000000015f6240 RDI: 
ffff888080692000
[   90.129168] RBP: 0000000000000001 R08: 0000000000000000 R09: 
ffff888080692000
[   90.129168] R10: ffff8880840e3180 R11: 0000000000000001 R12: 
0000000000000002
[   90.129170] R13: 0000000000000000 R14: 0000000000000002 R15: 
ffff88823156c0b0
[   90.130470] RSP: 0018:ffffc90003a3bc78 EFLAGS: 00010246
[   90.131648] FS:  00007fe8ce9e6740(0000) GS:ffff888233c00000(0000) 
knlGS:0000000000000000
[   90.131649] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.131650] CR2: 0000000000000018 CR3: 000000014f40a005 CR4: 
0000000000160ee0
[   90.131653] Call Trace:
[   90.131659]  nvme_unmap_data+0xd3/0x1e0 [nvme]
[   90.133524] RAX: 0000000000000020 RBX: ffff888227e74b00 RCX: 
0000000000000002
[   90.138027]  nvme_pci_complete_rq+0xa5/0xb0 [nvme]
[   90.138030]  blk_mq_complete_request+0x47/0xf0
[   90.138032]  nvme_poll+0x23f/0x2d0 [nvme]
[   90.138035]  blk_poll+0x24f/0x320
[   90.140849] RDX: ffff8880889a0000 RSI: 6b6b6b6b6b6b6b6b RDI: 
ffff8880889a0000
[   90.149719]  io_iopoll_getevents+0x115/0x380
[   90.149724]  ? __x64_sys_io_uring_enter+0x1ff/0x3a0
[   90.157698] RBP: 0000000000000000 R08: 0000000000000000 R09: 
ffff8880889a0000
[   90.159687]  __io_iopoll_check+0x7e/0xb0
[   90.159690]  __x64_sys_io_uring_enter+0x20f/0x3a0
[   90.159693]  ? __x64_sys_io_uring_enter+0x7b/0x3a0
[   90.162169] R10: ffffffff82474820 R11: 0000000000000000 R12: 
0000000000000ff8
[   90.164904]  do_syscall_64+0x63/0x190
[   90.164909]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   90.167636] R13: 0000000087a06000 R14: ffff888229c2bfc0 R15: 
ffff888229c84000
[   90.169801] RIP: 0033:0x7fe8cd9322cd
[   90.169803] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 6b 2c 00 f7 d8 64 89 01 48
[   90.169804] RSP: 002b:00007fff969c6e58 EFLAGS: 00000246 ORIG_RAX: 
00000000000001aa
[   90.169805] RAX: ffffffffffffffda RBX: 00007fe8ac563100 RCX: 
00007fe8cd9322cd
[   90.169807] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
0000000000000003
[   90.171677] FS:  00007fe8ce9e6740(0000) GS:ffff888233000000(0000) 
knlGS:0000000000000000
[   90.173570] RBP: 00007fe8ac563100 R08: 0000000000000000 R09: 
0000000000000000
[   90.173571] R10: 0000000000000001 R11: 0000000000000246 R12: 
00000000015aa5b0
[   90.173572] R13: 00000000000004b8 R14: 0000000000000001 R15: 
00000000016132a8
[   90.173586] Modules linked in: xfs dm_mod sr_mod sd_mod cdrom 
crc32c_intel ata_piix nvme nvme_core e1000 libata virtio_pci 
9pnet_virtio virtio_ring virtio 9p 9pnet
[   90.175708] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.177131] CR2: 0000000000000018
[   90.177146] general protection fault: 0000 [#3] SMP DEBUG_PAGEALLOC PTI
[   90.177164] ---[ end trace 1291613dbce4882f ]---
[   90.177167] RIP: 0010:nvme_unmap_data+0x195/0x1e0 [nvme]
[   90.177168] Code: 75 0b 0f b7 83 c2 00 00 00 48 c1 e0 05 80 bb 40 01 
00 00 00 48 63 d5 49 8d 14 d1 48 8b 34 02 74 09 4c 8b b6 f0 0f 00 00 eb 
04 <4e> 8b 34 26 49 8b bf 58 02 00 00 4c 89 ea 83 c5 01 e8 15 27 16 e1
[   90.177170] RSP: 0018:ffffc90003a3bc78 EFLAGS: 00010246
[   90.177171] RAX: 0000000000000020 RBX: ffff888227e74b00 RCX: 
0000000000000002
[   90.177172] RDX: ffff8880889a0000 RSI: 6b6b6b6b6b6b6b6b RDI: 
ffff8880889a0000
[   90.177172] RBP: 0000000000000000 R08: 0000000000000000 R09: 
ffff8880889a0000
[   90.177173] R10: ffffffff82474820 R11: 0000000000000000 R12: 
0000000000000ff8
[   90.177174] R13: 0000000087a06000 R14: ffff888229c2bfc0 R15: 
ffff888229c84000
[   90.177175] FS:  00007fe8ce9e6740(0000) GS:ffff888233c00000(0000) 
knlGS:0000000000000000
[   90.177176] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.177176] CR2: 0000000000000018 CR3: 000000014f40a005 CR4: 
0000000000160ee0
[   90.177180] Kernel panic - not syncing: Fatal exception
[   90.229437] CPU: 7 PID: 11645 Comm: fio Tainted: G      D W         
5.4.0-rc8-bij #239
[   90.230829] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   90.232837] RIP: 0010:nvme_unmap_data+0x195/0x1e0 [nvme]
[   90.233780] Code: 75 0b 0f b7 83 c2 00 00 00 48 c1 e0 05 80 bb 40 01 
00 00 00 48 63 d5 49 8d 14 d1 48 8b 34 02 74 09 4c 8b b6 f0 0f 00 00 eb 
04 <4e> 8b 34 26 49 8b bf 58 02 00 00 4c 89 ea 83 c5 01 e8 15 27 16 e1
[   90.237066] RSP: 0018:ffffc90003a23c78 EFLAGS: 00010246
[   90.237992] RAX: 0000000000000020 RBX: ffff888227e65580 RCX: 
0000000000000002
[   90.239251] RDX: ffff88808482c000 RSI: 6b6b6b6b6b6b6b6b RDI: 
ffff88808482c000
[   90.240504] RBP: 0000000000000000 R08: 0000000000000000 R09: 
ffff88808482c000
[   90.241761] R10: 0000000000000000 R11: 000000000000000a R12: 
0000000000000ff8
[   90.243015] R13: 000000008b9db000 R14: ffff888229c2bef0 R15: 
ffff888229c84000
[   90.244281] FS:  00007fe8ce9e6740(0000) GS:ffff888234800000(0000) 
knlGS:0000000000000000
[   90.245703] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.246721] CR2: 00007fe72b255e70 CR3: 00000001024c2005 CR4: 
0000000000160ee0
[   90.247982] Call Trace:
[   90.248437]  nvme_pci_complete_rq+0xa5/0xb0 [nvme]
[   90.249291]  blk_mq_complete_request+0x47/0xf0
[   90.250080]  nvme_poll+0x23f/0x2d0 [nvme]
[   90.250797]  blk_poll+0x24f/0x320
[   90.251395]  ? __lock_acquire.isra.24+0x526/0x6c0
[   90.252224]  ? find_held_lock+0x3c/0xa0
[   90.252914]  io_iopoll_getevents+0x115/0x380
[   90.253674]  ? __x64_sys_io_uring_enter+0x1ff/0x3a0
[   90.254540]  __io_iopoll_check+0x7e/0xb0
[   90.255235]  __x64_sys_io_uring_enter+0x20f/0x3a0
[   90.256066]  ? __x64_sys_io_uring_enter+0x7b/0x3a0
[   90.256915]  do_syscall_64+0x63/0x190
[   90.257568]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   90.258455] RIP: 0033:0x7fe8cd9322cd
[   90.259088] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 6b 2c 00 f7 d8 64 89 01 48
[   90.262350] RSP: 002b:00007fff969c6e58 EFLAGS: 00000246 ORIG_RAX: 
00000000000001aa
[   90.263676] RAX: ffffffffffffffda RBX: 00007fe8ac5f9400 RCX: 
00007fe8cd9322cd
[   90.264924] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
0000000000000003
[   90.266177] RBP: 00007fe8ac5f9400 R08: 0000000000000000 R09: 
0000000000000000
[   90.267431] R10: 0000000000000001 R11: 0000000000000246 R12: 
00000000015aa670
[   90.268683] R13: 000000000000048d R14: 0000000000000001 R15: 
000000000161c728
[   90.269939] Modules linked in: xfs dm_mod sr_mod sd_mod cdrom 
crc32c_intel ata_piix nvme nvme_core e1000 libata virtio_pci 
9pnet_virtio virtio_ring virtio 9p 9pnet
[   90.272508] general protection fault: 0000 [#4] SMP DEBUG_PAGEALLOC PTI
[   90.273727] CPU: 15 PID: 11634 Comm: fio Tainted: G      D W         
5.4.0-rc8-bij #239
[   90.275153] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   90.277176] RIP: 0010:nvme_unmap_data+0x195/0x1e0 [nvme]
[   90.278130] Code: 75 0b 0f b7 83 c2 00 00 00 48 c1 e0 05 80 bb 40 01 
00 00 00 48 63 d5 49 8d 14 d1 48 8b 34 02 74 09 4c 8b b6 f0 0f 00 00 eb 
04 <4e> 8b 34 26 49 8b bf 58 02 00 00 4c 89 ea 83 c5 01 e8 15 27 16 e1
[   90.281426] RSP: 0018:ffffc900039dbc78 EFLAGS: 00010246
[   90.282359] RAX: 0000000000000020 RBX: ffff888227efe400 RCX: 
0000000000000002
[   90.283623] RDX: ffff88808b8d4000 RSI: 6b6b6b6b6b6b6b6b RDI: 
ffff88808b8d4000
[   90.284886] RBP: 0000000000000000 R08: 0000000000000000 R09: 
ffff88808b8d4000
[   90.286152] R10: ffff888085dbc240 R11: 0000000000000001 R12: 
0000000000000ff8
[   90.287420] R13: 0000000084eeb000 R14: ffff88822829a6f0 R15: 
ffff888229c84000
[   90.288686] FS:  00007fe8ce9e6740(0000) GS:ffff888236800000(0000) 
knlGS:0000000000000000
[   90.290120] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.291142] CR2: 00007f1c40005168 CR3: 000000020ef68004 CR4: 
0000000000160ee0
[   90.292410] Call Trace:
[   90.292860]  nvme_pci_complete_rq+0xa5/0xb0 [nvme]
[   90.293718]  blk_mq_complete_request+0x47/0xf0
[   90.294518]  nvme_poll+0x23f/0x2d0 [nvme]
[   90.295242]  blk_poll+0x24f/0x320
[   90.295845]  io_iopoll_getevents+0x115/0x380
[   90.296617]  ? __x64_sys_io_uring_enter+0x1ff/0x3a0
[   90.297493]  __io_iopoll_check+0x7e/0xb0
[   90.298199]  __x64_sys_io_uring_enter+0x20f/0x3a0
[   90.299047]  ? __x64_sys_io_uring_enter+0x7b/0x3a0
[   90.299911]  do_syscall_64+0x63/0x190
[   90.300581]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   90.301487] RIP: 0033:0x7fe8cd9322cd
[   90.302137] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 6b 2c 00 f7 d8 64 89 01 48
[   90.305446] RSP: 002b:00007fff969c6e58 EFLAGS: 00000246 ORIG_RAX: 
00000000000001aa
[   90.306790] RAX: ffffffffffffffda RBX: 00007fe8ac54a080 RCX: 
00007fe8cd9322cd
[   90.308060] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
0000000000000003
[   90.309323] RBP: 00007fe8ac54a080 R08: 0000000000000000 R09: 
0000000000000000
[   90.310583] R10: 0000000000000001 R11: 0000000000000246 R12: 
00000000015aa590
[   90.311836] R13: 000000000000052e R14: 0000000000000001 R15: 
0000000001606b68
[   90.313095] Modules linked in: xfs dm_mod sr_mod sd_mod cdrom 
crc32c_intel ata_piix nvme nvme_core e1000 libata virtio_pci 
9pnet_virtio virtio_ring virtio 9p 9pnet
[   90.315667] general protection fault: 0000 [#5] SMP DEBUG_PAGEALLOC PTI
[   90.316859] CPU: 9 PID: 11633 Comm: fio Tainted: G      D W         
5.4.0-rc8-bij #239
[   90.318248] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   90.320248] RIP: 0010:nvme_unmap_data+0x195/0x1e0 [nvme]
[   90.321188] Code: 75 0b 0f b7 83 c2 00 00 00 48 c1 e0 05 80 bb 40 01 
00 00 00 48 63 d5 49 8d 14 d1 48 8b 34 02 74 09 4c 8b b6 f0 0f 00 00 eb 
04 <4e> 8b 34 26 49 8b bf 58 02 00 00 4c 89 ea 83 c5 01 e8 15 27 16 e1
[   90.324456] RSP: 0018:ffffc90003517c78 EFLAGS: 00010246
[   90.325380] RAX: 0000000000000020 RBX: ffff888227efe580 RCX: 
0000000000000002
[   90.326636] RDX: ffff8880867ce000 RSI: 6b6b6b6b6b6b6b6b RDI: 
ffff8880867ce000
[   90.327891] RBP: 0000000000000000 R08: 0000000000000000 R09: 
ffff8880867ce000
[   90.329146] R10: ffff8880874ea1c0 R11: 0000000000000001 R12: 
0000000000000ff8
[   90.330408] R13: 0000000082019000 R14: ffff88822829a680 R15: 
ffff888229c84000
[   90.331669] FS:  00007fe8ce9e6740(0000) GS:ffff888235000000(0000) 
knlGS:0000000000000000
[   90.333090] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.334110] CR2: 00007f2b3c0013c8 CR3: 00000002047e8003 CR4: 
0000000000160ee0
[   90.335372] Call Trace:
[   90.335818]  nvme_pci_complete_rq+0xa5/0xb0 [nvme]
[   90.336672]  blk_mq_complete_request+0x47/0xf0
[   90.337462]  nvme_poll+0x23f/0x2d0 [nvme]
[   90.338173]  blk_poll+0x24f/0x320
[   90.338775]  io_iopoll_getevents+0x115/0x380
[   90.339540]  ? __x64_sys_io_uring_enter+0x1ff/0x3a0
[   90.340410]  __io_iopoll_check+0x7e/0xb0
[   90.341107]  __x64_sys_io_uring_enter+0x20f/0x3a0
[   90.341941]  ? __x64_sys_io_uring_enter+0x7b/0x3a0
[   90.342795]  do_syscall_64+0x63/0x190
[   90.343450]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   90.344345] RIP: 0033:0x7fe8cd9322cd
[   90.344984] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 6b 2c 00 f7 d8 64 89 01 48
[   90.348248] RSP: 002b:00007fff969c6e58 EFLAGS: 00000246 ORIG_RAX: 
00000000000001aa
[   90.349572] RAX: ffffffffffffffda RBX: 00007fe8ac531000 RCX: 
00007fe8cd9322cd
[   90.350823] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
0000000000000003
[   90.352073] RBP: 00007fe8ac531000 R08: 0000000000000000 R09: 
0000000000000000
[   90.353327] R10: 0000000000000001 R11: 0000000000000246 R12: 
00000000015aa570
[   90.354582] R13: 000000000000053c R14: 0000000000000001 R15: 
00000000016053e8
[   90.355835] Modules linked in: xfs dm_mod sr_mod sd_mod cdrom 
crc32c_intel ata_piix nvme nvme_core e1000 libata virtio_pci 
9pnet_virtio virtio_ring virtio 9p 9pnet
[   90.358396] general protection fault: 0000 [#6] SMP DEBUG_PAGEALLOC PTI
[   90.359608] CPU: 13 PID: 11642 Comm: fio Tainted: G      D W         
5.4.0-rc8-bij #239
[   90.361027] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   90.363058] RIP: 0010:nvme_unmap_data+0x195/0x1e0 [nvme]
[   90.364008] Code: 75 0b 0f b7 83 c2 00 00 00 48 c1 e0 05 80 bb 40 01 
00 00 00 48 63 d5 49 8d 14 d1 48 8b 34 02 74 09 4c 8b b6 f0 0f 00 00 eb 
04 <4e> 8b 34 26 49 8b bf 58 02 00 00 4c 89 ea 83 c5 01 e8 15 27 16 e1
[   90.367295] RSP: 0018:ffffc90003a1bc78 EFLAGS: 00010246
[   90.368225] RAX: 0000000000000020 RBX: ffff888227e74980 RCX: 
0000000000000002
[   90.369483] RDX: ffff88808b976000 RSI: 6b6b6b6b6b6b6b6b RDI: 
ffff88808b976000
[   90.370740] RBP: 0000000000000000 R08: 0000000000000000 R09: 
ffff88808b976000
[   90.371996] R10: ffff8880840dc900 R11: 0000000000000001 R12: 
0000000000000ff8
[   90.373257] R13: 00000000846ae000 R14: ffff888229c282c0 R15: 
ffff888229c84000
[   90.374519] FS:  00007fe8ce9e6740(0000) GS:ffff888236000000(0000) 
knlGS:0000000000000000
[   90.375942] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.376963] CR2: 00007f1c48000010 CR3: 000000014f6b6005 CR4: 
0000000000160ee0
[   90.378237] Call Trace:
[   90.378690]  nvme_pci_complete_rq+0xa5/0xb0 [nvme]
[   90.379551]  blk_mq_complete_request+0x47/0xf0
[   90.380350]  nvme_poll+0x23f/0x2d0 [nvme]
[   90.381068]  blk_poll+0x24f/0x320
[   90.381671]  io_iopoll_getevents+0x115/0x380
[   90.382442]  ? __x64_sys_io_uring_enter+0x1ff/0x3a0
[   90.383313]  __io_iopoll_check+0x7e/0xb0
[   90.384016]  __x64_sys_io_uring_enter+0x20f/0x3a0
[   90.384858]  ? __x64_sys_io_uring_enter+0x7b/0x3a0
[   90.385712]  do_syscall_64+0x63/0x190
[   90.386373]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   90.387273] RIP: 0033:0x7fe8cd9322cd
[   90.387916] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 6b 2c 00 f7 d8 64 89 01 48
[   90.391197] RSP: 002b:00007fff969c6e58 EFLAGS: 00000246 ORIG_RAX: 
00000000000001aa
[   90.392535] RAX: ffffffffffffffda RBX: 00007fe8ac5e0380 RCX: 
00007fe8cd9322cd
[   90.393795] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
0000000000000003
[   90.395057] RBP: 00007fe8ac5e0380 R08: 0000000000000000 R09: 
0000000000000000
[   90.396318] R10: 0000000000000001 R11: 0000000000000246 R12: 
00000000015aa650
[   90.397579] R13: 0000000000000469 R14: 0000000000000001 R15: 
0000000001622228
[   90.398845] Modules linked in: xfs dm_mod sr_mod sd_mod cdrom 
crc32c_intel ata_piix nvme nvme_core e1000 libata virtio_pci 
9pnet_virtio virtio_ring virtio 9p 9pnet
[   90.401429] general protection fault: 0000 [#7] SMP DEBUG_PAGEALLOC PTI
[   90.402622] CPU: 12 PID: 11639 Comm: fio Tainted: G      D W         
5.4.0-rc8-bij #239
[   90.404025] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   90.406034] RIP: 0010:nvme_unmap_data+0x195/0x1e0 [nvme]
[   90.406977] Code: 75 0b 0f b7 83 c2 00 00 00 48 c1 e0 05 80 bb 40 01 
00 00 00 48 63 d5 49 8d 14 d1 48 8b 34 02 74 09 4c 8b b6 f0 0f 00 00 eb 
04 <4e> 8b 34 26 49 8b bf 58 02 00 00 4c 89 ea 83 c5 01 e8 15 27 16 e1
[   90.410258] RSP: 0018:ffffc90003a03c78 EFLAGS: 00010246
[   90.411181] RAX: 0000000000000020 RBX: ffff888227e16480 RCX: 
0000000000000002
[   90.412445] RDX: ffff888086d9c000 RSI: 6b6b6b6b6b6b6b6b RDI: 
ffff888086d9c000
[   90.413703] RBP: 0000000000000000 R08: 0000000000000000 R09: 
ffff888086d9c000
[   90.414961] R10: ffff888083cfc480 R11: 0000000000000001 R12: 
0000000000000ff8
[   90.416208] R13: 0000000191cd1000 R14: ffff888227cc24f0 R15: 
ffff888229c84000
[   90.417461] FS:  00007fe8ce9e6740(0000) GS:ffff888235c00000(0000) 
knlGS:0000000000000000
[   90.418876] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.419885] CR2: 000055eae3dbe028 CR3: 0000000228eae002 CR4: 
0000000000160ee0
[   90.421135] Call Trace:
[   90.421589]  nvme_pci_complete_rq+0xa5/0xb0 [nvme]
[   90.422442]  blk_mq_complete_request+0x47/0xf0
[   90.423232]  nvme_poll+0x23f/0x2d0 [nvme]
[   90.423946]  blk_poll+0x24f/0x320
[   90.424544]  io_iopoll_getevents+0x115/0x380
[   90.425309]  ? __x64_sys_io_uring_enter+0x1ff/0x3a0
[   90.426169]  __io_iopoll_check+0x7e/0xb0
[   90.426871]  __x64_sys_io_uring_enter+0x20f/0x3a0
[   90.427702]  ? __x64_sys_io_uring_enter+0x7b/0x3a0
[   90.428553]  do_syscall_64+0x63/0x190
[   90.429207]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   90.430098] RIP: 0033:0x7fe8cd9322cd
[   90.430740] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 6b 2c 00 f7 d8 64 89 01 48
[   90.433997] RSP: 002b:00007fff969c6e58 EFLAGS: 00000246 ORIG_RAX: 
00000000000001aa
[   90.435325] RAX: ffffffffffffffda RBX: 00007fe8ac5ae280 RCX: 
00007fe8cd9322cd
[   90.436571] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
0000000000000003
[   90.437819] RBP: 00007fe8ac5ae280 R08: 0000000000000000 R09: 
0000000000000000
[   90.439073] R10: 0000000000000001 R11: 0000000000000246 R12: 
00000000015aa610
[   90.440331] R13: 00000000000004e8 R14: 0000000000000001 R15: 
000000000160e328
[   90.441582] Modules linked in: xfs dm_mod sr_mod sd_mod cdrom 
crc32c_intel ata_piix nvme nvme_core e1000 libata virtio_pci 
9pnet_virtio virtio_ring virtio 9p 9pnet
[   90.444135] general protection fault: 0000 [#8] SMP DEBUG_PAGEALLOC PTI
[   90.445327] CPU: 3 PID: 11653 Comm: fio Tainted: G      D W         
5.4.0-rc8-bij #239
[   90.446715] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   90.448717] RIP: 0010:nvme_unmap_data+0x195/0x1e0 [nvme]
[   90.449655] Code: 75 0b 0f b7 83 c2 00 00 00 48 c1 e0 05 80 bb 40 01 
00 00 00 48 63 d5 49 8d 14 d1 48 8b 34 02 74 09 4c 8b b6 f0 0f 00 00 eb 
04 <4e> 8b 34 26 49 8b bf 58 02 00 00 4c 89 ea 83 c5 01 e8 15 27 16 e1
[   90.452908] RSP: 0018:ffffc90003a6bc78 EFLAGS: 00010246
[   90.453833] RAX: 0000000000000020 RBX: ffff888227f3a680 RCX: 
0000000000000002
[   90.455081] RDX: ffff8880872d4000 RSI: 6b6b6b6b6b6b6b6b RDI: 
ffff8880872d4000
[   90.456331] RBP: 0000000000000000 R08: 0000000000000000 R09: 
ffff8880872d4000
[   90.457577] R10: ffff8880840df3c0 R11: 0000000000000001 R12: 
0000000000000ff8
[   90.458822] R13: 0000000084aff000 R14: ffff88822829a750 R15: 
ffff888229c84000
[   90.460067] FS:  00007fe8ce9e6740(0000) GS:ffff888233800000(0000) 
knlGS:0000000000000000
[   90.461484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.462495] CR2: 000055d4f0b63258 CR3: 00000001f5bc6001 CR4: 
0000000000160ee0
[   90.463743] Call Trace:
[   90.464188]  nvme_pci_complete_rq+0xa5/0xb0 [nvme]
[   90.465033]  blk_mq_complete_request+0x47/0xf0
[   90.465821]  nvme_poll+0x23f/0x2d0 [nvme]
[   90.466538]  blk_poll+0x24f/0x320
[   90.467131]  io_iopoll_getevents+0x115/0x380
[   90.467894]  ? __x64_sys_io_uring_enter+0x1ff/0x3a0
[   90.468759]  __io_iopoll_check+0x7e/0xb0
[   90.469456]  __x64_sys_io_uring_enter+0x20f/0x3a0
[   90.470291]  ? __x64_sys_io_uring_enter+0x7b/0x3a0
[   90.471132]  do_syscall_64+0x63/0x190
[   90.471783]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   90.472670] RIP: 0033:0x7fe8cd9322cd
[   90.473305] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 6b 2c 00 f7 d8 64 89 01 48
[   90.476543] RSP: 002b:00007fff969c6e58 EFLAGS: 00000246 ORIG_RAX: 
00000000000001aa
[   90.477862] RAX: ffffffffffffffda RBX: 00007fe8ac68f700 RCX: 
00007fe8cd9322cd
[   90.479106] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
0000000000000003
[   90.480351] RBP: 00007fe8ac68f700 R08: 0000000000000000 R09: 
0000000000000000
[   90.481595] R10: 0000000000000001 R11: 0000000000000246 R12: 
00000000015aa730
[   90.482840] R13: 0000000000000505 R14: 0000000000000001 R15: 
000000000160b268
[   90.484086] Modules linked in: xfs dm_mod sr_mod sd_mod cdrom 
crc32c_intel ata_piix nvme nvme_core e1000 libata virtio_pci 
9pnet_virtio virtio_ring virtio 9p 9pnet
[   90.486641] Kernel Offset: disabled
[   90.487288] ---[ end Kernel panic - not syncing: Fatal exception ]---

--bijan
