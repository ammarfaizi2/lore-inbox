Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVCGSgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVCGSgt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 13:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVCGSgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 13:36:49 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:63695 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261218AbVCGSgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 13:36:07 -0500
Subject: [PATCH][LSM/SELINUX] Pass requested protection to
	security_file_mmap/mprotect hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 07 Mar 2005 13:28:25 -0500
Message-Id: <1110220105.2778.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a reqprot parameter to the security_file_mmap and
security_file_mprotect hooks that is the original requested protection
value prior to any modification for read-implies-exec, and changes the
SELinux module to allow a mode of operation (controllable via a
checkreqprot setting) where it applies checks based on that protection
value rather than the protection that will be applied by the kernel,
effectively restoring SELinux's original behavior prior to the
introduction of the read-implies-exec logic in the mainline kernel.
The patch also disables execmem and execmod checking entirely on
PPC32, as the PPC32 ELF ABI presently requires RWE segments per Ulrich
Drepper.  The patch is relative to the enhanced MLS support patch submitted
against 2.6.11-mm1.

At present, the read-implies-exec logic causes SELinux to see every
mmap/mprotect read request by legacy binaries or binaries marked with
PT_GNU_STACK RWE as a read|execute request, which tends to distort
policy even if it reflects what is ultimately possible.  The
checkreqprot setting allows one to set the desired behavior for
SELinux, so either the current behavior or the original behavior is
possible.  The checkreqprot value has a compile-time configurable
default value and can also be set via boot parameter or at runtime via
/selinux/checkreqprot if allowed by policy.  Thanks to Chris Wright,
James Morris, and Colin Walters for comments on an earlier version of
the patch.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@redhat.com>

 include/linux/security.h                     |   25 +++++++----
 mm/mmap.c                                    |    4 -
 mm/mprotect.c                                |    6 +-
 security/dummy.c                             |    7 ++-
 security/selinux/Kconfig                     |   19 ++++++++
 security/selinux/hooks.c                     |   18 ++++++--
 security/selinux/include/av_perm_to_string.h |    1 
 security/selinux/include/av_permissions.h    |    1 
 security/selinux/include/objsec.h            |    2 
 security/selinux/selinuxfs.c                 |   60 +++++++++++++++++++++++++++
 10 files changed, 126 insertions(+), 17 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1-mls/include/linux/security.h linux-2.6.11-mm1-mls-reqprot/include/linux/security.h
--- linux-2.6.11-mm1-mls/include/linux/security.h	2005-03-07 13:06:54.000000000 -0500
+++ linux-2.6.11-mm1-mls-reqprot/include/linux/security.h	2005-03-07 12:21:48.000000000 -0500
@@ -458,13 +458,15 @@ struct swap_info_struct;
  *	Check permissions for a mmap operation.  The @file may be NULL, e.g.
  *	if mapping anonymous memory.
  *	@file contains the file structure for file to map (may be NULL).
- *	@prot contains the requested permissions.
+ *	@reqprot contains the protection requested by the application.
+ *	@prot contains the protection that will be applied by the kernel.
  *	@flags contains the operational flags.
  *	Return 0 if permission is granted.
  * @file_mprotect:
  *	Check permissions before changing memory access permissions.
  *	@vma contains the memory region to modify.
- *	@prot contains the requested permissions.
+ *	@reqprot contains the protection requested by the application.
+ *	@prot contains the protection that will be applied by the kernel.
  *	Return 0 if permission is granted.
  * @file_lock:
  *	Check permission before performing file locking operations.
@@ -1128,9 +1130,12 @@ struct security_operations {
 	void (*file_free_security) (struct file * file);
 	int (*file_ioctl) (struct file * file, unsigned int cmd,
 			   unsigned long arg);
-	int (*file_mmap) (struct file * file,
+	int (*file_mmap) (struct file * file, 
+			  unsigned long reqprot,
 			  unsigned long prot, unsigned long flags);
-	int (*file_mprotect) (struct vm_area_struct * vma, unsigned long prot);
+	int (*file_mprotect) (struct vm_area_struct * vma, 
+			      unsigned long reqprot,
+			      unsigned long prot);
 	int (*file_lock) (struct file * file, unsigned int cmd);
 	int (*file_fcntl) (struct file * file, unsigned int cmd,
 			   unsigned long arg);
@@ -1631,16 +1636,18 @@ static inline int security_file_ioctl (s
 	return security_ops->file_ioctl (file, cmd, arg);
 }
 
-static inline int security_file_mmap (struct file *file, unsigned long prot,
+static inline int security_file_mmap (struct file *file, unsigned long reqprot,
+				      unsigned long prot,
 				      unsigned long flags)
 {
-	return security_ops->file_mmap (file, prot, flags);
+	return security_ops->file_mmap (file, reqprot, prot, flags);
 }
 
 static inline int security_file_mprotect (struct vm_area_struct *vma,
+					  unsigned long reqprot,
 					  unsigned long prot)
 {
-	return security_ops->file_mprotect (vma, prot);
+	return security_ops->file_mprotect (vma, reqprot, prot);
 }
 
 static inline int security_file_lock (struct file *file, unsigned int cmd)
@@ -2278,13 +2285,15 @@ static inline int security_file_ioctl (s
 	return 0;
 }
 
-static inline int security_file_mmap (struct file *file, unsigned long prot,
+static inline int security_file_mmap (struct file *file, unsigned long reqprot,
+				      unsigned long prot,
 				      unsigned long flags)
 {
 	return 0;
 }
 
 static inline int security_file_mprotect (struct vm_area_struct *vma,
+					  unsigned long reqprot,
 					  unsigned long prot)
 {
 	return 0;
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1-mls/mm/mmap.c linux-2.6.11-mm1-mls-reqprot/mm/mmap.c
--- linux-2.6.11-mm1-mls/mm/mmap.c	2005-03-07 13:06:54.000000000 -0500
+++ linux-2.6.11-mm1-mls-reqprot/mm/mmap.c	2005-03-07 12:21:48.000000000 -0500
@@ -872,7 +872,7 @@ unsigned long do_mmap_pgoff(struct file 
 	int error;
 	struct rb_node ** rb_link, * rb_parent;
 	int accountable = 1;
-	unsigned long charged = 0;
+	unsigned long charged = 0, reqprot = prot;
 
 	if (file) {
 		if (is_file_hugepages(file))
@@ -990,7 +990,7 @@ unsigned long do_mmap_pgoff(struct file 
 		}
 	}
 
-	error = security_file_mmap(file, prot, flags);
+	error = security_file_mmap(file, reqprot, prot, flags);
 	if (error)
 		return error;
 		
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1-mls/mm/mprotect.c linux-2.6.11-mm1-mls-reqprot/mm/mprotect.c
--- linux-2.6.11-mm1-mls/mm/mprotect.c	2005-03-07 13:06:54.000000000 -0500
+++ linux-2.6.11-mm1-mls-reqprot/mm/mprotect.c	2005-03-07 12:21:48.000000000 -0500
@@ -219,7 +219,7 @@ fail:
 asmlinkage long
 sys_mprotect(unsigned long start, size_t len, unsigned long prot)
 {
-	unsigned long vm_flags, nstart, end, tmp;
+	unsigned long vm_flags, nstart, end, tmp, reqprot;
 	struct vm_area_struct *vma, *prev;
 	int error = -EINVAL;
 	const int grows = prot & (PROT_GROWSDOWN|PROT_GROWSUP);
@@ -237,6 +237,8 @@ sys_mprotect(unsigned long start, size_t
 		return -EINVAL;
 	if (end == start)
 		return 0;
+
+	reqprot = prot;
 	/*
 	 * Does the application expect PROT_READ to imply PROT_EXEC:
 	 */
@@ -290,7 +292,7 @@ sys_mprotect(unsigned long start, size_t
 			goto out;
 		}
 
-		error = security_file_mprotect(vma, prot);
+		error = security_file_mprotect(vma, reqprot, prot);
 		if (error)
 			goto out;
 
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1-mls/security/dummy.c linux-2.6.11-mm1-mls-reqprot/security/dummy.c
--- linux-2.6.11-mm1-mls/security/dummy.c	2005-03-07 13:06:54.000000000 -0500
+++ linux-2.6.11-mm1-mls-reqprot/security/dummy.c	2005-03-07 12:21:48.000000000 -0500
@@ -446,13 +446,16 @@ static int dummy_file_ioctl (struct file
 	return 0;
 }
 
-static int dummy_file_mmap (struct file *file, unsigned long prot,
+static int dummy_file_mmap (struct file *file, unsigned long reqprot,
+			    unsigned long prot,
 			    unsigned long flags)
 {
 	return 0;
 }
 
-static int dummy_file_mprotect (struct vm_area_struct *vma, unsigned long prot)
+static int dummy_file_mprotect (struct vm_area_struct *vma, 
+				unsigned long reqprot,
+				unsigned long prot)
 {
 	return 0;
 }
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1-mls/security/selinux/hooks.c linux-2.6.11-mm1-mls-reqprot/security/selinux/hooks.c
--- linux-2.6.11-mm1-mls/security/selinux/hooks.c	2005-03-07 13:06:54.000000000 -0500
+++ linux-2.6.11-mm1-mls-reqprot/security/selinux/hooks.c	2005-03-07 12:55:52.000000000 -0500
@@ -2421,6 +2421,7 @@ static int selinux_file_ioctl(struct fil
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
+#ifndef CONFIG_PPC32
 	if ((prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
 		/*
 		 * We are making executable an anonymous mapping or a
@@ -2431,6 +2432,7 @@ static int file_map_prot_check(struct fi
 		if (rc)
 			return rc;
 	}
+#endif
 
 	if (file) {
 		/* read access is always possible with a mapping */
@@ -2448,27 +2450,36 @@ static int file_map_prot_check(struct fi
 	return 0;
 }
 
-static int selinux_file_mmap(struct file *file, unsigned long prot, unsigned long flags)
+static int selinux_file_mmap(struct file *file, unsigned long reqprot, 
+			     unsigned long prot, unsigned long flags)
 {
 	int rc;
 
-	rc = secondary_ops->file_mmap(file, prot, flags);
+	rc = secondary_ops->file_mmap(file, reqprot, prot, flags);
 	if (rc)
 		return rc;
 
+	if (selinux_checkreqprot)
+		prot = reqprot;
+
 	return file_map_prot_check(file, prot,
 				   (flags & MAP_TYPE) == MAP_SHARED);
 }
 
 static int selinux_file_mprotect(struct vm_area_struct *vma,
+				 unsigned long reqprot,
 				 unsigned long prot)
 {
 	int rc;
 
-	rc = secondary_ops->file_mprotect(vma, prot);
+	rc = secondary_ops->file_mprotect(vma, reqprot, prot);
 	if (rc)
 		return rc;
 
+	if (selinux_checkreqprot)
+		prot = reqprot;
+
+#ifndef CONFIG_PPC32
 	if (vma->vm_file != NULL && vma->anon_vma != NULL && (prot & PROT_EXEC)) {
 		/*
 		 * We are making executable a file mapping that has
@@ -2480,6 +2491,7 @@ static int selinux_file_mprotect(struct 
 		if (rc)
 			return rc;
 	}
+#endif
 
 	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
 }
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1-mls/security/selinux/include/av_permissions.h linux-2.6.11-mm1-mls-reqprot/security/selinux/include/av_permissions.h
--- linux-2.6.11-mm1-mls/security/selinux/include/av_permissions.h	2005-03-07 13:06:54.000000000 -0500
+++ linux-2.6.11-mm1-mls-reqprot/security/selinux/include/av_permissions.h	2005-03-07 12:21:48.000000000 -0500
@@ -522,6 +522,7 @@
 #define SECURITY__SETENFORCE                      0x00000080UL
 #define SECURITY__SETBOOL                         0x00000100UL
 #define SECURITY__SETSECPARAM                     0x00000200UL
+#define SECURITY__SETCHECKREQPROT                 0x00000400UL
 
 #define SYSTEM__IPC_INFO                          0x00000001UL
 #define SYSTEM__SYSLOG_READ                       0x00000002UL
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1-mls/security/selinux/include/av_perm_to_string.h linux-2.6.11-mm1-mls-reqprot/security/selinux/include/av_perm_to_string.h
--- linux-2.6.11-mm1-mls/security/selinux/include/av_perm_to_string.h	2005-03-07 13:06:54.000000000 -0500
+++ linux-2.6.11-mm1-mls-reqprot/security/selinux/include/av_perm_to_string.h	2005-03-07 12:21:48.000000000 -0500
@@ -83,6 +83,7 @@
    S_(SECCLASS_SECURITY, SECURITY__SETENFORCE, "setenforce")
    S_(SECCLASS_SECURITY, SECURITY__SETBOOL, "setbool")
    S_(SECCLASS_SECURITY, SECURITY__SETSECPARAM, "setsecparam")
+   S_(SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT, "setcheckreqprot")
    S_(SECCLASS_SYSTEM, SYSTEM__IPC_INFO, "ipc_info")
    S_(SECCLASS_SYSTEM, SYSTEM__SYSLOG_READ, "syslog_read")
    S_(SECCLASS_SYSTEM, SYSTEM__SYSLOG_MOD, "syslog_mod")
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1-mls/security/selinux/include/objsec.h linux-2.6.11-mm1-mls-reqprot/security/selinux/include/objsec.h
--- linux-2.6.11-mm1-mls/security/selinux/include/objsec.h	2005-03-07 13:06:54.000000000 -0500
+++ linux-2.6.11-mm1-mls-reqprot/security/selinux/include/objsec.h	2005-03-07 12:21:48.000000000 -0500
@@ -109,4 +109,6 @@ struct sk_security_struct {
 
 extern int inode_security_set_sid(struct inode *inode, u32 sid);
 
+extern unsigned int selinux_checkreqprot;
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1-mls/security/selinux/Kconfig linux-2.6.11-mm1-mls-reqprot/security/selinux/Kconfig
--- linux-2.6.11-mm1-mls/security/selinux/Kconfig	2005-03-07 13:06:54.000000000 -0500
+++ linux-2.6.11-mm1-mls-reqprot/security/selinux/Kconfig	2005-03-07 12:21:48.000000000 -0500
@@ -76,3 +76,22 @@ config SECURITY_SELINUX_AVC_STATS
 	  /selinux/avc/cache_stats, which may be monitored via
 	  tools such as avcstat.
 
+config SECURITY_SELINUX_CHECKREQPROT_VALUE
+	int "NSA SELinux checkreqprot default value"
+	depends on SECURITY_SELINUX
+	range 0 1
+	default 1
+	help
+	  This option sets the default value for the 'checkreqprot' flag
+	  that determines whether SELinux checks the protection requested
+	  by the application or the protection that will be applied by the
+	  kernel (including any implied execute for read-implies-exec) for
+	  mmap and mprotect calls.  If this option is set to 0 (zero), 
+	  SELinux will default to checking the protection that will be applied
+	  by the kernel.  If this option is set to 1 (one), SELinux will 
+	  default to checking the protection requested by the application.
+	  The checkreqprot flag may be changed from the default via the 
+	  'checkreqprot=' boot parameter.  It may also be changed at runtime 
+	  via /selinux/checkreqprot if authorized by policy.
+
+	  If you are unsure how to answer this question, answer 1.
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1-mls/security/selinux/selinuxfs.c linux-2.6.11-mm1-mls-reqprot/security/selinux/selinuxfs.c
--- linux-2.6.11-mm1-mls/security/selinux/selinuxfs.c	2005-03-07 13:06:54.000000000 -0500
+++ linux-2.6.11-mm1-mls-reqprot/security/selinux/selinuxfs.c	2005-03-07 12:21:48.000000000 -0500
@@ -34,6 +34,16 @@
 #include "objsec.h"
 #include "conditional.h"
 
+unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
+
+static int __init checkreqprot_setup(char *str)
+{
+	selinux_checkreqprot = simple_strtoul(str,NULL,0) ? 1 : 0;
+	return 1;
+}
+__setup("checkreqprot=", checkreqprot_setup);
+
+
 static DECLARE_MUTEX(sel_sem);
 
 /* global data for booleans */
@@ -72,6 +82,7 @@ enum sel_inos {
 	SEL_DISABLE,	/* disable SELinux until next reboot */
 	SEL_AVC,	/* AVC management directory */
 	SEL_MEMBER,	/* compute polyinstantiation membership decision */
+	SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
 };
 
 #define TMPBUFLEN	12
@@ -300,6 +311,54 @@ static struct file_operations sel_contex
 	.write		= sel_write_context,
 };
 
+static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	char tmpbuf[TMPBUFLEN];
+	ssize_t length;
+
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", selinux_checkreqprot);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
+static ssize_t sel_write_checkreqprot(struct file * file, const char __user * buf,
+				      size_t count, loff_t *ppos)
+{
+	char *page;
+	ssize_t length;
+	unsigned int new_value;
+
+	length = task_has_security(current, SECURITY__SETCHECKREQPROT);
+	if (length)
+		return length;
+
+	if (count < 0 || count >= PAGE_SIZE)
+		return -ENOMEM;
+	if (*ppos != 0) {
+		/* No partial writes. */
+		return -EINVAL;
+	}
+	page = (char*)get_zeroed_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+	length = -EFAULT;
+	if (copy_from_user(page, buf, count))
+		goto out;
+
+	length = -EINVAL;
+	if (sscanf(page, "%u", &new_value) != 1)
+		goto out;
+
+	selinux_checkreqprot = new_value ? 1 : 0;
+	length = count;
+out:
+	free_page((unsigned long) page);
+	return length;
+}
+static struct file_operations sel_checkreqprot_ops = {
+	.read		= sel_read_checkreqprot,
+	.write		= sel_write_checkreqprot,
+};
 
 /*
  * Remaining nodes use transaction based IO methods like nfsd/nfsctl.c
@@ -1182,6 +1241,7 @@ static int sel_fill_super(struct super_b
 		[SEL_MLS] = {"mls", &sel_mls_ops, S_IRUGO},
 		[SEL_DISABLE] = {"disable", &sel_disable_ops, S_IWUSR},
 		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
+		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);


-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

