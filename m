Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbUDJWSd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 18:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbUDJWSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 18:18:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49047 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262136AbUDJWSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 18:18:24 -0400
Date: Sat, 10 Apr 2004 23:18:22 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] /proc/<pid>/statfd
Message-ID: <20040410221822.GA1287@gallifrey>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.5 (i686)
X-Uptime: 23:13:24 up  2:15,  1 user,  load average: 0.21, 0.20, 0.09
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch creates a /proc/<pid>/statfd file
that contains one line per file descriptor and gives the current
offset, the mode, flags and an error indicator (from struct file*).

I wrote it as an answer to age old questions such as
'how far into the tape is that tar?' and 'how far has the 30GB
gzip got?'.

It is against 2.6.5 and has been tested on x86 and SPARC.

Comments, suggestions and constructive criticisms welcome.

Dave

 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dagdiff

diff -urN linux-2.6.5-orig/Documentation/filesystems/proc.txt linux-2.6.5/Documentation/filesystems/proc.txt
--- linux-2.6.5-orig/Documentation/filesystems/proc.txt	2004-04-09 15:06:48.000000000 +0100
+++ linux-2.6.5/Documentation/filesystems/proc.txt	2004-04-10 20:43:56.000000000 +0100
@@ -130,6 +130,7 @@
  root	 Link to the root directory of this process
  stat    Process status                                 
  statm   Process memory status information              
+ statfd  Status of the processes file descriptors
  status  Process status in human readable form          
  wchan   If CONFIG_KALLSYMS is set, a pre-decoded wchan
 ..............................................................................
@@ -180,6 +181,13 @@
  dt       number of dirty pages           
 ..............................................................................
 
+The statfd contains one line per open file descriptor in the process - for
+example:
+16 821409 02 0x44009 0
+
+Is file descriptor 16, that is 821409 bytes into the file, has a mode of 02 (octal),
+has flags 0x44009 and no error.
+
 1.2 Kernel data
 ---------------
 
diff -urN linux-2.6.5-orig/fs/proc/base.c linux-2.6.5/fs/proc/base.c
--- linux-2.6.5-orig/fs/proc/base.c	2004-04-09 15:07:04.000000000 +0100
+++ linux-2.6.5/fs/proc/base.c	2004-04-10 20:34:12.000000000 +0100
@@ -57,6 +57,7 @@
 	PROC_TGID_CMDLINE,
 	PROC_TGID_STAT,
 	PROC_TGID_STATM,
+	PROC_TGID_STATFD,
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
@@ -80,6 +81,7 @@
 	PROC_TID_CMDLINE,
 	PROC_TID_STAT,
 	PROC_TID_STATM,
+	PROC_TID_STATFD,
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
@@ -111,6 +113,7 @@
 	E(PROC_TGID_CMDLINE,   "cmdline", S_IFREG|S_IRUGO),
 	E(PROC_TGID_STAT,      "stat",    S_IFREG|S_IRUGO),
 	E(PROC_TGID_STATM,     "statm",   S_IFREG|S_IRUGO),
+	E(PROC_TGID_STATFD,    "statfd",  S_IFREG|S_IRUSR),
 	E(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUGO),
 	E(PROC_TGID_MEM,       "mem",     S_IFREG|S_IRUSR|S_IWUSR),
 	E(PROC_TGID_CWD,       "cwd",     S_IFLNK|S_IRWXUGO),
@@ -133,6 +136,7 @@
 	E(PROC_TID_CMDLINE,    "cmdline", S_IFREG|S_IRUGO),
 	E(PROC_TID_STAT,       "stat",    S_IFREG|S_IRUGO),
 	E(PROC_TID_STATM,      "statm",   S_IFREG|S_IRUGO),
+	E(PROC_TID_STATFD,     "statfd",  S_IFREG|S_IRUGO),
 	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUGO),
 	E(PROC_TID_MEM,        "mem",     S_IFREG|S_IRUSR|S_IWUSR),
 	E(PROC_TID_CWD,        "cwd",     S_IFLNK|S_IRWXUGO),
@@ -167,6 +171,12 @@
 
 #undef E
 
+static int pid_alive(struct task_struct *p)
+{
+	BUG_ON(p->pids[PIDTYPE_PID].pidptr != &p->pids[PIDTYPE_PID].pid);
+	return atomic_read(&p->pids[PIDTYPE_PID].pid.count);
+}
+
 static inline struct task_struct *proc_task(struct inode *inode)
 {
 	return PROC_I(inode)->task;
@@ -513,6 +523,162 @@
 	.release	= mounts_release,
 };
 
+/* ------------------------------------------------------------------------ 
+ * statfd: A file containing one line of information per open file     
+ *    We use the seq_file stuff to let us construct the file on the fly
+ *    The seq_file's private member contains a pointer to a pid_statfd_temps
+ *    The 'v' pointer contains the last loff_t pointer we were given (safe??)
+ *
+ *    (Derived from a mix of the code to do the fd directory, the
+ *    pid/map file and LWN article 22355)
+ *        Dave Gilbert (linux@treblig.org)
+ */
+
+struct pid_statfd_temps {
+	struct task_struct* task;
+	struct files_struct* files;
+};
+
+static void *statfd_start(struct seq_file *m, loff_t *pos)
+{
+	struct pid_statfd_temps* temps=(struct pid_statfd_temps*)m->private;
+	struct task_struct *task = temps->task;
+	int max_fds;
+
+	if (!pid_alive(task))
+		return NULL;
+
+  /* Get hold of the files structure from the task */
+	task_lock(task);
+	temps->files = task->files;
+	if (temps->files)
+		atomic_inc(&temps->files->count); /* stop it being freed while we've got it */
+	task_unlock(task);
+
+	/* Check to see if we are off the end */
+	spin_lock(&temps->files->file_lock);
+	max_fds=temps->files->max_fds;
+	spin_unlock(&temps->files->file_lock);
+
+	if (*pos >= max_fds)
+	{
+		return NULL;
+	}
+
+	return pos;
+}
+
+static void statfd_stop(struct seq_file *m, void *v)
+{
+	struct pid_statfd_temps* temps=(struct pid_statfd_temps*)m->private;
+
+	if (temps->files)
+	{
+		/* Release if they are finished with */
+		put_files_struct(temps->files);
+		temps->files=NULL;
+	}
+}
+
+static void *statfd_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct pid_statfd_temps* temps=(struct pid_statfd_temps*)m->private;
+
+	int max_fds;
+
+	/* Check to see if we are off the end */
+	spin_lock(&temps->files->file_lock);
+	max_fds=temps->files->max_fds;
+	spin_unlock(&temps->files->file_lock);
+
+	/* Lets try another one, and if OK just return the same pointer */
+	if (++(*pos) < max_fds)
+	{
+		return pos;
+	}
+
+	/* Have to release locks etc before we tell seq_file we're done */
+	statfd_stop(m,v);
+	return NULL;
+}
+
+static int statfd_show(struct seq_file *m, void *v)
+{
+	struct pid_statfd_temps* temps=(struct pid_statfd_temps*)m->private;
+	int fd;
+	struct file* file;
+
+	loff_t f_pos;
+	mode_t f_mode;
+	int f_error;
+	unsigned int f_flags;
+ 
+	fd=(int)*(loff_t*)v;
+
+	spin_lock(&temps->files->file_lock);
+	file = fcheck_files(temps->files, fd);
+
+	if (file) {
+		f_pos=file->f_pos;
+		f_mode=file->f_mode;
+		f_error=file->f_error;
+		f_flags=file->f_flags;
+	}
+
+	spin_unlock(&temps->files->file_lock);
+
+	if (file)
+		seq_printf(m,"%d %lld 0%o 0x%x %d\n",fd, (long long)f_pos, f_mode, f_flags, f_error);
+
+	return 0;
+}
+
+static struct seq_operations proc_pid_statfd_seqop = {
+	.start  = statfd_start,
+	.next = statfd_next,
+	.stop = statfd_stop,
+	.show = statfd_show
+};
+
+static int pid_statfd_open(struct inode *inode, struct file *file)
+{
+	struct pid_statfd_temps* temps=kmalloc(sizeof(*temps), GFP_KERNEL);
+	if (!temps)
+		return -ENOMEM;
+
+	temps->task = proc_task(inode);
+	temps->files = NULL;
+
+	int ret = seq_open(file, &proc_pid_statfd_seqop);
+	if (!ret) {
+		struct seq_file *m = file->private_data;
+		m->private = temps;
+	} else {
+		kfree(temps);
+	}
+
+	return ret;
+}
+
+static int pid_statfd_release(struct inode *inode, struct file *file)
+{
+	/* We need to clean up the temporary we allocated in pid_statfd_open
+	 * and then let seq_release do its cleanup */
+	struct seq_file *m = file->private_data;
+	struct pid_statfd_temps* temps = m->private;
+	kfree(temps);
+	return seq_release(inode, file);
+}
+
+static struct file_operations proc_pid_statfd_operations = {
+	.open     = pid_statfd_open,
+	.read     = seq_read,
+	.llseek   = seq_lseek,
+	.release  = pid_statfd_release
+};
+
+/* ------------------------------------------------------------------------ */
+
 #define PROC_BLOCK_SIZE	(3*1024)		/* 4K page size but our output routines use some slack for overruns */
 
 static ssize_t proc_info_read(struct file * file, char * buf,
@@ -771,12 +937,6 @@
 	.follow_link	= proc_pid_follow_link
 };
 
-static int pid_alive(struct task_struct *p)
-{
-	BUG_ON(p->pids[PIDTYPE_PID].pidptr != &p->pids[PIDTYPE_PID].pid);
-	return atomic_read(&p->pids[PIDTYPE_PID].pid.count);
-}
-
 #define NUMBUF 10
 
 static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
@@ -1349,6 +1509,10 @@
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_statm;
 			break;
+		case PROC_TID_STATFD:
+		case PROC_TGID_STATFD:
+			inode->i_fop = &proc_pid_statfd_operations;
+			break;
 		case PROC_TID_MAPS:
 		case PROC_TGID_MAPS:
 			inode->i_fop = &proc_maps_operations;

--/04w6evG8XlLl3ft--
