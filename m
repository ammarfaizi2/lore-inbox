Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263497AbREYCtu>; Thu, 24 May 2001 22:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263494AbREYCtl>; Thu, 24 May 2001 22:49:41 -0400
Received: from venus.cs.uml.edu ([129.63.8.51]:47517 "EHLO venus.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263493AbREYCtZ>;
	Thu, 24 May 2001 22:49:25 -0400
Date: Thu, 24 May 2001 22:49:23 -0400 (EDT)
From: Mike Brown <mbrown@cs.uml.edu>
To: linux-scsi@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] memory leak in scsi_proc.c
Message-ID: <Pine.OSF.3.96.1010524223647.334235J-100000@venus.cs.uml.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If someone writes to a scsi adapter's /proc entry and that scsi adapter
has not defined a proc_info() entry point, proc_scsi_write() will leak a
page.  Furthermore, no sense asking for a page if said proc_info() entry
point does not exist.  This patch fixes the above problem and patches
cleanly against 2.4.4

--- drivers/scsi/scsi_proc.c.orig       Fri Feb  9 14:30:23 2001
+++ drivers/scsi/scsi_proc.c    Thu May 24 22:26:59 2001
@@ -99,6 +99,9 @@
        char * page;
        char *start;
     
+       if (hpnt->hostt->proc_info == NULL)
+               return -ENOSYS;
+
        if (count > PROC_BLOCK_SIZE)
                return -EOVERFLOW;
 
@@ -106,12 +109,10 @@
                return -ENOMEM;
        copy_from_user(page, buf, count);
 
-       if (hpnt->hostt->proc_info == NULL)
-               ret = -ENOSYS;
-       else
-               ret = hpnt->hostt->proc_info(page, &start, 0, count,
-                                               hpnt->host_no, 1);
+        ret = hpnt->hostt->proc_info(page, &start, 0, count,
+                                     hpnt->host_no, 1);
        free_page((ulong) page);
+
        return(ret);
 }
 

-Michael F. Brown, UMass Lowell Computer Science

email:  mbrown@cs.uml.edu

"In theory, there is no difference between theory and practice,
 but in practice, there is."       - Jan L.A. van de Snepscheut

