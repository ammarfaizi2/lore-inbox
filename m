Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263397AbREXHcy>; Thu, 24 May 2001 03:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263398AbREXHch>; Thu, 24 May 2001 03:32:37 -0400
Received: from smtp2.Stanford.EDU ([171.64.14.116]:21488 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263397AbREXHcX>; Thu, 24 May 2001 03:32:23 -0400
Message-Id: <200105240732.f4O7WLH23332@smtp2.Stanford.EDU>
Content-Type: text/plain; charset=US-ASCII
From: Praveen Srinivasan <praveens@stanford.edu>
Organization: Stanford University
To: torvalds@transmeta.com
Subject: [PATCH] md.c - null ptr fixes for 2.4.4
Date: Thu, 24 May 2001 00:33:27 -0700
X-Mailer: KMail [version 1.2.2]
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, mingo@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch fixes some unchecked ptr bugs in the multiple devices driver 
(RAID) code (md.c).

Praveen Srinivasan and Frederick Akalin

--- ../linux/./drivers/md/md.c	Fri Apr  6 10:42:55 2001
+++ ./drivers/md/md.c	Mon May  7 22:08:02 2001
@@ -3756,6 +3756,7 @@
 			continue;
 		}
 		mddev = alloc_mddev(MKDEV(MD_MAJOR,minor));
+
 		if (md_setup_args.pers[minor]) {
 			/* non-persistent */
 			mdu_array_info_t ainfo;
@@ -3773,7 +3774,12 @@
 			ainfo.spare_disks = 0;
 			ainfo.layout = 0;
 			ainfo.chunk_size = md_setup_args.chunk[minor];
-			err = set_array_info(mddev, &ainfo);
+			if(mddev==NULL){
+			    err=1;
+			  }
+			else {
+			  err = set_array_info(mddev, &ainfo);
+			}
 			for (i = 0; !err && (dev = md_setup_args.devices[minor][i]); i++) {
 				dinfo.number = i;
 				dinfo.raid_disk = i;
@@ -3797,9 +3803,12 @@
 		if (!err)
 			err = do_md_run(mddev);
 		if (err) {
-			mddev->sb_dirty = 0;
-			do_md_stop(mddev, 0);
-			printk("md: starting md%d failed\n", minor);
+		  if(mddev !=NULL){
+		    mddev->sb_dirty = 0;
+		    do_md_stop(mddev, 0);
+		  }
+		
+		  printk("md: starting md%d failed\n", minor);
 		}
 	}
 }
