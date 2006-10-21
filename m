Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992869AbWJUHOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992869AbWJUHOo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161177AbWJUHOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:14:44 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:28039 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992863AbWJUHOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:14:39 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 03 of 23] proc: change uses of f_{dentry, vfsmnt} to use f_path
Message-Id: <e3dd4914187376d8a831.1161411448@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:28 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the proc filesystem code.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

5 files changed, 33 insertions(+), 33 deletions(-)
fs/proc/base.c       |   40 ++++++++++++++++++++--------------------
fs/proc/generic.c    |   10 +++++-----
fs/proc/nommu.c      |    4 ++--
fs/proc/task_mmu.c   |    8 ++++----
fs/proc/task_nommu.c |    4 ++--

diff --git a/fs/proc/base.c b/fs/proc/base.c
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -471,7 +471,7 @@ static ssize_t proc_info_read(struct fil
 static ssize_t proc_info_read(struct file * file, char __user * buf,
 			  size_t count, loff_t *ppos)
 {
-	struct inode * inode = file->f_dentry->d_inode;
+	struct inode * inode = file->f_path.dentry->d_inode;
 	unsigned long page;
 	ssize_t length;
 	struct task_struct *task = get_proc_task(inode);
@@ -511,7 +511,7 @@ static ssize_t mem_read(struct file * fi
 static ssize_t mem_read(struct file * file, char __user * buf,
 			size_t count, loff_t *ppos)
 {
-	struct task_struct *task = get_proc_task(file->f_dentry->d_inode);
+	struct task_struct *task = get_proc_task(file->f_path.dentry->d_inode);
 	char *page;
 	unsigned long src = *ppos;
 	int ret = -ESRCH;
@@ -583,7 +583,7 @@ static ssize_t mem_write(struct file * f
 {
 	int copied;
 	char *page;
-	struct task_struct *task = get_proc_task(file->f_dentry->d_inode);
+	struct task_struct *task = get_proc_task(file->f_path.dentry->d_inode);
 	unsigned long dst = *ppos;
 
 	copied = -ESRCH;
@@ -653,7 +653,7 @@ static ssize_t oom_adjust_read(struct fi
 static ssize_t oom_adjust_read(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	struct task_struct *task = get_proc_task(file->f_dentry->d_inode);
+	struct task_struct *task = get_proc_task(file->f_path.dentry->d_inode);
 	char buffer[PROC_NUMBUF];
 	size_t len;
 	int oom_adjust;
@@ -695,7 +695,7 @@ static ssize_t oom_adjust_write(struct f
 		return -EINVAL;
 	if (*end == '\n')
 		end++;
-	task = get_proc_task(file->f_dentry->d_inode);
+	task = get_proc_task(file->f_path.dentry->d_inode);
 	if (!task)
 		return -ESRCH;
 	task->oomkilladj = oom_adjust;
@@ -715,7 +715,7 @@ static ssize_t proc_loginuid_read(struct
 static ssize_t proc_loginuid_read(struct file * file, char __user * buf,
 				  size_t count, loff_t *ppos)
 {
-	struct inode * inode = file->f_dentry->d_inode;
+	struct inode * inode = file->f_path.dentry->d_inode;
 	struct task_struct *task = get_proc_task(inode);
 	ssize_t length;
 	char tmpbuf[TMPBUFLEN];
@@ -731,7 +731,7 @@ static ssize_t proc_loginuid_write(struc
 static ssize_t proc_loginuid_write(struct file * file, const char __user * buf,
 				   size_t count, loff_t *ppos)
 {
-	struct inode * inode = file->f_dentry->d_inode;
+	struct inode * inode = file->f_path.dentry->d_inode;
 	char *page, *tmp;
 	ssize_t length;
 	uid_t loginuid;
@@ -782,7 +782,7 @@ static ssize_t seccomp_read(struct file 
 static ssize_t seccomp_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *ppos)
 {
-	struct task_struct *tsk = get_proc_task(file->f_dentry->d_inode);
+	struct task_struct *tsk = get_proc_task(file->f_path.dentry->d_inode);
 	char __buf[20];
 	loff_t __ppos = *ppos;
 	size_t len;
@@ -805,7 +805,7 @@ static ssize_t seccomp_write(struct file
 static ssize_t seccomp_write(struct file *file, const char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	struct task_struct *tsk = get_proc_task(file->f_dentry->d_inode);
+	struct task_struct *tsk = get_proc_task(file->f_path.dentry->d_inode);
 	char __buf[20], *end;
 	unsigned int seccomp_mode;
 	ssize_t result;
@@ -1075,7 +1075,7 @@ static int proc_fill_cache(struct file *
 	char *name, int len,
 	instantiate_t instantiate, struct task_struct *task, void *ptr)
 {
-	struct dentry *child, *dir = filp->f_dentry;
+	struct dentry *child, *dir = filp->f_path.dentry;
 	struct inode *inode;
 	struct qstr qname;
 	ino_t ino = 0;
@@ -1154,8 +1154,8 @@ static int proc_fd_link(struct inode *in
 		spin_lock(&files->file_lock);
 		file = fcheck_files(files, fd);
 		if (file) {
-			*mnt = mntget(file->f_vfsmnt);
-			*dentry = dget(file->f_dentry);
+			*mnt = mntget(file->f_path.mnt);
+			*dentry = dget(file->f_path.dentry);
 			spin_unlock(&files->file_lock);
 			put_files_struct(files);
 			return 0;
@@ -1290,7 +1290,7 @@ static int proc_fd_fill_cache(struct fil
 
 static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
 {
-	struct dentry *dentry = filp->f_dentry;
+	struct dentry *dentry = filp->f_path.dentry;
 	struct inode *inode = dentry->d_inode;
 	struct task_struct *p = get_proc_task(inode);
 	unsigned int fd, tid, ino;
@@ -1437,7 +1437,7 @@ static int proc_pident_readdir(struct fi
 {
 	int i;
 	int pid;
-	struct dentry *dentry = filp->f_dentry;
+	struct dentry *dentry = filp->f_path.dentry;
 	struct inode *inode = dentry->d_inode;
 	struct task_struct *task = get_proc_task(inode);
 	struct pid_entry *p, *last;
@@ -1493,7 +1493,7 @@ static ssize_t proc_pid_attr_read(struct
 static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
 				  size_t count, loff_t *ppos)
 {
-	struct inode * inode = file->f_dentry->d_inode;
+	struct inode * inode = file->f_path.dentry->d_inode;
 	unsigned long page;
 	ssize_t length;
 	struct task_struct *task = get_proc_task(inode);
@@ -1509,7 +1509,7 @@ static ssize_t proc_pid_attr_read(struct
 		goto out;
 
 	length = security_getprocattr(task,
-				      (char*)file->f_dentry->d_name.name,
+				      (char*)file->f_path.dentry->d_name.name,
 				      (void*)page, count);
 	if (length >= 0)
 		length = simple_read_from_buffer(buf, count, ppos, (char *)page, length);
@@ -1523,7 +1523,7 @@ static ssize_t proc_pid_attr_write(struc
 static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 				   size_t count, loff_t *ppos)
 {
-	struct inode * inode = file->f_dentry->d_inode;
+	struct inode * inode = file->f_path.dentry->d_inode;
 	char *page;
 	ssize_t length;
 	struct task_struct *task = get_proc_task(inode);
@@ -1549,7 +1549,7 @@ static ssize_t proc_pid_attr_write(struc
 		goto out_free;
 
 	length = security_setprocattr(task,
-				      (char*)file->f_dentry->d_name.name,
+				      (char*)file->f_path.dentry->d_name.name,
 				      (void*)page, count);
 out_free:
 	free_page((unsigned long) page);
@@ -1990,7 +1990,7 @@ int proc_pid_readdir(struct file * filp,
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
 	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
-	struct task_struct *reaper = get_proc_task(filp->f_dentry->d_inode);
+	struct task_struct *reaper = get_proc_task(filp->f_path.dentry->d_inode);
 	struct task_struct *task;
 	int tgid;
 
@@ -2231,7 +2231,7 @@ static int proc_task_fill_cache(struct f
 /* for the /proc/TGID/task/ directories */
 static int proc_task_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
-	struct dentry *dentry = filp->f_dentry;
+	struct dentry *dentry = filp->f_path.dentry;
 	struct inode *inode = dentry->d_inode;
 	struct task_struct *leader = get_proc_task(inode);
 	struct task_struct *task;
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -52,7 +52,7 @@ proc_file_read(struct file *file, char _
 proc_file_read(struct file *file, char __user *buf, size_t nbytes,
 	       loff_t *ppos)
 {
-	struct inode * inode = file->f_dentry->d_inode;
+	struct inode * inode = file->f_path.dentry->d_inode;
 	char 	*page;
 	ssize_t	retval=0;
 	int	eof=0;
@@ -203,7 +203,7 @@ proc_file_write(struct file *file, const
 proc_file_write(struct file *file, const char __user *buffer,
 		size_t count, loff_t *ppos)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_path.dentry->d_inode;
 	struct proc_dir_entry * dp;
 	
 	dp = PDE(inode);
@@ -432,7 +432,7 @@ int proc_readdir(struct file * filp,
 	struct proc_dir_entry * de;
 	unsigned int ino;
 	int i;
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	int ret = 0;
 
 	lock_kernel();
@@ -453,7 +453,7 @@ int proc_readdir(struct file * filp,
 			/* fall through */
 		case 1:
 			if (filldir(dirent, "..", 2, i,
-				    parent_ino(filp->f_dentry),
+				    parent_ino(filp->f_path.dentry),
 				    DT_DIR) < 0)
 				goto out;
 			i++;
@@ -558,7 +558,7 @@ static void proc_kill_inodes(struct proc
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
 		struct file * filp = list_entry(p, struct file, f_u.fu_list);
-		struct dentry * dentry = filp->f_dentry;
+		struct dentry * dentry = filp->f_path.dentry;
 		struct inode * inode;
 		const struct file_operations *fops;
 
diff --git a/fs/proc/nommu.c b/fs/proc/nommu.c
--- a/fs/proc/nommu.c
+++ b/fs/proc/nommu.c
@@ -46,7 +46,7 @@ int nommu_vma_show(struct seq_file *m, s
 	file = vma->vm_file;
 
 	if (file) {
-		struct inode *inode = vma->vm_file->f_dentry->d_inode;
+		struct inode *inode = vma->vm_file->f_path.dentry->d_inode;
 		dev = inode->i_sb->s_dev;
 		ino = inode->i_ino;
 	}
@@ -67,7 +67,7 @@ int nommu_vma_show(struct seq_file *m, s
 		if (len < 1)
 			len = 1;
 		seq_printf(m, "%*c", len, ' ');
-		seq_path(m, file->f_vfsmnt, file->f_dentry, "");
+		seq_path(m, file->f_path.mnt, file->f_path.dentry, "");
 	}
 
 	seq_putc(m, '\n');
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -94,8 +94,8 @@ int proc_exe_link(struct inode *inode, s
 	}
 
 	if (vma) {
-		*mnt = mntget(vma->vm_file->f_vfsmnt);
-		*dentry = dget(vma->vm_file->f_dentry);
+		*mnt = mntget(vma->vm_file->f_path.mnt);
+		*dentry = dget(vma->vm_file->f_path.dentry);
 		result = 0;
 	}
 
@@ -135,7 +135,7 @@ static int show_map_internal(struct seq_
 	int len;
 
 	if (file) {
-		struct inode *inode = vma->vm_file->f_dentry->d_inode;
+		struct inode *inode = vma->vm_file->f_path.dentry->d_inode;
 		dev = inode->i_sb->s_dev;
 		ino = inode->i_ino;
 	}
@@ -156,7 +156,7 @@ static int show_map_internal(struct seq_
 	 */
 	if (file) {
 		pad_len_spaces(m, len);
-		seq_path(m, file->f_vfsmnt, file->f_dentry, "\n");
+		seq_path(m, file->f_path.mnt, file->f_path.dentry, "\n");
 	} else {
 		const char *name = arch_vma_name(vma);
 		if (!name) {
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -126,8 +126,8 @@ int proc_exe_link(struct inode *inode, s
 	}
 
 	if (vma) {
-		*mnt = mntget(vma->vm_file->f_vfsmnt);
-		*dentry = dget(vma->vm_file->f_dentry);
+		*mnt = mntget(vma->vm_file->f_path.mnt);
+		*dentry = dget(vma->vm_file->f_path.dentry);
 		result = 0;
 	}
 


