Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312987AbSC0KFh>; Wed, 27 Mar 2002 05:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312988AbSC0KFS>; Wed, 27 Mar 2002 05:05:18 -0500
Received: from www.wen-online.de ([212.223.88.39]:22291 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S312987AbSC0KFO>;
	Wed, 27 Mar 2002 05:05:14 -0500
Date: Wed, 27 Mar 2002 11:24:46 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Alexander Viro <viro@math.psu.edu>
Subject: [patch] Re: 2.5.7 rm -r in tmpfs problem
In-Reply-To: <Pine.LNX.4.10.10203261736010.440-100000@mikeg.wen-online.de>
Message-ID: <Pine.LNX.4.10.10203271112410.639-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2002, Mike Galbraith wrote:

> On Sat, 23 Mar 2002, Alexander Viro wrote:
> 
> > There are known problems with rm(1) on ramfs/tmpfs/etc. - the thing assumes
> > that offsets in directory remain stable after unlink(2), but locking changes
> > didn't affect.
> 
> Ok, I finally found a wee bit of clue.  I understand the assumption,
> and in virgin 2.5.4, that assumption is enforced... somefsckingwhere ;-)

I suppose that doesn't matter much though, since the assumption working
still doesn't make it right. (mentioned it because I can't figure out
why the behavior changed despite MUCH reading.. seemed odd/reportable)

Anyway, the hack below seems to work fine.  Is there a better way?

	-Mike


--- fs/libfs.c.org	Sun Mar 24 13:20:39 2002
+++ fs/libfs.c	Wed Mar 27 10:46:13 2002
@@ -29,6 +29,21 @@
 	return 0;
 }
 
+static int seek_ok(struct dentry *dir, int offset)
+{
+	struct list_head *list;
+	int count = 2;
+
+	list = dir->d_subdirs.next;
+
+	while(list != &dir->d_subdirs) {
+		list = list->next;
+		count++;
+	}
+	
+	return offset > count;
+}
+
 /*
  * Directory is locked and all positive dentries in it are safe, since
  * for ramfs-type trees they can't go away without unlink() or rmdir(),
@@ -37,10 +52,9 @@
 
 int dcache_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
-	int i;
+	int i = filp->f_pos;
 	struct dentry *dentry = filp->f_dentry;
 
-	i = filp->f_pos;
 	switch (i) {
 		case 0:
 			if (filldir(dirent, ".", 1, i, dentry->d_inode->i_ino, DT_DIR) < 0)
@@ -57,11 +71,17 @@
 		default: {
 			struct list_head *list;
 			int j = i-2;
+			int abort;
 
 			spin_lock(&dcache_lock);
 			list = dentry->d_subdirs.next;
+			/*
+			 * HACK: if we're attempting to seek _past_ the last
+			 * entry, the directory is being modified. Abort seek.
+			 */
+			abort = seek_ok(dentry, i);
 
-			for (;;) {
+			for (;!abort;) {
 				if (list == &dentry->d_subdirs) {
 					spin_unlock(&dcache_lock);
 					return 0;


