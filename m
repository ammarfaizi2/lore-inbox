Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261767AbSJQTN0>; Thu, 17 Oct 2002 15:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261867AbSJQTN0>; Thu, 17 Oct 2002 15:13:26 -0400
Received: from [198.149.18.6] ([198.149.18.6]:39916 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261767AbSJQTNS>;
	Thu, 17 Oct 2002 15:13:18 -0400
Date: Thu, 17 Oct 2002 22:33:28 -0400
From: Christoph Hellwig <hch@sgi.com>
To: John Hesterberg <jh@sgi.com>
Cc: linux-kernel@vger.kernel.org, Robin Holt <holt@sgi.com>
Subject: Re: [PATCH] 2.5.43 CSA, Job, and PAGG
Message-ID: <20021017223328.B25777@sgi.com>
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
> 
> Linux Jobs is an inescapable process container that is typically
> created by point of entry processes like login, and inherited by
> children.  PAGG (Process Aggregates) is a generic framework for
> implementing process containers such as Linux Jobs.
> For more information, see:
>     http://oss.sgi.com/projects/pagg/

Comments:


diff -Naur /dev/null job25p/include/linux/job.h
--- /dev/null	Thu Aug 30 20:30:55 2001
+++ job25p/include/linux/job.h	Wed Oct 16 00:09:38 2002
+/*
+ * Description:  This file, include/linux/job.h, contains the data 
+ * 		 structure definitions and functions prototypes used
+ * 		 by other kernel bits that communicate with the job
+ * 		 module.  One such example is Comprehensive System 
+ * 		 Accounting  (CSA).
+ *
+ * History:
+ *
+ * 2000.07.15	Sam Watters <watters@sgi.com>
+ * 		created
+ * 2001.01.30	Sam Watters <watters@sgi.com>
+ * 		Moved file to include/linux/job.h 
+ */

I don't think we need this pre-merging history :)

+/*
+ * Define ioctl request structures for job module 
+ */
+
+typedef struct job_create_s {
+	uint64_t 	r_jid;	/* Return value of JID */
+	uint64_t 	jid;	/* Jid value requested */
+	uid_t	 	user;	/* UID of user associated with job */
+	int	 	options;/* creation options - unused */
+} job_create_t;

(all those comments apply for the other structs either)

Don't use typedefs or _s struct - linus just explained the issue to
Ingo recently.  You shouldn't use uid_t in a kernel/userspace interface.
And use uXX/sXX types in core kernel code.

It should look something like this:

struct job_create_s {
	__u64	r_jid;	/* Return value of JID */
	__u64	jid;	/* Jid value requested */
	__u32 	user;	/* UID of user associated with job */
	__s32 	options;/* creation options - unused */
};

+/* 
+ * The job start/stop events: These will identify the 
+ * the reason the do_jobstart and do_jobend callbacks are being 
+ * called.
+ */
+#define JOB_EVENT_IGNORE	0
+#define JOB_EVENT_START		1
+#define JOB_EVENT_RESTART	2
+#define JOB_EVENT_END		3

enum?

+/* 
+ * Subscriber type: Each module that registers as a accounting data
+ * "subscriber" has to have a type.  This type will identify the 
+ * the appropriate structs and macros to use when exchanging data.
+ */
+#define JOB_ACCT_CSA	0
+#define JOB_ACCT_COUNT	1 /* Number of entries available */	
+
+#if defined(CONFIG_CSA_JOB_ACCT) || defined(CONFIG_CSA_JOB_ACCT_MODULE)

no need for ifdefs to just protect struct definitions.

+#ifdef __KERNEL__
+int job_register_acct(job_acctmod_t *);
+int job_unregister_acct(job_acctmod_t *);
+uint64_t job_getjid(struct task_struct *);
+int job_getacct(uint64_t, int, void *);
+int job_setacct(uint64_t, int, int, void *);
+#endif

Remove the __KERNEL__ - kernel headers shouldn't be included by
userspace anyway.

+ *     do_paggctl:     Function pointer to paggctl() system call handler
+ *                     for the pagg module.  This is optional and may be set
+ *                     to NULL if it is not needed by the pagg module.

doesn't seem to be actually implemented..

+struct pagg_hook_s {
+       /* Name Key  - restricted to 32 characters */
+       char                    *name;
+       /* Function pointers */
+       int                     (*do_attach)(struct task_struct *, 
+                                            struct pagg_s *,
+                                            void *);
+       int                     (*do_detach)(struct task_struct *, 
+                                            struct pagg_s *);
+       int                     (*do_init)(struct task_struct *,
+                                          struct pagg_s *);

Please remove the do_ prefixes.


+       /* Opaque module specific data */
+       void                    *data;
+       /* Module reference */
+       struct module           *module;

Maybe the first entry as in file_operations, etc..?

+	/* Up the write semaphore for the task's pagg_list */
+#define write_unlock_pagg_list(t) 	up_write(&t->pagg_list.sem)
+
+
+
+
+
+#else  /* CONFIG_PAGG */

Maybe a few whitespaces less? :)

diff -Naur 2.5.42/include/linux/sched.h job25p/include/linux/sched.h
--- 2.5.42/include/linux/sched.h	Tue Oct  8 17:52:35 2002
+++ job25p/include/linux/sched.h	Wed Oct 16 15:38:31 2002
@@ -29,6 +29,7 @@
 #include <linux/compiler.h>
 #include <linux/completion.h>
 #include <linux/pid.h>
+#include <linux/pagg.h>
 
 struct exec_domain;
 
@@ -401,6 +402,9 @@
 	void *journal_info;
 	struct dentry *proc_dentry;
 	struct backing_dev_info *backing_dev_info;
+
+/* List of pagg (process aggregate) attachments */
+	struct pagg_list_s pagg_list;
 };

You don't need the header for an unreferences structure pointer.
And sched.h already includes far to many other headers..
 
 
diff -Naur 2.5.42/kernel/exit.c job25p/kernel/exit.c
--- 2.5.42/kernel/exit.c	Wed Oct  2 15:14:53 2002
+++ job25p/kernel/exit.c	Wed Oct 16 15:39:32 2002
@@ -19,6 +19,8 @@
 #include <linux/file.h>
 #include <linux/binfmts.h>
 #include <linux/ptrace.h>
+#include <linux/profile.h>

What do you need this for?

+#include <linux/pagg.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -59,11 +61,12 @@
 {
 	struct dentry *proc_dentry;
 	task_t *leader;
-
-	if (p->state < TASK_ZOMBIE)
-		BUG();
+ 
+	BUG_ON(p->state < TASK_ZOMBIE);
+ 
 	if (p != current)
 		wait_task_inactive(p);
+

Change looks unrelated

@@ -635,6 +638,8 @@
 				current->comm, current->pid,
 				preempt_count());
 
+	profile_exit_task(tsk);
+ 
 fake_volatile:
 	acct_process(code);
 	__exit_mm(tsk);

Change look unrelated.

@@ -653,6 +658,10 @@
 		__MOD_DEC_USE_COUNT(tsk->binfmt->module);
 
 	tsk->exit_code = code;
+
+	/* call pagg modules to detach from any attached process aggregates */
+	detach_pagg_list_chk(tsk);
+

Comments seems rather superflous.

@@ -173,6 +174,9 @@
 
 	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
 	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
+
+	/* Initialize the pagg list in pid 0 before it can clone itself. */
+        INIT_PAGG_LIST(&current->pagg_list);

Use a tab instead of eight spaces please.

+/* Host ID for the localhost */
+static uint32_t   jid_hid = DISABLED;
+
+static char 	   *hid = NULL;	    
+MODULE_PARM(hid, "s");

What's this for?

+
+/* Function prototypes */
+int job_sys_create(job_create_t *);
+int job_sys_getjid(job_getjid_t *);
+int job_sys_waitjid(job_waitjid_t *);
+int job_sys_killjid(job_killjid_t *);
+int job_sys_getjidcnt(job_jidcnt_t *);
+int job_sys_getjidlst(job_jidlst_t *);
+int job_sys_getpidcnt(job_pidcnt_t *);
+int job_sys_getpidlst(job_pidlst_t *);
+int job_sys_getuser(job_user_t *);
+int job_sys_getprimepid(job_primepid_t *);
+int job_sys_sethid(job_sethid_t *);
+int job_sys_detachjid(job_detachjid_t *);
+int job_sys_detachpid(job_detachpid_t *);
+int job_attach(struct task_struct *, struct pagg_s *, void *);
+int job_detach(struct task_struct *, struct pagg_s *);
+job_entry_t *job_getjob(uint64_t jid);

Make static?

+/* Job container kernel pagg entry */
+static struct pagg_hook_s pagg_hook = {
+	PAGG_JOB,
+	job_attach,
+	job_detach,
+	NULL,
+	&job_table,
+	THIS_MODULE,
+	LIST_HEAD_INIT(pagg_hook.entry)
+};

Use named intializers?

+#if defined(CONFIG_CSA_JOB_ACCT) || defined(CONFIG_CSA_JOB_ACCT_MODULE)
+		/* - CSA accounting */
+		if (acct_list[JOB_ACCT_CSA]) {
+			job_acctmod_t *acct = acct_list[JOB_ACCT_CSA];
+			if (try_inc_mod_count(acct->module)) {
+				if (acct->do_jobend) {
+					int res = 0;
+					job_csa_t csa;

Shouldn't this use a proper interface instead of the ugly conditional?

+/* 
+ * init_module
+ *
+ * This function is called when a module is inserted into a kernel. This
+ * function allocates any necessary structures and sets initial values for
+ * module data.
+ *
+ * If the function succeeds, then 0 is returned.  On failure, -1 is returned.
+ */
+static int __init
+init_job(void) 
+{
+	int i,rc;
+
+
+	/* Initialize the job table chains */
+	for (i = 0; i < HASH_SIZE; i++) {
+		INIT_LIST_HEAD(&job_table[i]);
+	}
+
+	/* Initialize the list for accounting subscribers */
+	for (i = 0; i < JOB_ACCT_COUNT; i++) {
+		acct_list[i] = NULL;
+	}

It's in .bss, no need to initialize to zero.

+	/* Setup our /proc entry file */
+	job_proc_entry = create_proc_entry(JOB_PROC_ENTRY,
+		S_IFREG | S_IRUGO, &proc_root);
+
+	if (!job_proc_entry) {
+		unregister_pagg_hook(&pagg_hook);
+		return -1;
+	}
+
+	job_proc_entry->proc_fops = &job_file_ops;
+	job_proc_entry->proc_iops = NULL;

Umm, no, ioctl on procfs is not the proper interfaces.  It looks like
all ioctl subcalls were syscalls initially (on unicos?), so doing the
as actual syscalls would at least be better.  Defining a proper
ascii file interface (i.e. echo start <arg1> <arg2> <etc.. > file)
sounds better.

+#include <linux/config.h>
+
+#if defined(CONFIG_PAGG)

Just compile the file conditional on CONFIG_PAGG instead.

