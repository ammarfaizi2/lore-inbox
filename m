Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUHMU3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUHMU3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 16:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUHMU3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 16:29:03 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:20173 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S267466AbUHMU0S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 16:26:18 -0400
Message-ID: <411D23B5.7000105@ttnet.net.tr>
Date: Fri, 13 Aug 2004 23:25:25 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4] comparison warning fixes
Content-Type: multipart/mixed;
	boundary="------------030806010401060002050702"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030806010401060002050702
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

Various "comparison always true/false" fixes. The coda one is
in 2.6 iirc, AM53C974.c and pcmcia ones may need review.


--------------030806010401060002050702
Content-Type: text/plain;
	name="coda-comparison.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="coda-comparison.diff"

--- 27rc5~/fs/coda/dir.c	2003-08-25 14:44:43.000000000 +0300
+++ 27rc5/fs/coda/dir.c	2004-08-07 14:09:39.000000000 +0300
@@ -589,8 +589,7 @@
 			break;
 		}
 		/* validate whether the directory file actually makes sense */
-		if (vdir->d_reclen < vdir_size + vdir->d_namlen ||
-		    vdir->d_namlen > CODA_MAXNAMLEN) {
+		if (vdir->d_reclen < vdir_size + vdir->d_namlen) {
 			printk("coda_venus_readdir: Invalid dir: %ld\n",
 			       filp->f_dentry->d_inode->i_ino);
 			ret = -EBADF;

--------------030806010401060002050702
Content-Type: text/plain;
	name="AM53C974.c-comparison.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="AM53C974.c-comparison.diff"

--- 27rc5~/drivers/scsi/AM53C974.c	2001-09-30 22:26:07.000000000 +0300
+++ 27rc5/drivers/scsi/AM53C974.c	2004-08-07 14:09:39.000000000 +0300
@@ -1612,7 +1612,7 @@
 		for (i = 0; i < sizeof(hostdata->last_message); i++)
 			hostdata->last_message[i] = hostdata->msgout[i];
 		if ((hostdata->msgout[0] == 0) || INSIDE(hostdata->msgout[0], 0x02, 0x1F) ||
-		    INSIDE(hostdata->msgout[0], 0x80, 0xFF))
+		    (hostdata->msgout[0] >= 0x80))
 			len = 1;
 		else {
 			if (hostdata->msgout[0] == EXTENDED_MESSAGE) {

--------------030806010401060002050702
Content-Type: text/plain;
	name="pcmcia-comparison.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="pcmcia-comparison.diff"

--- 27rc5~/drivers/pcmcia/i82092.c	2003-11-28 20:26:20.000000000 +0200
+++ 27rc5/drivers/pcmcia/i82092.c	2004-08-07 14:09:39.000000000 +0300
@@ -788,7 +788,7 @@
 		leave("i82092aa_set_io_map with invalid map");
 		return -EINVAL;
 	}
-	if ((io->start > 0xffff) || (io->stop > 0xffff) || (io->stop < io->start)){
+	if (io->stop < io->start){
 		leave("i82092aa_set_io_map with invalid io");
 		return -EINVAL;
 	}
--- 27rc5~/drivers/pcmcia/i82365.c	2003-11-28 20:26:20.000000000 +0200
+++ 27rc5/drivers/pcmcia/i82365.c	2004-08-07 14:09:39.000000000 +0300
@@ -1225,8 +1225,7 @@
 	  "%#4.4x-%#4.4x)\n", sock, io->map, io->flags,
 	  io->speed, io->start, io->stop);
     map = io->map;
-    if ((map > 1) || (io->start > 0xffff) || (io->stop > 0xffff) ||
-	(io->stop < io->start)) return -EINVAL;
+    if ((map > 1) || (io->stop < io->start)) return -EINVAL;
     /* Turn off the window before changing anything */
     if (i365_get(sock, I365_ADDRWIN) & I365_ENA_IO(map))
 	i365_bclr(sock, I365_ADDRWIN, I365_ENA_IO(map));
--- 27rc5~/drivers/pcmcia/tcic.c	2002-11-29 01:53:14.000000000 +0200
+++ 27rc5/drivers/pcmcia/tcic.c	2004-08-07 14:09:39.000000000 +0300
@@ -844,8 +844,7 @@
     DEBUG(1, "tcic: SetIOMap(%d, %d, %#2.2x, %d ns, "
 	  "%#4.4x-%#4.4x)\n", lsock, io->map, io->flags,
 	  io->speed, io->start, io->stop);
-    if ((io->map > 1) || (io->start > 0xffff) || (io->stop > 0xffff) ||
-	(io->stop < io->start)) return -EINVAL;
+    if ((io->map > 1) || (io->stop < io->start)) return -EINVAL;
     tcic_setw(TCIC_ADDR+2, TCIC_ADR2_INDREG | (psock << TCIC_SS_SHFT));
     addr = TCIC_IWIN(psock, io->map);
 

--------------030806010401060002050702--
