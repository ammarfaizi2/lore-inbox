Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbVAQTDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVAQTDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVAQTDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:03:01 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:57457 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262624AbVAQTCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:02:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dH0pmBbvR3voISpd+PXb4nDRWImFcXgUFBA1yl9Tdo5NtkTRp4lvfaKMOF+0apFSmrX3IJ9OzcNzMAC7YkdXWeFl9W8nP9gZpZoal4aAXI3fMdia7Ysj3lgqrPVq7p5fa+pqdPWTwzWJTcARugpn2KUeo50POgAznrbYu2CL+Rk=
Message-ID: <3f250c71050117110241dfc46c@mail.gmail.com>
Date: Mon, 17 Jan 2005 15:02:14 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Andrew Morton <akpm@osdl.org>, Mauricio Lin <mauricio.lin@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] A new entry for /proc
In-Reply-To: <3f250c71050117100332774211@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c7105010613115554b9d9@mail.gmail.com>
	 <20050106202339.4f9ba479.akpm@osdl.org>
	 <3f250c7105011414466f22fc37@mail.gmail.com>
	 <20050114154209.6b712e55.akpm@osdl.org>
	 <3f250c71050117100332774211@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I figured out the error. This patch works for others editors as well.


diff -uprN linux-2.6.10/Documentation/filesystems/proc.txt
linux-2.6.10-smaps/Documentation/filesystems/proc.txt
--- linux-2.6.10/Documentation/filesystems/proc.txt	2004-12-24
17:34:29.000000000 -0400
+++ linux-2.6.10-smaps/Documentation/filesystems/proc.txt	2005-01-17
11:29:31.000000000 -0400
@@ -133,6 +133,7 @@ Table 1-1: Process specific entries in /
  statm   Process memory status information              
  status  Process status in human readable form          
  wchan   If CONFIG_KALLSYMS is set, a pre-decoded wchan
+ smaps	 Extension of maps, presenting the rss size for each mapped file
 ..............................................................................
 
 For example, to get the status information of a process, all you have to do is
diff -uprN linux-2.6.10/fs/proc/base.c linux-2.6.10-smaps/fs/proc/base.c
--- linux-2.6.10/fs/proc/base.c	2004-12-24 17:35:00.000000000 -0400
+++ linux-2.6.10-smaps/fs/proc/base.c	2005-01-17 12:11:01.000000000 -0400
@@ -11,6 +11,24 @@
  *  go into icache. We cache the reference to task_struct upon lookup too.
  *  Eventually it should become a filesystem in its own. We don't use the
  *  rest of procfs anymore.
+ *
+ *
+ *  Changelog:
+ *  17-Jan-2005
+ *  Allan Bezerra
+ *  Bruna Moreira <bruna.moreira@indt.org.br>
+ *  Edjard Mota <edjard.mota@indt.org.br>
+ *  Ilias Biris <ext-ilias.biris@indt.org.br>
+ *  Mauricio Lin <mauricio.lin@indt.org.br>
+ *
+ *  Embedded Linux Lab - 10LE Instituto Nokia de Tecnologia - INdT
+ *
+ *  A new process specific entry (smaps) included in /proc. It shows the
+ *  size of rss for each memory area. The maps entry lacks information
+ *  about physical memory size (rss) for each mapped file, i.e.,
+ *  rss information for executables and library files.
+ *  This additional information is useful for any tools that need to know
+ *  about physical memory consumption for a process specific library.
  */
 
 #include <asm/uaccess.h>
@@ -60,6 +78,7 @@ enum pid_directory_inos {
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
+	PROC_TGID_SMAPS,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TGID_SCHEDSTAT,
 #endif
@@ -86,6 +105,7 @@ enum pid_directory_inos {
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
+	PROC_TID_SMAPS,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TID_SCHEDSTAT,
 #endif
@@ -123,6 +143,7 @@ static struct pid_entry tgid_base_stuff[
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -148,6 +169,7 @@ static struct pid_entry tid_base_stuff[]
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -497,6 +519,25 @@ static struct file_operations proc_maps_
 	.release	= seq_release,
 };
 
+extern struct seq_operations proc_pid_smaps_op;
+static int smaps_open(struct inode *inode, struct file *file)
+{
+	struct task_struct *task = proc_task(inode);
+	int ret = seq_open(file, &proc_pid_smaps_op);
+	if (!ret) {
+		struct seq_file *m = file->private_data;
+		m->private = task;
+	}
+	return ret;
+}
+
+static struct file_operations proc_smaps_operations = {
+	.open		= smaps_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 extern struct seq_operations mounts_op;
 static int mounts_open(struct inode *inode, struct file *file)
 {
@@ -1341,6 +1382,11 @@ static struct dentry *proc_pident_lookup
 		case PROC_TGID_MOUNTS:
 			inode->i_fop = &proc_mounts_operations;
 			break;
+		case PROC_TID_SMAPS:
+		case PROC_TGID_SMAPS:
+			inode->i_fop = &proc_smaps_operations;
+			break;
+
 #ifdef CONFIG_SECURITY
 		case PROC_TID_ATTR:
 			inode->i_nlink = 2;
diff -uprN linux-2.6.10/fs/proc/task_mmu.c linux-2.6.10-smaps/fs/proc/task_mmu.c
--- linux-2.6.10/fs/proc/task_mmu.c	2004-12-24 17:34:01.000000000 -0400
+++ linux-2.6.10-smaps/fs/proc/task_mmu.c	2005-01-17 14:55:17.000000000 -0400
@@ -81,6 +81,76 @@ static int show_map(struct seq_file *m, 
 	return 0;
 }
 
+static void resident_mem_size(struct mm_struct *mm,
+			      unsigned long start_address,
+			      unsigned long end_address,
+			      unsigned long *size)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *ptep, pte;
+	unsigned long each_page;
+
+	for (each_page = start_address; each_page < end_address; 
+	     each_page += PAGE_SIZE) {
+		pgd = pgd_offset(mm, each_page);
+		if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+			continue;
+
+		pmd = pmd_offset(pgd, each_page);
+
+		if (pmd_none(*pmd))
+			continue;
+
+		if (unlikely(pmd_bad(*pmd)))
+			continue;
+
+		if (pmd_present(*pmd)) {
+			ptep = pte_offset_map(pmd, each_page);
+			if (!ptep)
+				continue;
+			pte = *ptep;
+			pte_unmap(ptep);
+			if (pte_present(pte))
+				*size += PAGE_SIZE;
+		}
+	}
+}
+
+static int show_smap(struct seq_file *m, void *v)
+{
+	struct vm_area_struct *map = v;
+	struct file *file = map->vm_file;
+	int flags = map->vm_flags;
+	struct mm_struct *mm = map->vm_mm;
+	unsigned long rss = 0;
+	unsigned long vma_len = (map->vm_end - map->vm_start) >> 10;
+	
+	if (mm) {
+		resident_mem_size(mm, map->vm_start, map->vm_end, &rss);
+	}
+
+	seq_printf(m, "%08lx-%08lx %c%c%c%c ",
+			map->vm_start,
+			map->vm_end,
+			flags & VM_READ ? 'r' : '-',
+			flags & VM_WRITE ? 'w' : '-',
+			flags & VM_EXEC ? 'x' : '-',
+			flags & VM_MAYSHARE ? 's' : 'p');
+
+	if (map->vm_file)
+		seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
+
+	seq_putc(m, '\n');
+	
+	seq_printf(m, "Size:%8lu kB\n"
+			"Rss:%8lu kB\n",
+			vma_len,
+			rss >> 10);
+	
+	return 0;
+}
+
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct task_struct *task = m->private;
@@ -134,3 +204,10 @@ struct seq_operations proc_pid_maps_op =
 	.stop	= m_stop,
 	.show	= show_map
 };
+
+struct seq_operations proc_pid_smaps_op = {
+	.start	= m_start,
+	.next	= m_next,
+	.stop	= m_stop,
+	.show	= show_smap
+};
