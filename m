Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWDGQJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWDGQJI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 12:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWDGQJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 12:09:07 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:16574 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932439AbWDGQJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 12:09:06 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Nick Piggin <npiggin@suse.de>
Subject: [PATCH] inotify: check for NULL inode in inotify_d_instantiate
Date: Fri, 7 Apr 2006 18:08:41 +0200
User-Agent: KMail/1.9.1
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604071808.41953.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The spufs file system creates files in a directory before instantiating
the directory itself, which causes a NULL pointer access in
inotify_d_instantiate since c32ccd87bfd1414b0aabfcd8dbc7539ad23bcbaa.

I'd like to keep this behavior since it means that the user
will not have access to files in the directory before I know
that I succeed in creating everything in it. This patch adds
a simple check for the inode to keep that working.

Cc: Nick Piggin <npiggin@suse.de>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

diff --git a/fs/inotify.c b/fs/inotify.c
index 367c487..1f50302 100644
--- a/fs/inotify.c
+++ b/fs/inotify.c
@@ -538,7 +538,7 @@ void inotify_d_instantiate(struct dentry
 	WARN_ON(entry->d_flags & DCACHE_INOTIFY_PARENT_WATCHED);
 	spin_lock(&entry->d_lock);
 	parent = entry->d_parent;
-	if (inotify_inode_watched(parent->d_inode))
+	if (parent->d_inode && inotify_inode_watched(parent->d_inode))
 		entry->d_flags |= DCACHE_INOTIFY_PARENT_WATCHED;
 	spin_unlock(&entry->d_lock);
 }
