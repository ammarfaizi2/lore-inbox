Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVCCO0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVCCO0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 09:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVCCO0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 09:26:35 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:40967 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261766AbVCCOXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 09:23:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZCCRYmfQRFlXnzgFEPI6emH+EMZPouYyUV0o9jhcbNVEBTgfS7YfZ67QbDdVyZIvuI7isAvVfy+pef9xmdADZsZaTSJweqR69ZaFXRlpOuf2RrOMqKIWXKl6HaBCEy3VZ1dIHIZ9x3eLDaIud4RE8oqtOSZw5af6momxCth+jPc=
Message-ID: <3f250c7105030306235472eb2c@mail.gmail.com>
Date: Thu, 3 Mar 2005 10:23:24 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] A new entry for /proc
Cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, rrebel@whenu.com,
       marcelo.tosatti@cyclades.com, nickpiggin@yahoo.com.au
In-Reply-To: <Pine.LNX.4.61.0503031151180.8280@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106202339.4f9ba479.akpm@osdl.org>
	 <3f250c7105022801564a0d0e13@mail.gmail.com>
	 <Pine.LNX.4.61.0502282029470.28484@goblin.wat.veritas.com>
	 <3f250c7105030100085ab86bd2@mail.gmail.com>
	 <3f250c710503010617537a3ca@mail.gmail.com>
	 <3f250c710503010744390391e2@mail.gmail.com>
	 <3f250c71050302042059f36525@mail.gmail.com>
	 <Pine.LNX.4.61.0503021858330.5183@goblin.wat.veritas.com>
	 <3f250c710503022325af22974@mail.gmail.com>
	 <Pine.LNX.4.61.0503031151180.8280@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am sending some modifications about smaps PATCH.

BTW, thanks Hugh by all your suggestions. The page_table_lock was
already included in the smaps.

BR,

Mauricio Lin.


diff -uprN linux-2.6.11-rc4-bk9/Documentation/filesystems/proc.txt
linux-2.6.11-rc4-bk9-smaps/Documentation/filesystems/proc.txt
--- linux-2.6.11-rc4-bk9/Documentation/filesystems/proc.txt	2005-02-28
06:24:09.000000000 -0400
+++ linux-2.6.11-rc4-bk9-smaps/Documentation/filesystems/proc.txt	2005-02-28
06:28:10.000000000 -0400
@@ -133,6 +133,7 @@ Table 1-1: Process specific entries in /
  statm   Process memory status information              
  status  Process status in human readable form          
  wchan   If CONFIG_KALLSYMS is set, a pre-decoded wchan
+ smaps	 Extension based on maps, presenting the rss size for each mapped file
 ..............................................................................
 
 For example, to get the status information of a process, all you have to do is
diff -uprN linux-2.6.11-rc4-bk9/Makefile linux-2.6.11-rc4-bk9-smaps/Makefile
--- linux-2.6.11-rc4-bk9/Makefile	2005-02-28 06:24:59.000000000 -0400
+++ linux-2.6.11-rc4-bk9-smaps/Makefile	2005-02-28 06:28:10.000000000 -0400
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 11
-EXTRAVERSION = -rc4-bk9
+EXTRAVERSION = -rc4-bk9-smaps
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -uprN linux-2.6.11-rc4-bk9/fs/proc/base.c
linux-2.6.11-rc4-bk9-smaps/fs/proc/base.c
--- linux-2.6.11-rc4-bk9/fs/proc/base.c	2005-02-28 06:24:41.000000000 -0400
+++ linux-2.6.11-rc4-bk9-smaps/fs/proc/base.c	2005-02-28
06:28:10.000000000 -0400
@@ -11,6 +11,28 @@
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
+ *  
+ *  Changelog:
+ *  21-Feb-2005
+ *  Embedded Linux Lab - 10LE Instituto Nokia de Tecnologia - INdT 
  */
 
 #include <asm/uaccess.h>
@@ -61,6 +83,7 @@ enum pid_directory_inos {
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
+	PROC_TGID_SMAPS,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TGID_SCHEDSTAT,
 #endif
@@ -92,6 +115,7 @@ enum pid_directory_inos {
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
+	PROC_TID_SMAPS,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TID_SCHEDSTAT,
 #endif
@@ -134,6 +158,7 @@ static struct pid_entry tgid_base_stuff[
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -164,6 +189,7 @@ static struct pid_entry tid_base_stuff[]
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -488,6 +514,25 @@ static struct file_operations proc_maps_
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
@@ -1447,6 +1492,10 @@ static struct dentry *proc_pident_lookup
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
diff -uprN linux-2.6.11-rc4-bk9/fs/proc/task_mmu.c
linux-2.6.11-rc4-bk9-smaps/fs/proc/task_mmu.c
--- linux-2.6.11-rc4-bk9/fs/proc/task_mmu.c	2005-02-28 06:24:41.000000000 -0400
+++ linux-2.6.11-rc4-bk9-smaps/fs/proc/task_mmu.c	2005-02-28
06:32:33.000000000 -0400
@@ -113,6 +113,142 @@ static int show_map(struct seq_file *m, 
 	return 0;
 }
 
+static void smaps_pte_range(pmd_t *pmd,
+			    unsigned long address,
+			    unsigned long size,
+			    unsigned long *rss)
+{
+	pte_t * pte;
+	unsigned long end;
+	
+	if (pmd_none(*pmd))
+		return;
+	if (unlikely(pmd_bad(*pmd))) {
+		pmd_ERROR(*pmd);
+		pmd_clear(pmd);
+		return;
+	}
+	pte = pte_offset_map(pmd, address);
+	address &= ~PMD_MASK;
+	end = address + size;
+	if (end > PMD_SIZE)
+		end = PMD_SIZE;
+	do {
+		pte_t page = *pte;
+
+		address += PAGE_SIZE;
+		pte++;
+		if (pte_none(page) || (!pte_present(page)))
+			continue;
+		*rss += PAGE_SIZE;
+		
+	} while (address < end);
+	pte_unmap(pte);
+}
+
+static void smaps_pmd_range(pud_t *pud,
+			    unsigned long address,
+			    unsigned long size,
+			    unsigned long *rss)
+{
+	pmd_t *pmd;
+	unsigned long end;
+
+	if (pud_none(*pud))
+		return;
+	if (unlikely(pud_bad(*pud))) {
+		pud_ERROR(*pud);
+		pud_clear(pud);
+		return;
+	}
+	pmd = pmd_offset(pud, address);
+	address &= ~PUD_MASK;
+	end = address + size;
+	if (end > PUD_SIZE)
+		end = PUD_SIZE;
+	do {
+		smaps_pte_range(pmd, address, end - address, rss);
+		address = (address + PMD_SIZE) & PMD_MASK;
+		pmd++;
+	} while (address < end);
+}
+
+static void smaps_pud_range(pgd_t *pgd,
+			    unsigned long address,
+			    unsigned long size,
+			    unsigned long *rss)
+{
+	pud_t *pud;
+	unsigned long end;
+	
+	if (pgd_none(*pgd))
+		return;
+	if (unlikely(pgd_bad(*pgd))) {
+		pgd_ERROR(*pgd);
+		pgd_clear(pgd);
+		return;
+	}
+	pud = pud_offset(pgd, address);
+	address &= ~PGDIR_MASK;
+	end = address + size;
+	if (end > PGDIR_SIZE)
+		end = PGDIR_SIZE;
+	do {
+		smaps_pmd_range(pud, address, end - address, rss);
+		address = (address + PUD_SIZE) & PUD_MASK;
+		pud++;
+	} while (address < end);
+}
+
+static void smaps_pgd_range(pgd_t *pgd,
+			    unsigned long start_address,
+			    unsigned long end_address,
+			    unsigned long *rss)
+{
+	do {
+		smaps_pud_range(pgd, start_address, end_address - start_address, rss);
+		start_address = (start_address + PGDIR_SIZE) & PGDIR_MASK;
+		pgd++;
+	} while (start_address < end_address);
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
+		spin_lock(&mm->page_table_lock);
+		pgd_t *pgd = pgd_offset(mm, map->vm_start);		
+		smaps_pgd_range(pgd, map->vm_start, map->vm_end, &rss);
+		spin_unlock(&mm->page_table_lock);
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
@@ -166,3 +302,10 @@ struct seq_operations proc_pid_maps_op =
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
