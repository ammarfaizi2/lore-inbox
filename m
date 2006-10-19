Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946323AbWJSSdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946323AbWJSSdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946321AbWJSSdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:33:33 -0400
Received: from ns2.suse.de ([195.135.220.15]:45506 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946323AbWJSSdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:33:32 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Linux
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Remove superfluous lock_super() in ext2 and ext3 xattr code
Date: Thu, 19 Oct 2006 20:34:24 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610192034.24129.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lock_super() is unnecessary for setting super-block feature flags.
Use the provided *_SET_COMPAT_FEATURE() macros as well.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.19-rc2/fs/ext2/xattr.c
===================================================================
--- linux-2.6.19-rc2.orig/fs/ext2/xattr.c
+++ linux-2.6.19-rc2/fs/ext2/xattr.c
@@ -342,12 +342,9 @@ static void ext2_xattr_update_super_bloc
 	if (EXT2_HAS_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_EXT_ATTR))
 		return;
 
-	lock_super(sb);
-	EXT2_SB(sb)->s_es->s_feature_compat |=
-		cpu_to_le32(EXT2_FEATURE_COMPAT_EXT_ATTR);
+	EXT2_SET_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_EXT_ATTR);
 	sb->s_dirt = 1;
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
-	unlock_super(sb);
 }
 
 /*
Index: linux-2.6.19-rc2/fs/ext3/xattr.c
===================================================================
--- linux-2.6.19-rc2.orig/fs/ext3/xattr.c
+++ linux-2.6.19-rc2/fs/ext3/xattr.c
@@ -459,14 +459,11 @@ static void ext3_xattr_update_super_bloc
 	if (EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_EXT_ATTR))
 		return;
 
-	lock_super(sb);
 	if (ext3_journal_get_write_access(handle, EXT3_SB(sb)->s_sbh) == 0) {
-		EXT3_SB(sb)->s_es->s_feature_compat |=
-			cpu_to_le32(EXT3_FEATURE_COMPAT_EXT_ATTR);
+		EXT3_SET_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_EXT_ATTR);
 		sb->s_dirt = 1;
 		ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
 	}
-	unlock_super(sb);
 }
 
 /*
