Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbUBUIHZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 03:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbUBUIHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 03:07:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:5805 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261524AbUBUIHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 03:07:19 -0500
Subject: [PATCH] Fix use of sector_t in swim3 driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077350468.851.36.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 19:01:08 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This driver won't build with CONFIG_LBD due to a 64 bits division.

Use the "simple" fix of a cast down to 32 bits, this is only
a floppy driver, no need to do sector_div.

Please, apply.

Ben.

===== drivers/block/swim3.c 1.32 vs edited =====
--- 1.32/drivers/block/swim3.c	Sat Feb 14 19:29:14 2004
+++ edited/drivers/block/swim3.c	Sat Feb 21 18:57:10 2004
@@ -319,7 +319,7 @@
 #if 0
 		printk("do_fd_req: dev=%s cmd=%d sec=%ld nr_sec=%ld buf=%p\n",
 		       req->rq_disk->disk_name, req->cmd,
-		       req->sector, req->nr_sectors, req->buffer);
+		       (long)req->sector, req->nr_sectors, req->buffer);
 		printk("           rq_status=%d errors=%d current_nr_sectors=%ld\n",
 		       req->rq_status, req->errors, req->current_nr_sectors);
 #endif
@@ -346,8 +346,13 @@
 			}
 		}
 
-		fs->req_cyl = req->sector / fs->secpercyl;
-		x = req->sector % fs->secpercyl;
+		/* Do not remove the cast. req->sector is now a sector_t and
+		 * can be 64 bits, but it will never go past 32 bits for this
+		 * driver anyway, so we can safely cast it down and not have
+		 * to do a 64/32 division
+		 */
+		fs->req_cyl = ((long)req->sector) / fs->secpercyl;
+		x = ((long)req->sector) % fs->secpercyl;
 		fs->head = x / fs->secpertrack;
 		fs->req_sector = x % fs->secpertrack + 1;
 		fd_req = req;
@@ -614,7 +619,7 @@
 	fd_req->sector += s;
 	fd_req->current_nr_sectors -= s;
 	printk(KERN_ERR "swim3: timeout %sing sector %ld\n",
-	       (rq_data_dir(fd_req)==WRITE? "writ": "read"), fd_req->sector);
+	       (rq_data_dir(fd_req)==WRITE? "writ": "read"), (long)fd_req->sector);
 	end_request(fd_req, 0);
 	fs->state = idle;
 	start_request(fs);
@@ -730,7 +735,7 @@
 			} else {
 				printk("swim3: error %sing block %ld (err=%x)\n",
 				       rq_data_dir(fd_req) == WRITE? "writ": "read",
-				       fd_req->sector, err);
+				       (long)fd_req->sector, err);
 				end_request(fd_req, 0);
 				fs->state = idle;
 			}


