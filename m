Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262061AbSJQTYC>; Thu, 17 Oct 2002 15:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSJQTYC>; Thu, 17 Oct 2002 15:24:02 -0400
Received: from [198.149.18.6] ([198.149.18.6]:13038 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262061AbSJQTX7>;
	Thu, 17 Oct 2002 15:23:59 -0400
Date: Thu, 17 Oct 2002 22:44:10 -0400
From: Christoph Hellwig <hch@sgi.com>
To: John Hesterberg <jh@sgi.com>
Cc: linux-kernel@vger.kernel.org, Robin Holt <holt@sgi.com>
Subject: Re: [PATCH] 2.5.43 CSA, Job, and PAGG
Message-ID: <20021017224410.A25801@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	John Hesterberg <jh@sgi.com>, linux-kernel@vger.kernel.org,
	Robin Holt <holt@sgi.com>
References: <20021017102146.A17642@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021017102146.A17642@sgi.com>; from jh@sgi.com on Thu, Oct 17, 2002 at 10:21:47AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 10:21:47AM -0500, John Hesterberg wrote:
> 2.5.43 versions of CSA, Job, and PAGG patches are available at:
>     ftp://oss.sgi.com/projects/pagg/download/linux-2.5.43-pagg-job.patch
>     ftp://oss.sgi.com/projects/csa/download/linux-2.5.43-csa.patch
> The CSA and job user-level code is in the same directories.
> 
> CSA (Comprehensive System Accounting) provides methods for
> collecting per-process resource usage data, monitoring disk usage,
> and charging fees to specific login accounts.  CSA provides features
> which are not available with the other Linux accounting packages.
> For more information, see:
>      http://oss.sgi.com/projects/csa/

Comments:


diff -Naur job25p-linux/fs/read_write.c csa2.5p-linux/fs/read_write.c
--- job25p-linux/fs/read_write.c	Mon Oct 14 14:09:27 2002
+++ csa2.5p-linux/fs/read_write.c	Wed Oct 16 17:05:13 2002
@@ -209,8 +209,11 @@
 				ret = file->f_op->read(file, buf, count, pos);
 			else
 				ret = do_sync_read(file, buf, count, pos);
-			if (ret > 0)
+			if (ret > 0) {
 				dnotify_parent(file->f_dentry, DN_ACCESS);
+				current->rchar += ret;
+			}
+			current->syscr++;

You miss e.g. AIO, sendfile/sendmsg/recmsg when updating current->syscr.

+#ifndef _LINUX_CSA_H
+#define _LINUX_CSA_H
+
+#ifndef __KERNEL__
+#include <stdint.h>
+#include <sys/types.h>
+#endif

Umm, userspace shouldn't include kernel headers again..
Also for the types the same comments as for the pagg patch applies.

+
+/*
+ *  accounting flags per-process
+ */
+#define AFORK		0x01	/* fork, but did not exec */
+#define ASU		0x02	/* super-user privileges */
+#define ACKPT   	0x04	/* process has been checkpointed */
+#define ACORE		0x08	/* produced corefile */
+#define AXSIG		0x10	/* killed by a signal */
+#define AMORE		0x20	/* more CSA acct records for this process */
+#define AINC		0x40	/* incremental accounting record */

enum?

+ *  Job Accounting for Linux
+ *
+ *  This header file contains the definitions needed for communication
+ *  between the kernel and the CSA module.
+ */
+
+#ifndef _LINUX_CSA_INTERNAL_H
+#define _LINUX_CSA_INTERNAL_H
+
+#include <linux/config.h>
+
+#if defined (CONFIG_CSA_JOB_ACCT) || defined (CONFIG_CSA_JOB_ACCT_MODULE)

Umm, stubbing stuff out based on _MODULE is a bad, bad idea.  Just make it
a bool instead.

diff -Naur job25p-linux/include/linux/sched.h csa2.5p-linux/include/linux/sched.h
--- job25p-linux/include/linux/sched.h	Wed Oct 16 17:23:22 2002
+++ csa2.5p-linux/include/linux/sched.h	Wed Oct 16 17:15:39 2002
@@ -214,6 +214,8 @@
 	struct kioctx		*ioctx_list;
 
 	struct kioctx		default_kioctx;
+
+	unsigned long hiwater_rss, hiwater_vm;

Make conditional on CONFIG_CSA?

 };
 
 extern int mmlist_nr;
@@ -405,6 +407,11 @@
 
 /* List of pagg (process aggregate) attachments */
 	struct pagg_list_s pagg_list;
+
+/* i/o counters(bytes read/written, blocks read/written, #syscalls, waittime */
+	unsigned long rchar, wchar, rblk, wblk, syscr, syscw, bwtime;
+	unsigned long csa_rss_mem1, csa_vm_mem1;
+	clock_t csa_stimexpd;

Move into a sub-structure and make conditional on CONFIG_CSA?

+int		csa_jstart(int, void *);
+int		csa_jexit(int, void *);
+int		csa_ioctl(struct inode *, struct file *, unsigned int,
+			  unsigned long);
+void		csa_acct_eop(int, struct task_struct *);

All static?

+static int	csa_modify_buf(char *, struct acctcsa *, struct acctmem *,
+			struct acctio *, int, int);
+static int	csa_write(char *, int, int, uint64_t, int, job_csa_t *);
+static void	csa_config_make(ac_eventtype, struct acctcfg *);
+static int	csa_config_write(ac_eventtype,struct file *);
+static void	csa_header(struct achead *, int, int, int);
+static long int sc_CLK(long int);


+#if defined __ia64__
+#define JID_ERR1 "do_csa_acct:  No job table entry for jid 0x%lx.\n"
+#define JID_ERR2 "csa user job accounting write error %d, jid 0x%lx\n"
+#define JID_ERR3 "Can't disable csa user job accounting jid 0x%lx\n"
+#define JID_ERR4 "csa user job accounting disabled, jid 0x%lx\n"
+#else
+#define JID_ERR1 "do_csa_acct:  No job table entry for jid 0x%llx.\n"
+#define JID_ERR2 "csa user job accounting write error %d, jid 0x%llx\n"
+#define JID_ERR3 "Can't disable csa user job accounting jid 0x%llx\n"
+#define JID_ERR4 "csa user job accounting disabled, jid 0x%llx\n"
+#endif

Umm, this would be #if __LP64__.  But please just always cast
to long long instead.

+static struct file	*csa_acctvp = (struct file *)NULL;
+static time_t boottime = 0;

No need to inintialize stuff in .bss.

+static int     csa_flag = 0;           /* accounting start state flag */
+char    csa_path[ACCT_PATH] = "";      /* current accounting file path name */
+char    new_path[ACCT_PATH] = "";       /* new accounting file path name */

Again..

+static job_acctmod_t csa_job_callbacks = {
+	JOB_ACCT_CSA,
+	csa_jstart,
+	csa_jexit,
+	THIS_MODULE
+};

named initializers..

+static int __init
+init_csa(void)
+{
+	int retval = 0;
+
+	/*
+	 * Create the /proc entries used to communicate/control this
+	 * module.
+	 */
+	csa_proc_entry = create_proc_entry(CSA_PROC_ENTRY,
+		S_IFREG | S_IRUGO, &proc_root);
+
+	if (!csa_proc_entry) {
+		return -1;
+	}
+
+	csa_proc_entry->proc_fops = &csa_file_ops;
+	csa_proc_entry->proc_iops = NULL;

Again the interface is rather horrible.

