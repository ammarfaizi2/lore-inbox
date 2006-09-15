Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWIOPjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWIOPjV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWIOPjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:39:21 -0400
Received: from nef2.ens.fr ([129.199.96.40]:64263 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1751408AbWIOPjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:39:20 -0400
Date: Fri, 15 Sep 2006 17:39:18 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: [PATCH] security: add a mount option to make caps inheritable, re-enable CAP_SETPCAP
Message-ID: <20060915153918.GA29528@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Fri, 15 Sep 2006 17:39:19 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Attempt to make capabilities mildly useful, without breaking anything
and while still adhering to POSIX.1e semantics:

 * add a "inhcaps" mount option (MS_INHCAPS) which provides full
   executable inheritable and effective sets (we cannot provide
   finer-grained control over the mask, as fs-independent mount
   options are only one bit wide each);

 * re-enable CAP_SETPCAP which had been disabled following an
   incorrect analysis of a past sendmail security hole.

Signed-off-by: David A. Madore <david.madore@ens.fr>

---

		*** IMPORTANT NOTE ***

	This patch IS NOT related (nor compatible) with the one posted
	a few days ago on this list under the name "new capabilities
	patch".  The latter was much more ambitious and deviated from
	POSIX.1e semantics.  It has been abandoned due to heavy
	criticism on LKML.  *This* patch is much restricted and very
	simple, and the author hopes that it will be somewhat
	consensual: it does not change the (broken) semantics of
	capabilities in any way, only adds a mount option to enable
	inheritance; it also does not add any new capabilities, change
	the size of the capability sets or anything of the sort.  It
	does not add any filesystem support for capabilities (only
	per-mount support), but should be compatible with patches
	which add such support.

	Note that you need a patched version of mount (not
	provided...) to use the new "inhcaps" mount option.

 fs/namespace.c             |    5 ++++-
 include/linux/capability.h |    2 +-
 include/linux/fs.h         |    1 +
 include/linux/mount.h      |    1 +
 security/commoncap.c       |   10 ++++++++--
 5 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fa7ed6a..63b6227 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -376,6 +376,7 @@ static int show_vfsmnt(struct seq_file *
 		{ MNT_NOEXEC, ",noexec" },
 		{ MNT_NOATIME, ",noatime" },
 		{ MNT_NODIRATIME, ",nodiratime" },
+		{ MNT_INHCAPS, ",inhcaps" },
 		{ 0, NULL }
 	};
 	struct proc_fs_info *fs_infop;
@@ -1413,9 +1414,11 @@ long do_mount(char *dev_name, char *dir_
 		mnt_flags |= MNT_NOATIME;
 	if (flags & MS_NODIRATIME)
 		mnt_flags |= MNT_NODIRATIME;
+	if (flags & MS_INHCAPS)
+		mnt_flags |= MNT_INHCAPS;
 
 	flags &= ~(MS_NOSUID | MS_NOEXEC | MS_NODEV | MS_ACTIVE |
-		   MS_NOATIME | MS_NODIRATIME);
+		   MS_NOATIME | MS_NODIRATIME | MS_INHCAPS);
 
 	/* ... and get the mountpoint */
 	retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 6548b35..e37a268 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -312,7 +312,7 @@ #endif
 
 #define CAP_EMPTY_SET       to_cap_t(0)
 #define CAP_FULL_SET        to_cap_t(~0)
-#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
+#define CAP_INIT_EFF_SET    to_cap_t(~0)
 #define CAP_INIT_INH_SET    to_cap_t(0)
 
 #define CAP_TO_MASK(x) (1 << (x))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 555bc19..b41e515 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -106,6 +106,7 @@ #define MS_SYNCHRONOUS	16	/* Writes are 
 #define MS_REMOUNT	32	/* Alter flags of a mounted FS */
 #define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
 #define MS_DIRSYNC	128	/* Directory modifications are synchronous */
+#define MS_INHCAPS	256	/* Inherit capabilities by default */
 #define MS_NOATIME	1024	/* Do not update access times. */
 #define MS_NODIRATIME	2048	/* Do not update directory access times */
 #define MS_BIND		4096
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 403d1a9..b744823 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -27,6 +27,7 @@ #define MNT_NODEV	0x02
 #define MNT_NOEXEC	0x04
 #define MNT_NOATIME	0x08
 #define MNT_NODIRATIME	0x10
+#define MNT_INHCAPS	0x20
 
 #define MNT_SHRINKABLE	0x100
 
diff --git a/security/commoncap.c b/security/commoncap.c
index f50fc29..2488ed5 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -13,6 +13,7 @@ #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/security.h>
 #include <linux/file.h>
+#include <linux/mount.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -114,9 +115,14 @@ int cap_bprm_set_security (struct linux_
 	/* Copied from fs/exec.c:prepare_binprm. */
 
 	/* We don't have VFS support for capabilities yet */
-	cap_clear (bprm->cap_inheritable);
+	if (bprm->file->f_vfsmnt->mnt_flags & MNT_INHCAPS) {
+		cap_set_full (bprm->cap_inheritable);
+		cap_set_full (bprm->cap_effective);
+	} else {
+		cap_clear (bprm->cap_inheritable);
+		cap_clear (bprm->cap_effective);
+	}
 	cap_clear (bprm->cap_permitted);
-	cap_clear (bprm->cap_effective);
 
 	/*  To support inheritance of root-permissions and suid-root
 	 *  executables under compatibility mode, we raise all three
