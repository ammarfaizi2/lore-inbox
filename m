Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314675AbSEUPBH>; Tue, 21 May 2002 11:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314682AbSEUPBG>; Tue, 21 May 2002 11:01:06 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:42001 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S314675AbSEUPBF>; Tue, 21 May 2002 11:01:05 -0400
To: reneb@cistron.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS kernel2.5.17 in vatfs?
In-Reply-To: <slrnaekbe3.4u.reneb@orac.aais.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 22 May 2002 00:00:47 +0900
Message-ID: <87vg9ha6lc.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Blokland <reneb@orac.aais.org> writes:

> Hi all When installing vmlinuz op a fat partinion i get a nice :-/ oops
> If you need more information please tell me.
> Thanks Rene

Probably, the following patch fixes this.  NOTE, however I haven't even
compiled this yet.

--- linux-cvs/fs/vfat/namei.c.orig	Tue May 21 21:59:42 2002
+++ linux-cvs/fs/vfat/namei.c	Tue May 21 21:58:25 2002
@@ -1020,16 +1020,12 @@
 	unlock_kernel();
 	dentry->d_op = &vfat_dentry_ops[table];
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
-	if (inode) {
-		dentry = d_splice_alias(inode, dentry);
-		if (dentry) {
-			dentry->d_op = &vfat_dentry_ops[table];
-			dentry->d_time = dentry->d_parent->d_inode->i_version;
-		}
-		return dentry;
+	dentry = d_splice_alias(inode, dentry);
+	if (dentry) {
+		dentry->d_op = &vfat_dentry_ops[table];
+		dentry->d_time = dentry->d_parent->d_inode->i_version;
 	}
-	d_add(dentry,inode);
-	return NULL;
+	return dentry;
 }
 
 int vfat_create(struct inode *dir,struct dentry* dentry,int mode)
--- linux-cvs/fs/msdos/namei.c.orig	Tue May 21 22:02:08 2002
+++ linux-cvs/fs/msdos/namei.c	Tue May 21 22:01:46 2002
@@ -221,22 +221,17 @@
 	if (res)
 		goto out;
 add:
-	if (inode) {
-		dentry = d_splice_alias(inode, dentry);
-		dentry->d_op = &msdos_dentry_operations;
-	} else {
-		d_add(dentry, inode);
-		dentry = NULL;
-	}
 	res = 0;
+	dentry = d_splice_alias(inode, dentry);
+	if (dentry)
+		dentry->d_op = &msdos_dentry_operations;
 out:
 	if (bh)
 		fat_brelse(sb, bh);
 	unlock_kernel();
-	if (res)
-		return ERR_PTR(res);
-	else
+	if (!res)
 		return dentry;
+	return ERR_PTR(res);
 }
 
 /***** Creates a directory entry (name is already formatted). */

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
