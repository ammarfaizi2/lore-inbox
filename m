Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVAKDLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVAKDLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVAKC6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:58:11 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:982 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262631AbVAJVUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:20:42 -0500
From: Limin Gu <limin@dbear.engr.sgi.com>
Message-Id: <200501102120.j0ALKX808666@dbear.engr.sgi.com>
Subject: Subject: [PATCH] Linux JOB for 2.6.10
To: linux-kernel@vger.kernel.org
Date: Mon, 10 Jan 2005 13:20:33 -0800 (PST)
Cc: pagg@oss.sgi.com, erikj@sgi.com, limin@dbear.engr.sgi.com (Limin Gu)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.8557.1105392033--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.8557.1105392033--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Attached is a new JOB patch for 2.6.10.  This version of JOB uses a whole
new interface for communicating with user space.

A new small virtual filesystem called jobfs is implemented to replace the
previous binary ioctl call interface.

Linux JOB provides grouping of processes in to inescapable containers.  A job,
identified by a unique job identifier (jid), is the collection of all processes
that are descended from a point-of-entry process. Examples of such
points-of-entry include telnet, rlogin, and console logins. A job differs from
a session and process group since the job container (or group) is inescapable.
Only root level processes, or those with the CAP_SYS_RESOURCE capability, can
create new jobs or escape from a job.

Users of Linux JOB can create new jobs via the JOB library to track a group of
processes as one entity.  For example, a batch scheduler may want to track
a bunch of processes, perhaps otherwise unrelated, as a job and perform
action on that job.

This linux-2.6.10-job.patch should be applied after Process Aggregates (PAGG)
patch, which Erik Jacobson just posted minutes ago.

We also provide the job userland library and command package.
Job library and command rpm package is the middle layer
between job kernel module and job applications, it communicates with kernel
through the jobfs virtual filesystem, and it provides the SAME interface
to JOB applications through /usr/lib/libjob.so as before via job ioctl calls.
That ensures all current job applications should work without any change.

You can get the job library and command source rpm at
ftp://oss.sgi.com/projects/pagg/download/job-1.5.0-0.2.src.rpm

Please visit http://oss.sgi.com/projects/pagg/ for more information about
PAGG and JOB.

Thanks,

Signed-off-by: Limin Gu <limin@sgi.com>

--
Limin Gu - Linux System Software
Silicon Graphics Inc., Mountain View, CA


--%--multipart-mixed-boundary-1.8557.1105392033--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: English text
Content-Disposition: attachment; filename="linux-2.6.10-job.patch"

Index: linux/Documentation/job.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/Documentation/job.txt	2005-01-07 13:19:20.000000000 -0800
@@ -0,0 +1,104 @@
+Linux Jobs - A Process Aggregate (PAGG) Module
+----------------------------------------------
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
+       job(1), jwait(1), jstat(1), jkill(1), jsethid(8), 
+       jdetach(8), jattach(8)
+
+       job_attachpid(3), job_getjid(3), job_getpidlist(3), 
+       job_sethid(3), job_create(3), job_getjidcnt(3), 
+       job_getprimepid(3), job_waitjid(3), job_detachjid(3),
+       job_getjidlist(3), job_getuid(3), job_detachpid(3),
+       job_getpidcnt(3), job_killjid(3)
+   
+
+3. User Job Library
+
+For developers who wish to make software using Linux Jobs, there exists
+a user job library.  This library contains functions for obtaining information
+about running jobs, creating jobs, detaching, attaching, etc.  
+
+The library is part of the job package and can be obtained from oss.sgi.com
+using anonymous ftp.  Look in the /projects/pagg/download directory.  See the
+README in the job source package for more information.
Index: linux/include/linux/job.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/job.h	2005-01-06 15:21:50.000000000 -0800
@@ -0,0 +1,153 @@
+/*
+ * Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
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
+ * 		 by job to communicate with pagg via a virtual filesystem
+ *		 jobfs interface.
+ */
+
+#ifndef _LINUX_JOB_H
+#define _LINUX_JOB_H
+
+#ifndef __KERNEL__
+#include <stdint.h>
+#include <sys/types.h>
+#include <asm/unistd.h>
+#endif
+
+#define	PAGG_NAMELN	32    /* Max chars in PAGG module name */
+#define	PAGG_NAMESTR	PAGG_NAMELN+1  /* PAGG mod name string including room for end-of-string = '\0' */
+
+#define	PAGG_JOB	"job"   /* PAGG module identifier string */
+
+#define	JOB_PROC_ENTRY	"job"   /* /proc entry name */
+
+#define	HASH_SIZE	1024
+
+/* The states for a job */
+#define	RUNNING	1       /* Running job */
+#define	ZOMBIE	2       /* Dead job */
+
+/* Job creation tags for the job HID (host ID) */
+#define	DISABLED	0xffffffff      /* New job creation disabled */
+#define	LOCAL		0x0             /* Only creating local sys jobs */
+
+
+#ifdef	__BIG_ENDIAN
+#define	iptr_sid(ll)	(((u32 *)(&(ll) + 1)) - 1)
+#else   /* __LITTLE_ENDIAN */
+#define	iptr_sid(ll)	((u32 *)&(ll))
+#endif  /* __BIG_ENDIAN */
+
+#define	jid_hash(ll)	(*(iptr_sid(ll)) % HASH_SIZE)
+
+/* random number */
+#define	JOBFS_MAGIC	0x22490467
+
+#define	JOB_WDIR	1
+#define	JOB_RDIR	2
+#define	JOB_HID		3
+#define	JOB_JIDHANDLE	4
+#define	JOB_FILE_READ	5
+
+#define	JOBFS_BUF	32
+
+/* Job info entry for member tasks */
+struct job_attach {
+	struct task_struct	*task;  /* task we are attaching to job */
+	struct pagg		*pagg;  /* our pagg entry in the task */
+	struct job_entry	*job;   /* the job we are attaching task to */
+	struct list_head	entry;  /* list stuff */
+	struct dentry		*pid_dentry;
+	struct dentry		*pids_dentry;
+	char			jid_buf[JOBFS_BUF];
+};
+
+struct job_waitinfo {
+	int	status;         /* For tasks waiting on job exit */
+};
+
+struct job_csainfo {
+	u64		corehimem;      /* Accounting - highpoint, phys mem */
+	u64		virthimem;      /* Accounting - highpoint, virt mem */
+	struct file	*acctfile;      /* The accounting file for job */
+};
+
+/* Job table entry type */
+struct job_entry {
+	u64		    jid;        /* Our job ID */
+	int		    refcnt;     /* Number of tasks attached to job */
+	int		    state;      /* State of job - RUNNING,... */
+	struct rw_semaphore sem;        /* lock for the job */
+	uid_t		    user;       /* user that owns the job */
+	time_t		    start;      /* When the job began */
+	struct job_csainfo  csa;        /* CSA accounting info */
+	wait_queue_head_t   zombie;     /* queue last task - during wait */
+	wait_queue_head_t   wait;       /* queue of tasks waiting on job */
+	int		    waitcnt;    /* Number of tasks waiting on job */
+        struct job_waitinfo waitinfo;   /* Status info for waiting tasks */
+	struct list_head    attached;   /* List of attached tasks */
+	struct list_head    entry;      /* List of other jobs - same hash */
+	struct dentry	    *jid_dentry;
+	struct dentry	    *primepid_dentry;
+	char		    prime_buf[JOBFS_BUF];
+};
+
+
+/* Function prototypes */
+static int job_create(u64 jid, uid_t user, int options);
+static int job_waitjid(u64 jid, int *stat, int options);
+static int job_killjid(u64 jid, int sig);
+static pid_t job_getprimepid(struct job_entry *job);
+static int job_sethid(unsigned long hid);
+static int job_detachjid(u64 jid);
+static int job_detachpid(pid_t pid);
+static int job_attachpid(pid_t pid, u64 jid);
+static int job_attach(struct task_struct *, struct pagg *, void *);
+static void job_detach(struct task_struct *, struct pagg *);
+static struct job_entry *job_getjob(u64 jid);
+
+u64 job_getjid(struct task_struct *);
+
+static struct inode *jobfs_make_inode(struct super_block *sb, int mode);
+static int jobfs_fill_super(struct super_block * sb, void * data, int silent);
+static int jobfs_create_files (struct super_block *sb, struct dentry *root);
+static struct dentry *jobfs_create(struct super_block *sb,struct dentry *parent, const char *name, int mode, u64 *jid, pid_t *pid, char *buf, int type);
+static int jobfs_delete(struct dentry *delete_dentry);
+static int jobfs_mkdir(struct inode *dir, struct dentry *dentry, int mode);
+static int jobfs_open(struct inode *inode, struct file *filp);
+static ssize_t jobfs_read(struct file *filp, char *buf,size_t count, loff_t *offset);
+static ssize_t jobfs_jhandle_write(struct file *filp, const char *buf, size_t count, loff_t *offset);
+static ssize_t jobfs_hid_write(struct file *filp, const char *buf, size_t count, loff_t *offset);
+static int jobfs_chown(struct dentry *dentry, struct iattr *attr);
+static int jobfs_nosetattr(struct dentry *dentry, struct iattr *attr);
+
+
+#endif /* _LINUX_JOB_H */
Index: linux/init/Kconfig
===================================================================
--- linux.orig/init/Kconfig	2005-01-06 12:54:53.000000000 -0800
+++ linux/init/Kconfig	2005-01-06 12:56:58.000000000 -0800
@@ -146,6 +146,31 @@
      Linux Jobs module and the Linux Array Sessions module.  If you will not 
      be using such modules, say N.
 
+config PAGG_JOB
+	tristate "  Process aggregate based jobs"
+	depends on PAGG
+	help
+	  The Job feature implements a type of process aggregate,
+	  or grouping.  A job is the collection of all processes that
+	  are descended from a point-of-entry process.  Examples of such
+	  points-of-entry include telnet, rlogin, and console logins.
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
+++ linux/kernel/job.c	2005-01-07 14:23:35.000000000 -0800
@@ -0,0 +1,1733 @@
+/*
+ * Linux Job kernel module
+ *
+ *
+ * Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
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
+ * 		Documentation/job.txt. Jobs are implemented as a type of PAGG
+ * 		(process aggregate).  For further information about PAGGs,
+ * 		consult the file Documentation/pagg.txt.
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
+ * entry in the job_table.  This job module is a PAGG module (Process
+ * Aggregation).  Each task has a special lock that protects its PAGG
+ * information - this is called the pagg list lock. There are special macros
+ * used to lock/unlock a task's pagg list lock.  The pagg list lock is really
+ * a semaphore.
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
+ *	down_write/up_write/down_read/up_read(&task->pagg_sem)
+ *	job_table_sem
+ *	job->sem
+ *
+ * However, it is not strictly necessary to down the job_table_sem
+ * before downing job->sem. 
+ *
+ * Also, the nesting order allows you to lock in this order:
+ *
+ *	down_write/up_write/down_read/up_read(&task->pagg_sem)
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
+#include <linux/sched.h>	/* for current */
+#include <linux/tty.h>		/* for the tty declarations */
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <linux/string.h>
+#include <asm/semaphore.h>
+#include <linux/moduleparam.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/dnotify.h>
+
+#include <linux/pagg.h>		/* to use pagg hooks */
+#include <linux/job.h>
+#include <linux/job_acct.h>
+
+MODULE_AUTHOR("Silicon Graphics, Inc.");
+MODULE_DESCRIPTION("PAGG-based inescapable jobs");
+MODULE_LICENSE("GPL");
+
+/* Job container tables */
+static struct list_head  job_table[HASH_SIZE];
+static int	    	 job_table_refcnt = 0;
+static 			 DECLARE_RWSEM(job_table_sem);
+
+/* Accounting subscriber list */
+static struct job_acctmod 	*acct_list[JOB_ACCT_COUNT];
+static 				DECLARE_RWSEM(acct_list_sem);
+
+/* Host ID for the localhost */
+static u32   jid_hid;
+static char hidname[16];
+static char 	   *hid = NULL;
+module_param(hid, charp, 0);
+
+struct dentry *jiddirs;
+struct dentry *piddirs;
+struct super_block *jobsb;
+
+/* Job container kernel pagg entry */
+static struct pagg_hook pagg_hook = {
+	.module	= THIS_MODULE,
+	.name	= PAGG_JOB,
+	.data	= &job_table,
+	.entry	= LIST_HEAD_INIT(pagg_hook.entry),
+	.attach	= job_attach,
+	.detach	= job_detach,
+};
+
+/* 
+ * job_getjob - Return job_entry given a jid
+ * @jid: The jid of the job entry we wish to retrieve
+ *
+ * Given a jid value, find the entry in the job_table and return a pointer
+ * to the job entry or NULL if not found.
+ *
+ * The caller should normally down_read() the job_table_sem before calling this 
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
+/*
+ * job_attach - Attach a task to a specified job
+ * @task: The task we want to attach to the job 
+ * @new_pagg: The already allocated pagg struct for the task 
+ * @old_data: (struct job_attach *)old_data)->job is the specified job
+ *
+ * Attach the task to the job specified in the target data (old_data).
+ * This function will add the task to the list of attached tasks for the job.
+ * In addition, a link from the task to the job is created and added to the 
+ * task via the data pointer reference.  
+ *
+ * The process that owns the target data should be at least read locked (using
+ * down_read(&task->pagg_sem)) during this call.  This help in ensuring
+ * that the job cannot be removed since at least one process will 
+ * still be referencing the job (the one owning the target_data).
+ *
+ * It is expected that this function will be called from within the
+ * pagg_attach() function in the kernel, when forking (do_fork) a child
+ * process represented by task.
+ *
+ * If this function is called form some other point, then it is possible that
+ * task and data could be altered while going through this function.  In such
+ * a case, the caller should also lock the pagg list for the task
+ * task_struct.
+ *
+ * the function returns 0 on success, and -1 on failure.
+ */
+static int
+job_attach(struct task_struct *task, struct pagg *new_pagg, 
+		void  *old_data)
+{
+	struct job_entry  *job        = ((struct job_attach *)old_data)->job;
+	struct job_attach *attached   = NULL;
+	int          errcode     = 0;
+	char pid_buf[JOBFS_BUF];
+
+	/* 
+	 * Lock the job for writing. The task owning target_data has its
+	 * pagg_sem locked, so we know there is at least one active reference
+	 * to the job - therefore, it cannot have been removed before we
+	 * have gotten this write lock established.
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
+	attached->task  = task;
+	attached->pagg  = new_pagg;
+	attached->job   = job;
+	new_pagg->data  = (void *)attached;
+	list_add_tail(&attached->entry, &job->attached);
+	++job->refcnt;
+
+	/* create files in jobfs for newly attatched job.*/
+	sprintf(pid_buf, "%d", attached->task->pid);
+	sprintf(attached->jid_buf, "0x%llx", attached->job->jid);
+	/* jobfs_create() could fail, oh well... */
+	if(job->jid_dentry)
+		attached->pid_dentry = jobfs_create(jobsb, job->jid_dentry, 
+			pid_buf, S_IFREG|0444, 0, 0, attached->jid_buf, JOB_FILE_READ);
+	attached->pids_dentry = jobfs_create(jobsb, piddirs, pid_buf, 
+		S_IFREG|0444, 0, 0, attached->jid_buf, JOB_FILE_READ);
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
+ * job_detach - Detach a task via the pagg reference
+ * @task: The task to be detached
+ * @pagg: The pagg reference 
+ *
+ * Detach the task from the job attached to via the pagg reference.
+ * This function will remove the task from the list of attached tasks for the
+ * job specified via the pagg pointer.  In addition, the link to the job
+ * provided via the data pointer will also be removed.
+ *
+ * The pagg_list should be write locked for task before entering
+ * this function (using down_write(&task->pagg_sem)).
+ *
+ * the function returns 0 on success, and -1 on failure.
+ */
+static void
+job_detach(struct task_struct *task, struct pagg *pagg)
+{
+	struct job_attach *attached   = ((struct job_attach *)(pagg->data));
+	struct job_entry  *job        = attached->job;
+	struct job_csa csa;
+	pid_t primepid;
+	int i;
+
+	/*
+	 * Obtain the lock on the the job_table_sem and the job->sem for 
+	 * this job.
+	 */
+	down_write(&job_table_sem);
+	down_write(&job->sem);  
+	
+	primepid = job_getprimepid(job);
+
+	/* - CSA accounting */
+	if (acct_list[JOB_ACCT_CSA]) {
+		struct job_acctmod *acct = acct_list[JOB_ACCT_CSA];
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
+
+	job->refcnt--;
+	list_del(&attached->entry);
+	pagg->data = NULL;
+	jobfs_delete(attached->pid_dentry);
+	jobfs_delete(attached->pids_dentry);
+
+	/* If the detached pid is primepid, update primepid in jobfs */
+	if (primepid == task->pid) {
+		jobfs_delete(job->primepid_dentry);
+		primepid = job_getprimepid(job);
+		sprintf(job->prime_buf, "%d", primepid);
+		if (job->jid_dentry)
+			job->primepid_dentry = jobfs_create(jobsb, 
+				job->jid_dentry, "primepid", S_IFREG|0444, 
+				0, 0, job->prime_buf, JOB_FILE_READ);
+	}
+	kfree(attached);
+
+	if (job->refcnt == 0) {
+		int waitcnt;
+
+		list_del(&job->entry);
+		--job_table_refcnt;
+		jobfs_delete(job->jid_dentry);
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
+		 * have been notified.  Now we call the accounting
+		 * subscribers.
+		 */
+
+		for (i=0; i<JOB_ACCT_COUNT; i++) {
+			if (acct_list[i]) {
+				struct job_acctmod *acct = acct_list[i];
+				if (acct->module) {
+					if (try_module_get(acct->module) == 0) {
+						printk(KERN_WARNING
+							"job_detach: Tried to get non-living acct module\n");
+					}
+				}
+				if (acct->jobend) {
+					int res = 0;
+					struct job_csa csa;
+
+					csa.job_id = job->jid;
+					csa.job_uid = job->user;
+					csa.job_start = job->start;
+					csa.job_corehimem = job->csa.corehimem;
+					csa.job_virthimem = job->csa.virthimem;
+					csa.job_acctfile = job->csa.acctfile;
+
+					res = acct->jobend(JOB_EVENT_END,
+							&csa);
+					if (res) {
+						printk(KERN_WARNING
+							"job_detach: CSA -"
+							" jobend failed.\n");
+					}
+				}
+				if (acct->module) 
+					module_put(acct->module);
+			} 
+		}
+
+
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
+	return;
+}
+
+/* 
+ * job_create - create a new job and attache the calling process to it.
+ * @jid: The new job id
+ * @user: The job owner
+ * @options: Not used for now
+ *
+ * return 0 on job is DISABLE, -errno on failure, 1 on success
+ */
+static int
+job_create(u64 jid, uid_t user, int options)
+{
+	struct job_entry                *job          = NULL;
+	struct job_attach		*attached     = NULL;
+	struct pagg		*pagg	      = NULL;
+	struct pagg		*old_pagg	= NULL;
+	int			errcode       = 0;
+	int i;
+	struct dentry *handle_dentry = NULL;
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
+
+	if (!capable(CAP_SYS_RESOURCE)) {
+		errcode = -EPERM;
+		goto error_return;
+	}
+
+	if(jid == 0) {
+		errcode = -EINVAL;
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
+	/* We keep the old pagg around in case we need it in an error condition.
+	 * If, for example, a job_getjob call fails because the requested JID is
+	 * already in use, we don't want to detach that job.  Having this ability 
+	 * is complicated by the locking.
+	 */
+	down_write(&current->pagg_sem); /* write lock pagg list */
+	old_pagg = pagg_get(current, pagg_hook.name);
+
+	/* 
+	 * Lock the job_table and add the pointers for the new job.
+	 * Since the job is new, we won't need to lock the job.
+	 */
+	down_write(&job_table_sem);
+	
+	if (job_getjob(jid)) { 
+		/* JID already in use, bail */
+		/* error_return doesn't do JOB_WUNLOCK */
+		up_write(&job_table_sem);
+		/* we haven't allocated a new pagg yet so error_return won't unlock 
+		 * this.  We'll unlock here */
+		up_write(&current->pagg_sem);
+		errcode = -EBUSY;
+		/* error_return doesn't touch old_pagg so we don't detach */
+		goto error_return;
+	} else {
+		/* Using specifiec JID */
+		job->jid = jid;
+	}
+
+	pagg = pagg_alloc(current, &pagg_hook);
+	if (!pagg) {
+		/* error */
+		up_write(&current->pagg_sem); /* write unlock pagg list */
+		errcode = -ENOMEM;
+		goto error_return;
+	}
+
+	/* Initialize job entry values & lists */
+	job->refcnt = 1;
+	job->user = user;
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
+	attached->pagg = pagg;
+	pagg->data = (void *)attached;
+
+	/* create files in jobfs for the new job */
+	sprintf(attached->jid_buf, "0x%llx", job->jid);
+	sprintf(job->prime_buf, "%d", attached->task->pid);
+
+	/* Any jobfs_create could fail, but just like list_add_tail, etc.
+	 * could fail too, we don't want to job_create fail at this point. 
+	 */
+	job->jid_dentry = jobfs_create(jobsb, jiddirs, attached->jid_buf, 
+		S_IFDIR|0555, 0, 0, attached->jid_buf, JOB_RDIR );
+	if (!job->jid_dentry) 
+		printk(KERN_WARNING "jobfs: jid dentry for %s failed", 
+			attached->jid_buf);
+	else {
+		handle_dentry = jobfs_create(jobsb, job->jid_dentry, "handle", 
+			S_IFREG|0222, &job->jid, 0, attached->jid_buf, 
+			JOB_JIDHANDLE);
+		attached->pid_dentry = jobfs_create(jobsb, job->jid_dentry, 
+			job->prime_buf, S_IFREG|0444, 0, 0, attached->jid_buf, 
+			JOB_FILE_READ);
+		job->primepid_dentry = jobfs_create(jobsb, job->jid_dentry, 
+			"primepid", S_IFREG|0444, 0, 0, job->prime_buf, 
+			JOB_FILE_READ);
+	}
+	attached->pids_dentry = jobfs_create(jobsb, piddirs, job->prime_buf,
+		S_IFREG|0444, 0, 0, attached->jid_buf, JOB_FILE_READ);
+
+	if (handle_dentry == NULL || attached->pid_dentry == NULL ||
+		job->primepid_dentry == NULL ||
+		attached->pids_dentry == NULL) 
+		printk(KERN_WARNING "jid sub dentrys for %s failed", 
+			attached->jid_buf);
+
+	
+	/* Insert new job into front of chain list */
+	list_add_tail(&job->entry, &job_table[ jid_hash(job->jid) ]);;
+	++job_table_refcnt;
+
+	up_write(&job_table_sem); 
+	/* At this point, the possible error conditions where we would need the
+	 * old pagg are gone.  So we can remove it.  We remove after we unlock
+	 * because the pagg hook detach function does job table lock of its own.
+	 */
+	if (old_pagg) {
+		/* 
+		 * Detaching paggs for jobs never has a failure case,
+		 * so we don't need to worry about error codes.
+		 */
+		old_pagg->hook->detach(current, old_pagg);
+		pagg_free(old_pagg);
+	} 
+	up_write(&current->pagg_sem); /* write unlock pagg list */
+
+	/* Issue callbacks into accounting subscribers */
+
+	for (i=0; i<JOB_ACCT_COUNT; i++) {
+		if (acct_list[i]) {
+			struct job_acctmod *acct = acct_list[i];
+			if (acct->module) {
+				if (try_module_get(acct->module) == 0) {
+					printk(KERN_WARNING
+						"job_create: Tried to get non-living acct module\n");
+				}
+			}
+			if (acct->jobstart) {
+				int res;
+				struct job_csa csa;
+
+				csa.job_id = job->jid;
+				csa.job_uid = job->user;
+				csa.job_start = job->start;
+				csa.job_corehimem = job->csa.corehimem;
+				csa.job_virthimem = job->csa.virthimem;
+				csa.job_acctfile = job->csa.acctfile;
+
+				res = acct->jobstart(JOB_EVENT_START, &csa);
+				if (res < 0) {
+					printk(KERN_WARNING "job_create: CSA -"
+						" jobstart failed.\n");
+				}
+			}	
+			if (acct->module) 
+				module_put(acct->module);
+		}
+	}
+
+	return 1;
+
+error_return:
+	kfree(attached);
+	kfree(job);
+	if (pagg) {
+		pagg->hook->detach(current, pagg);  /* detach the pagg */
+		pagg_free(pagg);
+		/* This was locked at pagg_alloc call */
+		up_write(&current->pagg_sem); /* write unlock pagg list */
+	}
+	return errcode;
+}
+
+
+/* 
+ * job_waitjid - allows a process to wait until a job exits 
+ * @jid: The job id to be waited
+ * @stat: Status information of the last process to exit the job
+ * @options: 0
+ *
+ * On success returns 0, failure it returns the negative errno value.
+ */
+static int
+job_waitjid(u64 jid, int *stat, int options)
+{
+	struct job_entry	*job;
+	int		retcode = 0;
+
+	*stat = 0;
+
+	if (options != 0) {
+		retcode = -EINVAL;
+		goto general_return;
+	}
+
+	/* Lock the job table so that the current jobs don't change */
+	down_read(&job_table_sem);
+
+	if ((job = job_getjob(jid)) == NULL ) {
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
+		*stat = job->waitinfo.status;
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
+	return retcode;
+}
+
+
+/*
+ * job_killjid - send a signal to all processes in a job
+ * @jid: The job id
+ * @sig: The signal to be sent
+ *
+ * returns 0 on success, negative of errno on failure.
+ */
+static int
+job_killjid(u64 jid, int sig)
+{
+	struct job_entry	 *job;
+	struct list_head *attached_entry;
+	struct siginfo   info;
+	int retcode = 0;
+
+	/* A signal of zero is really a status check and is handled as such
+	 * by send_sig_info.  So we have < 0 instead of <= 0 here.
+	 */
+	if (sig < 0) {
+		retcode = -EINVAL;
+		goto cleanup_0locks_return;
+	} 
+
+	down_read(&job_table_sem);
+	job = job_getjob(jid);
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
+	info.si_signo = sig;
+	info.si_errno = 0;
+	info.si_code = SI_USER;
+	info.si_pid = current->pid;
+	info.si_uid = current->uid;
+
+	list_for_each(attached_entry, &job->attached) {
+		int err;
+		struct job_attach *attached;
+
+		attached = list_entry(attached_entry, struct job_attach, entry);
+		err = send_sig_info(sig, &info, 
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
+	}
+
+cleanup_2locks_return:
+	up_read(&job->sem);
+cleanup_1locks_return:
+	up_read(&job_table_sem);
+cleanup_0locks_return:
+	return retcode;
+}
+
+static pid_t
+job_getprimepid(struct job_entry *job)
+{
+	struct job_attach     *attached = NULL;
+
+	if (list_empty(&job->attached))
+		return -ESRCH;
+	else {
+		attached = list_entry(job->attached.next, struct job_attach, entry);
+		if (!attached->task) 
+			return -ESRCH;
+		else 
+			return attached->task->pid;
+	}
+}
+
+/* 
+ * job_sethid - set the host ID segment for the job IDs (jid).
+ * @hid: The host id to be set
+ *
+ * If the hid does not get set, then the jids upper 32 bits will be set to 
+ * 0 and the jid cannot be used reliably in a cluster environment.
+ *
+ * returns -errno value on fail, 0 on success
+ */
+static int
+job_sethid(unsigned long hid)
+{
+	int			errcode = 0;
+
+	if (!capable(CAP_SYS_RESOURCE)) {
+		errcode = -EPERM;
+		goto cleanup_return;
+	}
+
+	/* 
+	 * Set job_table_sem, so no jobs can be deleted or created while doing
+	 * this operation.
+	 */
+	down_write(&job_table_sem); 
+	jid_hid = hid;
+	memset(hidname, 0, 16);
+	sprintf(hidname, "%lu", jid_hid);
+	up_write(&job_table_sem);
+
+cleanup_return:
+	return errcode;
+}
+
+
+/* 
+ * job_detachjid - detach all processes attached to the job
+ * @jid: The job id to be detached
+ * 
+ * The job will exit, but the processes are allowed to continue running. 
+ * You need CAP_SYS_RESOURCE capability for this to succeed.
+ *
+ * returns -errno value on fail, 0 on success
+ */
+static int
+job_detachjid(u64 jid)
+{
+	struct job_entry	   *job;
+	struct list_head   *entry;
+	int		   count;
+	int		   rv = -1;
+	struct task_struct *task;
+	struct pagg *pagg;
+
+	if (!capable(CAP_SYS_RESOURCE)) {
+		rv = -EPERM;
+		goto cleanup_return;
+	}
+
+	/* 
+	 * Set job_table_sem, so no jobs can be deleted while doing
+	 * this operation.
+	 */
+	down_write(&job_table_sem); 
+
+	job = job_getjob(jid);
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
+		 * pagg entries. 
+		 * 
+		 * We don't test with list_empty because that actually means NO tasks
+		 * left rather than one task.  If we used !list_empty or list_for_each,
+		 * we could reference memory freed by the pagg hook detach function 
+		 * (job_detach).
+		 * 
+		 * We know there is only one task left when job->attached.next and
+		 * job->attached.prev both point to the same place.
+		 */
+		while (job->attached.next != job->attached.prev) {
+			entry = job->attached.next;
+			
+			task = (list_entry(entry, struct job_attach, entry))->task;
+			pagg = (list_entry(entry, struct job_attach, entry))->pagg;
+			down_write(&task->pagg_sem); /* write lock pagg list */
+			pagg->hook->detach(task, pagg);
+			pagg_free(pagg);
+			up_write(&task->pagg_sem); /* write unlock pagg list */
+
+		}
+		/* At this point, there is only one task left */
+
+		entry = job->attached.next;
+
+		task = (list_entry(entry, struct job_attach, entry))->task;
+		pagg = (list_entry(entry, struct job_attach, entry))->pagg;
+		down_write(&task->pagg_sem); /* write lock pagg list */
+		pagg->hook->detach(task, pagg);
+		pagg_free(pagg);
+		up_write(&task->pagg_sem); /* write unlock pagg list */
+			
+		rv = 0;
+
+	} else {
+		rv = -ENODATA;
+		up_write(&job_table_sem);
+	}
+
+cleanup_return:
+	return rv;
+}
+
+
+/* 
+ * job_detachpid - detach a process from the job it is attached to
+ * @pid: The process id to be detached. 
+ *
+ * That process is allowed to continue running.  You need 
+ * CAP_SYS_RESOURCE capability for this to succeed. 
+ *
+ * returns -errno value on fail, 0 on success
+ */
+static int
+job_detachpid(pid_t pid)
+{
+	struct task_struct *task;
+	struct pagg *pagg;
+	int		   errcode = 0;
+
+	if (!capable(CAP_SYS_RESOURCE)) {
+		errcode = -EPERM;
+		goto cleanup_return;
+	}
+
+	/* Lock the task list while we find a specific task */
+	read_lock(&tasklist_lock);
+	task = find_task_by_pid(pid);
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
+
+	down_write(&task->pagg_sem); /* write lock pagg list */
+	
+	pagg = pagg_get(task, pagg_hook.name);
+	if (pagg) {
+		pagg->hook->detach(task, pagg);
+		pagg_free(pagg);
+	} else {
+		errcode = -ENODATA;
+	}
+	put_task_struct(task);  /* Done accessing the task */
+	up_write(&task->pagg_sem); /* write unlock pagg list */
+
+cleanup_return:
+	return errcode;
+}
+
+/*
+ * job_attachpid - attach a process to the an existing job
+ * @pid: The process to be attached. It must not belong to any job.
+ * @jid: The job id to be attached to
+ *
+ * You need CAP_SYS_RESOURCE capability for this to succeed.
+ *
+ * returns -errno value on fail, 0 on success
+ */
+static int
+job_attachpid(pid_t pid, u64 jid)
+{
+	struct task_struct *task;
+	struct pagg *pagg;
+	struct job_entry *job = NULL;
+	struct job_attach *attached = NULL;
+	int errcode = 0;
+
+	if (!capable(CAP_SYS_RESOURCE)) {
+		errcode = -EPERM;
+		goto cleanup_return;
+	}
+
+	/* lock the tasklist until we grab the specific task */
+	read_lock(&tasklist_lock);
+	task = find_task_by_pid(pid);
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
+
+	down_write(&task->pagg_sem); /* write lock pagg list */
+	/* check if it belongs to a job*/
+	pagg = pagg_get(task, pagg_hook.name);
+	if (pagg) {
+		put_task_struct(task);
+		up_write(&task->pagg_sem);
+		errcode = -EINVAL;
+		goto cleanup_return;
+	}
+
+	/* Alloc pagg for it */
+	pagg = pagg_alloc(task, &pagg_hook);
+	if (pagg) {
+		down_read(&job_table_sem);
+		/* Check on the requested job */
+		job = job_getjob(jid);
+		if (!job) {
+			pagg_free(pagg);
+			errcode = -ENODATA;
+		}
+		else {
+			attached = list_entry(job->attached.next, struct job_attach, entry);
+			if(attached) {
+				if (pagg->hook->attach(task, pagg, attached) != 0) {
+					pagg_free(pagg);
+					errcode = -EFAULT;
+				}
+			}
+		}
+		up_read(&job_table_sem);
+	} else
+		errcode = -ENOMEM;
+	put_task_struct(task);  /* Done accessing the task */
+	up_write(&task->pagg_sem); /* write unlock pagg list */
+
+cleanup_return:
+	return errcode;
+}
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
+	struct pagg *pagg = NULL;
+	struct job_entry	   *job = NULL;
+	u64	   jid = 0;
+
+	down_read(&task->pagg_sem); /* lock pagg list */
+	pagg = pagg_get(task, pagg_hook.name);
+	if (pagg) {
+		job = ((struct job_attach *)pagg->data)->job;
+		down_read(&job->sem);
+		jid = job->jid;
+		up_read(&job->sem);
+	}
+	up_read(&task->pagg_sem);
+	return jid;
+}
+
+
+/*
+ * job_getacct - accounting subscribers get accounting information about a job.
+ * @jid: The job id
+ * @type: The accounting subscriber type
+ * @data: The accounting data that subscriber wants.
+ *
+ * The caller must supply the Job ID (jid) that specifies the job. The
+ * "type" argument indicates the type of accounting data to be returned.
+ * The data will be returned in the memory accessed via the data pointer
+ * argument.  The data pointer is void so that this function interface
+ * can handle different types of accounting data.
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
+ * job_setacct - accounting subscribers set specific accounting information 
+ * @jid: The job id
+ * @type: The accounting subscriber type.
+ * @subfield: The accounting information subfield for this set call
+ * @data: The accounting information to be set
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
+ * A small virtual filesystem called jobfs is used as the job's kernel 
+ * user communication interface. The jobfs should be mounted at /proc/job/
+ * from the userland after the job module is loaded. 
+ *
+ * jobfs provides the following directory structure:
+ * ( 0x000013479aa37011 is an example job id (jid), 9812 and 3244 are 
+ * two example pids that are attached to the jid.)
+ *  
+ *  |-hid
+ *  |-jids
+ *  |  |-0x000013479aa37011
+ *  |  | |-9812
+ *  |  | |-3244
+ *  |  | |-...
+ *  |  | |-handle
+ *  |  | `-primepid
+ *  |  |
+ *  |  `-...
+ *  |    |-...
+ *  |    `-...
+ *  `-pid
+ *     |-9812
+ *     |-3244
+ *     `-...
+ */ 
+
+/* jobfs mount point is /proc/job/ */
+struct proc_dir_entry *job_proc_entry;
+
+static struct file_operations job_file_ops = {
+        .owner  = THIS_MODULE,
+};
+
+static struct file_operations *jobfs_dir_ops = &simple_dir_operations;
+
+static struct super_operations jobfs_super_ops = {
+	.statfs = simple_statfs,
+        .drop_inode = generic_delete_inode,
+};
+
+static struct inode_operations job_jidsdir_ops = {
+	.mkdir = jobfs_mkdir,     
+	.lookup = simple_lookup,
+	.setattr = jobfs_nosetattr,
+};
+
+static struct inode_operations job_jiddir_ops = {
+	.lookup = simple_lookup,
+	.setattr = jobfs_chown,
+};
+
+static struct file_operations job_hid_fops = {
+	.open = jobfs_open,
+	.read = jobfs_read,
+	.write  = jobfs_hid_write,
+};
+
+static struct file_operations job_jidhandle_fops = {
+	.open = jobfs_open,
+	.write = jobfs_jhandle_write,
+};
+
+static struct file_operations job_read_fops = {
+	.open = jobfs_open,
+	.read = jobfs_read,
+};
+
+static struct inode_operations job_nosetattr_ops = {
+	.lookup = simple_lookup,
+	.setattr = jobfs_nosetattr,
+};
+
+static struct inode *jobfs_make_inode(struct super_block *sb, int mode)
+{
+	struct inode * inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->uid;
+		inode->i_gid = 0;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	}
+	return inode;
+}
+
+static int jobfs_nosetattr(struct dentry *dentry, struct iattr *attr) {
+	return -EPERM;
+}
+
+static int jobfs_chown(struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = dentry->d_inode;
+	unsigned int ia_valid = attr->ia_valid;
+	u64 jid;
+	struct job_entry *job;
+	if (sscanf(dentry->d_name.name, "%llx", &jid) != 1)
+                return -EINVAL;
+	down_write(&job_table_sem);
+	job = job_getjob(jid);
+	if (!job) {
+		up_write(&job_table_sem);
+		return -EINVAL;
+	}
+	if (capable(CAP_SYS_RESOURCE) || (current->uid == job->user)) {
+		job->user = attr->ia_uid;
+		if (ia_valid & ATTR_UID) { 
+			inode->i_uid = attr->ia_uid;
+			inode->i_gid = attr->ia_gid;
+			up_write(&job_table_sem);
+			return 0;
+		}
+	}
+	up_write(&job_table_sem);
+	return -EINVAL;
+}
+
+static struct dentry *jobfs_create (struct super_block *sb,
+	struct dentry *dir, const char *name,
+	int mode, u64 *jid, pid_t *pid, char *buf, int type)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+	struct qstr qname;
+
+	qname.name = name;
+	qname.len = strlen (name);
+	qname.hash = full_name_hash(name, qname.len);
+
+	dentry = d_alloc(dir, &qname);
+	if (! dentry)
+		return NULL;
+	inode = jobfs_make_inode(sb, mode);
+	if (! inode) {
+		dput(dentry);
+		return NULL;
+	}
+	switch(type) {
+	case JOB_WDIR:
+		inode->i_op = &job_jidsdir_ops;
+		inode->i_fop = &simple_dir_operations;
+		break;
+	case JOB_RDIR:
+		inode->i_op = &job_jiddir_ops;
+		inode->i_fop = &simple_dir_operations;
+		break;
+	case JOB_HID:
+		inode->i_op = &job_nosetattr_ops;
+		inode->i_fop = &job_hid_fops;
+		inode->u.generic_ip = hidname;
+                break;
+	case JOB_JIDHANDLE:
+		inode->i_op = &job_nosetattr_ops;
+		inode->i_fop = &job_jidhandle_fops;
+		inode->u.generic_ip = jid;
+		break;
+	case JOB_FILE_READ:
+		inode->i_op = &job_nosetattr_ops;
+		inode->i_fop = &job_read_fops;
+		inode->u.generic_ip = buf;
+		break;
+	} 
+	d_add(dentry, inode);
+	return dentry;
+}
+
+static int jobfs_fill_super(struct super_block * sb, void * data, int silent)
+{
+	struct inode * inode;
+	struct dentry * root;
+	int rv;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = JOBFS_MAGIC;
+	sb->s_op = &jobfs_super_ops;
+	inode = jobfs_make_inode(sb, S_IFDIR | 0555);
+	if (!inode)
+		return -ENOMEM;
+
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = jobfs_dir_ops;
+
+	root = d_alloc_root(inode);
+	if (!root) {
+		iput(inode);
+		return -ENOMEM;
+	}
+	sb->s_root = root;
+
+	rv = jobfs_create_files(sb, root);
+	return rv;
+}
+
+static struct super_block *jobfs_get_super(struct file_system_type *fst,
+                        int flags, const char *name, void *data)
+{
+	return get_sb_single(fst, flags, data, jobfs_fill_super);
+}
+
+static int jobfs_delete(struct dentry *delete_dentry)
+{
+	struct dentry *parent;
+
+	if (!delete_dentry || !delete_dentry->d_parent)
+		return -EINVAL;
+	parent = delete_dentry->d_parent;
+	if (!delete_dentry->d_inode) 
+		return 0;
+	down (&parent->d_inode->i_sem);
+	if (S_ISDIR(delete_dentry->d_inode->i_mode))
+		simple_rmdir(parent->d_inode, delete_dentry);
+	else
+		simple_unlink(parent->d_inode, delete_dentry);
+	up(&parent->d_inode->i_sem);
+	d_delete(delete_dentry);
+	return 0;
+}
+
+static int jobfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	u64 jid;
+	int ret;
+	if (sscanf(dentry->d_name.name, "%llx", &jid) != 1)
+		return -EINVAL;
+	ret = job_create(jid, current->uid, 0);
+	return ret;
+}
+
+static int jobfs_open(struct inode *inode, struct file *filp)
+{
+	filp->private_data = inode->u.generic_ip;
+	return 0;
+}
+
+static ssize_t jobfs_read(struct file *filp, char *buf,
+              size_t count, loff_t *offset)
+{ 
+	char *hbuf = (char *) filp->private_data;
+	int len;
+	char tmp[JOBFS_BUF];
+
+	len = snprintf(tmp, JOBFS_BUF, hbuf);
+	if (*offset > len)
+		return 0;
+	if (count > len - *offset)
+		count = len - *offset;
+
+	if (copy_to_user(buf, tmp + *offset, count))
+		return -EFAULT;
+	*offset += count;
+	return count;
+}
+
+
+static ssize_t jobfs_jhandle_write(struct file *filp, const char *buf,
+                 size_t count, loff_t *offset)
+{
+	char tmp[JOBFS_BUF];
+	char *tmp1;
+	u64 *jid = (u64 *) filp->private_data;
+	int sig;
+	int options;
+	int ret;
+	int stat;
+	pid_t pid;
+
+	if (*offset != 0)
+		return -EINVAL;
+	if (count >= JOBFS_BUF)
+		return -EINVAL;
+	memset(tmp, 0, JOBFS_BUF);
+	if (copy_from_user(tmp, buf, count))
+		return -EFAULT;
+	
+	if (strcmp(tmp, "detach") == 0) 
+		return job_detachjid(*jid);
+	tmp1 = strchr(tmp, ' ');
+		if (!tmp1)
+			return -EINVAL;
+		*tmp1 = '\0';
+		tmp1++;
+
+	if(strncmp(tmp, "kill", 4) == 0) {
+		if (sscanf(tmp1, "%d", &sig) != 1)
+			return -EINVAL;
+		return job_killjid(*jid, sig);
+	}
+	if(strncmp(tmp, "wait", 4) == 0) {
+		if (sscanf(tmp1, "%d", &options)!=1)
+			return -EINVAL;
+		ret = job_waitjid(*jid, &stat, options);
+		if (ret == 0)
+			return stat;
+		else
+			return ret;
+	}
+	if(strncmp(tmp, "detachpid", 9) == 0) {
+		if (sscanf(tmp1, "%d", &pid)!=1)
+			return -EINVAL;
+		return job_detachpid(pid);
+	}
+	if(strncmp(tmp, "attachpid", 9) == 0) {
+		if (sscanf(tmp1, "%d", &pid) != 1)
+			return -EINVAL;
+		return job_attachpid(pid, *jid);
+	}
+	return -EINVAL;
+}
+
+static ssize_t jobfs_hid_write(struct file *filp, const char *buf,
+                 size_t count, loff_t *offset)
+{
+	char *hbuf = (char *) filp->private_data;
+	char tmp[JOBFS_BUF];
+	unsigned long h;
+
+	if (*offset != 0)
+		return -EINVAL;
+	if (count >= JOBFS_BUF)
+		return -EINVAL;
+	memset(tmp, 0, JOBFS_BUF);
+	if (copy_from_user(tmp, buf, count))
+		return -EFAULT;
+	if (sscanf(tmp, "%lu", &h) != 1)
+		return -EINVAL;
+	return job_sethid(h);
+}
+
+static struct file_system_type jobfs_fs_type = {
+	.owner = THIS_MODULE,
+	.name = "jobfs",
+	.get_sb = jobfs_get_super,
+	.kill_sb = kill_litter_super,
+};
+
+static int jobfs_create_files (struct super_block *sb, struct dentry *root)
+{
+	char *data = NULL;
+
+	jobsb = sb;
+	if (!jobfs_create(sb, root, "hid", S_IFREG|0666, 0, 0, data, JOB_HID))
+		return -EFAULT;	
+	jiddirs = jobfs_create(sb, root, "jids", S_IFDIR|0777, 0, 0, 
+		data, JOB_WDIR);
+	if (!jiddirs)
+		return -EFAULT;
+	piddirs = jobfs_create(sb, root, "pids", S_IFDIR|0555, 0, 0, 
+		data, JOB_RDIR);
+	if(!piddirs)
+		return -EFAULT;
+	return 0;
+}
+	
+struct vfsmount *jobfs_vfsmount;
+
+int __init init_jobfs_fs(void)
+{
+        int error;
+
+        error = register_filesystem(&jobfs_fs_type);
+        if (error)
+                return error;
+
+	jobfs_vfsmount = kern_mount(&jobfs_fs_type);
+	if (IS_ERR(jobfs_vfsmount)) {
+		printk(KERN_ERR "jobfs: could not mount!\n");
+		goto out;
+	}
+	return 0;
+out:
+	unregister_filesystem(&jobfs_fs_type);
+	return PTR_ERR(jobfs_vfsmount);
+}
+
+static void __exit exit_jobfs_fs(void)
+{
+	unregister_filesystem(&jobfs_fs_type);
+}
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
+	memset(hidname, 0, 16);
+	sprintf(hidname, "%lu", jid_hid);
+
+	rc = pagg_hook_register(&pagg_hook);
+	if (rc < 0) 
+		return -1;
+
+	/* Setup /proc/job/ entry for jobfs mounting */
+	job_proc_entry = create_proc_entry(JOB_PROC_ENTRY,
+		S_IFDIR | S_IRUGO, &proc_root);
+	if (!job_proc_entry) {
+		pagg_hook_unregister(&pagg_hook);
+		return -1;
+	}
+
+	job_proc_entry->proc_fops = &job_file_ops;
+	job_proc_entry->proc_iops = NULL;
+
+	rc = init_jobfs_fs();
+	if (rc < 0)
+		return -1;
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
+	pagg_hook_unregister(&pagg_hook);
+	exit_jobfs_fs();
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
--- linux.orig/kernel/Makefile	2005-01-06 12:54:53.000000000 -0800
+++ linux/kernel/Makefile	2005-01-06 12:56:58.000000000 -0800
@@ -19,6 +19,7 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_PAGG) += pagg.o
+obj-$(CONFIG_PAGG_JOB) += job.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o

--%--multipart-mixed-boundary-1.8557.1105392033--%--
