Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286717AbRLVIOo>; Sat, 22 Dec 2001 03:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286716AbRLVIOf>; Sat, 22 Dec 2001 03:14:35 -0500
Received: from bwbohh.net ([66.96.192.22]:54406 "EHLO garcia.hostnoc.net")
	by vger.kernel.org with ESMTP id <S286714AbRLVIO2>;
	Sat, 22 Dec 2001 03:14:28 -0500
Date: Sat, 22 Dec 2001 03:14:42 -0500
From: Eric Windisch <ericw@grokthis.net>
To: linux-kernel@vger.kernel.org
Subject: Hello. Patch time (drivers/block/loop.c)
Message-ID: <20011222031442.A25275@grokthis.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hello. I would like to formally introduce myself to this list, as this is my first post. Of course, I would not come to the table empty handed.. I bring to you a patch ;)

I was digging around the loopback block device driver and it wasn't long before I realized that it assumes you are writing if you are not reading.. which I assume could be hazardous if there is an overflow, bad memory, or someone modifies some other code without knowledge :)

Patch attached.

I may be looking at this and the multi-device drivers in the near future as I have a need for support for partitions on these devices; I think it would be really neat if the software-raid could eventually become compatable with hardware raid.. although much slower, it may be a nice thing to have for testing purposes or a last resort for those who fry their hardware raid-controllers ;)

--
Eric Windisch
http://bwbohh.net

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop-badmem.diff"

--- linux/drivers/block/loop.c	Fri Dec 21 12:41:53 2001
+++ linux-2.4.17-ericw/drivers/block/loop.c	Sat Dec 22 02:35:17 2001
@@ -90,8 +90,10 @@
 	if (raw_buf != loop_buf) {
 		if (cmd == READ)
 			memcpy(loop_buf, raw_buf, size);
-		else
+		else if (cmd == WRITE) 
 			memcpy(raw_buf, loop_buf, size);
+		else
+			printk(KERN_ERR "loop: Illegal command, %d", cmd);
 	}
 
 	return 0;
@@ -106,9 +108,11 @@
 	if (cmd == READ) {
 		in = raw_buf;
 		out = loop_buf;
-	} else {
+	} else if (cmd == WRITE) {
 		in = loop_buf;
 		out = raw_buf;
+	} else {
+		printk(KERN_ERR "loop: Illegal command, %d", cmd);
 	}
 
 	key = lo->lo_encrypt_key;

--0F1p//8PRICkK4MW--
