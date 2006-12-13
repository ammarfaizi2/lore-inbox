Return-Path: <linux-kernel-owner+w=401wt.eu-S965106AbWLMTyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbWLMTyy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWLMTyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:54:18 -0500
Received: from cantor2.suse.de ([195.135.220.15]:53216 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965108AbWLMTx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:53:57 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 9/14] DebugFS : file/directory creation error handling
Date: Wed, 13 Dec 2006 11:53:00 -0800
Message-Id: <11660396163757-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <11660396133624-git-send-email-greg@kroah.com>
References: <20061213195226.GA6736@kroah.com> <1166039585152-git-send-email-greg@kroah.com> <11660395913232-git-send-email-greg@kroah.com> <11660395951158-git-send-email-greg@kroah.com> <11660395998-git-send-email-greg@kroah.com> <11660396032350-git-send-email-greg@kroah.com> <1166039606191-git-send-email-greg@kroah.com> <11660396091326-git-send-email-greg@kroah.com> <11660396133624-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Desnoyers <compudj@krystal.dyndns.org>

Fix error handling of file and directory creation in DebugFS.

The error path should release the file system because no _remove will be called
for this erroneous creation.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/debugfs/inode.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 05d1a9c..d6c5fb5 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -206,13 +206,15 @@ struct dentry *debugfs_create_file(const char *name, mode_t mode,
 
 	pr_debug("debugfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&debug_fs_type, &debugfs_mount, &debugfs_mount_count);
+	error = simple_pin_fs(&debug_fs_type, &debugfs_mount,
+			      &debugfs_mount_count);
 	if (error)
 		goto exit;
 
 	error = debugfs_create_by_name(name, mode, parent, &dentry);
 	if (error) {
 		dentry = NULL;
+		simple_release_fs(&debugfs_mount, &debugfs_mount_count);
 		goto exit;
 	}
 
-- 
1.4.4.2

