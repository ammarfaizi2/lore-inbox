Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVD2SjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVD2SjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 14:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVD2SjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 14:39:17 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:46529 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262878AbVD2Sgy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 14:36:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fBBeFM0/rosjSSCikgS5MufLxSLj8gX4SHCh4lSQWE31MDqfsd/59MDkShwPBNj1UoEj518MPC+XnZELkz9TatD0nj7xa2ra+ZtcdUbooNydBUeTnyhZg1GXpGt11hJ2lsQTNv9cJxLNjoQ89m21mAP1YsME4iTdOJTiPmq/ogc=
Message-ID: <3f250c71050429113616a55f28@mail.gmail.com>
Date: Fri, 29 Apr 2005 14:36:54 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] A new entry for /proc
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050106202339.4f9ba479.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3f250c7105010613115554b9d9@mail.gmail.com>
	 <20050106202339.4f9ba479.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I sent some months ago the PATCH about smaps entry. Here is the new
one with more features included. People that want to perform a memory
consumption analysing can use it mainly if someone needs to figure out
which libraries can be reduced for embedded systems. So the new
features are the physical size of shared and clean [or dirty]; private
and clean [or dirty]. Do you think this is important for Linux
community?

Take a look the example below:

# cat /proc/4576/smaps

08048000-080dc000 r-xp /bin/bash
Size:               592 KB
Rss:                500 KB
Shared_Clean:       500 KB
Shared_Dirty:         0 KB
Private_Clean:        0 KB
Private_Dirty:        0 KB
080dc000-080e2000 rw-p /bin/bash
Size:                24 KB
Rss:                 24 KB
Shared_Clean:         0 KB
Shared_Dirty:         0 KB
Private_Clean:        0 KB
Private_Dirty:       24 KB
080e2000-08116000 rw-p 
Size:               208 KB
Rss:                208 KB
Shared_Clean:         0 KB
Shared_Dirty:         0 KB
Private_Clean:        0 KB
Private_Dirty:      208 KB
b7e2b000-b7e34000 r-xp /lib/tls/libnss_files-2.3.2.so
Size:                36 KB
Rss:                 12 KB
Shared_Clean:        12 KB
Shared_Dirty:         0 KB
Private_Clean:        0 KB
Private_Dirty:        0 KB
...

Here goes the patch:

diff -uprN linux-2.6.11.7/Documentation/filesystems/proc.txt
linux-2.6.11.7-smaps/Documentation/filesystems/proc.txt
--- linux-2.6.11.7/Documentation/filesystems/proc.txt	2005-04-07
14:57:27.000000000 -0400
+++ linux-2.6.11.7-smaps/Documentation/filesystems/proc.txt	2005-04-29
11:10:16.000000000 -0400
@@ -133,6 +133,7 @@ Table 1-1: Process specific entries in /
  statm   Process memory status information              
  status  Process status in human readable form          
  wchan   If CONFIG_KALLSYMS is set, a pre-decoded wchan
+ smaps	 Extension based on maps, presenting the rss size for each mapped file
 ..............................................................................
 
 For example, to get the status information of a process, all you have to do is
diff -uprN linux-2.6.11.7/fs/proc/base.c linux-2.6.11.7-smaps/fs/proc/base.c
--- linux-2.6.11.7/fs/proc/base.c	2005-04-07 14:57:45.000000000 -0400
+++ linux-2.6.11.7-smaps/fs/proc/base.c	2005-04-29 11:10:16.000000000 -0400
@@ -11,6 +11,40 @@
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
+ *  Ilias Biris <ilias.biris@indt.org.br>
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
+ *  Pud inclusion in the page table walking.
+ *
+ *  ChangeLog:
+ *  10-Mar-2005
+ *  10LE Instituto Nokia de Tecnologia - INdT:
+ *  A better way to walks through the page table as suggested by Hugh Dickins.
+ *
+ *  Simo Piiroinen <simo.piiroinen@nokia.com>:
+ *  Smaps information related to shared, private, clean and dirty pages.
+ *
+ *  Paul Mundt <paul.mundt@nokia.com>:
+ *  Overall revision about smaps.
  */
 
 #include <asm/uaccess.h>
@@ -61,6 +95,7 @@ enum pid_directory_inos {
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
+	PROC_TGID_SMAPS,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TGID_SCHEDSTAT,
 #endif
@@ -92,6 +127,7 @@ enum pid_directory_inos {
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
+	PROC_TID_SMAPS,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TID_SCHEDSTAT,
 #endif
@@ -134,6 +170,7 @@ static struct pid_entry tgid_base_stuff[
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -164,6 +201,7 @@ static struct pid_entry tid_base_stuff[]
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -488,6 +526,25 @@ static struct file_operations proc_maps_
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
@@ -1447,6 +1504,10 @@ static struct dentry *proc_pident_lookup
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
diff -uprN linux-2.6.11.7/fs/proc/task_mmu.c
linux-2.6.11.7-smaps/fs/proc/task_mmu.c
--- linux-2.6.11.7/fs/proc/task_mmu.c	2005-04-07 14:57:16.000000000 -0400
+++ linux-2.6.11.7-smaps/fs/proc/task_mmu.c	2005-04-29 11:10:16.000000000 -0400
@@ -113,6 +113,178 @@ static int show_map(struct seq_file *m, 
 	return 0;
 }
 
+struct mem_size_stats
+{
+	unsigned long resident;
+	unsigned long shared_clean;
+	unsigned long shared_dirty;
+	unsigned long private_clean;
+	unsigned long private_dirty;
+};
+
+static void smaps_pte_range(pmd_t *pmd,
+			    unsigned long address,
+			    unsigned long size,
+			    struct mem_size_stats *mss)
+{
+	pte_t *ptep, pte;
+	unsigned long end;
+	unsigned long pfn;
+	struct page *page;
+	
+	if (pmd_none(*pmd))
+		return;
+	if (unlikely(pmd_bad(*pmd))) {
+		pmd_ERROR(*pmd);
+		pmd_clear(pmd);
+		return;
+	}
+	ptep = pte_offset_map(pmd, address);
+	address &= ~PMD_MASK;
+	end = address + size;
+	if (end > PMD_SIZE)
+		end = PMD_SIZE;
+	do {
+		pte = *ptep;
+		address += PAGE_SIZE;
+		ptep++;
+
+		if (pte_none(pte) || (!pte_present(pte)))
+			continue;
+
+		mss->resident += PAGE_SIZE;
+		pfn = pte_pfn(pte);
+		if (pfn_valid(pfn)) {
+			page = pfn_to_page(pfn);					
+			if (page_count(page) >= 2) {
+				if (pte_dirty(pte))
+					mss->shared_dirty += PAGE_SIZE;
+				else
+					mss->shared_clean += PAGE_SIZE;
+			}
+			else {
+				if (pte_dirty(pte))
+					mss->private_dirty += PAGE_SIZE;
+				else
+					mss->private_clean += PAGE_SIZE;
+			}
+		}
+	} while (address < end);
+	pte_unmap(pte);
+}
+
+static void smaps_pmd_range(pud_t *pud,
+			    unsigned long address,
+			    unsigned long size,
+			    struct mem_size_stats *mss)
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
+		smaps_pte_range(pmd, address, end - address, mss);
+		address = (address + PMD_SIZE) & PMD_MASK;
+		pmd++;
+	} while (address < end);
+}
+
+static void smaps_pud_range(pgd_t *pgd,
+			    unsigned long address,
+			    unsigned long size,
+			    struct mem_size_stats *mss)
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
+		smaps_pmd_range(pud, address, end - address, mss);
+		address = (address + PUD_SIZE) & PUD_MASK;
+		pud++;
+	} while (address < end);
+}
+
+static void smaps_pgd_range(pgd_t *pgd,
+			    unsigned long start_address,
+			    unsigned long end_address,
+			    struct mem_size_stats *mss)
+{
+	do {
+		smaps_pud_range(pgd, start_address, end_address - start_address, mss);
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
+	unsigned long vma_len = (map->vm_end - map->vm_start);
+	struct mem_size_stats mss;
+	
+	memset(&mss, 0, sizeof mss);
+
+	if (mm) {
+		pgd_t *pgd;
+		spin_lock(&mm->page_table_lock);
+		pgd = pgd_offset(mm, map->vm_start);		
+		smaps_pgd_range(pgd, map->vm_start, map->vm_end, &mss);
+		spin_unlock(&mm->page_table_lock);
+	}
+	
+	seq_printf(m, "%08lx-%08lx %c%c%c%c ",
+		   map->vm_start,
+		   map->vm_end,
+		   flags & VM_READ ? 'r' : '-',
+		   flags & VM_WRITE ? 'w' : '-',
+		   flags & VM_EXEC ? 'x' : '-',
+		   flags & VM_MAYSHARE ? 's' : 'p');
+	
+	if (map->vm_file)
+		seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
+
+	seq_printf(m, "\n"
+		   "Size:          %8lu KB\n"
+		   "Rss:           %8lu KB\n"
+		   "Shared_Clean:  %8lu KB\n"
+		   "Shared_Dirty:  %8lu KB\n"
+		   "Private_Clean: %8lu KB\n"
+		   "Private_Dirty: %8lu KB\n",
+		   vma_len >> 10,
+		   mss.resident >> 10,
+		   mss.shared_clean  >> 10,
+		   mss.shared_dirty  >> 10,
+		   mss.private_clean >> 10,
+		   mss.private_dirty >> 10);
+	return 0; 
+}
+
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct task_struct *task = m->private;
@@ -166,3 +338,10 @@ struct seq_operations proc_pid_maps_op =
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


BR,

Mauricio Lin.

On 1/7/05, Andrew Morton <akpm@osdl.org> wrote:
> Mauricio Lin <mauriciolin@gmail.com> wrote:
> >
> > Here is a new entry developed for /proc that prints for each process
> > memory area (VMA) the size of rss. The maps from original kernel is
> > able to present the virtual size for each vma, but not the physical
> > size (rss). This entry can provide an additional information for tools
> > that analyze the memory consumption. You can know the physical memory
> > size of each library used by a process and also the executable file.
> >
> > Take a look the output:
> > # cat /proc/877/smaps
> > 08048000-08132000 r-xp  /usr/bin/xmms
> > Size:     936 kB
> > Rss:     788 kB
> 
> This is potentially quite useful.  I'd be interested in what others think of
> the idea and implementation.
> 
> > Here is the patch:
> 
> - It was wordwrapped.  Mail the patch to yourself first, make sure it
>   still applies.
> 
> - Prepare patches with `diff -u'
> 
> -
> 
> > + extern struct seq_operations proc_pid_smaps_op;
> 
>   Put extern headers in .h files, not in .c.
> 
> 
> > + static void resident_mem_size(struct mm_struct *mm, unsigned long
> > start_address,
> > +                     unsigned long end_address, unsigned long *size) {
> > +     pgd_t *pgd;
> > +     pmd_t *pmd;
> > +     pte_t *ptep, pte;
> > +     unsigned long page;
> 
> The identifier `page' is usually used for pointers to struct page.  Please
> pick another name?
> 
> > +                     if (pte_present(pte)) {
> > +                             *size += PAGE_SIZE;
> > +                     }
> 
> We prefer to omit the braces if they enclose only a single statement.
> 
> > +     if (map->vm_file) {
> > +             len = sizeof(void*) * 6 - len;
> > +             if (len < 1)
> > +                     len = 1;
> > +             seq_printf(m, "%*c", len, ' ');
> > +             seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
> > +     }
> 
> hm, that's a bit bizarre.  Isn't there a printf construct which will do the
> right-alignment for you?  %8u?  (See meminfo_read_proc())
> 
>
