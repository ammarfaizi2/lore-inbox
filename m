Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWFHFes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWFHFes (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 01:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWFHFes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 01:34:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:39237 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932510AbWFHFes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 01:34:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=UF6byPJ7iFaZOgSs+5/06CQzFBtmZgORal8zkS6FI2p6XazjL6pbHWZQnb8ReFd2gjmRCp7qT0DLic72R+B3tlnSbvvgXeBE4COGQJpAj1456AiLuRJhF4efbK+VbTnEKXe73KIazX1rPexMnDfvRP9p/uM543aBB/4kdOYJlSk=
Message-ID: <4487B83E.4090009@gmail.com>
Date: Thu, 08 Jun 2006 01:40:14 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: ericvh@gmail.com, rminnich@lanl.gov, lucho@ionkov.net
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] 9pfs: missing result check in v9fs_vfs_readlink() and v9fs_vfs_link()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__getname() may fail and return NULL (as pointed out by Coverity 437 &
1220).

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

 fs/9p/vfs_inode.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 2cb87ba..8e60dc7 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1054,6 +1054,9 @@ static int v9fs_vfs_readlink(struct dent
 	int ret;
 	char *link = __getname();
 
+	if (unlikely(!link))
+		return -ENOMEM;
+
 	if (buflen > PATH_MAX)
 		buflen = PATH_MAX;
 
@@ -1227,6 +1230,9 @@ v9fs_vfs_link(struct dentry *old_dentry,
 	}
 
 	name = __getname();
+	if (unlikely(!name))
+		return -ENOMEM;
+
 	sprintf(name, "%d\n", oldfid->fid);
 	retval = v9fs_vfs_mkspecial(dir, dentry, V9FS_DMLINK, name);
 	__putname(name);


