Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbUDTPTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUDTPTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 11:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUDTPTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 11:19:21 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:3490 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262961AbUDTPTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 11:19:08 -0400
Subject: [PATCH][SELINUX] Add runtime disable for SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Jeremy Katz <katzj@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       selinux@tycho.nsa.gov
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1082474329.7481.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Apr 2004 11:18:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.6-rc1-mm1 adds a kernel configuration option that
enables writing to a new selinuxfs node 'disable' that allows SELinux to
be disabled at runtime prior to initial policy load.  SELinux will then
remain disabled until next boot.  This option is similar to the
selinux=0 boot parameter, but is to support runtime disabling of
SELinux, e.g. from /sbin/init, for portability across platforms where
boot parameters are difficult to employ (based on feedback by Jeremy
Katz, who I have CC'd).

 security/selinux/Kconfig     |   15 ++++++++++
 security/selinux/hooks.c     |   53 ++++++++++++++++++++++++++++++++++++
 security/selinux/selinuxfs.c |   62 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 128 insertions(+), 2 deletions(-)

diff -X /home/sds/dontdiff -ru linux-2.6.old/security/selinux/hooks.c linux-2.6/security/selinux/hooks.c
--- linux-2.6.old/security/selinux/hooks.c	2004-04-20 08:48:52.000000000 -0400
+++ linux-2.6/security/selinux/hooks.c	2004-04-20 10:11:17.637184602 -0400
@@ -4217,4 +4217,57 @@
 
 __initcall(selinux_nf_ip_init);
 
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+static void selinux_nf_ip_exit(void)
+{
+	printk(KERN_INFO "SELinux:  Unregistering netfilter hooks\n");
+	
+	nf_unregister_hook(&selinux_ipv4_op);
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	nf_unregister_hook(&selinux_ipv6_op);
+#endif	/* IPV6 */
+}
+#endif
+
+#else /* CONFIG_SECURITY_NETWORK && CONFIG_NETFILTER */
+
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+#define selinux_nf_ip_exit() 
+#endif
+
 #endif /* CONFIG_SECURITY_NETWORK && CONFIG_NETFILTER */
+
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+int selinux_disable(void)
+{
+	extern void exit_sel_fs(void);
+	static int selinux_disabled = 0;
+
+	if (ss_initialized) {
+		/* Not permitted after initial policy load. */
+		return -EINVAL;
+	}
+
+	if (selinux_disabled) {
+		/* Only do this once. */
+		return -EINVAL;
+	}
+
+	printk(KERN_INFO "SELinux:  Disabled at runtime.\n");
+
+	selinux_disabled = 1;
+	
+	/* Reset security_ops to the secondary module, dummy or capability. */
+	security_ops = secondary_ops;
+
+	/* Unregister netfilter hooks. */
+	selinux_nf_ip_exit();
+
+	/* Unregister selinuxfs. */
+	exit_sel_fs();
+
+	return 0;
+}
+#endif
+
+
diff -X /home/sds/dontdiff -ru linux-2.6.old/security/selinux/Kconfig linux-2.6/security/selinux/Kconfig
--- linux-2.6.old/security/selinux/Kconfig	2004-04-20 08:48:46.000000000 -0400
+++ linux-2.6/security/selinux/Kconfig	2004-04-20 10:14:00.694754564 -0400
@@ -24,6 +24,21 @@
 
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_SELINUX_DISABLE
+	bool "NSA SELinux runtime disable"
+	depends on SECURITY_SELINUX
+	default n
+	help
+	  This option enables writing to a selinuxfs node 'disable', which 
+	  allows SELinux to be disabled at runtime prior to the policy load.
+	  SELinux will then remain disabled until the next boot. 
+	  This option is similar to the selinux=0 boot parameter, but is to
+	  support runtime disabling of SELinux, e.g. from /sbin/init, for
+	  portability across platforms where boot parameters are difficult
+	  to employ.
+
+	  If you are unsure how to answer this question, answer N.
+
 config SECURITY_SELINUX_DEVELOP
 	bool "NSA SELinux Development Support"
 	depends on SECURITY_SELINUX
diff -X /home/sds/dontdiff -ru linux-2.6.old/security/selinux/selinuxfs.c linux-2.6/security/selinux/selinuxfs.c
--- linux-2.6.old/security/selinux/selinuxfs.c	2004-04-20 08:48:46.000000000 -0400
+++ linux-2.6/security/selinux/selinuxfs.c	2004-04-20 10:11:17.647183288 -0400
@@ -46,6 +46,8 @@
 	struct task_security_struct *tsec;
 
 	tsec = tsk->security;
+	if (!tsec)
+		return -EACCES;
 
 	return avc_has_perm(tsec->sid, SECINITSID_SECURITY,
 			    SECCLASS_SECURITY, perms, NULL, NULL);
@@ -61,8 +63,9 @@
 	SEL_RELABEL,	/* compute relabeling decision */
 	SEL_USER,	/* compute reachable user contexts */
 	SEL_POLICYVERS,	/* return policy version for this kernel */
-	SEL_COMMIT_BOOLS,
-	SEL_MLS		/* return if MLS policy is enabled */
+	SEL_COMMIT_BOOLS, /* commit new boolean values */
+	SEL_MLS,	/* return if MLS policy is enabled */
+	SEL_DISABLE	/* disable SELinux until next reboot */
 };
 
 static ssize_t sel_read_enforce(struct file *filp, char *buf,
@@ -151,6 +154,53 @@
 	.write		= sel_write_enforce,
 };
 
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+static ssize_t sel_write_disable(struct file * file, const char * buf,
+				 size_t count, loff_t *ppos)
+
+{
+	char *page;
+	ssize_t length;
+	int new_value;
+	extern int selinux_disable(void);
+
+	if (count < 0 || count >= PAGE_SIZE)
+		return -ENOMEM;
+	if (*ppos != 0) {
+		/* No partial writes. */
+		return -EINVAL;
+	}
+	page = (char*)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+	memset(page, 0, PAGE_SIZE);
+	length = -EFAULT;
+	if (copy_from_user(page, buf, count))
+		goto out;
+
+	length = -EINVAL;
+	if (sscanf(page, "%d", &new_value) != 1)
+		goto out;
+
+	if (new_value) {
+		length = selinux_disable();
+		if (length < 0)
+			goto out;
+	}
+
+	length = count;
+out:
+	free_page((unsigned long) page);
+	return length;
+}
+#else
+#define sel_write_disable NULL
+#endif
+
+static struct file_operations sel_disable_ops = {
+	.write		= sel_write_disable,
+};
+
 static ssize_t sel_read_policyvers(struct file *filp, char *buf,
                                    size_t count, loff_t *ppos)
 {
@@ -1005,6 +1055,7 @@
 		[SEL_POLICYVERS] = {"policyvers", &sel_policyvers_ops, S_IRUGO},
 		[SEL_COMMIT_BOOLS] = {"commit_pending_bools", &sel_commit_bools_ops, S_IWUSR},
 		[SEL_MLS] = {"mls", &sel_mls_ops, S_IRUGO},
+		[SEL_DISABLE] = {"disable", &sel_disable_ops, S_IWUSR},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
@@ -1054,3 +1105,10 @@
 }
 
 __initcall(init_sel_fs);
+
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+void exit_sel_fs(void)
+{
+	unregister_filesystem(&sel_fs_type);
+}
+#endif


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

