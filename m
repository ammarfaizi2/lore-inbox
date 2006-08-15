Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWHOPy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWHOPy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWHOPy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:54:57 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:9397 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030348AbWHOPy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:54:56 -0400
Date: Tue, 15 Aug 2006 10:54:29 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] eCryptfs: Mutex fixes
Message-ID: <20060815155429.GA3267@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The MD5 TFM for an inode might be manipulated concurrently if two
separate reads on the same file occur. The crypt_stat struct for the
same inode may be manipulated concurrently if two open events on the
same inode occur. This patch adds mutex locks to resolve these issues.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c |    2 ++
 fs/ecryptfs/file.c   |    6 ++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

13663b8871df88686621ca9b701392235bf838c0
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index a7889cc..39d7ec0 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -97,6 +97,7 @@ static int ecryptfs_calculate_md5(char *
 	int rc = 0;
 	struct scatterlist sg;
 
+	mutex_lock(&crypt_stat->cs_md5_tfm_mutex);
 	sg_init_one(&sg, (u8 *)src, len);
 	if (!crypt_stat->md5_tfm) {
 		crypt_stat->md5_tfm =
@@ -111,6 +112,7 @@ static int ecryptfs_calculate_md5(char *
 	crypto_digest_init(crypt_stat->md5_tfm);
 	crypto_digest_update(crypt_stat->md5_tfm, &sg, 1);
 	crypto_digest_final(crypt_stat->md5_tfm, dst);
+	mutex_unlock(&crypt_stat->cs_md5_tfm_mutex);
 out:
 	return rc;
 }
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index c84e1d2..b707a99 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -232,12 +232,14 @@ static int ecryptfs_open(struct inode *i
 	}
 	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
 	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
+	mutex_lock(&crypt_stat->cs_mutex);
 	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_POLICY_APPLIED)) {
 		ecryptfs_printk(KERN_DEBUG, "Setting flags for stat...\n");
 		/* Policy code enabled in future release */
 		ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_POLICY_APPLIED);
 		ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED);
 	}
+	mutex_unlock(&crypt_stat->cs_mutex);
 	/* This mntget & dget is undone via fput when the file is released */
 	dget(lower_dentry);
 	lower_flags = file->f_flags;
@@ -263,10 +265,12 @@ static int ecryptfs_open(struct inode *i
 		rc = 0;
 		goto out;
 	}
+	mutex_lock(&crypt_stat->cs_mutex);
 	if (i_size_read(lower_inode) == 0) {
 		ecryptfs_printk(KERN_EMERG, "Zero-length lower file; "
 				"ecryptfs_create() had a problem?\n");
 		rc = -ENOENT;
+		mutex_unlock(&crypt_stat->cs_mutex);
 		goto out_puts;
 	} else if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
 					ECRYPTFS_POLICY_APPLIED)
@@ -283,9 +287,11 @@ static int ecryptfs_open(struct inode *i
 			 * as-is to userspace. For release 0.1, we are
 			 * going to default to -EIO. */
 			rc = -EIO;
+			mutex_unlock(&crypt_stat->cs_mutex);
 			goto out_puts;
 		}
 	}
+	mutex_unlock(&crypt_stat->cs_mutex);
 	ecryptfs_printk(KERN_DEBUG, "inode w/ addr = [0x%p], i_ino = [0x%.16x] "
 			"size: [0x%.16x]\n", inode, inode->i_ino,
 			i_size_read(inode));
-- 
1.3.3

