Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132053AbRDPUly>; Mon, 16 Apr 2001 16:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132054AbRDPUlp>; Mon, 16 Apr 2001 16:41:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63759 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132053AbRDPUlb>;
	Mon, 16 Apr 2001 16:41:31 -0400
Date: Mon, 16 Apr 2001 22:41:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: Re: 2.4.3-ac{6,7} LVM hang
Message-ID: <20010416224102.O9539@suse.de>
In-Reply-To: <Pine.LNX.4.21.0104161653140.14442-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0104161653140.14442-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Mon, Apr 16, 2001 at 04:55:15PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16 2001, Rik van Riel wrote:
> Hi,
> 
> 2.4.3-ac4 seems to work great on my test box (UP K6-2 with SCSI
> disk), but 2.4.3-ac6 and 2.4.3-ac7 hang pretty hard when I try
> to access any of the logical volumes on my test box.
> 
> The following changelog entry in Linus' changelog suggests me
> whom to bother:   ;)
>  - Jens Axboe: LVM and loop fixes

Heh :-). I'd categorize the lvm fixes as "obviously right", haven't
checked why they seem to break for some people. Maybe the minor indexing
of LVM is broken, in which case attached patch should make it go again
(and the LVM crew needs to look into that). Also fixes a slight error in
the IO error path.

-- 
Jens Axboe


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lvm-eout-2

--- /opt/kernel/linux-2.4.4-pre3/drivers/md/lvm.c	Sun Apr 15 16:24:13 2001
+++ drivers/md/lvm.c	Mon Apr 16 22:40:28 2001
@@ -1476,7 +1476,7 @@
  */
 static int lvm_map(struct buffer_head *bh, int rw)
 {
-	int minor = MINOR(bh->b_rdev);
+	int minor = MINOR(bh->b_dev);
 	int ret = 0;
 	ulong index;
 	ulong pe_start;
@@ -1675,8 +1675,11 @@
 			       struct buffer_head *bh)
 {
 	int ret = lvm_map(bh, rw);
-	if (ret < 0)
+
+	if (ret < 0) {
+		ret = 0;
 		buffer_IO_error(bh);
+	}
 	return ret;
 }
 

--b5gNqxB1S1yM7hjW--
