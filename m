Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261177AbTDBAvp>; Tue, 1 Apr 2003 19:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbTDBAvp>; Tue, 1 Apr 2003 19:51:45 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:8189 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id <S261177AbTDBAvo>;
	Tue, 1 Apr 2003 19:51:44 -0500
Date: Tue, 1 Apr 2003 17:03:07 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: jsun@mvista.com, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] [2.4] kiobuf flush dcache properly
Message-ID: <20030401170307.A29837@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some CPUs have cache aliasing problem, where the same physical
memory could appear in more than one places in data cache
(such as those found in MIPS and Sparc).  For those CPUs, kiobuf
is not flushing cache properly.

The symptom can be easily found if you open files with O_DIRECT
flag and do file copies on those CPUs.

This patch fixes the problem.

Basically if it is a WRITE (from user to disk), we need to flush
cache before the IO.  If it is a READ, we need to flush cache after 
the IO.

Please apply.

Jun

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030401-2.4-kiobuf-flush-dcache.patch"

diff -Nru linux-2.4.20/mm/memory.c.orig linux-2.4.20/mm/memory.c
--- linux-2.4.20/mm/memory.c.orig	2003-04-01 16:33:48.000000000 -0800
+++ linux-2.4.20/mm/memory.c	2003-04-01 16:41:34.000000000 -0800
@@ -553,6 +553,7 @@
 	if (err)
 		return err;
 
+	iobuf->rw = rw;
 	iobuf->locked = 0;
 	iobuf->offset = va & (PAGE_SIZE-1);
 	iobuf->length = len;
@@ -569,11 +570,10 @@
 		return err;
 	}
 	iobuf->nr_pages = err;
-	while (pgcount--) {
-		/* FIXME: flush superflous for rw==READ,
-		 * probably wrong function for rw==WRITE
-		 */
-		flush_dcache_page(iobuf->maplist[pgcount]);
+	/* if rw==WRITE, get updated data before writing them to disk */
+	if (rw==WRITE) {
+		while (pgcount--) 
+			flush_dcache_page(iobuf->maplist[pgcount]);
 	}
 	dprintk ("map_user_kiobuf: end OK\n");
 	return 0;
@@ -628,9 +628,10 @@
 		if (map) {
 			if (iobuf->locked)
 				UnlockPage(map);
-			/* FIXME: cache flush missing for rw==READ
-			 * FIXME: call the correct reference counting function
-			 */
+			/* if rw==READ, flush dcache before user uses data */
+			if (iobuf->rw==READ) {
+				flush_dcache_page(iobuf->maplist[i]);
+			}
 			page_cache_release(map);
 		}
 	}
diff -Nru linux-2.4.20/include/linux/iobuf.h.orig linux-2.4.20/include/linux/iobuf.h
--- linux-2.4.20/include/linux/iobuf.h.orig	2002-11-28 15:53:15.000000000 -0800
+++ linux-2.4.20/include/linux/iobuf.h	2003-04-01 16:34:16.000000000 -0800
@@ -32,6 +32,7 @@
 
 struct kiobuf 
 {
+	int		rw;		/* mapped for READ or WRITE */
 	int		nr_pages;	/* Pages actually referenced */
 	int		array_len;	/* Space in the allocated lists */
 	int		offset;		/* Offset to start of valid data */

--EVF5PPMfhYS0aIcm--
