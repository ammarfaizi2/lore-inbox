Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVAXWUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVAXWUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVAXWRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:17:40 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:43563 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261698AbVAXWOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:14:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KdSztPwlyMk0yZwlDNInDFx8V6uXMWpl7H7zmLMgsPBQG82j37a+XFxM3UsijTWmf++1LmiqzLcCvUWFyAl45JZMbTa+ljF0rJzrjF9ffZ8WOocjX2PDYmQAoyNPYzwTfhtBJ0lURPsU0uSlbuTXUtJEJPMbbDWDY63vbzdhQiM=
Message-ID: <3f250c7105012414144c059fab@mail.gmail.com>
Date: Mon, 24 Jan 2005 18:14:23 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] A new entry for /proc
Cc: Andrew Morton <akpm@osdl.org>, Mauricio Lin <mauricio.lin@indt.org.br>,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
In-Reply-To: <20050117173023.GA22202@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c7105010613115554b9d9@mail.gmail.com>
	 <20050106202339.4f9ba479.akpm@osdl.org>
	 <3f250c7105011414466f22fc37@mail.gmail.com>
	 <20050114154209.6b712e55.akpm@osdl.org>
	 <3f250c71050117100332774211@mail.gmail.com>
	 <3f250c71050117110241dfc46c@mail.gmail.com>
	 <20050117173023.GA22202@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tosatti and Andrew,

On Mon, 17 Jan 2005 15:30:23 -0200, Marcelo Tosatti
<marcelo.tosatti@cyclades.com> wrote:
> 
> Hi Mauricio,
> 
> You want to update your patch to handle the new 4level pagetables which introduces
> a new indirection table: the PUD.

Here goes the smaps patch updated for kernel 2.6.11-rc2-bk2 with PUD included.


diff -uprN linux-2.6.11-rc2/Documentation/filesystems/proc.txt
linux-2.6.11-rc2-smaps/Documentation/filesystems/proc.txt
--- linux-2.6.11-rc2/Documentation/filesystems/proc.txt	2004-12-24
17:34:29.000000000 -0400
+++ linux-2.6.11-rc2-smaps/Documentation/filesystems/proc.txt	2005-01-24
17:15:03.000000000 -0400
@@ -133,6 +133,7 @@ Table 1-1: Process specific entries in /
  statm   Process memory status information              
  status  Process status in human readable form          
  wchan   If CONFIG_KALLSYMS is set, a pre-decoded wchan
+ smaps	 Extension of maps, presenting the rss size for each mapped file
 ..............................................................................
 
 For example, to get the status information of a process, all you have to do is
diff -uprN linux-2.6.11-rc2/Makefile linux-2.6.11-rc2-smaps/Makefile
--- linux-2.6.11-rc2/Makefile	2005-01-24 17:42:02.000000000 -0400
+++ linux-2.6.11-rc2-smaps/Makefile	2005-01-24 11:57:42.000000000 -0400
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 11
-EXTRAVERSION = -rc2-bk2
+EXTRAVERSION = -rc2-bk2-smaps
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -uprN linux-2.6.11-rc2/fs/proc/base.c linux-2.6.11-rc2-smaps/fs/proc/base.c
--- linux-2.6.11-rc2/fs/proc/base.c	2005-01-24 17:41:51.000000000 -0400
+++ linux-2.6.11-rc2-smaps/fs/proc/base.c	2005-01-24 17:02:37.000000000 -0400
@@ -11,6 +11,24 @@
  *  go into icache. We cache the reference to task_struct upon lookup too.
  *  Eventually it should become a filesystem in its own. We don't use the
  *  rest of procfs anymore.
+ *
+ *
+ *  Changelog:
+ *  24-Jan-2005
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
@@ -61,6 +79,7 @@ enum pid_directory_inos {
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
+	PROC_TGID_SMAPS,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TGID_SCHEDSTAT,
 #endif
@@ -87,6 +106,7 @@ enum pid_directory_inos {
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
+	PROC_TID_SMAPS,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TID_SCHEDSTAT,
 #endif
@@ -124,6 +144,7 @@ static struct pid_entry tgid_base_stuff[
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -149,6 +170,7 @@ static struct pid_entry tid_base_stuff[]
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -456,6 +478,26 @@ static struct file_operations proc_maps_
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
+
 extern struct seq_operations mounts_op;
 static int mounts_open(struct inode *inode, struct file *file)
 {
@@ -1300,6 +1342,10 @@ static struct dentry *proc_pident_lookup
 		case PROC_TGID_MOUNTS:
 			inode->i_fop = &proc_mounts_operations;
 			break;
+		case PROC_TID_SMAPS:
+		case PROC_TGID_SMAPS:
+			inode->i_fop = &proc_smaps_operations;
+			break;
 #ifdef CONFIG_SECURITY
 		case PROC_TID_ATTR:
 			inode->i_nlink = 2;
diff -uprN linux-2.6.11-rc2/fs/proc/task_mmu.c
linux-2.6.11-rc2-smaps/fs/proc/task_mmu.c
--- linux-2.6.11-rc2/fs/proc/task_mmu.c	2005-01-24 17:41:51.000000000 -0400
+++ linux-2.6.11-rc2-smaps/fs/proc/task_mmu.c	2005-01-24
12:06:23.000000000 -0400
@@ -113,6 +113,77 @@ static int show_map(struct seq_file *m, 
 	return 0;
 }
 
+static void resident_mem_size(struct mm_struct *mm,
+			      unsigned long start_address,
+			      unsigned long end_address,
+			      unsigned long *size)
+{
+	pgd_t *pgd;
+	pud_t *pud;
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
+		pud = pud_offset(pgd, each_page);
+		if (pud_none(*pud) || unlikely(pud_bad(*pud)))
+			continue;
+
+		pmd = pmd_offset(pud, each_page);
+		if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
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
@@ -166,3 +237,10 @@ struct seq_operations proc_pid_maps_op =
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


Let me know about any suggestions.

BR,

Mauricio Lin.
