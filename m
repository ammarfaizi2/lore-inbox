Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265101AbRGWXz7>; Mon, 23 Jul 2001 19:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265133AbRGWXzt>; Mon, 23 Jul 2001 19:55:49 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:53521 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265101AbRGWXzh>; Mon, 23 Jul 2001 19:55:37 -0400
From: Nathan Laredo <nlaredo@transmeta.com>
Message-Id: <200107232355.QAA01785@nil.transmeta.com>
Subject: patch for allowing msdos/vfat nfs exports
To: linux-kernel@vger.kernel.org
Date: Mon, 23 Jul 2001 16:55:17 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Linus was nice enough to change the kernel this morning for me
to allow msdos/vfat NFS exports.  Since this is totally new code
and there is no guarantee it won't destroy everything on your
fat filesystem he asked me to post the diff to the kernel mailing
list so more people could look at it/test it out before it goes
back into the standard kernel.

The patch below is relative to Linus' current working tree
(which should be the same 2.4.7 in theory).

I've been using it for half a day now and so far it hasn't done
anything bad, but please be careful if you decide to test it and
backup your data and after testing, be sure to compare your data
to your backup.

Note: this patch will NOT work for older kernels.  dentry_to_fh and
fh_to_dentry are provided (just as in reiserfs).

Please send me email directly with your experiences using this patch
since I offered to collect them for Linus.

-- Nathan Laredo
nlaredo@transmeta.com


diff -r -u linux/fs/fat/inode.c linux-new/fs/fat/inode.c
--- linux/fs/fat/inode.c	Mon Jun 11 19:15:27 2001
+++ linux-new/fs/fat/inode.c	Mon Jul 23 14:35:41 2001
@@ -403,12 +403,60 @@
 	inode->i_nlink = fat_subdirs(inode)+2;
 }
 
+static int fat_dentry_to_fh(struct dentry *dentry, __u32 *data, int *lenp, int need_parent)
+{
+	struct inode *inode = dentry->d_inode;
+	unsigned int i_pos = MSDOS_I(inode)->i_location;
+
+	*data = i_pos;
+	*lenp = 1;
+	return 1;
+}
+
+static struct dentry *fat_fh_to_dentry(struct super_block *sb, __u32 *data, int len, int fhtype, int parent)
+{
+	struct list_head *lp;
+	struct dentry *result;
+	unsigned int i_pos = data[0];
+	struct inode *inode;
+
+	inode = fat_iget(sb, i_pos);
+
+	if (!inode)
+		return ERR_PTR(-ESTALE);
+
+	/* now to find a dentry.
+	 * If possible, get a well-connected one
+	 */
+	spin_lock(&dcache_lock);
+	for (lp = inode->i_dentry.next; lp != &inode->i_dentry ; lp=lp->next) {
+	        result = list_entry(lp,struct dentry, d_alias);
+	        if (! (result->d_flags & DCACHE_NFSD_DISCONNECTED)) {
+	                 dget_locked(result);
+	                 result->d_vfs_flags |= DCACHE_REFERENCED;
+	                 spin_unlock(&dcache_lock);
+	                 iput(inode);
+	                 return result;
+	         }
+	}
+	spin_unlock(&dcache_lock);
+	result = d_alloc_root(inode);
+	if (result == NULL) {
+	         iput(inode);
+	         return ERR_PTR(-ENOMEM);
+	}
+	result->d_flags |= DCACHE_NFSD_DISCONNECTED;
+	return result;
+}
+
 static struct super_operations fat_sops = { 
 	write_inode:	fat_write_inode,
 	delete_inode:	fat_delete_inode,
 	put_super:	fat_put_super,
 	statfs:		fat_statfs,
 	clear_inode:	fat_clear_inode,
+	fh_to_dentry:	fat_fh_to_dentry,
+	dentry_to_fh:	fat_dentry_to_fh
 };
 
 /*

