Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVAFVNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVAFVNw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVAFVNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:13:39 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:2490 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263039AbVAFVLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:11:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=SJfobfiyXJQ+TrxNNyrtaZeNdEk6ap2Tmpsfadu57EH8EzA6R+Qfzxs3EpGT8nOO/BZXe6kmO5ih2AL+nYncv5ZQ9Q+V3BUnyWImOtfDi6U7ZZBXExDIOZqcOq9Kk0EIjTawknXiHGS6kocKAKvqazcoWGK1MOTJeAHtFhbDXC4=
Message-ID: <3f250c7105010613115554b9d9@mail.gmail.com>
Date: Thu, 6 Jan 2005 17:11:18 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] A new entry for /proc
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is a new entry developed for /proc that prints for each process
memory area (VMA) the size of rss. The maps from original kernel is
able to present the virtual size for each vma, but not the physical
size (rss). This entry can provide an additional information for tools
that analyze the memory consumption. You can know the physical memory
size of each library used by a process and also the executable file.

Take a look the output:
# cat /proc/877/smaps
08048000-08132000 r-xp  /usr/bin/xmms
Size:     936 kB
Rss:     788 kB
08132000-0813a000 rw-p  /usr/bin/xmms
Size:      32 kB
Rss:      32 kB
0813a000-081dd000 rw-p 
Size:     652 kB
Rss:     616 kB
b67b5000-b67b6000 ---p 
Size:       4 kB
Rss:       0 kB
b67b6000-b6fb5000 rwxp 
Size:    8188 kB
Rss:       4 kB
b6fb5000-b6fbc000 r-xp  /usr/lib/xmms/Visualization/libsanalyzer.so
Size:      28 kB
Rss:       8 kB
b6fbc000-b6fbd000 rw-p  /usr/lib/xmms/Visualization/libsanalyzer.so
Size:       4 kB
Rss:       4 kB
b6fbd000-b6fc1000 r-xp  /usr/X11R6/lib/libXxf86vm.so.1.0
Size:      16 kB
Rss:       8 kB
b6fc1000-b6fc2000 rw-p  /usr/X11R6/lib/libXxf86vm.so.1.0
Size:       4 kB
Rss:       4 kB
b6fc2000-b702d000 r-xp  /usr/X11R6/lib/libGL.so.1.2
Size:     428 kB
Rss:     372 kB
b702d000-b7032000 rw-p  /usr/X11R6/lib/libGL.so.1.2
Size:      20 kB
Rss:      20 kB
b7032000-b7033000 rw-p 
Size:       4 kB
Rss:       0 kB
...

Here is the patch:

diff -rcNP linux-2.6.10/fs/proc/base.c linux-2.6.10-smaps/fs/proc/base.c
*** linux-2.6.10/fs/proc/base.c	Fri Dec 24 17:35:00 2004
--- linux-2.6.10-smaps/fs/proc/base.c	Thu Jan  6 15:47:37 2005
***************
*** 11,16 ****
--- 11,18 ----
   *  go into icache. We cache the reference to task_struct upon lookup too.
   *  Eventually it should become a filesystem in its own. We don't use the
   *  rest of procfs anymore.
+  *  2004, 10LE INdT <mauricio.lin@indt.org.br>. A new entry smaps
included in /proc.
+  *  It shows the size of rss for each memory area.
   */
  
  #include <asm/uaccess.h>
***************
*** 60,65 ****
--- 62,68 ----
  	PROC_TGID_MAPS,
  	PROC_TGID_MOUNTS,
  	PROC_TGID_WCHAN,
+ 	PROC_TGID_SMAPS,
  #ifdef CONFIG_SCHEDSTATS
  	PROC_TGID_SCHEDSTAT,
  #endif
***************
*** 86,91 ****
--- 89,95 ----
  	PROC_TID_MAPS,
  	PROC_TID_MOUNTS,
  	PROC_TID_WCHAN,
+ 	PROC_TID_SMAPS,
  #ifdef CONFIG_SCHEDSTATS
  	PROC_TID_SCHEDSTAT,
  #endif
***************
*** 123,128 ****
--- 127,133 ----
  	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
  	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
  	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
+ 	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),
  #ifdef CONFIG_SECURITY
  	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
  #endif
***************
*** 148,153 ****
--- 153,159 ----
  	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
  	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
  	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
+ 	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
  #ifdef CONFIG_SECURITY
  	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
  #endif
***************
*** 497,502 ****
--- 503,527 ----
  	.release	= seq_release,
  };
  
+ extern struct seq_operations proc_pid_smaps_op;
+ static int smaps_open(struct inode *inode, struct file *file)
+ {
+ 	struct task_struct *task = proc_task(inode);
+ 	int ret = seq_open(file, &proc_pid_smaps_op);
+ 	if (!ret) {
+ 		struct seq_file *m = file->private_data;
+ 		m->private = task;
+ 	}
+ 	return ret;
+ }
+ 
+ static struct file_operations proc_smaps_operations = {
+ 	.open		= smaps_open,
+ 	.read		= seq_read,
+ 	.llseek		= seq_lseek,
+ 	.release	= seq_release,
+ };
+ 
  extern struct seq_operations mounts_op;
  static int mounts_open(struct inode *inode, struct file *file)
  {
***************
*** 1341,1346 ****
--- 1366,1376 ----
  		case PROC_TGID_MOUNTS:
  			inode->i_fop = &proc_mounts_operations;
  			break;
+ 		case PROC_TID_SMAPS:
+ 		case PROC_TGID_SMAPS:
+ 			inode->i_fop = &proc_smaps_operations;
+ 			break;
+ 
  #ifdef CONFIG_SECURITY
  		case PROC_TID_ATTR:
  			inode->i_nlink = 2;
diff -rcNP linux-2.6.10/fs/proc/task_mmu.c linux-2.6.10-smaps/fs/proc/task_mmu.c
*** linux-2.6.10/fs/proc/task_mmu.c	Fri Dec 24 17:34:01 2004
--- linux-2.6.10-smaps/fs/proc/task_mmu.c	Wed Dec 29 10:21:04 2004
***************
*** 81,86 ****
--- 81,159 ----
  	return 0;
  }
  
+ static void resident_mem_size(struct mm_struct *mm, unsigned long
start_address,
+ 			unsigned long end_address, unsigned long *size) {
+ 	pgd_t *pgd;
+ 	pmd_t *pmd;
+ 	pte_t *ptep, pte;
+ 	unsigned long page;
+ 
+ 	for (page = start_address; page < end_address; page += PAGE_SIZE) {
+ 		pgd = pgd_offset(mm, page);
+ 		if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+ 			continue;
+ 
+ 		pmd = pmd_offset(pgd, page);
+ 
+ 		if (pmd_none(*pmd))
+ 			continue;
+ 
+ 		if (unlikely(pmd_bad(*pmd)))
+ 			continue;
+ 
+ 		if (pmd_present(*pmd)) {
+ 			ptep = pte_offset_map(pmd, page);
+ 			if (!ptep)
+ 				continue;
+ 			pte = *ptep;
+ 			pte_unmap(ptep);
+ 			if (pte_present(pte)) {
+ 				*size += PAGE_SIZE;
+ 			}
+ 		}
+ 	}
+ }
+ 
+ static int show_smap(struct seq_file *m, void *v)
+ {
+ 	struct vm_area_struct *map = v;
+ 	struct file *file = map->vm_file;
+ 	int flags = map->vm_flags;
+ 	int len;
+ 	struct mm_struct *mm = map->vm_mm;
+ 	unsigned long rss = 0;
+ 	unsigned long vma_len = (map->vm_end - map->vm_start) >> 10;
+ 	
+ 	if (mm) {
+ 		resident_mem_size(mm, map->vm_start, map->vm_end, &rss);
+ 	}
+ 
+ 	seq_printf(m, "%08lx-%08lx %c%c%c%c %n",
+ 			map->vm_start,
+ 			map->vm_end,
+ 			flags & VM_READ ? 'r' : '-',
+ 			flags & VM_WRITE ? 'w' : '-',
+ 			flags & VM_EXEC ? 'x' : '-',
+ 			flags & VM_MAYSHARE ? 's' : 'p',
+ 			&len);
+ 
+ 	if (map->vm_file) {
+ 		len = sizeof(void*) * 6 - len;
+ 		if (len < 1)
+ 			len = 1;
+ 		seq_printf(m, "%*c", len, ' ');
+ 		seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
+ 	}
+ 	seq_putc(m, '\n');
+ 	
+ 	seq_printf(m, "Size:%8lu kB\n"
+ 			"Rss:%8lu kB\n",
+ 			vma_len,
+ 			rss >> 10);
+ 	
+ 	return 0;
+ }
+ 
  static void *m_start(struct seq_file *m, loff_t *pos)
  {
  	struct task_struct *task = m->private;
***************
*** 134,136 ****
--- 207,216 ----
  	.stop	= m_stop,
  	.show	= show_map
  };
+ 
+ struct seq_operations proc_pid_smaps_op = {
+ 	.start	= m_start,
+ 	.next	= m_next,
+ 	.stop	= m_stop,
+ 	.show	= show_smap
+ };

Suggestions are welcome.

BR,

Mauricio Lin.
