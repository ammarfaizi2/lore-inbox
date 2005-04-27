Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVD0BIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVD0BIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 21:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVD0BIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 21:08:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9657 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261874AbVD0BI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 21:08:28 -0400
Date: Tue, 26 Apr 2005 21:08:27 -0400
From: Neil Horman <nhorman@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [Patch] add check to /proc/devices read routines
Message-ID: <20050427010827.GA2451@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to add check to get_chrdev_list and get_blkdev_list to prevent reads of
/proc/devices from spilling over the provided page if more than 4096 bytes of
string data are generated from all the registered character and block devices in
a system

Signed-off-by: Neil Horman <nhorman@redhat.com>


 fs/char_dev.c         |   13 ++++++++++++-
 fs/proc/proc_misc.c   |    2 +-
 include/linux/genhd.h |    2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)



--- linux-2.6-test/fs/char_dev.c.fixproc	2005-04-26 15:27:31.000000000 -0400
+++ linux-2.6-test/fs/char_dev.c	2005-04-26 15:25:31.000000000 -0400
@@ -57,10 +57,21 @@ int get_chrdev_list(char *page)
 
 	down(&chrdevs_lock);
 	for (i = 0; i < ARRAY_SIZE(chrdevs) ; i++) {
-		for (cd = chrdevs[i]; cd; cd = cd->next)
+		for (cd = chrdevs[i]; cd; cd = cd->next) {
+			/*
+			 * if the current name, plus the 5 extra characters
+			 * in the device line for this entry
+			 * would run us off the page, we're done
+			 */
+			if((len+strlen(chrdevs[i].name) + 5) >= PAGE_SIZE) 
+				goto page_full;
+
+
 			len += sprintf(page+len, "%3d %s\n",
 				       cd->major, cd->name);
+		}
 	}
+page_full:
 	up(&chrdevs_lock);
 
 	return len;
--- linux-2.6-test/fs/proc/proc_misc.c.fixproc	2005-04-26 15:23:14.000000000 -0400
+++ linux-2.6-test/fs/proc/proc_misc.c	2005-04-26 15:23:32.000000000 -0400
@@ -433,7 +433,7 @@ static int devices_read_proc(char *page,
 				 int count, int *eof, void *data)
 {
 	int len = get_chrdev_list(page);
-	len += get_blkdev_list(page+len);
+	len += get_blkdev_list(page+len, len);
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
--- linux-2.6-test/include/linux/genhd.h.fixproc	2005-04-26 15:25:53.000000000 -0400
+++ linux-2.6-test/include/linux/genhd.h	2005-04-26 15:26:00.000000000 -0400
@@ -224,7 +224,7 @@ static inline void free_disk_stats(struc
 extern void disk_round_stats(struct gendisk *disk);
 
 /* drivers/block/genhd.c */
-extern int get_blkdev_list(char *);
+extern int get_blkdev_list(char *, int);
 extern void add_disk(struct gendisk *disk);
 extern void del_gendisk(struct gendisk *gp);
 extern void unlink_gendisk(struct gendisk *gp);
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
