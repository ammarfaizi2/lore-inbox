Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267879AbUHKCcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267879AbUHKCcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 22:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUHKCcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 22:32:18 -0400
Received: from lakermmtao03.cox.net ([68.230.240.36]:52965 "EHLO
	lakermmtao03.cox.net") by vger.kernel.org with ESMTP
	id S267879AbUHKCcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 22:32:11 -0400
Mime-Version: 1.0 (Apple Message framework v618)
Content-Transfer-Encoding: 7bit
Message-Id: <9F7D78D4-EB3E-11D8-BC30-000393ACC76E@mac.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: lkml List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [PATCH] Clean up posix_acl_permission to not require an inode
Date: Tue, 10 Aug 2004 22:32:00 -0400
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All but one of the functions in fs/posix_acl.c done use inodes, they 
just work with
ACLs and permission masks.  The function posix_acl_permission uses an 
inode
just to retrieve its i_uid and i_gid parameters.  I think it should 
just receive those
parameters directly, to better match the function of the other 
functions in that file.

Here is a patch that changes the parameter and fixes in-kernel 
filesystems that
use it:

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------

###
## BEGIN PATCH
###

diff -ruN linux-2.6.7/fs/ext2/acl.c linux-2.6.7-km/fs/ext2/acl.c
--- linux-2.6.7/fs/ext2/acl.c	2004-06-16 01:19:44.000000000 -0400
+++ linux-2.6.7-km/fs/ext2/acl.c	2004-08-10 21:26:11.000000000 -0400
@@ -308,7 +308,7 @@
  			goto check_groups;
  		acl = ext2_get_acl(inode, ACL_TYPE_ACCESS);
  		if (acl) {
-			int error = posix_acl_permission(inode, acl, mask);
+			int error = posix_acl_permission(inode->i_uid, inode->i_gid, acl, 
mask);
  			posix_acl_release(acl);
  			if (error == -EACCES)
  				goto check_capabilities;
diff -ruN linux-2.6.7/fs/ext3/acl.c linux-2.6.7-km/fs/ext3/acl.c
--- linux-2.6.7/fs/ext3/acl.c	2004-06-16 01:19:11.000000000 -0400
+++ linux-2.6.7-km/fs/ext3/acl.c	2004-08-10 21:26:31.000000000 -0400
@@ -313,7 +313,7 @@
  			goto check_groups;
  		acl = ext3_get_acl(inode, ACL_TYPE_ACCESS);
  		if (acl) {
-			int error = posix_acl_permission(inode, acl, mask);
+			int error = posix_acl_permission(inode->i_uid, inode->i_gid, acl, 
mask);
  			posix_acl_release(acl);
  			if (error == -EACCES)
  				goto check_capabilities;
diff -ruN linux-2.6.7/fs/jfs/acl.c linux-2.6.7-km/fs/jfs/acl.c
--- linux-2.6.7/fs/jfs/acl.c	2004-06-16 01:18:57.000000000 -0400
+++ linux-2.6.7-km/fs/jfs/acl.c	2004-08-10 21:26:50.000000000 -0400
@@ -169,7 +169,7 @@
  	}

  	if (ji->i_acl) {
-		int rc = posix_acl_permission(inode, ji->i_acl, mask);
+		int rc = posix_acl_permission(inode->i_uid, inode->i_gid, ji->i_acl, 
mask);
  		if (rc == -EACCES)
  			goto check_capabilities;
  		return rc;
diff -ruN linux-2.6.7/fs/posix_acl.c linux-2.6.7-km/fs/posix_acl.c
--- linux-2.6.7/fs/posix_acl.c	2004-06-16 01:20:20.000000000 -0400
+++ linux-2.6.7-km/fs/posix_acl.c	2004-08-10 18:17:21.000000000 -0400
@@ -211,7 +211,7 @@
   * by the acl. Returns -E... otherwise.
   */
  int
-posix_acl_permission(struct inode *inode, const struct posix_acl *acl, 
int want)
+posix_acl_permission(uid_t uid, gid_t gid, const struct posix_acl 
*acl, int want)
  {
  	const struct posix_acl_entry *pa, *pe, *mask_obj;
  	int found = 0;
@@ -220,7 +220,7 @@
                  switch(pa->e_tag) {
                          case ACL_USER_OBJ:
  				/* (May have been checked already) */
-                                if (inode->i_uid == current->fsuid)
+                                if (uid == current->fsuid)
                                          goto check_perm;
                                  break;
                          case ACL_USER:
@@ -228,7 +228,7 @@
                                          goto mask;
  				break;
                          case ACL_GROUP_OBJ:
-                                if (in_group_p(inode->i_gid)) {
+                                if (in_group_p(gid)) {
  					found = 1;
  					if ((pa->e_perm & want) == want)
  						goto mask;
diff -ruN linux-2.6.7/fs/reiserfs/xattr.c 
linux-2.6.7-km/fs/reiserfs/xattr.c
--- linux-2.6.7/fs/reiserfs/xattr.c	2004-06-16 01:20:04.000000000 -0400
+++ linux-2.6.7-km/fs/reiserfs/xattr.c	2004-08-10 21:27:11.000000000 
-0400
@@ -1386,7 +1386,7 @@
                  }

                  if (acl) {
-                    int err = posix_acl_permission (inode, acl, mask);
+                    int err = posix_acl_permission (inode->i_uid, 
inode->i_gid, acl, mask);
                      posix_acl_release (acl);
                      if (err == -EACCES) {
                          goto check_capabilities;
diff -ruN linux-2.6.7/include/linux/posix_acl.h 
linux-2.6.7-km/include/linux/posix_acl.h
--- linux-2.6.7/include/linux/posix_acl.h	2004-06-16 01:20:26.000000000 
-0400
+++ linux-2.6.7-km/include/linux/posix_acl.h	2004-08-10 
18:18:18.000000000 -0400
@@ -74,7 +74,7 @@
  extern struct posix_acl *posix_acl_alloc(int, int);
  extern struct posix_acl *posix_acl_clone(const struct posix_acl *, 
int);
  extern int posix_acl_valid(const struct posix_acl *);
-extern int posix_acl_permission(struct inode *, const struct posix_acl 
*, int);
+extern int posix_acl_permission(uid_t, gid_t, const struct posix_acl 
*, int);
  extern struct posix_acl *posix_acl_from_mode(mode_t, int);
  extern int posix_acl_equiv_mode(const struct posix_acl *, mode_t *);
  extern int posix_acl_create_masq(struct posix_acl *, mode_t *);


###
## End Patch
###

