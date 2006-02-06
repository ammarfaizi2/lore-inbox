Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWBFUKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWBFUKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWBFUKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:10:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56448 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932291AbWBFUK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:10:28 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 19/20] pspace: Upcate the pid_max sysctl to work in a
 per pspace fashion
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y80ol1gh.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com>
	<m1psm0l170.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkwol133.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd7cl0yp.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5i0l0ua.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xsol0p9.fsf_-_@ebiederm.dsl.xmission.com>
	<m14q3cl0mk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zml4jlzk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1vevsjlxa.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r76gjlua.fsf_-_@ebiederm.dsl.xmission.com>
	<m1mzh4jlrl.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 13:07:56 -0700
In-Reply-To: <m1mzh4jlrl.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 13:05:34 -0700")
Message-ID: <m1irrsjlnn.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is a pain to export anything in sysctl that is not a global
variable but it is possible.  So for backwards compatibility.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 kernel/sysctl.c |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 75 insertions(+), 4 deletions(-)

dc9bb041416aeaa92add46c7fe7689099768d8fa
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8e1bdc5..89476f6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -44,6 +44,7 @@
 #include <linux/limits.h>
 #include <linux/dcache.h>
 #include <linux/syscalls.h>
+#include <linux/pspace.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -64,7 +65,6 @@ extern int core_uses_pid;
 extern int suid_dumpable;
 extern char core_pattern[];
 extern int cad_pid;
-extern int pid_max;
 extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
@@ -132,6 +132,11 @@ static int parse_table(int __user *, int
 		       ctl_table *, void **);
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
+static int proc_pidmax(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos);
+static int sysctl_pidmax(ctl_table *table, int __user *name, int nlen,
+		void __user *oldval, size_t __user *oldlenp,
+		void __user *newval, size_t newlen, void **context);
 
 static ctl_table root_table[];
 static struct ctl_table_header root_table_header =
@@ -579,11 +584,11 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_PIDMAX,
 		.procname	= "pid_max",
-		.data		= &pid_max,
+		.data		= (void *)1,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec_minmax,
-		.strategy	= sysctl_intvec,
+		.proc_handler	= &proc_pidmax,
+		.strategy	= sysctl_pidmax,
 		.extra1		= &pid_max_min,
 		.extra2		= &pid_max_max,
 	},
@@ -2157,6 +2162,29 @@ int proc_dointvec_ms_jiffies(ctl_table *
 				do_proc_dointvec_ms_jiffies_conv, NULL);
 }
 
+static int do_pidmax_conv(int *negp, unsigned long *lvalp,
+				int *valp, int write, void *data)
+{
+	if (write) {
+		int val = *negp ? -*lvalp : *lvalp;
+		if ((pid_max_min > val) || (pid_max_max < val))
+			return -EINVAL;
+		current->pspace->max = val;
+	} else {
+		*negp = 0;
+		*lvalp = (unsigned long)(current->pspace->max);
+	}
+	return 0;
+}
+
+static int proc_pidmax(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	return do_proc_dointvec(table, write, filp, buffer, lenp, ppos,
+				do_pidmax_conv, NULL);
+}
+
+
 #else /* CONFIG_PROC_FS */
 
 int proc_dostring(ctl_table *table, int write, struct file *filp,
@@ -2222,6 +2250,12 @@ int proc_doulongvec_ms_jiffies_minmax(ct
 }
 
 
+static int proc_pidmax(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	return -ENOSYS;
+}
+
 #endif /* CONFIG_PROC_FS */
 
 
@@ -2367,6 +2401,43 @@ int sysctl_ms_jiffies(ctl_table *table, 
 	return 1;
 }
 
+static int sysctl_pidmax(ctl_table *table, int __user *name, int nlen,
+		void __user *oldval, size_t __user *oldlenp,
+		void __user *newval, size_t newlen, void **context)
+{
+	int result = 0;
+	if (oldval && oldlenp) {
+		size_t len;
+		if (get_user(len, oldlenp))
+			return -EFAULT;
+		if (len < sizeof(int))
+			return -EINVAL;
+		if (put_user(current->pspace->max, oldval))
+			return -EFAULT;
+		if (put_user(sizeof(int), oldlenp))
+			return -EFAULT;
+		result = 1;
+	}
+	if (newval && newlen) {
+		int __user *vec = (int __user *)newval;
+		int value;
+
+		if (newlen != sizeof(int))
+			return -EINVAL;
+
+		if (get_user(value, vec))
+			return -EFAULT;
+		if (value < pid_max_min)
+			return -EINVAL;
+		if (value > pid_max_max)
+			return -EINVAL;
+
+		current->pspace->max = value;
+		result = 1;
+	}
+	return result;
+}
+
 #else /* CONFIG_SYSCTL */
 
 
-- 
1.1.5.g3480

