Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbSJMCNM>; Sat, 12 Oct 2002 22:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261403AbSJMCNM>; Sat, 12 Oct 2002 22:13:12 -0400
Received: from zok.SGI.COM ([204.94.215.101]:6545 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S261402AbSJMCNJ>;
	Sat, 12 Oct 2002 22:13:09 -0400
Date: Sun, 13 Oct 2002 12:18:51 +1000
From: Nathan Scott <nathans@sgi.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, "Theodore Ts'o" <tytso@mit.edu>,
       Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2][RESEND] POSIX ACL configuration option
Message-ID: <20021013121851.B276740@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch provides the configuration entry, help text and basic
header file definitions for filesystems that support POSIX ACLs.

cheers.

-- 
Nathan

 fs/Config.help                  |    8 ++++
 fs/Config.in                    |    3 +
 include/linux/posix_acl_xattr.h |   67 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff -Naur linux-2.5.42-pristine/fs/Config.help linux-2.5.42-posixacl/fs/Config.help
--- linux-2.5.42-pristine/fs/Config.help	Sat Oct 12 14:22:18 2002
+++ linux-2.5.42-posixacl/fs/Config.help	Sun Oct 13 11:04:30 2002
@@ -18,6 +18,14 @@
   need this functionality say Y here. Note that you will need latest
   quota utilities for new quota format with this kernel.
 
+CONFIG_FS_POSIX_ACL
+  POSIX Access Control Lists (ACLs) support permissions for users and
+  groups beyond the owner/group/world scheme.
+
+  Refer to <http://acl.bestbits.at/> for more information about POSIX
+  ACLs on Linux.  If you wish to use ACLs, you'll need the getfacl(1)
+  and setfacl(1) utilities.  If unsure, say N.
+
 CONFIG_MINIX_FS
   Minix is a simple operating system used in many classes about OS's.
   The minix file system (method to organize files on a hard disk
diff -Naur linux-2.5.42-pristine/fs/Config.in linux-2.5.42-posixacl/fs/Config.in
--- linux-2.5.42-pristine/fs/Config.in	Sat Oct 12 14:22:12 2002
+++ linux-2.5.42-posixacl/fs/Config.in	Sun Oct 13 11:04:30 2002
@@ -10,6 +10,9 @@
 if [ "$CONFIG_QUOTA" = "y" ]; then
    define_bool CONFIG_QUOTACTL y
 fi
+
+bool 'POSIX Access Control Lists' CONFIG_FS_POSIX_ACL
+
 tristate 'Kernel automounter support' CONFIG_AUTOFS_FS
 tristate 'Kernel automounter version 4 support (also supports v3)' CONFIG_AUTOFS4_FS
 
diff -Naur linux-2.5.42-pristine/include/linux/posix_acl_xattr.h linux-2.5.42-posixacl/include/linux/posix_acl_xattr.h
--- linux-2.5.42-pristine/include/linux/posix_acl_xattr.h	Thu Jan  1 10:00:00 1970
+++ linux-2.5.42-posixacl/include/linux/posix_acl_xattr.h	Sun Oct 13 11:04:30 2002
@@ -0,0 +1,67 @@
+/*
+  File: linux/posix_acl_xattr.h
+
+  Extended attribute system call representation of Access Control Lists.
+
+  Copyright (C) 2000 by Andreas Gruenbacher <a.gruenbacher@computer.org>
+  Copyright (C) 2002 SGI - Silicon Graphics, Inc <linux-xfs@oss.sgi.com>
+ */
+#ifndef _POSIX_ACL_XATTR_H
+#define _POSIX_ACL_XATTR_H
+
+/* Extended attribute names */
+#define POSIX_ACL_XATTR_ACCESS	"system.posix_acl_access"
+#define POSIX_ACL_XATTR_DEFAULT	"system.posix_acl_default"
+
+/* Supported ACL a_version fields */
+#define POSIX_ACL_XATTR_VERSION	0x0002
+
+
+/* An undefined entry e_id value */
+#define ACL_UNDEFINED_ID	(-1)
+
+/* ACL entry e_tag field values */
+#define ACL_USER_OBJ		(0x01)
+#define ACL_USER		(0x02)
+#define ACL_GROUP_OBJ		(0x04)
+#define ACL_GROUP		(0x08)
+#define ACL_MASK		(0x10)
+#define ACL_OTHER		(0x20)
+
+/* ACL entry e_perm bitfield values */
+#define ACL_READ		(0x04)
+#define ACL_WRITE		(0x02)
+#define ACL_EXECUTE		(0x01)
+
+
+typedef struct {
+	__u16			e_tag;
+	__u16			e_perm;
+	__u32			e_id;
+} posix_acl_xattr_entry;
+
+typedef struct {
+	__u32			a_version;
+	posix_acl_xattr_entry	a_entries[0];
+} posix_acl_xattr_header;
+
+
+static inline size_t
+posix_acl_xattr_size(int count)
+{
+	return (sizeof(posix_acl_xattr_header) +
+		(count * sizeof(posix_acl_xattr_entry)));
+}
+
+static inline int
+posix_acl_xattr_count(size_t size)
+{
+	if (size < sizeof(posix_acl_xattr_header))
+		return -1;
+	size -= sizeof(posix_acl_xattr_header);
+	if (size % sizeof(posix_acl_xattr_entry))
+		return -1;
+	return size / sizeof(posix_acl_xattr_entry);
+}
+
+#endif	/* _POSIX_ACL_XATTR_H */
