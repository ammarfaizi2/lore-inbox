Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbVJCTC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbVJCTC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVJCTC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:02:26 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:12997 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932620AbVJCTCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:02:24 -0400
Date: Mon, 3 Oct 2005 14:02:19 -0500
From: Erik Jacobson <erikj@sgi.com>
To: pagg@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Process Notification / pnotify user: Job
Message-ID: <20051003190219.GA20154@sgi.com>
References: <20051003184644.GA19106@sgi.com> <20051003185155.GB19106@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003185155.GB19106@sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the Linux job implementation.  It provides inescapable job
containers built on top of pnotify.

More information can be found in Documentation/job.txt and 
http://oss.sgi.com/projects/pagg/

Note: In the past, the community suggested using a virtual filesystem
interface to userland and moving much of the logic to user space.  We 
implemented and posted this, but we have found it to suffer greatly in 
performance in certain situations.  For that reason, I'm posting the 
stable non-jobfs version here because it works better.  We're open to
more discussion in the jobfs version if people have ideas on how to
make it faster.  In particular, we ran in to performance problems when
there was rapid process firing and the site administrator did something
that required a job operation for most tasks.  We'd end up spending lots
of time doing inode operations in the virtual filesystem.  This patch 
doesn't suffer from that problem.

Signed-off-by: Erik Jacobson <erikj@sgi.com>

---
 Documentation/job.txt    |  104 ++
 include/linux/job_acct.h |  124 +++
 include/linux/jobctl.h   |  185 ++++
 init/Kconfig             |   29
 kernel/Makefile          |    1
 kernel/fork.c            |    1
 kernel/job.c             | 1871 +++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 2315 insertions(+)


Index: linux/Documentation/job.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/Documentation/job.txt	2005-09-30 13:59:14.034582264 -0500
@@ -0,0 +1,104 @@
+Linux Jobs - A Process Notification (pnotify) Module
+----------------------------------------------------
+
+1. Overview
+
+This document provides two additional sections.  Section 2 provides a
+listing of the manual page that describes the particulars of the Linux
+job implementation.  Section 3 provides some information about using
+the user job library to interface to jobs.
+
+2. Job Man Page
+
+
+JOB(7)		       Linux User's Manual		   JOB(7)
+
+
+NAME
+       job - Linux Jobs kernel module overview
+
+DESCRIPTION
+       A job is a group of related processes all descended from a
+       point of entry process and  identified  by  a  unique  job
+       identifier  (jid).   A  job  can	 contain multiple process
+       groups or sessions, and all processes in one of these sub-
+       groups can only be contained within a single job.
+
+       The  primary  purpose  for  having  jobs is to provide job
+       based resource limits.  The  current  implementation  only
+       provides	 the  job  container  and resource limits will be
+       provided in a later implementation.  When  an  implementa-
+       tion  that provides job limits is available, this descrip-
+       tion will be expanded to provide	 further  explanation  of
+       job based limits.
+
+       Not  every  process  on the system is part of a job.  That
+       is, only processes which are started by a login	initiator
+       like  login, rlogin, rsh and so on, get assigned a job ID.
+       In the Linux environment, jobs are created via a PAM  mod-
+       ule.
+
+       Jobs on Linux are provided using a loadable kernel module.
+       Linux jobs have the following characteristics:
+
+       o   A job is an inescapable container.  A  process  cannot
+	   leave the job nor can a new process be created outside
+	   the job without explicit action,  that  is,	a  system
+	   call with root privilege.
+
+       o   Each	 new  process  inherits	 the jid and limits [when
+	   implemented] from its parent process.
+
+       o   All point of entry processes (job initiators) create a
+	   new	job  and  set  the  job limits [when implemented]
+	   appropriately.
+
+       o   Job initiation on Linux is performed via a PAM session
+	   module.
+
+       o   The job initiator performs authentication and security
+	   checks.
+
+       o   Users can raise and lower their own job limits  within
+	   maximum  values  specified by the system administrator
+	   [when implemented].
+
+       o   Not all processes on a system need be members of a job.
+
+       o   The	process control initialization process (init(1M))
+	   and startup scripts called by init are not part  of	a
+	   job.
+
+
+       Job initiators can be categorized as either interactive or
+       batch processes.	 Limit domain names are	 defined  by  the
+       system  administrator when the user limits database (ULDB)
+       is created.  [The ULDB will be implemented in  conjunction
+       with future job limits work.]
+
+       Note: The existing command jobs(1) applies to shell "jobs"
+       and it is not related to the  Linux  Kernel  Module  jobs.
+       The  at(1),  atd(8),  atq(1), batch(1), atrun(8), atrm(1))
+       man pages refer to  shell  scripts  as  a  job.	 a  shell
+       script.
+
+SEE ALSO
+       job(1), jwait(1), jstat(1), jkill(1)
+
+
+
+
+
+
+
+
+
+3. User Job Library
+
+For developers who wish to make software using Linux Jobs, there exists
+a user job library.  This library contains functions for obtaining information
+about running jobs, creating jobs, detaching, etc.
+
+The library is part of the job package and can be obtained from oss.sgi.com
+using anonymous ftp.  Look in the /projects/pagg/download directory.  See the
+README in the job source package for more information.
Index: linux/init/Kconfig
===================================================================
--- linux.orig/init/Kconfig	2005-09-30 12:14:10.989916853 -0500
+++ linux/init/Kconfig	2005-09-30 13:59:19.749826026 -0500
@@ -170,6 +170,35 @@
      Linux Jobs module and the Linux Array Sessions module.  If you will not
      be using such modules, say N.
 
+config JOB
+	tristate "  Process Notification (pnotify) based jobs"
+	depends on PNOTIFY
+	help
+	  The Job feature implements a type of process aggregate,
+	  or grouping.  A job is the collection of all processes that
+	  are descended from a point-of-entry process.  Examples of such
+	  points-of-entry include telnet, rlogin, and console logins.
+
+	  Batch schedulers such as LSF also make use of Job for containing,
+	  maintaining, and signaling a job as one entity.
+
+	  A job differs from a session and process group since the job
+	  container (or group) is inescapable.  Only root level processes,
+	  or those with the CAP_SYS_RESOURCE capability, can create new jobs
+	  or escape from a job.
+
+	  A job is identified by a unique job identifier (jid).  Currently,
+	  that jid can be used to obtain status information about the job
+	  and the processes it contians.  The jid can also be used to send
+	  signals to all processes contained in the job.  In addition,
+	  other processes can wait for the completion of a job - the event
+	  where the last process contained in the job has exited.
+
+	  If you want to compile support for jobs into the kernel, select
+	  this entry using Y.  If you want the support for jobs provided as
+	  a module, select this entry using M.  If you do not want support
+	  for jobs, select N.
+
 config SYSCTL
 	bool "Sysctl support"
 	---help---
Index: linux/kernel/job.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/kernel/job.c	2005-09-30 13:59:14.049229224 -0500
@@ -0,0 +1,1871 @@
+/*
+ * Linux Job kernel module
+ *
+ *
+ * Copyright (c) 2000-2005 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ *
+ * Contact information:  Silicon Graphics, Inc., 1500 Crittenden Lane,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ *
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan
+ */
+
+/*
+ * Description:	This file implements a type of process grouping called jobs.
+ * 		For further information about jobs, consult the file
+ * 		Documentation/job.txt. Jobs are implemented using Process Notification
+ *			(pnotify).  For more information about pnotify, see
+ *			Documentation/pnotify.txt.
+ */
+
+/*
+ * LOCKING INFO
+ *
+ * There are currently two levels of locking in this module.  So, we
+ * have two classes of locks:
+ *
+ *	(1) job table lock (always, job_table_sem)
+ *	(2) job entry lock (usually, job->sem)
+ *
+ * Most of the locking used is read/write sempahores.  In  rare cases, a
+ * spinlock is also used.  Those cases requiring a spinlock concern when the
+ * tasklist_lock must be locked (such as when looping over all tasks on the
+ * system).
+ *
+ * There is only one job_table_sem.  There is a job->sem for each job
+ * entry in the job_table.  This job module uses Process Notification
+ * (pnotify).  Each task has a special lock that protects its pnotify
+ * information - this is called the pnotify_subscriber_list lock. There are
+ * special macros used to lock/unlock a task's subscriber list lock.  The
+ * subscriber list lock is really a semaphore.
+ *
+ * Purpose:
+ *
+ *	(1) The job_table_sem protects all entries in the table.
+ *	(2) The job->sem protects all data and task attachments for the job.
+ *
+ * Truths we hold to be self-evident:
+ *
+ * Only the holder of a write lock for the job_table_lock may add or
+ * delete a job entry from the job_table. The job_table includes all job
+ * entries in the hash table and chains off the hash table locations.
+ *
+ * Only the holder of a write lock for a job->lock may attach or detach
+ * processes/tasks from the attached list for the job.
+ *
+ * If you hold a read lock of job_table_lock, you can assume that the
+ * job entries in the table will not change.  The link pointers for
+ * the chains of job entries will not change, the job ID (jid) value
+ * will not change, and data changes will be (mostly) atomic.
+ *
+ * If you hold a read lock of a job->lock, you can assume that the
+ * attachments to the job will not change.  The link pointers for the
+ * attachment list will not change and the attachments will not change.
+ *
+ * If you are going to grab nested locks, the nesting order is:
+ *
+ *	down_write/up_write/down_read/up_read(&task->pnotify_subscriber_list_sem)
+ *	job_table_sem
+ *	job->sem
+ *
+ * However, it is not strictly necessary to down the job_table_sem
+ * before downing job->sem.
+ *
+ * Also, the nesting order allows you to lock in this order:
+ *
+ *	down_write/up_write/down_read/up_read(&task->pnotify_subscriber_list_sem)
+ *	job->sem
+ *
+ * without locking job_table_sem between the two.
+ *
+ */
+
+/* standard for kernel modules */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+#include <linux/init.h>
+#include <linux/list.h>
+
+#include <asm/uaccess.h>	/* for get_user & put_user */
+
+#include <linux/sched.h>	/* for current */
+#include <linux/tty.h>		/* for the tty declarations */
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <linux/proc_fs.h>
+
+#include <linux/string.h>
+#include <asm/semaphore.h>
+#include <linux/moduleparam.h>
+
+#include <linux/pnotify.h>		/* to use process notification service */
+#include <linux/jobctl.h>
+#include <linux/job_acct.h>
+
+MODULE_AUTHOR("Silicon Graphics, Inc.");
+MODULE_DESCRIPTION("pnotify based inescapable jobs");
+MODULE_LICENSE("GPL");
+
+#define HASH_SIZE	1024
+
+/* The states for a job */
+#define RUNNING 1	/* Running job */
+#define ZOMBIE  2	/* Dead job */
+
+/* Job creation tags for the job HID (host ID) */
+#define DISABLED	0xffffffff	/* New job creation disabled */
+#define LOCAL		0x0		/* Only creating local sys jobs */
+
+
+#ifdef 	__BIG_ENDIAN
+#define		iptr_hid(ll) 	((u32 *)&(ll))
+#define		iptr_sid(ll) 	(((u32 *)(&(ll) + 1)) - 1)
+#else	/* __LITTLE_ENDIAN */
+#define		iptr_hid(ll) 	(((u32 *)(&(ll) + 1)) - 1)
+#define		iptr_sid(ll) 	((u32 *)&(ll))
+#endif	/* __BIG_ENDIAN */
+
+#define		jid_hash(ll) 	(*(iptr_sid(ll)) % HASH_SIZE)
+
+
+/* Job info entry for member tasks */
+struct job_attach {
+	struct task_struct	*task;	/* task we are attaching to job */
+	struct pnotify_subscriber	*subscriber;	/* our subscriber entry in task */
+	struct job_entry	*job;	/* the job we are attaching task to */
+	struct list_head	entry; 	/* list stuff */
+};
+
+struct job_waitinfo {
+	int		status;		/* For tasks waiting on job exit */
+};
+
+struct job_csainfo {
+	u64		corehimem;	/* Accounting - highpoint, phys mem */
+	u64		virthimem;	/* Accounting - highpoint, virt mem */
+	struct file	*acctfile;	/* The accounting file for job */
+};
+
+/* Job table entry type */
+struct job_entry {
+	u64		    jid;	/* Our job ID */
+	int	    	    refcnt;	/* Number of tasks attached to job */
+	int		    state;	/* State of job - RUNNING,... */
+	struct rw_semaphore sem;	/* lock for the job */
+	uid_t		    user;	/* user that owns the job */
+	time_t		    start;	/* When the job began */
+	struct job_csainfo  csa;	/* CSA accounting info */
+	wait_queue_head_t   zombie;	/* queue last task - during wait */
+	wait_queue_head_t   wait;	/* queue of tasks waiting on job */
+	int		    waitcnt;	/* Number of tasks waiting on job */
+	struct job_waitinfo waitinfo;	/* Status info for waiting tasks */
+	struct list_head    attached;	/* List of attached tasks */
+	struct list_head    entry;	/* List of other jobs - same hash */
+};
+
+
+/* Job container tables */
+static struct list_head  job_table[HASH_SIZE];
+static int	    	 job_table_refcnt = 0;
+static 			 DECLARE_RWSEM(job_table_sem);
+
+
+/* Accounting subscriber list */
+static struct job_acctmod 	*acct_list[JOB_ACCT_COUNT];
+static 				DECLARE_RWSEM(acct_list_sem);
+
+
+/* Host ID for the localhost */
+static u32   jid_hid;
+
+static char 	   *hid = NULL;
+module_param(hid, charp, 0);
+
+/* Function prototypes */
+static int job_dispatch_create(struct job_create *);
+static int job_dispatch_getjid(struct job_getjid *);
+static int job_dispatch_waitjid(struct job_waitjid *);
+static int job_dispatch_killjid(struct job_killjid *);
+static int job_dispatch_getjidcnt(struct job_jidcnt *);
+static int job_dispatch_getjidlst(struct job_jidlst *);
+static int job_dispatch_getpidcnt(struct job_pidcnt *);
+static int job_dispatch_getpidlst(struct job_pidlst *);
+static int job_dispatch_getuser(struct job_user *);
+static int job_dispatch_getprimepid(struct job_primepid *);
+static int job_dispatch_sethid(struct job_sethid *);
+static int job_dispatch_detachjid(struct job_detachjid *);
+static int job_dispatch_detachpid(struct job_detachpid *);
+static int job_dispatch_attachpid(struct job_attachpid *);
+static int job_attach(struct task_struct *, struct pnotify_subscriber *, void *);
+static void job_detach(struct task_struct *, struct pnotify_subscriber *);
+static struct job_entry *job_getjob(u64 jid);
+static int job_dispatcher(unsigned int, unsigned long);
+
+u64 job_getjid(struct task_struct *);
+
+int job_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
+
+/* Job container pnotify service request */
+static struct pnotify_events events = {
+	.module	= THIS_MODULE,
+	.name	= PNOTIFY_JOB,
+	.data	= &job_table,
+	.entry	= LIST_HEAD_INIT(events.entry),
+	.fork		= job_attach,
+	.exit		= job_detach,
+};
+
+/* proc dir entry */
+struct proc_dir_entry *job_proc_entry;
+
+/* file operations for proc file */
+static struct file_operations job_file_ops = {
+	.owner	= THIS_MODULE,
+	.ioctl	= job_ioctl
+};
+
+
+/*
+ * job_getjob - return job_entry given a jid
+ * @jid: The jid of the job entry we wish to retrieve
+ *
+ * Given a jid value, find the entry in the job_table and return a pointer
+ * to the job entry or NULL if not found.
+ *
+ * You should normally down_read the job_table_sem before calling this
+ * function.
+ */
+struct job_entry *
+job_getjob(u64 jid)
+{
+	struct list_head *entry = NULL;
+	struct job_entry *tjob = NULL;
+	struct job_entry *job = NULL;
+
+	list_for_each(entry,  &job_table[ jid_hash(jid) ]) {
+		tjob = list_entry(entry, struct job_entry, entry);
+		if (tjob->jid == jid) {
+			job = tjob;
+			break;
+		}
+	}
+	return job;
+}
+
+
+/*
+ * job_attach - Attach a task to a specified job
+ * @task: Task we want to attach to the job
+ * @new_subscriber: The already allocated subscriber struct for the task
+ * @old_data: (struct job_attach *)old_data)->job is the specified job
+ *
+ * Attach the task to the job specified in the target data (old_data).
+ * This function will add the task to the list of attached tasks for the job.
+ * In addition, a link from the task to the job is created and added to the
+ * task via the data pointer reference.
+ *
+ * The process that owns the target data should be at least read locked (using
+ * down_read(&task->pnotify_subscriber_list_sem)) during this call.  This help
+ * in ensuring that the job cannot be removed since at least one process will
+ * still be referencing the job (the one owning the target_data).
+ *
+ * It is expected that this function will be called from within the
+ * pnotify_fork() function in the kernel, when forking (do_fork) a child
+ * process represented by task.
+ *
+ * If this function is called form some other point, then it is possible that
+ * task and data could be altered while going through this function.  In such
+ * a case, the caller should also lock the pnotify_subscriber_list for the task
+ * task_struct.
+ *
+ * the function returns 0 upon success, and -1 upon failure.
+ */
+static int
+job_attach(struct task_struct *task, struct pnotify_subscriber *new_subscriber,
+		void  *old_data)
+{
+	struct job_entry  *job        = ((struct job_attach *)old_data)->job;
+	struct job_attach *attached   = NULL;
+	int          errcode     = 0;
+
+	/*
+	 * Lock the job for writing. The task owning target_data has its
+	 * pnotify_subscriber_list_sem locked, so we know there is at least one
+	 * active reference to the job - therefore, it cannot have been removed
+	 * before we have gotten this write lock established.
+	 */
+	down_write(&job->sem);
+
+	if (job->state == ZOMBIE) {
+		/* If the job is a zombie (dying), bail out of the attach */
+		printk(KERN_WARNING "Attach task(pid=%d) to job"
+				" failed - job is ZOMBIE\n",
+				task->pid);
+		errcode = -EINPROGRESS;
+		up_write(&job->sem);
+		goto error_return;
+	}
+
+
+	/* Allocate memory that we will need */
+
+	attached = (struct job_attach *)kmalloc(sizeof(struct job_attach),
+			GFP_KERNEL);
+	if (!attached) {
+		/* error */
+		printk(KERN_ERR "Attach task(pid=%d) to job"
+				" failed on memory error in kernel\n",
+				task->pid);
+		errcode = -ENOMEM;
+		up_write(&job->sem);
+		goto error_return;
+	}
+
+
+	attached->task  = task;
+	attached->subscriber  = new_subscriber;
+	attached->job   = job;
+	new_subscriber->data  = (void *)attached;
+	list_add_tail(&attached->entry, &job->attached);
+	++job->refcnt;
+
+	up_write(&job->sem);
+
+	return 0;
+
+error_return:
+	kfree(attached);
+	return errcode;
+}
+
+
+/*
+ * job_detach - Detach a task via the pnotify subscriber reference
+ * @task: The task to be detached
+ * @subscriber: The pnotify subscriber reference
+ *
+ * Detach the task from the job attached to via the pnotify reference.
+ * This function will remove the task from the list of attached tasks for the
+ * job specified via the pnotify data pointer.  In addition, the link to the
+ * job provided via the data pointer will also be removed.
+ *
+ * The pnotify_subscriber_list should be write locked for task before enterin
+ * this function (using down_write(&task->pnotify_subscriber_list_sem)).
+ *
+ * the function returns 0 uopn success, and -1 uopn failure.
+ */
+static void
+job_detach(struct task_struct *task, struct pnotify_subscriber *subscriber)
+{
+	struct job_attach *attached   = ((struct job_attach *)(subscriber->data));
+	struct job_entry  *job        = attached->job;
+	struct job_csa csa;
+	struct job_acctmod *acct;
+
+	/*
+	 * Obtain the lock on the the job_table_sem and the job->sem for
+	 * this job.
+	 */
+	down_write(&job_table_sem);
+	down_write(&job->sem);
+
+	/* - CSA accounting */
+	if (acct_list[JOB_ACCT_CSA]) {
+		acct = acct_list[JOB_ACCT_CSA];
+		if (acct->module) {
+			if (try_module_get(acct->module) == 0) {
+				printk(KERN_WARNING
+					"job_detach: Tried to get non-living acct module\n");
+			}
+		}
+		if (acct->eop) {
+			csa.job_id = job->jid;
+			csa.job_uid = job->user;
+			csa.job_start = job->start;
+			csa.job_corehimem = job->csa.corehimem;
+			csa.job_virthimem = job->csa.virthimem;
+			csa.job_acctfile = job->csa.acctfile;
+			acct->eop(task->exit_code, task, &csa);
+		}
+		if (acct->module)
+			module_put(acct->module);
+	}
+	job->refcnt--;
+	list_del(&attached->entry);
+	subscriber->data = NULL;
+	kfree(attached);
+
+	if (job->refcnt == 0) {
+		int waitcnt;
+
+		list_del(&job->entry);
+		--job_table_refcnt;
+
+		/*
+		 * The job is removed from the job_table.
+		 * We can remove the job_table_sem now since
+		 * nobody can access the job via the table.
+		 */
+		up_write(&job_table_sem);
+
+		job->state = ZOMBIE;
+		job->waitinfo.status = task->exit_code;
+
+		waitcnt = job->waitcnt;
+
+		/*
+		 * Release the job semaphore.  You cannot hold
+		 * this lock if you want the wakeup to work
+		 * properly.
+		 */
+		up_write(&job->sem);
+
+		if (waitcnt > 0) {
+			wake_up_interruptible(&job->wait);
+			wait_event(job->zombie, job->waitcnt == 0);
+		}
+
+		/*
+		 * Job is exiting, all processes waiting for job to exit
+		 * have been notified.  Now we call the accountin
+		 * subscribers.
+		 */
+
+		/* - CSA accounting */
+		if (acct_list[JOB_ACCT_CSA]) {
+			acct = acct_list[JOB_ACCT_CSA];
+			if (acct->module) {
+				if (try_module_get(acct->module) == 0) {
+					printk(KERN_WARNING
+						"job_detach: Tried to get non-living acct module\n");
+				}
+			}
+			if (acct->jobend) {
+				int res = 0;
+
+				csa.job_id = job->jid;
+				csa.job_uid = job->user;
+				csa.job_start = job->start;
+				csa.job_corehimem = job->csa.corehimem;
+				csa.job_virthimem = job->csa.virthimem;
+				csa.job_acctfile = job->csa.acctfile;
+
+				res = acct->jobend(JOB_EVENT_END,
+						&csa);
+				if (res) {
+					printk(KERN_WARNING
+						"job_detach: CSA -"
+						" jobend failed.\n");
+				}
+			}
+			if (acct->module)
+				module_put(acct->module);
+		}
+		/*
+		 * Every process attached or waiting on this job should be
+	         * detached and finished waiting, so now we can free the
+		 * memory for the job.
+		 */
+		kfree(job);
+
+	} else {
+		/* This is case where job->refcnt was greater than 1, so
+		 * we were not going to delete the job after the detach.
+		 * Therefore, only the job->sem is being held - the
+		 * job_table_sem was released earlier.
+		 */
+		up_write(&job->sem);
+		up_write(&job_table_sem);
+	}
+
+	return;
+}
+
+/*
+ * job_dispatch_create - create a new job and attach the calling process to it
+ * @create_args: Pointer of job_create struct which stores the create request
+ *
+ * Returns 0 on success, and negative on failure (negative errno value).
+ */
+static int
+job_dispatch_create(struct job_create *create_args)
+{
+	struct job_create		create;
+	struct job_entry		*job 	      = NULL;
+	struct job_attach		*attached     = NULL;
+	struct pnotify_subscriber		*subscriber	      = NULL;
+	struct pnotify_subscriber		*old_subscriber	= NULL;
+	int			errcode       = 0;
+	struct job_acctmod 	*acct	= NULL;
+	static u32	jid_count = 0;
+	u32	initial_jid_count;
+
+	/*
+	 * if the job ID - host ID segment is set to DISABLED, we will
+	 * not be creating new jobs.  We don't mark it as an error, but
+	 * the jid value returned will be 0.
+	 */
+	if (jid_hid == DISABLED) {
+		errcode = 0;
+		goto error_return;
+	}
+	if (!capable(CAP_SYS_RESOURCE)) {
+		errcode = -EPERM;
+		goto error_return;
+	}
+	if (!create_args) {
+		errcode = -EINVAL;
+		goto error_return;
+	}
+
+	if (copy_from_user(&create, create_args, sizeof(create)))  {
+		errcode = -EFAULT;
+		goto error_return;
+	}
+
+	/*
+	 * Allocate some of the memory we might need, before we start
+	 * locking
+	 */
+
+	attached = (struct job_attach *)kmalloc(sizeof(struct job_attach), GFP_KERNEL);
+	if (!attached) {
+		/* error */
+		errcode = -ENOMEM;
+		goto error_return;
+	}
+
+	job = (struct job_entry *)kmalloc(sizeof(struct job_entry), GFP_KERNEL);
+	if (!job) {
+		/* error */
+		errcode = -ENOMEM;
+		goto error_return;
+	}
+
+	/* We keep the old pnotify subscriber reference around in case we need it
+	 * in an error condition. If, for example, a job_getjob call fails because
+	 * the requested JID is already in use, we don't want to detach that job.
+	 * Having this ability is complicated by the locking.
+	 */
+	down_write(&current->pnotify_subscriber_list_sem);
+	old_subscriber = pnotify_get_subscriber(current, events.name);
+
+	/*
+	 * Lock the job_table and add the pointers for the new job.
+	 * Since the job is new, we won't need to lock the job.
+	 */
+	down_write(&job_table_sem);
+
+	/*
+	 * Determine if create should use specified JID or one that is
+	 * generated.
+	 */
+	if (create.jid != 0) {
+		/* We use the specified JID value */
+		job->jid = create.jid;
+		/* Does the supplied JID conflict with an existing one? */
+		if (job_getjob(job->jid)) {
+			/* JID already in use, bail. error_return tosses/frees job */
+
+			/* error_return doesn't do up_write() */
+			up_write(&job_table_sem);
+			/* we haven't allocated a new pnotify subscriber refernce yet so
+			 * error_return won't unlock this.  We'll unlock here */
+			up_write(&current->pnotify_subscriber_list_sem);
+			errcode = -EBUSY;
+			/* error_return doesn't touch old_subscriber so we don't detach */
+			goto error_return;
+		}
+	} else {
+		/* We generate a new JID value using a new JID */
+		*(iptr_hid(job->jid)) = jid_hid;
+		*(iptr_sid(job->jid)) = jid_count;
+		initial_jid_count = jid_count++;
+		while (((job->jid == 0) || (job_getjob(job->jid))) &&
+			jid_count != initial_jid_count) {
+
+			/* JID was in use or was zero, try a new one */
+			*(iptr_sid(job->jid)) = jid_count++;
+		}
+		/* If all the JIDs are in use, fail */
+		if (jid_count == initial_jid_count) {
+			/* error_return tosses/frees job */
+			/* error_return doesn't do up_write() */
+			up_write(&job_table_sem);
+			/* we haven't allocated a new pagg yet so error_return won't unlock
+			 * this.  We'll unlock here */
+			up_write(&current->pnotify_subscriber_list_sem);
+			errcode = -EBUSY;
+			/* error_return doesn't touch old_pagg so we don't detach */
+			goto error_return;
+		}
+
+	}
+
+	subscriber = pnotify_subscribe(current, &events);
+	if (!subscriber) {
+		/* error */
+		up_write(&job_table_sem); /* unlock since error_return doesn't */
+		up_write(&current->pnotify_subscriber_list_sem);
+		errcode = -ENOMEM;
+		goto error_return;
+	}
+
+	/* Initialize job entry values & lists */
+	job->refcnt = 1;
+	job->user = create.user;
+	job->start = jiffies;
+	job->csa.corehimem = 0;
+	job->csa.virthimem = 0;
+	job->csa.acctfile  = NULL;
+	job->state = RUNNING;
+	init_rwsem(&job->sem);
+	INIT_LIST_HEAD(&job->attached);
+	list_add_tail(&attached->entry, &job->attached);
+	init_waitqueue_head(&job->wait);
+	init_waitqueue_head(&job->zombie);
+	job->waitcnt = 0;
+	job->waitinfo.status = 0;
+
+	/* set link from entry in attached list to task and job entry */
+	attached->task = current;
+	attached->job = job;
+	attached->subscriber = subscriber;
+	subscriber->data = (void *)attached;
+
+	/* Insert new job into front of chain list */
+	list_add_tail(&job->entry, &job_table[ jid_hash(job->jid) ]);;
+	++job_table_refcnt;
+
+	up_write(&job_table_sem);
+	/* At this point, the possible error conditions where we would need the
+	 * old pnotify subscriber are gone.  So we can remove it.  We remove after
+	 * we unlock because the detach function does job table lock of its own.
+	 */
+	if (old_subscriber) {
+		/*
+		 * Detaching subscribers for jobs never has a failure case,
+		 * so we don't need to worry about error codes.
+		 */
+		old_subscriber->events->exit(current, old_subscriber);
+		pnotify_unsubscribe(old_subscriber);
+	}
+	up_write(&current->pnotify_subscriber_list_sem);
+
+	/* Issue callbacks into accounting subscribers */
+
+	/* - CSA subscriber */
+	if (acct_list[JOB_ACCT_CSA]) {
+		acct = acct_list[JOB_ACCT_CSA];
+		if (acct->module) {
+			if (try_module_get(acct->module) == 0) {
+				printk(KERN_WARNING
+					"job_dispatch_create: Tried to get non-living acct module\n");
+			}
+		}
+		if (acct->jobstart) {
+			int res;
+			struct job_csa csa;
+
+			csa.job_id = job->jid;
+			csa.job_uid = job->user;
+			csa.job_start = job->start;
+			csa.job_corehimem = job->csa.corehimem;
+			csa.job_virthimem = job->csa.virthimem;
+			csa.job_acctfile = job->csa.acctfile;
+
+			res = acct->jobstart(JOB_EVENT_START, &csa);
+			if (res < 0) {
+				printk(KERN_WARNING "job_dispatch_create: CSA -"
+						" jobstart failed.\n");
+			}
+		}
+		if (acct->module)
+			module_put(acct->module);
+	}
+
+
+	create.r_jid = job->jid;
+	if (copy_to_user(create_args, &create, sizeof(create))) {
+		return -EFAULT;
+	}
+
+	return 0;
+
+error_return:
+	kfree(attached);
+	kfree(job);
+	create.r_jid = 0;
+	if (copy_to_user(create_args, &create, sizeof(create)))
+		return -EFAULT;
+
+	return errcode;
+}
+
+
+/*
+ * job_dispatch_getjid - retrieves the job ID (jid) for the specified process (pid)
+ * @getjid_args: Pointer of job_getjid struct which stores the get request
+ *
+ * returns 0 on success, negative errno value on exit.
+ */
+static int
+job_dispatch_getjid(struct job_getjid *getjid_args)
+{
+	struct job_getjid	   getjid;
+	int		   errcode = 0;
+	struct task_struct *task;
+
+	if (copy_from_user(&getjid, getjid_args, sizeof(getjid)))
+		return -EFAULT;
+
+	/* lock the tasklist until we grab the specific task */
+	read_lock(&tasklist_lock);
+
+	if (getjid.pid == current->pid) {
+		task = current;
+	} else {
+		task = find_task_by_pid(getjid.pid);
+	}
+	if (task) {
+		get_task_struct(task); /* Ensure the task doesn't vanish on us */
+		read_unlock(&tasklist_lock); /* unlock the task list */
+		getjid.r_jid = job_getjid(task);
+		put_task_struct(task); /* We're done accessing the task */
+		if (getjid.r_jid == 0) {
+			errcode = -ENODATA;
+		}
+	} else {
+		read_unlock(&tasklist_lock);
+		getjid.r_jid = 0;
+		errcode = -ESRCH;
+	}
+
+
+	if (copy_to_user(getjid_args, &getjid, sizeof(getjid)))
+		return -EFAULT;
+	return errcode;
+}
+
+
+/*
+ * job_dispatch_waitjid - allows a process to wait until a job exits
+ * @waitjid_args: Pointer of job_waitjid struct which stores the wait request
+ *
+ * On success returns 0, failure it returns the negative errno value.
+ */
+static int
+job_dispatch_waitjid(struct job_waitjid *waitjid_args)
+{
+	struct job_waitjid 	waitjid;
+	struct job_entry	*job;
+	int		retcode = 0;
+
+	if (copy_from_user(&waitjid, waitjid_args, sizeof(waitjid)))
+		return -EFAULT;
+
+	waitjid.r_jid = waitjid.stat = 0;
+
+	if (waitjid.options != 0) {
+		retcode = -EINVAL;
+		goto general_return;
+	}
+
+	/* Lock the job table so that the current jobs don't change */
+	down_read(&job_table_sem);
+
+	if ((job = job_getjob(waitjid.jid)) == NULL ) {
+		up_read(&job_table_sem);
+		retcode = -ENODATA;
+		goto general_return;
+	}
+
+	/*
+	 * We got the job we need, we can release the job_table_sem
+	 */
+	down_write(&job->sem);
+	up_read(&job_table_sem);
+
+	++job->waitcnt;
+
+	up_write(&job->sem);
+
+	/* We shouldn't hold any locks at this point! The increment of the
+	 * jobs waitcnt will ensure that the job is not removed without
+	 * first notifying this current task */
+	retcode = wait_event_interruptible(job->wait,
+			job->refcnt == 0);
+
+	if (!retcode) {
+		/*
+		 * This data is static at this point, we will
+		 * not need a lock to read it.
+		 */
+		waitjid.stat = job->waitinfo.status;
+		waitjid.r_jid = job->jid;
+	}
+
+	down_write(&job->sem);
+	--job->waitcnt;
+
+	if (job->waitcnt == 0)  {
+		up_write(&job->sem);
+
+		/*
+		 * We shouldn't hold any locks at this point!  Else, the
+		 * last process in the job will not be able to remove the
+		 * job entry.
+		 *
+		 * That process is stuck waiting for this wake_up, so the
+		 * job shouldn't disappear until after this function call.
+		 * The job entry is not longer in the job table, so no
+		 * other process can get to the entry to foul things up.
+		 */
+		wake_up(&job->zombie);
+	} else {
+		up_write(&job->sem);
+	}
+
+general_return:
+	if (copy_to_user(waitjid_args, &waitjid, sizeof(waitjid)))
+		return -EFAULT;
+	return retcode;
+}
+
+
+/*
+ * job_dispatch_killjid - send a signal to all processes in a job
+ * @killjid_args: Pointer of job_killjid struct which stores the kill request
+ *
+ * returns 0 on success, negative of errno on failure.
+ */
+static int
+job_dispatch_killjid(struct job_killjid *killjid_args)
+{
+	struct job_killjid	 killjid;
+	struct job_entry	 *job;
+	struct list_head *attached_entry;
+	struct siginfo   info;
+	int retcode = 0;
+
+	if (copy_from_user(&killjid, killjid_args, sizeof(killjid))) {
+		retcode = -EFAULT;
+		goto cleanup_0locks_return;
+	}
+
+	killjid.r_val = -1;
+
+	/* A signal of zero is really a status check and is handled as such
+	 * by send_sig_info.  So we have < 0 instead of <= 0 here.
+	 */
+	if (killjid.sig < 0) {
+		retcode = -EINVAL;
+		goto cleanup_0locks_return;
+	}
+
+	down_read(&job_table_sem);
+	job = job_getjob(killjid.jid);
+	if (!job) {
+		/* Job not found, copy back data & bail with error */
+		retcode = -ENODATA;
+		goto cleanup_1locks_return;
+	}
+
+	down_read(&job->sem);
+
+	/*
+         * Check capability to signal job.  The signaling user must be
+	 * the owner of the job or have CAP_SYS_RESOURCE capability.
+	 */
+	if (!capable(CAP_SYS_RESOURCE)) {
+		if (current->uid != job->user) {
+			retcode = -EPERM;
+			goto cleanup_2locks_return;
+		}
+	}
+
+	info.si_signo = killjid.sig;
+	info.si_errno = 0;
+	info.si_code = SI_USER;
+	info.si_pid = current->pid;
+	info.si_uid = current->uid;
+
+	/* send_group_sig_info needs the tasklist lock locked */
+	read_lock(&tasklist_lock);
+	list_for_each(attached_entry, &job->attached) {
+		int err;
+		struct job_attach *attached;
+
+		attached = list_entry(attached_entry, struct job_attach, entry);
+		err = send_group_sig_info(killjid.sig, &info,
+				attached->task);
+		if (err != 0) {
+			/*
+			 * XXX - the "prime" process, or initiating process
+			 * for the job may not be owned by the user.  So,
+			 * we would get an error in this case.  However, we
+			 * ignore the error for that specific process - it
+			 * should exit when all the child processes exit. It
+			 * should ignore all signals from the user.
+			 *
+			 */
+			if (attached->entry.prev != &job->attached) {
+				retcode = err;
+			}
+		}
+
+	}
+	read_unlock(&tasklist_lock);
+
+cleanup_2locks_return:
+	up_read(&job->sem);
+cleanup_1locks_return:
+	up_read(&job_table_sem);
+cleanup_0locks_return:
+	killjid.r_val = retcode;
+
+	if (copy_to_user(killjid_args, &killjid, sizeof(killjid)))
+		return -EFAULT;
+	return retcode;
+}
+
+
+/*
+ * job_dispatch_getjidcnt - return the number of jobs currently on the system
+ * @jidcnt_args: Pointer of job_jidcnt struct which stores the get request
+ *
+ * returns 0 on success & it always succeeds.
+ */
+static int
+job_dispatch_getjidcnt(struct job_jidcnt *jidcnt_args)
+{
+	struct job_jidcnt 	jidcnt;
+
+	/* read lock might be overdoing it in this case */
+	down_read(&job_table_sem);
+	jidcnt.r_val = job_table_refcnt;
+	up_read(&job_table_sem);
+
+	if (copy_to_user(jidcnt_args, &jidcnt, sizeof(jidcnt)))
+		return -EFAULT;
+
+	return 0;
+}
+
+
+/*
+ * job_dispatch_getjidlst - get the list of all jids currently on the system
+ * @jidlist_args: Pointer of job_jidlst struct which stores the get request
+ */
+static int
+job_dispatch_getjidlst(struct job_jidlst *jidlst_args)
+{
+	struct job_jidlst	 jidlst;
+	u64	 *jid;
+	struct job_entry	 *job;
+	struct list_head *job_entry;
+	int		 i;
+	int 		 count;
+
+	if (copy_from_user(&jidlst, jidlst_args, sizeof(jidlst)))
+		return -EFAULT;
+
+	if (jidlst.r_val == 0)
+		return 0;
+
+	jid = (u64 *)kmalloc(sizeof(u64)*jidlst.r_val, GFP_KERNEL);
+	if (!jid) {
+		jidlst.r_val = 0;
+		if (copy_to_user(jidlst_args, &jidlst, sizeof(jidlst)))
+			return -EFAULT;
+		return -ENOMEM;
+	}
+
+	count = 0;
+	down_read(&job_table_sem);
+	for (i = 0; i < HASH_SIZE && count < jidlst.r_val; i++) {
+		list_for_each(job_entry, &job_table[i]) {
+			job = list_entry(job_entry, struct job_entry, entry);
+			jid[count++] = job->jid;
+			if (count == jidlst.r_val) {
+				break;
+			}
+		}
+	}
+	up_read(&job_table_sem);
+
+	jidlst.r_val = count;
+
+	for (i = 0; i < count; i++)
+		if (copy_to_user(jidlst.jid+i, &jid[i], sizeof(u64)))
+			return -EFAULT;
+
+	kfree(jid);
+
+	if (copy_to_user(jidlst_args, &jidlst, sizeof(jidlst)))
+		return -EFAULT;
+	return 0;
+}
+
+
+/*
+ * job_dispatch_getpidcnt - get the processe count in the specified job
+ * @pidcnt_args: Pointer of job_pidcnt struct which stores the get request
+ *
+ * returns 0 on success, or negative errno value on failure.
+ */
+static int
+job_dispatch_getpidcnt(struct job_pidcnt *pidcnt_args)
+{
+	struct job_pidcnt pidcnt;
+	struct job_entry  *job;
+	int	     retcode = 0;
+
+	if (copy_from_user(&pidcnt, pidcnt_args, sizeof(pidcnt)))
+		return -EFAULT;
+
+	pidcnt.r_val = 0;
+
+	down_read(&job_table_sem);
+	job = job_getjob(pidcnt.jid);
+	if (!job) {
+		retcode = -ENODATA;
+	} else {
+		/* Read lock might be overdoing it for this case */
+		down_read(&job->sem);
+		pidcnt.r_val = job->refcnt;
+		up_read(&job->sem);
+	}
+	up_read(&job_table_sem);
+
+	if (copy_to_user(pidcnt_args, &pidcnt, sizeof(pidcnt)))
+		return -EFAULT;
+	return retcode;
+}
+
+/*
+ * job_getpidlst - get the process list in the specified job
+ * @pidlst_args: Pointer of job_pidlst struct which stores the get request
+ *
+ * This function returns the the list of processes that are part of the job.
+ * The number of processes provided by this function could be trimmed if
+ * max size specified in r_val is not large enough to hold the entire list.
+ *
+ * returns 0 on success, negative errno value on failure.
+ */
+static int
+job_dispatch_getpidlst(struct job_pidlst *pidlst_args)
+{
+	struct job_pidlst	 pidlst;
+	struct job_entry	 *job;
+	struct job_attach	 *attached;
+	struct list_head *attached_entry;
+	pid_t		 *pid;
+	int		 max;
+	int		 i;
+
+	if (copy_from_user(&pidlst, pidlst_args, sizeof(pidlst)))
+		return -EFAULT;
+
+	if (pidlst.r_val == 0)
+		return 0;
+
+	max = pidlst.r_val;
+	pidlst.r_val = 0;
+	pid = (pid_t *)kmalloc(sizeof(pid_t)*max, GFP_KERNEL);
+	if (!pid) {
+		if (copy_to_user(pidlst_args, &pidlst, sizeof(pidlst)))
+			return -EFAULT;
+		return -ENOMEM;
+	}
+
+	down_read(&job_table_sem);
+
+	job = job_getjob(pidlst.jid);
+	if (!job) {
+		up_read(&job_table_sem);
+		if (copy_to_user(pidlst_args, &pidlst, sizeof(pidlst)))
+			return -EFAULT;
+		return -ENODATA;
+	} else {
+
+		down_read(&job->sem);
+		up_read(&job_table_sem);
+
+		i = 0;
+		list_for_each(attached_entry, &job->attached) {
+			if (i == max) {
+				break;
+			}
+			attached = list_entry(attached_entry, struct job_attach,
+					entry);
+			pid[i++] = attached->task->pid;
+		}
+		pidlst.r_val = i;
+
+		up_read(&job->sem);
+	}
+
+	for (i = 0; i < pidlst.r_val; i++)
+		if (copy_to_user(pidlst.pid+i, &pid[i], sizeof(pid_t)))
+			return -EFAULT;
+	kfree(pid);
+
+	copy_to_user(pidlst_args, &pidlst, sizeof(pidlst));
+	return 0;
+}
+
+
+/*
+ * job_dispatch_getuser - get the uid of the user that owns the job
+ * @user_args: Pointer of job_user struct which stores the get request
+ *
+ * returns 0 on success, returns negative errno on failure.
+ */
+static int
+job_dispatch_getuser(struct job_user *user_args)
+{
+	struct job_entry *job;
+	struct job_user user;
+	int        retcode = 0;
+
+	if (copy_from_user(&user, user_args, sizeof(user)))
+		return(-EFAULT);
+	user.r_user = 0;
+
+	down_read(&job_table_sem);
+
+	job = job_getjob(user.jid);
+	if (!job) {
+		retcode = -ENODATA;
+	} else {
+		down_read(&job->sem);
+		user.r_user = job->user;
+		up_read(&job->sem);
+	}
+
+	up_read(&job_table_sem);
+
+	if (copy_to_user(user_args, &user, sizeof(user)))
+		return -EFAULT;
+	return retcode;
+}
+
+
+/*
+ * job_dispatch_getprimepid - get the oldest process (primepid) in the job
+ * @primepid_args: Pointer of job_primepid struct which stores the get request
+ *
+ * returns 0 on success, negative errno on failure.
+ */
+static int
+job_dispatch_getprimepid(struct job_primepid *primepid_args)
+{
+	struct job_primepid   primepid;
+	struct job_entry      *job = NULL;
+	struct job_attach     *attached = NULL;
+	int              retcode = 0;
+
+	if (copy_from_user(&primepid, primepid_args, sizeof(primepid)))
+		return -EFAULT;
+
+	primepid.r_pid = 0;
+
+	down_read(&job_table_sem);
+
+	job = job_getjob(primepid.jid);
+	if (!job) {
+		up_read(&job_table_sem);
+		/* Job not found, return INVALID VALUE */
+		return -ENODATA;
+	}
+
+	/*
+	 * Job found, now look at first pid entry in the
+	 * attached list.
+	 */
+	down_read(&job->sem);
+	up_read(&job_table_sem);
+	if (list_empty(&job->attached)) {
+		retcode = -ESRCH;
+		primepid.r_pid = 0;
+	}  else {
+		attached = list_entry(job->attached.next, struct job_attach, entry);
+		if (!attached->task) {
+			retcode = -ESRCH;
+		} else {
+			primepid.r_pid = attached->task->pid;
+		}
+	}
+	up_read(&job->sem);
+
+	if (copy_to_user(primepid_args, &primepid, sizeof(primepid)))
+		return -EFAULT;
+	return retcode;
+}
+
+
+/*
+ * job_dispatch_sethid - set the host ID segment for the job IDs (jid)
+ * @sethid_args: Pointer of job_sethid struct which stores the set request
+ *
+ * If hid does not get set, then the jids upper 32 bits will be set to
+ * 0 and the jid cannot be used reliably in a cluster environment.
+ *
+ * returns -errno value on fail, 0 on success
+ */
+static int
+job_dispatch_sethid(struct job_sethid *sethid_args)
+{
+	struct job_sethid	sethid;
+	int			errcode = 0;
+
+	if (copy_from_user(&sethid, sethid_args, sizeof(sethid)))
+		return -EFAULT;
+
+	if (!capable(CAP_SYS_RESOURCE)) {
+		errcode = -EPERM;
+		sethid.r_hid = 0;
+		goto cleanup_return;
+	}
+
+	/*
+	 * Set job_table_sem, so no jobs can be deleted while doing
+	 * this operation.
+	 */
+	down_write(&job_table_sem);
+
+	sethid.r_hid = jid_hid = sethid.hid;
+
+	up_write(&job_table_sem);
+
+cleanup_return:
+	if (copy_to_user(sethid_args, &sethid, sizeof(sethid)))
+		return -EFAULT;
+	return errcode;
+}
+
+
+/*
+ * job_dispatch_detachjid - detach all processes attached to the specified job
+ * @detachjid_args: Pointer of job_detachjid struct
+ *
+ * The job will exit after the detach. The processes are allowed to
+ * continue running. You need CAP_SYS_RESOURCE capability for this to succeed.
+ *
+ * returns -errno value on fail, 0 on success
+ */
+static int
+job_dispatch_detachjid(struct job_detachjid *detachjid_args)
+{
+	struct job_detachjid	   detachjid;
+	struct job_entry	   *job;
+	struct list_head   *entry;
+	int		   count;
+	int		   errcode = 0;
+	struct task_struct *task;
+	struct pnotify_subscriber *subscriber;
+
+	if (copy_from_user(&detachjid, detachjid_args, sizeof(detachjid)))
+		return -EFAULT;
+
+	detachjid.r_val = 0;
+
+	if (!capable(CAP_SYS_RESOURCE)) {
+		errcode = -EPERM;
+		goto cleanup_return;
+	}
+
+	/*
+	 * Set job_table_sem, so no jobs can be deleted while doing
+	 * this operation.
+	 */
+	down_write(&job_table_sem);
+
+	job = job_getjob(detachjid.jid);
+
+	if (job) {
+
+		down_write(&job->sem);
+
+		/* Mark job as ZOMBIE so no new processes can attach to it */
+		job->state = ZOMBIE;
+
+		count = job->refcnt;
+
+		/* Okay, no new processes can attach to the job.  We can
+		 * release the locks on the job_table and job since the only
+		 * way for the job to change now is for tasks to detach and
+		 * the job to be removed.  And this is what we want to happen
+		 */
+		up_write(&job_table_sem);
+		up_write(&job->sem);
+
+
+		/* Walk through list of attached tasks and unset the
+		 * pnotify subscriber entries.
+		 *
+		 * We don't test with list_empty because that actually means NO tasks
+		 * left rather than one task.  If we used !list_empty or list_for_each,
+		 * we could reference memory freed by the pnotify hook detach function
+		 * (job_detach).
+		 *
+		 * We know there is only one task left when job->attached.next and
+		 * job->attached.prev both point to the same place.
+		 */
+		while (job->attached.next != job->attached.prev) {
+			entry = job->attached.next;
+
+			task = (list_entry(entry, struct job_attach, entry))->task;
+			subscriber = (list_entry(entry, struct job_attach, entry))->subscriber;
+
+			down_write(&task->pnotify_subscriber_list_sem);
+			subscriber->events->exit(task, subscriber);
+			pnotify_unsubscribe(subscriber);
+			up_write(&task->pnotify_subscriber_list_sem);
+
+		}
+		/* At this point, there is only one task left */
+
+		entry = job->attached.next;
+
+		task = (list_entry(entry, struct job_attach, entry))->task;
+		subscriber = (list_entry(entry, struct job_attach, entry))->subscriber;
+
+		down_write(&task->pnotify_subscriber_list_sem);
+		subscriber->events->exit(task, subscriber);
+		pnotify_unsubscribe(subscriber);
+		up_write(&task->pnotify_subscriber_list_sem);
+
+		detachjid.r_val = count;
+
+	} else {
+		errcode = -ENODATA;
+		up_write(&job_table_sem);
+	}
+
+cleanup_return:
+	if (copy_to_user(detachjid_args, &detachjid, sizeof(detachjid)))
+		return -EFAULT;
+	return errcode;
+}
+
+
+/*
+ * job_dispatch_detachpid - detach a process from the job it is attached to
+ * @detachpid_args: Pointer of job_detachpid struct.
+ *
+ * That process is allowed to continue running.  You need
+ * CAP_SYS_RESOURCE capability for this to succeed.
+ *
+ * returns -errno value on fail, 0 on success
+ */
+static int
+job_dispatch_detachpid(struct job_detachpid *detachpid_args)
+{
+	struct job_detachpid	   detachpid;
+	struct task_struct *task;
+	struct pnotify_subscriber *subscriber;
+	int		   errcode = 0;
+
+	if (copy_from_user(&detachpid, detachpid_args, sizeof(detachpid)))
+		return -EFAULT;
+
+	detachpid.r_jid = 0;
+
+	if (!capable(CAP_SYS_RESOURCE)) {
+		errcode = -EPERM;
+		goto cleanup_return;
+	}
+
+	/* Lock the task list while we find a specific task */
+	read_lock(&tasklist_lock);
+	task = find_task_by_pid(detachpid.pid);
+	if (!task) {
+		errcode = -ESRCH;
+		/* We need to unlock the tasklist here too or the lock is held forever */
+		read_unlock(&tasklist_lock);
+		goto cleanup_return;
+	}
+
+	/* We have a valid task now */
+	get_task_struct(task); /* Ensure the task doesn't vanish on us */
+	read_unlock(&tasklist_lock); /* Unlock the tasklist */
+	down_write(&task->pnotify_subscriber_list_sem);
+
+	subscriber = pnotify_get_subscriber(task, events.name);
+	if (subscriber) {
+		detachpid.r_jid = ((struct job_attach *)subscriber->data)->job->jid;
+		subscriber->events->exit(task, subscriber);
+		pnotify_unsubscribe(subscriber);
+	} else {
+		errcode = -ENODATA;
+	}
+	put_task_struct(task);  /* Done accessing the task */
+	up_write(&task->pnotify_subscriber_list_sem);
+
+cleanup_return:
+	if (copy_to_user(detachpid_args, &detachpid, sizeof(detachpid)))
+		return -EFAULT;
+	return errcode;
+}
+
+/*
+ * job_dispatch_attachpid - attach a process to the specified job
+ * @attachpid_args: Pointer of job_attachpid struct.
+ *
+ * The attaching process must not belong to any job and the specified job
+ * must exist. You need CAP_SYS_RESOURCE capability for this to succeed.
+ *
+ * returns -errno value on fail, 0 on success
+ */
+static int
+job_dispatch_attachpid(struct job_attachpid *attachpid_args)
+{
+	struct job_attachpid       attachpid;
+	struct task_struct *task;
+	struct pnotify_subscriber *subscriber;
+	struct job_entry *job = NULL;
+	struct job_attach *attached = NULL;
+	int errcode = 0;
+
+	if (copy_from_user(&attachpid, attachpid_args, sizeof(attachpid)))
+		return -EFAULT;
+
+	if (!capable(CAP_SYS_RESOURCE)) {
+		errcode = -EPERM;
+		goto cleanup_return;
+	}
+
+	/* lock the tasklist until we grab the specific task */
+	read_lock(&tasklist_lock);
+	task = find_task_by_pid(attachpid.pid);
+	if (!task) {
+		errcode = -ESRCH;
+		/* We need to unlock the tasklist here too or the lock is held f
+orever */
+		read_unlock(&tasklist_lock);
+		goto cleanup_return;
+	}
+
+	/* We have a valid task now */
+	get_task_struct(task); /* Ensure the task doesn't vanish on us */
+	read_unlock(&tasklist_lock); /* Unlock the tasklist */
+
+	down_write(&task->pnotify_subscriber_list_sem);
+	/* check if it belongs to a job*/
+	subscriber = pnotify_get_subscriber(task, events.name);
+	if (subscriber) {
+		put_task_struct(task);
+		up_write(&task->pnotify_subscriber_list_sem);
+		errcode = -EINVAL;
+		goto cleanup_return;
+	}
+
+	/* Alloc subscriber list entry for it */
+	subscriber = pnotify_subscribe(task, &events);
+	if (subscriber) {
+		down_read(&job_table_sem);
+		/* Check on the requested job */
+		job = job_getjob(attachpid.r_jid);
+		if (!job) {
+			pnotify_unsubscribe(subscriber);
+			errcode = -ENODATA;
+		}
+		else {
+			attached = list_entry(job->attached.next, struct job_attach, entry);
+			if(attached) {
+				if (subscriber->events->fork(task, subscriber, attached) != 0) {
+					pnotify_unsubscribe(subscriber);
+					errcode = -EFAULT;
+				}
+			}
+		}
+		up_read(&job_table_sem);
+	} else
+		errcode = -ENOMEM;
+	put_task_struct(task);  /* Done accessing the task */
+	up_write(&task->pnotify_subscriber_list_sem);
+
+cleanup_return:
+	if (copy_to_user(attachpid_args, &attachpid, sizeof(attachpid)))
+		return -EFAULT;
+	return errcode;
+}
+
+
+/*
+ * job_register_acct - accounting modules register to job module
+ * @am: The registering accounting module's job_acctmod pointer
+ *
+ * returns -errno value on fail, 0 on success.
+ */
+int
+job_register_acct(struct job_acctmod *am)
+{
+	if (!am)
+		return -EINVAL;	/* error, invalid value */
+	if (am->type < 0 || am->type > (JOB_ACCT_COUNT-1))
+		return -EINVAL;	/* error, invalid value */
+
+	down_write(&acct_list_sem);
+	if (acct_list[am->type] != NULL) {
+		up_write(&acct_list_sem);
+		return -EBUSY;	/* error, duplicate entry */
+	}
+
+	acct_list[am->type] = am;
+	up_write(&acct_list_sem);
+	return 0;
+}
+
+
+/*
+ * job_unregister_acct - accounting modules to unregister with the job module
+ * @am: The unregistering accounting module's job_acctmod pointer
+ *
+ * Returns -errno on failure and 0 on success.
+ */
+int
+job_unregister_acct(struct job_acctmod *am)
+{
+	if (!am)
+		return -EINVAL;	/* error, invalid value */
+	if (am->type < 0 || am->type > (JOB_ACCT_COUNT-1))
+		return -EINVAL;	/* error, invalid value */
+
+	down_write(&acct_list_sem);
+
+	if (acct_list[am->type] != am) {
+		up_write(&acct_list_sem);
+		return -EFAULT;	/* error, not matching entry */
+	}
+
+	acct_list[am->type] = NULL;
+	up_write(&acct_list_sem);
+	return 0;
+}
+
+/*
+ * job_getjid - return the Job ID for the given task.
+ * @task: The given task
+ *
+ * If the task is not attached to a job, then 0 is returned.
+ *
+ */
+u64 job_getjid(struct task_struct *task)
+{
+	struct pnotify_subscriber *subscriber = NULL;
+	struct job_entry	   *job = NULL;
+	u64	   jid = 0;
+
+	down_read(&task->pnotify_subscriber_list_sem);
+	subscriber = pnotify_get_subscriber(task, events.name);
+	if (subscriber) {
+		job = ((struct job_attach *)subscriber->data)->job;
+		down_read(&job->sem);
+		jid = job->jid;
+		up_read(&job->sem);
+	}
+	up_read(&task->pnotify_subscriber_list_sem);
+
+	return jid;
+}
+
+
+/*
+ * job_getacct - accounting subscribers get accounting information about a job.
+ * @jid: the job id
+ * @type: the accounting subscriber type
+ * @data: the accounting data that subscriber wants.
+ *
+ * The caller must supply the Job ID (jid) that specifies the job. The
+ * "type" argument indicates the type of accounting data to be returned.
+ * The data will be returned in the memory accessed via the data pointer
+ * argument.  The data pointer is void so that this function interface
+ * can handle different types of accounting data.
+ *
+ */
+int job_getacct(u64 jid, int type, void *data)
+{
+	struct job_entry	*job;
+
+	if (!data)
+		return -EINVAL;
+
+	if (!jid)
+		return -EINVAL;
+
+	down_read(&job_table_sem);
+	job = job_getjob(jid);
+	if (!job) {
+		up_read(&job_table_sem);
+		return -ENODATA;
+	}
+
+	down_read(&job->sem);
+	up_read(&job_table_sem);
+
+	switch (type) {
+		case JOB_ACCT_CSA:
+		{
+			struct job_csa *csa = (struct job_csa *)data;
+
+			csa->job_id = job->jid;
+			csa->job_uid = job->user;
+			csa->job_start = job->start;
+			csa->job_corehimem = job->csa.corehimem;
+			csa->job_virthimem = job->csa.virthimem;
+			csa->job_acctfile = job->csa.acctfile;
+			break;
+		}
+		default:
+			up_read(&job->sem);
+			return -EINVAL;
+			break;
+	}
+	up_read(&job->sem);
+	return 0;
+}
+
+/*
+ * job_setacct - accounting subscribers set accounting info in the job
+ * @jid: the job id
+ * @type: the accounting subscriber type.
+ * @subfield: the accounting information subfield for this set call
+ * @data: the accounting information to be set
+ *
+ * The job is identified by the jid argument.  The type indicates the
+ * type of accounting the information is associated with.  The subfield
+ * is a bitmask that indicates exactly what subfields are to be changed.
+ * The data that is used to set the values is supplied by the data pointer.
+ * The data pointer is a void type so that the interface can be used for
+ * different types of accounting information.
+ */
+int job_setacct(u64 jid, int type, int subfield, void *data)
+{
+	struct job_entry	*job;
+
+	if (!data)
+		return -EINVAL;
+
+	if (!jid)
+		return -EINVAL;
+
+	down_read(&job_table_sem);
+	job = job_getjob(jid);
+	if (!job) {
+		up_read(&job_table_sem);
+		return -ENODATA;
+	}
+
+	down_read(&job->sem);
+	up_read(&job_table_sem);
+
+	switch (type) {
+		case JOB_ACCT_CSA:
+		{
+			struct job_csa *csa = (struct job_csa *)data;
+
+			if (subfield & JOB_CSA_ACCTFILE) {
+				job->csa.acctfile = csa->job_acctfile;
+			}
+			if (subfield & JOB_CSA_COREHIMEM) {
+				job->csa.corehimem = csa->job_corehimem;
+			}
+			if (subfield & JOB_CSA_VIRTHIMEM) {
+				job->csa.virthimem = csa->job_virthimem;
+			}
+			break;
+		}
+		default:
+			up_read(&job->sem);
+			return -EINVAL;
+			break;
+	}
+	up_read(&job->sem);
+	return 0;
+}
+
+
+
+/*
+ * job_dispatcher - handles job ioctl requests
+ * @request: The syscall request type
+ * @data: The syscall request data
+ *
+ * Returns 0 on success and -(ERRNO VALUE) upon failure.
+ */
+int
+job_dispatcher(unsigned int request, unsigned long data)
+{
+	int rc=0;
+
+	switch (request) {
+		case JOB_CREATE:
+			rc = job_dispatch_create((struct job_create *)data);
+			break;
+		case JOB_ATTACH:
+		case JOB_DETACH:
+			/* RESERVED */
+			rc = -EBADRQC;
+			break;
+		case JOB_GETJID:
+			rc = job_dispatch_getjid((struct job_getjid *)data);
+			break;
+		case JOB_WAITJID:
+			rc = job_dispatch_waitjid((struct job_waitjid *)data);
+			break;
+		case JOB_KILLJID:
+			rc = job_dispatch_killjid((struct job_killjid *)data);
+			break;
+		case JOB_GETJIDCNT:
+			rc = job_dispatch_getjidcnt((struct job_jidcnt *)data);
+			break;
+		case JOB_GETJIDLST:
+			rc = job_dispatch_getjidlst((struct job_jidlst *)data);
+			break;
+		case JOB_GETPIDCNT:
+			rc = job_dispatch_getpidcnt((struct job_pidcnt *)data);
+			break;
+		case JOB_GETPIDLST:
+			rc = job_dispatch_getpidlst((struct job_pidlst *)data);
+			break;
+		case JOB_GETUSER:
+			rc = job_dispatch_getuser((struct job_user *)data);
+			break;
+		case JOB_GETPRIMEPID:
+			rc = job_dispatch_getprimepid((struct job_primepid *)data);
+			break;
+		case JOB_SETHID:
+			rc = job_dispatch_sethid((struct job_sethid *)data);
+			break;
+		case JOB_DETACHJID:
+			rc = job_dispatch_detachjid((struct job_detachjid *)data);
+			break;
+		case JOB_DETACHPID:
+			rc = job_dispatch_detachpid((struct job_detachpid *)data);
+			break;
+		case JOB_ATTACHPID:
+			rc = job_dispatch_attachpid((struct job_attachpid *)data);
+			break;
+		case JOB_SETJLIMIT:
+		case JOB_GETJLIMIT:
+		case JOB_GETJUSAGE:
+		case JOB_FREE:
+		default:
+			rc = -EBADRQC;
+			break;
+	}
+
+	return rc;
+}
+
+
+/*
+ * job_ioctl - handles job ioctl call requests
+ *
+ *
+ * Returns 0 on success and -(ERRNO VALUE) upon failure.
+ */
+int
+job_ioctl(struct inode *inode, struct file *file, unsigned int request,
+	  unsigned long data)
+{
+	return job_dispatcher(request, data);
+}
+
+
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
+	/* Get hostID string and fill in jid_template hostID segment */
+	if (hid) {
+		jid_hid = (int)simple_strtoul(hid, &hid, 16);
+	} else {
+		jid_hid = 0;
+	}
+
+	rc = pnotify_register(&events);
+	if (rc < 0) {
+		return -1;
+	}
+
+	/* Setup our /proc entry file */
+	job_proc_entry = create_proc_entry(JOB_PROC_ENTRY,
+		S_IFREG | S_IRUGO, &proc_root);
+
+	if (!job_proc_entry) {
+		pnotify_unregister(&events);
+		return -1;
+	}
+
+	job_proc_entry->proc_fops = &job_file_ops;
+	job_proc_entry->proc_iops = NULL;
+
+
+	return 0;
+}
+module_init(init_job);
+
+/*
+ * cleanup_module
+ *
+ * This function is called to cleanup after a module when it is removed.
+ * All memory allocated for this module will be freed.
+ *
+ * This function does not take any inputs or produce and output.
+ */
+static void __exit
+cleanup_job(void)
+{
+	remove_proc_entry(JOB_PROC_ENTRY, &proc_root);
+	pnotify_unregister(&events);
+	return;
+}
+module_exit(cleanup_job);
+
+EXPORT_SYMBOL(job_register_acct);
+EXPORT_SYMBOL(job_unregister_acct);
+EXPORT_SYMBOL(job_getjid);
+EXPORT_SYMBOL(job_getacct);
+EXPORT_SYMBOL(job_setacct);
Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile	2005-09-30 12:14:10.990893317 -0500
+++ linux/kernel/Makefile	2005-09-30 13:59:19.748849562 -0500
@@ -21,6 +21,7 @@
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_PNOTIFY) += pnotify.o
+obj-$(CONFIG_JOB) += job.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
Index: linux/include/linux/jobctl.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/jobctl.h	2005-09-30 13:59:14.059970327 -0500
@@ -0,0 +1,185 @@
+/*
+ *
+ * Copyright (c) 2000-2005 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ *
+ * Contact information:  Silicon Graphics, Inc., 1500 Crittenden Lane,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ *
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan
+ *
+ *
+ * Description:   This file, include/linux/jobctl.h, contains the data
+ *       definitions used by job to communicate with pnotify via the /proc/job
+ *       ioctl interface.
+ *
+ */
+
+#ifndef _LINUX_JOBCTL_H
+#define _LINUX_JOBCTL_H
+#ifndef __KERNEL__
+#include <stdint.h>
+#include <sys/types.h>
+#include <asm/unistd.h>
+#endif
+
+#define PNOTIFY_NAMELEN  32    /* Max chars in PNOTIFY module name */
+#define PNOTIFY_NAMESTR PNOTIFY_NAMELN+1  /* PNOTIFY mod name string including
+														 * room for end-of-string = '\0' */
+
+/*
+ * =======================
+ * JOB PNOTIFY definitions
+ * =======================
+ */
+#define PNOTIFY_JOB 	"job"	/* PNOTIFY module identifier string */
+
+
+
+/*
+ * ================
+ * KERNEL INTERFACE
+ * ================
+ */
+#define JOB_PROC_ENTRY	"job"	/* /proc entry name */
+#define JOB_IOCTL_NUM	'A'
+
+
+/*
+ *
+ * Define ioctl options available in the job module
+ *
+ */
+
+#define JOB_NOOP	_IOWR(JOB_IOCTL_NUM, 0, void *)	/* No-op options */
+
+#define JOB_CREATE	_IOWR(JOB_IOCTL_NUM, 1, void *)	/* Create a job - uid = 0 only */
+#define JOB_ATTACH	_IOWR(JOB_IOCTL_NUM, 2, void *)	/* RESERVED */
+#define JOB_DETACH	_IOWR(JOB_IOCTL_NUM, 3, void *)	/* RESERVED */
+#define JOB_GETJID	_IOWR(JOB_IOCTL_NUM, 4, void *)	/* Get Job ID for specificed pid */
+#define JOB_WAITJID	_IOWR(JOB_IOCTL_NUM, 5, void *)	/* Wait for job to complete */
+#define JOB_KILLJID	_IOWR(JOB_IOCTL_NUM, 6, void *)	/* Send signal to job */
+#define JOB_GETJIDCNT	_IOWR(JOB_IOCTL_NUM, 9, void *)	/* Get number of JIDs on system */
+#define JOB_GETJIDLST	_IOWR(JOB_IOCTL_NUM, 10, void *)	/* Get list of JIDs on system */
+#define JOB_GETPIDCNT	_IOWR(JOB_IOCTL_NUM, 11, void *)	/* Get number of PIDs in JID */
+#define JOB_GETPIDLST	_IOWR(JOB_IOCTL_NUM, 12, void *)	/* Get list of PIDs in JID */
+#define JOB_SETJLIMIT	_IOWR(JOB_IOCTL_NUM, 13, void *)	/* Future: set job limits info */
+#define JOB_GETJLIMIT	_IOWR(JOB_IOCTL_NUM, 14, void *)	/* Future: get job limits info */
+#define JOB_GETJUSAGE	_IOWR(JOB_IOCTL_NUM, 15, void *)	/* Future: get job res. usage */
+#define JOB_FREE	_IOWR(JOB_IOCTL_NUM, 16, void *)	/* Future: Free job entry */
+#define JOB_GETUSER	_IOWR(JOB_IOCTL_NUM, 17, void *)	/* Get owner for job */
+#define JOB_GETPRIMEPID	_IOWR(JOB_IOCTL_NUM, 18, void *)	/* Get prime pid for job */
+#define JOB_SETHID	_IOWR(JOB_IOCTL_NUM, 19, void *)	/* Set HID for jid values */
+#define JOB_DETACHJID	_IOWR(JOB_IOCTL_NUM, 20, void *)	/* Detach all tasks from job */
+#define JOB_DETACHPID	_IOWR(JOB_IOCTL_NUM, 21, void *)	/* Detach a task from job */
+#define JOB_ATTACHPID	_IOWR(JOB_IOCTL_NUM, 22, void *)	/* Attach a task to a job */
+#define JOB_OPT_MAX	_IOWR(JOB_IOCTL_NUM, 23 , void *)	/* Should always be highest number */
+
+
+/*
+ * Define ioctl request structures for job module
+ */
+
+struct job_create {
+	u64 	r_jid;	/* Return value of JID */
+	u64 	jid;	/* Jid value requested */
+	int 	user;	/* UID of user associated with job */
+	int 	options;/* creation options - unused */
+};
+
+
+struct job_getjid {
+	u64 	r_jid;	/* Returned value of JID */
+	pid_t 	pid;	/* Info requested for PID */
+};
+
+
+struct job_waitjid {
+	u64 	r_jid;	/* Returned value of JID */
+	u64 	jid;	/* Waiting on specified JID */
+	int 	stat;	/* Status information on JID */
+	int 	options;/* Waiting options */
+};
+
+
+struct job_killjid {
+	int	r_val;	/* Return value of kill request */
+	u64	jid;	/* Sending signal to all PIDs in JID */
+	int	sig;	/* Signal to send */
+};
+
+
+struct job_jidcnt {
+	int	r_val;	/* Number of JIDs on system */
+};
+
+
+struct job_jidlst {
+	int	r_val;	/* Number of JIDs in list */
+	u64	*jid;	/* List of JIDs */
+};
+
+
+struct job_pidcnt {
+	int	r_val;	/* Number of PIDs in JID */
+	u64	jid;	/* Getting count of JID */
+};
+
+
+struct job_pidlst {
+	int	r_val;	/* Number of PIDs in list */
+	pid_t	*pid;	/* List of PIDs */
+	u64	jid;
+};
+
+
+struct job_user {
+	int	r_user; /* The UID of the owning user */
+	u64	jid;    /* Get the UID for this job */
+};
+
+struct job_primepid {
+	pid_t	r_pid; /* The prime pid */
+	u64	jid;   /* Get the prime pid for this job */
+};
+
+struct job_sethid {
+	unsigned long	r_hid; /* Value that was set */
+	unsigned long	hid;   /* Value to set to */
+};
+
+
+struct job_detachjid {
+	int	r_val; /* Number of tasks detached from job */
+	u64	jid;   /* Job to detach processes from */
+};
+
+struct job_detachpid {
+	u64	r_jid; /* Jod ID task was attached to */
+	pid_t	pid;   /* Task to detach from job */
+};
+
+struct job_attachpid {
+	u64	r_jid; /* Job ID task is to attach to */
+	pid_t	pid;   /* Task to be attached */
+};
+
+#endif /* _LINUX_JOBCTL_H */
Index: linux/include/linux/job_acct.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/job_acct.h	2005-09-30 13:59:14.063876183 -0500
@@ -0,0 +1,124 @@
+/*
+ * Linux Job kernel definitions & interfaces using pnotify
+ *
+ *
+ * Copyright (c) 2000-2005 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ *
+ * Contact information:  Silicon Graphics, Inc., 1500 Crittenden Lane,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ *
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan
+ */
+
+/*
+ * Description:  This file, include/linux/job.h, contains the data
+ * 		 structure definitions and functions prototypes used
+ * 		 by other kernel bits that communicate with the job
+ * 		 module.  One such example is Comprehensive System
+ * 		 Accounting  (CSA).
+ */
+
+#ifndef _LINUX_JOB_ACCT_H
+#define _LINUX_JOB_ACCT_H
+
+/*
+ * ================
+ * GENERAL USE INFO
+ * ================
+ */
+
+/*
+ * The job start/stop events: These will identify the
+ * the reason the jobstart and jobend callbacks are being
+ * called.
+ */
+enum {
+    JOB_EVENT_IGNORE =  0,
+    JOB_EVENT_START =   1,
+    JOB_EVENT_RESTART = 2,
+    JOB_EVENT_END =  3,
+};
+
+
+/*
+ * =========================================
+ * INTERFACE INFO FOR ACCOUNTING SUBSCRIBERS
+ * =========================================
+ */
+
+/* To register as a job dependent accounting module */
+struct job_acctmod {
+	int     	type;   /* CSA or something else */
+	int     	(*jobstart)(int event, void *data);
+	int     	(*jobend)(int event, void *data);
+	void		(*eop)(int code, void *data1, void *data2);
+	struct module	*module;
+};
+
+
+/*
+ * Subscriber type: Each module that registers as a accounting data
+ * "subscriber" has to have a type.  This type will identify the
+ * the appropriate structs and macros to use when exchanging data.
+ */
+#define JOB_ACCT_CSA	0
+#define JOB_ACCT_COUNT	1 /* Number of entries available */
+
+
+/*
+ * --------------
+ * CSA ACCOUNTING
+ * --------------
+ */
+
+/*
+ * For data exchange betwee job and csa.  The embedded defines
+ * identify the sub-fields
+ */
+struct job_csa {
+#define                 JOB_CSA_JID             001
+	u64		job_id;
+#define                 JOB_CSA_UID             002
+	uid_t		job_uid;
+#define                 JOB_CSA_START           004
+	time_t		job_start;
+#define                 JOB_CSA_COREHIMEM       010
+	u64		job_corehimem;
+#define                 JOB_CSA_VIRTHIMEM       020
+	u64		job_virthimem;
+#define                 JOB_CSA_ACCTFILE        040
+	struct file	*job_acctfile;
+};
+
+
+/*
+ * ===================
+ * FUNCTION PROTOTYPES
+ * ===================
+ */
+int job_register_acct(struct job_acctmod *);
+int job_unregister_acct(struct job_acctmod *);
+u64 job_getjid(struct task_struct *);
+int job_getacct(u64, int, void *);
+int job_setacct(u64, int, int, void *);
+
+#endif /* _LINUX_JOB_ACCT_H */
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2005-09-30 13:59:13.993570776 -0500
+++ linux/kernel/fork.c	2005-09-30 13:59:14.064852647 -0500
@@ -122,6 +122,7 @@
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
 }
+EXPORT_SYMBOL_GPL(__put_task_struct);
 
 void __init fork_init(unsigned long mempages)
 {
