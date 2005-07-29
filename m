Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVG2LA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVG2LA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 07:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbVG2K6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:58:46 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:47884 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262590AbVG2K4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:56:42 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] fuse: stricter mount option checking
Message-Id: <E1DySXT-0004q6-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 29 Jul 2005 12:56:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check for the presence of all mandatory mount options.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.13-rc3-mm3/fs/fuse/inode.c linux-fuse/fs/fuse/inode.c
--- linux-2.6.13-rc3-mm3/fs/fuse/inode.c	2005-07-29 11:03:38.000000000 +0200
+++ linux-fuse/fs/fuse/inode.c	2005-07-29 10:36:59.000000000 +0200
@@ -32,6 +32,10 @@ struct fuse_mount_data {
 	unsigned rootmode;
 	unsigned user_id;
 	unsigned group_id;
+	unsigned fd_present : 1;
+	unsigned rootmode_present : 1;
+	unsigned user_id_present : 1;
+	unsigned group_id_present : 1;
 	unsigned flags;
 	unsigned max_read;
 };
@@ -277,7 +281,6 @@ static int parse_fuse_opt(char *opt, str
 {
 	char *p;
 	memset(d, 0, sizeof(struct fuse_mount_data));
-	d->fd = -1;
 	d->max_read = ~0;
 
 	while ((p = strsep(&opt, ",")) != NULL) {
@@ -293,24 +296,28 @@ static int parse_fuse_opt(char *opt, str
 			if (match_int(&args[0], &value))
 				return 0;
 			d->fd = value;
+			d->fd_present = 1;
 			break;
 
 		case OPT_ROOTMODE:
 			if (match_octal(&args[0], &value))
 				return 0;
 			d->rootmode = value;
+			d->rootmode_present = 1;
 			break;
 
 		case OPT_USER_ID:
 			if (match_int(&args[0], &value))
 				return 0;
 			d->user_id = value;
+			d->user_id_present = 1;
 			break;
 
 		case OPT_GROUP_ID:
 			if (match_int(&args[0], &value))
 				return 0;
 			d->group_id = value;
+			d->group_id_present = 1;
 			break;
 
 		case OPT_DEFAULT_PERMISSIONS:
@@ -339,7 +346,9 @@ static int parse_fuse_opt(char *opt, str
 			return 0;
 		}
 	}
-	if (d->fd == -1)
+
+	if (!d->fd_present || !d->rootmode_present ||
+	    !d->user_id_present || !d->group_id_present)
 		return 0;
 
 	return 1;
