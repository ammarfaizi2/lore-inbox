Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265380AbSJRTEX>; Fri, 18 Oct 2002 15:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265376AbSJRTCg>; Fri, 18 Oct 2002 15:02:36 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:15257 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265200AbSJRTBf>; Fri, 18 Oct 2002 15:01:35 -0400
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, viro@math.psu.edu
Subject: [PATCH][RFC] 2.5.42 (1/2): Filesystem capabilities kernel patch
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Fri, 18 Oct 2002 21:07:20 +0200
Message-ID: <87y98vmuqf.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds filesystem capabilities to 2.5.42, but it applies to
2.5.43 as well.

It's very simple. In the root directory of every filesystem, there
must be a file named ".capabilities". This is the capability database
indexed by inode number. These files are populated by a chcap tool,
see next mail.

This fs capability system should work on all filesystem, which can
provide long dotted names and have some sort of inode. Another benefit
is, when holes in files are allowed. Otherwise the .capabilities file
could grow pretty large.

I use this on an ext2 filesystem. It boots and seems to work so far.

Comments?

Regards, Olaf.

diff -urN a/security/Config.in b/security/Config.in
--- a/security/Config.in	Sat Oct  5 18:44:05 2002
+++ b/security/Config.in	Fri Oct 18 13:38:55 2002
@@ -3,5 +3,6 @@
 #
 mainmenu_option next_comment
 comment 'Security options'
-define_bool CONFIG_SECURITY_CAPABILITIES y
+tristate 'Security Capabilities' CONFIG_SECURITY_CAPABILITIES
+dep_bool '  Filesystem Capabilities (EXPERIMENTAL)' CONFIG_FS_CAPABILITIES $CONFIG_EXPERIMENTAL
 endmenu
diff -urN a/security/capability.c b/security/capability.c
--- a/security/capability.c	Sat Oct 12 14:24:21 2002
+++ b/security/capability.c	Fri Oct 18 20:05:30 2002
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <linux/namei.h>
 
 /* flag to keep track of how we were registered */
 static int secondary;
@@ -115,14 +116,53 @@
 	return 0;
 }
 
+#ifdef CONFIG_FS_CAPABILITIES
+static struct file *open_capabilities(struct linux_binprm *bprm)
+{
+	static char name[] = ".capabilities";
+	struct nameidata nd;
+	int err;
+	nd.mnt = mntget(bprm->file->f_vfsmnt);
+	nd.dentry = dget(nd.mnt->mnt_root);
+//	nd.last_type = LAST_ROOT;
+	nd.flags = 0;
+	err = path_walk(name, &nd);
+	if (err)
+		return ERR_PTR(err);
+
+	return dentry_open(nd.dentry, nd.mnt, O_RDONLY);
+}
+
+static void read_capabilities(struct file *filp, struct linux_binprm *bprm)
+{
+	__u32 fscaps[3];
+	unsigned long ino = bprm->file->f_dentry->d_inode->i_ino;
+	int n = kernel_read(filp, ino * sizeof(fscaps), (char *) fscaps, sizeof(fscaps));
+	if (n == sizeof(fscaps)) {
+		bprm->cap_effective = fscaps[0];
+		bprm->cap_inheritable = fscaps[1];
+		bprm->cap_permitted = fscaps[2];
+	}
+}
+#endif
+
 static int cap_bprm_set_security (struct linux_binprm *bprm)
 {
+#ifdef CONFIG_FS_CAPABILITIES
+	struct file *filp;
+#endif
 	/* Copied from fs/exec.c:prepare_binprm. */
 
-	/* We don't have VFS support for capabilities yet */
 	cap_clear (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
 	cap_clear (bprm->cap_effective);
+#ifdef CONFIG_FS_CAPABILITIES
+	filp = open_capabilities(bprm);
+	if (filp && !IS_ERR(filp)) {
+		read_capabilities(filp, bprm);
+		filp_close(filp, 0);
+	}
+#endif
 
 	/*  To support inheritance of root-permissions and suid-root
 	 *  executables under compatibility mode, we raise all three
