Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTFUWzb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 18:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTFUWzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 18:55:31 -0400
Received: from dm4-159.slc.aros.net ([66.219.220.159]:9098 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S263547AbTFUWz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 18:55:29 -0400
Message-ID: <3EF4E5A9.5010802@aros.net>
Date: Sat, 21 Jun 2003 17:09:29 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>, axboe@suse.de,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] nbd driver 2.5+: fix for incorrect struct bio usage
References: <3EF4D2C8.6060608@aros.net> <20030621151818.081139fc.akpm@digeo.com>
In-Reply-To: <20030621151818.081139fc.akpm@digeo.com>
Content-Type: multipart/mixed;
 boundary="------------070001030504040203090600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070001030504040203090600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here's a possible patch #2... I believe the address pointed to by 
bio_data(bio) is not always contiguous over the length of bio->bi_size 
and was responsible for locking my machine up sometimes. My biggest 
reason for apprehension on believeing that I'm 100% correct on this is 
that there's still what appears to be a source of memory corruption in 
the patchlet modified nbd driver even after this patch. I know the 
driver is still not correctly notifying processes of the bytesize on 
open but the size reported appears to be big enough. Anyway, thanks for 
all of the feedback so far!!!!

--------------070001030504040203090600
Content-Type: text/plain;
 name="nbd-patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-patch2"

diff -urN linux-2.5.72-p1/drivers/block/nbd.c linux-2.5.72-p2/drivers/block/nbd.c
--- linux-2.5.72-p1/drivers/block/nbd.c	2003-06-21 15:30:17.860967573 -0600
+++ linux-2.5.72-p2/drivers/block/nbd.c	2003-06-21 16:42:00.865099598 -0600
@@ -28,7 +28,10 @@
  *   the transmit lock. <steve@chygwyn.com>
  * 02-10-11 Allow hung xmit to be aborted via SIGKILL & various fixes.
  *   <Paul.Clements@SteelEye.com> <James.Bottomley@SteelEye.com>
- * 03-06-21 Fix memory corruption from module removal. <ldl@aros.net>
+ * 03-06-21 Make nbd work with linux 2.5 block layer code. This fixes memory
+ *   corruption from module removal too. <ldl@aros.net>
+ * 03-06-21 Fix incorrect bio struct access that could have lead to memory
+ *   corruption on receiving disk data. <ldl@aros.net>
  *
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
  * why not: would need verify_area and friends, would share yet another 
@@ -256,6 +259,12 @@
 	return NULL;
 }
 
+static inline int sock_recv_bvec(struct socket *sock, struct bio_vec *bvec)
+{
+	return nbd_xmit(0, sock, page_address(bvec->bv_page) + bvec->bv_offset,
+			bvec->bv_len, MSG_WAITALL);
+}
+
 #define HARDFAIL( s ) { printk( KERN_ERR "NBD: " s "(result %d)\n", result ); lo->harderror = result; return NULL; }
 struct request *nbd_read_stat(struct nbd_device *lo)
 		/* NULL returned = something went wrong, inform userspace       */ 
@@ -263,10 +272,11 @@
 	int result;
 	struct nbd_reply reply;
 	struct request *req;
+	struct socket *sock = lo->sock;
 
 	DEBUG("reading control, ");
 	reply.magic = 0;
-	result = nbd_xmit(0, lo->sock, (char *) &reply, sizeof(reply), MSG_WAITALL);
+	result = nbd_xmit(0, sock, (char *) &reply, sizeof(reply), MSG_WAITALL);
 	if (result <= 0)
 		HARDFAIL("Recv control failed.");
 	req = nbd_find_request(lo, reply.handle);
@@ -280,14 +290,17 @@
 		FAIL("Other side returned error.");
 
 	if (nbd_cmd(req) == NBD_CMD_READ) {
-		struct bio *bio = req->bio;
+		int i;
+		struct bio *bio;
 		DEBUG("data, ");
-		do {
-			result = nbd_xmit(0, lo->sock, bio_data(bio), bio->bi_size, MSG_WAITALL);
-			if (result <= 0)
-				HARDFAIL("Recv data failed.");
-			bio = bio->bi_next;
-		} while(bio);
+		rq_for_each_bio(bio, req) {
+			struct bio_vec *bvec;
+			bio_for_each_segment(bvec, bio, i) {
+				result = sock_recv_bvec(sock, bvec);
+				if (result <= 0)
+					HARDFAIL("Recv data failed.");
+			}
+		}
 	}
 	DEBUG("done.\n");
 	return req;

--------------070001030504040203090600--

