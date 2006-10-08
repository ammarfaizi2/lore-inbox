Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWJHTX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWJHTX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWJHTX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:23:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:28804 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751350AbWJHTX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:23:28 -0400
X-Authenticated: #1045983
From: Helge Deller <deller@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [kernel/ subdirectory] constifications
Date: Sun, 8 Oct 2006 21:21:49 +0200
User-Agent: KMail/1.9.5
X-Face: *4/{KL3=jWs!v\UO#3e7~Vb1~CL@oP'~|*/M$!9`tb2[;fY@)WscF2iV7`,a$141g'o,7X
	?Bt1Wb:L7K6z-<?-+-13|S_ixrq58*E`)ZkSe~NSI?u=89G'J<n]7\?[)LCCBZc}~[j(e}
	`-QV{#%&[?^fAke6t8QbP;b'XB,ZU84HeThMrO(@/K.`jxq9P({V(AzezCKMxk\F2^p^+"
	["ppalbA!zy-l)^Qa3*u/Z-1W3,o?2fes2_d\u=1\E9N+~Qo
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610082121.49925.deller@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- completely constify string arrays,  thus move them to the rodata section
- audit.c: mark some initially initialized variables __read_mostly

    Signed-off-by: Helge Deller <deller@gmx.de>


 include/linux/relay.h |    2 +-
 kernel/audit.c        |    8 ++++----
 kernel/configs.c      |    2 +-
 kernel/cpuset.c       |    4 ++--
 kernel/dma.c          |    2 +-
 kernel/futex.c        |    2 +-
 kernel/kallsyms.c     |    2 +-
 kernel/lockdep_proc.c |    4 ++--
 kernel/profile.c      |    2 +-
 kernel/relay.c        |    2 +-
 kernel/resource.c     |    4 ++--
 kernel/sched.c        |    2 +-
 12 files changed, 18 insertions(+), 18 deletions(-)


diff --git a/include/linux/relay.h b/include/linux/relay.h
index 24accb4..07c56e6 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -274,7 +274,7 @@ static inline void subbuf_start_reserve(
 /*
  * exported relay file operations, kernel/relay.c
  */
-extern struct file_operations relay_file_operations;
+extern const struct file_operations relay_file_operations;
 
 #endif /* _LINUX_RELAY_H */
 
diff --git a/kernel/audit.c b/kernel/audit.c
index 98106f6..9648dff 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -62,13 +62,13 @@
 
 /* No auditing will take place until audit_initialized != 0.
  * (Initialization happens after skb_init is called.) */
-static int	audit_initialized;
+static int	audit_initialized __read_mostly;
 
 /* No syscall auditing will take place unless audit_enabled != 0. */
-int		audit_enabled;
+int		audit_enabled __read_mostly;
 
 /* Default state when kernel boots without any parameters. */
-static int	audit_default;
+static int	audit_default __read_mostly;
 
 /* If auditing cannot proceed, audit_failure selects what happens. */
 static int	audit_failure = AUDIT_FAIL_PRINTK;
@@ -1027,7 +1027,7 @@ void audit_log_hex(struct audit_buffer *
 	int i, avail, new_len;
 	unsigned char *ptr;
 	struct sk_buff *skb;
-	static const unsigned char *hex = "0123456789ABCDEF";
+	static const unsigned char hex[] = "0123456789ABCDEF";
 
 	if (!ab)
 		return;
diff --git a/kernel/configs.c b/kernel/configs.c
index f9e3197..8fa1fb2 100644
--- a/kernel/configs.c
+++ b/kernel/configs.c
@@ -75,7 +75,7 @@ ikconfig_read_current(struct file *file,
 	return count;
 }
 
-static struct file_operations ikconfig_file_ops = {
+static const struct file_operations ikconfig_file_ops = {
 	.owner = THIS_MODULE,
 	.read = ikconfig_read_current,
 };
diff --git a/kernel/cpuset.c b/kernel/cpuset.c
index 9d850ae..b94b8de 100644
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -1532,7 +1532,7 @@ static int cpuset_rename(struct inode *o
 	return simple_rename(old_dir, old_dentry, new_dir, new_dentry);
 }
 
-static struct file_operations cpuset_file_operations = {
+static const struct file_operations cpuset_file_operations = {
 	.read = cpuset_file_read,
 	.write = cpuset_file_write,
 	.llseek = generic_file_llseek,
@@ -2610,7 +2610,7 @@ static int cpuset_open(struct inode *ino
 	return single_open(file, proc_cpuset_show, pid);
 }
 
-struct file_operations proc_cpuset_operations = {
+const struct file_operations proc_cpuset_operations = {
 	.open		= cpuset_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
diff --git a/kernel/dma.c b/kernel/dma.c
index 2020644..937b13c 100644
--- a/kernel/dma.c
+++ b/kernel/dma.c
@@ -140,7 +140,7 @@ static int proc_dma_open(struct inode *i
 	return single_open(file, proc_dma_show, NULL);
 }
 
-static struct file_operations proc_dma_operations = {
+static const struct file_operations proc_dma_operations = {
 	.open		= proc_dma_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
diff --git a/kernel/futex.c b/kernel/futex.c
index 4aaf919..0c465c9 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1493,7 +1493,7 @@ static unsigned int futex_poll(struct fi
 	return ret;
 }
 
-static struct file_operations futex_fops = {
+static const struct file_operations futex_fops = {
 	.release	= futex_close,
 	.poll		= futex_poll,
 };
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index eeac3e3..27f9cb5 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -436,7 +436,7 @@ static int kallsyms_release(struct inode
 	return seq_release(inode, file);
 }
 
-static struct file_operations kallsyms_operations = {
+static const struct file_operations kallsyms_operations = {
 	.open = kallsyms_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
diff --git a/kernel/lockdep_proc.c b/kernel/lockdep_proc.c
index f6e72ea..5c8738f 100644
--- a/kernel/lockdep_proc.c
+++ b/kernel/lockdep_proc.c
@@ -135,7 +135,7 @@ static int lockdep_open(struct inode *in
 	return res;
 }
 
-static struct file_operations proc_lockdep_operations = {
+static const struct file_operations proc_lockdep_operations = {
 	.open		= lockdep_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -319,7 +319,7 @@ static int lockdep_stats_open(struct ino
 	return single_open(file, lockdep_stats_show, NULL);
 }
 
-static struct file_operations proc_lockdep_stats_operations = {
+static const struct file_operations proc_lockdep_stats_operations = {
 	.open		= lockdep_stats_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
diff --git a/kernel/profile.c b/kernel/profile.c
index 857300a..0fafd7b 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -480,7 +480,7 @@ static ssize_t write_profile(struct file
 	return count;
 }
 
-static struct file_operations proc_profile_operations = {
+static const struct file_operations proc_profile_operations = {
 	.read		= read_profile,
 	.write		= write_profile,
 };
diff --git a/kernel/relay.c b/kernel/relay.c
index 1d63ecd..a6b1dcc 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1008,7 +1008,7 @@ static ssize_t relay_file_sendfile(struc
 				       actor, target);
 }
 
-struct file_operations relay_file_operations = {
+const struct file_operations relay_file_operations = {
 	.open		= relay_file_open,
 	.poll		= relay_file_poll,
 	.mmap		= relay_file_mmap,
diff --git a/kernel/resource.c b/kernel/resource.c
index 6de60c1..f0c2105 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -115,14 +115,14 @@ static int iomem_open(struct inode *inod
 	return res;
 }
 
-static struct file_operations proc_ioports_operations = {
+static const struct file_operations proc_ioports_operations = {
 	.open		= ioports_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
 
-static struct file_operations proc_iomem_operations = {
+static const struct file_operations proc_iomem_operations = {
 	.open		= iomem_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
diff --git a/kernel/sched.c b/kernel/sched.c
index 53608a5..c9b6edb 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -505,7 +505,7 @@ static int schedstat_open(struct inode *
 	return res;
 }
 
-struct file_operations proc_schedstat_operations = {
+const struct file_operations proc_schedstat_operations = {
 	.open    = schedstat_open,
 	.read    = seq_read,
 	.llseek  = seq_lseek,
