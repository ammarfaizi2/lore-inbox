Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288930AbSANOup>; Mon, 14 Jan 2002 09:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289255AbSANOu0>; Mon, 14 Jan 2002 09:50:26 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:59024 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S289252AbSANOuO>; Mon, 14 Jan 2002 09:50:14 -0500
Date: Mon, 14 Jan 2002 06:50:13 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: PATCH: linux-2.5.2-pre11/drivers/block/loop.c -- garbage reads
Message-ID: <20020114065013.A8790@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.5.2-pre11/drivers/block/loop.c returned incorrect data
for reads from any loop device that was mounted on a block device,
such as a disk partition.  The bug is the problem that I asked about
yesterday where do_bio_blockbacked in loop.c would transfer no data
because bio->bi_idx was nonzero (or, more precisely, always equal to
bio->bi_vcnt).  Here is a test case that reproduces the problem:



#!/bin/sh
# testdev can be any existant device that has a first sector
# that is not all zeroes.  We only need read access to it for this test.
testdev=/dev/discs/disc0/part1
set -e
dd count=1 if=$testdev of=/tmp/first_sector
losetup /dev/loop/0 $testdev
dd count=1 if=/dev/loop/0 of=/tmp/first_sector.loop
losetup -d /dev/loop/0
cmp /tmp/first_sector /tmp/first_sector.loop



	It turns out that the value of bio->bi_idx is correct.
The "bio" variable in that routine refers to the I/O operation
on the underlying device (not the loop device), and the I/O
operation has completed when do_bio_blockbacked has been
called for a READ.  do_bio_blockbacked should be looking at
rbh->bi_idx instead (rbh is the operation on /dev/loop/nnn,
which has not yet completed).  I have attached a patch below
which does this, and I have verified that it fixes the test
case and have used it in mounting a filesystem as well.

	By the way, there are plenty of other problems with
loop.c, such as the fact that it hangs my note book computer
in "disk I/O" (presumably to /dev/loop/0) every time it boots,
whereas I don't think I've seen that happen at all under 2.5.1-pre1
(although I have generally seen hangs about once every three weeks
since I went to an encrypted root).

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop.diff"

--- linux-2.5.2-pre11/drivers/block/loop.c	Mon Jan 14 05:48:01 2002
+++ linux/drivers/block/loop.c	Mon Jan 14 06:13:33 2002
@@ -488,15 +488,15 @@
 			      struct bio *rbh)
 {
 	unsigned long IV = loop_get_iv(lo, rbh->bi_sector);
-	struct bio_vec *to;
+	struct bio_vec *from;
 	char *vto, *vfrom;
 	int ret = 0, i;
 
-	bio_for_each_segment(to, bio, i) {
-		vfrom = page_address(rbh->bi_io_vec[i].bv_page) + rbh->bi_io_vec[i].bv_offset;
-		vto = page_address(to->bv_page) + to->bv_offset;
+	bio_for_each_segment(from, rbh, i) {
+		vfrom = page_address(from->bv_page) + from->bv_offset;
+		vto = page_address(bio->bi_io_vec[i].bv_page) + bio->bi_io_vec[i].bv_offset;
 		ret |= lo_do_transfer(lo, bio_data_dir(bio), vto, vfrom,
-					to->bv_len, IV);
+					from->bv_len, IV);
 	}
 
 	return ret;

--y0ulUmNC+osPPQO6--
