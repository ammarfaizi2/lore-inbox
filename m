Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbTEDRKK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 13:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbTEDRKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 13:10:09 -0400
Received: from verein.lst.de ([212.34.181.86]:28943 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261244AbTEDRKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 13:10:08 -0400
Date: Sun, 4 May 2003 19:22:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] remove devfs special casing from disk_name
Message-ID: <20030504192236.A10765@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently disk_name() does some special casing to print the devfs
pathname for a gendisk instead of the disk_name as used all over the
kernel (which is the same/similar to the old-style device name but
not in any way connected to it).  There's two problems with this

 a) the devfs name is often too long for BDEVNAME_SIZE and thus
    gets truncated by snprintf
 b) having the kernel behave differently depending on whether devfs
    is compiled in or not is a bad thing.  One of my goals for 2.5
    is that devfs has no effect on the kernel except creating the
    devfs entries.

If there's some reason you can't live with the change below please
speak up (and no, "the devfs name looks prettier" or "it would confuse
Aunt Tillie" are not good enough arguments).


--- 1.108/fs/partitions/check.c	Tue Apr 29 17:42:50 2003
+++ edited/fs/partitions/check.c	Fri May  2 09:41:04 2003
@@ -96,19 +96,6 @@
 
 char *disk_name(struct gendisk *hd, int part, char *buf)
 {
-#ifdef CONFIG_DEVFS_FS
-	if (hd->devfs_name[0] != '\0') {
-		if (part)
-			snprintf(buf, BDEVNAME_SIZE, "%s/part%d",
-					hd->devfs_name, part);
-		else if (hd->minors != 1)
-			snprintf(buf, BDEVNAME_SIZE, "%s/disc", hd->devfs_name);
-		else
-			snprintf(buf, BDEVNAME_SIZE, "%s", hd->devfs_name);
-		return buf;
-	}
-#endif
-
 	if (!part)
 		snprintf(buf, BDEVNAME_SIZE, "%s", hd->disk_name);
 	else if (isdigit(hd->disk_name[strlen(hd->disk_name)-1]))
