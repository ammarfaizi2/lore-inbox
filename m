Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265274AbSKEEi7>; Mon, 4 Nov 2002 23:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSKEEi7>; Mon, 4 Nov 2002 23:38:59 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:1474 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S265274AbSKEEi6>; Mon, 4 Nov 2002 23:38:58 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.46: drivers/mtd/mtdblock.c won't compile -- misordered declaration
References: <buod6ppj20y.fsf@mcspd15.ucom.lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 05 Nov 2002 13:45:22 +0900
In-Reply-To: <buod6ppj20y.fsf@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <buobs54ipzx.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is a repost of my earlier message, since the problem doesn't seem
 to have been fixed in 2.5.46; could someone please look at this?
 I don't think it should be controversial...]

When I compile 2.5.45, I get the following errors:

     v850e-elf-gcc -Wp,-MD,drivers/mtd/.mtdblock.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -g -fomit-frame-pointer -fno-strict-aliasing -fno-common -mv850e -ffixed-r16 -mno-prolog-function -fno-builtin -D__linux__ -DUTS_SYSNAME=\"uClinux\" -nostdinc -iwithprefix include    -DKBUILD_BASENAME=mtdblock   -c -o drivers/mtd/mtdblock.o drivers/mtd/mtdblock.c
   drivers/mtd/mtdblock.c:398: parse error before `struct'
   drivers/mtd/mtdblock.c:399: `p' undeclared (first use in this function)

I fixed this locally as follows:

diff -ruN -X../cludes ../orig/linux-2.5.45-uc1/drivers/mtd/mtdblock.c drivers/mtd/mtdblock.c
--- ../orig/linux-2.5.45-uc1/drivers/mtd/mtdblock.c	2002-10-31 11:41:04.000000000 +0900
+++ drivers/mtd/mtdblock.c	2002-11-01 12:43:26.000000000 +0900
@@ -393,9 +393,10 @@
 	unsigned int res;

 	while (!blk_queue_empty(&mtd_queue)) {
+		struct mtdblk_dev **p;
 		struct request *req = elv_next_request(&mtd_queue);
 		spin_unlock_irq(mtd_queue.queue_lock);
-		struct mtdblk_dev **p = req->rq_disk->private_data;
+		p = req->rq_disk->private_data;
 		mtdblk = *p;
 		res = 0;

Thanks,

-Miles
-- 
o The existentialist, not having a pillow, goes everywhere with the book by
  Sullivan, _I am going to spit on your graves_.
