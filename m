Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWFUTOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWFUTOd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWFUTOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:14:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52381 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751205AbWFUTOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:14:32 -0400
Message-ID: <44999A98.8030406@engr.sgi.com>
Date: Wed, 21 Jun 2006 12:14:32 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org> <4489EE7C.3080007@watson.ibm.com> <449999D1.7000403@engr.sgi.com>
In-Reply-To: <449999D1.7000403@engr.sgi.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030603050204060303060806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030603050204060303060806
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jay Lan wrote:
>Shailabh Nagar wrote:
>  
>>Andrew Morton wrote:
>> 
>>    
>>>You see the problem - if one userspace package wants the tgid-stats and
>>>another concurrently-running one does now, what do we do?  Just leave it
>>>enabled and run a bit slower?
>>>
>>>If so, how much slower?  Your changelog says some potential users don't
>>>need the tgid-stats, but so what?  I assume this patch is a performance
>>>thing?  If so, has it been quantified?
>>>   
>>>      
>>Here are some results from running a simple program (source below) that does
>>10 iterations of creating and then destroying 1000 threads. On the side, another utility
>>kept reading the pid (+tgid if present) stats from exiting tasks.
>> 
>>    
>
>I ran my testing using the same program posted by Shalilabh attached in his
>posting.
>
>System: SGI a350, a two cpus IA64 machine.
>Kernel:  2.6.17-rc3 + delay-acct-taskstats patch set
>       + tgid-disable_patch_shailabh + exit race patch_balbir +
>csa_patch_jlan
>
>I also modified the Decumentation/accounting/getdelay.c:
>   - it repeatedly does recv() to retrieve data from kernel
>   - instead of using printf() to display data received, i simply write
>it to
>     disk as it would be for an accounting daemon. Note that currently
>both the
>     BSD (or GNU) accounting and the CSA writes accounting data from kernel.
>     As an effort of moving accounting system to userspace, the raw data
>needs
>     to be written to a raw file first before further processing.
>
>In Shailabh's testing, he ran his 'mkthreads' 10 iterations of creating and
>distroying 1000 threads.  I had to increase my test to 5000 iterations
>in order
>to receive meaningful data: 'mkthreads 1000 5000'.
>
>I used Shailabh's per-tgid-disable patch to run my tests with per-tgid
>enabled and disabled. I used 'sa' command of 'acct' package to report
>results of 5 runs of 'mkthreads 1000 5000'.
>
>  
>>	Yes	No	Ovhd
>>user	0.14	0.15	-6%
>>system	1.61	1.54	+5%
>>elapsed	2.01	1.94	+3%
>>
>>Yes = tgid stats printed on exit
>>No = not printed
>>Ovhd = (Yes-No)/No * 100
>> 
>>    
>
>Here are test results:
>
>             Yes      No     Ovhd
>user         1.77    0.44    302.27%
>system       0.06    0.06      0.00%
>  

Please swap "user" label with "system" label. Sorry.

Also i forgot to attach the two files.

- jay

>elapsed    794.60  316.40    151.14%
>
>Also, the results of five runs of per-tgid-disabled were very
>consistent (3 runs of 0,44 seconds and 2 runs of 0.45), while
>those of per-tgid-enabled varies (1.56, 1.99, 1.54, 2.21, 1.57).
>
>The impact of per-tgid stats is too significant to ignore for
>those who do not need the per-tgid stats data.
>
>Another observation that i considered bad news is that all
>10 runs produced 1 to 5 recv() error with errno=105 (ENOBUF).
>
>Here I attach my csa_taskstats patch and my modified version of
>exit_recv.c.
>
>Regards,
> - jay
>
>
>  
>>So even in this extreme case where the per-tgid stats are indeed
>>half of the total data, the overhead is not very significant.
>>
>>As pointed out earlier, more representative cases are
>>- single threaded apps (e.g. make -jX) where the current
>>taskstats interface already optimizes by not sending redundant per-tgid stats, or
>>- server-type multithreaded apps where the exits are going to be relatively infrequent (due to
>>reuse of thread pools) so the extra per-tgid output is not going to have much impact.
>>
>>I'd suggest we drop the idea of including this patch until we have data showing that
>>the overhead is an issue.
>>
>>--Shailabh
>>
>>
>>
>>#include <stdio.h>
>>#include <stdlib.h>
>>#include <sys/types.h>
>>#include <unistd.h>
>>#include <pthread.h>
>>
>>int n;
>>
>>void *slow_exit(void *arg)
>>{
>>	int i = (int) arg;
>>	usleep((n-i)*2);
>>}
>>
>>int main(int argc, char *argv[])
>>{
>>	int i,rc, rep;
>>	pthread_t *ppthread;
>>	
>>	n = 5 ;
>>	if (argc > 1)
>>		n = atoi(argv[1]);
>>
>>	rep = 10;
>>	if (argc > 2)
>>		rep = atoi(argv[2]);
>>
>>	ppthread = malloc(n * sizeof(pthread_t));
>>	if (ppthread == NULL) {
>>		printf("Memory allocation failure\n");
>>		exit(-1);
>>	}
>>
>>	while (rep) {
>>		for (i=0; i<n; i++) {
>>			rc = pthread_create(&ppthread[i], NULL,
>>					    slow_exit, (void *)i);
>>			if (rc) {
>>				printf("Error creating thread %d\n", i);
>>				exit(-1);
>>			}
>>		}
>>		for (i=0; i<n; i++) {
>>			rc = pthread_join(ppthread[i], NULL);
>>			if (rc) {
>>				printf("Error joining thread %d\n", i);
>>				exit(-1);
>>			}
>>		}
>>		rep--;
>>	}
>>}
>>
>>
>>
>> 
>>    
>
>  


--------------030603050204060303060806
Content-Type: text/plain;
 name="csa_taskstats.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="csa_taskstats.patch"

Index: linux/include/linux/taskstats.h
===================================================================
--- linux.orig/include/linux/taskstats.h	2006-06-19 18:27:38.881105605 -0700
+++ linux/include/linux/taskstats.h	2006-06-20 11:37:51.278901513 -0700
@@ -15,6 +15,11 @@
 #ifndef _LINUX_TASKSTATS_H
 #define _LINUX_TASKSTATS_H
 
+#ifdef __KERNEL__
+#include <linux/time.h>
+#include <linux/sched.h>
+#endif
+
 /* Format for per-task data returned to userland when
  *	- a task exits
  *	- listener requests stats for a task
@@ -84,6 +89,40 @@ struct taskstats {
 
 	/* version of taskstats */
 	__u64	version;
+
+ 	/* Common Accounting Fields start */
+ 	__u32	ac_uid;			/* User ID */
+ 	__u32	ac_gid;			/* Group ID */
+ 	__u32	ac_pid;			/* Process ID */
+ 	__u32	ac_ppid;		/* Parent process ID */
+ 	struct timespec	start_time;	/* Start time */
+ 	struct timespec exit_time;	/* Exit time */
+ 	__u64	ac_utime;		/* User CPU time [usec] */
+ 	__u64	ac_stime;		/* SYstem CPU time [usec] */
+ 	char	ac_comm[TASK_COMM_LEN];	/* Command name */
+ 	/* Common Accounting Fields end */
+
+ 	/* CSA accounting fields start */
+ 	__u64	ac_sbu;			/* System billing units */
+ 	__u16	csa_revision;		/* CSA Revision */
+ 	__u8	csa_type;		/* Record types */
+ 	__u8	csa_flag;		/* Record flags */
+ 	__u8	ac_stat;		/* Exit status */
+ 	__u8	ac_nice;		/* Nice value */
+ 	__u8	ac_sched;		/* Scheduling discipline */
+ 	__u8	pad0;			/* Unused */
+ 	__u64	acct_rss_mem1;		/* accumulated rss usage */
+ 	__u64	acct_vm_mem1;		/* accumulated virtual memory usage */
+ 	__u64	hiwater_rss;		/* High-watermark of RSS usage */
+ 	__u64	hiwater_vm;		/* High-water virtual memory usage */
+ 	__u64	ac_minflt;		/* Minor Page Fault */
+ 	__u64	ac_majflt;		/* Major Page Fault */
+ 	__u64	ac_chr;			/* bytes read */
+ 	__u64	ac_chw;			/* bytes written */
+ 	__u64	ac_scr;			/* read syscalls */
+ 	__u64	ac_scw;			/* write syscalls */
+ 	__u64	ac_jid;			/* Job ID */
+ 	/* CSA accounting fields end */
 
 };
 
Index: linux/init/Kconfig
===================================================================
--- linux.orig/init/Kconfig	2006-06-19 18:27:38.913105990 -0700
+++ linux/init/Kconfig	2006-06-20 11:37:51.290901649 -0700
@@ -173,6 +173,31 @@ config TASK_DELAY_ACCT
 
 	  Say N if unsure.
 
+config CSA_ACCT
+	bool "Enable CSA Job Accounting (EXPERIMENTAL)"
+	depends on TASKSTATS
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
--- linux.orig/kernel/Makefile	2006-06-19 18:27:38.929106183 -0700
+++ linux/kernel/Makefile	2006-06-20 11:37:51.290901649 -0700
@@ -40,6 +40,7 @@ obj-$(CONFIG_RCU_TORTURE_TEST) += rcutor
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 obj-$(CONFIG_TASKSTATS) += taskstats.o
+obj-$(CONFIG_CSA_ACCT) += csa.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux/kernel/csa.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/kernel/csa.c	2006-06-20 11:37:51.294901694 -0700
@@ -0,0 +1,66 @@
+/*
+ * Copyright (c) 2006 Silicon Graphics, Inc All Rights Reserved.
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
+#include <linux/taskstats.h>
+#include <linux/csa_kern.h>
+
+int csa_add_tsk(struct taskstats *stats, struct task_struct *p)
+{
+	stats->version  = 0x3132333435363738;
+	stats->ac_uid	= 0x39393939;	/* p->uid; */
+	stats->ac_gid	= 0x38383838;	/* p->gid; */
+	stats->ac_pid	= p->pid;
+	stats->ac_ppid	= (p->parent) ? p->parent->pid : 0;
+	stats->ac_utime	= p->utime * USEC_PER_TICK;
+	stats->ac_stime	= p->stime * USEC_PER_TICK;
+	/* Each process gets a minimum of a half tick cpu time */
+	if ((stats->ac_utime == 0) && (stats->ac_stime == 0)) {
+		stats->ac_stime = USEC_PER_TICK/2;
+	}
+
+	stats->start_time = p->start_time;
+	do_posix_clock_monotonic_gettime(&stats->exit_time);
+	strncpy(stats->ac_comm, p->comm, sizeof(stats->ac_comm));
+
+	stats->ac_sbu = 0;
+	stats->csa_revision = REV_CSA;
+	stats->csa_type = 0;
+	stats->csa_flag = 0;
+	stats->ac_stat  = p->exit_code;
+	stats->ac_nice  = task_nice(p);
+	stats->ac_sched = p->policy;
+	stats->acct_rss_mem1 = p->acct_rss_mem1;
+	stats->acct_vm_mem1  = p->acct_vm_mem1;
+	if (p->mm) {
+		stats->hiwater_rss   = p->mm->hiwater_rss;
+		stats->hiwater_vm    = p->mm->hiwater_vm;
+	}
+	stats->ac_minflt = p->min_flt;
+	stats->ac_majflt = p->maj_flt;
+	stats->ac_chr	= p->rchar;
+	stats->ac_chw	= p->wchar;
+	stats->ac_scr	= p->syscr;
+	stats->ac_scw	= p->syscw;
+	stats->ac_jid	= 0xffffffffffffffff;
+	return 0;
+}
Index: linux/kernel/taskstats.c
===================================================================
--- linux.orig/kernel/taskstats.c	2006-06-20 11:34:51.652867983 -0700
+++ linux/kernel/taskstats.c	2006-06-20 11:37:51.298901739 -0700
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/taskstats_kern.h>
 #include <linux/delayacct.h>
+#include <linux/csa_kern.h>
 #include <net/genetlink.h>
 #include <asm/atomic.h>
 
@@ -123,8 +124,16 @@ static int fill_pid(pid_t pid, struct ta
 	 */
 
 	rc = delayacct_add_tsk(stats, tsk);
+/*
+	if (rc)
+		goto err;
+ */
+	rc = csa_add_tsk(stats, tsk);
+	if (rc) {
+		goto err;
+	}
 
-	/* Define err: label here if needed */
+err:	/* Define err: label here if needed */
 	put_task_struct(tsk);
 	return rc;
 
@@ -269,12 +278,14 @@ void taskstats_exit_send(struct task_str
 		size = 2 * size;	/* PID + STATS + TGID + STATS */
 
 	rc = prepare_reply(NULL, TASKSTATS_CMD_NEW, &rep_skb, &reply, size);
-	if (rc < 0)
+	if (rc < 0) {
 		goto ret;
+	}
 
 	rc = fill_pid(tsk->pid, tsk, tidstats);
-	if (rc < 0)
+	if (rc < 0) {
 		goto err_skb;
+	}
 
 	tidstats->version = TASKSTATS_VERSION;
 
Index: linux/include/linux/csa_kern.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/csa_kern.h	2006-06-20 11:37:51.314901921 -0700
@@ -0,0 +1,71 @@
+/*
+ * Copyright (c) 2006 Silicon Graphics, Inc All Rights Reserved.
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
+ * Contact information:  Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
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
+ *  This kernel header file and the csa.h in the csa userland source
+ *  rpm share same data struct declaration and #define's. Do not modify
+ *  one without modify the other one as well. The compatibility between
+ *  userland and the kernel is ensured by using the 'ah_revision' field
+ *  of struct achead.
+ *
+ */
+
+#ifndef _CSA_KERN_H
+#define _CSA_KERN_H
+
+#include <linux/time.h>
+
+extern int csa_add_tsk(struct taskstats *, struct task_struct *);
+
+/*
+ * Record revision levels.
+ *
+ * These are incremented to indicate that a record's format has changed since
+ * a previous release.
+ *
+ * History:     05000   The first rev in Linux
+ *              06000   Major rework to clean up unused fields and features.
+ *                      No binary compatibility with earlier rev.
+ *		07000	Convert to taskstats interface
+ *
+ * NOTE: The header revision number was defined as 02400 in earlier version.
+ *       However, since ah_revision was defined as 15-bit field (ah_magic
+ *       takes up 17 bits), the revision number is read as twice the value in
+ *       new code. So, define it to be 05000 accordingly.
+ */
+#define REV_CSA		07000	/* Kernel: CSA base record */
+
+
+/* this defines can be removed once they're available in kernel header files */
+/* #define USEC_PER_SEC 1000000L */	/* number of usecs for 1 second */
+#define USEC_PER_TICK	(USEC_PER_SEC/HZ)
+
+
+#endif	/* _CSA_KERN_H */

--------------030603050204060303060806
Content-Type: text/plain;
 name="exit_recv.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="exit_recv.c"

/* getdelays.c
 *
 * Utility to get per-pid and per-tgid delay accounting statistics
 * Also illustrates usage of the taskstats interface
 *
 * Copyright (C) Shailabh Nagar, IBM Corp. 2005
 * Copyright (C) Balbir Singh, IBM Corp. 2006
 * Copyright (c) Jay Lan, SGI. 2006
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <poll.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <signal.h>

#include <linux/genetlink.h>
#include <taskstats.h>

/*
 * Generic macros for dealing with netlink sockets. Might be duplicated
 * elsewhere. It is recommended that commercial grade applications use
 * libnl or libnetlink and use the interfaces provided by the library
 */
#define GENLMSG_DATA(glh)	((void *)(NLMSG_DATA(glh) + GENL_HDRLEN))
#define GENLMSG_PAYLOAD(glh)	(NLMSG_PAYLOAD(glh, 0) - GENL_HDRLEN)
#define NLA_DATA(na)		((void *)((char*)(na) + NLA_HDRLEN))
#define NLA_PAYLOAD(len)	(len - NLA_HDRLEN)

#define err(code, fmt, arg...) do { printf(fmt, ##arg); exit(code); } while (0)
int done = 0;

int dbg=0, Delayacct=0;
__u64 stime, utime;
#define PRINTF(fmt, arg...) {			\
	    if (dbg) {				\
		printf(fmt, ##arg);		\
	    }					\
	}
/*
 * Create a raw netlink socket and bind
 */
static int create_nl_socket(int protocol, int groups)
{
    socklen_t addr_len;
    int fd;
    struct sockaddr_nl local;

    fd = socket(AF_NETLINK, SOCK_RAW, protocol);
    if (fd < 0)
	return -1;

    memset(&local, 0, sizeof(local));
    local.nl_family = AF_NETLINK;
    local.nl_groups = groups;

    if (bind(fd, (struct sockaddr *) &local, sizeof(local)) < 0)
	goto error;

    return fd;
  error:
    close(fd);
    return -1;
}

int sendto_fd(int s, const char *buf, int bufLen)
{
    struct sockaddr_nl nladdr;
    int r;

    memset(&nladdr, 0, sizeof(nladdr));
    nladdr.nl_family = AF_NETLINK;

    while ((r = sendto(s, buf, bufLen, 0, (struct sockaddr *) &nladdr,
		       sizeof(nladdr))) < bufLen) {
	if (r > 0) {
	    buf += r;
	    bufLen -= r;
	} else if (errno != EAGAIN)
	    return -1;
    }
    return 0;
}

/*
 * Probe the controller in genetlink to find the family id
 * for the TASKSTATS family
 */
int get_family_id(int sd)
{
    struct {
	struct nlmsghdr n;
	struct genlmsghdr g;
	char buf[256];
    } family_req;
    struct {
	struct nlmsghdr n;
	struct genlmsghdr g;
	char buf[256];
    } ans;

    int id;
    struct nlattr *na;
    int rep_len;

    /* Get family name */
    family_req.n.nlmsg_type = GENL_ID_CTRL;
    family_req.n.nlmsg_flags = NLM_F_REQUEST;
    family_req.n.nlmsg_seq = 0;
    family_req.n.nlmsg_pid = getpid();
    family_req.n.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
    family_req.g.cmd = CTRL_CMD_GETFAMILY;
    family_req.g.version = 0x1;
    na = (struct nlattr *) GENLMSG_DATA(&family_req);
    na->nla_type = CTRL_ATTR_FAMILY_NAME;
    na->nla_len = strlen(TASKSTATS_GENL_NAME) + 1 + NLA_HDRLEN;
    strcpy(NLA_DATA(na), TASKSTATS_GENL_NAME);
    family_req.n.nlmsg_len += NLMSG_ALIGN(na->nla_len);

    if (sendto_fd(sd, (char *) &family_req, family_req.n.nlmsg_len) < 0)
	err(1, "error sending message via Netlink\n");

    rep_len = recv(sd, &ans, sizeof(ans), 0);

    if (rep_len < 0)
	err(1, "error receiving reply message via Netlink\n");


    /* Validate response message */
    if (!NLMSG_OK((&ans.n), rep_len))
	err(1, "invalid reply message received via Netlink\n");

    if (ans.n.nlmsg_type == NLMSG_ERROR) {	/* error */
	printf("error received NACK - leaving\n");
	exit(1);
    }


    na = (struct nlattr *) GENLMSG_DATA(&ans);
    na = (struct nlattr *) ((char *) na + NLA_ALIGN(na->nla_len));
    if (na->nla_type == CTRL_ATTR_FAMILY_ID) {
	id = *(__u16 *) NLA_DATA(na);
    }
    return id;
}

void print_taskstats(struct taskstats *t)
{
    printf("\n\nCPU   %15s%15s%15s%15s\n"
	   "      %15llu%15llu%15llu%15llu\n"
	   "IO    %15s%15s\n"
	   "      %15llu%15llu\n"
	   "MEM   %15s%15s\n"
	   "      %15llu%15llu\n\n",
	   "count", "real total", "virtual total", "delay total",
	   t->cpu_count, t->cpu_run_real_total, t->cpu_run_virtual_total,
	   t->cpu_delay_total,
	   "count", "delay total",
	   t->blkio_count, t->blkio_delay_total,
	   "count", "delay total", t->swapin_count, t->swapin_delay_total);
}

void print_csa(struct taskstats *t)
{
    int sec, nsec;
    sec = t->exit_time.tv_sec - t->start_time.tv_sec;
    nsec = t->exit_time.tv_nsec - t->start_time.tv_nsec;
    printf("Command='%s'\n stime=%15llu, utime=%15llu, elapsed=%15llu msec\n",
    	t->ac_comm, t->ac_stime, t->ac_utime, sec*1000 + nsec/1000000);
    stime += t->ac_stime;
    utime += t->ac_utime;
}

void sigchld(int sig)
{
    done = 1;
}

int main(int argc, char *argv[])
{
    int rc;
    int sk_nl;
    struct nlmsghdr *nlh;
    struct genlmsghdr *genlhdr;
    __u16 id;
    struct nlattr *na;
    struct {
        struct nlmsghdr n;
	struct genlmsghdr g;
	char buf[800];
    } exitmsg;
    int	fd;

    /* For receiving */
    struct sockaddr_nl kern_nla, from_nla;
    socklen_t from_nla_len;
    int recv_len;

    int nl_sd = -1;
    int rep_len;
    int len = 0;
    int aggr_len, len2;
    struct sockaddr_nl nladdr;
    pid_t tid = 0;
    pid_t rtid = 0;
    int c;
    int count = 0, csa_summary=0;
    int write_file = 1;
    struct sigaction act = {
	.sa_handler = SIG_IGN,
    };
    struct sigaction tact = {
	.sa_handler = sigchld,
    };

    if (sigaction(SIGCHLD, &tact, NULL) < 0)
	err(1, "sigaction failed for SIGCHLD\n");

    while (1) {
    	c = getopt(argc, argv, "cdDw");
	if (c < 0)
	    break;

	switch (c) {
	    case 'c':
	    	printf("display csa\n");
		csa_summary = 1;
		break;

	    case 'd':
	    	printf("exit_recv: debug on\n");
	    	dbg = 1;
		break;

	    case 'D':
	    	printf("Delayacct summary ON\n");
		Delayacct = 1;
		break;

	    case 'w':		/* DON'T write data to a file */
	    	printf("exit_recv: write_file OFF\n");
	    	write_file = 0;
	    	break;

	    default: {
	    	printf("Unknown option %d\n", c);
		exit(-1);
	    }
	}
    }

    if (write_file)
	if ((fd = open("/var/csa/acct", O_WRONLY | O_CREAT | O_TRUNC, 
		S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)) == -1) {
	    perror("Cannot open output file\n"); exit(1);
	}

    /* Open a NETLINK_GENERIC socket with TASKSTATS_LISTEN_GROUP */

    if ((nl_sd =
	 create_nl_socket(NETLINK_GENERIC, TASKSTATS_LISTEN_GROUP)) < 0)
	err(1, "error creating Netlink socket\n");

    if (sigaction(SIGINT, &act, NULL) < 0)
        err(1, "sigaction failed for SIGINT\n");

    do {
	int i;

	rep_len = recv(nl_sd, &exitmsg, sizeof(exitmsg), 0);
	PRINTF("\n\treceived %d bytes\n", rep_len);
	nladdr.nl_family = AF_NETLINK;
	nladdr.nl_groups = TASKSTATS_LISTEN_GROUP;

	if (exitmsg.n.nlmsg_type == NLMSG_ERROR) {	/* error */
	    printf("error received NACK - leaving\n");
	    exit(1);
	}

	if (rep_len < 0) {
	    printf("error receiving reply message via Netlink, rep_len=%d, errno=%d\n",
	    	rep_len, errno);
	    continue;
	}

	PRINTF("nlmsghdr size=%d, nlmsg_len=%d, rep_len=%d\n",
		sizeof(struct nlmsghdr), exitmsg.n.nlmsg_len, rep_len);
	/* Validate response message */
	if (!NLMSG_OK((&exitmsg.n), rep_len))
	    err(1, "invalid reply message received via Netlink\n");
/* #define NLMSG_OK(nlh,len) ((len) >= (int)sizeof(struct nlmsghdr) && \
                           (nlh)->nlmsg_len >= sizeof(struct nlmsghdr) && \
			                              (nlh)->nlmsg_len <= (len))
 */

	rep_len = GENLMSG_PAYLOAD(&exitmsg.n);

	na = (struct nlattr *) GENLMSG_DATA(&exitmsg);
	len = 0;
	i = 0;
	while (len < rep_len) {
	    len += NLA_ALIGN(na->nla_len);
	    switch (na->nla_type) {
	    case TASKSTATS_TYPE_AGGR_PID:
		/* Fall through */
	    case TASKSTATS_TYPE_AGGR_TGID:
		aggr_len = NLA_PAYLOAD(na->nla_len);
		len2 = 0;
		/* For nested attributes, na follows */
		na = (struct nlattr *) NLA_DATA(na);
		done = 0;
		while (len2 < aggr_len) {
		    switch (na->nla_type) {
		    case TASKSTATS_TYPE_PID:
			rtid = *(int *) NLA_DATA(na);
			PRINTF("PID\t%d\n", rtid);
			break;
		    case TASKSTATS_TYPE_TGID:
			rtid = *(int *) NLA_DATA(na);
			PRINTF("TGID\t%d\n", rtid);
			break;
		    case TASKSTATS_TYPE_STATS:
		    	count++;
		    	if (Delayacct)
			    print_taskstats((struct taskstats *) NLA_DATA(na));
			if (fd > 0) {
			    if (write(fd, NLA_DATA(na), na->nla_len) < 0) {
			    	err(1,"write error\n");
			    }
			}
			if (csa_summary)
			    print_csa((struct taskstats *)NLA_DATA(na));
			break;
		    default:
		    	printf("Unknown nested nla_type %d\n", na->nla_type);
			break;
		    }
		    len2 += NLA_ALIGN(na->nla_len);
		    na = (struct nlattr *) ((char *) na + len2);
		    if (done)
			break;
		}
		break;

	    default:
	    	printf("Unknown nla_type %d\n", na->nla_type);
		break;
	    }
	    na = (struct nlattr *) (GENLMSG_DATA(&exitmsg) + len);
	    if (done)
		break;
	}
	if (done)
	    break;
    }
    while (1);

    printf("Total taskstats STATS read %d, stime=%llu, utime=%llu\n",
    	count, stime, utime);
    close(nl_sd);
    if (fd > 0)
    	close(fd);
    return 0;
}

--------------030603050204060303060806--
