Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbTEaILa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 04:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbTEaILa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 04:11:30 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:3342 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S264215AbTEaILV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 04:11:21 -0400
Message-ID: <3ED86687.6000805@torque.net>
Date: Sat, 31 May 2003 18:23:35 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Subject: Re: [PATCH] SG_IO readcd and various bugs
Content-Type: multipart/mixed;
 boundary="------------090301010008090801070905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090301010008090801070905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
 > On Fri, May 30 2003, Markus Plail wrote:
 > > On Fri, 30 May 2003, Markus Plail wrote:
 > >
 > > > The patch makes readcd work just fine here :-) Many thanks!
 > >
 > > Just realized that C2 scans don't yet work.
 >
 > Updated patch, please give that a shot. These sense_len wasn't
 > being set correctly.

Jens,
At the end of this post is an incremental patch on
top of your most recent one.


Here are some timing and CPU utilization numbers on the
combined patches. Reading
1 GB data from the beginning of a Fujitsu MAM3184MP SCSI
disk whose streaming speed for outer zones is about
57 MB/sec (according to Storage Review). Each atomic read
is 64 KB (and "of=." is sg_dd shorthand for "of=/dev/null").

Here is a normal read (i.e. treating /dev/sda as a normal file):
  $ /usr/bin/time sg_dd if=/dev/sda of=. bs=512 time=1 count=2M
  time to transfer data was 17.821534 secs, 57.46 MB/sec
  0.00user 4.37system 0:17.82elapsed 24%CPU

The transfer time is a little fast due to cache hits. The
24% CPU utilization is the price paid for those cache hits.

Next using O_DIRECT:
  $ /usr/bin/time sg_dd if=/dev/sda of=. bs=512 time=1 count=2M
      odir=1
  time to transfer data was 18.003662 secs, 56.88 MB/sec
  0.00user 0.52system 0:18.00elapsed 2%CPU

The time to transfer is about right and the CPU utilization is
down to 2% (0.52 seconds).

Next using the block layer SG_IO command:
  $ /usr/bin/time sg_dd if=/dev/sda of=. bs=512 time=1 count=2M
      blk_sgio=1
  time to transfer data was 18.780551 secs, 54.52 MB/sec
  0.00user 6.40system 0:18.78elapsed 34%CPU

The throughput is worse and the CPU utilization is now
worse than a normal file.

Setting the "dio=1" flag in sg_dd page aligns its buffers
which causes bio_map_user() to succeed (in
drivers/block/scsi_ioctl.c:sg_io()). In other words it turns
on direct I/O:
  $ /usr/bin/time sg_dd if=/dev/sda of=. bs=512 time=1 count=2M
      blk_sgio=1 dio=1
  time to transfer data was 17.899802 secs, 57.21 MB/sec
  0.00user 0.31system 0:17.90elapsed 1%CPU

So this result is comparable with O_DIRECT on the normal
file. CPU utilization is down to 1% (0.31 seonds).


With the latest changes from Jens (mainly dropping the
artificial 64 KB per operation limit) the maximum
element size in the block layer SG_IO is:
   - 128 KB when direct I/O is not used (i.e. the user
     space buffer does not meet bio_map_user()'s
     requirements). This seems to be the largest buffer
     kmalloc() will allow (in my tests)
   - (sg_tablesize * page_size) when direct I/O is used.
     My test was with the sym53c8xx_2 driver in which
     sg_tablesize==96 so my largest element size was 384 KB



Incremental patch (on top of Jens's 2nd patch in this
thread) changelog:
   - change version number (effectively to 3.7.29) so
     apps can distinguish if the want (current sg driver
     version is 3.5.29). The main thing that app do is
     check the version >= 3.0.0 as that implies the
     SG_IO ioctl is there.
   - reject requests for mmap()-ed I/O with a "not
     supported error"
   - if direct I/O is requested, send back via info
     field whether it was done (or fell back to indirect
     I/O). This is what happens in the sg driver.
   - ultra-paranoid buffer zeroing (in padding at end)

Doug Gilbert

--------------090301010008090801070905
Content-Type: text/plain;
 name="blk_sg_io2570ja_dg.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk_sg_io2570ja_dg.diff"

--- linux/drivers/block/scsi_ioctl.c	2003-05-31 13:50:04.000000000 +1000
+++ linux/drivers/block/scsi_ioctl.c2570dpg2	2003-05-31 14:13:15.000000000 +1000
@@ -82,7 +82,7 @@
 
 static int sg_get_version(int *p)
 {
-	static int sg_version_num = 30527;
+	static int sg_version_num = 30729;   /* version 3.7.* to distinguish */
 	return put_user(sg_version_num, p);
 }
 
@@ -143,7 +143,7 @@
 		 struct sg_io_hdr *uptr)
 {
 	unsigned long start_time;
-	int reading, writing;
+	int reading, writing, dio;
 	struct sg_io_hdr hdr;
 	struct request *rq;
 	struct bio *bio;
@@ -163,11 +163,14 @@
 	 */
 	if (hdr.iovec_count)
 		return -EOPNOTSUPP;
+	if (hdr.flags & SG_FLAG_MMAP_IO)
+		return -EOPNOTSUPP;
 
 	if (hdr.dxfer_len > (q->max_sectors << 9))
 		return -EIO;
 
 	reading = writing = 0;
+	dio = 0;
 	buffer = NULL;
 	bio = NULL;
 	if (hdr.dxfer_len) {
@@ -194,10 +197,12 @@
 		bio = bio_map_user(bdev, (unsigned long) hdr.dxferp,
 				   hdr.dxfer_len, reading);
 
-		/*
-		 * if bio setup failed, fall back to slow approach
-		 */
-		if (!bio) {
+		if (bio)
+			dio = 1;
+		else {
+			/*
+			 * if bio setup failed, fall back to slow approach
+			 */
 			buffer = kmalloc(bytes, q->bounce_gfp | GFP_USER);
 			if (!buffer)
 				return -ENOMEM;
@@ -206,8 +211,11 @@
 				if (copy_from_user(buffer, hdr.dxferp,
 						   hdr.dxfer_len))
 					goto out_buffer;
+				if (bytes > hdr.dxfer_len)
+					memset((char *)buffer + hdr.dxfer_len,
+					       0, bytes - hdr.dxfer_len);
 			} else
-				memset(buffer, 0, hdr.dxfer_len);
+				memset(buffer, 0, bytes);
 		}
 	}
 
@@ -257,11 +265,13 @@
 	hdr.status = rq->errors;	
 	hdr.masked_status = (hdr.status >> 1) & 0x1f;
 	hdr.msg_status = 0;
-	hdr.host_status = 0;
+	hdr.host_status = 0;	/* "lost nexus" error could go here */
 	hdr.driver_status = 0;
 	hdr.info = 0;
 	if (hdr.masked_status || hdr.host_status || hdr.driver_status)
 		hdr.info |= SG_INFO_CHECK;
+	if (dio && (hdr.flags & SG_FLAG_DIRECT_IO))
+		hdr.info |= SG_INFO_DIRECT_IO;
 	hdr.resid = rq->data_len;
 	hdr.duration = ((jiffies - start_time) * 1000) / HZ;
 	hdr.sb_len_wr = 0;
@@ -286,7 +296,7 @@
 		kfree(buffer);
 	}
 
-	/* may not have succeeded, but output values written to control
+	/* may not have succeeded, but output status written to control
 	 * structure (struct sg_io_hdr).  */
 	return 0;
 out_request:

--------------090301010008090801070905--

