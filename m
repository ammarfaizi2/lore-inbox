Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUFYGwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUFYGwx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 02:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUFYGwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 02:52:53 -0400
Received: from holomorphy.com ([207.189.100.168]:57231 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266339AbUFYGwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 02:52:04 -0400
Date: Thu, 24 Jun 2004 23:51:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@muc.de>, Yusuf Goolamabbas <yusufg@outblaze.com>,
       linux-kernel@vger.kernel.org
Subject: Re: finish_task_switch high in profiles in 2.6.7
Message-ID: <20040625065140.GX21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@muc.de>, Yusuf Goolamabbas <yusufg@outblaze.com>,
	linux-kernel@vger.kernel.org
References: <2ayz2-1Um-15@gated-at.bofh.it> <m3n02tz203.fsf@averell.firstfloor.org> <20040624104416.GB8798@outblaze.com> <20040624113608.GA31080@colin2.muc.de> <20040624140539.GT1552@holomorphy.com> <20040624212248.GM21066@holomorphy.com> <20040624215645.GN21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20040624215645.GN21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 24, 2004 at 02:56:45PM -0700, William Lee Irwin III wrote:
> While I'm spraying out untested code, I might as well do these, which
> I've not even compiled. =)

Okay, these compile -- ship it! =)


-- wli

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Description: schedprof_mmap-2.6.7
Content-Disposition: attachment; filename="schedprof_mmap-2.6.7"

Index: schedprof-2.6.7/kernel/sched.c
===================================================================
--- schedprof-2.6.7.orig/kernel/sched.c	2004-06-24 14:02:48.292038264 -0700
+++ schedprof-2.6.7/kernel/sched.c	2004-06-24 23:43:43.734205632 -0700
@@ -4053,7 +4053,7 @@
 
 static atomic_t *schedprof_buf;
 static int sched_profiling;
-static unsigned long schedprof_len;
+static unsigned long schedprof_len, schedprof_pages;
 
 #include <linux/bootmem.h>
 #include <asm/sections.h>
@@ -4063,7 +4063,7 @@
 	if (schedprof_buf) {
 		unsigned long pc = (unsigned long)__pc;
 		pc -= min(pc, (unsigned long)_stext);
-		atomic_inc(&schedprof_buf[min(pc, schedprof_len)]);
+		atomic_inc(&schedprof_buf[min(pc + 1, schedprof_len - 1)]);
 	}
 }
 
@@ -4081,8 +4081,10 @@
 	if (!sched_profiling)
 		return;
 	schedprof_len = (unsigned long)(_etext - _stext) + 1;
-	schedprof_buf = alloc_bootmem(schedprof_len*sizeof(atomic_t));
+	schedprof_buf = alloc_bootmem_pages(sizeof(atomic_t)*schedprof_len);
+	schedprof_pages = PAGE_ALIGN(sizeof(atomic_t)*schedprof_len)/PAGE_SIZE;
 	printk(KERN_INFO "Scheduler call profiling enabled\n");
+	atomic_set(&schedprof_buf[0], 1);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -4092,38 +4094,58 @@
 read_sched_profile(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	ssize_t read;
-	char * pnt;
-	unsigned int sample_step = 1;
 
-	if (p >= (schedprof_len+1)*sizeof(atomic_t))
+	if (p >= sizeof(atomic_t)*schedprof_len)
 		return 0;
-	if (count > (schedprof_len+1)*sizeof(atomic_t) - p)
-		count = (schedprof_len+1)*sizeof(atomic_t) - p;
-	read = 0;
-
-	while (p < sizeof(atomic_t) && count > 0) {
-		put_user(*((char *)(&sample_step)+p),buf);
-		buf++; p++; count--; read++;
-	}
-	pnt = (char *)schedprof_buf + p - sizeof(atomic_t);
-	if (copy_to_user(buf,(void *)pnt,count))
+	count = min(schedprof_len*sizeof(atomic_t) - p, count);
+	if (copy_to_user(buf, (char *)schedprof_buf + p, count))
 		return -EFAULT;
-	read += count;
-	*ppos += read;
-	return read;
+	*ppos += count;
+	return count;
 }
 
 static ssize_t write_sched_profile(struct file *file, const char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	memset(schedprof_buf, 0, sizeof(atomic_t)*schedprof_len);
+	memset(&schedprof_buf[1], 0, (schedprof_len-1)*sizeof(atomic_t));
 	return count;
 }
 
+static int mmap_sched_profile(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned long pfn, vaddr, base_pfn = __pa(schedprof_buf)/PAGE_SIZE;
+	if (vma->vm_pgoff + vma_pages(vma) > schedprof_pages)
+		return -ENODEV;
+	vma->vm_flags |= VM_RESERVED|VM_IO;
+	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
+		pgd_t *pgd = pgd_offset(vma->vm_mm, vaddr);
+		pmd_t *pmd;
+		pte_t *pte, pte_val;
+
+		spin_lock(&vma->vm_mm->page_table_lock);
+		pmd = pmd_alloc(vma->vm_mm, pgd, vaddr);
+		if (!pmd)
+			goto enomem;
+		pte = pte_alloc_map(vma->vm_mm, pmd, vaddr);
+		if (!pte)
+			goto enomem;
+		pfn = base_pfn + linear_page_index(vma, vaddr);
+		pte_val = pfn_pte(pfn, vma->vm_page_prot);
+		set_pte(pte, pte_val);
+		update_mmu_cache(vma, vaddr, pte_val);
+		pte_unmap(pte);
+		spin_unlock(&vma->vm_mm->page_table_lock);
+	}
+	return 0;
+enomem:
+	spin_unlock(&vma->vm_mm->page_table_lock);
+	return -ENOMEM;
+}
+
 static struct file_operations sched_profile_operations = {
 	.read		= read_sched_profile,
 	.write		= write_sched_profile,
+	.mmap		= mmap_sched_profile,
 };
 
 static int proc_schedprof_init(void)
@@ -4134,7 +4156,7 @@
 	entry = create_proc_entry("schedprof", S_IWUSR | S_IRUGO, NULL);
 	if (entry) {
 		entry->proc_fops = &sched_profile_operations;
-		entry->size = sizeof(atomic_t)*(schedprof_len + 1);
+		entry->size = sizeof(atomic_t)*schedprof_len;
 	}
 	return !!entry;
 }

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Description: schedprof_proc_init-2.6.7
Content-Disposition: attachment; filename="schedprof_proc_init-2.6.7"

Index: schedprof-2.6.7/kernel/sched.c
===================================================================
--- schedprof-2.6.7.orig/kernel/sched.c	2004-06-24 23:43:43.734205632 -0700
+++ schedprof-2.6.7/kernel/sched.c	2004-06-24 23:43:54.660544576 -0700
@@ -4152,13 +4152,13 @@
 {
 	struct proc_dir_entry *entry;
 	if (!sched_profiling)
-		return 1;
+		return 0;
 	entry = create_proc_entry("schedprof", S_IWUSR | S_IRUGO, NULL);
 	if (entry) {
 		entry->proc_fops = &sched_profile_operations;
 		entry->size = sizeof(atomic_t)*schedprof_len;
 	}
-	return !!entry;
+	return !entry;
 }
 module_init(proc_schedprof_init);
 #endif

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Description: schedprof_shift-2.6.7
Content-Disposition: attachment; filename="schedprof_shift-2.6.7"

Index: schedprof-2.6.7/kernel/sched.c
===================================================================
--- schedprof-2.6.7.orig/kernel/sched.c	2004-06-24 23:42:11.200272928 -0700
+++ schedprof-2.6.7/kernel/sched.c	2004-06-24 23:42:41.895606528 -0700
@@ -4052,7 +4052,7 @@
 #endif /* defined(CONFIG_SMP) && defined(CONFIG_PREEMPT) */
 
 static atomic_t *schedprof_buf;
-static int sched_profiling;
+static int sched_profiling, schedprof_shift;
 static unsigned long schedprof_len, schedprof_pages;
 
 #include <linux/bootmem.h>
@@ -4062,11 +4062,22 @@
 {
 	if (schedprof_buf) {
 		unsigned long pc = (unsigned long)__pc;
-		pc -= min(pc, (unsigned long)_stext);
+		pc = (pc - min(pc, (unsigned long)_stext)) >> schedprof_shift;
 		atomic_inc(&schedprof_buf[min(pc + 1, schedprof_len - 1)]);
 	}
 }
 
+static int __init schedprof_shift_setup(char *s)
+{
+	int n;
+	if (get_option(&s, &n)) {
+		schedprof_shift = n;
+		sched_profiling = 1;
+	}
+	return 1;
+}
+__setup("schedprof_shift=", schedprof_shift_setup);
+
 static int __init schedprof_setup(char *s)
 {
 	int n;
@@ -4080,11 +4091,11 @@
 {
 	if (!sched_profiling)
 		return;
-	schedprof_len = (unsigned long)(_etext - _stext) + 1;
+	schedprof_len = ((unsigned long)(_etext-_stext)>>schedprof_shift) + 1;
 	schedprof_buf = alloc_bootmem_pages(sizeof(atomic_t)*schedprof_len);
 	schedprof_pages = PAGE_ALIGN(sizeof(atomic_t)*schedprof_len)/PAGE_SIZE;
 	printk(KERN_INFO "Scheduler call profiling enabled\n");
-	atomic_set(&schedprof_buf[0], 1);
+	atomic_set(&schedprof_buf[0], 1 << schedprof_shift);
 }
 
 #ifdef CONFIG_PROC_FS

--gatW/ieO32f1wygP--
