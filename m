Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129769AbQKJOn1>; Fri, 10 Nov 2000 09:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130500AbQKJOnR>; Fri, 10 Nov 2000 09:43:17 -0500
Received: from hvmta03-ext.us.psimail.psi.net ([38.202.36.27]:65021 "EHLO
	hvmta03-stg.us.psimail.psi.net") by vger.kernel.org with ESMTP
	id <S129769AbQKJOnG>; Fri, 10 Nov 2000 09:43:06 -0500
From: "Chris Swiedler" <chris.swiedler@sevista.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Cc: "Rik van Riel" <riel@conectiva.com.br>
Subject: [PATCH] oom_nice
Date: Fri, 10 Nov 2000 09:46:40 -0500
Message-ID: <NDBBIAJKLMMHOGKNMGFNKEFLCPAA.chris.swiedler@sevista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an updated version of the "oom_nice" patch. It allows a sysadmin to
set the "oom niceness" for processes, either by PID or by process name. The
oom niceness value factors into the badness() function called by Rik's
OOM killer. Negative values decrease the chance that the process will be
killed, and positive values increase it.

The usage is:

echo [PID|process_name]=oom_niceness > /proc/sys/vm/oom_nice

examples:

echo 418=-10 > /proc/sys/vm/oom_nice
echo netscape=20 > /proc/sys/vm/oom_nice
echo 1=- > /proc/sys/vm/oom_nice

In the first example, the process with PID 418 is 10 times less likely to
be killed than it would have been. Likewise, in the second example, any
processes named 'netscape' are 20 times more likely to be killed than
otherwise. The last example protects the init process from being killed,
no matter what.

cating oom_nice will show the current nice values for all processes.

By default the oom_nice proc entry is not world-readable or writable. For
security reasons I would suggest that you give good (negative) oom nice
values to processes by PID rather than process name. If any process named
'init' is protected, then it's easy for a user to just rename their
executable
and get around the oom killer.

To test the OOM killer algorithm I also inclued a proc entry
/proc/sys/vm/oom_nice_test. On my machine 'cat /proc/sys/vm/oom_nice_test'
produces:

"OOM killer would have killed process 516 (csh) with 496 points"

Compiling oom_kill.c with DEBUG defined and cating oom_nice_test will print
out the points for all processes, including their oom_nice values and how
they affected the final points.

diff -u -N official/linux-2.4.0/mm/Makefile
work/linux-2.4.0-test10/mm/Makefile
--- official/linux-2.4.0/mm/Makefile	Mon Nov  6 23:53:01 2000
+++ work/linux-2.4.0-test10/mm/Makefile	Tue Nov  7 22:01:00 2000
@@ -10,7 +10,8 @@
 O_TARGET := mm.o
 O_OBJS	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
-	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o
+	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o \
+	    oom_nice.o

 ifeq ($(CONFIG_HIGHMEM),y)
 O_OBJS += highmem.o
--- official/linux-2.4.0/mm/oom_kill.c	Mon Nov  6 23:53:01 2000
+++ work/linux-2.4.0-test10/mm/oom_kill.c	Thu Nov  9 23:12:10 2000
@@ -20,9 +20,12 @@
 #include <linux/swap.h>
 #include <linux/swapctl.h>
 #include <linux/timex.h>
+#include <linux/ctype.h>

 /* #define DEBUG */

+extern int get_oom_nice(struct task_struct *ts);
+
 /**
  * int_sqrt - oom_kill.c internal function, rough approximation to sqrt
  * @x: integer of which to calculate the sqrt
@@ -55,9 +58,9 @@
  *    of least surprise ... (be careful when you change it)
  */

-static int badness(struct task_struct *p)
+int badness(struct task_struct *p)
 {
-	int points, cpu_time, run_time;
+	int points, cpu_time, run_time, oom_nice;

 	if (!p->mm)
 		return 0;
@@ -101,6 +104,22 @@
 	 */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
 		points /= 4;
+
+	oom_nice = get_oom_nice(p);
+#ifdef DEBUG
+	if (oom_nice != 0)
+		printk(KERN_DEBUG "OOMkill: task %d (%s) has oom_nice=%d. start points:
%d\n",
+		p->pid,p->comm,oom_nice,points);
+#endif
+
+	if (oom_nice == INT_MIN)
+		points = 0;
+	else if (oom_nice > 0)
+		points *= oom_nice;
+	else if (oom_nice < 0)
+		points /= -oom_nice;
+
+
 #ifdef DEBUG
 	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
 	p->pid, p->comm, points);
@@ -124,11 +143,12 @@
 	read_lock(&tasklist_lock);
 	for_each_task(p)
 	{
-		if (p->pid)
+		if (p->pid) {
 			points = badness(p);
-		if (points > maxpoints) {
-			chosen = p;
-			maxpoints = points;
+			if (points > maxpoints) {
+				chosen = p;
+				maxpoints = points;
+			}
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -156,7 +176,7 @@
 	if (p == NULL)
 		panic("Out of memory and no killable processes...\n");

-	printk(KERN_ERR "Out of Memory: Killed process %d (%s).", p->pid,
p->comm);
+	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid,
p->comm);

 	/*
 	 * We give our sacrificial lamb high priority and access to
diff -u -N official/linux-2.4.0/mm/oom_nice.c
work/linux-2.4.0-test10/mm/oom_nice.c
--- official/linux-2.4.0/mm/oom_nice.c	Wed Dec 31 19:00:00 1969
+++ work/linux-2.4.0-test10/mm/oom_nice.c	Thu Nov  9 23:19:45 2000
@@ -0,0 +1,250 @@
+/*
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/malloc.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/file.h>
+#include <linux/spinlock.h>
+#include <asm/uaccess.h>
+
+#ifndef CONFIG_PROC_FS
+#error You really need /proc support for oom_nice. Please reconfigure!
+#endif
+
+/* #define DEBUG */
+
+struct oom_nice_entry {
+	struct oom_nice_entry *next;
+	int nice;
+	char *process_name;
+};
+
+static struct oom_nice_entry *entries = NULL;
+static rwlock_t entries_lock __attribute__((unused)) = RW_LOCK_UNLOCKED;
+
+int get_oom_nice(struct task_struct * ts)
+{
+	struct oom_nice_entry *e;
+	char *p;
+	int pid;
+
+	for (e = entries; e; e = e->next) {
+		if (isdigit(e->process_name[0])) {
+			pid = 0;
+			for (p = e->process_name; *p && isdigit(*p); p++)
+				pid = pid * 10 + (*p - '0');
+
+			if (pid == ts->pid)
+				break;
+		}
+		if (strncmp(ts->comm,e->process_name,16) == 0)
+			break;
+	}
+	if (e)
+		return e->nice;
+	else
+		return 0;
+}
+
+/*
+ * Find entry through process name and lock it
+ */
+static struct oom_nice_entry *get_entry(char *process_name)
+{
+	struct oom_nice_entry *e;
+
+	for (e = entries; e; e = e->next) {
+		if (strcmp(process_name,e->process_name) == 0)
+			break;
+	}
+
+	return e;
+}
+
+/*
+ * This registers a new oom niceness with the format
+ * 'pid:nice'
+ */
+static int proc_write_nice(struct file *file, const char *buffer,
+			       unsigned long _count, void *data)
+{
+	struct oom_nice_entry *e;
+	int err, left, count, nice = 0, neg = 0;
+	char c, *p, *process_name;
+
+	count = _count;
+
+	if (buffer[count-1] == '\n')
+		count--;
+
+	/* some sanity checks */
+	err = -EINVAL;
+	if (count > 256)
+		goto _err;
+
+	err = -ENOMEM;
+	if (!(process_name = kmalloc(count+1,GFP_USER)))
+		goto _err;
+
+	p = process_name;
+	left = count;
+	err = -EFAULT;
+	while (left--) {
+		if (get_user(c,(char *)buffer++))
+			goto _err;
+		if (c == ':' || c == '=')
+			break;
+		*p++ = c;
+	}
+
+	*p++ = '\0';
+
+	while (left--) {
+		if (get_user(c,(char *)buffer++))
+			goto _err;
+
+		if (c == '-') {
+			neg = 1;
+			continue;
+		}
+
+		if (!isdigit(c))
+			break;
+
+		nice = (nice * 10) + (c - '0');
+
+		*p++ = c;
+	}
+
+	if (neg) {
+		/* special case: 'pid=-' means completely protected */
+		if (nice == 0)
+			nice = INT_MIN;
+		else
+			nice *= -1;
+	}
+
+	read_lock(&entries_lock);
+	e = get_entry(process_name);
+
+	if (!e) {
+		read_unlock(&entries_lock);
+
+		err = -ENOMEM;
+		if (!(e = (struct oom_nice_entry *) kmalloc(sizeof(struct
oom_nice_entry), GFP_USER))) {
+			kfree(process_name);
+			goto _err;
+		}
+		write_lock(&entries_lock);
+		e->next = entries;
+		e->process_name = process_name;
+		e->nice = nice;
+		entries = e;
+		write_unlock(&entries_lock);
+	}
+	else {
+		e->nice = nice;
+		read_unlock(&entries_lock);
+		kfree(process_name);
+	}
+
+	err = _count;
+
+_err:
+	return err;
+}
+
+/*
+ */
+static int proc_read_nice(char *page, char **start, off_t off,
+			    int count, int *eof, void *data)
+{
+	struct oom_nice_entry *e;
+	int err, elen;
+	char *p = page;
+
+	read_lock(&entries_lock);
+
+	for (e = entries; e; e = e->next) {
+		if (e->nice == INT_MIN)
+			sprintf(p,"%s=-\n",e->process_name);
+		else
+			sprintf(p,"%s=%d\n",e->process_name,e->nice);
+		p = page + strlen(page);
+	}
+
+	read_unlock(&entries_lock);
+
+	elen = strlen(page) - off;
+	if (elen < 0)
+		elen = 0;
+	*eof = (elen <= count) ? 1 : 0;
+	*start = page + off;
+	err = elen;
+
+	return err;
+}
+
+extern int badness(struct task_struct * ts);
+
+static int proc_test(char *page, char **start, off_t off,
+			    int count, int *eof, void *data)
+{
+	struct task_struct *p, *chosen = NULL;
+	int err, elen, points = 0, maxpoints = 0;
+
+	read_lock(&tasklist_lock);
+
+	for_each_task(p) {
+		if (p->pid) {
+			points = badness(p);
+			if (points > maxpoints) {
+				chosen = p;
+				maxpoints = points;
+			}
+		}
+	}
+
+	if (!chosen)
+		sprintf(page,"Error: no bad process could be found.\n");
+	else
+		sprintf(page,"OOM killer would have killed process %d (%s) with %d
points\n",chosen->pid,chosen->comm,maxpoints);
+
+	read_unlock(&tasklist_lock);
+
+	elen = strlen(page) - off;
+	if (elen < 0)
+		elen = 0;
+	*eof = (elen <= count) ? 1 : 0;
+	*start = page + off;
+	err = elen;
+
+	return err;
+}
+
+int __init init_oom_nice(void)
+{
+	int error = -ENOENT;
+	struct proc_dir_entry *oom_nice, *test;
+
+	oom_nice = create_proc_entry("sys/vm/oom_nice", S_IFREG | S_IWUSR, NULL);
+	if (!oom_nice)
+		goto out;
+
+	oom_nice->write_proc = proc_write_nice;
+	oom_nice->read_proc = proc_read_nice;
+
+	test = create_proc_entry("sys/vm/oom_nice_test", S_IFREG | S_IWUSR, NULL);
+	test->read_proc = proc_test;
+out:
+	return error;
+}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
