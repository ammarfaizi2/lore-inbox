Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270177AbVBESEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270177AbVBESEb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 13:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbVBESEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 13:04:31 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:64905 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S273650AbVBESD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 13:03:28 -0500
Subject: [FIX] Long-standing xattr sharing bug
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: acl-devel@bestbits.at,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1107626603.27797.64.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 05 Feb 2005 19:03:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When looking for identical xattr blocks to share, we were not comparing
the name_index fields.  This could lead to false sharing when two xattr
blocks ended up with identical attribute names and values, and the only
difference was in name_index.  Specifically this could trigger with
default acls.  Because acls are cached, the bug was hidden until the
next reload of the affected inode.

  $ mkdir -m 700 a b
  $ setfacl -m u:bin:rwx a
	< acl of a goes in the mbcache

  $ setfacl -dm u:bin:rwx b
	< acl of b differs only in name_index, so a's acl is reused

  $ getfacl b
	< shows the result from the inode cache

  < empty inode cache (remount, etc.)

  $ getfacl b
	< shows an access acl instead of a default acl.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc3/fs/ext2/xattr.c
===================================================================
--- linux-2.6.11-rc3.orig/fs/ext2/xattr.c
+++ linux-2.6.11-rc3/fs/ext2/xattr.c
@@ -881,6 +881,7 @@ ext2_xattr_cmp(struct ext2_xattr_header 
 		if (IS_LAST_ENTRY(entry2))
 			return 1;
 		if (entry1->e_hash != entry2->e_hash ||
+		    entry1->e_name_index != entry2->e_name_index ||
 		    entry1->e_name_len != entry2->e_name_len ||
 		    entry1->e_value_size != entry2->e_value_size ||
 		    memcmp(entry1->e_name, entry2->e_name, entry1->e_name_len))
Index: linux-2.6.11-rc3/fs/ext3/xattr.c
===================================================================
--- linux-2.6.11-rc3.orig/fs/ext3/xattr.c
+++ linux-2.6.11-rc3/fs/ext3/xattr.c
@@ -1162,6 +1162,7 @@ ext3_xattr_cmp(struct ext3_xattr_header 
 		if (IS_LAST_ENTRY(entry2))
 			return 1;
 		if (entry1->e_hash != entry2->e_hash ||
+		    entry1->e_name_index != entry2->e_name_index ||
 		    entry1->e_name_len != entry2->e_name_len ||
 		    entry1->e_value_size != entry2->e_value_size ||
 		    memcmp(entry1->e_name, entry2->e_name, entry1->e_name_len))


Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

