Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTFPRXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 13:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbTFPRXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 13:23:13 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:2185 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S264027AbTFPRXF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 13:23:05 -0400
Subject: [RFC][PATCH] AT_SECURE auxv entry
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Roland McGrath <roland@redhat.com>, jmorris@intercode.com.au,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1055784978.3362.74.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jun 2003 13:36:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.5.71 adds an AT_SECURE auxv entry to pass a boolean
flag indicating whether "secure mode" should be enabled (i.e. sanitize
the environment, initial descriptors, etc) and allows each security
module to specify the flag value via a new hook.  New userland can then
simply obey this flag when present rather than applying other methods of
deciding (sample patch for glibc-2.3.2 can be found at
http://www.cs.utah.edu/~sds/glibc-secureexec.patch).  This change
enables security modules like SELinux to request secure mode upon
changes to other security attributes (e.g. capabilities, roles/domains,
etc) in addition to uid/gid changes or even to completely override the
legacy logic.  The legacy decision algorithm is preserved in the default
hook functions for the dummy and capability security modules.  Credit
for the idea of adding an AT_SECURE auxv entry goes to Roland McGrath. 
If anyone has any objections to this patch, please let me know.  Thanks.


 fs/binfmt_elf.c          |    2 ++
 include/linux/elf.h      |    2 ++
 include/linux/security.h |   19 +++++++++++++++++++
 security/capability.c    |   13 +++++++++++++
 security/dummy.c         |   11 +++++++++++
 5 files changed, 47 insertions(+)

Index: linux-2.5/fs/binfmt_elf.c
diff -u linux-2.5/fs/binfmt_elf.c:1.1.1.7 linux-2.5/fs/binfmt_elf.c:1.2
--- linux-2.5/fs/binfmt_elf.c:1.1.1.7	Mon Jun 16 09:22:18 2003
+++ linux-2.5/fs/binfmt_elf.c	Mon Jun 16 11:27:34 2003
@@ -35,6 +35,7 @@
 #include <linux/compiler.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/param.h>
@@ -191,6 +192,7 @@
 	NEW_AUX_ENT(AT_EUID, (elf_addr_t) tsk->euid);
 	NEW_AUX_ENT(AT_GID, (elf_addr_t) tsk->gid);
 	NEW_AUX_ENT(AT_EGID, (elf_addr_t) tsk->egid);
+ 	NEW_AUX_ENT(AT_SECURE, (elf_addr_t) security_bprm_secureexec(bprm));
 	if (k_platform) {
 		NEW_AUX_ENT(AT_PLATFORM, (elf_addr_t)(long)u_platform);
 	}
Index: linux-2.5/include/linux/elf.h
diff -u linux-2.5/include/linux/elf.h:1.1.1.5 linux-2.5/include/linux/elf.h:1.2
--- linux-2.5/include/linux/elf.h:1.1.1.5	Tue May 27 11:04:23 2003
+++ linux-2.5/include/linux/elf.h	Mon Jun 16 11:27:35 2003
@@ -163,6 +163,8 @@
 #define AT_HWCAP  16    /* arch dependent hints at CPU capabilities */
 #define AT_CLKTCK 17	/* frequency at which times() increments */
 
+#define AT_SECURE 23   /* secure mode boolean */
+
 typedef struct dynamic{
   Elf32_Sword d_tag;
   union{
Index: linux-2.5/include/linux/security.h
diff -u linux-2.5/include/linux/security.h:1.1.1.4 linux-2.5/include/linux/security.h:1.22
--- linux-2.5/include/linux/security.h:1.1.1.4	Mon Jun 16 09:19:23 2003
+++ linux-2.5/include/linux/security.h	Mon Jun 16 11:27:35 2003
@@ -45,6 +45,7 @@
 extern void cap_capset_set (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
 extern int cap_bprm_set_security (struct linux_binprm *bprm);
 extern void cap_bprm_compute_creds (struct linux_binprm *bprm);
+extern int cap_bprm_secureexec(struct linux_binprm *bprm);
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
 extern void cap_task_reparent_to_init (struct task_struct *p);
 extern int cap_syslog (int type);
@@ -131,6 +132,12 @@
  * 	first.
  * 	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
+ * @bprm_secureexec:
+ *      Return a boolean value (0 or 1) indicating whether a "secure exec" 
+ *      is required.  The flag is passed in the auxiliary table
+ *      on the initial stack to the ELF interpreter to indicate whether libc 
+ *      should enable secure mode.
+ *      @bprm contains the linux_binprm structure.
  *
  * Security hooks for filesystem operations.
  *
@@ -988,6 +995,7 @@
 	void (*bprm_compute_creds) (struct linux_binprm * bprm);
 	int (*bprm_set_security) (struct linux_binprm * bprm);
 	int (*bprm_check_security) (struct linux_binprm * bprm);
+	int (*bprm_secureexec) (struct linux_binprm * bprm);
 
 	int (*sb_alloc_security) (struct super_block * sb);
 	void (*sb_free_security) (struct super_block * sb);
@@ -1246,11 +1254,17 @@
 {
 	return security_ops->bprm_set_security (bprm);
 }
+
 static inline int security_bprm_check (struct linux_binprm *bprm)
 {
 	return security_ops->bprm_check_security (bprm);
 }
 
+static inline int security_bprm_secureexec (struct linux_binprm *bprm)
+{
+	return security_ops->bprm_secureexec (bprm);
+}
+
 static inline int security_sb_alloc (struct super_block *sb)
 {
 	return security_ops->sb_alloc_security (sb);
@@ -1905,6 +1919,11 @@
 static inline int security_bprm_check (struct linux_binprm *bprm)
 {
 	return 0;
+}
+
+static inline int security_bprm_secureexec (struct linux_binprm *bprm)
+{
+	return cap_bprm_secureexec(bprm);
 }
 
 static inline int security_sb_alloc (struct super_block *sb)
Index: linux-2.5/security/capability.c
diff -u linux-2.5/security/capability.c:1.1.1.3 linux-2.5/security/capability.c:1.6
--- linux-2.5/security/capability.c:1.1.1.3	Mon Jun 16 09:25:52 2003
+++ linux-2.5/security/capability.c	Mon Jun 16 11:27:36 2003
@@ -158,6 +158,17 @@
 	current->keep_capabilities = 0;
 }
 
+int cap_bprm_secureexec (struct linux_binprm *bprm)
+{
+	/* If/when this module is enhanced to incorporate capability
+	   bits on files, the test below should be extended to also perform a 
+	   test between the old and new capability sets.  For now,
+	   it simply preserves the legacy decision algorithm used by
+	   the old userland. */
+	return (current->euid != current->uid ||
+		current->egid != current->gid);
+}
+
 /* moved from kernel/sys.c. */
 /* 
  * cap_emulate_setxuid() fixes the effective / permitted capabilities of
@@ -271,6 +282,7 @@
 EXPORT_SYMBOL(cap_capset_set);
 EXPORT_SYMBOL(cap_bprm_set_security);
 EXPORT_SYMBOL(cap_bprm_compute_creds);
+EXPORT_SYMBOL(cap_bprm_secureexec);
 EXPORT_SYMBOL(cap_task_post_setuid);
 EXPORT_SYMBOL(cap_task_reparent_to_init);
 EXPORT_SYMBOL(cap_syslog);
@@ -289,6 +301,7 @@
 
 	.bprm_compute_creds =		cap_bprm_compute_creds,
 	.bprm_set_security =		cap_bprm_set_security,
+	.bprm_secureexec =		cap_bprm_secureexec,
 
 	.task_post_setuid =		cap_task_post_setuid,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
Index: linux-2.5/security/dummy.c
diff -u linux-2.5/security/dummy.c:1.1.1.4 linux-2.5/security/dummy.c:1.19
--- linux-2.5/security/dummy.c:1.1.1.4	Mon Jun 16 09:25:52 2003
+++ linux-2.5/security/dummy.c	Mon Jun 16 11:27:36 2003
@@ -122,6 +122,16 @@
 	return 0;
 }
 
+static int dummy_bprm_secureexec (struct linux_binprm *bprm)
+{
+	/* The new userland will simply use the value provided
+	   in the AT_SECURE field to decide whether secure mode
+	   is required.  Hence, this logic is required to preserve
+	   the legacy decision algorithm used by the old userland. */
+	return (current->euid != current->uid ||
+		current->egid != current->gid);
+}
+
 static int dummy_sb_alloc_security (struct super_block *sb)
 {
 	return 0;
@@ -788,6 +798,7 @@
 	set_to_dummy_if_null(ops, bprm_compute_creds);
 	set_to_dummy_if_null(ops, bprm_set_security);
 	set_to_dummy_if_null(ops, bprm_check_security);
+	set_to_dummy_if_null(ops, bprm_secureexec);
 	set_to_dummy_if_null(ops, sb_alloc_security);
 	set_to_dummy_if_null(ops, sb_free_security);
 	set_to_dummy_if_null(ops, sb_kern_mount);


  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

