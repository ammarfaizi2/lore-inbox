Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129339AbRCBRVz>; Fri, 2 Mar 2001 12:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129329AbRCBRVp>; Fri, 2 Mar 2001 12:21:45 -0500
Received: from mail.inup.com ([194.250.46.226]:12299 "EHLO mailhost.inup.com")
	by vger.kernel.org with ESMTP id <S129324AbRCBRVi>;
	Fri, 2 Mar 2001 12:21:38 -0500
Date: Fri, 2 Mar 2001 18:21:35 +0100
From: christophe barbe <christophe.barbe@inup.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] detail in fs/block_dev.c
Message-ID: <20010302182135.B13539@pc8.inup.com>
In-Reply-To: <20010302181726.A13539@pc8.inup.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AWniW0JNca5xppdA"
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010302181726.A13539@pc8.inup.com>; from christophe.barbe@inup.com on ven, mar 02, 2001 at 18:17:26 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AWniW0JNca5xppdA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

in fs/block_dev.c block_read() function (in 2.2 and 2.4 series)

rblocks = blocks = (left + offset + blocksize - 1) >> blocksize_bits;
bhb = bhe = buflist;
if (filp->f_reada) {
	if (blocks < read_ahead[MAJOR(dev)] / (blocksize >> 9))
		blocks = read_ahead[MAJOR(dev)] / (blocksize >> 9);
	if (rblocks > blocks)
		blocks = rblocks;

The second test is false in all case and there's no concequences because the rblocks variable is never used.

So I've joined a patch (ok for 2.2.17 and 2.4.2) to remove rblocks.

Christophe

-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com

--AWniW0JNca5xppdA
Content-Type: application/octet-stream; charset=us-ascii
Content-Disposition: attachment; filename="block_dev.patch"

--- fs/block_dev.c.org	Fri Mar  2 18:16:04 2001
+++ fs/block_dev.c	Fri Mar  2 18:16:43 2001
@@ -163,7 +163,7 @@
 	loff_t offset;
 	ssize_t blocksize;
 	ssize_t blocksize_bits, i;
-	size_t blocks, rblocks, left;
+	size_t blocks, left;
 	int bhrequest, uptodate;
 	struct buffer_head ** bhb, ** bhe;
 	struct buffer_head * buflist[NBUF];
@@ -205,14 +205,11 @@
 	block = offset >> blocksize_bits;
 	offset &= blocksize-1;
 	size >>= blocksize_bits;
-	rblocks = blocks = (left + offset + blocksize - 1) >> blocksize_bits;
+	blocks = (left + offset + blocksize - 1) >> blocksize_bits;
 	bhb = bhe = buflist;
 	if (filp->f_reada) {
 	        if (blocks < read_ahead[MAJOR(dev)] / (blocksize >> 9))
 			blocks = read_ahead[MAJOR(dev)] / (blocksize >> 9);
-		if (rblocks > blocks)
-			blocks = rblocks;
-		
 	}
 	if (block + blocks > size) {
 		blocks = size - block;

--AWniW0JNca5xppdA--
