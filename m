Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280670AbRKYDZE>; Sat, 24 Nov 2001 22:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280671AbRKYDYy>; Sat, 24 Nov 2001 22:24:54 -0500
Received: from web9204.mail.yahoo.com ([216.136.129.27]:58676 "HELO
	web9204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280670AbRKYDYs>; Sat, 24 Nov 2001 22:24:48 -0500
Message-ID: <20011125032447.4327.qmail@web9204.mail.yahoo.com>
Date: Sat, 24 Nov 2001 19:24:47 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: change to fs/proc/inode.c breaks ALSA drivers
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Somewhere between 2.4.15pre6 and 2.4.15 final,
fs/proc/inode.c was modified. The change causes all
the devices files that ALSA creates in
/proc/asound/dev to have a major and minor number of
zero. I'm sending a patch to revert the file back to
what it was in 2.4.15pre5.


--- linux-2.4.15test/fs/proc/inode.c	Sat Nov 23
20:10:11 2001
+++ linux-2.4.15/fs/proc/inode.c	Sat Nov 24 19:56:21
2001
@@ -160,12 +160,14 @@
 			inode->i_nlink = de->nlink;
 		if (de->owner)
 			__MOD_INC_USE_COUNT(de->owner);
-		if (de->proc_iops)
-			inode->i_op = de->proc_iops;
-		if (de->proc_fops)
-			inode->i_fop = de->proc_fops;
-		else if
(S_ISBLK(de->mode)||S_ISCHR(de->mode)||S_ISFIFO(de->mode))
+		if
(S_ISBLK(de->mode)||S_ISCHR(de->mode)||S_ISFIFO(de->mode))
 		
init_special_inode(inode,de->mode,kdev_t_to_nr(de->rdev));
+		else {
+			if (de->proc_iops)
+				inode->i_op = de->proc_iops;
+			if (de->proc_fops)
+				inode->i_fop = de->proc_fops;
+		}
 	}
 
 out:


__________________________________________________
Do You Yahoo!?
Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
