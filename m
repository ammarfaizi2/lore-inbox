Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265849AbRGJHJw>; Tue, 10 Jul 2001 03:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265846AbRGJHJm>; Tue, 10 Jul 2001 03:09:42 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:5316 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S265878AbRGJHJW>;
	Tue, 10 Jul 2001 03:09:22 -0400
Message-ID: <3B4AABE2.99475E56@sun.com>
Date: Tue, 10 Jul 2001 00:16:50 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  Minor misc SCSI tweaks
Content-Type: multipart/mixed;
 boundary="------------1EA57E6F4B137AAFCFB56427"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1EA57E6F4B137AAFCFB56427
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Attached is a small patch fixing some minor misc. SCSI issues (Duncan
Laurie's work).  These are against 2.4.6, for general inclusion.

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------1EA57E6F4B137AAFCFB56427
Content-Type: text/plain; charset=us-ascii;
 name="scsi_misc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi_misc.diff"

diff -ruN dist-2.4.6/drivers/scsi/scsi.c cobalt-2.4.6/drivers/scsi/scsi.c
--- dist-2.4.6/drivers/scsi/scsi.c	Tue Jun 12 11:06:54 2001
+++ cobalt-2.4.6/drivers/scsi/scsi.c	Mon Jul  9 11:04:11 2001
@@ -82,7 +82,7 @@
 #endif
 
 /*
-   static const char RCSid[] = "$Header: /vger/u4/cvs/linux/drivers/scsi/scsi.c,v 1.38 1997/01/19 23:07:18 davem Exp $";
+   static const char RCSid[] = "$Header: /home/cvs/linux-2.4/drivers/scsi/scsi.c,v 1.1.1.4 2001/05/30 01:05:04 thockin Exp $";
  */
 
 /*
@@ -1823,6 +1823,8 @@
 				 */
 	pcount = next_scsi_host;
 
+	MOD_INC_USE_COUNT;
+
 	/* The detect routine must carefully spinunlock/spinlock if 
 	   it enables interrupts, since all interrupt handlers do 
 	   spinlock as well.
@@ -1952,8 +1954,6 @@
 	       (scsi_init_memory_start - scsi_memory_lower_value) / 1024,
 	       (scsi_memory_upper_value - scsi_init_memory_start) / 1024);
 #endif
-
-	MOD_INC_USE_COUNT;
 
 	if (out_of_space) {
 		scsi_unregister_host(tpnt);	/* easiest way to clean up?? */
diff -ruN dist-2.4.6/drivers/scsi/sd.c cobalt-2.4.6/drivers/scsi/sd.c
--- dist-2.4.6/drivers/scsi/sd.c	Tue Jun 12 11:17:17 2001
+++ cobalt-2.4.6/drivers/scsi/sd.c	Mon Jul  9 11:04:11 2001
@@ -145,6 +151,9 @@
 	int diskinfo[4];
     
 	SDev = rscsi_disks[DEVICE_NR(dev)].device;
+	if (!SDev)
+		return -ENODEV;
+
 	/*
 	 * If we are in the middle of error recovery, don't let anyone
 	 * else try and use this device.  Also, if error recovery fails, it
@@ -502,6 +515,8 @@
 
 	target = DEVICE_NR(inode->i_rdev);
 	SDev = rscsi_disks[target].device;
+	if (!SDev)
+		return -ENODEV;
 
 	SDev->access_count--;
 
@@ -734,8 +759,15 @@
 	 */
 
 	SRpnt = scsi_allocate_request(rscsi_disks[i].device);
+	if (!SRpnt)
+		return i;
 
 	buffer = (unsigned char *) scsi_malloc(512);
+	if (!buffer) {
+		scsi_release_request(SRpnt);
+		SRpnt = NULL;
+		return i;
+	}
 
 	spintime = 0;
 

--------------1EA57E6F4B137AAFCFB56427--

