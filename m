Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754635AbWKMQnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbWKMQnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755156AbWKMQne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:43:34 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:49045 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1754635AbWKMQnc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:43:32 -0500
Date: Mon, 13 Nov 2006 10:43:26 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Chris Friedhoff <chris@friedhoff.org>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061113164326.GA11355@sergelap.austin.ibm.com>
References: <20061108222453.GA6408@sergelap.austin.ibm.com> <20061108224837.GG4972@martell.zuzino.mipt.ru> <20061108235203.GA7987@sergelap.austin.ibm.com> <20061109052733.GA4976@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109052733.GA4976@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexey Dobriyan (adobriyan@gmail.com):
> On Wed, Nov 08, 2006 at 05:52:03PM -0600, Serge E. Hallyn wrote:
> > > > +	__u32 version;
> > > > +	__u32 effective;
> > > > +	__u32 permitted;
> > > > +	__u32 inheritable;
> > > > +};
> > > > +
> > > > +static inline void convert_to_le(struct vfs_cap_data_struct *cap)
> > > > +{
> > > > +	cap->version = le32_to_cpu(cap->version);
> > > > +	cap->effective = le32_to_cpu(cap->effective);
> > > > +	cap->permitted = le32_to_cpu(cap->permitted);
> > > > +	cap->inheritable = le32_to_cpu(cap->inheritable);
> > > > +}
> > >
> > > This pretty much defeats sparse endian checking. You will get warnings
> > > regardless of whether u32 or le32 are used.
> >
> > But I don't get any sparse warnings with make C=1.  Am I doing something
> > wrong?
> 
> You need (temporarily) to use CF:
> 
> 	make C=1 CF=-D__CHECK_ENDIAN__ ...

The following patch on top of the existing one eliminates the warning.
Does it appear consistent with what you were suggesting?

If it is ok, I'll resend the full patch.

Thank you for that help.

-serge

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH 1/1] filecaps: fix endianness warnings

Fix endianness warnings as suggested by Alexey Dobriyan.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 include/linux/capability.h |   21 +++++++++++++++++++++
 security/commoncap.c       |   39 ++++++++++++++++-----------------------
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 76a6e87..c54b201 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -39,12 +39,33 @@ typedef struct __user_cap_data_struct {
         __u32 permitted;
         __u32 inheritable;
 } __user *cap_user_data_t;
+
+
+#ifdef CONFIG_SECURITY_FS_CAPABILITIES
+#define XATTR_CAPS_SUFFIX "capability"
+#define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
+struct vfs_cap_data_disk {
+	__le32 version;
+	__le32 effective;
+	__le32 permitted;
+	__le32 inheritable;
+};
+#endif
   
 #ifdef __KERNEL__
 
 #include <linux/spinlock.h>
 #include <asm/current.h>
 
+#ifdef CONFIG_SECURITY_FS_CAPABILITIES
+struct vfs_cap_data {
+	__u32 version;
+	__u32 effective;
+	__u32 permitted;
+	__u32 inheritable;
+};
+#endif
+
 /* #define STRICT_CAP_T_TYPECHECKS */
 
 #ifdef STRICT_CAP_T_TYPECHECKS
diff --git a/security/commoncap.c b/security/commoncap.c
index 4b50b4d..c1ef43f 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -110,21 +110,13 @@ void cap_capset_set (struct task_struct 
 }
 
 #ifdef CONFIG_SECURITY_FS_CAPABILITIES
-#define XATTR_CAPS_SUFFIX "capability"
-#define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
-struct vfs_cap_data {
-	__u32 version;
-	__u32 effective;
-	__u32 permitted;
-	__u32 inheritable;
-};
-
-static inline void convert_to_le(struct vfs_cap_data *cap)
+static inline void cap_from_disk(struct vfs_cap_data_disk *dcap,
+					struct vfs_cap_data *cap)
 {
-	cap->version = le32_to_cpu(cap->version);
-	cap->effective = le32_to_cpu(cap->effective);
-	cap->permitted = le32_to_cpu(cap->permitted);
-	cap->inheritable = le32_to_cpu(cap->inheritable);
+	cap->version = le32_to_cpu(dcap->version);
+	cap->effective = le32_to_cpu(dcap->effective);
+	cap->permitted = le32_to_cpu(dcap->permitted);
+	cap->inheritable = le32_to_cpu(dcap->inheritable);
 }
 
 static int check_cap_sanity(struct vfs_cap_data *cap)
@@ -155,7 +147,8 @@ static int set_file_caps(struct linux_bi
 {
 	struct dentry *dentry;
 	ssize_t rc;
-	struct vfs_cap_data cap_struct;
+	struct vfs_cap_data_disk dcaps;
+	struct vfs_cap_data caps;
 	struct inode *inode;
 
 	dentry = dget(bprm->file->f_dentry);
@@ -165,8 +158,8 @@ static int set_file_caps(struct linux_bi
 		return 0;
 	}
 
-	rc = inode->i_op->getxattr(dentry, XATTR_NAME_CAPS, &cap_struct,
-						sizeof(cap_struct));
+	rc = inode->i_op->getxattr(dentry, XATTR_NAME_CAPS, &dcaps,
+						sizeof(dcaps));
 	dput(dentry);
 
 	if (rc == -ENODATA)
@@ -178,19 +171,19 @@ static int set_file_caps(struct linux_bi
 		return rc;
 	}
 
-	if (rc != sizeof(cap_struct)) {
+	if (rc != sizeof(dcaps)) {
 		printk(KERN_NOTICE "%s: got wrong size for getxattr (%d)\n",
 					__FUNCTION__, rc);
 		return -EPERM;
 	}
 	
-	convert_to_le(&cap_struct);
-	if (check_cap_sanity(&cap_struct))
+	cap_from_disk(&dcaps, &caps);
+	if (check_cap_sanity(&caps))
 		return -EPERM;
 
-	bprm->cap_effective = cap_struct.effective;
-	bprm->cap_permitted = cap_struct.permitted;
-	bprm->cap_inheritable = cap_struct.inheritable;
+	bprm->cap_effective = caps.effective;
+	bprm->cap_permitted = caps.permitted;
+	bprm->cap_inheritable = caps.inheritable;
 
 	return 0;
 }
-- 
1.4.1

