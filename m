Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbTBGNdv>; Fri, 7 Feb 2003 08:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbTBGNdv>; Fri, 7 Feb 2003 08:33:51 -0500
Received: from DaVinci.coe.neu.edu ([129.10.32.95]:35775 "EHLO
	DaVinci.coe.neu.edu") by vger.kernel.org with ESMTP
	id <S265094AbTBGNdu>; Fri, 7 Feb 2003 08:33:50 -0500
Date: Fri, 7 Feb 2003 08:43:26 -0500 (EST)
From: Mauricio Martinez <mauricio@coe.neu.edu>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.20 drivers/cdrom/cdu31a.c
Message-ID: <Pine.GSO.4.33.0302070833310.15863-100000@Amps.coe.neu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the kernel oops while trying to read a data CD. Thanks to
Brian Gerst and Faik Uygur for your suggestions.

It looks like the variable nblocks must be <= 4 so the read ahead buffer
size is not exceeded (which is the cause of the oops). Changing its value
doesn't seem to be the right way, but it makes the device work properly.

Feedback of any sort welcome.


--- linux-2.4.20/drivers/cdrom/cdu31a.c.orig	Thu Nov 28 15:53:12 2002
+++ linux-2.4.20/drivers/cdrom/cdu31a.c	Thu Feb  6 20:49:44 2003
@@ -1361,7 +1361,9 @@
 	res_reg[0] = 0;
 	res_reg[1] = 0;
 	*res_size = 0;
-	bytesleft = nblocks * 512;
+	/* Make sure that bytesleft doesn't exceed the buffer size */
+	if (nblocks > 4) nblocks = 4;
+	bytesleft = nblocks * 512;
 	offset = 0;

 	/* If the data in the read-ahead does not match the block offset,
@@ -1384,9 +1386,9 @@
 			       readahead_buffer + (2048 -
 						   readahead_dataleft),
 			       readahead_dataleft);
-			readahead_dataleft = 0;
 			bytesleft -= readahead_dataleft;
 			offset += readahead_dataleft;
+			readahead_dataleft = 0;
 		} else {
 			/* The readahead will fill the whole buffer, get the data
 			   and return. */

