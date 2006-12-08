Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164334AbWLHBH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164334AbWLHBH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164325AbWLHBH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:07:27 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:5533 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164329AbWLHBHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:07:24 -0500
In-Reply-To: <20061207143611.7a2925e2.akpm@osdl.org>
References: <45789124.1070207@mvista.com> <20061207143611.7a2925e2.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: multipart/mixed; boundary=Apple-Mail-1-401765200
Message-Id: <04710480e9f151439cacdf3dd9d507d1@mvista.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: david singleton <dsingleton@mvista.com>
Subject: Re: new procfs memory analysis feature
Date: Thu, 7 Dec 2006 17:07:22 -0800
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-1-401765200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Attached is the 2.6.19 patch.



--Apple-Mail-1-401765200
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="pagemaps.patch"
Content-Disposition: attachment;
	filename=pagemaps.patch

Signed-off-by: David Singleton <dsingleton@mvista.com>
Signed-off-by: Joe Green <jgreen@mvista.com>

    Add variation of /proc/PID/smaps called /proc/PID/pagemaps.
    Shows reference counts for individual pages instead of aggregate totals.
    Allows more detailed memory usage information for memory analysis tools.
    An example of the output shows the shared text VMA for ld.so and
    the share depths of the pages in the VMA.

a7f4b000-a7f65000 r-xp 00000000 00:0d 19185826   /lib/ld-2.5.90.so
 11 11 11 11 11 11 11 11 11 13 13 13 13 13 13 13 8 8 8 13 13 13 13 13 13 13


 Documentation/filesystems/proc.txt |    3 -
 fs/proc/base.c                     |    2 
 fs/proc/internal.h                 |    5 -
 fs/proc/task_mmu.c                 |  110 +++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 5 deletions(-)

Index: linux-2.6.19/Documentation/filesystems/proc.txt
===================================================================
--- linux-2.6.19.orig/Documentation/filesystems/proc.txt
+++ linux-2.6.19/Documentation/filesystems/proc.txt
@@ -130,12 +130,13 @@ Table 1-1: Process specific entries in /
  fd      Directory, which contains all file descriptors 
  maps	 Memory maps to executables and library files		(2.4)
  mem     Memory held by this process                    
+ pagemaps Based on maps, presents page ref counts for each mapped file
  root	 Link to the root directory of this process
+ smaps	 Extension based on maps, presenting the rss size for each mapped file
  stat    Process status                                 
  statm   Process memory status information              
  status  Process status in human readable form          
  wchan   If CONFIG_KALLSYMS is set, a pre-decoded wchan
- smaps	 Extension based on maps, presenting the rss size for each mapped file
 ..............................................................................
 
 For example, to get the status information of a process, all you have to do is
Index: linux-2.6.19/fs/proc/base.c
===================================================================
--- linux-2.6.19.orig/fs/proc/base.c
+++ linux-2.6.19/fs/proc/base.c
@@ -1773,6 +1773,7 @@ static struct pid_entry tgid_base_stuff[
 	REG("mountstats", S_IRUSR, mountstats),
 #ifdef CONFIG_MMU
 	REG("smaps",      S_IRUGO, smaps),
+	REG("pagemaps",   S_IRUGO, pagemaps),
 #endif
 #ifdef CONFIG_SECURITY
 	DIR("attr",       S_IRUGO|S_IXUGO, attr_dir),
@@ -2047,6 +2048,7 @@ static struct pid_entry tid_base_stuff[]
 	REG("mounts",    S_IRUGO, mounts),
 #ifdef CONFIG_MMU
 	REG("smaps",     S_IRUGO, smaps),
+	REG("pagemaps",  S_IRUGO, pagemaps),
 #endif
 #ifdef CONFIG_SECURITY
 	DIR("attr",      S_IRUGO|S_IXUGO, attr_dir),
Index: linux-2.6.19/fs/proc/internal.h
===================================================================
--- linux-2.6.19.orig/fs/proc/internal.h
+++ linux-2.6.19/fs/proc/internal.h
@@ -41,10 +41,7 @@ extern int proc_pid_statm(struct task_st
 extern struct file_operations proc_maps_operations;
 extern struct file_operations proc_numa_maps_operations;
 extern struct file_operations proc_smaps_operations;
-
-extern struct file_operations proc_maps_operations;
-extern struct file_operations proc_numa_maps_operations;
-extern struct file_operations proc_smaps_operations;
+extern struct file_operations proc_pagemaps_operations;
 
 
 void free_proc_entry(struct proc_dir_entry *de);
Index: linux-2.6.19/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.19.orig/fs/proc/task_mmu.c
+++ linux-2.6.19/fs/proc/task_mmu.c
@@ -429,6 +429,116 @@ static int do_maps_open(struct inode *in
 	return ret;
 }
 
+static void pagemaps_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
+				unsigned long addr, unsigned long end,
+				struct seq_file *m)
+{
+	pte_t *pte, ptent;
+	spinlock_t *ptl;
+	struct page *page;
+	int mapcount = 0;
+
+	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	do {
+		ptent = *pte;
+		if (pte_present(ptent)) {
+			page = vm_normal_page(vma, addr, ptent);
+			if (page) {
+				if (pte_dirty(ptent))
+					mapcount = -page_mapcount(page);
+				else
+					mapcount = page_mapcount(page);
+			} else {
+				mapcount = 1;
+			}
+		}
+		seq_printf(m, " %d", mapcount);
+
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	seq_putc(m, '\n');
+
+	pte_unmap_unlock(pte - 1, ptl);
+	cond_resched();
+
+}
+
+static inline void pagemaps_pmd_range(struct vm_area_struct *vma, pud_t *pud,
+				unsigned long addr, unsigned long end,
+				struct seq_file *m)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		pagemaps_pte_range(vma, pmd, addr, next, m);
+	} while (pmd++, addr = next, addr != end);
+}
+
+static inline void pagemaps_pud_range(struct vm_area_struct *vma, pgd_t *pgd,
+				unsigned long addr, unsigned long end,
+				struct seq_file *m)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		pagemaps_pmd_range(vma, pud, addr, next, m);
+	} while (pud++, addr = next, addr != end);
+}
+
+static inline void pagemaps_pgd_range(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end,
+				struct seq_file *m)
+{
+	pgd_t *pgd;
+	unsigned long next;
+
+	pgd = pgd_offset(vma->vm_mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		pagemaps_pud_range(vma, pgd, addr, next, m);
+	} while (pgd++, addr = next, addr != end);
+}
+
+static int show_pagemap(struct seq_file *m, void *v)
+{
+	struct vm_area_struct *vma = v;
+
+	show_map_internal(m, v, NULL);
+	if (vma->vm_mm && !is_vm_hugetlb_page(vma))
+		pagemaps_pgd_range(vma, vma->vm_start, vma->vm_end, m);
+	return 0;
+}
+
+static struct seq_operations proc_pid_pagemaps_op = {
+	.start	= m_start,
+	.next	= m_next,
+	.stop	= m_stop,
+	.show	= show_pagemap
+};
+
+static int pagemaps_open(struct inode *inode, struct file *file)
+{
+	return do_maps_open(inode, file, &proc_pid_pagemaps_op);
+}
+
+struct file_operations proc_pagemaps_operations = {
+	.open		= pagemaps_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release_private,
+};
+
 static int maps_open(struct inode *inode, struct file *file)
 {
 	return do_maps_open(inode, file, &proc_pid_maps_op);

--Apple-Mail-1-401765200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed






On Dec 7, 2006, at 2:36 PM, Andrew Morton wrote:

> On Thu, 07 Dec 2006 14:09:40 -0800
> David Singleton <dsingleton@mvista.com> wrote:
>
>>
>> Andrew,
>>
>>     this implements a feature for memory analysis tools to go along 
>> with
>> smaps.
>> It shows reference counts for individual pages instead of aggregate
>> totals for a given VMA.
>> It helps memory analysis tools determine how well pages are being
>> shared, or not,
>> in a shared libraries, etc.
>>
>>    The per page information is presented in /proc/<pid>/pagemaps.
>>
>
> I think the concept is not a bad one, frankly - this requirement arises
> frequently.  What bugs me is that it only displays the mapcount and
> dirtiness.  Perhaps there are other things which people want to know.  
> I'm
> not sure what they would be though.
>
> I wonder if it would be insane to display the info via a filesystem:
>
> 	cat /mnt/pagemaps/$(pidof crond)/pgd0/pmd1/pte45
>
> Probably it would.
>
>> Index: linux-2.6.18/Documentation/filesystems/proc.txt
>
> Against 2.6.18?  I didn't know you could still buy copies of that ;)
>
> This patch's changelog should include sample output.
>
> Your email client wordwraps patches, and it replaces tabs with spaces.
>
>> ...
>>
>> +static void pagemaps_pte_range(struct vm_area_struct *vma, pmd_t 
>> *pmd,
>> +                               unsigned long addr, unsigned long end,
>> +                               struct seq_file *m)
>> +{
>> +       pte_t *pte, ptent;
>> +       spinlock_t *ptl;
>> +       struct page *page;
>> +       int mapcount = 0;
>> +
>> +       pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
>> +       do {
>> +               ptent = *pte;
>> +               if (pte_present(ptent)) {
>> +                       page = vm_normal_page(vma, addr, ptent);
>> +                       if (page) {
>> +                               if (pte_dirty(ptent))
>> +                                       mapcount = 
>> -page_mapcount(page);
>> +                               else
>> +                                       mapcount = 
>> page_mapcount(page);
>> +                       } else {
>> +                               mapcount = 1;
>> +                       }
>> +               }
>> +               seq_printf(m, " %d", mapcount);
>> +
>> +       } while (pte++, addr += PAGE_SIZE, addr != end);
>
> Well that's cute.  As long as both seq_file and pte-pages are of size
> PAGE_SIZE, and as long as pte's are more than three bytes, this will 
> not
> overflow the seq_file output buffer.
>
> hm.  Unless the pages are all dirty and the mapcounts are all 10000.  I
> think it will overflow then?
>
>> +
>> +static inline void pagemaps_pmd_range(struct vm_area_struct *vma, 
>> pud_t
>> *pud,
>> +                               unsigned long addr, unsigned long end,
>> +                               struct seq_file *m)
>> +{
>> +       pmd_t *pmd;
>> +       unsigned long next;
>> +
>> +       pmd = pmd_offset(pud, addr);
>> +       do {
>> +               next = pmd_addr_end(addr, end);
>> +               if (pmd_none_or_clear_bad(pmd))
>> +                       continue;
>> +               pagemaps_pte_range(vma, pmd, addr, next, m);
>> +       } while (pmd++, addr = next, addr != end);
>> +}
>> +
>> +static inline void pagemaps_pud_range(struct vm_area_struct *vma, 
>> pgd_t
>> *pgd,
>> +                               unsigned long addr, unsigned long end,
>> +                               struct seq_file *m)
>> +{
>> +       pud_t *pud;
>> +       unsigned long next;
>> +
>> +       pud = pud_offset(pgd, addr);
>> +       do {
>> +               next = pud_addr_end(addr, end);
>> +               if (pud_none_or_clear_bad(pud))
>> +                       continue;
>> +               pagemaps_pmd_range(vma, pud, addr, next, m);
>> +       } while (pud++, addr = next, addr != end);
>> +}
>> +
>> +static inline void pagemaps_pgd_range(struct vm_area_struct *vma,
>> +                               unsigned long addr, unsigned long end,
>> +                               struct seq_file *m)
>> +{
>> +       pgd_t *pgd;
>> +       unsigned long next;
>> +
>> +       pgd = pgd_offset(vma->vm_mm, addr);
>> +       do {
>> +               next = pgd_addr_end(addr, end);
>> +               if (pgd_none_or_clear_bad(pgd))
>> +                       continue;
>> +               pagemaps_pud_range(vma, pgd, addr, next, m);
>> +       } while (pgd++, addr = next, addr != end);
>> +}
>
> I think that's our eighth open-coded pagetable walker.  Apparently 
> they are
> all slightly different.  Perhaps we shouild do something about that one
> day.
>
>

--Apple-Mail-1-401765200--

