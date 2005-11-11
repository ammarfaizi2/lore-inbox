Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbVKKQt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVKKQt3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVKKQt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:49:28 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:48260 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750892AbVKKQt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:49:27 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.52083.510971.403797@tut.ibm.com>
Date: Fri, 11 Nov 2005 10:48:51 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 4/12] relayfs: use generic_ip for private data
In-Reply-To: <17268.51814.215178.281986@tut.ibm.com>
References: <17268.51814.215178.281986@tut.ibm.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use inode->u.generic_ip instead of relayfs_inode_info to store pointer
to user data.  Clients using relayfs_file_create() to create their own
files would probably more expect their data to be stored in
generic_ip; we also intend in the next set of patches to get rid of
relayfs-specific stuff in the file operations, so we might as well do
it here.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 inode.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/relayfs/inode.c b/fs/relayfs/inode.c
--- a/fs/relayfs/inode.c
+++ b/fs/relayfs/inode.c
@@ -54,7 +54,8 @@ static struct inode *relayfs_get_inode(s
 	switch (mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_fop = fops;
-		RELAYFS_I(inode)->data = data;
+		if (data)
+			inode->u.generic_ip = data;
 		break;
 	case S_IFDIR:
 		inode->i_op = &simple_dir_inode_operations;
@@ -255,8 +256,9 @@ int relayfs_remove_dir(struct dentry *de
  */
 static int relayfs_open(struct inode *inode, struct file *filp)
 {
-	struct rchan_buf *buf = RELAYFS_I(inode)->data;
+	struct rchan_buf *buf = inode->u.generic_ip;
 	kref_get(&buf->kref);
+	filp->private_data = buf;
 
 	return 0;
 }
@@ -270,8 +272,8 @@ static int relayfs_open(struct inode *in
  */
 static int relayfs_mmap(struct file *filp, struct vm_area_struct *vma)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
-	return relay_mmap_buf(RELAYFS_I(inode)->data, vma);
+	struct rchan_buf *buf = filp->private_data;
+	return relay_mmap_buf(buf, vma);
 }
 
 /**
@@ -284,8 +286,7 @@ static int relayfs_mmap(struct file *fil
 static unsigned int relayfs_poll(struct file *filp, poll_table *wait)
 {
 	unsigned int mask = 0;
-	struct inode *inode = filp->f_dentry->d_inode;
-	struct rchan_buf *buf = RELAYFS_I(inode)->data;
+	struct rchan_buf *buf = filp->private_data;
 
 	if (buf->finalized)
 		return POLLERR;
@@ -309,7 +310,7 @@ static unsigned int relayfs_poll(struct 
  */
 static int relayfs_release(struct inode *inode, struct file *filp)
 {
-	struct rchan_buf *buf = RELAYFS_I(inode)->data;
+	struct rchan_buf *buf = filp->private_data;
 	kref_put(&buf->kref, relay_remove_buf);
 
 	return 0;
@@ -470,8 +471,8 @@ static ssize_t relayfs_read(struct file 
 			    size_t count,
 			    loff_t *ppos)
 {
+	struct rchan_buf *buf = filp->private_data;
 	struct inode *inode = filp->f_dentry->d_inode;
-	struct rchan_buf *buf = RELAYFS_I(inode)->data;
 	size_t read_start, avail;
 	ssize_t ret = 0;
 	void *from;


