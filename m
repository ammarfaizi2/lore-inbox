Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUHRRXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUHRRXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 13:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUHRRXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 13:23:24 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:34507 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267356AbUHRRUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 13:20:42 -0400
Message-ID: <41238FF8.2070202@engr.sgi.com>
Date: Wed, 18 Aug 2004 10:20:56 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Erik Jacobson <erikj@dbear.engr.sgi.com>, Limin Gu <limin@engr.sgi.com>
Subject: [PATCH] csa patch for 2.6.8
Content-Type: multipart/mixed;
 boundary="------------060202000807050403020600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060202000807050403020600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached is the Comprehensive System Accounting (CSA) patch to kernel
2.6.8.

This patch applies cleanly after PAGG and JOB patch to 2.6.8. There was
no code changes since the 2.6.7 patch.

The project page of CSA is located at http://oss.sgi.com/projects/csa/

Any comment, suggestion, bug post/fix are very much welcome!

Signed-off-by: Jay Lan <jlan@sgi.com>

---
Jay Lan - Linux System Software
Silicon Graphics Inc., Mountain View, CA

--------------060202000807050403020600
Content-Type: text/plain;
 name="csa"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="csa"

Index: linux/drivers/block/ll_rw_blk.c
===================================================================
--- linux.orig/drivers/block/ll_rw_blk.c	2004-08-14 00:36:16.000000000 -0500
+++ linux/drivers/block/ll_rw_blk.c	2004-08-16 09:59:30.000000000 -0500
@@ -1674,6 +1674,7 @@
 {
 	DEFINE_WAIT(wait);
 	struct request *rq;
+	unsigned long start_wait = jiffies;
 
 	generic_unplug_device(q);
 	do {
@@ -1702,6 +1703,7 @@
 		finish_wait(&rl->wait[rw], &wait);
 	} while (!rq);
 
+	current->bwtime += (unsigned long) jiffies - start_wait;
 	return rq;
 }
 
@@ -1948,10 +1950,12 @@
 
 	if (rw == READ) {
 		disk_stat_add(rq->rq_disk, read_sectors, nr_sectors);
+		current->rblk += nr_sectors;
 		if (!new_io)
 			disk_stat_inc(rq->rq_disk, read_merges);
 	} else if (rw == WRITE) {
 		disk_stat_add(rq->rq_disk, write_sectors, nr_sectors);
+		current->wblk += nr_sectors;
 		if (!new_io)
 			disk_stat_inc(rq->rq_disk, write_merges);
 	}
Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c	2004-08-16 09:55:20.000000000 -0500
+++ linux/fs/exec.c	2004-08-16 09:59:30.000000000 -0500
@@ -47,6 +47,7 @@
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
 #include <linux/pagg.h>
+#include <linux/csa_internal.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1145,6 +1146,9 @@
 
 		/* execve success */
 		security_bprm_free(&bprm);
+		/* no-op if CONFIG_CSA not set */
+		csa_update_integrals();
+		update_mem_hiwater();
 		return retval;
 	}
 
Index: linux/fs/read_write.c
===================================================================
--- linux.orig/fs/read_write.c	2004-08-14 00:37:15.000000000 -0500
+++ linux/fs/read_write.c	2004-08-16 09:59:30.000000000 -0500
@@ -216,8 +216,11 @@
 				ret = file->f_op->read(file, buf, count, pos);
 			else
 				ret = do_sync_read(file, buf, count, pos);
-			if (ret > 0)
+			if (ret > 0) {
 				dnotify_parent(file->f_dentry, DN_ACCESS);
+				current->rchar += ret;
+			}
+			current->syscr++;
 		}
 	}
 
@@ -260,8 +263,11 @@
 				ret = file->f_op->write(file, buf, count, pos);
 			else
 				ret = do_sync_write(file, buf, count, pos);
-			if (ret > 0)
+			if (ret > 0) {
 				dnotify_parent(file->f_dentry, DN_MODIFY);
+				current->wchar += ret;
+			}
+			current->syscw++;
 		}
 	}
 
@@ -540,6 +546,10 @@
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0) {
+		current->rchar += ret;
+	}
+	current->syscr++;
 	return ret;
 }
 
@@ -558,6 +568,10 @@
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0) {
+		current->wchar += ret;
+	}
+	current->syscw++;
 	return ret;
 }
 
@@ -636,6 +650,13 @@
 
 	retval = in_file->f_op->sendfile(in_file, ppos, count, file_send_actor, out_file);
 
+	if (retval > 0) {
+		current->rchar += retval;
+		current->wchar += retval;
+	}
+	current->syscr++;
+	current->syscw++;
+
 	if (*ppos > max)
 		retval = -EOVERFLOW;
 
Index: linux/include/linux/csa.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/csa.h	2004-08-16 09:59:30.000000000 -0500
@@ -0,0 +1,526 @@
+/*
+ * Copyright (c) 2000-2002 Silicon Graphics, Inc and LANL  All Rights Reserved.
+ * Copyright (c) 2004 Silicon Graphics, Inc All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as 
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it would be useful, but 
+ * WITHOUT ANY WARRANTY; without even the implied warranty of 
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details. 
+ *
+ * You should have received a copy of the GNU General Public License along 
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information:  Silicon Graphics, Inc., 1500 Crittenden Lane,
+ * Mountain View, CA  94043, or:
+ * 
+ * http://www.sgi.com 
+ */
+/*
+ *  CSA (Comprehensive System Accounting)
+ *  Job Accounting for Linux
+ *
+ *  This header file contains the definitions needed for job
+ *  accounting. The kernel CSA accounting module code and all
+ *  user-level programs that try to write or process the binary job 
+ *  accounting data must include this file.
+ *
+ *
+ */
+
+#ifndef _LINUX_CSA_H
+#define _LINUX_CSA_H
+
+#ifndef __KERNEL__
+#include <stdint.h>
+#include <sys/types.h>
+#endif
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
+
+#define AHZ		100
+
+/*
+ * Magic number - for achead.ah_magic in the 1st header.  The magic number
+ *                in the 2nd header is the inverse of this.
+ */
+#define ACCT_MAGIC_BIG          030510  /* big-endian */
+#define ACCT_MAGIC_LITTLE       030512  /* little-endian */
+#ifdef __LITTLE_ENDIAN
+#define ACCT_MAGIC ACCT_MAGIC_LITTLE
+#else
+#define ACCT_MAGIC ACCT_MAGIC_BIG
+#endif
+
+/*
+ * Record types - for achead.ah_type in the 1st header.
+ */
+#define	ACCT_KERNEL_CSA		0001	/* Kernel: CSA base record */
+#define	ACCT_KERNEL_MEM		0002	/* Kernel: memory record */
+#define	ACCT_KERNEL_IO		0004	/* Kernel: input/output record */
+#define	ACCT_KERNEL_MT 		0006	/* Kernel: multi-tasking record */
+#define	ACCT_KERNEL_MPP		0010	/* Kernel: multi-PE appl record */
+#define	ACCT_KERNEL_SOJ		0012	/* Kernel: start-of-job record */
+#define	ACCT_KERNEL_EOJ		0014	/* Kernel: end-of-job record */
+#define	ACCT_KERNEL_CFG		0020	/* Kernel: configuration record */
+
+#define	ACCT_KERNEL_SITE0	0100	/* Kernel: reserved for site */
+#define	ACCT_KERNEL_SITE1	0101	/* Kernel: reserved for site */
+
+#define	ACCT_DAEMON_NQS		0120	/* Daemon: NQS record */
+#define	ACCT_DAEMON_WKMG      	0122	/* Daemon: workload management record,
+					           i.e., LSF */
+#define	ACCT_DAEMON_TAPE	0124	/* Daemon: tape record */
+#define	ACCT_DAEMON_DMIG	0126	/* Daemon: data migration record */
+#define	ACCT_DAEMON_SOCKET	0130	/* Daemon: socket record */
+
+#define	ACCT_DAEMON_SITE0	0200	/* Daemon: reserved for site */
+#define	ACCT_DAEMON_SITE1	0201	/* Daemon: reserved for site */
+
+#define	ACCT_JOB_HEADER		0220	/* csabuild: job header record */
+#define	ACCT_CACCT		0222	/* cacct:    consolidated data */
+#define	ACCT_CMS		0224	/* cms:      command summary data */
+
+/* Record types - for achead.ah_type in the 2nd header. */
+#define	ACCT_MEM	1<<0	/* Process generated memory record */
+#define	ACCT_IO		1<<1	/* Process generated I/O record */
+#define	ACCT_MT		1<<2	/* Process used multi-tasking */
+#define	ACCT_MPP	1<<3	/* Process used multi-PE */
+
+/*
+ * Record revision levels.
+ *
+ * These are incremented to indicate that a record's format has changed since
+ * a previous release.
+ */
+#define	REV_CSA		02400	/* Kernel: CSA base record */
+#define	REV_MEM		02400	/* Kernel: memory record */
+#define	REV_IO		02400	/* Kernel: I/O record */
+#define	REV_MT 		02400	/* Kernel: multi-tasking record */
+#define	REV_MPP		02400	/* Kernel: multi-PE appl record */
+#define	REV_SOJ		02400	/* Kernel: start-of-job record */
+#define	REV_EOJ		02400	/* Kernel: end-of-job record */
+#define	REV_CFG		02400	/* Kernel: configuration record */
+
+#define REV_NQS		02400 	/* Daemon: NQS record */
+#define REV_WKMG	02400 	/* Daemon: workload management (i.e., LSF)
+				           record */
+#define REV_TAPE	02400	/* Daemon: tape record */
+#define REV_DMIG	02400	/* Daemon: data migration record */
+#define REV_SOCKET	02400	/* Daemon: socket record */
+
+#define REV_JOB		02400	/* csabuild: job header record */
+#define REV_CACCT	02400	/* cacct:    consolidated data */
+#define REV_CMS		02400	/* cms:      command summary data */
+
+/*
+ * Record header
+ */
+struct achead
+{
+	unsigned int	ah_magic:17;	/* Magic */
+	unsigned int	ah_revision:15;	/* Revision */
+	unsigned int	ah_type:8;	/* Record type */
+	unsigned int	ah_flag:8;	/* Record flags */
+	unsigned int	ah_size:16;	/* Size of record */
+};
+
+/*
+ *  In order to keep the accounting records the same size across different
+ *  machine types, record fields will be defined to types that won't
+ *  vary (i.e. uint_32_t instead of uid_t).
+*/
+
+/*
+ * Per process base accounting record.
+ */
+struct acctcsa
+{
+	struct achead	ac_hdr1;	/* Header */
+	struct achead	ac_hdr2;	/* 2nd header for continued records */ 
+	double 		ac_sbu;		/* System billing units */
+	unsigned int	ac_stat:8;	/* Exit status */
+	unsigned int	ac_nice:8;	/* Nice value */
+	unsigned char	ac_sched;	/* Scheduling discipline */
+	unsigned int	:8;		/* Unused */
+	uint32_t	ac_uid;		/* User ID */
+	uint32_t	ac_gid;		/* Group ID */
+	uint64_t	ac_ash;		/* Array session handle */
+	uint64_t	ac_jid;		/* Job ID */
+	uint64_t	ac_prid;	/* Project ID -> account ID */
+	uint32_t	ac_pid;		/* Process ID */
+	uint32_t	ac_ppid;	/* Parent process ID */
+	time_t		ac_btime;	/* Beginning time [sec since 1970] */
+	char		ac_comm[16];	/* Command name */
+/*	CPU resource usage information. */
+	uint64_t	ac_etime;	/* Elapsed time [usecs] */
+	uint64_t	ac_utime;	/* User CPU time [usec] */
+	uint64_t	ac_stime;	/* System CPU time [usec] */
+	uint64_t	ac_spare;	/* Spare field */
+	uint64_t        ac_spare1;	/* Spare field */
+};
+
+/*
+ * Memory accounting structure
+ * This structure is part of the acctmem record.
+ */
+struct memint
+{
+	uint64_t	himem;	/* Hiwater memory usage [Kbytes] */
+	uint64_t	mem1;	/* Memory integral 1 [Mbytes/uSec] */
+	uint64_t	mem2;	/* Memory integral 2 - not used */
+	uint64_t	mem3;	/* Memory integral 3 - not used */
+};
+
+/*
+ * Memory accounting record
+ */
+struct acctmem
+{
+	struct achead	ac_hdr;		/* Header */
+	double 		ac_sbu;		/* System billing units */
+	struct memint	ac_core;	/* Core memory integrals */
+	struct memint	ac_virt;	/* Virtual memory integrals */
+	uint64_t	ac_pgswap;	/* # of pages swapped  */
+	uint64_t	ac_minflt;	/* # of minor page faults */
+	uint64_t	ac_majflt;	/* # of major page faults */
+	uint64_t	ac_spare;	/* Spare field */
+};
+
+/*
+ * Input/Output accounting record
+ */
+struct acctio
+{
+	struct achead		ac_hdr;	   /* Header */
+	double 			ac_sbu;	   /* System billing units */
+	uint64_t	ac_bwtime; /* Block I/O wait time [usecs] */
+	uint64_t	ac_rwtime; /* Raw I/O wait time [usecs] */
+	uint64_t	ac_chr;    /* Number of chars (bytes) read */
+	uint64_t	ac_chw;	   /* Number of chars (bytes) written */
+	uint64_t	ac_bkr;	   /* Number of blocks read */
+	uint64_t	ac_bkw;	   /* Number of blocks written */
+	uint64_t	ac_scr;	   /* Number of read system calls */
+	uint64_t	ac_scw;	   /* Number of write system calls */
+	uint64_t	ac_spare;  /* Spare field */
+};
+
+/*
+ * Multi-tasking accounting structure
+ * This structure is part of the acctmt record.
+ */
+struct mtask
+{
+	uint64_t	mt;		/* CPU+1 connect time [usecs] */
+	uint64_t	spare1;		/* Spare field */
+	uint64_t	spare2;		/* Spare field */
+};
+
+/*
+ * Multi-tasking accounting record - currently not used, adapted from UNICOS.
+ */
+#define	ACCT_MAXCPUS	512	/* Maximum number of CPUs supported */
+
+struct acctmt
+{
+	struct achead	ac_hdr;		/* Header */
+	double 		ac_sbu;		/* System billing units */
+	unsigned int	ac_numcpu:16;	/* Max number of CPUs used */
+	unsigned int	ac_maxcpu:16;	/* Max number of CPUs available */
+	unsigned int	:32;		/* Unused */
+	int64_t		ac_smwtime;	/* Semaphore wait time [usec] */
+	struct mtask	ac_mttime[ACCT_MAXCPUS]; /* Time connected to (i+1)
+						    CPUs [usec] */
+};
+
+/*
+ * MPP PE accounting structure - MPP hardware specific.
+ * This structure is part of the acctmpp record.
+ */
+struct acctpe
+{
+	uint64_t	utime;	 /* User CPU time [usecs] */
+	uint64_t	srtime;	 /* System & remote CPU time [usecs] */
+	uint64_t	io;	 /* Number of chars transferred */
+};
+
+/*
+ * MPP accounting record - MPP hardware specific; currently not used.
+ */
+#define	ACCT_MAXPES	1024	/* Maximum number of PEs */
+
+struct acctmpp
+{
+	struct achead 	ac_hdr;		/* Header */
+	double 		ac_sbu;		/* System billing units */
+	unsigned int	ac_mpbesu:8;	/* Number of BESUs used	*/
+	unsigned int	ac_mppe:24;	/* Number of PEs used */
+	uint64_t	ac_himem; /* Maximum memory hiwater [Mbytes] */
+
+	struct acctpe	ac_mpp[ACCT_MAXPES];	/* Per PE information */
+};
+
+/*
+ * MPP Detailed PE accounting structure - currently not used
+ */
+struct acctdpe
+{
+	struct achead 	ac_hdr;		/* Header */
+
+	uint64_t	utime;		/* User CPU time [usecs] */
+	uint64_t	stime;		/* System CPU time [usecs] */
+	uint64_t	rtime;		/* Remote CPU time [usecs] */
+
+	uint64_t	ctime;		/* Connect CPU time [usecs] */
+	uint64_t	io;		/* Number of chars transferred */
+	uint64_t	spare;		/* Spare field */
+};
+
+/*
+ * Start-of-job record
+ * Written when a job is created.
+ */
+
+typedef enum
+{
+        AC_INIT_LOGIN,          /* Initiated by login */
+        AC_INIT_NQS,            /* Initiated by NQS */
+        AC_INIT_LSF,            /* Initiated by LSF */
+        AC_INIT_CROND,          /* Initiated by crond */
+        AC_INIT_FTPD,           /* Initiated by ftpd */
+        AC_INIT_INETD,          /* Initiated by inetd */
+        AC_INIT_TELNETD,        /* Initiated by telnetd */
+        AC_INIT_MAX
+} ac_inittype;
+
+
+#define AC_SOJ	1	/* Start-of-job record type */
+#define AC_ROJ	2	/* Restart-of-job record type */
+
+struct acctsoj
+{
+	struct achead 	ac_hdr;		/* Header */
+	unsigned int	ac_type:8;	/* Record type (AC_SOJ, AC_ROJ) */
+	ac_inittype	ac_init:8;	/* Initiator - currently not used */
+	unsigned int	:16;		/* Unused */
+	uint32_t	ac_uid;		/* User ID */
+	uint64_t	ac_jid;		/* Job ID */
+	time_t	 	ac_btime;	/* Start time [secs since 1970] */
+	time_t	 	ac_rstime;	/* Restart time [secs since 1970] */
+};
+
+/*
+ * End-of-job record
+ * Written when the last process of a job exits.
+ */
+struct accteoj
+{
+	struct achead	ac_hdr1;	/* Header */ 
+	struct achead	ac_hdr2;	/* 2nd header for continued records */ 
+	double 		ac_sbu;		/* System billing units */
+	ac_inittype	ac_init:8;	/* Initiator - currently not used */
+	unsigned int	ac_nice:8;	/* Nice value */
+	unsigned int	:16;		/* Unused */
+	uint32_t	ac_uid;		/* User ID */
+	uint32_t	ac_gid;		/* Group ID */
+	uint64_t	ac_ash;		/* Array session handle; not used */
+	uint64_t	ac_jid;		/* Job ID */
+	uint64_t	ac_prid;	/* Project ID; not used */
+	time_t	 	ac_btime;	/* Job start time [secs since 1970] */
+	time_t  	ac_etime;	/* Job end time   [secs since 1970] */
+	uint64_t	ac_corehimem;	/* Hiwater core mem [Kbytes] */
+	uint64_t	ac_virthimem;	/* Hiwater virt mem [Kbytes] */
+/*	CPU resource usage information. */
+	uint64_t	ac_utime;  /* User CPU time [usec]  */
+	uint64_t	ac_stime; /* System CPU time [usec] */
+	uint32_t	ac_spare;	
+};
+
+/*
+ * Accounting configuration uname structure
+ * This structure is part of the acctcfg record.
+ */
+struct ac_utsname
+{
+	char	 sysname[26];
+	char	 nodename[26];
+	char	 release[42];
+	char	 version[41];
+	char	 machine[26];
+};
+
+/*
+ * Accounting configuration record
+ * Written for accounting configuration changes.
+ */
+typedef enum
+{
+        AC_CONFCHG_BOOT,        /* Boot time (always first) */
+        AC_CONFCHG_FILE,        /* Reporting pacct file change */
+        AC_CONFCHG_ON,          /* Reporting xxx ON */
+        AC_CONFCHG_OFF,         /* Reporting xxx OFF */
+        AC_CONFCHG_INC_DELTA,   /* Report incremental acct clock delta change */        AC_CONFCHG_INC_EVENT,   /* Report incremental accounting event */
+        AC_CONFCHG_MAX
+} ac_eventtype;
+
+struct acctcfg
+{
+	struct achead	ac_hdr;		/* Header */
+	unsigned int	ac_kdmask;	/* Kernel and daemon config mask */
+	unsigned int	ac_rmask;	/* Record configuration mask */
+	int64_t		ac_uptimelen;	/* Bytes from the end of the boot
+					   record to the next boot record */
+	ac_eventtype	ac_event:8;	/* Accounting configuration event */
+	unsigned int	:24;		/* Unused */
+	time_t		ac_boottime;	/* System boot time [secs since 1970]*/
+	time_t		ac_curtime;	/* Current time [secs since 1970] */
+	struct ac_utsname  ac_uname;	/* Condensed uname information */
+};
+
+
+/*
+ * Accounting control status values.
+ */
+typedef	enum
+{
+	ACS_OFF,	/* Accounting stopped for this entry */
+	ACS_ERROFF,	/* Accounting turned off by kernel */
+	ACS_ON		/* Accounting started for this entry */
+} ac_status;
+
+/*
+ * Function codes for CSA library interface
+ */
+typedef	enum
+{
+	AC_START,	/* Start kernel, daemon, or record accounting */
+	AC_STOP,	/* Stop kernel, daemon, or record accounting */
+	AC_HALT,	/* Stop all kernel, daemon, and record accounting */
+	AC_CHECK,	/* Check a kernel, daemon, or record accounting state*/
+	AC_KDSTAT,	/* Check all kernel & daemon accounting states */
+	AC_RCDSTAT,	/* Check all record accounting states */
+	AC_JASTART,	/* Start user job accounting  */
+	AC_JASTOP,	/* Stop user job accounting */
+	AC_WRACCT,	/* Write accounting record for daemon */
+	AC_AUTH,	/* Verify executing user is authorized */
+	AC_INCACCT,	/* Control incremental accounting */
+	AC_MREQ
+} ac_request;
+
+/*
+ * Define the CSA accounting record type indices.
+ */
+typedef	enum
+{
+	ACCT_KERN_CSA,		/* Kernel CSA accounting */
+	ACCT_KERN_JOB_PROC,	/* Kernel job process summary accounting */
+	ACCT_KERN_ASH,		/* Kernel array session summary accounting */
+	ACCT_DMD_NQS, 		/* Daemon NQS accounting */
+	ACCT_DMD_WKMG, 		/* Daemon workload management (i.e. LSF) acct */
+	ACCT_DMD_TAPE,		/* Daemon tape accounting */
+	ACCT_DMD_DMIG,		/* Daemon data migration accounting */
+	ACCT_DMD_SOCKET,	/* Daemon socket accounting */
+	ACCT_DMD_SITE1,		/* Site reserved daemon acct */
+	ACCT_DMD_SITE2,		/* Site reserved daemon acct */
+	ACCT_MAXKDS,		/* Max # kernel and daemon entries */
+
+	ACCT_RCD_MPPDET,	/* Record acct for MPP detail exit info */
+	ACCT_RCD_MEM,		/* Record acct for memory */
+	ACCT_RCD_IO,		/* Record acct for input/output */
+	ACCT_RCD_MT,		/* Record acct for multi-tasking */
+	ACCT_RCD_MPP,		/* Record acct for MPP accumulated info */
+	ACCT_THD_MEM,		/* Record acct for memory size threshhold */
+	ACCT_THD_TIME,		/* Record acct for CPU time threshhold */
+	ACCT_RCD_INCACCT,	/* Record acct for incremental accounting */
+	ACCT_RCD_APPACCT,	/* Record acct for application accounting */
+	ACCT_RCD_SITE1,		/* Site reserved record acct */
+	ACCT_RCD_SITE2,		/* Site reserved record acct */
+	ACCT_MAXRCDS		/* Max # record entries */
+} ac_kdrcd;
+
+#define	ACCT_RCDS	ACCT_RCD_MPPDET /* Record acct low range definition */
+#define	NUM_KDS		(ACCT_MAXKDS - ACCT_KERN_CSA)
+#define	NUM_RCDS	(ACCT_MAXRCDS - ACCT_RCDS)
+#define	NUM_KDRCDS	(NUM_KDS + NUM_RCDS)
+
+
+/*
+ * The following structures are used to get status of a CSA accounting type.
+ */
+
+/*
+ * Accounting entry status structure
+ */
+struct actstat
+{
+	ac_kdrcd	ac_ind;		/* Entry index */
+	ac_status	ac_state;	/* Entry status */
+	int64_t		ac_param;	/* Entry parameter */
+};
+
+/*
+ * Accounting control and status structure
+ */
+#define	ACCT_PATH	128	/* Max path length for accounting file */
+
+struct actctl
+{
+	int	ac_sttnum;		/* Number of status array entries */
+	char	ac_path[ACCT_PATH];	/* Path name for accounting file */
+	struct actstat	ac_stat[NUM_KDRCDS];	/* Entry status array */
+};
+
+/*
+ * Function codes for incremental accounting; currently not used
+ */
+typedef	enum
+{
+	IA_NONE,	/* Zero entry place holder */
+	IA_DELTA,	/* Change clock delta for incremental accounting */
+	IA_EVENT,	/* Cause incremental accounting event now */
+	IA_MAX
+} ac_iafnc;
+
+/*
+ * Incremental accounting structure; currently not used
+ */
+struct actinc
+{
+	int		ac_ind;		/* Entry index */
+	ac_iafnc	ac_fnc;		/* Entry function */
+	int64_t		ac_param;	/* Entry parameter */
+};
+
+/*
+ * Daemon write accounting structure
+ */
+#define	MAX_WRACCT	1024	/* Maximum buffer size of wracct() */
+
+struct actwra
+{
+	int	 ac_did;		/* Daemon index */
+	int	 ac_len;		/* Length of buffer (bytes) */
+	uint64_t ac_jid;		/* Job ID */
+	char	*ac_buf;		/* Daemon accounting buffer */
+};
+
+/* These definitions are used with the CSA /proc IOCTL interface */
+#define CSA_PROC	"csa"
+#define CSA_IOCTL_NUM	'A'
+
+
+#endif	/* _LINUX_CSA_H */
Index: linux/include/linux/csa_internal.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/csa_internal.h	2004-08-16 09:59:30.000000000 -0500
@@ -0,0 +1,85 @@
+/*
+ * Copyright (c) 2000-2002 Silicon Graphics, Inc and LANL  All Rights Reserved.
+ * Copyright (c) 2004 Silicon Graphics, Inc All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information:  Silicon Graphics, Inc., 1500 Crittenden Lane,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ */
+
+/*
+ *  CSA (Comprehensive System Accounting)
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
+extern void (*do_csa_acct) (int, struct task_struct *);
+
+#if defined (CONFIG_CSA) || defined (CONFIG_CSA_MODULE)
+
+#include <linux/linkage.h>
+#include <linux/ptrace.h>
+
+static inline void csa_update_integrals(void)
+{
+	long delta;
+
+	if (current->mm) {
+		delta = current->stime - current->csa_stimexpd;
+		current->csa_stimexpd = current->stime;
+		current->csa_rss_mem1 += delta * current->mm->rss;
+		current->csa_vm_mem1 += delta * current->mm->total_vm;
+	}
+}
+
+static inline void csa_clear_integrals(struct task_struct *tsk)
+{
+	if (tsk) {
+		tsk->csa_stimexpd = 0;
+		tsk->csa_rss_mem1 = 0;
+		tsk->csa_vm_mem1 = 0;
+	}	
+}
+
+/*
+ *  This is the wrapper for the CSA end-of-process accounting record, which
+ *  is written by the CSA csa.c code when a task within a job exits.
+ */
+static inline void
+csa_acct(int exitcode, struct task_struct *p)
+{
+	if (do_csa_acct != NULL) {
+		do_csa_acct(exitcode, p);
+	}
+}
+
+#else	/* CONFIG_CSA || CONFIG_CSA_MODULE */
+
+#define csa_update_integrals()		do { } while (0);
+#define csa_clear_integrals(task)	do { } while (0);
+#define csa_acct(exitcode, task)	do { } while (0);
+#endif	/* CONFIG_CSA || CONFIG_CSA_MODULE */
+
+#endif	/* _LINUX_CSA_INTERNAL_H */
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2004-08-16 09:55:20.000000000 -0500
+++ linux/include/linux/sched.h	2004-08-16 09:59:30.000000000 -0500
@@ -229,6 +229,8 @@
 	struct kioctx		*ioctx_list;
 
 	struct kioctx		default_kioctx;
+
+	unsigned long hiwater_rss, hiwater_vm;
 };
 
 extern int mmlist_nr;
@@ -455,6 +457,7 @@
 	unsigned long it_real_value, it_prof_value, it_virt_value;
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
+	struct list_head posix_timers; /* POSIX.1b Interval Timers */
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw; /* context switch counts */
 	u64 start_time;
@@ -473,6 +476,7 @@
 	char comm[16];
 /* file system info */
 	int link_count, total_link_count;
+	struct tty_struct *tty; /* NULL if no tty */
 /* ipc stuff */
 	struct sysv_sem sysvsem;
 /* CPU-specific state of this task */
@@ -533,7 +537,12 @@
 	struct list_head pagg_list;
 	struct rw_semaphore pagg_sem;
 #endif
-
+/* i/o counters(bytes read/written, blocks read/written, #syscalls, waittime */
+	unsigned long rchar, wchar, rblk, wblk, syscr, syscw, bwtime;
+#if defined(CONFIG_CSA) || defined(CONFIG_CSA_MODULE)       
+	unsigned long csa_rss_mem1, csa_vm_mem1;              
+	clock_t csa_stimexpd;                                 
+#endif                                                      
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
@@ -870,6 +879,19 @@
 /* Remove the current tasks stale references to the old mm_struct */
 extern void mm_release(struct task_struct *, struct mm_struct *);
 
+/* Update highwater values */
+static inline void update_mem_hiwater(void)
+{
+	if (current->mm) {
+		if (current->mm->hiwater_rss < current->mm->rss) {
+			current->mm->hiwater_rss = current->mm->rss;
+		}
+		if (current->mm->hiwater_vm < current->mm->total_vm) {
+			current->mm->hiwater_vm = current->mm->total_vm;
+		}
+	}
+}
+
 extern int  copy_thread(int, unsigned long, unsigned long, unsigned long, struct task_struct *, struct pt_regs *);
 extern void flush_thread(void);
 extern void exit_thread(void);
Index: linux/init/Kconfig
===================================================================
--- linux.orig/init/Kconfig	2004-08-16 09:55:20.000000000 -0500
+++ linux/init/Kconfig	2004-08-16 09:59:30.000000000 -0500
@@ -158,6 +158,31 @@
 	  a module, select this entry using M.  If you do not want support
 	  for jobs, select N.
 
+config CSA
+	tristate "  CSA Job Accounting"
+	depends on PAGG_JOB
+	help
+	  Comprehensive System Accounting (CSA) provides job level
+	  accounting of resource usage.  The accounting records are
+	  written by the kernel into a file.  CSA user level scripts
+	  and commands process the binary accounting records and
+	  combine them by job identifier within system boot uptime
+	  periods.  These accounting records are then used to produce
+	  reports and charge fees to users.
+
+	  Say Y here if you want job level accounting to be compiled
+	  into the kernel.  Say M here if you want the writing of
+	  accounting records portion of this feature to be a loadable
+	  module.  Say N here if you do not want job level accounting
+	  (the default).
+	
+	  The CSA commands and scripts package needs to be installed
+	  to process the CSA accounting records.  See
+	  http://oss.sgi.com/projects/csa for further information
+	  about CSA and download instructions for the CSA commands
+	  package and documentation.
+
+
 config SYSCTL
 	bool "Sysctl support"
 	---help---
Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile	2004-08-16 09:55:20.000000000 -0500
+++ linux/kernel/Makefile	2004-08-16 09:59:30.000000000 -0500
@@ -20,6 +20,7 @@
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_PAGG) += pagg.o
 obj-$(CONFIG_PAGG_JOB) += job.o
+obj-$(CONFIG_CSA) += csa.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
Index: linux/kernel/csa.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/kernel/csa.c	2004-08-16 09:59:30.000000000 -0500
@@ -0,0 +1,1664 @@
+/*
+ * Copyright (c) 2000-2002 Silicon Graphics, Inc and LANL  All Rights Reserved.
+ * Copyright (c) 2004 Silicon Graphics, Inc All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information:  Silicon Graphics, Inc., 1500 Crittenden Lane,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ */
+
+/*
+ *  Description:
+ *	This file, csa.c, contains the procedures that handle kernel CSA
+ *	job accounting. It configures CSA, writes CSA accounting
+ *	records, and processes the acctctl /proc ioctl.  This code can
+ *	either be compiled directly into the kernel or compiled as
+ *	a loadable module.
+ *
+ *	During initialization, this code registers procedure callbacks
+ *	with the PAGG job code.
+ *
+ *  Author:
+ *	Marlys Kohnke (kohnke@sgi.com)
+ *
+ *  Contributors:
+ *
+ *  Changes:
+ *	January 31, 2001  (kohnke)  Changed to use semaphores rather than
+ *	spinlocks.  Was seeing a spinlock deadlock sometimes when an accounting
+ *	record was being written to disk with 2.4.0 (didn't happen with 
+ *	2.4.0-test7).
+ *
+ *	February 2, 2001  (kohnke)  Changed to handle being compiled directly
+ *	into the kernel, not just compiled as a loadable module. Renamed
+ *	init_module() as init_csa() and cleanup_module() as cleanup_csa().
+ *	Added calls to module_init() and module_exit().
+ *
+ *	January 21, 2003 (jlan)  Changed to provide /proc ioctl interface.
+ *	Also, provided MODULE_* clause.
+ */
+
+
+#include <linux/config.h>
+
+#if defined(CONFIG_CSA) || defined(CONFIG_CSA_MODULE)
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/file.h>
+#include <linux/utsname.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+
+#include <linux/csa_internal.h>
+#include <linux/csa.h>
+#include <linux/job.h>
+
+
+static int csa_registered = 0;
+
+MODULE_AUTHOR("Silicon Graphics, Inc.");
+MODULE_DESCRIPTION("CSA Kernel Module");
+MODULE_LICENSE("GPL");
+
+static int	csa_jstart(int, void *);
+static int	csa_jexit(int, void *);
+static void	csa_acct_eop(int, struct task_struct *);
+static int	csa_modify_buf(char *, struct acctcsa *, struct acctmem *,
+			struct acctio *, int, int);
+static int	csa_write(char *, int, int, uint64_t, int, struct job_csa *);
+static void	csa_config_make(ac_eventtype, struct acctcfg *);
+static int	csa_config_write(ac_eventtype,struct file *);
+static void	csa_header(struct achead *, int, int, int);
+static long int sc_CLK(long int);
+
+#define JID_ERR1 "do_csa_acct:  No job table entry for jid 0x%llx.\n"
+#define JID_ERR2 "csa user job accounting write error %d, jid 0x%llx\n"
+#define JID_ERR3 "Can't disable csa user job accounting jid 0x%llx\n"
+#define JID_ERR4 "csa user job accounting disabled, jid 0x%llx\n"
+
+/* #define CSA_DEBUG 0 */
+
+#ifdef CSA_DEBUG
+#define PRINTK(args...) printk(args)
+#else
+#define PRINTK(args...)
+#endif /* CSA_DEBUG */
+
+/* this defines can be removed once they're available in kernel header files */
+/* #define USEC_PER_SEC	1000000L */	/* number of usecs for 1 second */
+#define USEC_PER_TICK	(USEC_PER_SEC/HZ)
+#define NBPC		PAGE_SIZE 	/* Number of bytes per click */
+#define ctob(x) ((uint64_t)(x)*NBPC)
+
+
+static struct file	*csa_acctvp = (struct file *)NULL;
+static time_t boottime = 0;
+
+struct  timeval acct_now;               /* present time (sec, usec) */
+
+static DECLARE_MUTEX(csa_sem);
+static DECLARE_MUTEX(csa_write_sem);
+
+static int     csa_flag = 0;		/* accounting start state flag */
+char    csa_path[ACCT_PATH] = "";	/* current accounting file path name */
+char    new_path[ACCT_PATH] = "";	/* new accounting file path name */
+
+
+static struct job_acctmod csa_job_callbacks = {
+	.type =		JOB_ACCT_CSA,
+	.jobstart =	csa_jstart,
+	.jobend =	csa_jexit,
+	.module =	THIS_MODULE
+};
+
+
+/* modify this when changes are made to ac_kdrcd in csa.h */ 
+char *acct_dmd_name[ACCT_MAXKDS] = 
+		{"CSA",
+		 "JOB",
+		 "ASH",
+		 "NQS",
+		 "WORKLOAD MGMT",
+		 "TAPE",
+		 "DATA MIGRATION",
+		 "SOCKET",
+		 "SITE1",
+		 "SITE2" };
+
+typedef enum {
+        A_SYS,          /* system accounting action     (0) */
+        A_CJA,          /* Job accounting action        (1) */
+        A_DMD,          /* daemon accounting action     (2) */
+        A_MAX} a_fnc;
+
+struct  actstat acct_dmd[ACCT_MAXKDS][A_MAX];
+struct  actstat acct_rcd[ACCT_MAXRCDS-ACCT_RCDS][A_MAX];
+
+/*  Initialize the CSA accounting state information. */
+#define INIT_DMD(t, i, s, p)    acct_dmd[i][t].ac_ind = i;              \
+                                acct_dmd[i][t].ac_state = s;            \
+                                acct_dmd[i][t].ac_param = p;
+#define INIT_RCD(t, i, s, p)    acct_rcd[i-ACCT_RCDS][t].ac_ind = i;    \
+                                acct_rcd[i-ACCT_RCDS][t].ac_state = s;  \
+                                acct_rcd[i-ACCT_RCDS][t].ac_param = p;
+
+static int csa_ioctl( struct inode *, struct file *, unsigned int,
+		unsigned long);
+/* proc dir entry */
+struct proc_dir_entry *csa_proc_entry;
+
+/* file operations for proc file */
+static struct file_operations csa_file_ops = {
+	owner: THIS_MODULE,
+	ioctl: csa_ioctl
+};
+
+#ifdef DEBUG
+
+#define DBG_PRINTINIT(s)	\
+	char *dbg_fname = s		
+
+#define DBG_PRINTENTRY()					\
+do {								\
+	printk(KERN_DEBUG __FILE__ ": %s: entry\n", dbg_fname);	\
+} while(0)
+
+#define DBG_PRINTEXIT(c)				 		\
+do {							 		\
+	printk(KERN_DEBUG __FILE__ ": %s: exit, code = %d\n", dbg_fname, c);	\
+} while(0)
+
+/* write lock semaphore */
+#define JOB_WLOCK(l)					\
+do {							\
+	printk(KERN_DEBUG __FILE__ ": wlock = %p\n", l);	\
+	down_write(l);					\
+} while(0);
+
+/* write unlock semaphore */
+#define JOB_WUNLOCK(l)					\
+do {							\
+	printk(KERN_DEBUG __FILE__ ": wunlock = %p\n", l);	\
+	up_write(l);					\
+} while(0);
+
+/* read lock semaphore */
+#define JOB_RLOCK(l)					\
+do {							\
+	printk(KERN_DEBUG __FILE__ ": rlock = %p\n", l);	\
+	down_read(l);					\
+} while(0);
+
+/* read unlock semaphore */
+#define JOB_RUNLOCK(l)					\
+do {							\
+	printk(KERN_DEBUG __FILE__ ": runlock = %p\n", l);	\
+	up_read(l);					\
+} while(0);
+
+
+#else /* #ifdef DEBUG */
+
+#define DBG_PRINTINIT(s)	
+
+#define DBG_PRINTENTRY() 	\
+do {				\
+} while(0)
+
+#define DBG_PRINTEXIT(c)	\
+do {				\
+} while(0)
+
+/* write lock semaphore */
+#define JOB_WLOCK(l)	\
+do {			\
+	down_write(l);	\
+} while(0);
+
+/* write unlock semaphore */
+#define JOB_WUNLOCK(l)	\
+do {			\
+	up_write(l);	\
+} while(0);
+
+/* read lock semaphore */
+#define JOB_RLOCK(l)	\
+do {			\
+	down_read(l);	\
+} while(0);
+
+/* read unlock semaphore */
+#define JOB_RUNLOCK(l)	\
+do {			\
+	up_read(l);	\
+} while(0);
+
+
+#endif /* #ifdef DEBUG */
+
+
+
+/*
+ *	register procedure callbacks with the kernel/csa.c CSA
+ *	code and with the PAGG job code
+ */
+static int __init
+init_csa(void)
+{
+	int retval = 0;
+
+	if (csa_registered) {
+		/*
+		 *
+		 * incorrectly using csa_job_acct.c as a loadable module and
+		 * compiled into the kernel??
+		 */     
+		 printk(KERN_WARNING "init_csa: %s\n",
+			"Multiple attempts to register CSA support\n");
+		return -EBUSY;
+	} else {
+		csa_registered = 1;
+	}
+
+	/*
+	 * register callbacks with the PAGG job code to process 
+	 * start-of-job and end-of-job accounting records.  If this is a
+	 * module, this registration will also increment the job module
+	 * use count so the job module won't be unloaded out from under
+	 * the CSA module.
+	 */
+	retval = job_register_acct(&csa_job_callbacks);
+	if (retval != 0) {
+		printk(KERN_INFO "CSA: failed to register job\n");
+		return retval;
+	}
+
+	/* setup our /proc entry file */
+	csa_proc_entry = create_proc_entry(CSA_PROC, S_IFREG|S_IRUGO,
+				&proc_root);
+	if (!csa_proc_entry) {
+		csa_registered = 0;
+		job_unregister_acct(&csa_job_callbacks);
+		return -1;
+	}
+
+	csa_proc_entry->proc_fops = &csa_file_ops;
+	csa_proc_entry->proc_iops = NULL;
+
+	do_csa_acct = csa_acct_eop;
+
+	printk(KERN_INFO "CSA: initialized\n");
+
+	return retval;
+}
+
+
+/*
+ *	Do module cleanup before the module is removed; unregister
+ *	procedure callbacks with the kernel non-module CSA code and
+ *	with the PAGG job module (which decrements the job module use count).
+ */
+static void __exit
+cleanup_csa(void)
+{
+	int retval = 0;
+
+	csa_registered = 0;
+	do_csa_acct = NULL;
+
+	retval = job_unregister_acct(&csa_job_callbacks);
+	if (retval < 0) {
+		printk(KERN_ERR "CSA module can't unregister with job module."
+		       "Continuing with CSA module cleanup.\n");
+	} 
+	remove_proc_entry(CSA_PROC, &proc_root);
+	printk(KERN_INFO "CSA removed\n");
+	return;
+}
+
+/*
+ *	Initialize the CSA accounting state table.
+ *	Modify this when changes are made to ac_kdrcd in csa.h
+ *	
+ */
+static void
+csa_init_acct(int flag)
+{
+	csa_flag = flag;
+
+	boottime = xtime.tv_sec - (jiffies / HZ);
+
+	/*  Initialize system accounting states. */
+	INIT_DMD(A_SYS, ACCT_KERN_CSA,		ACS_OFF, 0);
+	INIT_DMD(A_SYS, ACCT_KERN_JOB_PROC,	ACS_OFF, 0);
+	INIT_DMD(A_SYS, ACCT_KERN_ASH,		ACS_OFF, 0);
+	INIT_DMD(A_SYS, ACCT_DMD_NQS,		ACS_OFF, 0);
+	INIT_DMD(A_SYS, ACCT_DMD_WKMG,		ACS_OFF, 0);
+	INIT_DMD(A_SYS, ACCT_DMD_TAPE,		ACS_OFF, 0);
+	INIT_DMD(A_SYS, ACCT_DMD_SOCKET,	ACS_OFF, 0);
+	INIT_DMD(A_SYS, ACCT_DMD_DMIG,		ACS_OFF, 0);
+	INIT_DMD(A_SYS, ACCT_DMD_SITE1,		ACS_OFF, 0);
+	INIT_DMD(A_SYS, ACCT_DMD_SITE2,		ACS_OFF, 0);
+
+	INIT_RCD(A_SYS, ACCT_RCD_MPPDET,	ACS_OFF, 0);
+	INIT_RCD(A_SYS, ACCT_RCD_MEM,		ACS_OFF, 0);
+	INIT_RCD(A_SYS, ACCT_RCD_IO,		ACS_OFF, 0);
+	INIT_RCD(A_SYS, ACCT_RCD_MT,		ACS_OFF, 0);
+	INIT_RCD(A_SYS, ACCT_RCD_MPP,		ACS_OFF, 0);
+	INIT_RCD(A_SYS, ACCT_THD_MEM,		ACS_OFF, 0);
+	INIT_RCD(A_SYS, ACCT_THD_TIME,		ACS_OFF, 0);
+	INIT_RCD(A_SYS, ACCT_RCD_INCACCT,	ACS_OFF, 0);
+	INIT_RCD(A_SYS, ACCT_RCD_APPACCT,	ACS_OFF, 0);
+	INIT_RCD(A_SYS, ACCT_RCD_SITE1,		ACS_OFF, 0);
+	INIT_RCD(A_SYS, ACCT_RCD_SITE2,		ACS_OFF, 0);
+
+	return;
+}
+
+/*
+ *	convert ticks into microseconds; necessary kernel math ops not
+ *	available on 32-bit systems, so can't use uint64_t
+ */
+static long int
+sc_CLK(long int clock)
+{
+	long int sec, split;
+
+	sec = clock / HZ;
+	split = (clock % HZ) * 1000000 / HZ;
+
+	return ((sec * 1000000) + split);
+}
+
+/*  Initialize CSA accounting header. */
+static void
+csa_header(struct achead *head, int revision, int type, int size)
+{
+	head->ah_magic = ACCT_MAGIC;
+	head->ah_revision = revision;
+	head->ah_type = type;
+	head->ah_flag = 0;
+	head->ah_size = size;
+
+	return;
+}
+
+/*
+ *  Create a CSA end-of-process accounting record and write it to 
+ *  appropriate file(s)
+ */
+void
+csa_acct_eop(int exitcode, struct task_struct *p)
+{
+	char	acctent[sizeof(struct acctcsa) +
+			sizeof(struct acctmem) +
+			sizeof(struct acctio) ];
+	char	modacctent[sizeof(struct acctcsa) +
+			   sizeof(struct acctmem) +
+			   sizeof(struct acctio) ];
+	struct	acctcsa	*csa = NULL;
+	struct  acctmem *mem = NULL;
+	struct  acctio  *io = NULL;
+	struct	achead	*hdr1, *hdr2;
+	char	*cb = acctent;
+	struct job_csa job_acctbuf;
+	uint64_t jid = 0;
+	int	len = 0;
+	int	csa_enabled = 0;
+	int	ja_enabled = 0;
+	int	io_enabled = 0;
+	int	mem_enabled = 0;
+	int	retval = 0;
+	uint64_t memtime;
+
+	if (p == NULL) {
+		printk(KERN_ERR "do_csa_acct: CSA null task pointer\n");
+		return;
+	}
+	jid = job_getjid(p);
+	if (jid <= 0) {
+		/* no job table entry; not all processes are part of a job */
+		return;
+	}
+	memset(&job_acctbuf, 0, sizeof(job_acctbuf));
+	retval = job_getacct(jid, JOB_ACCT_CSA, &job_acctbuf);
+	if (retval != 0) {
+		/* couldn't get accounting info stored in the job table entry */
+		printk(KERN_WARNING JID_ERR1, (unsigned long long) jid);
+		return;
+	}
+
+	down(&csa_sem);
+	/*
+	 * figure out what's turned on, which determines which record types
+	 * need to be written.  All records are written to a user job
+	 * accounting file.  Only those record types configured on are
+	 * written to the system pacct file
+	 */
+	if (job_acctbuf.job_acctfile != (struct file *)NULL) {
+		ja_enabled = 1;
+	}
+        if (acct_dmd[ACCT_KERN_CSA][A_SYS].ac_state == ACS_ON) {
+		csa_enabled = 1;
+	}
+        if (acct_rcd[ACCT_RCD_IO-ACCT_RCDS][A_SYS].ac_state == ACS_ON) {
+		io_enabled = 1;
+	}
+        if (acct_rcd[ACCT_RCD_MEM-ACCT_RCDS][A_SYS].ac_state == ACS_ON) {
+		mem_enabled = 1;
+	}
+
+	if (!ja_enabled && !csa_enabled) {
+		/* nothing to do */
+		up(&csa_sem);
+		return;
+	}
+	up(&csa_sem);
+
+	csa = (struct acctcsa *)acctent;
+	memset(csa, 0, sizeof(struct acctcsa));
+	hdr1 = &csa->ac_hdr1;
+	csa_header(hdr1, REV_CSA, ACCT_KERNEL_CSA, sizeof(struct acctcsa) );
+	hdr2 = &csa->ac_hdr2;
+	csa_header(hdr2, REV_CSA, ACCT_KERNEL_CSA, 0 );
+	hdr2->ah_magic = ~ACCT_MAGIC;
+ 
+	csa->ac_stat = exitcode;
+	csa->ac_uid  = p->uid;
+	csa->ac_gid  = p->gid;
+
+	/* XXX change this when array session handle info available */
+	csa->ac_ash  = 0;
+	csa->ac_jid  = job_acctbuf.job_id;
+	/* XXX change this when project ids are available */
+	csa->ac_prid = 0;
+	csa->ac_nice = task_nice(p);
+	csa->ac_sched = p->policy;
+
+	csa->ac_pid  = p->pid;
+	csa->ac_ppid = (p->parent) ? p->parent->pid : 0;
+	if (p->flags & PF_FORKNOEXEC) {
+		csa->ac_hdr1.ah_flag |= AFORK;
+	}
+	if (p->flags & PF_SUPERPRIV) {
+		csa->ac_hdr1.ah_flag |= ASU;
+	}
+	if (p->flags & PF_DUMPCORE) {
+		csa->ac_hdr1.ah_flag |= ACORE;
+	}
+	if (p->flags & PF_SIGNALED) {
+		csa->ac_hdr1.ah_flag |= AXSIG;
+	}
+	csa->ac_hdr1.ah_flag &= ~ACKPT;
+
+	strncpy(csa->ac_comm, p->comm, sizeof(csa->ac_comm));
+/*	csa->ac_btime = CT_TO_SECS(p->start_time) + (xtime.tv_sec -
+		(jiffies / HZ)); */
+        csa->ac_btime = do_div(p->start_time, HZ) + (xtime.tv_sec -  (jiffies / HZ));
+
+	/*
+	 * cpu usage is accumulated by the kernel in ticks. 
+	 * convert from clock ticks to microseconds; each process gets
+	 * a minimum of a tick for elapsed time.  If the granularity
+	 * changes to something finer than a tick in the future,
+	 * then these zero cpu and elapsed time modifications should be 
+	 * looked at again.
+	 */
+	csa->ac_etime = (jiffies - p->start_time == 0) ? (USEC_PER_TICK) : 
+		((uint64_t)(jiffies - p->start_time) * USEC_PER_TICK);
+
+	cb += sizeof(struct acctcsa);
+	len += sizeof(struct acctcsa);
+
+	/* convert from ticks to microseconds */
+	csa->ac_utime = p->utime * USEC_PER_TICK;
+	csa->ac_stime = p->stime * USEC_PER_TICK;
+	/* Each process gets a minimum of a half tick cpu time */
+	if ((csa->ac_utime == 0) && (csa->ac_stime == 0)) {
+		csa->ac_stime = USEC_PER_TICK/2;
+	}
+
+	/*   Create the memory record if needed */
+	if (ja_enabled || mem_enabled) {
+		mem = (struct acctmem *)cb;
+		memset(mem, 0, sizeof(struct acctmem));
+		hdr1->ah_flag |= AMORE;
+		hdr2->ah_type |= ACCT_MEM;
+		hdr1 = &mem->ac_hdr;
+		csa_header(hdr1, REV_MEM, ACCT_KERNEL_MEM,
+			sizeof(struct acctmem) );
+
+		/* adjust from pages/ticks to Mb/usec */
+		memtime = sc_CLK((long int)p->csa_rss_mem1);
+		mem->ac_core.mem1 = ctob(memtime) / (1024 * 1024);
+		memtime = sc_CLK((long int)p->csa_vm_mem1);
+		mem->ac_virt.mem1 = ctob(memtime) / (1024 * 1024);
+
+		/* adjust page size to 1K units */
+		if (p->mm) {
+		    mem->ac_virt.himem = p->mm->hiwater_vm * (PAGE_SIZE / 1024);
+		    mem->ac_core.himem = p->mm->hiwater_rss * (PAGE_SIZE/1024);
+		    /*
+		     * For processes with zero systime, set the integral
+		     * to the highwater mark rather than leave at zero
+		     */
+		    if (mem->ac_core.mem1 == 0) {
+			mem->ac_core.mem1 = mem->ac_core.himem / 1024;
+		    }
+		    if (mem->ac_virt.mem1 == 0) {
+			mem->ac_virt.mem1 = mem->ac_virt.himem / 1024;
+		    }
+		}
+
+		mem->ac_minflt = p->min_flt;
+		mem->ac_majflt = p->maj_flt;
+
+		cb += sizeof(struct acctmem);
+		hdr2->ah_size += sizeof(struct acctmem);
+		len += sizeof(struct acctmem);
+	}
+	/*  Create the I/O record */
+	if (ja_enabled || io_enabled) {
+		io = (struct acctio *)cb;
+		memset(io, 0, sizeof(struct acctio));	
+		hdr1->ah_flag |= AMORE;
+		hdr2->ah_type |= ACCT_IO;
+		hdr1 = &io->ac_hdr;
+		csa_header(hdr1, REV_IO, ACCT_KERNEL_IO,
+			sizeof(struct acctio) );
+
+		/* convert from ticks to microseconds */
+		/* XXX when able to do kernel 64 bit divide, change type */
+		PRINTK(KERN_INFO "CSA: block wait time %lu\n",(unsigned long int)p->bwtime);
+		io->ac_bwtime = CT_TO_USECS((unsigned long int)p->bwtime);
+		PRINTK(KERN_INFO "CSA: converted bwtime %lu\n",io->ac_bwtime);
+
+		io->ac_bkr = p->rblk;
+		io->ac_bkw = p->wblk;
+
+		/* raw wait time; currently not used */
+		io->ac_rwtime = 0;
+
+		io->ac_chr = p->rchar;
+		io->ac_chw = p->wchar;
+		io->ac_scr  = p->syscr;
+		io->ac_scw  = p->syscw;
+
+		cb += sizeof(struct acctio);
+		hdr2->ah_size += sizeof(struct acctio);
+		len += sizeof(struct acctio);
+	}
+
+	/* record always written to a user job accounting file */
+	if ((len > 0) && (job_acctbuf.job_acctfile != (struct file *)NULL) ) {
+		csa_write((caddr_t)&acctent, ACCT_KERN_CSA,
+			len, jid, A_CJA, &job_acctbuf);
+	}
+	/*
+	 * check the cpu time and virtual memory thresholds before writing
+	 * this record to the system pacct file
+	 */
+	if ((acct_rcd[ACCT_THD_MEM-ACCT_RCDS][A_SYS].ac_state == ACS_ON) &&
+	    (ja_enabled || mem_enabled)) {
+		if (mem->ac_virt.himem < 
+	            acct_rcd[ACCT_THD_MEM-ACCT_RCDS][A_SYS].ac_param) {
+			/* don't write record to pacct */
+			return;
+		}
+	}
+	if ((acct_rcd[ACCT_THD_TIME-ACCT_RCDS][A_SYS].ac_state == ACS_ON)) {
+	     if ((csa->ac_utime + csa->ac_stime) <
+	          acct_rcd[ACCT_THD_TIME-ACCT_RCDS][A_SYS].ac_param) {
+			/* don't write record to pacct */
+			return;
+	     }
+	}
+				
+	if ((len > 0) && (csa_acctvp != (struct file *)NULL) && csa_enabled ) {
+		if (io_enabled && mem_enabled) {
+			/* write out buffer as is to system pacct file */
+			csa_write((caddr_t)&acctent, ACCT_KERN_CSA,
+				len, jid, A_SYS, &job_acctbuf);
+		} else {
+			/* only write out record types turned on */
+			len = csa_modify_buf(modacctent, csa, mem, io,
+				io_enabled, mem_enabled);
+			csa_write((caddr_t)&modacctent, ACCT_KERN_CSA,
+				len, jid, A_SYS, &job_acctbuf);
+		}
+	}
+	return;
+}
+
+/*
+ *	Copy needed accounting records into buffer, skipping record
+ *	types which are not enabled.  May need to adjust downward
+ *	the second header size if not both memory and io continuation
+ *	records are written, plus adjust the second header types and
+ * 	first header flags.
+ */
+static int
+csa_modify_buf(char *modacctent, struct acctcsa *csa, struct acctmem *mem,
+	       struct acctio *io, int io_enabled, int mem_enabled)
+{
+	int size = 0;
+	int len = 0;
+	char *bufptr;
+	struct achead *hdr1, *hdr2;
+
+	size = sizeof(struct acctcsa) + sizeof(struct acctmem) +
+		sizeof(struct acctio);
+	memset(modacctent, 0, size);
+	bufptr = modacctent;
+	/*
+	 * adjust values that might not be correct anymore if all of
+	 * the continuation records aren't written out to the pacct file
+	 */
+	hdr1 = &csa->ac_hdr1;
+	hdr2 = &csa->ac_hdr2;
+	hdr1->ah_flag &= ~AMORE;
+	hdr2->ah_type = ACCT_KERNEL_CSA;
+	hdr2->ah_size = 0;
+	if (mem_enabled) {
+		hdr1->ah_flag |= AMORE;
+		hdr2->ah_type |= ACCT_MEM;
+		hdr2->ah_size += sizeof(struct acctmem);
+		hdr1 = &mem->ac_hdr;
+		hdr1->ah_flag &= ~AMORE;
+	}
+	if (io_enabled) {
+		hdr1->ah_flag |= AMORE;
+		hdr2->ah_type |= ACCT_IO;
+		hdr2->ah_size += sizeof(struct acctio);
+		hdr1 = &io->ac_hdr;
+		hdr1->ah_flag &= ~AMORE;
+	}	
+	memcpy(bufptr, csa, sizeof(struct acctcsa));
+	bufptr += sizeof(struct acctcsa);
+	len += sizeof(struct acctcsa);
+
+	if (mem_enabled) {
+		memcpy(bufptr, mem, sizeof(struct acctmem));
+		len += sizeof(struct acctmem);
+		bufptr += sizeof(struct acctmem);
+	}
+	if(io_enabled) {
+		memcpy(bufptr, io, sizeof(struct acctio));
+		len += sizeof(struct acctio);
+	}
+
+	return len;
+}
+
+
+/*
+ * csa_ioctl
+ *
+ */
+static int
+csa_ioctl(
+	struct inode *inode,
+	struct file *file,
+	unsigned int req,
+	unsigned long data)
+{
+	struct	actctl	actctl;
+	struct	actstat	actstat;
+
+	int	daemon = 0;
+	int	error = 0;
+	int	err = 0;
+	static	int	flag = 010000;
+	int	ind;
+	int	id;
+	int	len;
+	int	num;
+
+	PRINTK(KERN_INFO "CSA: csa_ioctl\n");
+	down(&csa_sem);
+	if (!csa_flag) {
+		csa_init_acct(flag++);
+	}
+	up(&csa_sem);
+
+	if ((req < 0) || (req >= AC_MREQ) ) {
+		return -EINVAL;
+	}
+
+	memset(&actctl, 0, sizeof(struct actctl));
+	memset(&actstat, 0, sizeof(struct actstat));
+
+	switch (req) {
+	/*
+	 *  Start specified types of accounting.
+	 */
+	case AC_START:
+	    {
+		int id, ind;
+		struct file *newvp;
+
+		PRINTK(KERN_INFO "CSA: AC_START\n");
+		if (!capable(CAP_SYS_PACCT) ) {
+			error = -EPERM;
+			break;
+		}
+
+		if (copy_from_user(&actctl, (void*)data, sizeof(int)) ) {
+			error = -EFAULT;
+			break;
+		}
+
+		num = (actctl.ac_sttnum == 0) ? 1 : actctl.ac_sttnum;
+		if ((num < 0) || (num > NUM_KDRCDS) ) {
+			error = -EINVAL;
+			break;
+
+		}
+
+		len = sizeof(struct actctl) -
+		    sizeof(struct actstat) * NUM_KDRCDS + 
+		    sizeof(struct actstat) * num;
+		if (copy_from_user(&actctl, (void*)data, len)) {
+			error = -EFAULT;
+			break;
+		}
+		/*
+		 *	Verify all indexes in actstat structures specified.
+	 	 */
+		for(ind = 0; ind < num; ind++) {
+			id = actctl.ac_stat[ind].ac_ind;
+			if ((id < 0) || (id >= ACCT_MAXRCDS) ) {
+				error = -EINVAL;
+				break;
+			}
+
+			if (id == ACCT_MAXKDS) {
+				error = -EINVAL;
+				break;
+			}
+		}
+		down(&csa_sem);
+		/*
+		 *	If an accounting file was specified, make sure
+		 *	that we can access it.
+		 */
+		if (strlen(actctl.ac_path) ) {
+			strncpy(new_path, actctl.ac_path, ACCT_PATH);
+			newvp = filp_open(new_path,O_WRONLY|O_APPEND, 0);
+			if (IS_ERR(newvp)) {
+				error = PTR_ERR(newvp);
+				up(&csa_sem);
+				break;
+			} else if (!S_ISREG(newvp->f_dentry->d_inode->i_mode)) {
+				error = -EACCES;
+				filp_close(newvp, NULL);
+				up(&csa_sem);
+				break;
+			} else if (!newvp->f_op->write) {
+				error = -EIO;
+				filp_close(newvp, NULL);
+				up(&csa_sem);
+				break;
+			}
+			if ((csa_acctvp != (struct file *)NULL) &&
+					csa_acctvp == newvp) {
+				/*
+				 * this file already being used, so ignore
+				 * request to use this file; just continue on
+				 */
+				filp_close(newvp, NULL);
+				newvp = (struct file *)NULL;
+			}
+
+		} else {
+			newvp = (struct file *)NULL;
+		}
+		/*
+		 *	If a new accounting file was specified and there's
+		 *	an old accounting file, stop writing to it.
+		 */
+		if (newvp != (struct file *)NULL) {
+			if (csa_acctvp != (struct file *)NULL) {
+				error = csa_config_write(AC_CONFCHG_FILE,NULL);
+				filp_close(csa_acctvp, NULL);
+			} else if (!csa_flag) {
+				csa_init_acct(flag++);
+			}
+
+			strncpy(csa_path, new_path, ACCT_PATH);
+			down(&csa_write_sem);
+			csa_acctvp = newvp;
+			up(&csa_write_sem);
+
+		} else {
+			if (csa_acctvp == (struct file *)NULL) {
+				error = -EINVAL;
+				up(&csa_sem);
+				break;
+			}
+		}
+
+		/*
+		 *  Loop through each actstat block and turn ON that accounting.
+		 */
+		for(ind = 0; ind < num; ind++) {
+			struct	actstat	*stat;
+
+			id = actctl.ac_stat[ind].ac_ind;
+			stat = &actctl.ac_stat[ind];
+			if (id < ACCT_RCDS)  {
+				acct_dmd[id][A_SYS].ac_state = ACS_ON;
+				acct_dmd[id][A_SYS].ac_param = stat->ac_param;
+
+				stat->ac_state = acct_dmd[id][A_SYS].ac_state;
+				stat->ac_param = acct_dmd[id][A_SYS].ac_param;
+			} else {
+				int	tid = id -ACCT_RCDS;
+
+				acct_rcd[tid][A_SYS].ac_state = ACS_ON;
+				acct_rcd[tid][A_SYS].ac_param = stat->ac_param;
+
+				stat->ac_state = acct_rcd[tid][A_SYS].ac_state;
+				stat->ac_param = acct_rcd[tid][A_SYS].ac_param;
+			}
+		}
+
+		up(&csa_sem);
+		error = csa_config_write(AC_CONFCHG_ON, NULL);
+		/*
+		 *  Return the accounting states to the user.
+	 	 */
+		if (copy_to_user((void*)data, &actctl, len)) {
+			error = -EFAULT;
+			break;
+		}
+	    }
+	    break;
+
+	/*
+	 *  Stop specified types of accounting.
+	 */
+	case AC_STOP:
+	    {
+		int	id, ind;
+
+		PRINTK(KERN_INFO "CSA: AC_STOP\n");
+		if (!capable(CAP_SYS_PACCT) ) {
+			error = -EPERM;
+			break;
+		}
+
+		if (copy_from_user(&actctl, (void*)data, sizeof(int)) ) {
+			error = -EFAULT;
+			break;
+		}
+
+		num = (actctl.ac_sttnum == 0) ? 1 : actctl.ac_sttnum;
+		if ((num <= 0) || (num > NUM_KDRCDS) ) {
+			error = -EINVAL;
+			break;
+		}
+
+		len = sizeof(struct actctl) -
+		    sizeof(struct actstat) * NUM_KDRCDS + 
+		    sizeof(struct actstat) * num;
+		if (copy_from_user(&actctl, (void*)data, len)) {
+			error = -EFAULT;
+			break;
+		}
+
+		/*
+		 *  Verify all of the indexes in actstat structures specified.
+	 	 */
+		for(ind = 0; ind < num; ind++) {
+			id = actctl.ac_stat[ind].ac_ind;
+			if ((id < 0) || (id >= NUM_KDRCDS) ) {
+				error = -EINVAL;
+				break;
+			}
+		}
+
+		/*
+		 * Loop through each actstat block and turn off that accounting.
+		 */
+		down(&csa_sem);
+		/*
+		 *	Disable accounting for this entry.
+		 */
+		for(ind = 0; ind < num; ind++) {
+			id = actctl.ac_stat[ind].ac_ind;
+			if (id < ACCT_RCDS) {
+				acct_dmd[id][A_SYS].ac_state = ACS_OFF;
+				acct_dmd[id][A_SYS].ac_param = 0;
+
+				actctl.ac_stat[ind].ac_state =
+					acct_dmd[id][A_SYS].ac_state;
+				actctl.ac_stat[ind].ac_param = 0;
+			} else {
+				int	tid = id -ACCT_RCDS;
+
+				acct_rcd[tid][A_SYS].ac_state = ACS_OFF;
+				acct_rcd[tid][A_SYS].ac_param = 0;
+				actctl.ac_stat[ind].ac_state =
+					acct_rcd[tid][A_SYS].ac_state;
+				actctl.ac_stat[ind].ac_param = 
+					acct_rcd[tid][A_SYS].ac_param;
+			}
+		}		/* end of for(ind) */
+		/*
+		 *  Check the daemons to see if any are still on.
+	 	 */
+		for(ind = 0; ind < ACCT_MAXKDS; ind++) {
+			if (acct_dmd[ind][A_SYS].ac_state == ACS_ON) {
+				daemon += 1<<ind;
+			}
+		}
+		up(&csa_sem);
+		/*
+		 *  If all daemons are off and there's an old accounting file,
+		 *	stop writing to it.
+	 	*/
+		if (!daemon && (csa_acctvp != (struct file *)NULL) ) {
+			error = csa_config_write(AC_CONFCHG_OFF,NULL);
+			filp_close(csa_acctvp, NULL);
+			down(&csa_write_sem);
+			csa_acctvp = (struct file *)NULL;
+			up(&csa_write_sem);
+		} else {
+			error = csa_config_write(AC_CONFCHG_OFF, NULL);
+		}
+		/*
+		 *  Return the accounting states to the user.
+	 	*/
+		if (copy_to_user((void*)data, &actctl, len)) {
+			error = -EFAULT;
+			break;
+		}
+	    }
+	    break;
+
+	/*
+	 *  Halt all accounting.
+	 */
+	case AC_HALT:
+	    {
+		int	ind;
+
+		PRINTK(KERN_INFO "CSA: AC_HALT\n");
+		if (!capable(CAP_SYS_PACCT) ) {
+			error = -EPERM;
+			break;
+		}
+		down(&csa_sem);
+	 	/*  Turn off all accounting if any is on. */
+		for(ind = 0; ind <ACCT_MAXKDS; ind++) {
+			acct_dmd[ind][A_SYS].ac_state = ACS_OFF;
+			acct_dmd[ind][A_SYS].ac_param = 0;
+		}
+
+		for(ind = ACCT_RCDS; ind < ACCT_MAXRCDS; ind++) {
+			int	tid = ind -ACCT_RCDS;
+
+			acct_rcd[tid][A_SYS].ac_state = ACS_OFF;
+			acct_rcd[tid][A_SYS].ac_param = 0;
+		}
+ 
+		up(&csa_sem);
+	 	/*  If there's an old accounting file, stop writing to it. */
+		if (csa_acctvp != (struct file *)NULL) {
+			error = csa_config_write(AC_CONFCHG_OFF,NULL);
+			filp_close(csa_acctvp, NULL);
+			down(&csa_write_sem);
+			csa_acctvp = (struct file *)NULL;
+			up(&csa_write_sem);
+		}
+	    }
+	    break;
+
+	/*
+	 * Process daemon/record status function.
+	 */
+	case AC_CHECK:
+	    {
+		PRINTK(KERN_INFO "CSA: AC_CHECK\n");
+		if (copy_from_user(&actstat, (void*)data, sizeof(struct actstat)) ) {
+			error = -EFAULT;
+			break;
+		}
+		id = actstat.ac_ind;
+		if ((id >= 0) && (id < ACCT_MAXKDS) ) {
+			actstat.ac_state = acct_dmd[id][A_SYS].ac_state;
+			actstat.ac_param = acct_dmd[id][A_SYS].ac_param;
+
+		} else if ((id >= ACCT_RCDS) && (id < ACCT_MAXRCDS) ) {
+			int	tid = id-ACCT_RCDS;
+
+			actstat.ac_state = acct_rcd[tid][A_SYS].ac_state;
+			actstat.ac_param = acct_rcd[tid][A_SYS].ac_param;
+
+		} else {
+			error = -EINVAL;
+			break;
+		}
+		if (copy_to_user((void*)data, &actstat, sizeof(struct actstat)) ) {
+			error = -EFAULT;
+		}
+	    }
+		break;
+
+	/*
+	 *  Process daemon status function.
+	 */
+	case AC_KDSTAT:
+	    {
+		PRINTK(KERN_INFO "CSA: AC_KDSTAT\n");
+		if (copy_from_user(&actctl, (void*)data, sizeof(int)) ) {
+			error = -EFAULT;
+			break;
+		}
+
+		num = actctl.ac_sttnum;
+
+		if (num <= 0) {
+			error = EINVAL;
+			break;
+		} else if (num > NUM_KDS) {
+			num = NUM_KDS;
+		}
+		for(ind = 0; ind < num; ind++) {
+			actctl.ac_stat[ind].ac_ind   =
+				acct_dmd[ind][A_SYS].ac_ind;
+			actctl.ac_stat[ind].ac_state =
+				acct_dmd[ind][A_SYS].ac_state;
+			actctl.ac_stat[ind].ac_param =
+				acct_dmd[ind][A_SYS].ac_param;
+		}		/* end of for(ind) */
+		actctl.ac_sttnum = num;
+		strncpy(actctl.ac_path, csa_path, ACCT_PATH);
+
+		len = sizeof(struct actctl) -
+		    sizeof(struct actstat) * NUM_KDRCDS + 
+		    sizeof(struct actstat) * num;
+		if (copy_to_user((void*)data, &actctl, len)) {
+			error = -EFAULT;
+			break;
+		}
+	    }
+	    break;
+
+	/*
+	 *  Process record status function.
+	 */
+	case AC_RCDSTAT:
+	    {
+		PRINTK(KERN_INFO "CSA: AC_RCDSTAT\n");
+		if (copy_from_user(&actctl, (void*)data, sizeof(int)) ) {
+			error = -EFAULT;
+			break;
+		}
+		num = actctl.ac_sttnum;
+
+		if (num <= 0) {
+			error = -EINVAL;
+			break;
+		} else if (num > NUM_RCDS) {
+			num = NUM_RCDS;
+		}
+		for(ind = 0; ind < num; ind++) {
+			actctl.ac_stat[ind].ac_ind =
+				acct_rcd[ind][A_SYS].ac_ind;
+			actctl.ac_stat[ind].ac_state =
+				acct_rcd[ind][A_SYS].ac_state;
+			actctl.ac_stat[ind].ac_param =
+				acct_rcd[ind][A_SYS].ac_param;
+		}
+		actctl.ac_sttnum = num;
+		strncpy(actctl.ac_path, csa_path, ACCT_PATH);
+		len = sizeof(struct actctl) -
+		    sizeof(struct actstat) * NUM_KDRCDS + 
+		    sizeof(struct actstat) * num;
+		if (copy_to_user((void*)data, &actctl, len)) {
+			error = -EFAULT;
+			break;
+		}
+	    }
+	    break;
+
+	/*
+	 *  Turn user job accounting ON or OFF.
+	 */
+	case AC_JASTART:
+	case AC_JASTOP:	
+	    {
+		char	localpath[ACCT_PATH];
+		struct	file	*newvp = NULL;
+		struct	file	*oldvp;
+		uint64_t	jid;
+		struct job_csa job_acctbuf;
+		int retval = 0;
+
+		if (req == AC_JASTART)
+			PRINTK(KERN_INFO "CSA: AC_JASTART\n");
+		else
+			PRINTK(KERN_INFO "CSA: AC_JASTOP\n");
+		len = sizeof(struct actctl) -
+		    sizeof(struct actstat) * (NUM_KDRCDS -1);
+		if (copy_from_user(&actctl, (void*)data, len)) {
+			error = -EFAULT;
+			break;
+		}
+		/*
+		 * If an accounting file was specified, make sure
+		 * that we can access it.
+		 */
+		if (strlen(actctl.ac_path)) {
+			strncpy(localpath, actctl.ac_path, ACCT_PATH);
+			newvp = filp_open(localpath,O_WRONLY|O_APPEND,0);
+			if (IS_ERR(newvp)) {
+				error = PTR_ERR(newvp);
+				break;
+			} else if (!S_ISREG(newvp->f_dentry->d_inode->i_mode)) {
+				error = -EACCES;
+				filp_close(newvp, NULL);
+				break;
+			} else if (!newvp->f_op->write) {
+				error = -EIO;
+				filp_close(newvp, NULL);
+				break;
+			}
+		} else if (req == AC_JASTART) {
+			error = -EINVAL;
+			break;
+		}
+		if (req == AC_JASTOP) {
+			newvp = (struct file *)NULL;
+		}
+		jid = job_getjid(current);
+		if (jid <= 0) {
+			/* no job table entry */
+			error = -ENOENT;
+			break;
+		}
+		memset(&job_acctbuf, 0, sizeof(job_acctbuf));
+		retval = job_getacct(jid, JOB_ACCT_CSA, &job_acctbuf);
+		if (retval != 0) {
+			/* couldn't get csa info in the job table entry */
+			error = retval;
+			break;
+		}
+		/* Use this semaphore since csa_write() can also change this
+		 * file pointer.
+		 */
+		down(&csa_write_sem);
+		if ((oldvp = job_acctbuf.job_acctfile) != (struct file *)NULL) {
+			/* Stop writing to the old job accounting file */
+			filp_close(oldvp, NULL);
+		}
+
+	 	/* Establish new job accounting file or stop job accounting */
+		job_acctbuf.job_acctfile = newvp;
+
+		retval = job_setacct(jid, JOB_ACCT_CSA, JOB_CSA_ACCTFILE,
+			&job_acctbuf);
+		if (retval != 0) {
+			/* couldn't set the new file name in the job entry */
+			error = retval;
+			up(&csa_write_sem);
+			break;
+		}
+		up(&csa_write_sem);
+		/* Write a config record so ja has uname info */
+		if (req == AC_JASTART) {
+			error = csa_config_write(AC_CONFCHG_ON,
+				 job_acctbuf.job_acctfile);
+		}
+	    }
+	    break;
+
+	/*
+	 *  Write an accounting record for a system daemon.
+	 */
+	case AC_WRACCT:
+	    {
+		int	len;
+		int retval = 0;
+		uint64_t	jid;
+		struct job_csa job_acctbuf;
+		struct	actwra	actwra;
+
+		PRINTK(KERN_INFO "CSA: AC_WRACCT\n");
+		if (!capable(CAP_SYS_PACCT) ) {
+			error = -EPERM;
+			break;
+		}
+		if (copy_from_user(&actwra, (void*)data, sizeof(struct actwra))) {
+			error = -EFAULT;
+			break;
+		}
+	 	/*  Verify the parameters. */
+		jid = actwra.ac_jid;
+		if (jid < 0) {
+			error = -EINVAL;
+			break;
+		}
+
+		id = actwra.ac_did;
+		if ((id < 0) || (id >= ACCT_MAXKDS) ) {
+			error = -EINVAL;
+			break;
+		}
+
+		len = actwra.ac_len;
+		if ((len <= 0) || (len > MAX_WRACCT) ) {
+			error = -EINVAL;
+			break;
+		}
+
+		if (actwra.ac_buf == (char *)NULL) {
+			error = -EINVAL;
+			break;
+		}
+
+		/*  If the daemon type is on, write out the daemon buffer. */
+		if ((acct_dmd[id][A_SYS].ac_state == ACS_ON) &&
+				(csa_acctvp != (struct file *)NULL) ) {
+			error = csa_write(actwra.ac_buf, id, len,
+				jid, A_DMD, NULL);
+		}
+
+		/* get the job table entry for this jid */
+		memset(&job_acctbuf, 0, sizeof(job_acctbuf));
+		retval = job_getacct(jid, JOB_ACCT_CSA, &job_acctbuf);
+		if (retval != 0) {
+			/* couldn't get accounting info stored in job table */
+			error = retval;
+			break;
+		}
+
+		/* maybe write out daemon record to ja user accounting file */
+		if (job_acctbuf.job_acctfile != NULL) {
+			error = csa_write(actwra.ac_buf, id, len, jid, A_CJA,
+					&job_acctbuf);
+		}
+	    }
+	    break;
+
+	/*
+	 *  Return authorized state information.
+	 */
+	case AC_AUTH:
+	    {
+		PRINTK(KERN_INFO "CSA: AC_AUTH\n");
+		if (!capable(CAP_SYS_PACCT) ) {
+			error = -EPERM;
+			break;
+		}
+		/*
+		 *  Process user authorization request...If we get to this spot,
+		 *  the user is authorized.
+		 */
+	    }
+	    break;
+
+	/*
+	 *  Process the incremental accounting request.
+	 */
+	case AC_INCACCT:
+		PRINTK(KERN_INFO "CSA: AC_INCACCT\n");
+                error = -EINVAL;
+		break;
+
+	default:
+		PRINTK(KERN_INFO "CSA: Unknown request %d\n", req);
+		error = -EINVAL;
+
+	}  /* end of switch(req) */
+
+	return(error ? error : err);
+}
+
+
+/*
+ *	Create a configuration change accounting record.
+ */
+static void
+csa_config_make(ac_eventtype event, struct acctcfg *cfg)
+{
+	int	daemon = 0;
+	int	record = 0;
+	int	ind;
+	int	nmsize = 0;
+
+	memset(cfg, 0, sizeof(struct acctcfg));
+	/*  Setup the record and header. */
+	csa_header(&cfg->ac_hdr, REV_CFG, ACCT_KERNEL_CFG,
+		sizeof(struct acctcfg) );
+	cfg->ac_event = event;
+	if (!boottime) {
+		boottime = xtime.tv_sec - (jiffies / HZ);
+	}
+	cfg->ac_boottime = boottime;
+	cfg->ac_curtime  = xtime.tv_sec;
+
+	/*
+	 *  Create the masks of the types that are on.
+	 */
+	for(ind = 0; ind < ACCT_MAXKDS; ind++) {
+		if (acct_dmd[ind][A_SYS].ac_state == ACS_ON) {
+			daemon += 1<<ind;
+		}
+	}
+	for(ind = ACCT_RCDS; ind < ACCT_MAXRCDS; ind++) {
+		int	tid = ind -ACCT_RCDS;
+
+		if (acct_rcd[tid][A_SYS].ac_state == ACS_ON) {
+			record += 1<<tid;
+		}
+	}
+	cfg->ac_kdmask = daemon;
+	cfg->ac_rmask = record;
+
+	nmsize = sizeof(cfg->ac_uname.sysname);
+	memcpy(cfg->ac_uname.sysname, system_utsname.sysname, nmsize-1);
+	cfg->ac_uname.sysname[nmsize-1] = '\0';
+	nmsize = sizeof(cfg->ac_uname.nodename);
+	memcpy(cfg->ac_uname.nodename, system_utsname.nodename, nmsize-1);
+	cfg->ac_uname.nodename[nmsize-1] = '\0';
+	nmsize = sizeof(cfg->ac_uname.release);
+	memcpy(cfg->ac_uname.release, system_utsname.release, nmsize-1);
+	cfg->ac_uname.release[nmsize-1] = '\0';
+	nmsize = sizeof(cfg->ac_uname.version);
+	memcpy(cfg->ac_uname.version, system_utsname.version, nmsize-1);
+	cfg->ac_uname.version[nmsize-1] = '\0';
+	nmsize = sizeof(cfg->ac_uname.machine);
+	memcpy(cfg->ac_uname.machine, system_utsname.machine, nmsize-1);
+	cfg->ac_uname.machine[nmsize-1] = '\0';
+
+	return;
+}
+
+
+/*
+ *      Create and write a configuration change accounting record.
+ */
+static int
+csa_config_write(ac_eventtype event, struct file *job_acctfile)
+{
+	int	error = 0;	/* errno */
+        struct  acctcfg acctcfg;
+	mm_segment_t fs;
+
+        /* write record to process accounting file. */
+        csa_config_make(event, &acctcfg);
+
+	down(&csa_write_sem);
+	if (csa_acctvp != (struct file *)NULL) {
+		fs = get_fs();
+		set_fs(KERNEL_DS);
+		error = csa_acctvp->f_op->write(csa_acctvp, (char *)&acctcfg,
+			sizeof(struct acctcfg), &csa_acctvp->f_pos);
+		set_fs(fs);
+        }
+	if (job_acctfile != (struct file *)NULL) {
+		fs = get_fs();
+		set_fs(KERNEL_DS);
+		error = job_acctfile->f_op->write(job_acctfile,(char *)&acctcfg,
+			sizeof(struct acctcfg), &job_acctfile->f_pos);
+		set_fs(fs);
+	}
+	if (error >= 0) {
+		error = 0;
+	}
+	up(&csa_write_sem);
+        return(error);
+}
+
+
+
+/*
+ *	When first process in a job is created.
+ */
+int
+csa_jstart(int event, void *data)
+{
+	struct job_csa *job_sojbuf = (struct job_csa *)data;
+	struct acctsoj	acctsoj;	/* start of job record */
+	DBG_PRINTINIT(__FUNCTION__);
+
+	DBG_PRINTENTRY();
+
+	 /*  Are we doing any accounting?  */
+	if (csa_acctvp == (struct file *)NULL) {
+		DBG_PRINTEXIT(0);
+		return 0;
+	}
+
+	if (!job_sojbuf) {
+		/* bad pointer */
+		printk(KERN_ERR
+		    "csa_jstart: Received bad soj pointer, pid %d.\n",
+		     current->pid);
+		DBG_PRINTEXIT(-1);
+		return -1;
+	}
+		
+	memset(&acctsoj, 0, sizeof(struct acctsoj));
+	DBG_PRINTEXIT(__LINE__);
+	csa_header(&acctsoj.ac_hdr, REV_SOJ, ACCT_KERNEL_SOJ,
+		sizeof(struct acctsoj));
+	DBG_PRINTEXIT(__LINE__);
+	acctsoj.ac_jid = job_sojbuf->job_id;
+	DBG_PRINTEXIT(__LINE__);
+	acctsoj.ac_uid = job_sojbuf->job_uid;
+	DBG_PRINTEXIT(__LINE__);
+	if (event == JOB_EVENT_START) {
+	DBG_PRINTEXIT(__LINE__);
+		acctsoj.ac_type = AC_SOJ;
+		acctsoj.ac_btime = CT_TO_SECS(job_sojbuf->job_start) +
+			(xtime.tv_sec - (jiffies / HZ) );
+	} else if (event == JOB_EVENT_RESTART) {
+	DBG_PRINTEXIT(__LINE__);
+		acctsoj.ac_type = AC_ROJ;
+		acctsoj.ac_rstime = CT_TO_SECS(job_sojbuf->job_start) +
+			(xtime.tv_sec - (jiffies / HZ) );
+	} else {
+	DBG_PRINTEXIT(__LINE__);
+		DBG_PRINTEXIT(-1);
+		return -1;
+	}
+
+	/*
+	 *  Write the accounting record to the process accounting
+	 *  file if any accounting is enabled.
+ 	 */
+	DBG_PRINTEXIT(__LINE__);
+	if (csa_acctvp != (struct file *)NULL) {
+	DBG_PRINTEXIT(__LINE__);
+		(void)csa_write((caddr_t)&acctsoj, ACCT_KERN_CSA,
+			sizeof(acctsoj), job_sojbuf->job_id, A_SYS, job_sojbuf);
+	}
+
+	DBG_PRINTEXIT(__LINE__);
+	DBG_PRINTEXIT(0);
+	return 0;
+}
+
+/*
+ *	When last process in a job is done, write an EOJ record
+ */
+int
+csa_jexit(int event, void *data)
+{
+	struct	achead	*hdr1, *hdr2;
+	struct	accteoj	eoj;	/* end of job record */
+	struct job_csa *job_eojbuf = (struct job_csa *)data;
+
+	/*  Are we doing any accounting? */
+	if (csa_acctvp == (struct file *)NULL) {
+		return 0;
+	}
+
+	if (!job_eojbuf) {
+		/* bad pointer */
+		printk(KERN_ERR 
+		    "csa_jexit: Received bad eoj pointer, pid %d.\n",
+		    current->pid);
+		return -1;
+	}
+
+	memset(&eoj, 0, sizeof(struct accteoj));
+
+	/*  Set up record. */
+	hdr1 = &eoj.ac_hdr1;
+	csa_header(hdr1, REV_EOJ, ACCT_KERNEL_EOJ, sizeof(struct accteoj) );
+	hdr2 = &eoj.ac_hdr2;
+	csa_header(hdr2, REV_EOJ, ACCT_KERNEL_EOJ, 0 );
+	hdr2->ah_magic = ~ACCT_MAGIC;
+
+	eoj.ac_nice = task_nice(current);
+	eoj.ac_uid = job_eojbuf->job_uid;
+	eoj.ac_gid = current->gid;
+
+	eoj.ac_jid = job_eojbuf->job_id;
+
+	eoj.ac_btime = CT_TO_SECS(job_eojbuf->job_start) +
+		(xtime.tv_sec - (jiffies / HZ) );
+	eoj.ac_etime = xtime.tv_sec;
+
+	/*
+	 * XXX Once we have real values in these two fields, convert them
+	 * to Kbytes.
+	 */
+	eoj.ac_corehimem = job_eojbuf->job_corehimem;
+	eoj.ac_virthimem = job_eojbuf->job_virthimem;
+
+	/*
+	 *  Write the accounting record to the process accounting
+	 *  file if job accounting is enabled.
+ 	 */
+	if (csa_acctvp != (struct file *)NULL) {
+		(void) csa_write((caddr_t)&eoj, ACCT_KERN_CSA,
+			sizeof(struct accteoj), job_eojbuf->job_id, A_SYS,
+			job_eojbuf);
+	}
+
+	return 0;
+}
+
+/*
+ *	Write buf out to the accounting file.
+ *	If an error occurs, return the error code to the caller
+ */
+int
+csa_write(char *buf, int did, int nbyte, uint64_t jid, int type,
+	struct job_csa *jp)
+{
+	int	error = 0;	/* errno */
+	int	retval = 0;
+	struct file	*vp;	/* acct file */
+	mm_segment_t fs;
+	unsigned long limit;
+
+	down(&csa_write_sem);
+	 /*  Locate the accounting type. */
+	switch (type) {
+	case A_SYS:
+	case A_DMD:
+		vp = csa_acctvp;
+		break;
+
+	case A_CJA:
+		if (jp != (struct job_csa *)NULL) {
+			vp = jp->job_acctfile;
+		} else {
+			vp = (struct file *)NULL;
+		}
+		break;
+
+	default:
+		up(&csa_write_sem);
+		return -EINVAL;
+
+	}	/* end of switch(type) */
+
+	/*  Check if this type of accounting is turned on. */
+	if (vp == (struct file *)NULL) {
+		up(&csa_write_sem);
+		return 0;
+	}
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	/* make sure we don't get hit by a process file size limit */
+	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+	current->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
+	error = vp->f_op->write(vp,buf, nbyte, &vp->f_pos);
+	current->rlim[RLIMIT_FSIZE].rlim_cur = limit;
+
+	set_fs(fs);
+	if (error >= 0) {
+		error = 0;
+	}
+	/*  If an error occurred, disable this type of accounting. */
+	if (error) {
+		switch(type) {
+
+		case A_SYS:
+		case A_DMD:
+			csa_acctvp = (struct file *)NULL;
+			acct_dmd[did][A_SYS].ac_state = ACS_ERROFF;
+			acct_dmd[ACCT_KERN_CSA][A_SYS].ac_state = ACS_ERROFF;
+			printk(KERN_ALERT
+			   "csa accounting pacct write error %d; %s disabled\n",
+			    error, acct_dmd_name[did]);
+			filp_close(vp, NULL);
+			break;
+		case A_CJA:
+			jp->job_acctfile = (struct file *)NULL;
+			retval = job_setacct(jid, JOB_ACCT_CSA,
+				JOB_CSA_ACCTFILE, jp);
+			printk(KERN_WARNING JID_ERR2, error,
+			       (unsigned long long) jid);
+			if (retval != 0) {
+			    printk(KERN_WARNING JID_ERR3,
+				   (unsigned long long) jid);
+			} else {
+			    printk(KERN_WARNING JID_ERR4,
+				   (unsigned long long) jid);
+			}
+			filp_close(vp, NULL);
+			break;
+		}
+		up(&csa_write_sem);
+		return(error);
+	} 
+	up(&csa_write_sem);
+	return(error);
+}
+
+
+module_init(init_csa);
+module_exit(cleanup_csa);
+
+#endif /* defined(CONFIG_CSA) || defined(CONFIG_CSA_MODULE) */
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c	2004-08-14 00:37:40.000000000 -0500
+++ linux/kernel/exit.c	2004-08-16 09:59:30.000000000 -0500
@@ -23,6 +23,7 @@
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
 #include <linux/mempolicy.h>
+#include <linux/csa_internal.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -31,6 +32,8 @@
 
 extern void sem_exit (void);
 extern struct task_struct *child_reaper;
+void (*do_csa_acct) (int, struct task_struct *) = NULL;
+EXPORT_SYMBOL(do_csa_acct);
 
 int getrusage(struct task_struct *, int, struct rusage __user *);
 
@@ -820,7 +823,12 @@
 		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);
 	}
 
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 	acct_process(code);
+	/* no-op if CONFIG_CSA not set */
+	csa_acct(code, tsk);
 	__exit_mm(tsk);
 
 	exit_sem(tsk);
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2004-08-16 09:55:20.000000000 -0500
+++ linux/kernel/fork.c	2004-08-16 09:59:30.000000000 -0500
@@ -37,7 +37,7 @@
 #include <linux/audit.h>
 #include <linux/rmap.h>
 #include <linux/pagg.h>
-
+#include <linux/csa_internal.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -578,6 +578,9 @@
 	if (retval)
 		goto free_pt;
 
+	mm->hiwater_rss = mm->rss;
+	mm->hiwater_vm = mm->total_vm;	
+
 good_mm:
 	tsk->mm = mm;
 	tsk->active_mm = mm;
@@ -966,6 +969,10 @@
 
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
+	p->rchar = p->wchar = p->rblk = p->wblk = p->syscr = p->syscw = 0;
+	p->bwtime = 0;
+	/* no-op if CONFIG_CSA not set */
+	csa_clear_integrals(p);
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c	2004-08-14 00:36:57.000000000 -0500
+++ linux/mm/memory.c	2004-08-16 09:59:30.000000000 -0500
@@ -44,6 +44,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
+#include <linux/csa_internal.h>
 #include <linux/module.h>
 #include <linux/init.h>
 
@@ -605,6 +606,8 @@
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
 	tlb_finish_mmu(tlb, address, end);
+	/* no-op unless CONFIG_CSA is set */
+        csa_update_integrals();
 	spin_unlock(&mm->page_table_lock);
 }
 
@@ -1095,9 +1098,12 @@
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
-		if (PageReserved(old_page))
+		if (PageReserved(old_page)) {
 			++mm->rss;
-		else
+			/* no-op if CONFIG_CSA not set */
+			csa_update_integrals();
+			update_mem_hiwater();
+		} else
 			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
@@ -1378,6 +1384,10 @@
 		remove_exclusive_swap_page(page);
 
 	mm->rss++;
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
+	update_mem_hiwater();
+  
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
@@ -1443,6 +1453,9 @@
 			goto out;
 		}
 		mm->rss++;
+		/* no-op if CONFIG_CSA not set */
+		csa_update_integrals();
+		update_mem_hiwater();
 		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
 							 vma->vm_page_prot)),
 				      vma);
@@ -1552,6 +1565,10 @@
 	if (pte_none(*page_table)) {
 		if (!PageReserved(new_page))
 			++mm->rss;
+		/* no-op if CONFIG_CSA not set */
+		csa_update_integrals();
+		update_mem_hiwater();
+
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
Index: linux/mm/mmap.c
===================================================================
--- linux.orig/mm/mmap.c	2004-08-14 00:37:15.000000000 -0500
+++ linux/mm/mmap.c	2004-08-16 09:59:30.000000000 -0500
@@ -20,6 +20,7 @@
 #include <linux/hugetlb.h>
 #include <linux/profile.h>
 #include <linux/module.h>
+#include <linux/csa_internal.h>
 #include <linux/mount.h>
 #include <linux/mempolicy.h>
 #include <linux/rmap.h>
@@ -988,6 +989,9 @@
 					pgoff, flags & MAP_NONBLOCK);
 		down_write(&mm->mmap_sem);
 	}
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 	return addr;
 
 unmap_and_free_vma:
@@ -1227,6 +1231,9 @@
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
+	/* no-op if CONFIG_CSA_JOB_ACCT not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 	anon_vma_unlock(vma);
 	return 0;
 }
@@ -1688,6 +1695,9 @@
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
 	}
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 	return addr;
 }
 
Index: linux/mm/mremap.c
===================================================================
--- linux.orig/mm/mremap.c	2004-08-14 00:36:59.000000000 -0500
+++ linux/mm/mremap.c	2004-08-16 09:59:30.000000000 -0500
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
+#include <linux/csa_internal.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -231,6 +232,10 @@
 					   new_addr + new_len);
 	}
 
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
+	update_mem_hiwater();
+
 	return new_addr;
 }
 
@@ -363,6 +368,9 @@
 				make_pages_present(addr + old_len,
 						   addr + new_len);
 			}
+			/* no-op if CONFIG_CSA not set */
+			csa_update_integrals();
+			update_mem_hiwater();
 			ret = addr;
 			goto out;
 		}
Index: linux/mm/rmap.c
===================================================================
--- linux.orig/mm/rmap.c	2004-08-14 00:37:42.000000000 -0500
+++ linux/mm/rmap.c	2004-08-16 09:59:30.000000000 -0500
@@ -29,6 +29,7 @@
 #include <linux/swapops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/csa_internal.h>
 #include <linux/rmap.h>
 
 #include <asm/tlbflush.h>
@@ -515,6 +516,8 @@
 	mm->rss--;
 	BUG_ON(!page->mapcount);
 	page->mapcount--;
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
 	page_cache_release(page);
 
 out_unmap:
@@ -614,6 +617,8 @@
 
 		page_remove_rmap(page);
 		page_cache_release(page);
+		/* no-op if CONFIG_CSA not set */
+		csa_update_integrals();
 		mm->rss--;
 		(*mapcount)--;
 	}
Index: linux/mm/swapfile.c
===================================================================
--- linux.orig/mm/swapfile.c	2004-08-14 00:36:32.000000000 -0500
+++ linux/mm/swapfile.c	2004-08-16 09:59:30.000000000 -0500
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/rmap.h>
 #include <linux/security.h>
+#include <linux/csa_internal.h>
 #include <linux/backing-dev.h>
 
 #include <asm/pgtable.h>
@@ -435,6 +436,9 @@
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_anon_rmap(page, vma, address);
 	swap_free(entry);
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 }
 
 /* vma->vm_mm->page_table_lock is held */

--------------060202000807050403020600--

