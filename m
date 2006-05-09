Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWEIHPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWEIHPX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 03:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWEIHPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 03:15:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:25035 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751440AbWEIHPW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 03:15:22 -0400
Date: Tue, 9 May 2006 12:45:23 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: [RFC] [PATCH 6/6] Kprobes: Remove breakpoints from the copied pages
Message-ID: <20060509071523.GF22493@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060509065455.GA11630@in.ibm.com> <20060509065917.GA22493@in.ibm.com> <20060509070106.GB22493@in.ibm.com> <20060509070508.GC22493@in.ibm.com> <20060509070911.GD22493@in.ibm.com> <20060509071204.GE22493@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509071204.GE22493@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the breakpoints if the pages read from the page
cache contains breakpoints. If the pages containing the breakpoints
is copied from the page cache, the copied image would also contain
breakpoints in them. This could be a major problem for tools like
tripwire etc and cause security concerns, hence must be prevented.
This patch hooks up the actor routine, checks if the executable was
a probed executable using the file inode and then replaces the
breakpoints with the original opcodes in the copied image.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


 fs/nfsd/vfs.c              |    4 +++-
 include/asm-i386/kprobes.h |    1 +
 include/linux/fs.h         |    9 ++++++---
 include/linux/kprobes.h    |   17 ++++++++++++++++-
 kernel/uprobes.c           |   39 +++++++++++++++++++++++++++++++++++++++
 mm/filemap.c               |   17 ++++++++++++++---
 mm/shmem.c                 |    2 +-
 7 files changed, 80 insertions(+), 9 deletions(-)

diff -puN kernel/uprobes.c~kprobes_userspace_probes-remove-breakpoints-on-copy kernel/uprobes.c
--- linux-2.6.17-rc3-mm1/kernel/uprobes.c~kprobes_userspace_probes-remove-breakpoints-on-copy	2006-05-09 12:43:21.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/kernel/uprobes.c	2006-05-09 12:43:21.000000000 +0530
@@ -300,6 +300,45 @@ struct uprobe_module __kprobes *get_modu
 	return NULL;
 }
 
+/*
+ * This routine checks if the given page contains breakpoints. It first
+ * checks if the file read is a probed executable and later checks
+ * if the page being read contains breakpoints. This routine is
+ * used by file_read_actor();
+ */
+void remove_uprobe_breakpoints(struct address_space *mapping,
+				struct page *page, unsigned long offset,
+				read_descriptor_t *desc, unsigned long size)
+{
+	struct inode *inode = mapping->host;
+	struct page *upage;
+	struct uprobe_module *umodule = NULL;
+	struct uprobe *uprobe = NULL;
+	struct hlist_node *node;
+	unsigned long page_off, ret;
+
+	mutex_lock(&uprobe_mutex);
+	umodule = get_module_by_inode(inode);
+	if (!umodule)
+		goto out;
+	hlist_for_each_entry(uprobe, node, &umodule->ulist_head, ulist) {
+		upage = find_get_page(mapping,
+				uprobe->offset >> PAGE_CACHE_SHIFT);
+		if (upage == page) {
+			page_off = uprobe->offset & ~PAGE_MASK;
+			if ((page_off >= offset) &&
+					(page_off < (offset + PAGE_SIZE)) &&
+					((page_off - offset) <= size))
+				ret = __copy_to_user(desc->arg.buf +
+						(page_off - offset),
+						&(uprobe->kp.opcode),
+						sizeof(kprobe_opcode_t));
+		}
+	}
+out:
+	mutex_unlock(&uprobe_mutex);
+}
+
 static inline void insert_readpage_uprobe(struct page *page,
 	struct address_space *mapping, struct uprobe *uprobe)
 {
diff -puN mm/filemap.c~kprobes_userspace_probes-remove-breakpoints-on-copy mm/filemap.c
--- linux-2.6.17-rc3-mm1/mm/filemap.c~kprobes_userspace_probes-remove-breakpoints-on-copy	2006-05-09 12:43:21.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/mm/filemap.c	2006-05-09 12:43:21.000000000 +0530
@@ -31,6 +31,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/cpuset.h>
+#include <linux/kprobes.h>
 #include "filemap.h"
 #include "internal.h"
 
@@ -884,7 +885,7 @@ page_ok:
 		 * "pos" here (the actor routine has to update the user buffer
 		 * pointers and the remaining count).
 		 */
-		ret = actor(desc, page, offset, nr);
+		ret = actor(desc, page, offset, nr, mapping);
 		offset += ret;
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
@@ -1012,7 +1013,8 @@ out:
 EXPORT_SYMBOL(do_generic_mapping_read);
 
 int file_read_actor(read_descriptor_t *desc, struct page *page,
-			unsigned long offset, unsigned long size)
+			unsigned long offset, unsigned long size,
+			struct address_space *mapping)
 {
 	char *kaddr;
 	unsigned long left, count = desc->count;
@@ -1043,6 +1045,13 @@ int file_read_actor(read_descriptor_t *d
 		desc->error = -EFAULT;
 	}
 success:
+#ifdef CONFIG_KPROBES
+	/*
+	 * Check if the data copied to the buffer contains breakpoint
+	 * and overwrite the breakpoints with appropriate opcodes.
+	 */
+	remove_uprobe_breakpoints(mapping, page, offset, desc, size);
+#endif
 	desc->count = count - size;
 	desc->written += size;
 	desc->arg.buf += size;
@@ -1159,7 +1168,9 @@ generic_file_read(struct file *filp, cha
 
 EXPORT_SYMBOL(generic_file_read);
 
-int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
+int file_send_actor(read_descriptor_t * desc, struct page *page,
+			unsigned long offset, unsigned long size,
+			struct address_space *mapping)
 {
 	ssize_t written;
 	unsigned long count = desc->count;
diff -puN mm/shmem.c~kprobes_userspace_probes-remove-breakpoints-on-copy mm/shmem.c
--- linux-2.6.17-rc3-mm1/mm/shmem.c~kprobes_userspace_probes-remove-breakpoints-on-copy	2006-05-09 12:43:21.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/mm/shmem.c	2006-05-09 12:43:21.000000000 +0530
@@ -1588,7 +1588,7 @@ static void do_shmem_file_read(struct fi
 		 * "pos" here (the actor routine has to update the user buffer
 		 * pointers and the remaining count).
 		 */
-		ret = actor(desc, page, offset, nr);
+		ret = actor(desc, page, offset, nr, mapping);
 		offset += ret;
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
diff -puN fs/nfsd/vfs.c~kprobes_userspace_probes-remove-breakpoints-on-copy fs/nfsd/vfs.c
--- linux-2.6.17-rc3-mm1/fs/nfsd/vfs.c~kprobes_userspace_probes-remove-breakpoints-on-copy	2006-05-09 12:43:21.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/fs/nfsd/vfs.c	2006-05-09 12:43:21.000000000 +0530
@@ -785,7 +785,9 @@ found:
  * directrly. They will be released after the sending has completed.
  */
 static int
-nfsd_read_actor(read_descriptor_t *desc, struct page *page, unsigned long offset , unsigned long size)
+nfsd_read_actor(read_descriptor_t *desc, struct page *page,
+		unsigned long offset, unsigned long size,
+		struct address_space *mapping)
 {
 	unsigned long count = desc->count;
 	struct svc_rqst *rqstp = desc->arg.data;
diff -puN include/linux/kprobes.h~kprobes_userspace_probes-remove-breakpoints-on-copy include/linux/kprobes.h
--- linux-2.6.17-rc3-mm1/include/linux/kprobes.h~kprobes_userspace_probes-remove-breakpoints-on-copy	2006-05-09 12:43:21.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/include/linux/kprobes.h	2006-05-09 12:43:21.000000000 +0530
@@ -205,13 +205,13 @@ extern void copy_kprobe(struct kprobe *o
 extern int arch_copy_uprobe(struct kprobe *p, kprobe_opcode_t *address);
 extern void arch_arm_uprobe(kprobe_opcode_t *address);
 extern void arch_disarm_uprobe(struct kprobe *p, kprobe_opcode_t *address);
-extern void init_uprobes(void);
 
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
 struct kprobe *get_kprobe(void *addr);
 struct kprobe *get_uprobe(void *addr);
 extern int arch_alloc_insn(struct kprobe *p);
 struct hlist_head * kretprobe_inst_table_head(struct task_struct *tsk);
+struct uprobe_module *get_module_by_inode(struct inode *inode);
 
 /* kprobe_running() will just return the current_kprobe on this CPU */
 static inline struct kprobe *kprobe_running(void)
@@ -239,6 +239,21 @@ static inline void reset_uprobe_instance
 	current_uprobe = NULL;
 }
 
+#ifdef ARCH_SUPPORTS_UPROBES
+extern void init_uprobes(void);
+extern void remove_uprobe_breakpoints(struct address_space *mapping,
+				struct page *page, unsigned long offset,
+				read_descriptor_t *desc, unsigned long size);
+#else
+static inline void init_uprobes(void)
+{
+}
+static inline void remove_uprobe_breakpoints(struct address_space *mapping,
+				struct page *page, unsigned long offset,
+				read_descriptor_t *desc, unsigned long size)
+{
+}
+#endif
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int setjmp_pre_handler(struct kprobe *, struct pt_regs *);
diff -puN include/asm-i386/kprobes.h~kprobes_userspace_probes-remove-breakpoints-on-copy include/asm-i386/kprobes.h
--- linux-2.6.17-rc3-mm1/include/asm-i386/kprobes.h~kprobes_userspace_probes-remove-breakpoints-on-copy	2006-05-09 12:43:21.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/include/asm-i386/kprobes.h	2006-05-09 12:43:21.000000000 +0530
@@ -46,6 +46,7 @@ typedef u8 kprobe_opcode_t;
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 #define ARCH_SUPPORTS_KRETPROBES
 #define  ARCH_INACTIVE_KPROBE_COUNT 0
+#define ARCH_SUPPORTS_UPROBES
 
 void arch_remove_kprobe(struct kprobe *p);
 void kretprobe_trampoline(void);
diff -puN include/linux/fs.h~kprobes_userspace_probes-remove-breakpoints-on-copy include/linux/fs.h
--- linux-2.6.17-rc3-mm1/include/linux/fs.h~kprobes_userspace_probes-remove-breakpoints-on-copy	2006-05-09 12:43:21.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/include/linux/fs.h	2006-05-09 12:43:21.000000000 +0530
@@ -998,7 +998,8 @@ typedef struct {
 	int error;
 } read_descriptor_t;
 
-typedef int (*read_actor_t)(read_descriptor_t *, struct page *, unsigned long, unsigned long);
+typedef int (*read_actor_t)(read_descriptor_t *, struct page *, unsigned long,
+					unsigned long, struct address_space *);
 
 /* These macros are for out of kernel modules to test that
  * the kernel supports the unlocked_ioctl and compat_ioctl
@@ -1595,8 +1596,10 @@ extern int sb_min_blocksize(struct super
 
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
-extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
-extern int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
+extern int file_read_actor(read_descriptor_t * desc, struct page *page,
+		unsigned long offset, unsigned long size, struct address_space *mapping);
+extern int file_send_actor(read_descriptor_t * desc, struct page *page,
+		unsigned long offset, unsigned long size, struct address_space *mapping);
 extern ssize_t generic_file_read(struct file *, char __user *, size_t, loff_t *);
 int generic_write_checks(struct file *file, loff_t *pos, size_t *count, int isblk);
 extern ssize_t generic_file_write(struct file *, const char __user *, size_t, loff_t *);

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
