Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVBVNOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVBVNOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 08:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVBVNOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 08:14:43 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:3887 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262293AbVBVNNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 08:13:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=C/b4A4edA/AyemloC2W1Bv1FOSe/ILlf3bCIJz3AAUNqkUGpd5R3V2TWKOJCm9WhnPoCWvQF8Sa3ufGBlw0WBGWfIa0E9b9g6BNfiAorEEu+/QNA+Qxa/vA+nNc4Fd0g4h/ZgmG/HwCGu2vfI9k2i6k2DHco5qwsrQsHfA9spYM=
Message-ID: <3f250c710502220513179b606a@mail.gmail.com>
Date: Tue, 22 Feb 2005 09:13:01 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] A new entry for /proc
Cc: Andrew Morton <akpm@osdl.org>, William Irwin <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, "Richard F. Rebel" <rrebel@whenu.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106202339.4f9ba479.akpm@osdl.org>
	 <Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here goes the new smaps patch. As suggested by Hugh in another discussion, the 
 inefficient loop was removed and replaced by smaps_pgd_range,
smaps_pud_range, smaps_pmd and smaps_pte_range functions. I mantained
the old resident_mem_size function between comments just for anyone
who wants to verify it. BTW, we are using smaps to figure out which
shared libraries that have heavy physical memory comsumption.


diff -uprN linux-2.6.11-rc4-bk9/Documentation/filesystems/proc.txt
linux-2.6.11-rc4-bk9-smaps/Documentation/filesystems/proc.txt
--- linux-2.6.11-rc4-bk9/Documentation/filesystems/proc.txt	2005-02-20
11:35:13.000000000 -0400
+++ linux-2.6.11-rc4-bk9-smaps/Documentation/filesystems/proc.txt	2005-02-20
11:29:42.000000000 -0400
@@ -133,6 +133,7 @@ Table 1-1: Process specific entries in /
  statm   Process memory status information              
  status  Process status in human readable form          
  wchan   If CONFIG_KALLSYMS is set, a pre-decoded wchan
+ smaps	 Extension based on maps, presenting the rss size for each mapped file
 ..............................................................................
 
 For example, to get the status information of a process, all you have to do is
diff -uprN linux-2.6.11-rc4-bk9/Makefile linux-2.6.11-rc4-bk9-smaps/Makefile
--- linux-2.6.11-rc4-bk9/Makefile	2005-02-20 11:36:00.000000000 -0400
+++ linux-2.6.11-rc4-bk9-smaps/Makefile	2005-02-20 11:31:44.000000000 -0400
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
--- linux-2.6.11-rc4-bk9/fs/proc/base.c	2005-02-20 11:35:22.000000000 -0400
+++ linux-2.6.11-rc4-bk9-smaps/fs/proc/base.c	2005-02-20
11:28:00.000000000 -0400
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
--- linux-2.6.11-rc4-bk9/fs/proc/task_mmu.c	2005-02-20 11:35:22.000000000 -0400
+++ linux-2.6.11-rc4-bk9-smaps/fs/proc/task_mmu.c	2005-02-20
11:21:41.000000000 -0400
@@ -113,6 +113,182 @@ static int show_map(struct seq_file *m, 
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
+		struct page *ptpage;
+
+		address += PAGE_SIZE;
+		pte++;
+		if (pte_none(page) || (!pte_present(page)))
+			continue;
+		ptpage = pte_page(page);
+		if (!ptpage || PageReserved(ptpage))
+			continue;
+		*rss += PAGE_SIZE;
+		
+	} while (address < end);
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
+	while (start_address < end_address) {
+		smaps_pud_range(pgd, start_address, end_address - start_address, rss);
+		start_address = (start_address + PGDIR_SIZE) & PGDIR_MASK;
+		pgd++;
+	}
+}
+
+/*
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
+*/
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
+		pgd_t *pgd = pgd_offset(mm, map->vm_start);
+		smaps_pgd_range(pgd, map->vm_start, map->vm_end, &rss);
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
@@ -166,3 +342,10 @@ struct seq_operations proc_pid_maps_op =
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



On Sat, 8 Jan 2005 20:20:39 +0000 (GMT), Hugh Dickins <hugh@veritas.com> wrote:
> On Thu, 6 Jan 2005, Andrew Morton wrote:
> > Mauricio Lin <mauriciolin@gmail.com> wrote:
> > >
> > > Here is a new entry developed for /proc that prints for each process
> > > memory area (VMA) the size of rss. The maps from original kernel is
> > > able to present the virtual size for each vma, but not the physical
> > > size (rss). This entry can provide an additional information for tools
> > > that analyze the memory consumption. You can know the physical memory
> > > size of each library used by a process and also the executable file.
> > >
> > > Take a look the output:
> > > # cat /proc/877/smaps
> > > 08048000-08132000 r-xp  /usr/bin/xmms
> > > Size:     936 kB
> > > Rss:     788 kB
> >
> > This is potentially quite useful.  I'd be interested in what others think of
> > the idea and implementation.
> 
> Regarding the idea.
> 
> Well, it goes back to just what wli freed 2.6 from, and what we scorned
> clameter for: a costly examination of every pte-slot of every vma of the
> process.  That doesn't matter _too_ much so long as there's no standard
> tool liable to do it every second or so, nor doing it to every single
> process, and it doesn't need spinlock or preemption disabled too long.
> 
> But personally I'd be happier for it to remain an out-of-tree patch,
> just to discourage people from writing and running such tools,
> and to discourage them from adding other such costly analyses.
> 
> Potentially quite useful, perhaps.  But I don't have a use for it
> myself, and if I do have, I'll be content to search out (or recreate)
> the patch.  Let's hear from those who actually have a use for it now -
> the more useful it is, of course, the stronger the argument for inclusion.
> 
> I am a bit sceptical how useful such a lot of little numbers would
> really be - usually it's an overall picture we're interested in.
> 
> Regarding the implementation.
> 
> Unnecessarily inefficient: a pte_offset_map and unmap for each pte.
> Better go back to the 2.4.28 or 2.5.36 fs/proc/array.c design for
> statm_pgd_range + statm_pmd_range + statm_pte_range - but now you
> need a pud level too.
> 
> Seems to have no locking: needs to down_read mmap_sem to guard vmas.
> Does it need page_table_lock?  I think not (and proc_pid_statm didn't).
> 
> If there were a use for it, that use might want to distinguish between
> the "shared rss" of pagecache pages from a file, and the "anon rss" of
> private pages copied from file or originally zero - would need to get
> the struct page and check PageAnon.  And might want to count swap
> entries too.  Hard to say without real uses in mind.
> 
> Andrew mentioned "unsigned long page": similarly, we usually say
> "struct vm_area_struct *vma" rather than "*map" (well, some places
> say "*mpnt", but that's not a precedent to follow).
> 
> Regarding the display.
> 
> It's a mixture of two different styles, the /proc/<pid>/maps
> many-hex-fields one-vma-per-line style and the /proc/meminfo
> one-decimal-kB-per-line style.  I think it would be better following
> the /proc/<pid>/maps style, but replacing the major,minor,ino fields
> by size and rss (anon_rss? swap?) fields (decimal kB? I suppose so).
> 
> Hugh
> 
>
