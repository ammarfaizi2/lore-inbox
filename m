Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWHYNCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWHYNCS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWHYNCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:02:18 -0400
Received: from 82-69-39-138.dsl.in-addr.zen.co.uk ([82.69.39.138]:10907 "EHLO
	ty.sabi.co.UK") by vger.kernel.org with ESMTP id S1750891AbWHYNCR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:02:17 -0400
X-Face: SMJE]JPYVBO-9UR%/8d'mG.F!@.,l@c[f'[%S8'BZIcbQc3/">GrXDwb#;fTRGNmHr^JFb
 SAptvwWc,0+z+~p~"Gdr4H$(|N(yF(wwCM2bW0~U?HPEE^fkPGx^u[*[yV.gyB!hDOli}EF[\cW*S
 H<GG"+i\3#fp@@EeWZWBv;]LA5n1pS2VO%Vv[yH?kY'lEWr30WfIU?%>&spRGFL}{`bj1TaD^l/"[
 msn( /TH#THs{Hpj>)]f><W}Ck9%2?H"AEM)+9<@D;3Kv=^?4$1/+#Qs:-aSsBTUS]iJ$6
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: oops while doing block IO
From: pg_lkm@lkm.for.sabi.co.UK (Peter Grandi)
X-Disclaimer: This message contains only personal opinions
Date: Fri, 25 Aug 2006 14:02:07 +0100
Message-ID: <yf3wt8xm0j4.fsf@base.gp.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.16.17 I get infrequent but very consistent null pointer
dereferences especially but not only when lots of block IO is
going on (I backup with disk-to-disk copies).

Some more context: I use 'loop-AES' (may or may not be relevant),
and the error happens most often when lots of _concurrent_ block
IO takes place; usually mere single threaded copying from one disk
to another does not trigger the error.

The relevant details are:

------------------------------------------------------------------------
base kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 00000040
------------------------------------------------------------------------
EIP is at generic_make_request+0x31/0x330
eax: 00000000   ebx: 00000200   ecx: a1a23480   edx: 95aa34c0
esi: 95aa34c0   edi: 00000000   ebp: b7f14cec   esp: b7f14c64
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 166, threadinfo=b7f14000 task=b7f15ab0)
------------------------------------------------------------------------
Call Trace:
 <7810402d> show_stack_log_lvl+0x9d/0xd0  <78104267> show_registers+0x1b7/0x240
 <78104422> die+0x132/0x330  <78116086> do_page_fault+0x296/0x6bc
 <78103a9f> error_code+0x4f/0x54  <78235a18> submit_bio+0x58/0x100
 <78169be3> submit_bh+0xd3/0x130  <7816b744> __block_write_full_page+0x1c4/0x3b0
 <7816bd92> block_write_full_page+0x102/0x110  <78170560> blkdev_writepage+0x20/0x30
 <7818f688> mpage_writepages+0x1b8/0x3d0  <78170510> generic_writepages+0x20/0x30
 <7814e13d> do_writepages+0x2d/0x50  <7818da54> __writeback_single_inode+0x94/0x3c0
 <7818e04b> sync_sb_inodes+0x1bb/0x2a0  <7818e6b3> writeback_inodes+0xc3/0xf9
 <7814e4b0> background_writeout+0x80/0xa0  <7814ecde> pdflush+0xee/0x1b0
 <78133385> kthread+0xc5/0xf0  <78100dd5> kernel_thread_helper+0x5/0x10
------------------------------------------------------------------------

The relevant bit of code is:

------------------------------------------------------------------------
0x7823338e <generic_make_request+30>:   call   0x78118410 <__might_sleep>
0x78233393 <generic_make_request+35>:   call   0x783ea290 <cond_resched>
0x78233398 <generic_make_request+40>:   mov    0x8(%ebp),%edx
0x7823339b <generic_make_request+43>:   mov    0x8(%edx),%ecx
0x7823339e <generic_make_request+46>:   mov    0x4(%ecx),%eax
0x782333a1 <generic_make_request+49>:   mov    0x40(%eax),%edx
0x782333a4 <generic_make_request+52>:   mov    0x3c(%eax),%eax
0x782333a7 <generic_make_request+55>:   shrd   $0x9,%edx,%eax
------------------------------------------------------------------------

and the null pointer is clearly in '%eax', which corresponds to
'->bd_inode' at the beginning of 'generic_make_request' in
'block/ll_rw_blk.c':

------------------------------------------------------------------------
	might_sleep();
	/* Test device or partition size, when known. */
	maxsector = bio->bi_bdev->bd_inode->i_size >> 9;
	if (maxsector) {
------------------------------------------------------------------------

As a crude fix I have done this patch:

------------------------------------------------------------------------
--- block/ll_rw_blk.c-dist	2006-07-26 12:35:54.918926000 +0100
+++ block/ll_rw_blk.c	2006-08-24 11:55:01.806241906 +0100
@@ -80,6 +80,16 @@
 #define BLK_BATCH_REQ	32
+
+/*
+ * Return the maximum number of sectors for the block device,
+ * or 0 if unknown.
+ */
+static inline sector_t bio_max_sector(const struct bio *const bio)
+{
+	return (bio->bi_bdev->bd_inode == 0) ? 0
+		: bio->bi_bdev->bd_inode->i_size >> 9;
+}
 
 /*
  * Return the threshold (number of used requests) at which the queue is
  * considered to be congested.  It include a little hysteresis to keep the
  * context switch rate down.
@@ -2983,7 +2993,7 @@
 			bdevname(bio->bi_bdev, b),
 			bio->bi_rw,
 			(unsigned long long)bio->bi_sector + bio_sectors(bio),
-			(long long)(bio->bi_bdev->bd_inode->i_size >> 9));
+			(long long) bio_max_sector(bio));
 
 	set_bit(BIO_EOF, &bio->bi_flags);
 }
@@ -3021,7 +3031,7 @@
 
 	might_sleep();
 	/* Test device or partition size, when known. */
-	maxsector = bio->bi_bdev->bd_inode->i_size >> 9;
+	maxsector = bio_max_sector(bio);
 	if (maxsector) {
 		sector_t sector = bio->bi_sector;
 
------------------------------------------------------------------------

Which just prevents the null pointer dereference. The wider
question is why 'bd_inode' is null, but only in some cases...
