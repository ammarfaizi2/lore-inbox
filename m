Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVD0L2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVD0L2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 07:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVD0L2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 07:28:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:221 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261433AbVD0L2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 07:28:42 -0400
Date: Wed, 27 Apr 2005 07:28:41 -0400
From: Neil Horman <nhorman@redhat.com>
To: Dave Jones <davej@redhat.com>, Neil Horman <nhorman@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] add check to /proc/devices read routines
Message-ID: <20050427112841.GA3305@hmsendeavour.rdu.redhat.com>
References: <20050427010827.GA2451@hmsendeavour.rdu.redhat.com> <20050427012003.GA31496@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427012003.GA31496@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 09:20:03PM -0400, Dave Jones wrote:
> On Tue, Apr 26, 2005 at 09:08:27PM -0400, Neil Horman wrote:
>  > Patch to add check to get_chrdev_list and get_blkdev_list to prevent reads of
>  > /proc/devices from spilling over the provided page if more than 4096 bytes of
>  > string data are generated from all the registered character and block devices in
>  > a system

Crud, your right, sorry.  I misnamed my origional file for genhd, so it skipped
when I ran gendiff.  New patch attached with missing genhd.c bits.  Regards the
seq_file change, I agree that that would probably be the best long term
solution, but at the moment everything in proc_misc.c does this, and has a
simmilar check.  I'll happily work on the seq_file conversion, but since thats a
larger amount of work, I figure it would be best to plug this oops in the same
way the other files do it in the short term.

Signed-off-by: Neil Horman <nhorman@redhat.com>

 drivers/block/genhd.c |   12 ++++++++++--
 fs/char_dev.c         |   13 ++++++++++++-
 fs/proc/proc_misc.c   |    2 +-
 include/linux/genhd.h |    2 +-
 4 files changed, 24 insertions(+), 5 deletions(-)


--- linux-2.6-test/fs/char_dev.c.fixproc	2005-04-26 15:27:31.000000000 -0400
+++ linux-2.6-test/fs/char_dev.c	2005-04-26 15:58:16.000000000 -0400
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
+			if((len+strlen(cd->name) + 5) >= PAGE_SIZE) 
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
--- linux-2.6-test/drivers/block/genhd.c.fixproc	2005-04-26 14:33:01.000000000 -0400
+++ linux-2.6-test/drivers/block/genhd.c	2005-04-26 16:27:41.000000000 -0400
@@ -39,7 +39,7 @@ static inline int major_to_index(int maj
 
 #ifdef CONFIG_PROC_FS
 /* get block device names in somewhat random order */
-int get_blkdev_list(char *p)
+int get_blkdev_list(char *p, int used)
 {
 	struct blk_major_name *n;
 	int i, len;
@@ -48,10 +48,18 @@ int get_blkdev_list(char *p)
 
 	down(&block_subsys_sem);
 	for (i = 0; i < ARRAY_SIZE(major_names); i++) {
-		for (n = major_names[i]; n; n = n->next)
+		for (n = major_names[i]; n; n = n->next) {
+			/*
+			 *if the curent string plus the 5 extra characters 
+			 *in the line would run us off the page, then we're done
+			 */
+			if((len+used+strlen(n->name)+5) >= PAGE_SIZE)
+				goto page_full;
 			len += sprintf(p+len, "%3d %s\n",
 				       n->major, n->name);
+		}
 	}
+page_full:
 	up(&block_subsys_sem);
 
 	return len;
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
