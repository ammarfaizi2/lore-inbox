Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129658AbRBGUTd>; Wed, 7 Feb 2001 15:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbRBGUTX>; Wed, 7 Feb 2001 15:19:23 -0500
Received: from caesar.cryptofreak.org ([64.6.202.103]:22277 "EHLO
	caesar.cryptofreak.org") by vger.kernel.org with ESMTP
	id <S129658AbRBGUTK>; Wed, 7 Feb 2001 15:19:10 -0500
Date: Wed, 7 Feb 2001 13:19:08 -0700
From: Jay Miller <jnmiller@colorado.edu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] inode_change_ok() grpid bug?
Message-ID: <20010207131908.A26338@cryptofreak.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
X-Mailer: Mutt 1.2.5i
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I found a reælly minor problem..

* 'chmod g+s foo' when I am not in foo's group does nothing. (no error)
* 'chmod g-s foo' when I am not in foo's group turns off the GID bit.

This seems like inconsistent/wrong behavior.  It apparently stems from the
fact that if there is a group mismatch between the current process and the
inode, inode_change_ok() and inode_setattr() just turn S_ISGID off, as they
have no way of knowing the original state of the bit.

My lame suggestions (to 2.4.1) are below - I apologize if this is old news
or in fact correct behavior.

-- 
Jay Miller

diff -urN linux/fs/attr.c linux-j/fs/attr.c
--- linux/fs/attr.c     Mon Oct 16 14:00:53 2000
+++ linux-j/fs/attr.c   Wed Feb  7 13:10:06 2001
@@ -43,7 +43,7 @@
                /* Also check the setgid bit! */
                if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
                                inode->i_gid) && !capable(CAP_FSETID))
-                       attr->ia_mode &= ~S_ISGID;
+                       goto error;
        }
 
        /* Check for setting the inode time. */
@@ -73,11 +73,8 @@
                inode->i_mtime = attr->ia_mtime;
        if (ia_valid & ATTR_CTIME)
                inode->i_ctime = attr->ia_ctime;
-       if (ia_valid & ATTR_MODE) {
+       if (ia_valid & ATTR_MODE)
                inode->i_mode = attr->ia_mode;
-               if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
-                       inode->i_mode &= ~S_ISGID;
-       }
        mark_inode_dirty(inode);
 }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
