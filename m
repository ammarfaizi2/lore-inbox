Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWG1Acc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWG1Acc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 20:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWG1Acb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 20:32:31 -0400
Received: from ns.suse.de ([195.135.220.2]:34183 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750919AbWG1AcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 20:32:13 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Jul 2006 10:31:30 +1000
Message-Id: <1060728003130.15224@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 2] knfsd: Make ext3 reject filehandles referring to invalid inode numbers
References: <20060728102713.15132.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Inodes earlier than the 'first' inode (e.g. journal,
resize) should be rejected early - except the root inode.
Also inode numbers that are too big should be rejected early.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/ext3/super.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff .prev/fs/ext3/super.c ./fs/ext3/super.c
--- .prev/fs/ext3/super.c	2006-07-28 10:18:55.000000000 +1000
+++ ./fs/ext3/super.c	2006-07-28 10:25:20.000000000 +1000
@@ -554,6 +554,48 @@ static int ext3_show_options(struct seq_
 	return 0;
 }
 
+
+static struct dentry *ext3_get_dentry(struct super_block *sb, void *vobjp)
+{
+	__u32 *objp = vobjp;
+	unsigned long ino = objp[0];
+	__u32 generation = objp[1];
+	struct inode *inode;
+	struct dentry *result;
+
+	if (ino != EXT3_ROOT_INO && ino < EXT3_FIRST_INO(sb))
+		return ERR_PTR(-ESTALE);
+	if (ino > le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count))
+		return ERR_PTR(-ESTALE);
+
+	/* iget isn't really right if the inode is currently unallocated!!
+	 *
+	 * ext3_read_inode will return a bad_inode if the inode had been deleted.
+	 * so we should be safe.
+	 *
+	 * Currently we don't know the generation for parent directory, so
+	 * a generation of 0 means "accept any"
+	 */
+	inode = iget(sb, ino);
+	if (inode == NULL)
+		return ERR_PTR(-ENOMEM);
+	if (is_bad_inode(inode)
+	    || (generation && inode->i_generation != generation)
+		) {
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
 #ifdef CONFIG_QUOTA
 #define QTYPE2NAME(t) ((t)==USRQUOTA?"user":"group")
 #define QTYPE2MOPT(on, t) ((t)==USRQUOTA?((on)##USRJQUOTA):((on)##GRPJQUOTA))
@@ -622,6 +664,7 @@ static struct super_operations ext3_sops
 
 static struct export_operations ext3_export_ops = {
 	.get_parent = ext3_get_parent,
+	.get_dentry = ext3_get_dentry,
 };
 
 enum {
