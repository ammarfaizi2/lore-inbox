Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTKZGt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 01:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTKZGt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 01:49:58 -0500
Received: from palrel12.hp.com ([156.153.255.237]:22177 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262108AbTKZGtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 01:49:53 -0500
Date: Tue, 25 Nov 2003 22:49:49 -0800
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200311260649.hAQ6nnFZ010220@napali.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: roland@redhat.com
Subject: Re: [PATCH] report user-readable fixmap area in /proc/PID/maps
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a modified and slightly expanded version of Roland's earlier
patch (see http://marc.theaimsgroup.com/?l=linux-kernel&m=106551701731039).
What's modified is that I added a gate_map() macro which evaluates to
NULL on platforms that don't use the gate DSO.  With that, the new
code in task_mmu.c will get optimized away without any ugly #ifdefs.
The other difference is that I left vm_flags at 0, rather
than turning on VM_READ+VM_EXEC.  The reason is that I wanted to
discourage apps from trying to read the fix-map area directly, because
that may or may not work (e.g., on ia64, the executable portion of the
gate-DSO is not readable).  Roland, if this is a problem for gdb's
gcore command, we need to find a better solution.

What's new is that I added a sysctl that allows setting the path of
the gate DSO so that users apps relying on /proc/PID/maps can read the
DSO contents just like any other file.  By default, the path is the
empty string.  The idea here is that there would be an init script
which dumps the kernel's gate DSO to a file and then registers the
path to that file via /proc/sys/kernel/gate_dso.  I considered several
other options, but this seems to me the most lightweight and least
intrusive solution to the problem.  Perhaps for 2.7.x the whole issue
of special kernel mappings could be revisited.

Here is a concrete example of how this works with a simple "bt" test-program
which generates a stack trace that goes across a signal-handler:

 $ ./bt # (no gate DSO registered)
 4000000000001210 <do_backtrace+0x30>
 40000000000017c0 <sighandler+0xa0>
 a0000000000207e0
 a000000000020641
 2000000800183ca0 <kill+0x20>
 4000000000001c40 <main+0x460>
 200000080015c9d0 <__libc_start_main+0x3e0>
 4000000000001000 <_start+0x80>
 $ echo /boot/gate.so > /proc/sys/kernel/gate_dso
 $ ./bt
 4000000000001210 <do_backtrace+0x30>
 40000000000017c0 <sighandler+0xa0>
 a0000000000207e0 <__kernel_sigtramp+0xc0>
 a000000000020641 <__kernel_syscall_via_break+0x1>
 2000000800183ca0 <kill+0x20>
 4000000000001990 <main+0x1b0>
 200000080015c9d0 <__libc_start_main+0x3e0>
 4000000000001000 <_start+0x80>

Note that with the gate-DSO path in /proc/PID/maps, one process can
unwind another process and still get the correct output.

	--david

===== fs/proc/task_mmu.c 1.5 vs edited =====
--- 1.5/fs/proc/task_mmu.c	Sat Aug 23 05:08:00 2003
+++ edited/fs/proc/task_mmu.c	Tue Nov 25 22:16:02 2003
@@ -1,6 +1,7 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/seq_file.h>
+#include <asm/elf.h>
 #include <asm/uaccess.h>
 
 char *task_mem(struct mm_struct *mm, char *buffer)
@@ -75,6 +76,23 @@
 	return size;
 }
 
+#ifdef AT_SYSINFO_EHDR
+
+char gate_dso_path[256] = "";
+static struct vm_area_struct gate_vmarea = {
+	/* Do _not_ mark this area as readable, cuz not the entire range may be readable
+	   (e.g., due to execute-only pages or holes) and the tools that read
+	   /proc/PID/maps should read the interesting bits from the gate-DSO file
+	   instead.  */
+	.vm_start = FIXADDR_USER_START,
+	.vm_end = FIXADDR_USER_END
+};
+
+# define gate_map()	&gate_vmarea
+#else
+# define gate_map()	NULL
+#endif
+
 static int show_map(struct seq_file *m, void *v)
 {
 	struct vm_area_struct *map = v;
@@ -100,12 +118,15 @@
 			map->vm_pgoff << PAGE_SHIFT,
 			MAJOR(dev), MINOR(dev), ino, &len);
 
-	if (map->vm_file) {
+	if (map->vm_file || map == gate_map()) {
 		len = 25 + sizeof(void*) * 6 - len;
 		if (len < 1)
 			len = 1;
 		seq_printf(m, "%*c", len, ' ');
-		seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
+		if (map == gate_map())
+			seq_printf (m, "%s", gate_dso_path);
+		else
+			seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
 	}
 	seq_putc(m, '\n');
 	return 0;
@@ -128,6 +149,8 @@
 	if (!map) {
 		up_read(&mm->mmap_sem);
 		mmput(mm);
+		if (l == -1)
+			map = gate_map();
 	}
 	return map;
 }
@@ -135,7 +158,7 @@
 static void m_stop(struct seq_file *m, void *v)
 {
 	struct vm_area_struct *map = v;
-	if (map) {
+	if (map && map != gate_map()) {
 		struct mm_struct *mm = map->vm_mm;
 		up_read(&mm->mmap_sem);
 		mmput(mm);
@@ -149,6 +172,8 @@
 	if (map->vm_next)
 		return map->vm_next;
 	m_stop(m, v);
+	if (map != gate_map())
+		return gate_map();
 	return NULL;
 }
 
===== include/linux/sysctl.h 1.53 vs edited =====
--- 1.53/include/linux/sysctl.h	Mon Nov 24 10:15:06 2003
+++ edited/include/linux/sysctl.h	Tue Nov 25 22:29:16 2003
@@ -127,6 +127,7 @@
 	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
 	KERN_HPPA_PWRSW=58,	/* int: hppa soft-power enable */
 	KERN_HPPA_UNALIGNED=59,	/* int: hppa unaligned-trap enable */
+	KERN_GATE_DSO=60,	/* string: path to gate DSO file */
 };
 
 
===== kernel/sysctl.c 1.52 vs edited =====
--- 1.52/kernel/sysctl.c	Thu Oct  9 16:25:29 2003
+++ edited/kernel/sysctl.c	Tue Nov 25 22:28:57 2003
@@ -37,6 +37,7 @@
 #include <linux/hugetlb.h>
 #include <linux/security.h>
 #include <linux/initrd.h>
+#include <asm/elf.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_ROOT_NFS
@@ -65,6 +66,9 @@
 static int maxolduid = 65535;
 static int minolduid;
 
+#ifdef AT_SYSINFO_EHDR
+extern char gate_dso_path[];
+#endif
 #ifdef CONFIG_KMOD
 extern char modprobe_path[];
 #endif
@@ -395,6 +399,17 @@
 		.strategy	= &sysctl_string,
 	},
 #endif
+#ifdef AT_SYSINFO_EHDR
+	{
+		.ctl_name	= KERN_GATE_DSO,
+		.procname	= "gate_dso",
+		.data		= &gate_dso_path,
+		.maxlen		= 256,
+		.mode		= 0644,
+		.proc_handler	= &proc_dostring,
+		.strategy	= &sysctl_string,
+	},
+#endif
 #ifdef CONFIG_CHR_DEV_SG
 	{
 		.ctl_name	= KERN_SG_BIG_BUFF,
