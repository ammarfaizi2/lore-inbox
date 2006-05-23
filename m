Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWEWABh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWEWABh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 20:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWEWABh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 20:01:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53380 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751328AbWEWABf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 20:01:35 -0400
Date: Tue, 23 May 2006 02:01:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Zachary Amsden <zach@vmware.com>, jakub@redhat.com,
       rusty@rustcorp.com.au, kraxel@suse.de, linux-kernel@vger.kernel.org
Subject: [patch 2/3] vdso: improve print_fatal_signals support by adding memory maps
Message-ID: <20060523000126.GC9934@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

improved the print-fatal-signals debug output:

hotplug/825: potentially unexpected fatal signal 11.
code at ffffe400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
vDSO at b7f41000

Pid: 825, comm:              hotplug
EIP: 0073:[<ffffe400>] CPU: 0
EIP is at 0xffffe400
 ESP: 007b:bff52910 EFLAGS: 00010246    Not tainted  (2.6.17-rc4 #91)
EAX: 000000af EBX: 00000000 ECX: 00000000 EDX: 080f341c
ESI: 00000008 EDI: 41c9eff4 EBP: bff529ac DS: 007b ES: 007b
CR0: 8005003b CR2: ffffe40f CR3: 372a3000 CR4: 00000680
 [<c0103fad>] show_trace+0xd/0x10
 [<c0101637>] show_regs+0x177/0x180
 [<c0123d13>] get_signal_to_deliver+0x3f3/0x7d0
 [<c010278c>] do_notify_resume+0x1bc/0x750
 [<c0102ebe>] work_notifysig+0x13/0x19

08047000-080e9000 r-xp 00000000 03:01 3547392    /bin/bash
080e9000-080ef000 rw-p 000a1000 03:01 3547392    /bin/bash
080ef000-080f4000 rw-p 080ef000 00:00 0          [heap]
41b5a000-41b73000 r-xp 00000000 03:01 846154     /lib/ld-2.3.90.so
41b73000-41b74000 r--p 00018000 03:01 846154     /lib/ld-2.3.90.so
41b74000-41b75000 rw-p 00019000 03:01 846154     /lib/ld-2.3.90.so
41b77000-41c9d000 r-xp 00000000 03:01 846155     /lib/libc-2.3.90.so
41c9d000-41c9f000 r--p 00125000 03:01 846155     /lib/libc-2.3.90.so
41c9f000-41ca1000 rw-p 00127000 03:01 846155     /lib/libc-2.3.90.so
41ca1000-41ca3000 rw-p 41ca1000 00:00 0
41ccc000-41cce000 r-xp 00000000 03:01 846157     /lib/libdl-2.3.90.so
41cce000-41ccf000 r--p 00001000 03:01 846157     /lib/libdl-2.3.90.so
41ccf000-41cd0000 rw-p 00002000 03:01 846157     /lib/libdl-2.3.90.so
41dce000-41dd1000 r-xp 00000000 03:01 846175     /lib/libtermcap.so.2.0.8
41dd1000-41dd2000 rw-p 00002000 03:01 846175     /lib/libtermcap.so.2.0.8
b7f29000-b7f2a000 rw-p b7f29000 00:00 0
b7f40000-b7f41000 rw-p b7f40000 00:00 0
b7f41000-b7f42000 r-xp b7f41000 00:00 0          [vdso]
bff3e000-bff53000 rw-p bff3e000 00:00 0          [stack]

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>
---
 kernel/signal.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 2 deletions(-)

Index: linux-vdso-rand.q/kernel/signal.c
===================================================================
--- linux-vdso-rand.q.orig/kernel/signal.c
+++ linux-vdso-rand.q/kernel/signal.c
@@ -16,6 +16,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
@@ -763,7 +764,95 @@ out_set:
 #define LEGACY_QUEUE(sigptr, sig) \
 	(((sig) < SIGRTMIN) && sigismember(&(sigptr)->signal, (sig)))
 
-int print_fatal_signals = 0;
+int print_fatal_signals;
+
+static void pad_len_spaces(int len)
+{
+	len = 25 + sizeof(void*) * 6 - len;
+
+	if (len < 1)
+		len = 1;
+
+	printk("%*c", len, ' ');
+}
+
+static int print_vma(struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct file *file = vma->vm_file;
+	int flags = vma->vm_flags;
+	unsigned long ino = 0;
+	dev_t dev = 0;
+	int len;
+
+	if (file) {
+		struct inode *inode = vma->vm_file->f_dentry->d_inode;
+		dev = inode->i_sb->s_dev;
+		ino = inode->i_ino;
+	}
+
+	printk("%08lx-%08lx %c%c%c%c %08lx %02x:%02x %lu %n",
+			vma->vm_start,
+			vma->vm_end,
+			flags & VM_READ ? 'r' : '-',
+			flags & VM_WRITE ? 'w' : '-',
+			flags & VM_EXEC ? 'x' : '-',
+			flags & VM_MAYSHARE ? 's' : 'p',
+			vma->vm_pgoff << PAGE_SHIFT,
+			MAJOR(dev), MINOR(dev), ino, &len);
+
+	/*
+	 * Print the dentry name for named mappings, and a
+	 * special [heap] marker for the heap:
+	 */
+	if (file) {
+#define SIZE 128
+		char tmp[SIZE], *str;
+
+		str = d_path(file->f_dentry, file->f_vfsmnt, tmp, SIZE);
+		while (str[0] && (str[0] == ' '))
+			str++;
+
+		pad_len_spaces(len);
+		printk("%s", str);
+	} else {
+		const char *name = arch_vma_name(vma);
+		if (!name) {
+			if (mm) {
+				if (vma->vm_start <= mm->start_brk &&
+						vma->vm_end >= mm->brk) {
+					name = "[heap]";
+				} else if (vma->vm_start <= mm->start_stack &&
+					   vma->vm_end >= mm->start_stack) {
+					name = "[stack]";
+				}
+			} else {
+				name = "[vdso]";
+			}
+		}
+		if (name) {
+			pad_len_spaces(len);
+			printk(name);
+		}
+	}
+	printk("\n");
+
+	return 0;
+}
+
+static void print_vmas(void)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
+
+	if (!mm)
+		return;
+
+	down_read(&mm->mmap_sem);
+	for (vma = mm->mmap; vma; vma = vma->vm_next)
+		print_vma(vma);
+	up_read(&mm->mmap_sem);
+}
 
 static void print_fatal_signal(struct pt_regs *regs, int signr)
 {
@@ -781,9 +870,13 @@ static void print_fatal_signal(struct pt
 			printk("%02x ", insn);
 		}
 	}
-#endif
 	printk("\n");
+	if (current->mm)
+		printk("vDSO at %p\n", current->mm->context.vdso);
+#endif
 	show_regs(regs);
+	printk("\n");
+	print_vmas();
 }
 
 static int __init setup_print_fatal_signals(char *str)
