Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbRFYP1N>; Mon, 25 Jun 2001 11:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264629AbRFYP1F>; Mon, 25 Jun 2001 11:27:05 -0400
Received: from m1020-mp1-cvx1c.col.ntl.com ([213.104.79.252]:4224 "EHLO
	[213.104.79.252]") by vger.kernel.org with ESMTP id <S264622AbRFYP0v>;
	Mon, 25 Jun 2001 11:26:51 -0400
To: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: VM tuning through fault trace gathering [with actual code]
From: John Fremlin <vii@users.sourceforge.net>
Date: 25 Jun 2001 16:26:39 +0100
Message-ID: <m2d77s4m34.fsf@boreas.yi.org.>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Last year I had the idea of tracing the memory accesses of the system
to improve the VM - the traces could be used to test algorithms in
userspace. The difficulty is of course making all memory accesses
fault without destroying system performance.

The following patch (i386 only) will dump all page faults to
/dev/biglog (you need devfs for this node to appear). If you echo 1 >
/proc/sys/vm/trace then *almost all* userspace memory accesses will
take a soft fault. Note that this is a bit suicidal at the moment
because of the staggeringly inefficient way its implemented, on my box
(K6-2 300MHz) only processes which do very little (e.g. /usr/bin/yes)
running at highest priority are able to print anything to the console.

I think the best way would be to have only one valid l2 pte per
process. I'll have a go at doing that in a day or two unless someone
has a better idea?


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.4.4-i386-pagetrace-2.patch

diff --exclude *~ --new-file -u -r linux-2.4.4-orig/drivers/char/Makefile linux-2.4.4-i386-pagetrace/drivers/char/Makefile
--- linux-2.4.4-orig/drivers/char/Makefile	Tue May  1 14:33:51 2001
+++ linux-2.4.4-i386-pagetrace/drivers/char/Makefile	Sat Jun 23 22:21:34 2001
@@ -16,7 +16,7 @@
 
 O_TARGET := char.o
 
-obj-y	 += tty_io.o n_tty.o tty_ioctl.o mem.o raw.o pty.o misc.o random.o
+obj-y	 += tty_io.o n_tty.o tty_ioctl.o mem.o raw.o pty.o misc.o random.o biglog.o
 
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
diff --exclude *~ --new-file -u -r linux-2.4.4-orig/drivers/char/biglog.c linux-2.4.4-i386-pagetrace/drivers/char/biglog.c
--- linux-2.4.4-orig/drivers/char/biglog.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.4-i386-pagetrace/drivers/char/biglog.c	Sun Jun 24 14:55:55 2001
@@ -0,0 +1,204 @@
+/* Implements a misc device that can output large amounts of data from
+ * the kernel to userspace
+ *
+ * (c) 2001 John Fremlin released under GPL
+ */
+
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <asm/uaccess.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+
+#define BUFFER_SIZE (1024*1024*1)
+
+char buffer[BUFFER_SIZE];
+
+static DECLARE_WAIT_QUEUE_HEAD(waiters);
+static spinlock_t write_head_lock = SPIN_LOCK_UNLOCKED;
+unsigned long write_head;
+
+struct fop_priv
+{
+	unsigned long read_head;
+}
+;
+
+void biglog_log(const char*str)
+{
+	const char*i = str;
+	unsigned long head;
+	unsigned long flags;
+
+	spin_lock_irqsave(&write_head_lock,flags);
+	head = write_head;
+	while(*i) {
+		buffer[head++]= *i++;
+		if(head>=BUFFER_SIZE)
+			head = 0;
+	}
+	write_head = head;
+	spin_unlock_irqrestore(&write_head_lock,flags);
+	wake_up_all(&waiters);
+}
+
+void biglog_logfault(struct mm_struct *mm, struct vm_area_struct * vma,
+		     unsigned long address, int write_access) 
+{
+	static unsigned long no;
+	static char faultbuf[1024];
+
+	char* process = current ? current->comm : "unknown";
+	pid_t pid = current ? current->pid : 0;
+	
+	unsigned long offset = address - vma->vm_start;
+	struct file* file = vma->vm_file;
+	struct dentry* dentry = file ? file->f_dentry : 0;
+	struct inode* inode = dentry ? dentry->d_inode : 0;
+
+	unsigned long ino = inode ? inode->i_ino : 0;
+	kdev_t device = inode ? inode->i_dev : 0;
+	struct qstr* d_name = dentry ? &dentry->d_name : 0;
+               
+	char name[100];
+	unsigned len = sizeof(name)-1;
+               
+	if(d_name && (d_name->len < len))
+		len = d_name->len;
+               
+	strncpy(name, d_name ? (const char*)d_name->name : (const char*)
+		"anon", len);
+	name[len] = 0;
+
+	sprintf(faultbuf,"%lu: %p%c (%s) %lu (%s) %p %lu:%lu+%lu\n",
+		no++,
+		(void*)address,
+		write_access?'W':'r',
+		process,
+		(unsigned long)pid,
+		(char*)name,
+		vma,
+		(unsigned long)device,
+		ino,
+		offset
+		);
+
+	biglog_log(faultbuf);
+}
+
+static int fop_open(struct inode * inode, struct file * file)
+{
+	struct fop_priv*priv;
+	priv = kmalloc(sizeof *priv,GFP_KERNEL);
+	if(!priv)
+		return -ENOMEM;
+
+	memset(priv,0,sizeof *priv);
+
+	priv->read_head = write_head;
+	file->private_data = priv;
+
+	return 0;
+}
+
+static ssize_t fop_read(struct file * file, char * buf,
+			size_t count, loff_t *ppos)
+{
+	ssize_t ret = 0;
+	unsigned long head;
+	unsigned long flags;
+	struct fop_priv *priv = (struct fop_priv *)file->private_data;
+
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	spin_lock_irqsave(&write_head_lock,flags);
+	head = write_head;
+	if(head == priv->read_head) {
+		spin_unlock_irqrestore(&write_head_lock,flags);
+		if(file->f_flags&O_NONBLOCK)
+			return -EAGAIN;
+		
+		if (wait_event_interruptible(waiters,
+		    head != write_head)
+		    == -ERESTARTSYS) {
+			return -ERESTARTSYS;
+		}
+		spin_lock_irqsave(&write_head_lock,flags);
+		head = write_head;
+	}
+	if(!count) 
+		goto out;
+	
+	if(head >= priv->read_head)
+		if(count > head - priv->read_head)
+			count = head - priv->read_head;
+		
+	if(count+priv->read_head >  BUFFER_SIZE)
+		count = BUFFER_SIZE - priv->read_head;
+	
+	if (copy_to_user(buf, buffer + priv->read_head, count))
+		ret = -EFAULT;
+	else {
+		ret = count;
+		priv->read_head += count;
+		if(priv->read_head >= BUFFER_SIZE)
+			priv->read_head = 0;
+	}
+ out:
+	spin_unlock_irqrestore(&write_head_lock,flags);
+	return ret;
+}
+
+static int fop_release(struct inode * inode, struct file * file)
+{
+	struct fop_priv *priv = (struct fop_priv *)file->private_data;
+	kfree(priv);
+	return 0;
+}
+
+static struct file_operations fops = {
+	owner:		THIS_MODULE,
+	read:		fop_read,
+	open:		fop_open,
+	release:		fop_release,
+};
+
+static struct miscdevice dev=
+{
+	MISC_DYNAMIC_MINOR,
+	"biglog",
+	&fops
+};
+
+
+static int __init mod_init(void)
+{
+	if(misc_register(&dev)){
+		printk(KERN_DEBUG "biglog: could not register device node\n");
+		return -EBUSY;
+	}
+	
+	printk(KERN_INFO "biglog: ready to rock\n");
+	return 0;
+}
+
+static void __exit mod_exit(void)
+{
+	if(misc_deregister(&dev))
+		printk(KERN_DEBUG "biglog: could not deregister device node\n");
+
+	/* FIXME: remove if this gets into main tree */
+	printk(KERN_INFO "biglog: biglog has left the building\n");
+}
+
+module_init(mod_init);
+module_exit(mod_exit);
+
+MODULE_DESCRIPTION("Interface for loggin large amounts of data from the kernel");
+MODULE_AUTHOR("John Fremlin");
+EXPORT_SYMBOL(biglog_logfault);
+EXPORT_SYMBOL(biglog_log);
diff --exclude *~ --new-file -u -r linux-2.4.4-orig/include/asm-i386/mmu_context.h linux-2.4.4-i386-pagetrace/include/asm-i386/mmu_context.h
--- linux-2.4.4-orig/include/asm-i386/mmu_context.h	Tue May  1 20:35:24 2001
+++ linux-2.4.4-i386-pagetrace/include/asm-i386/mmu_context.h	Sun Jun 24 15:34:31 2001
@@ -27,6 +27,8 @@
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk, unsigned cpu)
 {
+	extern void trace_mm(struct mm_struct*mm);
+	trace_mm(next);
 	if (prev != next) {
 		/* stop flush ipis for the previous mm */
 		clear_bit(cpu, &prev->cpu_vm_mask);
diff --exclude *~ --new-file -u -r linux-2.4.4-orig/include/asm-i386/pgtable.h linux-2.4.4-i386-pagetrace/include/asm-i386/pgtable.h
--- linux-2.4.4-orig/include/asm-i386/pgtable.h	Tue May  1 20:35:24 2001
+++ linux-2.4.4-i386-pagetrace/include/asm-i386/pgtable.h	Sun Jun 24 14:57:11 2001
@@ -174,6 +174,7 @@
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry PPro+ */
 
 #define _PAGE_PROTNONE	0x080	/* If not present */
+#define _PAGE_TRACE     0x200
 
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _KERNPG_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
@@ -243,7 +244,8 @@
 /* page table for 0-4MB for everybody */
 extern unsigned long pg0[1024];
 
-#define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
+#define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE | _PAGE_TRACE))
+#define pte_traced(x)   ((x).pte_low & _PAGE_TRACE)
 #define pte_clear(xp)	do { set_pte(xp, __pte(0)); } while (0)
 
 #define pmd_none(x)	(!pmd_val(x))
@@ -278,6 +280,8 @@
 static inline pte_t pte_mkdirty(pte_t pte)	{ (pte).pte_low |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
+static inline pte_t pte_mktrace(pte_t pte)      { (pte).pte_low |= _PAGE_TRACE; (pte).pte_low &= ~_PAGE_PRESENT; return pte; }
+static inline pte_t pte_untrace(pte_t pte)      { if(!pte_traced(pte))return pte; (pte).pte_low &= ~_PAGE_TRACE; (pte).pte_low |= _PAGE_PRESENT; return pte; }
 
 static inline  int ptep_test_and_clear_dirty(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_DIRTY, ptep); }
 static inline  int ptep_test_and_clear_young(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_ACCESSED, ptep); }
diff --exclude *~ --new-file -u -r linux-2.4.4-orig/include/linux/sysctl.h linux-2.4.4-i386-pagetrace/include/linux/sysctl.h
--- linux-2.4.4-orig/include/linux/sysctl.h	Tue May  1 20:35:46 2001
+++ linux-2.4.4-i386-pagetrace/include/linux/sysctl.h	Sun Jun 24 04:08:01 2001
@@ -134,7 +134,8 @@
 	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
 	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
 	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
-	VM_PAGE_CLUSTER=10	/* int: set number of pages to swap together */
+	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
+	VM_TRACE=11,            /* Turn on page access tracing */
 };
 
 
diff --exclude *~ --new-file -u -r linux-2.4.4-orig/kernel/sysctl.c linux-2.4.4-i386-pagetrace/kernel/sysctl.c
--- linux-2.4.4-orig/kernel/sysctl.c	Tue May  1 14:34:43 2001
+++ linux-2.4.4-i386-pagetrace/kernel/sysctl.c	Sun Jun 24 04:16:27 2001
@@ -40,6 +40,7 @@
 #if defined(CONFIG_SYSCTL)
 
 /* External variables not in a header file. */
+extern int page_trace;
 extern int panic_timeout;
 extern int C_A_D;
 extern int bdf_prm[], bdflush_min[], bdflush_max[];
@@ -270,6 +271,8 @@
 	 &pgt_cache_water, 2*sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster", 
 	 &page_cluster, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_TRACE, "trace",
+	 &page_trace, sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}
 };
 
diff --exclude *~ --new-file -u -r linux-2.4.4-orig/mm/memory.c linux-2.4.4-i386-pagetrace/mm/memory.c
--- linux-2.4.4-orig/mm/memory.c	Tue May  1 14:34:43 2001
+++ linux-2.4.4-i386-pagetrace/mm/memory.c	Sun Jun 24 15:51:19 2001
@@ -52,6 +52,7 @@
 unsigned long num_physpages;
 void * high_memory;
 struct page *highmem_start_page;
+int page_trace;
 
 /*
  * We special-case the C-O-W ZERO_PAGE, because it's such
@@ -1271,6 +1272,48 @@
 	return 2;	/* Major fault */
 }
 
+void trace_vma(struct vm_area_struct*vma,pte_t *avoid)
+{
+	unsigned long address;
+
+	if(!page_trace)
+		return;
+	
+	for(address = vma->vm_start;
+	    address < vma->vm_end;
+	    address += PAGE_SIZE)
+	{
+		pgd_t *pgd;
+		pmd_t *pmd;
+		pte_t * pte;
+
+		pgd = pgd_offset(vma->vm_mm, address);
+		if(pgd && !pgd_none(*pgd) && !pgd_bad(*pgd)){
+			pmd = pmd_offset(pgd, address);
+			if(pmd && !pmd_none(*pmd) && !pmd_bad(*pmd)){
+				pte = pte_offset(pmd, address);
+				if(pte && pte != avoid && !pte_none(*pte))
+					if(pte_present(*pte) && !pte_traced(*pte)) {
+						establish_pte(vma, address, pte, pte_mktrace(*pte));
+						flush_tlb_page(vma,address);
+					}
+				
+			}
+		}
+	}
+}
+
+void trace_mm(struct mm_struct*mm)
+{
+	struct vm_area_struct * mmap;
+
+	if(!page_trace)
+		return;
+	
+	for(mmap = mm->mmap;mmap;mmap = mmap->vm_next)
+		trace_vma(mmap,0);
+}
+
 /*
  * These routines also need to handle stuff like marking pages dirty
  * and/or accessed for architectures that don't do it in hardware (most
@@ -1294,19 +1337,25 @@
 	int write_access, pte_t * pte)
 {
 	pte_t entry;
-
+	
 	entry = *pte;
+	if(pte_traced(entry)) {
+		trace_vma(vma,pte);
+		entry = pte_untrace(entry);
+		establish_pte(vma, address, pte, entry);
+		return 1;
+	}
+
+	trace_vma(vma,pte);
+
 	if (!pte_present(entry)) {
-		/*
-		 * If it truly wasn't present, we know that kswapd
-		 * and the PTE updates will not touch it later. So
-		 * drop the lock.
-		 */
+
 		if (pte_none(entry))
 			return do_no_page(mm, vma, address, write_access, pte);
 		return do_swap_page(mm, vma, address, pte, pte_to_swp_entry(entry), write_access);
 	}
 
+	entry = pte_untrace(entry);
 	if (write_access) {
 		if (!pte_write(entry))
 			return do_wp_page(mm, vma, address, pte, entry);
@@ -1324,10 +1373,14 @@
 int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
 	unsigned long address, int write_access)
 {
+	extern void biglog_logfault(struct mm_struct *mm, struct vm_area_struct * vma,
+				    unsigned long address, int write_access);
 	int ret = -1;
 	pgd_t *pgd;
 	pmd_t *pmd;
 
+	biglog_logfault(mm,vma,address,write_access);
+	
 	current->state = TASK_RUNNING;
 	pgd = pgd_offset(mm, address);
 

--=-=-=


-- 
PS. I'm desparately seeking last minute summer job in Europe due to an
unfortunate series of events. Please see http://ape.n3.net/cv.html

--=-=-=--
