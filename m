Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268118AbUIPRQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268118AbUIPRQJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268463AbUIPRM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:12:56 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:2584 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S268215AbUIPRJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:09:52 -0400
Message-ID: <4149C998.6090306@suse.com>
Date: Thu, 16 Sep 2004 13:12:56 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: [PATCH] Fix for default ACL handling on ReiserFS
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030306080809030700030406"
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030306080809030700030406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello all -

reiserfs_set_xattr() explicitly updates the ctime for the host inode.

This works for direct setfacl/setfattr calls, but for the more common
case of an inherited default ACL, it breaks. The ACL is inherited in the
middle of the new inode creation, before the inode has been hashed.

When mark_inode_dirty is called, one of the checks bails out if the
inode is unhashed -- but AFTER inode->i_state is updated, so the inode
is marked dirty but never placed on any dirty list.

Since the inode is never placed on a dirty list, __sync_single_inode
from the writeback_inodes() path can never be called on it to clear the
dirty flags. Once the inode is hashed and mark_inode_dirty is called for
it again, it's too late -- it will bail early assuming (correctly) that
the inode is already marked dirty. This ultimately results in I/O stalls
that can't be resolved by the fs path, only be the memory allocation
path that uses pages directly.

The attached patch makes the update of the ctime conditional on the
inode being hashed already.

Please apply.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBScmYLPWxlyuTD7IRAopEAJ9uyyIudRaYd01pHvNHEGni+tO+zgCfc1Z0
zVSRILsXsk2xdvRN1/ss+5Y=
=6ndQ
-----END PGP SIGNATURE-----

--------------030306080809030700030406
Content-Type: text/plain;
 name="reiserfs-acl-dirty.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiserfs-acl-dirty.diff"

diff -rup linux-2.6.8/fs/reiserfs/xattr.c linux-2.6.8.fix/fs/reiserfs/xattr.c
--- linux-2.6.8/fs/reiserfs/xattr.c	2004-08-14 01:38:08.000000000 -0400
+++ linux-2.6.8.fix/fs/reiserfs/xattr.c	2004-09-16 00:22:19.000000000 -0400
@@ -588,12 +588,18 @@
         if (err || buffer_size == 0 || !buffer)
             break;
     }
 
-    inode->i_ctime = CURRENT_TIME;
-    mark_inode_dirty (inode);
+    /* We can't mark the inode dirty if it's not hashed. This is the case
+     * when we're inheriting the default ACL. If we dirty it, the inode
+     * gets marked dirty, but won't (ever) make it onto the dirty list until
+     * it's synced explicitly to clear I_DIRTY. This is bad. */
+    if (!hlist_unhashed(&inode->i_hash)) {
+        inode->i_ctime = CURRENT_TIME;
+        mark_inode_dirty (inode);
+    }
 
 out_filp:
     up (&xinode->i_sem);
     fput(fp);
 
 out:

--------------030306080809030700030406--
