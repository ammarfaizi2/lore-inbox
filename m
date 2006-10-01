Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWJAVNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWJAVNS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 17:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWJAVNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 17:13:18 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:32404 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932388AbWJAVNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 17:13:17 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
Subject: [PATCH 2/4] fdtable: Make fdarray and fdsets equal in size.
Date: Sun, 1 Oct 2006 14:13:15 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610011413.15870.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, each fdtable supports three dynamically-sized arrays of data: the
fdarray and two fdsets. The code allows the number of fds supported by the
fdarray (fdtable->max_fds) to differ from the number of fds supported by each
of the fdsets (fdtable->max_fdset). In practice, it is wasteful for these two
sizes to differ: whenever we hit a limit on the smaller-capacity structure, we
will reallocate the entire fdtable and all the dynamic arrays within it, so
any delta in the memory used by the larger-capacity structure will never be
touched at all. Rather than hogging this excess, we shouldn't even allocate it
in the first place, and keep the capacities of the fdarray and the fdsets
equal. This patch removes fdtable->max_fdset. As an added bonus, most of the
supporting code becomes simpler.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru old/arch/alpha/kernel/osf_sys.c new/arch/alpha/kernel/osf_sys.c
--- old/arch/alpha/kernel/osf_sys.c	2006-09-25 22:31:54.000000000 -0700
+++ new/arch/alpha/kernel/osf_sys.c	2006-09-25 22:37:40.000000000 -0700
@@ -979,7 +979,7 @@ osf_select(int n, fd_set __user *inp, fd
 	long timeout;
 	int ret = -EINVAL;
 	struct fdtable *fdt;
-	int max_fdset;
+	int max_fds;
 
 	timeout = MAX_SCHEDULE_TIMEOUT;
 	if (tvp) {
@@ -1003,9 +1003,9 @@ osf_select(int n, fd_set __user *inp, fd
 
 	rcu_read_lock();
 	fdt = files_fdtable(current->files);
-	max_fdset = fdt->max_fdset;
+	max_fds = fdt->max_fds;
 	rcu_read_unlock();
-	if (n < 0 || n > max_fdset)
+	if (n < 0 || n > max_fds)
 		goto out_nofds;
 
 	/*
diff -Npru old/arch/mips/kernel/kspd.c new/arch/mips/kernel/kspd.c
--- old/arch/mips/kernel/kspd.c	2006-09-25 22:31:54.000000000 -0700
+++ new/arch/mips/kernel/kspd.c	2006-09-25 22:37:40.000000000 -0700
@@ -301,7 +301,7 @@ static void sp_cleanup(void)
 	for (;;) {
 		unsigned long set;
 		i = j * __NFDBITS;
-		if (i >= fdt->max_fdset || i >= fdt->max_fds)
+		if (i >= fdt->max_fds)
 			break;
 		set = fdt->open_fds->fds_bits[j++];
 		while (set) {
diff -Npru old/fs/compat.c new/fs/compat.c
--- old/fs/compat.c	2006-09-25 22:31:54.000000000 -0700
+++ new/fs/compat.c	2006-09-25 22:37:40.000000000 -0700
@@ -1676,19 +1676,19 @@ int compat_core_sys_select(int n, compat
 {
 	fd_set_bits fds;
 	char *bits;
-	int size, max_fdset, ret = -EINVAL;
+	int size, max_fds, ret = -EINVAL;
 	struct fdtable *fdt;
 
 	if (n < 0)
 		goto out_nofds;
 
-	/* max_fdset can increase, so grab it once to avoid race */
+	/* max_fds can increase, so grab it once to avoid race */
 	rcu_read_lock();
 	fdt = files_fdtable(current->files);
-	max_fdset = fdt->max_fdset;
+	max_fds = fdt->max_fds;
 	rcu_read_unlock();
-	if (n > max_fdset)
-		n = max_fdset;
+	if (n > max_fds)
+		n = max_fds;
 
 	/*
 	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
diff -Npru old/fs/exec.c new/fs/exec.c
--- old/fs/exec.c	2006-09-25 22:31:54.000000000 -0700
+++ new/fs/exec.c	2006-09-25 22:37:40.000000000 -0700
@@ -782,7 +782,7 @@ static void flush_old_files(struct files
 		j++;
 		i = j * __NFDBITS;
 		fdt = files_fdtable(files);
-		if (i >= fdt->max_fds || i >= fdt->max_fdset)
+		if (i >= fdt->max_fds)
 			break;
 		set = fdt->close_on_exec->fds_bits[j];
 		if (!set)
diff -Npru old/fs/fcntl.c new/fs/fcntl.c
--- old/fs/fcntl.c	2006-09-25 22:31:54.000000000 -0700
+++ new/fs/fcntl.c	2006-09-25 22:37:40.000000000 -0700
@@ -77,10 +77,9 @@ repeat:
 		start = files->next_fd;
 
 	newfd = start;
-	if (start < fdt->max_fdset) {
+	if (start < fdt->max_fds)
 		newfd = find_next_zero_bit(fdt->open_fds->fds_bits,
-			fdt->max_fdset, start);
-	}
+					   fdt->max_fds, start);
 	
 	error = -EMFILE;
 	if (newfd >= current->signal->rlim[RLIMIT_NOFILE].rlim_cur)
diff -Npru old/fs/file.c new/fs/file.c
--- old/fs/file.c	2006-09-25 22:31:54.000000000 -0700
+++ new/fs/file.c	2006-09-25 22:37:40.000000000 -0700
@@ -69,8 +69,8 @@ void free_fd_array(struct file **array, 
 
 static void __free_fdtable(struct fdtable *fdt)
 {
-	free_fdset(fdt->open_fds, fdt->max_fdset);
-	free_fdset(fdt->close_on_exec, fdt->max_fdset);
+	free_fdset(fdt->open_fds, fdt->max_fds);
+	free_fdset(fdt->close_on_exec, fdt->max_fds);
 	free_fd_array(fdt->fd, fdt->max_fds);
 	kfree(fdt);
 }
@@ -113,7 +113,7 @@ static void free_fdtable_rcu(struct rcu_
 	struct fdtable_defer *fddef;
 
 	BUG_ON(!fdt);
-	fdset_size = fdt->max_fdset / 8;
+	fdset_size = fdt->max_fds / 8;
 	fdarray_size = fdt->max_fds * sizeof(struct file *);
 
 	if (fdt->free_files) {
@@ -125,13 +125,11 @@ static void free_fdtable_rcu(struct rcu_
 		kmem_cache_free(files_cachep, fdt->free_files);
 		return;
 	}
-	if (fdt->max_fdset <= EMBEDDED_FD_SET_SIZE &&
-		fdt->max_fds <= NR_OPEN_DEFAULT) {
+	if (fdt->max_fds <= NR_OPEN_DEFAULT)
 		/*
 		 * The fdtable was embedded
 		 */
 		return;
-	}
 	if (fdset_size <= PAGE_SIZE && fdarray_size <= PAGE_SIZE) {
 		kfree(fdt->open_fds);
 		kfree(fdt->close_on_exec);
@@ -156,9 +154,7 @@ static void free_fdtable_rcu(struct rcu_
 
 void free_fdtable(struct fdtable *fdt)
 {
-	if (fdt->free_files ||
-		fdt->max_fdset > EMBEDDED_FD_SET_SIZE ||
-		fdt->max_fds > NR_OPEN_DEFAULT)
+	if (fdt->free_files || fdt->max_fds > NR_OPEN_DEFAULT)
 		call_rcu(&fdt->rcu, free_fdtable_rcu);
 }
 
@@ -171,12 +167,11 @@ static void copy_fdtable(struct fdtable 
 	int i;
 	int count;
 
-	BUG_ON(nfdt->max_fdset < fdt->max_fdset);
 	BUG_ON(nfdt->max_fds < fdt->max_fds);
 	/* Copy the existing tables and install the new pointers */
 
-	i = fdt->max_fdset / (sizeof(unsigned long) * 8);
-	count = (nfdt->max_fdset - fdt->max_fdset) / 8;
+	i = fdt->max_fds / (sizeof(unsigned long) * 8);
+	count = (nfdt->max_fds - fdt->max_fds) / 8;
 
 	/*
 	 * Don't copy the entire array if the current fdset is
@@ -184,9 +179,9 @@ static void copy_fdtable(struct fdtable 
 	 */
 	if (i) {
 		memcpy (nfdt->open_fds, fdt->open_fds,
-						fdt->max_fdset/8);
+						fdt->max_fds/8);
 		memcpy (nfdt->close_on_exec, fdt->close_on_exec,
-						fdt->max_fdset/8);
+						fdt->max_fds/8);
 		memset (&nfdt->open_fds->fds_bits[i], 0, count);
 		memset (&nfdt->close_on_exec->fds_bits[i], 0, count);
 	}
@@ -221,7 +216,7 @@ fd_set * alloc_fdset(int num)
 
 void free_fdset(fd_set *array, int num)
 {
-	if (num <= EMBEDDED_FD_SET_SIZE) /* Don't free an embedded fdset */
+	if (num <= NR_OPEN_DEFAULT) /* Don't free an embedded fdset */
 		return;
 	else if (num <= 8 * PAGE_SIZE)
 		kfree(array);
@@ -240,18 +235,6 @@ static struct fdtable *alloc_fdtable(int
 	if (!fdt)
   		goto out;
 
-	nfds = max_t(int, 8 * L1_CACHE_BYTES, roundup_pow_of_two(nr + 1));
-	if (nfds > NR_OPEN)
-		nfds = NR_OPEN;
-
-  	new_openset = alloc_fdset(nfds);
-  	new_execset = alloc_fdset(nfds);
-  	if (!new_openset || !new_execset)
-  		goto out;
-	fdt->open_fds = new_openset;
-	fdt->close_on_exec = new_execset;
-	fdt->max_fdset = nfds;
-
 	nfds = NR_OPEN_DEFAULT;
 	/*
 	 * Expand to the max in easy steps, and keep expanding it until
@@ -271,15 +254,21 @@ static struct fdtable *alloc_fdtable(int
 				nfds = NR_OPEN;
   		}
 	} while (nfds <= nr);
+
+  	new_openset = alloc_fdset(nfds);
+  	new_execset = alloc_fdset(nfds);
+  	if (!new_openset || !new_execset)
+  		goto out;
+	fdt->open_fds = new_openset;
+	fdt->close_on_exec = new_execset;
+
 	new_fds = alloc_fd_array(nfds);
 	if (!new_fds)
-		goto out2;
+		goto out;
 	fdt->fd = new_fds;
 	fdt->max_fds = nfds;
 	fdt->free_files = NULL;
 	return fdt;
-out2:
-	nfds = fdt->max_fdset;
 out:
 	free_fdset(new_openset, nfds);
 	free_fdset(new_execset, nfds);
@@ -310,7 +299,7 @@ static int expand_fdtable(struct files_s
 	 * we dropped the lock
 	 */
 	cur_fdt = files_fdtable(files);
-	if (nr >= cur_fdt->max_fds || nr >= cur_fdt->max_fdset) {
+	if (nr >= cur_fdt->max_fds) {
 		/* Continue as planned */
 		copy_fdtable(new_fdt, cur_fdt);
 		rcu_assign_pointer(files->fdt, new_fdt);
@@ -336,11 +325,10 @@ int expand_files(struct files_struct *fi
 
 	fdt = files_fdtable(files);
 	/* Do we need to expand? */
-	if (nr < fdt->max_fdset && nr < fdt->max_fds)
+	if (nr < fdt->max_fds)
 		return 0;
 	/* Can we expand? */
-	if (fdt->max_fdset >= NR_OPEN || fdt->max_fds >= NR_OPEN ||
-	    nr >= NR_OPEN)
+	if (nr >= NR_OPEN)
 		return -EMFILE;
 
 	/* All good, so we try */
diff -Npru old/fs/open.c new/fs/open.c
--- old/fs/open.c	2006-09-25 22:31:54.000000000 -0700
+++ new/fs/open.c	2006-09-25 22:37:40.000000000 -0700
@@ -864,8 +864,7 @@ int get_unused_fd(void)
 
 repeat:
 	fdt = files_fdtable(files);
- 	fd = find_next_zero_bit(fdt->open_fds->fds_bits,
-				fdt->max_fdset,
+	fd = find_next_zero_bit(fdt->open_fds->fds_bits, fdt->max_fds,
 				files->next_fd);
 
 	/*
diff -Npru old/fs/select.c new/fs/select.c
--- old/fs/select.c	2006-09-25 22:31:54.000000000 -0700
+++ new/fs/select.c	2006-09-25 22:37:40.000000000 -0700
@@ -311,7 +311,7 @@ static int core_sys_select(int n, fd_set
 {
 	fd_set_bits fds;
 	void *bits;
-	int ret, max_fdset;
+	int ret, max_fds;
 	unsigned int size;
 	struct fdtable *fdt;
 	/* Allocate small arguments on the stack to save memory and be faster */
@@ -321,13 +321,13 @@ static int core_sys_select(int n, fd_set
 	if (n < 0)
 		goto out_nofds;
 
-	/* max_fdset can increase, so grab it once to avoid race */
+	/* max_fds can increase, so grab it once to avoid race */
 	rcu_read_lock();
 	fdt = files_fdtable(current->files);
-	max_fdset = fdt->max_fdset;
+	max_fds = fdt->max_fds;
 	rcu_read_unlock();
-	if (n > max_fdset)
-		n = max_fdset;
+	if (n > max_fds)
+		n = max_fds;
 
 	/*
 	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
diff -Npru old/include/linux/file.h new/include/linux/file.h
--- old/include/linux/file.h	2006-09-25 22:31:54.000000000 -0700
+++ new/include/linux/file.h	2006-09-25 22:37:40.000000000 -0700
@@ -26,14 +26,8 @@ struct embedded_fd_set {
 	unsigned long fds_bits[1];
 };
 
-/*
- * More than this number of fds: we use a separately allocated fd_set
- */
-#define EMBEDDED_FD_SET_SIZE (BITS_PER_BYTE * sizeof(struct embedded_fd_set))
-
 struct fdtable {
 	unsigned int max_fds;
-	int max_fdset;
 	struct file ** fd;      /* current fd array */
 	fd_set *close_on_exec;
 	fd_set *open_fds;
diff -Npru old/include/linux/init_task.h new/include/linux/init_task.h
--- old/include/linux/init_task.h	2006-09-25 22:31:54.000000000 -0700
+++ new/include/linux/init_task.h	2006-09-25 22:37:40.000000000 -0700
@@ -11,7 +11,6 @@
 #define INIT_FDTABLE \
 {							\
 	.max_fds	= NR_OPEN_DEFAULT, 		\
-	.max_fdset	= EMBEDDED_FD_SET_SIZE,		\
 	.fd		= &init_files.fd_array[0], 	\
 	.close_on_exec	= (fd_set *)&init_files.close_on_exec_init, \
 	.open_fds	= (fd_set *)&init_files.open_fds_init, 	\
diff -Npru old/kernel/exit.c new/kernel/exit.c
--- old/kernel/exit.c	2006-09-25 22:31:54.000000000 -0700
+++ new/kernel/exit.c	2006-09-25 22:37:40.000000000 -0700
@@ -428,7 +428,7 @@ static void close_files(struct files_str
 	for (;;) {
 		unsigned long set;
 		i = j * __NFDBITS;
-		if (i >= fdt->max_fdset || i >= fdt->max_fds)
+		if (i >= fdt->max_fds)
 			break;
 		set = fdt->open_fds->fds_bits[j++];
 		while (set) {
diff -Npru old/kernel/fork.c new/kernel/fork.c
--- old/kernel/fork.c	2006-09-25 22:36:20.000000000 -0700
+++ new/kernel/fork.c	2006-09-25 22:37:40.000000000 -0700
@@ -596,7 +596,7 @@ static inline int copy_fs(unsigned long 
 
 static int count_open_files(struct fdtable *fdt)
 {
-	int size = fdt->max_fdset;
+	int size = fdt->max_fds;
 	int i;
 
 	/* Find the last open fd */
@@ -623,7 +623,6 @@ static struct files_struct *alloc_files(
 	newf->next_fd = 0;
 	fdt = &newf->fdtab;
 	fdt->max_fds = NR_OPEN_DEFAULT;
-	fdt->max_fdset = EMBEDDED_FD_SET_SIZE;
 	fdt->close_on_exec = (fd_set *)&newf->close_on_exec_init;
 	fdt->open_fds = (fd_set *)&newf->open_fds_init;
 	fdt->fd = &newf->fd_array[0];
@@ -644,7 +643,7 @@ static struct files_struct *dup_fd(struc
 {
 	struct files_struct *newf;
 	struct file **old_fds, **new_fds;
-	int open_files, size, i, expand;
+	int open_files, size, i;
 	struct fdtable *old_fdt, *new_fdt;
 
 	*errorp = -ENOMEM;
@@ -655,25 +654,14 @@ static struct files_struct *dup_fd(struc
 	spin_lock(&oldf->file_lock);
 	old_fdt = files_fdtable(oldf);
 	new_fdt = files_fdtable(newf);
-	size = old_fdt->max_fdset;
 	open_files = count_open_files(old_fdt);
-	expand = 0;
 
 	/*
-	 * Check whether we need to allocate a larger fd array or fd set.
-	 * Note: we're not a clone task, so the open count won't  change.
+	 * Check whether we need to allocate a larger fd array and fd set.
+	 * Note: we're not a clone task, so the open count won't change.
 	 */
-	if (open_files > new_fdt->max_fdset) {
-		new_fdt->max_fdset = 0;
-		expand = 1;
-	}
 	if (open_files > new_fdt->max_fds) {
 		new_fdt->max_fds = 0;
-		expand = 1;
-	}
-
-	/* if the old fdset gets grown now, we'll only copy up to "size" fds */
-	if (expand) {
 		spin_unlock(&oldf->file_lock);
 		spin_lock(&newf->file_lock);
 		*errorp = expand_files(newf, open_files-1);
@@ -719,8 +707,8 @@ static struct files_struct *dup_fd(struc
 	/* This is long word aligned thus could use a optimized version */ 
 	memset(new_fds, 0, size); 
 
-	if (new_fdt->max_fdset > open_files) {
-		int left = (new_fdt->max_fdset-open_files)/8;
+	if (new_fdt->max_fds > open_files) {
+		int left = (new_fdt->max_fds-open_files)/8;
 		int start = open_files / (8 * sizeof(unsigned long));
 
 		memset(&new_fdt->open_fds->fds_bits[start], 0, left);
diff -Npru old/security/selinux/hooks.c new/security/selinux/hooks.c
--- old/security/selinux/hooks.c	2006-09-25 22:31:54.000000000 -0700
+++ new/security/selinux/hooks.c	2006-09-25 22:37:40.000000000 -0700
@@ -1728,7 +1728,7 @@ static inline void flush_unauthorized_fi
 		j++;
 		i = j * __NFDBITS;
 		fdt = files_fdtable(files);
-		if (i >= fdt->max_fds || i >= fdt->max_fdset)
+		if (i >= fdt->max_fds)
 			break;
 		set = fdt->open_fds->fds_bits[j];
 		if (!set)
diff -Npru old/security/slim/slm_main.c new/security/slim/slm_main.c
--- old/security/slim/slm_main.c	2006-09-25 22:31:54.000000000 -0700
+++ new/security/slim/slm_main.c	2006-09-25 22:37:40.000000000 -0700
@@ -156,7 +156,8 @@ static int has_file_wperm(struct slm_fil
 	spin_lock(&files->file_lock);
 	fdt = files_fdtable(files);
 
-	while((fd=find_next_bit(fdt->open_fds->fds_bits, fdt->max_fdset, fd)) < 
fdt->max_fdset) {
+	while ((fd = find_next_bit(fdt->open_fds->fds_bits,
+				   fdt->max_fds, fd)) < fdt->max_fds) {
 		file = fdt->fd[fd++];
 		if (file)
 			rc = mark_has_file_wperm(file, cur_level);
