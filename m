Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVANWrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVANWrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVANWrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:47:15 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:63259 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261399AbVANWqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:46:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=G20tN7xIbPi63gQBOLFJQEeEzsKLGhet9Mv1MbXtLxEXlmkduYKw3zK5JJnD99WTR1EdlZUjTSRRJwYI2l/3O8ZvDWatg2yRy5zWC2yioeYIHcj/3buB7bLmXlxOeyzagoDsUNNzUbvMzMwVY24YPJKg5h5qChHDeYd4IiXwDuo=
Message-ID: <3f250c7105011414466f22fc37@mail.gmail.com>
Date: Fri, 14 Jan 2005 18:46:11 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] A new entry for /proc
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050106202339.4f9ba479.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c7105010613115554b9d9@mail.gmail.com>
	 <20050106202339.4f9ba479.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> > + extern struct seq_operations proc_pid_smaps_op;
> 
>   Put extern headers in .h files, not in .c.

Andrew, I did not put the extern headers in .h files, because I
noticed that there are other extern headers in base.c, so I think
would be better follow the code style. If it is necessary to put it in
.h file, which file do I have to put (or create a new one)?

Here goes the new PATCH.

**************************************
PATCH
**************************************

diff -urN linux-2.6.10/fs/proc/base.c linux-2.6.10-smaps/fs/proc/base.c
--- linux-2.6.10/fs/proc/base.c	2004-12-24 17:35:00.000000000 -0400
+++ linux-2.6.10-smaps/fs/proc/base.c	2005-01-14 17:07:30.000000000 -0400
@@ -11,6 +11,18 @@
  *  go into icache. We cache the reference to task_struct upon lookup too.
  *  Eventually it should become a filesystem in its own. We don't use the
  *  rest of procfs anymore.
+ *
+ *
+ *  2005
+ *  Allan Bezerra
+ *  Bruna Moreira <bruna.moreira@indt.org.br>
+ *  Edjard Mota <edjard.mota@indt.org.br>
+ *  Ilias Biris <ext-ilias.biris@indt.org.br>
+ *  Mauricio Lin <mauricio.lin@indt.org.br>
+ *
+ *  Embedded Linux Lab - 10LE Instituto Nokia de Tecnologia - INdT
+ *
+ *  A new entry smaps included in /proc. It shows the size of rss for
each memory area.
  */
 
 #include <asm/uaccess.h>
@@ -60,6 +72,7 @@
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
+	PROC_TGID_SMAPS,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TGID_SCHEDSTAT,
 #endif
@@ -86,6 +99,7 @@
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
+	PROC_TID_SMAPS,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TID_SCHEDSTAT,
 #endif
@@ -123,6 +137,7 @@
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -148,6 +163,7 @@
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -497,6 +513,25 @@
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
@@ -1341,6 +1376,11 @@
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
diff -urN linux-2.6.10/fs/proc/task_mmu.c linux-2.6.10-smaps/fs/proc/task_mmu.c
--- linux-2.6.10/fs/proc/task_mmu.c	2004-12-24 17:34:01.000000000 -0400
+++ linux-2.6.10-smaps/fs/proc/task_mmu.c	2005-01-14 16:35:38.000000000 -0400
@@ -81,6 +81,72 @@
 	return 0;
 }
 
+static void resident_mem_size(struct mm_struct *mm, unsigned long
start_address,
+			unsigned long end_address, unsigned long *size) {
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *ptep, pte;
+	unsigned long each_page;
+
+	for (each_page = start_address; each_page < end_address; each_page
+= PAGE_SIZE) {
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
@@ -134,3 +200,10 @@
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


The smaps was used to verify the memory consumption of gecko rendering
engine and has presented interesting results in a detailed way. Below
is the link to access the graphics generated by the application that
reads from /proc/pid/smaps.

http://www.manaos.org/10le/smaps.html

BR,

Mauricio Lin.
