Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWEWB0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWEWB0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 21:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWEWB0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 21:26:38 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:62609 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751236AbWEWB0S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 21:26:18 -0400
From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 3/3] proc: make UTS-related sysctls utsns aware
Date: Tue, 23 May 2006 13:23:01 +1200
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, "Serge E. Hallyn" <serue@us.ibm.com>,
       herbert@13thfloor.at, dev@sw.ru, devel@openvz.org, sam@vilain.net,
       xemul@sw.ru, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <20060523012301.13531.12776.stgit@localhost.localdomain>
In-Reply-To: <20060523012300.13531.96685.stgit@localhost.localdomain>
References: <20060523012300.13531.96685.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Vilain <sam.vilain@catalyst.net.nz>

Add a new function proc_do_utsns_string, that derives the pointer
into the uts_namespace->name structure, currently based on the
filename of the dentry in /proc, and calls _proc_do_string()
---
RFC only - not tested yet.  builds, though.

 kernel/sysctl.c |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 104 insertions(+), 0 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cf053fc..37dc17f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -141,8 +141,13 @@ #endif
 
 static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
 		       ctl_table *, void **);
+#ifndef CONFIG_UTS_NS
 static int proc_do_uts_string(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
+#else
+static int proc_do_utsns_string(ctl_table *table, int write, struct file *filp,
+		  void __user *buffer, size_t *lenp, loff_t *ppos);
+#endif
 
 static ctl_table root_table[];
 static struct ctl_table_header root_table_header =
@@ -238,6 +243,7 @@ #endif
 };
 
 static ctl_table kern_table[] = {
+#ifndef CONFIG_UTS_NS
 	{
 		.ctl_name	= KERN_OSTYPE,
 		.procname	= "ostype",
@@ -283,6 +289,54 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_do_uts_string,
 		.strategy	= &sysctl_string,
 	},
+#else  /* !CONFIG_UTS_NS */
+	{
+		.ctl_name	= KERN_OSTYPE,
+		.procname	= "ostype",
+		.data		= NULL,
+		/* could maybe use __NEW_UTS_LEN here? */
+		.maxlen		= sizeof(current->nsproxy->uts_ns->name.sysname),
+		.mode		= 0444,
+		.proc_handler	= &proc_do_utsns_string,
+		.strategy	= &sysctl_string,
+	},
+	{
+		.ctl_name	= KERN_OSRELEASE,
+		.procname	= "osrelease",
+		.data		= NULL,
+		.maxlen		= sizeof(current->nsproxy->uts_ns->name.release),
+		.mode		= 0444,
+		.proc_handler	= &proc_do_utsns_string,
+		.strategy	= &sysctl_string,
+	},
+	{
+		.ctl_name	= KERN_VERSION,
+		.procname	= "version",
+		.data		= NULL,
+		.maxlen		= sizeof(current->nsproxy->uts_ns->name.version),
+		.mode		= 0444,
+		.proc_handler	= &proc_do_utsns_string,
+		.strategy	= &sysctl_string,
+	},
+	{
+		.ctl_name	= KERN_NODENAME,
+		.procname	= "hostname",
+		.data		= NULL,
+		.maxlen		= sizeof(current->nsproxy->uts_ns->name.nodename),
+		.mode		= 0644,
+		.proc_handler	= &proc_do_utsns_string,
+		.strategy	= &sysctl_string,
+	},
+	{
+		.ctl_name	= KERN_DOMAINNAME,
+		.procname	= "domainname",
+		.data		= NULL,
+		.maxlen		= sizeof(current->nsproxy->uts_ns->name.domainname),
+		.mode		= 0644,
+		.proc_handler	= &proc_do_utsns_string,
+		.strategy	= &sysctl_string,
+	},
+#endif /* !CONFIG_UTS_NS */
 	{
 		.ctl_name	= KERN_PANIC,
 		.procname	= "panic",
@@ -1684,6 +1738,7 @@ int proc_dostring(ctl_table *table, int 
  *	to observe. Should this be in kernel/sys.c ????
  */
  
+#ifndef CONFIG_UTS_NS
 static int proc_do_uts_string(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -1700,6 +1755,55 @@ static int proc_do_uts_string(ctl_table 
 	}
 	return r;
 }
+#else /* !CONFIG_UTS_NS */
+static int proc_do_utsns_string(ctl_table *table, int write, struct file *filp,
+		  void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int r;
+	struct uts_namespace* uts_ns = current->nsproxy->uts_ns;
+	char* which;
+
+	/* map the filename to the pointer.  perhaps it would be better
+	   to put struct offset pointers in table->data ? */
+	switch (filp->f_dentry->d_name.name[3]) {
+		case 'y':  /* ostYpe */
+			which = uts_ns->name.sysname;
+			break;
+		case 't':  /* hosTname */
+			which = uts_ns->name.nodename;
+			break;
+		case 'e':  /* osrElease */
+			which = uts_ns->name.release;
+			break;
+		case 's':  /* verSion */
+			which = uts_ns->name.version;
+			break;
+		case 'x':  /* XXX - unreachable */
+			which = uts_ns->name.machine;
+			break;
+		case 'a':  /* domAinname */
+			which = uts_ns->name.domainname;
+			break;
+		default:
+			printk("procfs: impossible uts part '%s'",
+			       (char*)filp->f_dentry->d_name.name);
+			r = -EINVAL;
+			goto out;
+	}
+
+	if (!write) {
+		down_read(&uts_sem);
+		r=_proc_do_string(which,table->maxlen,0,filp,buffer,lenp, ppos);
+		up_read(&uts_sem);
+	} else {
+		down_write(&uts_sem);
+		r=_proc_do_string(which,table->maxlen,1,filp,buffer,lenp, ppos);
+		up_write(&uts_sem);
+	}
+ out:
+	return r;
+}
+#endif /* !CONFIG_UTS_NS */
 
 static int do_proc_dointvec_conv(int *negp, unsigned long *lvalp,
 				 int *valp,

