Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUH0M1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUH0M1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 08:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUH0M1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 08:27:24 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:2785 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S264147AbUH0MZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 08:25:43 -0400
Date: Fri, 27 Aug 2004 14:24:35 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Cc: Albert Cahalan <albert@users.sf.net>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
Subject: [1/2][PATCH] nproc: netlink access to /proc information
Message-ID: <20040827122435.GA20334@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827122412.GA20052@k3.hellgate.ch>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current code duplicates some data gathering logic from elsewhere
in the kernel. The code can be trivially shared if the exisiting users
in proc split data gathering and string creation.

The patch should apply against any current 2.6 kernel.

 include/linux/netlink.h |    1 
 include/linux/nproc.h   |   93 ++++++
 init/Kconfig            |    7 
 kernel/Makefile         |    1 
 kernel/nproc.c          |  690 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 792 insertions(+)

diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 linux-2.6.8/include/linux/netlink.h linux-2.6.8-nproc/include/linux/netlink.h
--- linux-2.6.8/include/linux/netlink.h	2004-08-27 10:08:20.000000000 +0200
+++ linux-2.6.8-nproc/include/linux/netlink.h	2004-08-27 10:20:07.000000000 +0200
@@ -15,6 +15,7 @@
 #define NETLINK_ARPD		8
 #define NETLINK_AUDIT		9	/* auditing */
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
+#define NETLINK_NPROC		12	/* /proc information */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
 #define NETLINK_TAPBASE		16	/* 16 to 31 are ethertap */
diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 linux-2.6.8/include/linux/nproc.h linux-2.6.8-nproc/include/linux/nproc.h
--- linux-2.6.8/include/linux/nproc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8-nproc/include/linux/nproc.h	2004-08-27 10:20:07.000000000 +0200
@@ -0,0 +1,93 @@
+#ifndef _LINUX_NPROC_H
+#define _LINUX_NPROC_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_NPROC
+
+#define NPROC_BASE		0x10
+#define NPROC_GET_LIST		(NPROC_BASE+0)
+#define NPROC_GET_LABEL		(NPROC_BASE+1)
+#define NPROC_GET_GLOBAL	(NPROC_BASE+2)
+#define NPROC_GET_PS		(NPROC_BASE+3)
+
+#define NPROC_SCOPE_MASK	0xF0000000
+#define NPROC_SCOPE_GLOBAL	0x10000000	/* Global w/o arguments */
+#define NPROC_SCOPE_PROCESS	0x20000000
+#define NPROC_SCOPE_LABEL	0x30000000
+
+#define NPROC_TYPE_MASK		0x0F000000
+#define NPROC_TYPE_STRING	0x01000000
+#define NPROC_TYPE_U32		0x02000000
+#define NPROC_TYPE_UL		0x03000000
+#define NPROC_TYPE_U64		0x04000000
+
+#define NPROC_SELECT_ALL	0x00000001
+#define NPROC_SELECT_PID	0x00000002
+#define NPROC_SELECT_UID	0x00000003
+
+#define NPROC_LABEL_FIELD	0x00000001
+#define NPROC_LABEL_KSYM	0x00000002
+
+struct nproc_field {
+	__u32 id;
+	const char *label;
+};
+
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
+#define NPROC_NR_DIRTY		(0x00000051 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_WRITEBACK	(0x00000052 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_UNSTABLE	(0x00000053 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_PG_TABLE_PGS	(0x00000054 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_MAPPED		(0x00000055 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_SLAB		(0x00000056 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_WCHAN		(0x00000100 | NPROC_TYPE_UL     | NPROC_SCOPE_PROCESS)
+#define NPROC_WCHAN_NAME	(0x00000101 | NPROC_TYPE_STRING)
+
+#ifdef __KERNEL__
+static struct nproc_field labels[] = {
+	{ NPROC_PID,			"PID" },
+	{ NPROC_NAME,			"Name" },
+	{ NPROC_MEMFREE,		"MemFree" },
+	{ NPROC_PAGESIZE,		"PageSize" },
+	{ NPROC_JIFFIES,		"Jiffies" },
+	{ NPROC_VMSIZE,			"VmSize" },
+	{ NPROC_VMLOCK,			"VmLock" },
+	{ NPROC_VMRSS,			"VmRSS" },
+	{ NPROC_VMDATA,			"VmData" },
+	{ NPROC_VMSTACK,		"VmStack" },
+	{ NPROC_VMEXE,			"VmExe" },
+	{ NPROC_VMLIB,			"VmLib" },
+	{ NPROC_NR_DIRTY,		"nr_dirty" },
+	{ NPROC_NR_WRITEBACK,		"nr_writeback" },
+	{ NPROC_NR_UNSTABLE,		"nr_unstable" },
+	{ NPROC_NR_PG_TABLE_PGS,	"nr_page_table_pages" },
+	{ NPROC_NR_MAPPED,		"nr_mapped" },
+	{ NPROC_NR_SLAB,		"nr_slab" },
+	{ NPROC_WCHAN,			"wchan" },
+#ifdef CONFIG_KALLSYMS
+	{ NPROC_WCHAN_NAME,		"wchan_symbol" },
+#endif
+};
+#endif /* __KERNEL__ */
+
+#endif /* CONFIG_NPROC */
+
+#endif /* _LINUX_NPROC_H */
diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 linux-2.6.8/kernel/Makefile linux-2.6.8-nproc/kernel/Makefile
--- linux-2.6.8/kernel/Makefile	2004-08-27 10:08:20.000000000 +0200
+++ linux-2.6.8-nproc/kernel/Makefile	2004-08-27 10:20:07.000000000 +0200
@@ -15,6 +15,7 @@ obj-$(CONFIG_SMP) += cpu.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
+obj-$(CONFIG_NPROC) += nproc.o
 obj-$(CONFIG_PM) += power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_COMPAT) += compat.o
diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 linux-2.6.8/kernel/nproc.c linux-2.6.8-nproc/kernel/nproc.c
--- linux-2.6.8/kernel/nproc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8-nproc/kernel/nproc.c	2004-08-27 10:20:07.000000000 +0200
@@ -0,0 +1,690 @@
+/*
+ * nproc.c
+ *
+ * netlink interface to /proc information.
+ *
+ */
+
+#include <linux/skbuff.h>
+#include <net/sock.h>
+#include <linux/swap.h>		/* nr_free_pages() */
+#include <linux/kallsyms.h>	/* kallsyms_lookup() */
+#include <linux/nproc.h>
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
+void __task_mem(struct task_struct *tsk, struct task_mem *res)
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
+	}
+}
+
+void __task_mem_cheap(struct task_struct *tsk, struct task_mem_cheap *res)
+{
+	struct mm_struct *mm = get_task_mm(tsk);
+	if (mm) {
+		res->vmsize = mm->total_vm << (PAGE_SHIFT-10);
+		res->vmlock = mm->locked_vm << (PAGE_SHIFT-10);
+		res->vmrss = mm->rss << (PAGE_SHIFT-10);
+		mmput(mm);
+	}
+}
+
+/*
+ * page_alloc.c already has an extra function broken out to fill a
+ * struct with information. Cool. Not sure whether pgpgin/pgpgout
+ * should be left as is or nailed down as kbytes.
+ */
+struct page_state *__vmstat(void)
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
+struct sk_buff *nproc_alloc_nlmsg(struct nlmsghdr *nlh, u32 len)
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
+	goto out;
+
+nlmsg_failure:				/* Used by NLMSG_PUT */
+	kfree_skb(skb2);
+	skb2 = NULL;
+out:
+	return skb2;
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
+/*
+ * Build and send a netlink msg for one PID.
+ */
+int nproc_pid_fields(struct nlmsghdr *nlh, u32 *fdata, u32 len, task_t *tsk)
+{
+	int i;
+	int err;
+	struct task_mem tsk_mem;
+	struct task_mem_cheap tsk_mem_cheap;
+	u32 fcnt = fdata[0];
+	u32 *fields = &fdata[1];
+	struct sk_buff *skb2;
+	char *buf;
+	struct nlmsghdr *nlh2;
+
+	tsk_mem.vmdata = (~0);
+	tsk_mem_cheap.vmsize = (~0);
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
+		switch (fields[i]) {
+			case NPROC_PID:
+				mstore(tsk->pid, NPROC_PID, buf);
+				break;
+			case NPROC_VMSIZE:
+			case NPROC_VMLOCK:
+			case NPROC_VMRSS:
+				if (tsk_mem_cheap.vmsize == (~0))
+					__task_mem_cheap(tsk, &tsk_mem_cheap);
+				switch (fields[i]) {
+					case NPROC_VMSIZE:
+						mstore(tsk_mem_cheap.vmsize, NPROC_VMSIZE, buf);
+						break;
+					case NPROC_VMLOCK:
+						mstore(tsk_mem_cheap.vmlock, NPROC_VMLOCK, buf);
+						break;
+					case NPROC_VMRSS:
+						mstore(tsk_mem_cheap.vmrss, NPROC_VMRSS, buf);
+						break;
+				}
+				break;
+			case NPROC_VMDATA:
+			case NPROC_VMSTACK:
+			case NPROC_VMEXE:
+			case NPROC_VMLIB:
+				if (tsk_mem.vmdata == (~0))
+					__task_mem(tsk, &tsk_mem);
+				switch (fields[i]) {
+					case NPROC_VMDATA:
+						mstore(tsk_mem.vmdata, NPROC_VMDATA, buf);
+						break;
+					case NPROC_VMSTACK:
+						mstore(tsk_mem.vmstack, NPROC_VMSTACK, buf);
+						break;
+					case NPROC_VMEXE:
+						mstore(tsk_mem.vmexe, NPROC_VMEXE, buf);
+						break;
+					case NPROC_VMLIB:
+						mstore(tsk_mem.vmlib, NPROC_VMLIB, buf);
+						break;
+				}
+				break;
+			case NPROC_JIFFIES:
+				mstore(get_jiffies_64(), NPROC_JIFFIES, buf);
+				break;
+			case NPROC_WCHAN:
+				mstore(get_wchan(tsk), NPROC_WCHAN, buf);
+				pdebug("pid %d wchan: %lu.\n", tsk->pid,
+						get_wchan(tsk));
+				break;
+			case NPROC_NAME:
+				mstore(sizeof(tsk->comm), NPROC_TYPE_U32, buf);
+				strncpy(buf, tsk->comm, sizeof(tsk->comm));
+				buf += sizeof(tsk->comm);
+				break;
+			default:
+				pwarn("Unknown field %#x.\n", fields[i]);
+		}
+	}
+	err = netlink_unicast(nproc_sock, skb2, nlh2->nlmsg_pid, MSG_DONTWAIT);
+	if (err > 0)
+		err = 0;
+out:
+	return err;
+}
+
+/*
+ * Iterate over a list of PIDs.
+ */
+int nproc_select_pid(struct nlmsghdr *nlh, u32 left, u32 *fdata, u32 len, u32 *sdata)
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
+	pids = &sdata[1];
+
+	for (i = 0; i < tcnt; i++) {
+		task_t *tsk;
+		tsk = find_task_by_pid(pids[i]);
+		pdebug("task found for pid %d: %s.\n", pids[i], tsk->comm);
+		if (!tsk) {
+			err = -ESRCH;
+			goto out;
+		}
+		err = nproc_pid_fields(nlh, fdata, len, tsk);
+	}
+
+out:
+	return err;
+
+err_inval:
+	return -EINVAL;
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
+	pdebug("for %d fields:\n", fcnt);
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
+ * Call the chosen process selector. Not much to choose from right now.
+ */
+static int nproc_get_ps(struct sk_buff *skb, struct nlmsghdr *nlh)
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
+	switch (*sdata) {
+#if 0
+		case NPROC_SELECT_ALL:
+			err = nproc_select_all(nlh, data, len, sdata + 1);
+			break;
+#endif
+		case NPROC_SELECT_PID:
+			err = nproc_select_pid(nlh, left, data, len,
+					sdata + 1);
+			break;
+#if 0
+		case NPROC_SELECT_UID:
+			err = nproc_select_uid(sdata + 1);
+			break;
+#endif
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
+static int nproc_get_global(struct nlmsghdr *nlh)
+{
+	int err, i, len;
+	void *errp;
+	struct sk_buff *skb2;
+	char *buf;
+	u32 fcnt;
+	struct page_state *ps = NULL;
+	u32 *data = NLMSG_DATA(nlh);
+	u32 *fields;
+	u32 left = nlh->nlmsg_len - sizeof(*nlh);
+
+	errp = __reply_size(data, &left, &len);
+	if (IS_ERR(errp)) {
+		err = PTR_ERR(errp);
+		goto out;
+	}
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
+		u32 id = fields[i];
+		switch (id) {
+			case NPROC_NR_DIRTY:
+			case NPROC_NR_WRITEBACK:
+			case NPROC_NR_UNSTABLE:
+			case NPROC_NR_PG_TABLE_PGS:
+			case NPROC_NR_MAPPED:
+			case NPROC_NR_SLAB:
+				if (!ps)
+					ps = __vmstat();
+				switch (id) {
+					case NPROC_NR_DIRTY:
+						mstore(ps->nr_dirty, NPROC_NR_DIRTY, buf);
+						break;
+					case NPROC_NR_WRITEBACK:
+						mstore(ps->nr_writeback, NPROC_NR_WRITEBACK, buf);
+						break;
+					case NPROC_NR_UNSTABLE:
+						mstore(ps->nr_unstable, NPROC_NR_UNSTABLE, buf);
+						break;
+					case NPROC_NR_PG_TABLE_PGS:
+						mstore(ps->nr_page_table_pages, NPROC_NR_PG_TABLE_PGS, buf);
+						break;
+					case NPROC_NR_MAPPED:
+						mstore(ps->nr_mapped, NPROC_NR_MAPPED, buf);
+						break;
+					case NPROC_NR_SLAB:
+						mstore(ps->nr_slab, NPROC_NR_SLAB, buf);
+						break;
+				}
+				break;
+			case NPROC_MEMFREE:
+				mstore(nr_free_pages(), NPROC_MEMFREE, buf);
+				break;
+			case NPROC_PAGESIZE:
+				mstore(PAGE_SIZE, NPROC_PAGESIZE, buf);
+				break;
+			case NPROC_JIFFIES:
+				mstore(get_jiffies_64(), NPROC_JIFFIES, buf);
+				break;
+			default:
+				pwarn("Unknown field requested %#x.\n",
+						fields[i]);
+				goto err_inval;
+		}
+	}
+
+	err = netlink_unicast(nproc_sock, skb2, nlh->nlmsg_pid, MSG_DONTWAIT);
+	if (err > 0)
+		err = 0;
+out:
+	kfree(ps);
+	return err;
+
+err_inval:
+	kfree(ps);
+	return -EINVAL;
+}
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
+
+	ltype = data[0];
+	left -= sizeof(ltype);
+
+	if (ltype == NPROC_LABEL_FIELD) {
+		int i;
+		u32 id;
+		
+		if (left < sizeof(id))
+			goto err_inval;
+
+		id = data[1];
+
+		for (i = 0; i < ARRAY_SIZE(labels) && labels[i].id != id; i++)
+			;	/* Do nothing */
+
+		if (labels[i].id != id) {
+			pwarn("No matching label found for %#x.\n", id);
+			goto err_inval;
+		}
+
+		label = labels[i].label;
+
+	}
+	else if (ltype == NPROC_LABEL_KSYM) {
+		char *modname;
+		unsigned long wchan, size, offset;
+		char namebuf[128];
+		if (left < sizeof(unsigned long))
+			goto err_inval;
+
+		wchan = (unsigned long)data[1];
+		label = kallsyms_lookup(wchan, &size, &offset, &modname,
+				namebuf);
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
+	err = netlink_unicast(nproc_sock, skb2, nlh->nlmsg_pid, MSG_DONTWAIT);
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
+	err = netlink_unicast(nproc_sock, skb2, nlh->nlmsg_pid, MSG_DONTWAIT);
+	if (err > 0)
+		err = 0;
+out:
+	return err;
+}
+
+static __inline__ int nproc_process_msg(struct sk_buff *skb,
+		struct nlmsghdr *nlh)
+{
+	int err;
+
+	if (!(nlh->nlmsg_flags & NLM_F_REQUEST))
+		return 0;
+
+	nlh->nlmsg_pid = NETLINK_CB(skb).pid;
+
+	switch (nlh->nlmsg_type) {
+		case NPROC_GET_LIST:
+			err = nproc_get_list(nlh);
+			break;
+		case NPROC_GET_LABEL:
+			err = nproc_get_label(nlh);
+			break;
+		case NPROC_GET_GLOBAL:
+			err = nproc_get_global(nlh);
+			break;
+		case NPROC_GET_PS:
+			err = nproc_get_ps(skb, nlh);
+			break;
+		default:
+			pwarn("Unknown msg type %#x.\n", nlh->nlmsg_type);
+			err = -EINVAL;
+	}
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
+		pdebug("err %d, type %#x, flags %#x, seq %#x.\n", err,
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
+		perror("No netlink socket for nproc.\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+module_init(nproc_init);
diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 linux-2.6.8/init/Kconfig linux-2.6.8-nproc/init/Kconfig
--- linux-2.6.8/init/Kconfig	2004-08-27 13:33:21.680899010 +0200
+++ linux-2.6.8-nproc/init/Kconfig	2004-08-27 13:28:33.104788111 +0200
@@ -141,6 +141,13 @@ config SYSCTL
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
