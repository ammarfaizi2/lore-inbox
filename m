Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWHNWID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWHNWID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 18:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWHNWIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 18:08:01 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:2961 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965004AbWHNWH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 18:07:59 -0400
Date: Mon, 14 Aug 2006 17:06:51 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
       chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060814220651.GA7726@sergelap.austin.ibm.com>
References: <20060730011338.GA31695@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730011338.GA31695@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge E. Hallyn (serue@us.ibm.com):
> This patch implements file (posix) capabilities.  This allows
> a binary to gain a subset of root's capabilities without having
> the file actually be setuid root.
> 
> There are some other implementations out there taking various
> approaches.  This patch keeps all the changes within the
> capability LSM, and stores the file capabilities in xattrs
> named "security.capability".  First question is, do we want
> this in the kernel?  Second is, is this sort of implementation
> we'd want?
> 
> Some userspace tools to manipulate the fscaps are at
> www.sr71.net/~hallyn/fscaps/.  For instance,
> 
> 	setcap writeroot "cap_dac_read_search,cap_dac_override+eip"
> 
> allows the 'writeroot' testcase to write to /root/ab when
> run as a normal user.
> 
> This patch doesn't address the need to update
> cap_bprm_secureexec().
> 
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> ---
>  include/linux/security.h |   10 +++-
>  security/Kconfig         |   11 ++++
>  security/capability.c    |    5 ++
>  security/commoncap.c     |  127 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 152 insertions(+), 1 deletions(-)

Here is a different version which sticks closer to the original
version by Simmonds, in that it simply calls getxattr at
bprm_set_security.  Very inadequate perftesting showed no
overhead, and this makes the patch much smaller and compatible
with SELinux.  Note that this patch changes nothing if
CONFIG_FS_CAPABILITIES is not enabled, which is the default, and
should therefore be safe to include in -mm.

(Also CC:ing lsm list which I forgot to do last time)

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 security/Kconfig     |   10 ++++++++++
 security/commoncap.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 67785df..aa3558f 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -80,6 +80,16 @@ config SECURITY_CAPABILITIES
 	  This enables the "default" Linux capabilities functionality.
 	  If you are unsure how to answer this question, answer Y.
 
+config SECURITY_FS_CAPABILITIES
+	bool "Filesystem Capabilities"
+	depends on SECURITY_CAPABILITIES
+	default n
+	help
+	  This enables filesystem capabilities, allowing you to give
+	  binaries a subset of root's powers without using setuid 0.
+
+	  If in doubt, answer N.
+
 config SECURITY_ROOTPLUG
 	tristate "Root Plug Support"
 	depends on USB && SECURITY
diff --git a/security/commoncap.c b/security/commoncap.c
index f50fc29..064fbb0 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -109,11 +109,17 @@ void cap_capset_set (struct task_struct 
 	target->cap_permitted = *permitted;
 }
 
+#define XATTR_CAPS_SUFFIX "capability"
+#define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
+	ssize_t (*bprm_getxattr)(struct dentry *,const char *,void *,size_t);
+	struct dentry *bprm_dentry;
+	ssize_t rc;
+	u32 fscaps[3];
+
 	/* Copied from fs/exec.c:prepare_binprm. */
 
-	/* We don't have VFS support for capabilities yet */
 	cap_clear (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
 	cap_clear (bprm->cap_effective);
@@ -134,6 +140,46 @@ int cap_bprm_set_security (struct linux_
 		if (bprm->e_uid == 0)
 			cap_set_full (bprm->cap_effective);
 	}
+
+#ifdef CONFIG_SECURITY_FS_CAPABILITIES
+	/* Locate any VFS capabilities: */
+
+	bprm_dentry = dget(bprm->file->f_dentry);
+	if(!(bprm_dentry->d_inode->i_op &&
+			bprm_dentry->d_inode->i_op->getxattr)) {
+		dput(bprm_dentry);
+		return 0;
+	}
+	bprm_getxattr = bprm_dentry->d_inode->i_op->getxattr;
+
+	rc = bprm_getxattr(bprm_dentry, XATTR_NAME_CAPS, &fscaps,
+						sizeof(fscaps));
+	dput(bprm_dentry);
+
+	/*
+	 * serge: not sure about the return values...
+	 * think about them some more, maybe some should
+	 * return rc.
+	 */
+	if (rc < 0 && rc != -ENODATA) {
+		printk(KERN_NOTICE "%s: Error (%d) getting xattr\n",
+				__FUNCTION__, rc);
+		return 0;
+	}
+	if (rc < 0)
+		return 0;
+
+	if (rc != sizeof(fscaps)) {
+		printk(KERN_NOTICE "%s: got wrong size for getxattr (%d)\n",
+					__FUNCTION__, rc);
+		return 0;
+	}
+
+	bprm->cap_effective = fscaps[0];
+	bprm->cap_inheritable = fscaps[1];
+	bprm->cap_permitted = fscaps[2];
+
+#endif
 	return 0;
 }
 
-- 
1.4.1.1

