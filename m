Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVK1MYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVK1MYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 07:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVK1MYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 07:24:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22238 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751265AbVK1MYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 07:24:05 -0500
Date: Mon, 28 Nov 2005 13:25:33 +0100
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix oops in vfs_quotaon_mount()
Message-ID: <20051128122533.GK26285@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  attached patch fixes a possible oops in journaled quotas. If quota file
specified in mount options did not exist, quota code tried to dereference
NULL pointer with the obvious result. Attached is a fix against 2.6.14
kernel. Please apply.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.14-quotaon_oops.diff"

When quota file specified in mount options did not exist, we tried to
dereference NULL pointer later. Fix it.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.14-1-punch-ioctl/fs/dquot.c linux-2.6.14-2-quotaon_oops/fs/dquot.c
--- linux-2.6.14-1-punch-ioctl/fs/dquot.c	2005-09-11 22:41:52.000000000 +0200
+++ linux-2.6.14-2-quotaon_oops/fs/dquot.c	2005-11-29 15:42:17.000000000 +0100
@@ -1526,10 +1526,16 @@ int vfs_quota_on_mount(struct super_bloc
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	if (!dentry->d_inode) {
+		error = -ENOENT;
+		goto out;
+	}
+
 	error = security_quota_on(dentry);
 	if (!error)
 		error = vfs_quota_on_inode(dentry->d_inode, type, format_id);
 
+out:
 	dput(dentry);
 	return error;
 }

--5p8PegU4iirBW1oA--
