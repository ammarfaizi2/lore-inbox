Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUDEI1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 04:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUDEI1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 04:27:24 -0400
Received: from A17-250-248-85.apple.com ([17.250.248.85]:39398 "EHLO
	smtpout.mac.com") by vger.kernel.org with ESMTP id S263163AbUDEI1W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 04:27:22 -0400
Message-ID: <16293307.1081153633839.JavaMail.pwaechtler@mac.com>
Date: Mon, 05 Apr 2004 10:27:13 +0200
From: Peter Waechtler <pwaechtler@mac.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC] core not owned by euid, mm->dumpable
Cc: peter@helios.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the current behavior typical server programs that switch euid
don't dump core. This is done "for security".
If the core file pattern exists the dump is written to but readable
for the file owner (not necessarily root - don't argue: only chdir into
dirs that only root can write to: think of file servers like samba)

The patch below addresses this (but still not perfect).
What I would like to see: instead of mm->dumpable=0 when calling seteuid()
something like mm->dumpAs=root and making sure that the core is owned by root
mode 600

I could install a sighandler that calls prctl(PR_SET_DUMPABLE,1,0,0,0),
switch euid to root, but still the formerly placed core is owned by evil
user :(
Then I could read the core pattern and unlink such a file - and all this
just for the Linux platform...

--- fs/exec.c.orig      2004-04-05 09:41:31.134456912 +0200
+++ fs/exec.c   2004-04-05 09:29:55.614192064 +0200
@@ -1398,6 +1398,8 @@

        if (!S_ISREG(inode->i_mode))
                goto close_fail;
+       if (chown_common(file->f_dentry, current->euid, current->egid))
+               goto close_fail;
        if (!file->f_op)
                goto close_fail;
        if (!file->f_op->write)
--- fs/open.c.orig      2004-04-05 09:43:39.229983432 +0200
+++ fs/open.c   2004-04-05 09:30:04.357862824 +0200
@@ -648,7 +648,7 @@
        return error;
 }

-extern int chown_common(struct dentry * dentry, uid_t user, gid_t group)
+int chown_common(struct dentry * dentry, uid_t user, gid_t group)
 {
        struct inode * inode;
        int error;
--- include/linux/fs.h.orig     2004-04-05 09:42:52.205132296 +0200
+++ include/linux/fs.h  2004-04-05 09:28:08.215519144 +0200
@@ -1139,6 +1139,7 @@
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
 extern int filp_close(struct file *, fl_owner_t id);
 extern char * getname(const char __user *);
+extern int chown_common(struct dentry *, uid_t, gid_t);

 /* fs/dcache.c */
 extern void vfs_caches_init(unsigned long);

