Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWD1AWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWD1AWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWD1AW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:22:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:54485 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751827AbWD1AWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:22:17 -0400
Date: Thu, 27 Apr 2006 17:20:39 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jan Kara <jack@suse.cz>, reiserfs-dev@namesys.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 15/24] Fix reiserfs deadlock
Message-ID: <20060428002039.GP18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-reiserfs-deadlock.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jan Kara <jack@suse.cz>

[PATCH] Fix reiserfs deadlock

reiserfs_cache_default_acl() should return whether we successfully found
the acl or not.  We have to return correct value even if reiserfs_get_acl()
returns error code and not just 0.  Otherwise callers such as
reiserfs_mkdir() can unnecessarily lock the xattrs and later functions such
as reiserfs_new_inode() fail to notice that we have already taken the lock
and try to take it again with obvious consequences.

Signed-off-by: Jan Kara <jack@suse.cz>
Cc: <reiserfs-dev@namesys.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/reiserfs/xattr_acl.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.16.11.orig/fs/reiserfs/xattr_acl.c
+++ linux-2.6.16.11/fs/reiserfs/xattr_acl.c
@@ -408,8 +408,9 @@ int reiserfs_cache_default_acl(struct in
 		acl = reiserfs_get_acl(inode, ACL_TYPE_DEFAULT);
 		reiserfs_read_unlock_xattrs(inode->i_sb);
 		reiserfs_read_unlock_xattr_i(inode);
-		ret = acl ? 1 : 0;
-		posix_acl_release(acl);
+		ret = (acl && !IS_ERR(acl));
+		if (ret)
+			posix_acl_release(acl);
 	}
 
 	return ret;

--
