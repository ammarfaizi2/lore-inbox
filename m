Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291065AbSAaNZa>; Thu, 31 Jan 2002 08:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291066AbSAaNZT>; Thu, 31 Jan 2002 08:25:19 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:36741 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S291065AbSAaNZK>;
	Thu, 31 Jan 2002 08:25:10 -0500
Date: Thu, 31 Jan 2002 14:24:46 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pavel@atrey.karlin.mff.cuni.cz
Subject: [PATCH] nbd in 2.5.3 does not work, and can cause severe damage when read-write
Message-ID: <20020131132446.GA23990@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
    I've got strange idea and tried to build diskless machine around
2.5.3... Besides problem with segfaulting crc32 (it is initialized after 
net/ipv4/ipconfig.c due to lib/lib.a being a library... I had to hardcode
lib/crc32.o before --start-group in main Makefile, but it is another
story) there is bad problem with NBD caused by BIO changes:

(1) request flags were immediately put into on-wire request format.
    In the past, we had 0=READ, !0=WRITE. Now only REQ_RW bit determines
    direction. As nbd-server from nbd distribution package treats any
    non-zero value as write, it performs writes instead of read. Fortunately
    it will die due to other consistency checks on incoming request, but...

(2) nbd servers handle only up to 10240 byte requests. So setting max_sectors
    to 20 is needed, as otherwise nbd server commits suicide. Maximum request size
    should be handshaked during nbd initialization, but currently just use
    hardwired 20 sectors, so it will behave like it did in the past.

						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz


diff -urdN linux/drivers/block/nbd.c linux/drivers/block/nbd.c
--- linux/drivers/block/nbd.c	Thu Jan 10 18:15:38 2002
+++ linux/drivers/block/nbd.c	Thu Jan 31 00:24:50 2002
@@ -155,14 +155,15 @@
 	unsigned long size = req->nr_sectors << 9;
 
 	DEBUG("NBD: sending control, ");
+	
+	rw = rq_data_dir(req);
+	
 	request.magic = htonl(NBD_REQUEST_MAGIC);
-	request.type = htonl(req->flags);
+	request.type = htonl((rw & WRITE) ? 1 : 0);
 	request.from = cpu_to_be64( (u64) req->sector << 9);
 	request.len = htonl(size);
 	memcpy(request.handle, &req, sizeof(req));
 
-	rw = rq_data_dir(req);
-
 	result = nbd_xmit(1, sock, (char *) &request, sizeof(request), rw & WRITE ? MSG_MORE : 0);
 	if (result <= 0)
 		FAIL("Sendmsg failed for control.");
@@ -517,6 +518,7 @@
 	blksize_size[MAJOR_NR] = nbd_blksizes;
 	blk_size[MAJOR_NR] = nbd_sizes;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_nbd_request, &nbd_lock);
+	blk_queue_max_sectors(BLK_DEFAULT_QUEUE(MAJOR_NR), 20);
 	for (i = 0; i < MAX_NBD; i++) {
 		nbd_dev[i].refcnt = 0;
 		nbd_dev[i].file = NULL;
