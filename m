Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTLPVIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTLPVIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:08:38 -0500
Received: from uirapuru.fua.br ([200.129.163.1]:12515 "EHLO uirapuru.fua.br")
	by vger.kernel.org with ESMTP id S262591AbTLPVHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:07:51 -0500
Message-ID: <53549.200.212.156.130.1071605237.squirrel@webmail.ufam.edu.br>
In-Reply-To: <20031215215717.GD1769@matchmail.com>
References: <20031214014429.GB1769@matchmail.com>
    <Pine.LNX.4.44.0312141915550.26386-100000@chimarrao.boston.redhat.com>
    <20031215185701.GC1769@matchmail.com>
    <33772.200.212.156.130.1071517210.squirrel@webmail.ufam.edu.br>
    <20031215215717.GD1769@matchmail.com>
Date: Tue, 16 Dec 2003 18:07:17 -0200 (BRST)
Subject: Re: Re: Re: More questions about 2.6 /proc/meminfo was: (Mem: and 
     Swap: lines in /proc/meminfo)
From: edjard@ufam.edu.br
To: "Mike Fedyk" <mfedyk@matchmail.com>
Cc: edjard@ufam.edu.br, "Rik van Riel" <riel@redhat.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, ajsb@dcc.fua.br,
       mauriciolin@bol.com.br
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

> Kernels without this patch, I'd have to take VmRSS and calculate that
> against VmLib, and then have to think about shared memory between threads
> and I'm not sure what else.

We are proposing to create another entry in /proc for more accurate
memory informartion. This is a variation of maps but it includes information
not shown by maps, like the size of stack and amount of rss allocated and
so on.

> If I want to get the memory used by all apps from /proc/$pid/status, how
> am I going to calculate it with this patch, and how will it be more
> accurate from what I'd have to deal with from 2.[246] as they currently
> are without the patch?

You may now build an applicatin like top and access /proc/PID/smaps as you
like. Your application should care about the format of smaps output. Here
is
just a sample of it

08048000-08085000 r-xp  /opt/mozilla/lib/mozilla-bin
VmRss:     216 kB 		 VmData:       0 KB
VmStk:       0 kB 		 VmExe:     244 kB
VmLib:       0 kB 		 Shared:       0 kB
Private:     244 kB 		 Shareable:       0 kB
08085000-08087000 rw-p  /opt/mozilla/lib/mozilla-bin
VmRss:       8 kB 		 VmData:       0 KB
VmStk:       0 kB 		 VmExe:       0 kB
VmLib:       0 kB 		 Shared:       0 kB
Private:       8 kB 		 Shareable:       0 kB
08087000-0879e000 rwxp
VmRss:    7188 kB 		 VmData:    7260 KB
VmStk:       0 kB 		 VmExe:       0 kB
VmLib:       0 kB 		 Shared:       0 kB
Private:    7260 kB 		 Shareable:       0 kB
40000000-40018000 r-xp  /lib/ld-2.3.2.so
VmRss:      92 kB 		 VmData:       0 KB
VmStk:       0 kB 		 VmExe:       0 kB
VmLib:      96 kB 		 Shared:       0 kB
Private:      96 kB 		 Shareable:       0 kB
40018000-40019000 rw-p  /lib/ld-2.3.2.so
VmRss:       4 kB 		 VmData:       0 KB
VmStk:       0 kB 		 VmExe:       0 kB
VmLib:       0 kB 		 Shared:       0 kB
Private:       4 kB 		 Shareable:       0 kB
40019000-4001a000 rw-p
VmRss:       4 kB 		 VmData:       4 KB
VmStk:       0 kB 		 VmExe:       0 kB
VmLib:       0 kB 		 Shared:       0 kB
Private:       4 kB 		 Shareable:       0 kB
....
etc.

Here it goes the new patch. Note that there are actually two patches for
fs/proc/base.c and fs/proc/task_mmu.c files.

BR

Edjard

--- linux-2.6.0-test11/fs/proc/base.c	2003-11-26 14:44:31.000000000 -0600
+++ linux/fs/proc/base.c	2003-12-16 16:02:28.000000000 -0600
@@ -60,6 +60,7 @@
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
+	PROC_TGID_SMAPS,	/* created by 10LE */
 #ifdef CONFIG_SECURITY
 	PROC_TGID_ATTR,
 	PROC_TGID_ATTR_CURRENT,
@@ -83,6 +84,7 @@
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
+	PROC_TID_SMAPS,		/* created by 10LE */
 #ifdef CONFIG_SECURITY
 	PROC_TID_ATTR,
 	PROC_TID_ATTR_CURRENT,
@@ -117,6 +119,7 @@
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),	/* created by 10LE */
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -139,6 +142,7 @@
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -439,6 +443,27 @@
 	.release	= seq_release,
 };

+/* BEGIN - Created by 10LE */
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
+/* END - Created by 10LE */
+
 extern struct seq_operations mounts_op;
 static int mounts_open(struct inode *inode, struct file *file)
 {
@@ -1332,6 +1357,10 @@
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

/********************* HERE BEGIN THE OTHER PATCH ********************
--- linux-2.6.0-test11/fs/proc/task_mmu.c	2003-11-26 14:43:07.000000000 -0600
+++ linux/fs/proc/task_mmu.c	2003-12-16 16:45:02.000000000 -0600
@@ -111,6 +111,96 @@
 	return 0;
 }

+/* Proposed by 10LE - Calculates the RSS for /proc/PID/smaps entry.
+ */
+void resident_mem_size(struct mm_struct *mm, unsigned long start_address,
+			unsigned long end_address, unsigned long *size) {
+	pgd_t *my_pgd;
+	pmd_t *my_pmd;
+	pte_t *my_pte;
+	unsigned long page;
+
+	for (page = start_address; page < end_address; page += PAGE_SIZE) {
+		my_pgd = pgd_offset(mm, page);
+		if (pgd_none(*my_pgd) || pgd_bad(*my_pgd)) continue;
+		my_pmd = pmd_offset(my_pgd, page);
+		if (pmd_none(*my_pmd) || pmd_bad(*my_pmd)) continue;
+		my_pte = pte_offset_map(my_pmd, page);
+		if (pte_present(*my_pte)) {
+			*size += PAGE_SIZE;
+		}
+	  }
+}
+
+/* Proposed by 10LE - Compute and calculates rss, shared, private,
shareable,
+ * data, stack, executable and libray size for each VM_AREA of a PID in new
+ * entry /proc/PID/smaps.
+ */
+static int show_smap(struct seq_file *m, void *v)
+{
+	struct vm_area_struct *map = v;
+	struct file *file = map->vm_file;
+	int flags = map->vm_flags;
+	int len;
+	struct mm_struct *mm = map->vm_mm;
+	unsigned long rss = 0, shared = 0, private = 0, shareable = 0;
+	unsigned long data = 0, stack = 0, exec = 0, lib = 0;
+	unsigned long vma_len = (map->vm_end - map->vm_start) >> 10;
+
+	resident_mem_size(mm, map->vm_start, map->vm_end, &rss);
+
+	if (map->vm_flags & VM_MAYSHARE) {
+		shareable = vma_len;
+		if (map->vm_flags & VM_SHARED) {
+			shared = vma_len;
+		}
+	}
+	else {
+		private = vma_len;
+	}
+
+	if (!map->vm_file) {
+		data = vma_len;
+	}
+	else if (map->vm_flags & VM_GROWSDOWN) {
+		stack = vma_len;
+	}
+	else if (map->vm_flags & VM_EXEC) {
+		if (map->vm_flags & VM_EXECUTABLE)
+			exec = vma_len;
+		else
+			lib = vma_len;
+	}
+
+	seq_printf(m, "%08lx-%08lx %c%c%c%c %n",
+			map->vm_start,
+			map->vm_end,
+			flags & VM_READ ? 'r' : '-',
+			flags & VM_WRITE ? 'w' : '-',
+			flags & VM_EXEC ? 'x' : '-',
+			flags & VM_MAYSHARE ? 's' : 'p',
+			&len);
+
+	if (map->vm_file) {
+		len = sizeof(void*) * 6 - len;
+		if (len < 1)
+			len = 1;
+		seq_printf(m, "%*c", len, ' ');
+		seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
+	}
+	seq_putc(m, '\n');
+	seq_printf(m, "VmRss:%8lu kB \t\t VmData:%8lu KB\n"
+			"VmStk:%8lu kB \t\t VmExe:%8lu kB\n"
+			"VmLib:%8lu kB \t\t Shared:%8lu kB\n"
+			"Private:%8lu kB \t\t Shareable:%8lu kB\n",
+			rss >> 10, data,
+			stack, exec,
+			lib, shared,
+			private, shareable);
+	return 0;
+}
+
+
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct task_struct *task = m->private;
@@ -158,3 +248,13 @@
 	.stop	= m_stop,
 	.show	= show_map
 };
+
+/* Proposed by 10LE - Differs from the above struct only in the .show
+ * function variable (or field).
+ */
+struct seq_operations proc_pid_smaps_op = {
+	.start	= m_start,
+	.next	= m_next,
+	.stop	= m_stop,
+	.show	= show_smap
+};

