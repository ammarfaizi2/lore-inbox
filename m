Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWFHUqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWFHUqH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWFHUqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:46:06 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:51973 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964993AbWFHUqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:46:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AbYbWcgjrA/V4LSZlxwZHLfdini/1fKMMJiH08RaTQl3JwmzP7i2AIGuCBgRQIS/OA7e3YBIXtmo4BSz6gZiV2nzYNUnME1lKbYs41oxyVGxjHkJdYxgfVSIAfQfjTdDG4HdoF63P8RFKcl+9r7GUqKzzgyOoyyYFWqqpR2Sh5Q=
Message-ID: <69a7202e0606081346n4d9ea650kb4329ea04d657bfa@mail.gmail.com>
Date: Thu, 8 Jun 2006 16:46:04 -0400
From: "Carl Spalletta" <cspalletta@gmail.com>
Reply-To: cspalletta@adelphia.net
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vfs: support for COW files in sys_open: vfs changes
Cc: viro@zeniv.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giving the O_COW flag to open() will return a special error, if
IS_COW(inode) and write permissions are expressed or implied.  COW-aware
applications may set this flag and deal with this error according to
some user defined policy.  This will not change the semantics of any
existing application or affect any kernel user of open_namei(); nor does
it affect future applications unless they use O_COW.  Filesystem level
code is unimplemented except for an ext2 example.

Signed-off-by: Carl Spalletta <cspalletta@gmail.com>
---

 fs/namei.c                  |   17 +++++++++++++++++
 include/linux/fs.h          |    3 +++
 include/asm-generic/errno.h |    2 ++
 3 files changed, 22 insertions(+)

A self-serving and biased discussion of some objections to this proposal:

CON: It is too lightweight; it is trivial.
PRO: All previous proposals have failed due to being unable to solve the
     problems of _too_much_ kernel support.  This patch accomplishes the
     purpose of kernel support for preserving a file marked COW, by providing
     _mechanism_ in the kernel, not policy.  The userspace applications
     provide their own policy through options, config files, or whatever.

CON: In that case you will have inconsistent treatment of COW files.
PRO: Which is as it should be, as long as the goal of preserving COW files from
     being silently overwritten is supported.  Users will choose the tool -
     and policy - that they prefer.

CON: It is too heavy - all you really need is S_COW.
PRO: In that case each application must parse the filesystem type and
     then provide separate IOCTL's and filesystem-specific arguments
     for each filesystem type.  If the IOCTL changes, or if COW support is
     added to an existing filesystem, or a new filesystem is added which
     has it built-in, then the application has to be revised.  With this
     approach the COW-aware application need only add the flag O_COW to
     open() and be prepared to deal with getting back ECOW, for _any_ fs.

CON: It doesn't work for symlinked files; the path gets resolved to a
regular file.
PRO: It is the file to be protected that must be marked COW, since it may
     have many links to it, both hard and soft.  Setting a symlink  "S_COW"
     is probably meaningless.

CON: It blurs the semantics of hard linked files.
PRO: Policy is determined by the user; putting an extra layer of meaning
     on top of what the kernel provides is not improper.  Generally, if a
     file with multiple hard links is to be written it is better for it to
     be COW than not, since the application can if it wishes use the S_COW
     flag in the inode as a hint to preserve the content of the original.

NB:
  In all cases the application must open a file with O_COW for this patch to
have any effect.


--- a/fs/namei.c        2006-06-07 11:18:15.000000000 -0400
+++ b/fs/namei.c        2006-06-06 13:59:41.000000000 -0400
@@ -244,6 +244,11 @@ int permission(struct inode *inode, int
                */
               if (IS_IMMUTABLE(inode))
                       return -EACCES;
+               /*
+                * COW-aware applications must set their own policy
for this error
+                */
+               if (mask & MAY_COW)
+                       return -ECOW;
       }


@@ -1485,6 +1490,12 @@ int may_open(struct nameidata *nd, int a
       if (!inode)
               return -ENOENT;

+       /*
+        * Cleaner, and simplifies test in permission()
+        */
+       if(!(IS_COW(inode)))
+               acc_mode &= ~MAY_COW;
+
       if (S_ISLNK(inode->i_mode))
               return -ELOOP;

@@ -1583,6 +1594,12 @@ int open_namei(int dfd, const char *path
       if (flag & O_TRUNC)
               acc_mode |= MAY_WRITE;

+       /*
+        * -ECOW will be propagated back to filp_open if MAY_WRITE && IS_COW
+        */
+       if (flag & O_COW)
+               acc_mode |= MAY_COW;
+
       /* Allow the LSM permission hook to distinguish append
          access from general write access. */
       if (flag & O_APPEND)
--- a/include/linux/fs.h        2006-06-07 11:19:08.000000000 -0400
+++ b/include/linux/fs.h        2006-06-06 13:16:34.000000000 -0400
@@ -56,6 +56,7 @@ extern int dir_notify_enable;
 #define MAY_WRITE 2
 #define MAY_READ 4
 #define MAY_APPEND 8
+#define MAY_COW 16

 #define FMODE_READ 1
 #define FMODE_WRITE 2
@@ -135,6 +136,7 @@ extern int dir_notify_enable;
 #define S_NOCMTIME     128     /* Do not update file c/mtime */
 #define S_SWAPFILE     256     /* Do not truncate: swapon got its bmaps */
 #define S_PRIVATE      512     /* Inode is fs-internal */
+#define S_COW          1024    /* open will fail if MAY_COW && MAY_WRITE */

 /*
 * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -167,6 +169,7 @@ extern int dir_notify_enable;
 #define IS_NOCMTIME(inode)     ((inode)->i_flags & S_NOCMTIME)
 #define IS_SWAPFILE(inode)     ((inode)->i_flags & S_SWAPFILE)
 #define IS_PRIVATE(inode)      ((inode)->i_flags & S_PRIVATE)
+#define IS_COW(inode)          ((inode)->i_flags & S_COW)

 /* the read-only stuff doesn't really belong here, but any other place is
   probably as bad and I don't want to create yet another include file. */
--- a/include/asm-generic/errno.h       2006-06-07 11:19:09.000000000 -0400
+++ b/include/asm-generic/errno.h       2006-06-06 12:35:28.000000000 -0400
@@ -106,4 +106,6 @@
 #define        EOWNERDEAD      130     /* Owner died */
 #define        ENOTRECOVERABLE 131     /* State not recoverable */

+#define        ECOW            132     /* COW file opened with write
permissions */
+
 #endif
