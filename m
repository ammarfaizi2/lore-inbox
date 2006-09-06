Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWIFXN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWIFXN6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWIFXBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:01:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:62155 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964894AbWIFXA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:00:59 -0400
Date: Wed, 6 Sep 2006 15:55:26 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Marcel Holtmann <marcel@holtmann.org>, Neil Brown <neilb@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 07/37] Have ext2 reject file handles with bad inode numbers early.
Message-ID: <20060906225526.GH15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="have-ext2-reject-file-handles-with-bad-inode-numbers-early.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Neil Brown <neilb@suse.de>

This prevents bad inode numbers from triggering errors in
ext2_get_inode.


Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/ext2/super.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

--- linux-2.6.17.11.orig/fs/ext2/super.c
+++ linux-2.6.17.11/fs/ext2/super.c
@@ -252,6 +252,46 @@ static struct super_operations ext2_sops
 #endif
 };
 
+static struct dentry *ext2_get_dentry(struct super_block *sb, void *vobjp)
+{
+	__u32 *objp = vobjp;
+	unsigned long ino = objp[0];
+	__u32 generation = objp[1];
+	struct inode *inode;
+	struct dentry *result;
+
+	if (ino != EXT2_ROOT_INO && ino < EXT2_FIRST_INO(sb))
+		return ERR_PTR(-ESTALE);
+	if (ino > le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count))
+		return ERR_PTR(-ESTALE);
+
+	/* iget isn't really right if the inode is currently unallocated!!
+	 * ext2_read_inode currently does appropriate checks, but
+	 * it might be "neater" to call ext2_get_inode first and check
+	 * if the inode is valid.....
+	 */
+	inode = iget(sb, ino);
+	if (inode == NULL)
+		return ERR_PTR(-ENOMEM);
+	if (is_bad_inode(inode)
+	    || (generation && inode->i_generation != generation)
+		) {
+		/* we didn't find the right inode.. */
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+	/* now to find a dentry.
+	 * If possible, get a well-connected one
+	 */
+	result = d_alloc_anon(inode);
+	if (!result) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+	return result;
+}
+
+
 /* Yes, most of these are left as NULL!!
  * A NULL value implies the default, which works with ext2-like file
  * systems, but can be improved upon.
@@ -259,6 +299,7 @@ static struct super_operations ext2_sops
  */
 static struct export_operations ext2_export_ops = {
 	.get_parent = ext2_get_parent,
+	.get_dentry = ext2_get_dentry,
 };
 
 static unsigned long get_sb_block(void **data)

--
