Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWBLSRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWBLSRp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 13:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWBLSRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 13:17:45 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:44781 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751123AbWBLSRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 13:17:45 -0500
To: linux-kernel@vger.kernel.org
Cc: Phillip Susi <psusi@cfl.rr.com>, bfennema@falcon.csc.calpoly.edu,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH] UDF filesystem uid fix
From: Peter Osterlund <petero2@telia.com>
Date: 12 Feb 2006 19:17:38 +0100
Message-ID: <m3lkwg4f25.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would appreciate if someone with file system knowledge could review
this patch from Phillip Susi.


From: Phillip Susi <psusi@cfl.rr.com>

The UDF filesystem refused to update the file's uid and gid on the
disk if the in memory inode's id matched the values in the uid= and
gid= mount options.  This was causing the owner to change from the
desktop user to root when the volume was ejected and remounted.  I
changed this so that if the inode's id matches the mount option, it
writes a -1 to disk, because when the filesystem reads a -1 from disk,
it uses the mount option for the in memory inode.  This allows you to
use the uid/gid mount options in the way you would expect.
---

 fs/udf/inode.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 395e582..f892948 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1337,9 +1337,13 @@ udf_update_inode(struct inode *inode, in
 
 	if (inode->i_uid != UDF_SB(inode->i_sb)->s_uid)
 		fe->uid = cpu_to_le32(inode->i_uid);
+	else
+		fe->uid = cpu_to_le32(-1);
 
 	if (inode->i_gid != UDF_SB(inode->i_sb)->s_gid)
 		fe->gid = cpu_to_le32(inode->i_gid);
+	else
+		fe->gid = cpu_to_le32(-1);
 
 	udfperms =	((inode->i_mode & S_IRWXO)     ) |
 			((inode->i_mode & S_IRWXG) << 2) |

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
