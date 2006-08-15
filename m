Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030489AbWHOTl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbWHOTl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWHOTl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:41:56 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:21844 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030486AbWHOTlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:41:55 -0400
Date: Tue, 15 Aug 2006 14:41:51 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Nicholas Miell <nmiell@comcast.net>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060815194151.GA8596@vino.hallyn.com>
References: <20060730011338.GA31695@sergelap.austin.ibm.com> <20060814220651.GA7726@sergelap.austin.ibm.com> <m1r6zirgst.fsf@ebiederm.dsl.xmission.com> <20060815020647.GB16220@sergelap.austin.ibm.com> <m13bbyr80e.fsf@ebiederm.dsl.xmission.com> <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com> <20060815122026.GA7422@vino.hallyn.com> <1155670262.2432.4.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155670262.2432.4.camel@entropy>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicholas Miell (nmiell@comcast.net):
> On Tue, 2006-08-15 at 07:20 -0500, Serge E. Hallyn wrote:
> > Quoting Serge E. Hallyn (serge@hallyn.com):
> > > > Make it an arbitrary length bitfield with a defined byte order (little
> > > > endian, probably). Bits at offsets greater than the length of the
> > > > bitfield are defined to be zero. If the kernel encounters a set bit that
> > > > it doesn't recognizes, fail with EPERM. If userspace attempts to set a
> > > > bit that the kernel doesn't recognize, fail with EINVAL.
> > > > 
> > > > It's extensible (as new capability bits are added, the length of the
> > > > bitfield grows), backward compatible (as long as there are no unknown
> > > > bits set, it'll still work) and secure (if an unknown bit is set, the
> > > > kernel fails immediately, so there's no chance of a "secure" app running
> > > > with less privileges than it expects and opening up a security hole).
> > > 
> > > Sounds good.
> > > 
> > > The version number will imply the bitfield length, or do we feel warm
> > > fuzzies if the length is redundantly encoded in the structure?
> > 
> > nm, 'encoded in the structure' clearly is silly.
> > 
> 
> There isn't really a version number, just recognized and unrecognized

Well, there is, defined in include/linux/capability.h, but it has never
changed thus far, and tying it to the bitfield length could get ugly as
things change.

In the below patch, the length is simply defined in
include/linux/capability.h, nothing fancy.  If anything beyond the known
capability bits is set to 1, we refuse exec permission.

> capability bits. If you wanted, you could use a single byte to give a
> binary CAP_DAC_OVERRIDE, with capability bits 8-30 being "stored" in
> not-present bytes and therefore assumed to be zero.

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH 1/1] security: introduce fs caps

Implement filesystem posix capabilities.  This allows programs to
be given a subset of root's powers regardless of who runs them,
without having to use setuid and giving the binary all of root's
powers.

This version works with Kaigai Kohei's userspace tools, found at
http://www.kaigai.gr.jp/pub/fscaps-1.0-kg.src.rpm under
http://www.kaigai.gr.jp/index.php?FrontPage#b556e50d.

Changelog:
	Aug 15:
	Handle endianness of xattrs.
	Enforce capability version match between kernel and disk.
	Enforce that no bits beyond the known max capability are
	set, else return -EPERM.
	With this extra processing, it may be worth reconsidering
	doing all the work at bprm_set_security rather than
	d_instantiate.

	Aug 10:
	Always call getxattr at bprm_set_security, rather than
	caching it at d_instantiate.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 include/linux/capability.h |    2 +
 security/Kconfig           |   10 +++++
 security/commoncap.c       |   85 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 1 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 6548b35..8b1932c 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -288,6 +288,8 @@ #define CAP_AUDIT_WRITE      29
 
 #define CAP_AUDIT_CONTROL    30
 
+#define CAP_NUMCAPS	     30
+
 #ifdef __KERNEL__
 /* 
  * Bounding set
diff --git a/security/Kconfig b/security/Kconfig
index 67785df..ce2bac7 100644
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
index f50fc29..6bf030d 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -109,11 +109,55 @@ void cap_capset_set (struct task_struct 
 	target->cap_permitted = *permitted;
 }
 
+#define XATTR_CAPS_SUFFIX "capability"
+#define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
+struct vfs_cap_data_struct {
+	__u32 version;
+	__u32 effective;
+	__u32 permitted;
+	__u32 inheritable;
+};
+
+static inline void convert_to_le(struct vfs_cap_data_struct *cap)
+{
+	cap->version = le32_to_cpu(cap->version);
+	cap->effective = le32_to_cpu(cap->effective);
+	cap->permitted = le32_to_cpu(cap->permitted);
+	cap->inheritable = le32_to_cpu(cap->inheritable);
+}
+
+static int check_cap_sanity(struct vfs_cap_data_struct *cap)
+{
+	int i;
+
+	if (cap->version != _LINUX_CAPABILITY_VERSION)
+		return -EPERM;
+
+	for (i=CAP_NUMCAPS; i<sizeof(cap->effective); i++) {
+		if (cap->effective & CAP_TO_MASK(i))
+			return -EPERM;
+	}
+	for (i=CAP_NUMCAPS; i<sizeof(cap->permitted); i++) {
+		if (cap->permitted & CAP_TO_MASK(i))
+			return -EPERM;
+	}
+	for (i=CAP_NUMCAPS; i<sizeof(cap->inheritable); i++) {
+		if (cap->inheritable & CAP_TO_MASK(i))
+			return -EPERM;
+	}
+
+	return 0;
+}
+
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
+	struct dentry *dentry;
+	ssize_t rc;
+	struct vfs_cap_data_struct cap_struct;
+	struct inode *inode;
+
 	/* Copied from fs/exec.c:prepare_binprm. */
 
-	/* We don't have VFS support for capabilities yet */
 	cap_clear (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
 	cap_clear (bprm->cap_effective);
@@ -134,6 +178,45 @@ int cap_bprm_set_security (struct linux_
 		if (bprm->e_uid == 0)
 			cap_set_full (bprm->cap_effective);
 	}
+
+#ifdef CONFIG_SECURITY_FS_CAPABILITIES
+	/* Locate any VFS capabilities: */
+
+	dentry = dget(bprm->file->f_dentry);
+	inode = dentry->d_inode;
+	if (!inode->i_op || !inode->i_op->getxattr) {
+		dput(dentry);
+		return 0;
+	}
+
+	rc = inode->i_op->getxattr(dentry, XATTR_NAME_CAPS, &cap_struct,
+						sizeof(cap_struct));
+	dput(dentry);
+
+	if (rc == -ENODATA)
+		return 0;
+
+	if (rc < 0) {
+		printk(KERN_NOTICE "%s: Error (%d) getting xattr\n",
+				__FUNCTION__, rc);
+		return rc;
+	}
+
+	if (rc != sizeof(cap_struct)) {
+		printk(KERN_NOTICE "%s: got wrong size for getxattr (%d)\n",
+					__FUNCTION__, rc);
+		return -EPERM;
+	}
+	
+	convert_to_le(&cap_struct);
+	if (check_cap_sanity(&cap_struct))
+		return -EPERM;
+
+	bprm->cap_effective = cap_struct.effective;
+	bprm->cap_permitted = cap_struct.permitted;
+	bprm->cap_inheritable = cap_struct.inheritable;
+
+#endif
 	return 0;
 }
 
-- 
1.4.2

