Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTIRABL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 20:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbTIRABL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 20:01:11 -0400
Received: from mail5.intermedia.net ([206.40.48.155]:14860 "EHLO
	mail5.intermedia.net") by vger.kernel.org with ESMTP
	id S262906AbTIRABH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 20:01:07 -0400
Subject: [PATCH] Linux 2.6.0-test5 OOPS in sysfs
From: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-p1IJm86hVLfvcvJc6SX4"
Organization: Zultys Technologies Inc.
Message-Id: <1063843491.1532.4.camel@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 17 Sep 2003 17:04:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p1IJm86hVLfvcvJc6SX4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


A week back I ran into this bug which was causing an OOPS. Andrew Morton
sent me a fix which worked and which I acknowledged on the mailing list
as being the correct fix. However I haven't seen this fix make its way
into the code, so I am sending it again.

Please note that the bug was fixed by Andrew, not me.

thanks,
-- 

Ranjeet Shetye
Senior Software Engineer
Zultys Technologies
Ranjeet dot Shetye2 at Zultys dot com
http://www.zultys.com/
 
The views, opinions, and judgements expressed in this message are solely
those of the author. The message contents have not been reviewed or
approved by Zultys.


--=-p1IJm86hVLfvcvJc6SX4
Content-Disposition: attachment; filename=sysfs.bug.patch
Content-Type: text/x-patch; name=sysfs.bug.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: fs/sysfs/dir.c
===================================================================
RCS file: /home/cvs/linux-2.5/fs/sysfs/dir.c,v
retrieving revision 1.8
diff -d -u -r1.8 dir.c
--- fs/sysfs/dir.c	5 Sep 2003 21:17:55 -0000	1.8
+++ fs/sysfs/dir.c	17 Sep 2003 22:15:21 -0000
@@ -24,10 +24,11 @@
 static struct dentry * 
 create_dir(struct kobject * k, struct dentry * p, const char * n)
 {
-	struct dentry * dentry;
+	struct dentry * dentry, * ret;
 
 	down(&p->d_inode->i_sem);
 	dentry = sysfs_get_dentry(p,n);
+	ret = dentry;
 	if (!IS_ERR(dentry)) {
 		int error = sysfs_create(dentry,
 					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
@@ -36,11 +37,11 @@
 			dentry->d_fsdata = k;
 			p->d_inode->i_nlink++;
 		} else
-			dentry = ERR_PTR(error);
+			ret = ERR_PTR(error);
 		dput(dentry);
 	}
 	up(&p->d_inode->i_sem);
-	return dentry;
+	return ret;
 }
 
 

--=-p1IJm86hVLfvcvJc6SX4--

