Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268153AbUHYRZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbUHYRZE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268173AbUHYRZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:25:03 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:47597 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268153AbUHYRWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:22:08 -0400
Date: Wed, 25 Aug 2004 10:21:31 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20040825172134.28782.65481.93950@sam.engr.sgi.com>
Subject: [PATCH] Cpusets tasks file: simplify format, fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the overly ornate format used to display the list of task
pids attached to a cpuset (the 'tasks' file in each cpuset directory.)
Instead of doing range compression on them to get something like:

	1-4,10-12

instead just print the pids one per line, as in:

	1
	2
	3
	4
	10
	11
	12

This is easier to code to, in both shell scripts and C.

Unfortunately, this patch doesn't provide any code savings, because
the above change uncovered a latent bug - seeks on cpuset tasks files
were not being handled based on a count of bytes emitted on reads,
but based on a count of pids displayed, one count per pid.

    This confused any user code that tried to seek around the file
    using byte counts.

    The 'head' command does this - seeking back to just past the last
    line displayed, if it happened to read more data than it chose
    to display.

    Resolved this by converting the list of pids to their ascii output
    form on the initial open, rather than lazily converting to ascii
    as needed to respond to a read.  This way, we can seek based on
    output byte counts instead of counting the pids.

While I was here, broke up the cpuset_tasks_mkctr() routine into
subroutines, since it was getting to be more code than would fit in
my head.

And Simon pointed out to me that the release of the ctr structure
used here, in cpuset_tasks_release(), was buggy: need to check that
the ctr == file->private_data really is not NULL.

Applies to 2.6.8.1-mm4.  Builds, boots and unit tests on ia64 sn2_defconfig.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.8.1-mm4/kernel/cpuset.c
===================================================================
--- 2.6.8.1-mm4.orig/kernel/cpuset.c	2004-08-25 08:10:27.000000000 -0700
+++ 2.6.8.1-mm4/kernel/cpuset.c	2004-08-25 08:12:04.000000000 -0700
@@ -997,117 +997,116 @@ static int cpuset_add_file(struct dentry
 /* cpusets_tasks_read array */
 
 struct ctr_struct {
-	int *array;
-	int count;
+	char *buf;
+	int bufsz;
 };
 
-static struct ctr_struct *cpuset_tasks_mkctr(struct file *file)
+/*
+ * Load into 'pidarray' up to 'npids' of the tasks using cpuset 'cs'.
+ * Return actual number of pids loaded.
+ */
+static inline int pid_array_load(pid_t *pidarray, int npids, struct cpuset *cs)
 {
-	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
-	struct ctr_struct *ctr;
-	pid_t *array;
-	int n, max;
-	pid_t i, j, last;
+	int n = 0;
 	struct task_struct *g, *p;
 
-	ctr = kmalloc(sizeof(*ctr), GFP_KERNEL);
-	if (!ctr)
-		return NULL;
-
-	/*
-	 * If cpuset gets more users after we read count, we won't have
-	 * enough space - tough.  This race is indistinguishable to the
-	 * caller from the case that the additional cpuset users didn't
-	 * show up until sometime later on.  Grabbing cpuset_sem would
-	 * not help, because cpuset_fork() doesn't grab cpuset_sem.
-	 */
-
-	max = atomic_read(&cs->count);
-	array = kmalloc(max * sizeof(pid_t), GFP_KERNEL);
-	if (!array) {
-		kfree(ctr);
-		return NULL;
-	}
-
-	n = 0;
 	read_lock(&tasklist_lock);
+
 	do_each_thread(g, p) {
 		if (p->cpuset == cs) {
-			array[n++] = p->pid;
-			if (unlikely(n == max))
+			pidarray[n++] = p->pid;
+			if (unlikely(n == npids))
 				goto array_full;
 		}
 	}
 	while_each_thread(g, p);
+
 array_full:
 	read_unlock(&tasklist_lock);
+	return n;
+}
 
-	/* stupid bubble sort */
-	for (i = 0; i < n - 1; i++) {
-		for (j = 0; j < n - 1 - i; j++)
-			if (array[j + 1] < array[j]) {
-				pid_t tmp = array[j];
-				array[j] = array[j + 1];
-				array[j + 1] = tmp;
+/*
+ * In place bubble sort pidarray of npids pid_t's.
+ */
+static inline void pid_array_sort(pid_t *pidarray, int npids)
+{
+	int i, j;
+
+	for (i = 0; i < npids - 1; i++) {
+		for (j = 0; j < npids - 1 - i; j++)
+			if (pidarray[j + 1] < pidarray[j]) {
+				pid_t tmp = pidarray[j];
+				pidarray[j] = pidarray[j + 1];
+				pidarray[j + 1] = tmp;
 			}
 	}
+}
+
+/*
+ * Convert array 'a' of 'npids' pid_t's to a string of newline separated
+ * decimal pids in 'buf'.  Don't write more than 'sz' chars, but return
+ * count 'cnt' of how many chars would be written if buf were large enough.
+ */
+static int pid_array_to_buf(char *buf, int sz, pid_t *a, int npids)
+{
+	int cnt = 0;
+	int i;
+
+	for (i = 0; i < npids; i++)
+		cnt += snprintf(buf + cnt, max(sz - cnt, 0), "%d\n", a[i]);
+	return cnt;
+}
+
+static inline struct ctr_struct *cpuset_tasks_mkctr(struct file *file)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct ctr_struct *ctr;
+	pid_t *pidarray;
+	int npids;
+	char c;
+
+	ctr = kmalloc(sizeof(*ctr), GFP_KERNEL);
+	if (!ctr)
+		goto err0;
 
 	/*
-	 * Collapse sorted array by grouping consecutive pids.
-	 * Code range of pids with a negative pid on the second.
-	 * Read from array[i]; write to array]j]; j <= i always.
+	 * If cpuset gets more users after we read count, we won't have
+	 * enough space - tough.  This race is indistinguishable to the
+	 * caller from the case that the additional cpuset users didn't
+	 * show up until sometime later on.
 	 */
-	last = array[0];  /* any value != array[0] - 1 */
-	j = -1;
-	for (i = 0; i < n; i++) {
-		pid_t curr = array[i];
-		/* consecutive pids ? */
-		if (curr - last == 1) {
-			/* move destination index if it has not been done */
-			if (array[j] > 0)
-				j++;
-			array[j] = -curr;
-		} else
-			array[++j] = curr;
-		last = curr;
-	}
+	npids = atomic_read(&cs->count);
+	pidarray = kmalloc(npids * sizeof(pid_t), GFP_KERNEL);
+	if (!pidarray)
+		goto err1;
+
+	npids = pid_array_load(pidarray, npids, cs);
+	pid_array_sort(pidarray, npids);
+
+	/* Call pid_array_to_buf() twice, first just to get bufsz */
+	ctr->bufsz = pid_array_to_buf(&c, sizeof(c), pidarray, npids) + 1;
+	ctr->buf = kmalloc(ctr->bufsz, GFP_KERNEL);
+	if (!ctr->buf)
+		goto err2;
+	ctr->bufsz = pid_array_to_buf(ctr->buf, ctr->bufsz, pidarray, npids);
 
-	ctr->array = array;
-	ctr->count = j + 1;
+	kfree(pidarray);
 	file->private_data = (void *)ctr;
 	return ctr;
-}
-
-/* printf one pid from an array
- * different formatting depending on whether it is positive or negative,
- * or whether it is or not the first pid or the last
- */
-static int array_pid_print(char *buf, pid_t *array, int idx, int last)
-{
-	pid_t v = array[idx];
-	int l = 0;
 
-	if (v < 0) {		/* second pid of a range of pids */
-		v = -v;
-		buf[l++] = '-';
-	} else {		/* first pid of a range, or not a range */
-		if (idx)	/* comma only if it's not the first */
-			buf[l++] = ',';
-	}
-	l += sprintf(buf + l, "%d", v);
-	/* newline after last record */
-	if (idx == last)
-		l += sprintf(buf + l, "\n");
-	return l;
+err2:
+	kfree(pidarray);
+err1:
+	kfree(ctr);
+err0:
+	return NULL;
 }
 
 static ssize_t cpuset_tasks_read(struct file *file, char __user *buf,
 						size_t nbytes, loff_t *ppos)
 {
 	struct ctr_struct *ctr = (struct ctr_struct *)file->private_data;
-	int *array, nr_pids, i;
-	size_t len, lastlen = 0;
-	char *page;
 
 	/* allocate buffer and fill it on first call to read() */
 	if (!ctr) {
@@ -1116,32 +1115,12 @@ static ssize_t cpuset_tasks_read(struct 
 			return -ENOMEM;
 	}
 
-	array = ctr->array;
-	nr_pids = ctr->count;
-
-	if (!(page = (char *)__get_free_page(GFP_KERNEL)))
-		return -ENOMEM;
-
-	i = *ppos;		/* index of pid being printed */
-	len = 0;		/* length of data sprintf'ed in the page */
-
-	while ((len < PAGE_SIZE - 10) && (i < nr_pids) && (len < nbytes)) {
-		lastlen = array_pid_print(page + len, array, i++, nr_pids - 1);
-		len += lastlen;
-	}
-
-	/* if we wrote too much, remove last record */
-	if (len > nbytes) {
-		len -= lastlen;
-		i--;
-	}
-
-	*ppos = i;
-
-	if (copy_to_user(buf, page, len))
-		len = -EFAULT;
-	free_page((unsigned long)page);
-	return len;
+	if (*ppos + nbytes > ctr->bufsz)
+		nbytes = ctr->bufsz - *ppos;
+	if (copy_to_user(buf, ctr->buf + *ppos, nbytes))
+		return -EFAULT;
+	*ppos += nbytes;
+	return nbytes;
 }
 
 static int cpuset_tasks_release(struct inode *unused_inode, struct file *file)
@@ -1153,8 +1132,10 @@ static int cpuset_tasks_release(struct i
 		return 0;
 
 	ctr = (struct ctr_struct *)file->private_data;
-	kfree(ctr->array);
-	kfree(ctr);
+	if (ctr) {
+		kfree(ctr->buf);
+		kfree(ctr);
+	}
 	return 0;
 }
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
