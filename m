Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWFOLD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWFOLD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWFOLD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:03:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:19913 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964783AbWFOLD4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:03:56 -0400
Date: Thu, 15 Jun 2006 12:03:55 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] affs_fill_super() %s abuses
Message-ID: <20060615110355.GH27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

%s is valid only on NUL-terminated arrays, damnit!

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/affs/super.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

02cc7ba4e655dc01773f43e5324986188d42653d
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 4d7e5b1..02aeb22 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -271,6 +271,7 @@ static int affs_fill_super(struct super_
 	int			 reserved;
 	unsigned long		 mount_flags;
 	int			 tmp_flags;	/* fix remount prototype... */
+	u8			 sig[4];
 
 	pr_debug("AFFS: read_super(%s)\n",data ? (const char *)data : "no options");
 
@@ -370,8 +371,9 @@ got_root:
 		printk(KERN_ERR "AFFS: Cannot read boot block\n");
 		goto out_error;
 	}
-	chksum = be32_to_cpu(*(__be32 *)boot_bh->b_data);
+	memcpy(sig, boot_bh->b_data, 4);
 	brelse(boot_bh);
+	chksum = be32_to_cpu(*(__be32 *)sig);
 
 	/* Dircache filesystems are compatible with non-dircache ones
 	 * when reading. As long as they aren't supported, writing is
@@ -420,11 +422,17 @@ got_root:
 	}
 
 	if (mount_flags & SF_VERBOSE) {
-		chksum = cpu_to_be32(chksum);
-		printk(KERN_NOTICE "AFFS: Mounting volume \"%*s\": Type=%.3s\\%c, Blocksize=%d\n",
-			AFFS_ROOT_TAIL(sb, root_bh)->disk_name[0],
-			AFFS_ROOT_TAIL(sb, root_bh)->disk_name + 1,
-			(char *)&chksum,((char *)&chksum)[3] + '0',blocksize);
+		int len = AFFS_ROOT_TAIL(sb, root_bh)->disk_name[0];
+		char name[32];
+
+		if (len > 31)
+			len = 31;
+		memcpy(name, AFFS_ROOT_TAIL(sb, root_bh)->disk_name + 1, len);
+		name[len] = '\0';
+
+		printk(KERN_NOTICE "AFFS: Mounting volume \"%*s\": "
+			"Type=%c%c%c\\%c, Blocksize=%d\n",
+			len, name, sig[0], sig[1], sig[2], sig[3], blocksize);
 	}
 
 	sb->s_flags |= MS_NODEV | MS_NOSUID;
-- 
1.3.GIT

