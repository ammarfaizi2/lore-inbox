Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263684AbREYKTY>; Fri, 25 May 2001 06:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263683AbREYKTP>; Fri, 25 May 2001 06:19:15 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:17 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263674AbREYKTG>;
	Fri, 25 May 2001 06:19:06 -0400
Date: Fri, 25 May 2001 06:19:05 -0400 (EDT)
From: Mike Brown <mbrown@cs.uml.edu>
Message-Id: <200105251019.f4PAJ5h466785@saturn.cs.uml.edu>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] memory leak in scsi_proc.c (fixed patch error)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

fixed patch poster earlier.  PINE's default editor munged it up.  Also changed
the 8 spaces indentation to a tab character.

Sorry about that.

> If someone writes to a scsi adapter's /proc entry and that scsi adapter
> has not defined a proc_info() entry point, proc_scsi_write() will leak a
> page.  Furthermore, no sense asking for a page if said proc_info() entry
> point does not exist.  This patch fixes the above problem and patches
> cleanly against 2.4.4


--- drivers/scsi/scsi_proc.c.orig	Fri May 25 06:01:20 2001
+++ drivers/scsi/scsi_proc.c	Fri May 25 06:04:16 2001
@@ -99,6 +99,9 @@
 	char * page;
 	char *start;
     
+	if (hpnt->hostt->proc_info == NULL)
+		ret = -ENOSYS;
+
 	if (count > PROC_BLOCK_SIZE)
 		return -EOVERFLOW;
 
@@ -106,11 +109,9 @@
 		return -ENOMEM;
 	copy_from_user(page, buf, count);
 
-	if (hpnt->hostt->proc_info == NULL)
-		ret = -ENOSYS;
-	else
-		ret = hpnt->hostt->proc_info(page, &start, 0, count,
-						hpnt->host_no, 1);
+	ret = hpnt->hostt->proc_info(page, &start, 0, count,
+				     hpnt->host_no, 1);
+
 	free_page((ulong) page);
 	return(ret);
 }
