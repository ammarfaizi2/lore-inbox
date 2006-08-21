Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWHUSr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWHUSr4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWHUSr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:47:56 -0400
Received: from ns1.suse.de ([195.135.220.2]:23942 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750719AbWHUSri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:47:38 -0400
Date: Mon, 21 Aug 2006 11:45:46 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Eric Sandeen <esandeen@redhat.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Eric Sandeen <sandeen@sandeen.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 01/20] Have ext3 reject file handles with bad inode numbers early
Message-ID: <20060821184546.GB21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="have-ext3-reject-file-handles-with-bad-inode-numbers-early.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
blatantly ripped off from Neil Brown's ext2 patch.


Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
Acked-by: "Theodore Ts'o" <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/ext3/super.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

--- linux-2.6.17.8.orig/fs/ext3/super.c
+++ linux-2.6.17.8/fs/ext3/super.c
@@ -620,8 +620,48 @@ static struct super_operations ext3_sops
 #endif
 };
 
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
+	 * ext3_read_inode currently does appropriate checks, but
+	 * it might be "neater" to call ext3_get_inode first and check
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
 static struct export_operations ext3_export_ops = {
 	.get_parent = ext3_get_parent,
+	.get_dentry = ext3_get_dentry,
 };
 
 enum {

--
