Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRB1AWk>; Tue, 27 Feb 2001 19:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRB1AWb>; Tue, 27 Feb 2001 19:22:31 -0500
Received: from [199.239.160.155] ([199.239.160.155]:56078 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S130004AbRB1AWY>; Tue, 27 Feb 2001 19:22:24 -0500
Date: Tue, 27 Feb 2001 16:22:22 -0800
From: Robert Read <rread@datarithm.net>
To: linux-kernel@vger.kernel.org
Subject: [patch] set kiobuf io_count once, instead of increment
Message-ID: <20010227162222.A6389@tenchi.datarithm.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in brw_kiovec, iobuf->io_count is being incremented as each
bh is submitted, and decremented in the bh->b_end_io().  This means
io_count can go to zero before all the bhs have been submitted,
especially during a large request. This causes the end_kio_request()
to be called before all of the io is complete.  

This suggested patch against 2.4.2 sets io_count to the total amount
before the bhs are submitted, although there is probably a better way
to determine the io_count than this.

robert

diff -ru linux/fs/buffer.c linux-rm/fs/buffer.c
--- linux/fs/buffer.c	Mon Jan 15 12:42:32 2001
+++ linux-rm/fs/buffer.c	Tue Jan 30 11:41:57 2001
@@ -2085,6 +2085,7 @@
 		offset = iobuf->offset;
 		length = iobuf->length;
 		iobuf->errno = 0;
+		atomic_set(&iobuf->io_count, length/size);
 		
 		for (pageind = 0; pageind < iobuf->nr_pages; pageind++) {
 			map  = iobuf->maplist[pageind];
@@ -2119,8 +2120,6 @@
 				bh[bhind++] = tmp;
 				length -= size;
 				offset += size;
-
-				atomic_inc(&iobuf->io_count);
 
 				submit_bh(rw, tmp);
 				/* 
