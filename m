Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267502AbUIJPgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267502AbUIJPgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267495AbUIJPfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:35:51 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:2547 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S267494AbUIJPe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:34:56 -0400
Date: Fri, 10 Sep 2004 17:30:30 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040910153030.GA4121@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909184300.GA28278@k3.hellgate.ch> <20040909184933.GG3106@holomorphy.com> <20040909191142.GA30151@k3.hellgate.ch> <20040909192313.GK3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909192313.GK3106@holomorphy.com>
X-Operating-System: Linux 2.6.9-rc1-mm4nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2004 12:23:13 -0700, William Lee Irwin III wrote:
> feasible, of course. I'll wait for your updates to follow up further.

Incremental update below. It contains a reorganization of the field
IDs (something I expected to do based on feedback) and minor tweaks in
error handling.

I'll post a full patch once the MMU stuff is sorted out.

Roger

diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 linux-2.6.9-rc1-mm4.01/include/linux/nproc.h linux-2.6.9-rc1-mm4.02/include/linux/nproc.h
--- linux-2.6.9-rc1-mm4.01/include/linux/nproc.h	2004-09-10 17:19:34.018727960 +0200
+++ linux-2.6.9-rc1-mm4.02/include/linux/nproc.h	2004-09-10 14:43:13.000000000 +0200
@@ -49,35 +49,57 @@
 #define NPROC_LABEL_FIELD_UNIT	0x00000003
 #define NPROC_LABEL_WCHAN	0x00000004
 
-/* Field IDs (unique key in bits 0 - 15) */
-#define NPROC_NOP_UL		(0x00000020 | NPROC_TYPE_UL)
-#define NPROC_PID		(0x00000001 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
-#define NPROC_NAME		(0x00000002 | NPROC_TYPE_STRING | NPROC_SCOPE_PROCESS)
-/* Amount of free memory (pages) */
-#define NPROC_MEMFREE		(0x00000004 | NPROC_TYPE_U32    | NPROC_SCOPE_GLOBAL)
-/* Size of a page (bytes) */
-#define NPROC_PAGESIZE		(0x00000005 | NPROC_TYPE_U32    | NPROC_SCOPE_GLOBAL)
+/* --------------------------------------------------------------------- misc */
 /* There's no guarantee about anything with jiffies. Still useful for some. */
-#define NPROC_JIFFIES		(0x00000006 | NPROC_TYPE_U64    | NPROC_SCOPE_GLOBAL)
-/* Process: VM size (KiB) */
-#define NPROC_VMSIZE		(0x00000010 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
-/* Process: locked memory (KiB) */
-#define NPROC_VMLOCK		(0x00000011 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
-/* Process: Memory resident size (KiB) */
-#define NPROC_VMRSS		(0x00000012 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
-#define NPROC_VMDATA		(0x00000013 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
-#define NPROC_VMSTACK		(0x00000014 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
-#define NPROC_VMEXE		(0x00000015 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
-#define NPROC_VMLIB		(0x00000016 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
-#define NPROC_UID		(0x00000018 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
-#define NPROC_NR_DIRTY		(0x00000051 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
-#define NPROC_NR_WRITEBACK	(0x00000052 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
-#define NPROC_NR_UNSTABLE	(0x00000053 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
-#define NPROC_NR_PG_TABLE_PGS	(0x00000054 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
-#define NPROC_NR_MAPPED		(0x00000055 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
-#define NPROC_NR_SLAB		(0x00000056 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
-#define NPROC_WCHAN		(0x00000080 | NPROC_TYPE_UL     | NPROC_SCOPE_PROCESS)
-#define NPROC_WCHAN_NAME	(0x00000081 | NPROC_TYPE_STRING)
+#define NPROC_JIFFIES		(0x00000001 | NPROC_TYPE_U64    | NPROC_SCOPE_GLOBAL)
+/* Field IDs (unique key in bits 0 - 15) */
+#define NPROC_NOP_UL		(0x00000002 | NPROC_TYPE_UL)
+/* Size of a page */
+#define NPROC_PAGESIZE		(0x00000003 | NPROC_TYPE_U32    | NPROC_SCOPE_GLOBAL)
+/* --------------------------------------------------------- /proc/PID/status */
+#define NPROC_NAME		(0x00000100 | NPROC_TYPE_STRING | NPROC_SCOPE_PROCESS)
+#define NPROC_STATE		(0x00000101 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_STATE_NAME	(0x00000102 | NPROC_TYPE_STRING)
+#define NPROC_SLEEP_TIME	(0x00000103 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_TOTAL_TIME	(0x00000104 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_PID		(0x00000105 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_TGID		(0x00000106 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_PPID		(0x00000107 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_TRACER_PID	(0x00000108 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_UID		(0x00000109 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_EUID		(0x00000110 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_SUID		(0x00000111 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_FSUID		(0x00000112 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_GID		(0x00000113 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_EGID		(0x00000114 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_SGID		(0x00000115 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_FSGID		(0x00000116 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+/* Process: VM size */
+#define NPROC_VMSIZE		(0x00000117 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+/* Process: locked memory */
+#define NPROC_VMLOCK		(0x00000118 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+/* Process: Memory resident size */
+#define NPROC_VMRSS		(0x00000119 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_VMDATA		(0x00000120 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_VMSTACK		(0x00000121 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_VMEXE		(0x00000122 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+#define NPROC_VMLIB		(0x00000123 | NPROC_TYPE_U32    | NPROC_SCOPE_PROCESS)
+/* ------------------------------------------------------------- /proc/vmstat */
+#define NPROC_NR_DIRTY		(0x00000214 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_WRITEBACK	(0x00000215 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_UNSTABLE	(0x00000216 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_PG_TABLE_PGS	(0x00000217 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_MAPPED		(0x00000218 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+#define NPROC_NR_SLAB		(0x00000219 | NPROC_TYPE_UL     | NPROC_SCOPE_GLOBAL)
+/* ------------------------------------------------------------ /proc/meminfo */
+/* Amount of free memory */
+#define NPROC_MEMFREE		(0x00000320 | NPROC_TYPE_U32    | NPROC_SCOPE_GLOBAL)
+/* ---------------------------------------------------------- /proc/PID/wchan */
+#define NPROC_WCHAN		(0x00000421 | NPROC_TYPE_UL     | NPROC_SCOPE_PROCESS)
+#define NPROC_WCHAN_NAME	(0x00000422 | NPROC_TYPE_STRING)
+/* ----------------------------------------------------------- /proc/PID/stat */
+/* ---------------------------------------------------------- /proc/PID/statm */
+
 
 #ifdef __KERNEL__
 struct nproc_field {
@@ -88,11 +110,11 @@ struct nproc_field {
 };
 
 static struct nproc_field labels[] = {
-	{ NPROC_PID,			"PID",		"%5u",	"" },
-	{ NPROC_NAME,			"Name",		"%-15s","" },
-	{ NPROC_MEMFREE,		"MemFree",	"%8u",	"page" },
-	{ NPROC_PAGESIZE,		"PageSize",	"%4u",	"byte" },
 	{ NPROC_JIFFIES,		"Jiffies",	"%10u",	"" },
+	{ NPROC_PAGESIZE,		"PageSize",	"%4u",	"byte" },
+	{ NPROC_NAME,			"Name",		"%-15s","" },
+	{ NPROC_PID,			"PID",		"%5u",	"" },
+	{ NPROC_UID,			"UID",		"%5u",	"" },
 	{ NPROC_VMSIZE,			"VmSize",	"%8u",	"KiB" },
 	{ NPROC_VMLOCK,			"VmLock",	"%8u",	"KiB" },
 	{ NPROC_VMRSS,			"VmRSS",	"%8u",	"KiB" },
@@ -100,16 +122,16 @@ static struct nproc_field labels[] = {
 	{ NPROC_VMSTACK,		"VmStack",	"%8u",	"KiB" },
 	{ NPROC_VMEXE,			"VmExe",	"%8u",	"KiB" },
 	{ NPROC_VMLIB,			"VmLib",	"%8u",	"KiB" },
-	{ NPROC_UID,			"UID",		"%5u",	"" },
 	{ NPROC_NR_DIRTY,		"nr_dirty",	"%8d",	"page" },
 	{ NPROC_NR_WRITEBACK,		"nr_writeback",	"%8u",	"page" },
 	{ NPROC_NR_UNSTABLE,		"nr_unstable",	"%8u",	"page" },
 	{ NPROC_NR_PG_TABLE_PGS,	"nr_page_table_pages",	"%8u", "page" },
 	{ NPROC_NR_MAPPED,		"nr_mapped",	"%8u",	"page" },
 	{ NPROC_NR_SLAB,		"nr_slab",	"%8u",	"page" },
+	{ NPROC_MEMFREE,		"MemFree",	"%8u",	"page" },
 	{ NPROC_WCHAN,			"wchan",	"%p",	"" },
 #ifdef CONFIG_KALLSYMS
-	{ NPROC_WCHAN_NAME,		"wchan_symbol",	"%s"},
+	{ NPROC_WCHAN_NAME,		"wchan_symbol",	"%s",	""},
 #endif
 };
 #endif /* __KERNEL__ */
diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 linux-2.6.9-rc1-mm4.01/kernel/nproc.c linux-2.6.9-rc1-mm4.02/kernel/nproc.c
--- linux-2.6.9-rc1-mm4.01/kernel/nproc.c	2004-09-10 17:19:34.034725528 +0200
+++ linux-2.6.9-rc1-mm4.02/kernel/nproc.c	2004-09-10 12:04:28.000000000 +0200
@@ -17,12 +17,11 @@
 /* There must be like 5 million dprintk definitions, so let's add some more */
 #ifdef DEBUG
 #define pdebug(x,args...) printk(KERN_DEBUG "%s:%d " x, __func__ , __LINE__, ##args)
-#define pwarn(x,args...) printk(KERN_WARNING "%s:%d " x, __func__ , __LINE__, ##args)
 #else
 #define pdebug(x,args...)
-#define pwarn(x,args...)
 #endif
 
+#define pwarn(x,args...) printk(KERN_WARNING "%s:%d " x, __func__ , __LINE__, ##args)
 #define perror(x,args...) printk(KERN_ERR "%s:%d " x, __func__ , __LINE__, ##args)
 
 static struct sock *nproc_sock = NULL;
@@ -129,18 +128,18 @@ static struct sk_buff *nproc_alloc_nlmsg
 	struct sk_buff *skb2 = 0;
 
 	skb2 = alloc_skb(NLMSG_SPACE(len), GFP_KERNEL);
-	if (!skb2) {
-		skb2 = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	if (!skb2)
+		goto err_out;
 
 	NLMSG_PUT(skb2, pid, seq, type, NLMSG_ALIGN(len));
-out:
-	return skb2;
+	goto out;
 
 nlmsg_failure:				/* Used by NLMSG_PUT */
 	kfree_skb(skb2);
-	return NULL;
+err_out:
+	skb2 = ERR_PTR(-ENOMEM);
+out:
+	return skb2;
 }
 
 #define mstore(value, id, buf)						\
@@ -634,18 +633,17 @@ static int find_id(__u32 *data, __u32 *l
 		pwarn("%d bytes left.\n", *left);
 	id = data[1];
 
-	for (i = 0; i < ARRAY_SIZE(labels) && labels[i].id != id; i++)
-		;	/* Do nothing */
-
-	if (labels[i].id != id) {
-		pwarn("No matching label found for %#x.\n", id);
-		goto err_inval;
+	for (i = 0; i < ARRAY_SIZE(labels); i++) {
+		if (labels[i].id == id)
+			goto out;
 	}
 
-	return i;
+	pwarn("No matching label found for %#x.\n", id);
 
 err_inval:
 	return -EINVAL;
+out:
+	return i;
 }
 
 
diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 linux-2.6.9-rc1-mm4.01/init/Kconfig linux-2.6.9-rc1-mm4.02/init/Kconfig
--- linux-2.6.9-rc1-mm4.01/init/Kconfig	2004-09-10 17:19:34.040724616 +0200
+++ linux-2.6.9-rc1-mm4.02/init/Kconfig	2004-09-10 00:32:36.000000000 +0200
@@ -141,10 +141,11 @@ config SYSCTL
 
 config NPROC
 	bool "Netlink interface to /proc information"
-	depends on PROC_FS && EXPERIMENTAL
+	depends on EXPERIMENTAL && !CONFIG_SECURITY
 	default y
 	help
-	  Nproc is a netlink interface to /proc information.
+	  Nproc is a netlink interface to /proc information. Its benefits
+	  are clean semantics and high performance.
 
 config AUDIT
 	bool "Auditing support"
