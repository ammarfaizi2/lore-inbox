Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVGHKr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVGHKr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVGHKZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:25:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:53653 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262453AbVGHKZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:25:49 -0400
Subject: [RFC PATCH 2/8] unclone a subtree
From: Ram <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <1120816355.30164.16.camel@localhost>
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120816355.30164.16.camel@localhost>
Content-Type: multipart/mixed; boundary="=-WVImkTqCsj8g5cHK+I9/"
Organization: IBM 
Message-Id: <1120817529.30164.45.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Jul 2005 03:25:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WVImkTqCsj8g5cHK+I9/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Adds the ability to unclone a vfs tree. A uncloned vfs tree will not be
 clonnable, and hence cannot be bind/rbind to any other mountpoint.

 RP


--=-WVImkTqCsj8g5cHK+I9/
Content-Disposition: attachment; filename=unclone.patch
Content-Type: text/x-patch; name=unclone.patch
Content-Transfer-Encoding: 7bit

 Adds the ability to unclone a vfs tree. A uncloned vfs tree will not be
 clonnable, and hence cannot be bind/rbind to any other mountpoint.

 RP


 fs/namespace.c        |   18 +++++++++++++++++-
 include/linux/fs.h    |    1 +
 include/linux/mount.h |   15 +++++++++++++--
 3 files changed, 31 insertions(+), 3 deletions(-)

Index: 2.6.12/fs/namespace.c
===================================================================
--- 2.6.12.orig/fs/namespace.c
+++ 2.6.12/fs/namespace.c
@@ -698,6 +698,7 @@ static int do_change_type(struct nameida
 	int err;
 
 	if (!(flag & MS_SHARED) && !(flag & MS_PRIVATE)
+			&& !(flag & MS_UNCLONE)
 			&& !(flag & MS_SLAVE))
 		return -EINVAL;
 
@@ -757,6 +758,11 @@ static int do_change_type(struct nameida
 			SET_MNT_PRIVATE(m);
 			break;
 
+		case MS_UNCLONE:
+			if(m->mnt_pnode)
+				pnode_disassociate_mnt(m);
+			SET_MNT_UNCLONABLE(m);
+			break;
 		}
 	}
 	spin_unlock(&vfsmount_lock);
@@ -1197,7 +1203,8 @@ long do_mount(char * dev_name, char * di
 				    data_page);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name, flags & MS_REC);
-	else if (flags & MS_SHARED || flags & MS_PRIVATE || flags & MS_SLAVE)
+	else if (flags & MS_SHARED || flags & MS_UNCLONE ||
+			flags & MS_PRIVATE || flags & MS_SLAVE)
 		retval = do_change_type(&nd, flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
Index: 2.6.12/include/linux/fs.h
===================================================================
--- 2.6.12.orig/include/linux/fs.h
+++ 2.6.12/include/linux/fs.h
@@ -102,6 +102,7 @@ extern int dir_notify_enable;
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_UNCLONE	131072
 #define MS_PRIVATE	262144
 #define MS_SLAVE	524288
 #define MS_SHARED	1048576
Index: 2.6.12/include/linux/mount.h
===================================================================
--- 2.6.12.orig/include/linux/mount.h
+++ 2.6.12/include/linux/mount.h
@@ -21,28 +21,39 @@
 #define MNT_NOEXEC	0x04
 #define MNT_PRIVATE	0x10  /* if the vfsmount is private, by default it is private*/
 #define MNT_SLAVE	0x20  /* if the vfsmount is a slave mount of its pnode */
-#define MNT_SHARED	0x40  /* if the vfsmount is a slave mount of its pnode */
+#define MNT_SHARED	0x40  /* if the vfsmount is a shared mount */
+#define MNT_UNCLONABLE	0x80  /* if the vfsmount is unclonable */
 #define MNT_PNODE_MASK	0xf0  /* propogation flag mask */
 
+#define IS_MNT_UNCLONABLE(mnt) (mnt->mnt_flags&MNT_UNCLONABLE)
 #define IS_MNT_SHARED(mnt) (mnt->mnt_flags&MNT_SHARED)
 #define IS_MNT_SLAVE(mnt) (mnt->mnt_flags&MNT_SLAVE)
 #define IS_MNT_PRIVATE(mnt) (mnt->mnt_flags&MNT_PRIVATE)
 
 #define CLEAR_MNT_SHARED(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_SHARED))
 #define CLEAR_MNT_PRIVATE(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_PRIVATE))
+#define CLEAR_MNT_UNCLONABLE(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_UNCLONABLE))
 #define CLEAR_MNT_SLAVE(mnt) (mnt->mnt_flags &= ~(MNT_PNODE_MASK & MNT_SLAVE))
 
 //TOBEDONE WRITE BETTER MACROS. ..
 #define SET_MNT_SHARED(mnt) (mnt->mnt_flags |= (MNT_PNODE_MASK & MNT_SHARED),\
 				CLEAR_MNT_PRIVATE(mnt), \
-				CLEAR_MNT_SLAVE(mnt))
+				CLEAR_MNT_SLAVE(mnt), \
+				CLEAR_MNT_UNCLONABLE(mnt))
 #define SET_MNT_PRIVATE(mnt) (mnt->mnt_flags |= (MNT_PNODE_MASK & MNT_PRIVATE), \
 				CLEAR_MNT_SLAVE(mnt), \
 				CLEAR_MNT_SHARED(mnt), \
+				CLEAR_MNT_UNCLONABLE(mnt),\
+				mnt->mnt_pnode = NULL)
+#define SET_MNT_UNCLONABLE(mnt) (mnt->mnt_flags |= (MNT_PNODE_MASK & MNT_UNCLONABLE), \
+				CLEAR_MNT_SLAVE(mnt),\
+				CLEAR_MNT_SHARED(mnt),\
+				CLEAR_MNT_PRIVATE(mnt),\
 				mnt->mnt_pnode = NULL)
 #define SET_MNT_SLAVE(mnt) (mnt->mnt_flags |= (MNT_PNODE_MASK & MNT_SLAVE), \
 				CLEAR_MNT_PRIVATE(mnt), \
-				CLEAR_MNT_SHARED(mnt))
+				CLEAR_MNT_SHARED(mnt), \
+				CLEAR_MNT_UNCLONABLE(mnt))
 
 struct vfsmount
 {

--=-WVImkTqCsj8g5cHK+I9/--

