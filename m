Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269324AbUIIBXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269324AbUIIBXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 21:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUIIBXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 21:23:40 -0400
Received: from holomorphy.com ([207.189.100.168]:38060 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269324AbUIIBRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 21:17:22 -0400
Date: Wed, 8 Sep 2004 18:17:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: [1/2] rediff nproc v2 vs. 2.6.9-rc1-mm4
Message-ID: <20040909011708.GL3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909004320.GJ3106@holomorphy.com> <20040909011549.GK3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909011549.GK3106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 05:35:29PM -0700, William Lee Irwin III wrote:
>>> Any chance you could convert these to use the new vm statistics
>>> accounting?

On Wed, Sep 08, 2004 at 05:43:20PM -0700, William Lee Irwin III wrote:
>> Hmm, there's a more serious issue; CONFIG_MMU=n will barf on these.
>> For that you will need to #ifdef on CONFIG_MMU and use the methods
>> in fs/proc/task_nommu.c and so on.

On Wed, Sep 08, 2004 at 06:15:49PM -0700, William Lee Irwin III wrote:
> This is a straight rediff of nproc vs. 2.6.9-rc1-mm4. No changes
> whatsoever to the underlying code were made; rather, this merely
> resolves offsets so it applies cleanly.
> Compiletested on ia64.

Repost with appropriate Subject: line.


-- wli

Index: mm4-2.6.9-rc1/include/linux/netlink.h
===================================================================
--- mm4-2.6.9-rc1.orig/include/linux/netlink.h	2004-09-08 06:10:50.000000000 -0700
+++ mm4-2.6.9-rc1/include/linux/netlink.h	2004-09-08 17:45:27.500658296 -0700
@@ -15,6 +15,7 @@
 #define NETLINK_ARPD		8
 #define NETLINK_AUDIT		9	/* auditing */
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
+#define NETLINK_NPROC		12	/* /proc information */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
 #define NETLINK_KEVENT		15	/* Kernel messages to userspace */
Index: mm4-2.6.9-rc1/include/linux/nproc.h
===================================================================
--- mm4-2.6.9-rc1.orig/include/linux/nproc.h	2004-04-25 12:31:02.000000000 -0700
+++ mm4-2.6.9-rc1/include/linux/nproc.h	2004-09-08 17:45:27.501634858 -0700
@@ -0,0 +1,119 @@
+#ifndef _LINUX_NPROC_H
+#define _LINUX_NPROC_H
+
+#include <linux/config.h>
+
+#ifndef __KERNEL__
+#define CONFIG_NPROC
+#endif
+
+#ifdef CONFIG_NPROC
+
+/* Request types */
+#define NPROC_BASE		0x10
+#define NPROC_GET_FIELD_LIST	(NPROC_BASE+0)
+#define NPROC_GET_LABEL		(NPROC_BASE+1)
+#define NPROC_GET_GLOBAL	(NPROC_BASE+2)
+#define NPROC_GET_PS		(NPROC_BASE+3)
+#define NPROC_GET_PID_LIST	(NPROC_BASE+4)
+
+/* Request flags */
+
+
+/* Field scopes */
+#define NPROC_SCOPE_MASK	0x70000000
+#define NPROC_SCOPE_GLOBAL	0x10000000	/* Global w/o arguments */
+#define NPROC_SCOPE_PROCESS	0x20000000
+#define NPROC_SCOPE_LABEL	0x30000000
+
+/* Data types */
+#define NPROC_TYPE_MASK		0x07000000
+#define NPROC_TYPE_STRING	0x01000000
+#define NPROC_TYPE_U32		0x02000000
+#define NPROC_TYPE_UL		0x03000000
+#define NPROC_TYPE_U64		0x04000000
+
+/* Access control (unused) */
+#define NPROC_PERM_MASK		0x00300000
+#define NPROC_PERM_USER		0x00100000
+#define NPROC_PERM_ROOT		0x00200000
+
+/* Selectors */
+#define NPROC_SELECT_ALL	0x00000001
+#define NPROC_SELECT_PID	0x00000002
+#define NPROC_SELECT_UID	0x00000003
+
+/* Labels */
+#define NPROC_LABEL_FIELD_NAME	0x00000001
+#define NPROC_LABEL_FIELD_FMT	0x00000002
+#define NPROC_LABEL_FIELD_UNIT	0x00000003
+#define NPROC_LABEL_WCHAN	0x00000004
+
+/* Field IDs (unique key in bits 0 - 15) */
+#define NPROC_NOP_UL		(0x00000020 | NPROC_TYPE_UL)
+#define NPROC_PID		(0x00000001 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_NAME		(0x00000002 | NPROC_TYPE_STRING | NPROC_SCOPE_PROCESS)
+/* Amount of free memory (pages) */
+#define NPROC_MEMFREE		(0x00000004 | NPROC_TYPE_U32    | NPROC_SCOPE_GLOBAL)
+/* Size of a page (bytes) */
+#define NPROC_PAGESIZE		(0x00000005 | NPROC_TYPE_U32    | NPROC_SCOPE_GLOBAL)
+/* There's no guarantee about anything with jiffies. Still useful for some. */
+#define NPROC_JIFFIES		(0x00000006 | NPROC_TYPE_U64    | NPROC_SCOPE_GLOBAL)
+/* Process: VM size (KiB) */
+#define NPROC_VMSIZE		(0x00000010 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+/* Process: locked memory (KiB) */
+#define NPROC_VMLOCK		(0x00000011 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+/* Process: Memory resident size (KiB) */
+#define NPROC_VMRSS		(0x00000012 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_VMDATA		(0x00000013 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_VMSTACK		(0x00000014 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_VMEXE		(0x00000015 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_VMLIB		(0x00000016 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_UID		(0x00000018 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_NR_DIRTY		(0x00000051 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_WRITEBACK	(0x00000052 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_UNSTABLE	(0x00000053 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_PG_TABLE_PGS	(0x00000054 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_MAPPED		(0x00000055 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_SLAB		(0x00000056 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_WCHAN		(0x00000080 | NPROC_TYPE_UL     | NPROC_SCOPE_PROCESS)
+#define NPROC_WCHAN_NAME	(0x00000081 | NPROC_TYPE_STRING)
+
+#ifdef __KERNEL__
+struct nproc_field {
+	__u32 id;
+	const char *label;
+	const char *fmt;
+	const char *unit;
+};
+
+static struct nproc_field labels[] = {
+	{ NPROC_PID,			"PID",		"%5u",	"" },
+	{ NPROC_NAME,			"Name",		"%-15s","" },
+	{ NPROC_MEMFREE,		"MemFree",	"%8u",	"page" },
+	{ NPROC_PAGESIZE,		"PageSize",	"%4u",	"byte" },
+	{ NPROC_JIFFIES,		"Jiffies",	"%10u",	"" },
+	{ NPROC_VMSIZE,			"VmSize",	"%8u",	"KiB" },
+	{ NPROC_VMLOCK,			"VmLock",	"%8u",	"KiB" },
+	{ NPROC_VMRSS,			"VmRSS",	"%8u",	"KiB" },
+	{ NPROC_VMDATA,			"VmData",	"%8u",	"KiB" },
+	{ NPROC_VMSTACK,		"VmStack",	"%8u",	"KiB" },
+	{ NPROC_VMEXE,			"VmExe",	"%8u",	"KiB" },
+	{ NPROC_VMLIB,			"VmLib",	"%8u",	"KiB" },
+	{ NPROC_UID,			"UID",		"%5u",	"" },
+	{ NPROC_NR_DIRTY,		"nr_dirty",	"%8d",	"page" },
+	{ NPROC_NR_WRITEBACK,		"nr_writeback",	"%8u",	"page" },
+	{ NPROC_NR_UNSTABLE,		"nr_unstable",	"%8u",	"page" },
+	{ NPROC_NR_PG_TABLE_PGS,	"nr_page_table_pages",	"%8u", "page" },
+	{ NPROC_NR_MAPPED,		"nr_mapped",	"%8u",	"page" },
+	{ NPROC_NR_SLAB,		"nr_slab",	"%8u",	"page" },
+	{ NPROC_WCHAN,			"wchan",	"%p",	"" },
+#ifdef CONFIG_KALLSYMS
+	{ NPROC_WCHAN_NAME,		"wchan_symbol",	"%s"},
+#endif
+};
+#endif /* __KERNEL__ */
+
+#endif /* CONFIG_NPROC */
+
+#endif /* _LINUX_NPROC_H */
Index: mm4-2.6.9-rc1/include/linux/pid.h
===================================================================
--- mm4-2.6.9-rc1.orig/include/linux/pid.h	2004-09-08 06:10:36.000000000 -0700
+++ mm4-2.6.9-rc1/include/linux/pid.h	2004-09-08 17:45:27.501634858 -0700
@@ -37,6 +37,7 @@
 extern struct pid *FASTCALL(find_pid(enum pid_type, int));
 
 extern int alloc_pidmap(void);
+extern void *get_pid_map(int);
 extern void FASTCALL(free_pidmap(int));
 extern void switch_exec_pids(struct task_struct *leader, struct task_struct *thread);
 
Index: mm4-2.6.9-rc1/init/Kconfig
===================================================================
--- mm4-2.6.9-rc1.orig/init/Kconfig	2004-09-08 06:10:50.000000000 -0700
+++ mm4-2.6.9-rc1/init/Kconfig	2004-09-08 17:45:27.504564546 -0700
@@ -139,6 +139,13 @@
 	  building a kernel for install/rescue disks or your system is very
 	  limited in memory.
 
+config NPROC
+	bool "Netlink interface to /proc information"
+	depends on PROC_FS && EXPERIMENTAL
+	default y
+	help
+	  Nproc is a netlink interface to /proc information.
+
 config AUDIT
 	bool "Auditing support"
 	default y if SECURITY_SELINUX
Index: mm4-2.6.9-rc1/kernel/Makefile
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/Makefile	2004-09-08 06:10:50.000000000 -0700
+++ mm4-2.6.9-rc1/kernel/Makefile	2004-09-08 17:45:27.501634858 -0700
@@ -15,6 +15,7 @@
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
+obj-$(CONFIG_NPROC) += nproc.o
 obj-$(CONFIG_PM) += power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_KEXEC) += kexec.o
Index: mm4-2.6.9-rc1/kernel/nproc.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/nproc.c	2004-04-25 12:31:02.000000000 -0700
+++ mm4-2.6.9-rc1/kernel/nproc.c	2004-09-08 17:45:27.503587983 -0700
@@ -0,0 +1,851 @@
+/*
+ * nproc.c
+ *
+ * netlink interface to /proc information.
+ */
+
+#include <linux/skbuff.h>
+#include <net/sock.h>
+#include <linux/swap.h>		/* nr_free_pages() */
+#include <linux/kallsyms.h>	/* kallsyms_lookup() */
+#include <linux/pid.h>		/* get_pid_map() */
+#include <linux/nproc.h>
+#include <asm/bitops.h>
+
+//#define DEBUG
+
+/* There must be like 5 million dprintk definitions, so let's add some more */
+#ifdef DEBUG
+#define pdebug(x,args...) printk(KERN_DEBUG "%s:%d " x, __func__ , __LINE__, ##args)
+#define pwarn(x,args...) printk(KERN_WARNING "%s:%d " x, __func__ , __LINE__, ##args)
+#else
+#define pdebug(x,args...)
+#define pwarn(x,args...)
+#endif
+
+#define perror(x,args...) printk(KERN_ERR "%s:%d " x, __func__ , __LINE__, ##args)
+
+static struct sock *nproc_sock = NULL;
+
+struct task_mem {
+	u32	vmdata;
+	u32	vmstack;
+	u32	vmexe;
+	u32	vmlib;
+};
+
+struct task_mem_cheap {
+	u32	vmsize;
+	u32	vmlock;
+	u32	vmrss;
+};
+
+/*
+ * __task_mem/__task_mem_cheap basically duplicate the MMU version of
+ * task_mem, but they are split by cost and work on structs.
+ */
+
+static void __task_mem(struct task_struct *tsk, struct task_mem *res)
+{
+	struct mm_struct *mm = get_task_mm(tsk);
+	if (mm) {
+		unsigned long data = 0, stack = 0, exec = 0, lib = 0;
+		struct vm_area_struct *vma;
+
+		down_read(&mm->mmap_sem);
+		for (vma = mm->mmap; vma; vma = vma->vm_next) {
+			unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
+			if (!vma->vm_file) {
+				data += len;
+				if (vma->vm_flags & VM_GROWSDOWN)
+					stack += len;
+				continue;
+			}
+			if (vma->vm_flags & VM_WRITE)
+				continue;
+			if (vma->vm_flags & VM_EXEC) {
+				exec += len;
+				if (vma->vm_flags & VM_EXECUTABLE)
+					continue;
+				lib += len;
+			}
+		}
+		res->vmdata = data - stack;
+		res->vmstack = stack;
+		res->vmexe = exec - lib;
+		res->vmlib = lib;
+		up_read(&mm->mmap_sem);
+
+		mmput(mm);
+	} else {
+		res->vmdata = 0;
+		res->vmstack = 0;
+		res->vmexe = 0;
+		res->vmlib = 0;
+	}
+}
+
+static void __task_mem_cheap(struct task_struct *tsk, struct task_mem_cheap *res)
+{
+	struct mm_struct *mm = get_task_mm(tsk);
+	if (mm) {
+		res->vmsize = mm->total_vm << (PAGE_SHIFT-10);
+		res->vmlock = mm->locked_vm << (PAGE_SHIFT-10);
+		res->vmrss = mm->rss << (PAGE_SHIFT-10);
+		mmput(mm);
+	} else {
+		res->vmsize = 0;
+		res->vmlock = 0;
+		res->vmrss = 0;
+	}
+}
+
+/*
+ * page_alloc.c already has an extra function broken out to fill a
+ * struct with information. Cool. Not sure whether pgpgin/pgpgout
+ * should be left as is or nailed down as kbytes.
+ */
+static struct page_state *__vmstat(void)
+{
+	struct page_state *ps;
+	ps = kmalloc(sizeof(*ps), GFP_KERNEL);
+	if (!ps)
+		return ERR_PTR(-ENOMEM);
+	get_full_page_state(ps);
+	ps->pgpgin /= 2;	/* sectors -> kbytes */
+	ps->pgpgout /= 2;
+	return ps;
+}
+
+/*
+ * Allocate and prefill an skb. The nlmsghdr provided to the function
+ * is a pointer to the respective struct in the request message.
+ */
+static struct sk_buff *nproc_alloc_nlmsg(struct nlmsghdr *nlh, u32 len)
+{
+	__u32 seq = nlh->nlmsg_seq;
+	__u16 type = nlh->nlmsg_type;
+	__u32 pid = nlh->nlmsg_pid;
+	struct sk_buff *skb2 = 0;
+
+	skb2 = alloc_skb(NLMSG_SPACE(len), GFP_KERNEL);
+	if (!skb2) {
+		skb2 = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	NLMSG_PUT(skb2, pid, seq, type, NLMSG_ALIGN(len));
+out:
+	return skb2;
+
+nlmsg_failure:				/* Used by NLMSG_PUT */
+	kfree_skb(skb2);
+	return NULL;
+}
+
+#define mstore(value, id, buf)						\
+({									\
+	u32 _type = id & NPROC_TYPE_MASK;				\
+	switch (_type) {						\
+		case NPROC_TYPE_U32: {					\
+			__u32 *p = (u32 *)buf;				\
+			*p = value;					\
+			buf = (char *)++p;				\
+			break;						\
+		}							\
+		case NPROC_TYPE_UL: {					\
+			unsigned long *p = (unsigned long *)buf;	\
+			*p = value;					\
+			buf = (char *)++p;				\
+			break;						\
+		}							\
+		case NPROC_TYPE_U64: {					\
+			__u64 *p = (u64 *)buf;				\
+			*p = value;					\
+			buf = (char *)++p;				\
+			break;						\
+		}							\
+		default:						\
+			perror("Huh? Bad type!\n");			\
+	}								\
+})
+
+static char *nproc_ps_field(u32 id, char *buf, task_t *tsk)
+{
+	struct task_mem tsk_mem;
+	struct task_mem_cheap tsk_mem_cheap;
+
+	tsk_mem.vmdata = (~0);
+	tsk_mem_cheap.vmsize = (~0);
+
+	switch (id) {
+		case NPROC_PID:
+			mstore(tsk->pid, NPROC_PID, buf);
+			break;
+		case NPROC_UID:
+			mstore(tsk->uid, NPROC_UID, buf);
+			break;
+		case NPROC_VMSIZE:
+		case NPROC_VMLOCK:
+		case NPROC_VMRSS:
+			if (tsk_mem_cheap.vmsize == (~0))
+				__task_mem_cheap(tsk, &tsk_mem_cheap);
+
+			switch (id) {
+				case NPROC_VMSIZE:
+					mstore(tsk_mem_cheap.vmsize,
+							NPROC_VMSIZE, buf);
+					break;
+				case NPROC_VMLOCK:
+					mstore(tsk_mem_cheap.vmlock,
+							NPROC_VMLOCK, buf);
+					break;
+				case NPROC_VMRSS:
+					mstore(tsk_mem_cheap.vmrss,
+							NPROC_VMRSS, buf);
+					break;
+			}
+			break;
+		case NPROC_VMDATA:
+		case NPROC_VMSTACK:
+		case NPROC_VMEXE:
+		case NPROC_VMLIB:
+			if (tsk_mem.vmdata == (~0))
+					__task_mem(tsk, &tsk_mem);
+
+			switch (id) {
+				case NPROC_VMDATA:
+					mstore(tsk_mem.vmdata, NPROC_VMDATA,
+							buf);
+					break;
+				case NPROC_VMSTACK:
+					mstore(tsk_mem.vmstack, NPROC_VMSTACK,
+							buf);
+					break;
+				case NPROC_VMEXE:
+					mstore(tsk_mem.vmexe, NPROC_VMEXE, buf);
+					break;
+				case NPROC_VMLIB:
+					mstore(tsk_mem.vmlib, NPROC_VMLIB, buf);
+					break;
+			}
+			break;
+		case NPROC_JIFFIES:
+			mstore(get_jiffies_64(), NPROC_JIFFIES, buf);
+			break;
+		case NPROC_WCHAN:
+			mstore(get_wchan(tsk), NPROC_WCHAN, buf);
+			break;
+		case NPROC_NAME:
+			mstore(sizeof(tsk->comm), NPROC_TYPE_U32, buf);
+			strncpy(buf, tsk->comm, sizeof(tsk->comm));
+			buf += sizeof(tsk->comm);
+			break;
+		case NPROC_NOP_UL:
+			mstore(0, NPROC_TYPE_UL, buf);
+			break;
+		default:
+			pwarn("Unknown field ID %#x.\n", id);
+			goto err_inval;
+	}
+	return buf;
+err_inval:
+	return ERR_PTR(-EINVAL);
+}
+
+/*
+ * Build and send a netlink msg for one PID.
+ */
+static int nproc_pid_msg(struct nlmsghdr *nlh, u32 *fdata, u32 len, task_t *tsk)
+{
+	int i;
+	int err = 0;
+	struct sk_buff *skb2;
+	char *buf;
+	struct nlmsghdr *nlh2;
+	u32 fcnt, *fields;
+
+	fcnt = fdata[0];
+	fields = &fdata[1];
+
+	skb2 = nproc_alloc_nlmsg(nlh, len);
+	if (IS_ERR(skb2)) {
+		err = PTR_ERR(skb2);
+		goto out;
+	}
+	nlh2 = (struct nlmsghdr *)skb2->data;
+	buf = NLMSG_DATA(nlh2);
+
+	for (i = 0; i < fcnt; i++) {
+		buf = nproc_ps_field(fields[i], buf, tsk);
+		if (IS_ERR(buf)) {
+			err = PTR_ERR(buf);
+			goto out_free;
+		}
+	}
+	err = netlink_unicast(nproc_sock, skb2, nlh2->nlmsg_pid, 0);
+	if (err > 0)
+		err = 0;
+	return err;
+out_free:
+	kfree_skb(skb2);
+out:
+	return err;
+}
+
+/*
+ * Find task for given pid, grab task lock (caller must unlock).
+ */
+static task_t *nproc_ps_get_task(int pid)
+{
+	task_t *tsk;
+
+	read_lock(&tasklist_lock);
+	tsk = find_task_by_pid(pid);
+	if (tsk)
+		get_task_struct(tsk);
+	read_unlock(&tasklist_lock);
+	return tsk;
+}
+
+/*
+ * Iterate over a list of PIDs.
+ */
+static int nproc_ps_select_pid(struct nlmsghdr *nlh, u32 *fdata, u32 len, u32 left, u32 *sdata)
+{
+	int i;
+	int err = 0;
+	u32 tcnt;
+	u32 *pids;
+
+	if (left < sizeof(tcnt))
+		goto err_inval;
+	left -= sizeof(tcnt);
+
+	tcnt = sdata[0];
+
+	if (left < (tcnt * sizeof(u32)))
+		goto err_inval;
+	left -= tcnt * sizeof(u32);
+
+	if (left)
+		pwarn("%d bytes left.\n", left);
+
+	pids = &sdata[1];
+
+	for (i = 0; i < tcnt; i++) {
+		task_t *tsk;
+		tsk = nproc_ps_get_task(pids[i]);
+		if (!tsk)
+			continue;
+		err = nproc_pid_msg(nlh, fdata, len, tsk);
+		put_task_struct(tsk);
+		if (err)
+			goto out;
+	}
+
+out:
+	return err;
+
+err_inval:
+	return -EINVAL;
+}
+
+#define PIDMAP_ENTRIES (PID_MAX_LIMIT/PAGE_SIZE/8)
+#define BITS_PER_PAGE (PAGE_SIZE*8)
+
+/*
+ * Iterate over all PIDs.
+ */
+static int nproc_ps_select_all(struct nlmsghdr *nlh, u32 *fdata, u32 len)
+{
+	void *map;
+	int offset, i;
+	int err = 0;
+
+	for (i = 0; i < PIDMAP_ENTRIES; i++) {
+
+		map = get_pid_map(i);
+		if (!map)	/* done -- there are no holes in pidmap_array */
+			break;
+		if (IS_ERR(map))	/* No PIDs used in this map */
+			continue;
+		offset = 0;
+		for ( ; ; ) {
+			int pid;
+			task_t *tsk;
+			offset = find_next_bit(map, BITS_PER_PAGE, ++offset);
+			if (offset >= BITS_PER_PAGE)
+				break;
+			pid = offset + i * BITS_PER_PAGE;
+			tsk = nproc_ps_get_task(pid);
+			if (!tsk)
+				continue;
+			err = nproc_pid_msg(nlh, fdata, len, tsk);
+			put_task_struct(tsk);
+			if (err)
+				goto out;
+		}
+	}
+
+out:
+	return err;
+}
+
+static u32 __reply_size_special(u32 id)
+{
+	u32 len = 0;
+
+	switch (id) {
+		case NPROC_NAME:
+			len = sizeof(u32) +
+				sizeof(((struct task_struct*)0)->comm);
+			break;
+		default:
+			pwarn("Unknown field size in %#x.\n", id);
+	}
+	return len;
+}
+
+/*
+ * Calculates the size of a reply message payload. Alternatively, we could have
+ * the user space caller supply a number along with the request and bail
+ * out or realloc later if we find the allocation was too small. More
+ * responsibility in user space, but faster.
+ */
+static u32 *__reply_size (u32 *data, u32 *left, u32 *len)
+{
+	u32 *fields;
+	u32 fcnt;
+	int i;
+	*len = 0;
+
+	if (*left < sizeof(fcnt))
+		goto err_inval;
+	*left -= sizeof(fcnt);
+
+	fcnt = data[0];
+
+	if (*left < (fcnt * sizeof(u32)))
+		goto err_inval;
+	*left -= fcnt * sizeof(u32);
+
+	fields = &data[1];
+
+	for (i = 0; i < fcnt; i++) {
+		u32 id = fields[i];
+		u32 type = id & NPROC_TYPE_MASK;
+		pdebug("        %#8.8x.\n", fields[i]);
+		switch (type) {
+			case NPROC_TYPE_U32:
+				*len += sizeof(u32);
+				break;
+			case NPROC_TYPE_UL:
+				*len += sizeof(unsigned long);
+				break;
+			case NPROC_TYPE_U64:
+				*len += sizeof(u64);
+				break;
+			default: {		/* Special cases */
+				u32 slen;
+				slen = __reply_size_special(id);
+				if (slen)
+					*len += slen;
+				else
+					goto err_inval;
+			}
+		}
+	}
+
+	return &fields[fcnt];
+
+err_inval:
+	return ERR_PTR(-EINVAL);
+}
+
+/*
+ * Call the chosen process selector. Adding additional selectors
+ * (e.g. select by uid) is easy, but is there a need?
+ */
+static int nproc_get_ps(struct nlmsghdr *nlh, uid_t uid)
+{
+	int err;
+	u32 len;
+	u32 *data = NLMSG_DATA(nlh);
+	u32 *sdata;
+	u32 left = nlh->nlmsg_len - sizeof(*nlh);
+
+
+	sdata = __reply_size(data, &left, &len);
+	if (IS_ERR(sdata)) {
+		err = PTR_ERR(sdata);
+		goto out;
+	}
+
+	if (left < sizeof(u32))
+		goto err_inval;
+	left -= sizeof(u32);
+
+	switch (*sdata) {
+		case NPROC_SELECT_ALL:
+			if (left)
+				pwarn("%d bytes left.\n", left);
+			err = nproc_ps_select_all(nlh, data, len);
+			break;
+		case NPROC_SELECT_PID:
+			err = nproc_ps_select_pid(nlh, data, len,
+					left, sdata + 1);
+			break;
+		default:
+			pwarn("Unknown selection method %#x.\n", *sdata);
+			goto err_inval;
+	}
+
+out:
+	return err;
+
+err_inval:
+	return -EINVAL;
+}
+
+static char *nproc_global_field(u32 id, char *buf)
+{
+	struct page_state *ps = NULL;
+
+	switch (id) {
+		case NPROC_NR_DIRTY:
+		case NPROC_NR_WRITEBACK:
+		case NPROC_NR_UNSTABLE:
+		case NPROC_NR_PG_TABLE_PGS:
+		case NPROC_NR_MAPPED:
+		case NPROC_NR_SLAB:
+			if (!ps) {
+				ps = __vmstat();
+				if (IS_ERR(ps)) {	/* Just pass it on */
+					buf = (void *)ps;
+					ps = NULL;
+					goto out;
+				}
+			}
+			switch (id) {
+				case NPROC_NR_DIRTY:
+					mstore(ps->nr_dirty, NPROC_NR_DIRTY,
+							buf);
+					break;
+				case NPROC_NR_WRITEBACK:
+					mstore(ps->nr_writeback,
+							NPROC_NR_WRITEBACK,
+							buf);
+					break;
+				case NPROC_NR_UNSTABLE:
+					mstore(ps->nr_unstable,
+							NPROC_NR_UNSTABLE,
+							buf);
+					break;
+				case NPROC_NR_PG_TABLE_PGS:
+					mstore(ps->nr_page_table_pages,
+							NPROC_NR_PG_TABLE_PGS,
+							buf);
+					break;
+				case NPROC_NR_MAPPED:
+					mstore(ps->nr_mapped, NPROC_NR_MAPPED,
+							buf);
+					break;
+				case NPROC_NR_SLAB:
+					mstore(ps->nr_slab, NPROC_NR_SLAB, buf);
+					break;
+			}
+			break;
+		case NPROC_MEMFREE:
+			mstore(nr_free_pages(), NPROC_MEMFREE, buf);
+			break;
+		case NPROC_PAGESIZE:
+			mstore(PAGE_SIZE, NPROC_PAGESIZE, buf);
+			break;
+		case NPROC_JIFFIES:
+			mstore(get_jiffies_64(), NPROC_JIFFIES, buf);
+			break;
+		default:
+			pwarn("Unknown field ID %#x.\n", id);
+			buf = ERR_PTR(-EINVAL);
+			goto out;
+	}
+	kfree(ps);
+out:
+	return buf;
+}
+
+static int nproc_get_global(struct nlmsghdr *nlh)
+{
+	int err, i;
+	void *errp;
+	struct sk_buff *skb2;
+	char *buf;
+	u32 fcnt, len;
+	u32 *data = NLMSG_DATA(nlh);
+	u32 *fields;
+	u32 left = nlh->nlmsg_len - sizeof(*nlh);
+
+	errp = __reply_size(data, &left, &len);
+	if (IS_ERR(errp)) {
+		err = PTR_ERR(errp);
+		goto out;
+	}
+	if (left)
+		pwarn("%d bytes left.\n", left);
+
+	fcnt = data[0];
+	fields = &data[1];
+
+	skb2 = nproc_alloc_nlmsg(nlh, len);
+	if (IS_ERR(skb2)) {
+		err = PTR_ERR(skb2);
+		goto out;
+	}
+
+	buf = NLMSG_DATA((struct nlmsghdr *)skb2->data);
+
+	for (i = 0; i < fcnt; i++) {
+		buf = nproc_global_field(fields[i], buf);
+		if (IS_ERR(buf)) {
+			err = PTR_ERR(buf);
+			kfree_skb(skb2);
+			goto out;
+		}
+	}
+
+	err = netlink_unicast(nproc_sock, skb2, nlh->nlmsg_pid, 0);
+	if (err > 0)
+		err = 0;
+out:
+	return err;
+}
+
+static int find_id(__u32 *data, __u32 *left)
+{
+	int i;
+	u32 id;
+
+	if (*left < sizeof(id))
+		goto err_inval;
+	*left -= sizeof(sizeof(id));
+
+	if (*left)
+		pwarn("%d bytes left.\n", *left);
+	id = data[1];
+
+	for (i = 0; i < ARRAY_SIZE(labels) && labels[i].id != id; i++)
+		;	/* Do nothing */
+
+	if (labels[i].id != id) {
+		pwarn("No matching label found for %#x.\n", id);
+		goto err_inval;
+	}
+
+	return i;
+
+err_inval:
+	return -EINVAL;
+}
+
+
+static int nproc_get_label(struct nlmsghdr *nlh)
+{
+	int err;
+	struct sk_buff *skb2;
+	const char *label;
+	char *buf;
+	int len;
+	u32 ltype;
+	u32 *data = NLMSG_DATA(nlh);
+	u32 left = nlh->nlmsg_len - sizeof(*nlh);
+
+	if (left < sizeof(ltype))
+		goto err_inval;
+	left -= sizeof(ltype);
+
+	ltype = data[0];
+
+	if (ltype == NPROC_LABEL_FIELD_NAME) {
+		int idx;
+		idx = find_id(data, &left);
+		if (idx < 0)
+			goto err_inval;
+		label = labels[idx].label;
+	}
+	else if (ltype == NPROC_LABEL_FIELD_UNIT) {
+		int idx;
+		idx = find_id(data, &left);
+		if (idx < 0)
+			goto err_inval;
+		label = labels[idx].unit;
+	}
+	else if (ltype == NPROC_LABEL_FIELD_FMT) {
+		int idx;
+		idx = find_id(data, &left);
+		if (idx < 0)
+			goto err_inval;
+		label = labels[idx].fmt;
+	}
+	else if (ltype == NPROC_LABEL_WCHAN) {
+		char *modname;
+		unsigned long wchan, size, offset;
+		char namebuf[128];
+
+		if (left < sizeof(unsigned long))
+			goto err_inval;
+		left -= sizeof(unsigned long);
+
+		if (left)
+			pwarn("%d bytes left.\n", left);
+
+		wchan = (unsigned long)data[1];
+		label = kallsyms_lookup(wchan, &size, &offset, &modname,
+				namebuf);
+
+		if (!label) {
+			pwarn("No ksym found for %#lx.\n", wchan);
+			goto err_inval;
+		}
+	}
+	else {
+		pwarn("Unknown label type %#x.\n", ltype);
+		goto err_inval;
+	}
+
+	len = strlen(label) + 1;
+
+	skb2 = nproc_alloc_nlmsg(nlh, len);
+	if (IS_ERR(skb2)) {
+		err = PTR_ERR(skb2);
+		goto out;
+	}
+
+	buf = NLMSG_DATA((struct nlmsghdr *)skb2->data);
+
+	strncpy(buf, label, len);
+
+	err = netlink_unicast(nproc_sock, skb2, nlh->nlmsg_pid, 0);
+	if (err > 0)
+		err = 0;
+out:
+	return err;
+
+err_inval:
+	return -EINVAL;
+}
+
+static int nproc_get_list(struct nlmsghdr *nlh)
+{
+	int err, i, cnt, len;
+	struct sk_buff *skb2;
+	u32 *buf;
+
+	cnt = ARRAY_SIZE(labels);
+	len = (cnt + 1) * sizeof(u32);
+
+	skb2 = nproc_alloc_nlmsg(nlh, len);
+	if (IS_ERR(skb2)) {
+		err = PTR_ERR(skb2);
+		goto out;
+	}
+
+	buf = NLMSG_DATA((struct nlmsghdr *)skb2->data);
+	buf[0] = cnt;
+	for (i = 0; i < cnt; i++)
+		buf[i + 1] = labels[i].id;
+
+	err = netlink_unicast(nproc_sock, skb2, nlh->nlmsg_pid, 0);
+	if (err > 0)
+		err = 0;
+out:
+	return err;
+}
+
+static __inline__ int nproc_process_msg(struct sk_buff *skb,
+		struct nlmsghdr *nlh)
+{
+	int err = 0;
+	uid_t uid;
+	kernel_cap_t caps;
+
+	if (!(nlh->nlmsg_flags & NLM_F_REQUEST))
+		goto out;
+
+	nlh->nlmsg_pid = NETLINK_CB(skb).pid;
+	uid = NETLINK_CB(skb).creds.uid;
+	caps = NETLINK_CB(skb).eff_cap;
+
+	switch (nlh->nlmsg_type) {
+		case NPROC_GET_FIELD_LIST:
+			err = nproc_get_list(nlh);
+			break;
+		case NPROC_GET_LABEL:
+			err = nproc_get_label(nlh);
+			break;
+		case NPROC_GET_GLOBAL:
+			err = nproc_get_global(nlh);
+			break;
+		case NPROC_GET_PS:
+			err = nproc_get_ps(nlh, uid);
+			break;
+		default:
+			pwarn("Unknown msg type %#x.\n", nlh->nlmsg_type);
+			err = -EINVAL;
+	}
+out:
+	return err;
+
+}
+
+static int nproc_receive_skb(struct sk_buff *skb)
+{
+	int err = 0;
+	struct nlmsghdr *nlh;
+
+	if (skb->len < NLMSG_LENGTH(0))
+		goto err_inval;
+
+	nlh = (struct nlmsghdr *)skb->data;
+	if (skb->len < nlh->nlmsg_len || nlh->nlmsg_len < sizeof(*nlh)){
+		pwarn("Invalid packet.\n");
+		goto err_inval;
+	}
+
+	err = nproc_process_msg(skb, nlh);
+	if (err || nlh->nlmsg_flags & NLM_F_ACK) {
+		pwarn("err %d, type %#x, flags %#x, seq %#x.\n", err,
+				nlh->nlmsg_type, nlh->nlmsg_flags,
+				nlh->nlmsg_seq);
+		netlink_ack(skb, nlh, err);
+	}
+
+	return err;
+
+err_inval:
+	return -EINVAL;
+}
+
+static void nproc_receive(struct sock *sk, int len)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+		nproc_receive_skb(skb);
+		kfree_skb(skb);
+	}
+}
+
+static int nproc_init(void)
+{
+	nproc_sock = netlink_kernel_create(NETLINK_NPROC, nproc_receive);
+
+	if (!nproc_sock) {
+		pwarn("No netlink socket for nproc.\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+module_init(nproc_init);
Index: mm4-2.6.9-rc1/kernel/pid.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/pid.c	2004-09-08 06:10:54.000000000 -0700
+++ mm4-2.6.9-rc1/kernel/pid.c	2004-09-08 17:45:27.504564546 -0700
@@ -148,6 +148,17 @@
 	return -1;
 }
 
+void *get_pid_map(int idx)
+{
+	pidmap_t *map = pidmap_array + idx;
+	if (!map->page)
+		return NULL;
+	else if (atomic_read(&map->nr_free) == BITS_PER_PAGE)
+		return ERR_PTR(-1);
+	else
+		return map->page;
+}
+
 struct pid * fastcall find_pid(enum pid_type type, int nr)
 {
 	struct hlist_node *elem;
