Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWCTCch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWCTCch (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 21:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWCTCch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 21:32:37 -0500
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:39669 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751256AbWCTCch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 21:32:37 -0500
Message-ID: <441E142F.2030305@cfl.rr.com>
Date: Sun, 19 Mar 2006 21:32:15 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] udf: fix uid/gid options and add uid/gid=ignore and forget
 options
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the incorrect patch previously applied in
commit 4d6660eb3665f22d16aff466eb9d45df6102b254.  I had posted
the correction as a reply on lkml, but it seems that the earlier
and incorrect patch got merged into Linus's tree.  This patch
also adds documentation for the changes made last time.

---

Documentation/filesystems/udf.txt |   14 ++++++++++++++
fs/udf/inode.c                    |    6 ++----
2 files changed, 16 insertions(+), 4 deletions(-)

83a730fb2e864dae308008d83c5d804afc539f08
diff --git a/Documentation/filesystems/udf.txt b/Documentation/filesystems/udf.txt
index e5213bc..85ff288 100644
--- a/Documentation/filesystems/udf.txt
+++ b/Documentation/filesystems/udf.txt
@@ -26,6 +26,20 @@ The following mount options are supporte
	nostrict	Unset strict conformance
	iocharset=	Set the NLS character set

+The uid= and gid= options need a bit more explaining.  They will accept a
+decimal numeric value which will be used as the default ID for that mount.
+They will also accept the string "ignore" and "forget".  For files on the disk
+that are owned by nobody ( -1 ), they will instead look as if they are owned
+by the default ID.  The ignore option causes the default ID to override all
+IDs on the disk, not just -1.  The forget option causes all IDs to be written
+to disk as -1, so when the media is later remounted, they will appear to be
+owned by whatever default ID it is mounted with at that time.  
+
+For typical desktop use of removable media, you should set the ID to that
+of the interactively logged on user, and also specify both the forget and
+ignore options.  This way the interactive user will always see the files
+on the disk as belonging to him.  
+
The remaining are for debugging and disaster recovery:

	novrs		Skip volume sequence recognition 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index d04cff2..81e0e84 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1341,13 +1341,11 @@ udf_update_inode(struct inode *inode, in

	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_UID_FORGET))
		fe->uid = cpu_to_le32(-1);
-	else if (inode->i_uid != UDF_SB(inode->i_sb)->s_uid)
-		fe->uid = cpu_to_le32(inode->i_uid);
+	else fe->uid = cpu_to_le32(inode->i_uid);

	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_GID_FORGET))
		fe->gid = cpu_to_le32(-1);
-	else if (inode->i_gid != UDF_SB(inode->i_sb)->s_gid)
-		fe->gid = cpu_to_le32(inode->i_gid);
+	else fe->gid = cpu_to_le32(inode->i_gid);

	udfperms =	((inode->i_mode & S_IRWXO)     ) |
			((inode->i_mode & S_IRWXG) << 2) |
-- 
1.1.3

