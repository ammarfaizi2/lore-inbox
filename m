Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271728AbRH0Lr1>; Mon, 27 Aug 2001 07:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271712AbRH0LrT>; Mon, 27 Aug 2001 07:47:19 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:13459 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S271714AbRH0LrB>; Mon, 27 Aug 2001 07:47:01 -0400
Date: Mon, 27 Aug 2001 13:47:15 +0200
To: linux-kernel@vger.kernel.org
Subject: kernel patch to keep control over batch processes
Message-ID: <20010827134715.A21058@mathphys.fsk.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: Christian Engwer <christi@fsmath.zbt.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am not shure, wether any one else could use a patch like this.
We have a cluster at the ,,Kirchhoff Institut fuer Physik'' at
Heidelberg and would like to keep track of the tasks a batch-job forks.

In order to achieve this I have written a kernel-patch (safefork)
(for kernel 2.4.4 right now).

I have added 3 flags and one datum to the task_struct, where I store
my data. Further changes are made to the proc file system, where I
have added a new file /proc/safefork and added some fields to
/proc/$PID/status.
You can mark a process to be watched by piping a command into
/proc/$PID/status.

At least I have made some changes to do_fork and do_exit, in order to
keep track of the forked processes.

Anyone interested in this can have more information at
http://tipsrv.kip.uni-heidelberg.de/christi/safefork

I will also add the most important parts of the patch.

CU Christian

PS: If this is not the right place to post this mail... please don't
    flame me - it's my first patch

PSS: the important parts of the patch LocalWords:  not shure wether
#
# SafeFork kernel patch
#
# additionel ifo in /proc/$PID/status
diff -u -r -N linux/fs/proc/array.c linux-safefork/fs/proc/array.c
--- linux/fs/proc/array.c	Fri Apr  6 19:51:19 2001
+++ linux-safefork/fs/proc/array.c	Sun Aug 26 17:22:26 2001
@@ -76,6 +80,35 @@
 #include <asm/io.h>
 #include <asm/processor.h>
 
+#ifdef CONFIG_SAFEFORK
+static inline char * task_safefork(struct task_struct *p, char *buffer)
+{
+	struct task_struct *list_p;        
+        read_lock(&tasklist_lock);
+	buffer += sprintf(buffer, "sf_flags:\t");
+	if (p->sf_watchme)
+		buffer += sprintf(buffer, "watchme ");
+	if (p->sf_zombie)
+		buffer += sprintf(buffer, "zombie ");
+	if (p->sf_killchildren)
+		buffer += sprintf(buffer, "killchildren");
+	buffer += sprintf(buffer,"\nsf_parent:\t%d", p->sf_parent);
+	if (p->sf_parent==p->pid)
+		buffer += sprintf(buffer, " (me)\n");
+	else
+		buffer += sprintf(buffer, "\n");	    
+	buffer += sprintf(buffer,"\sf_children:");
+	for_each_task(list_p) {
+		if (list_p->sf_parent==p->pid && list_p->pid!=p->pid) {
+			buffer += sprintf(buffer," %d",list_p->pid);	    
+		}
+	}
+	buffer += sprintf(buffer,"\n");
+	read_unlock(&tasklist_lock);	  
+	return buffer;
+}
+#endif
+
 /* Gcc optimizes away "strlen(x)" for constant x */
 #define ADDBUF(buffer, string) \
 do { memcpy(buffer, string, strlen(string)); \
# write support for /proc/$PID/status
diff -u -r -N linux/fs/proc/base.c linux-safefork/fs/proc/base.c
--- linux/fs/proc/base.c	Mon Mar 19 21:34:55 2001
+++ linux-safefork/fs/proc/base.c	Sun Aug 26 17:23:52 2001
@@ -271,6 +276,73 @@
 
 #define PROC_BLOCK_SIZE	(3*1024)		/* 4K page size but our output routines use some slack for overruns */
 
+#ifdef CONFIG_SAFEFORK
+static ssize_t status_safefork_write(struct file * file, const char * buf,
+				     size_t count, loff_t *ppos)
+{
+  	char * buffer;
+	int err;
+	uid_t w_uid, o_uid;
+	struct inode * inode = file->f_dentry->d_inode;
+	struct task_struct *p = inode->u.proc_i.task;
+
+	/* Who is writing? */
+	w_uid = file->f_uid;
+	printk(KERN_DEBUG "%i wants to write to /proc/%i/status\n",
+	       w_uid, p->pid);
+	/* Who own's the process? */
+	o_uid = p->uid;
+	printk(KERN_DEBUG "%i owns /proc/%i/status\n",
+	       o_uid, p->pid);
+
+	/* only root and the process owner can change the flags */
+	if ( o_uid!=w_uid && w_uid!=0)
+		return -EACCES;
+
+	/* check the buffer */
+	if (!buf || count>PAGE_SIZE)
+		return -EINVAL;
+
+	if (!(buffer = (char *) __get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+	copy_from_user(buffer, buf, count);
+
+	err = -EINVAL;
+	/* Here comes a REALLY stupid parser */
+#define SF_KILL "safefork killchildren"
+#define SF_WATCH "safefork watchme"
+	if (0==strncmp(SF_KILL, buffer, strlen(SF_KILL))) {	    
+		if (!p->sf_watchme) {
+			write_lock_irq(&tasklist_lock);
+			/* set the flags
+			// take care of me
+			p->sf_watchme=1;
+			// kill my children :-)
+			p->sf_killchildren=1;
+			// I am the master parent
+			p->sf_parent=p->pid;
+			write_unlock_irq(&tasklist_lock);
+		}
+	}
+	else
+		if (0==strncmp(SF_WATCH, buffer, strlen(SF_WATCH))) {
+			if (!p->sf_watchme) {
+				write_lock_irq(&tasklist_lock);
+				/* set the flags */
+				// take care of me
+				p->sf_watchme=1; 
+				// don't kill my children
+				p->sf_killchildren=0;
+				// I am the master parent
+				p->sf_parent=p->pid;
+				write_unlock_irq(&tasklist_lock);
+			}
+		}
+	free_page((unsigned long) buffer);
+	return err;
+}
+#endif
+
 static ssize_t proc_info_read(struct file * file, char * buf,
 			  size_t count, loff_t *ppos)
 {
# the new file /proc/safefork
diff -u -r -N linux/fs/proc/proc_misc.c linux-safefork/fs/proc/proc_misc.c
--- linux/fs/proc/proc_misc.c	Sat Apr 14 05:26:07 2001
+++ linux-safefork/fs/proc/proc_misc.c	Sun Aug 26 17:24:12 2001
@@ -375,6 +378,54 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+#ifdef CONFIG_SAFEFORK
+static int safefork_read_proc(char *page, char **start, off_t off,
+			      int count, int *eof, void *data)
+{
+	int len,zombie=0,watchme=0,killchildren=0;
+	char* buffer=page;
+	
+	struct task_struct *list_p;        
+        read_lock(&tasklist_lock);
+	
+	buffer += sprintf(buffer, "SafeFork:\n");
+	for_each_task(list_p) {
+		if (list_p->sf_watchme) watchme++;
+		if (list_p->sf_killchildren) killchildren++;
+		if (list_p->sf_zombie) zombie++;
+	}
+	
+	buffer += sprintf(buffer, "watchme [%i]:",watchme);
+	for_each_task(list_p) {
+		if (list_p->sf_watchme) {
+			buffer += sprintf(buffer," %d",list_p->pid);	    
+		}
+	}
+	buffer += sprintf(buffer,"\n");
+	
+	buffer += sprintf(buffer, "killchildren [%i]:",killchildren);
+	for_each_task(list_p) {
+		if (list_p->sf_killchildren) {
+			buffer += sprintf(buffer," %d",list_p->pid);	    
+		}
+	}
+	buffer += sprintf(buffer,"\n");
+	
+	buffer += sprintf(buffer, "zombie [%i]:",zombie);
+	for_each_task(list_p) {
+		if (list_p->sf_zombie) {
+			buffer += sprintf(buffer," %d",list_p->pid);	    
+		}
+	}
+	buffer += sprintf(buffer,"\n");
+	
+	read_unlock(&tasklist_lock);	  
+	
+	len = strlen(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+#endif
+
 static int ioports_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
# the new flags in task_struct
diff -u -r -N linux/include/linux/sched.h linux-safefork/include/linux/sched.h
--- linux/include/linux/sched.h	Sat Apr 28 00:48:34 2001
+++ linux-safefork/include/linux/sched.h	Sun Aug 26 17:40:48 2001
@@ -322,7 +322,17 @@
 	int pdeath_signal;  /*  The signal sent when the parent dies  */
 	/* ??? */
 	unsigned long personality;
-	int dumpable:1;
+
+#ifdef CONFIG_SAFEFORK
+        /* -- flags needed by safefork -- */
+        int sf_killchildren:1;
+        int sf_watchme:1;
+        int sf_zombie:1;
+        pid_t sf_parent; /* the master parent */
+        /* -- end safefork -- */
+#endif
+  
+        int dumpable:1;
 	int did_exec:1;
 	pid_t pid;
 	pid_t pgrp;
# do_exit calls now 2 extra funtions sf_kill_children
# and sf_mark_children
diff -u -r -N linux/kernel/exit.c linux-safefork/kernel/exit.c
--- linux/kernel/exit.c	Fri Feb  9 20:29:44 2001
+++ linux-safefork/kernel/exit.c	Sun Aug 26 17:28:07 2001
@@ -419,6 +429,66 @@
 	write_unlock_irq(&tasklist_lock);
 }
 
+#ifdef CONFIG_SAFEFORK
+/*
+ * if killchildren is set, I will send SIGTERM & SIGKILL to all children
+ */
+void sf_exit_children(struct task_struct *tsk)
+{
+	struct task_struct *list_p;        
+	int priv=1; // kernel privileges
+
+	/* check the flags */
+	if (!tsk->sf_killchildren)
+		return;
+
+	/* loop through the tasks and TERM & KILL */
+	read_lock(&tasklist_lock);
+	for_each_task(list_p) {
+		if (list_p->sf_parent==tsk->pid && list_p->pid!=tsk->pid) {
+			// hope that's the right way to send signals
+			// taken from signal.c
+			send_sig_info(SIGTERM,
+				      (void*)(long)(priv != 0), list_p);
+			send_sig_info(SIGKILL,
+				      (void*)(long)(priv != 0), list_p);
+			printk(KERN_INFO
+			       "safefork: Sending process %i"
+			       "SIGTERM and SIGKILL\n",
+			       list_p->pid );
+		}
+	}
+	read_unlock(&tasklist_lock);
+}
+	
+/*
+ * If I am master parent, then all my children become zombies
+ */
+void sf_mark_children(struct task_struct *tsk)
+{
+	struct task_struct *list_p;        
+
+	/* Am I master? */
+	if (tsk->sf_parent!=tsk->pid)
+		return;
+
+	/* loop through the tasks */
+	write_lock_irq(&tasklist_lock);
+	for_each_task(list_p) {
+		if (list_p->sf_parent==tsk->pid && list_p->pid!=tsk->pid)
+		{
+			/* turn children to zombies */
+			list_p->sf_zombie=1;
+			/* make children master */
+			list_p->sf_killchildren=tsk->sf_killchildren;
+			list_p->sf_parent=list_p->pid;
+		}
+	}
+	write_unlock_irq(&tasklist_lock);
+}
+
+/* end safefork */
+#endif
+
 NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
@@ -445,6 +515,11 @@
 	exit_sighand(tsk);
 	exit_thread();
 
+#ifdef CONFIG_SAFEFORK
+	sf_exit_children(tsk);
+	sf_mark_children(tsk);
+#endif
+	
 	if (current->leader)
 		disassociate_ctty(1);

# do_fork is nearly not changed, I just set one flag 
diff -u -r -N linux/kernel/fork.c linux-safefork/kernel/fork.c
--- linux/kernel/fork.c	Thu Apr 26 15:11:17 2001
+++ linux-safefork/kernel/fork.c	Sun Aug 26 17:29:31 2001
@@ -11,6 +11,13 @@
  * management can be a bitch. See 'mm/memory.c': 'copy_page_tables()'
  */
 
+/*
+ * Changes:
+ * Christian Engwer  :  added SafeFork support
+ *                      little changes to do_fork()
+ *                      <christi@uni-hd.de>
+ */
+
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -601,6 +608,12 @@
 	copy_flags(clone_flags, p);
 	p->pid = get_pid(clone_flags);
 
+#ifdef CONFIG_SAFEFORK
+	/* set safefork flags */
+	p->sf_killchildren=0; // this flag must be set by the user
+	/* end safefork */
+#endif
+	
 	p->run_list.next = NULL;
 	p->run_list.prev = NULL;
 
