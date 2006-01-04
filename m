Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWADAGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWADAGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWADAGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:06:23 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:20345 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S965008AbWADAGW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:06:22 -0500
Message-ID: <43BB1178.7020409@cosmosbay.com>
Date: Wed, 04 Jan 2006 01:06:16 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Shrinks sizeof(files_struct) and better layout
References: <20051108185349.6e86cec3.akpm@osdl.org>	<437226B1.4040901@cosmosbay.com> <20051109220742.067c5f3a.akpm@osdl.org> <4373698F.9010608@cosmosbay.com>
In-Reply-To: <4373698F.9010608@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------050301030003060602090100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050301030003060602090100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[PATCH] shrink the fdset and reorder fields to give better multi-threaded 
performance.


This patch :

1) Reduces the size of (struct fdtable) to exactly 64 bytes on 32bits 
platforms, lowering kmalloc() allocated space by 50%.

2) Reduces the size of (files_struct), using a special 32 bits (or 64bits) 
embedded_fd_set, instead of a 1024 bits fd_set for the close_on_exec_init and 
open_fds_init fields. This save some ram (248 bytes per task) as most tasks 
dont open more than 32 files. D-Cache footprint for such tasks is also reduced 
to the minimum.

3) Reduces size of allocated fdset. Currently two full pages are allocated, 
that is 32768 bits on x86 for example, and way too much. The minimum is now 
L1_CACHE_BYTES.

UP and SMP should benefit from this patch, because most tasks will touch only 
one cache line when open()/close() stdin/stdout/stderr (0/1/2), (next_fd, 
close_on_exec_init, open_fds_init, fd_array[0 .. 2] being in the same cache line)

Thank you

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------050301030003060602090100
Content-Type: text/plain;
 name="shrink-fdset-2.6.15.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="shrink-fdset-2.6.15.patch"

--- linux-2.6.15/include/linux/file.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-edum/include/linux/file.h	2006-01-04 00:35:17.000000000 +0100
@@ -17,10 +17,17 @@
  */
 #define NR_OPEN_DEFAULT BITS_PER_LONG
 
+/*
+ * The embedded_fd_set is a small fd_set,
+ * suitable for most tasks (which open <= BITS_PER_LONG files)
+ */
+typedef struct {
+	unsigned long fds_bits[1];
+} embedded_fd_set;
+
 struct fdtable {
 	unsigned int max_fds;
 	int max_fdset;
-	int next_fd;
 	struct file ** fd;      /* current fd array */
 	fd_set *close_on_exec;
 	fd_set *open_fds;
@@ -33,13 +40,20 @@
  * Open file table structure
  */
 struct files_struct {
+  /*
+   * read mostly part
+   */
 	atomic_t count;
 	struct fdtable *fdt;
 	struct fdtable fdtab;
-	fd_set close_on_exec_init;
-	fd_set open_fds_init;
+  /*
+   * written part on a separate cache line in SMP
+   */
+	spinlock_t file_lock ____cacheline_aligned_in_smp;
+	int next_fd;
+	embedded_fd_set close_on_exec_init;
+	embedded_fd_set open_fds_init;
 	struct file * fd_array[NR_OPEN_DEFAULT];
-	spinlock_t file_lock;     /* Protects concurrent writers.  Nests inside tsk->alloc_lock */
 };
 
 #define files_fdtable(files) (rcu_dereference((files)->fdt))
--- linux-2.6.15/include/linux/init_task.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-edum/include/linux/init_task.h	2006-01-04 00:32:05.000000000 +0100
@@ -7,11 +7,10 @@
 #define INIT_FDTABLE \
 {							\
 	.max_fds	= NR_OPEN_DEFAULT, 		\
-	.max_fdset	= __FD_SETSIZE, 		\
-	.next_fd	= 0, 				\
+	.max_fdset	= 8 * sizeof(embedded_fd_set),	\
 	.fd		= &init_files.fd_array[0], 	\
-	.close_on_exec	= &init_files.close_on_exec_init, \
-	.open_fds	= &init_files.open_fds_init, 	\
+	.close_on_exec	= (fd_set *)&init_files.close_on_exec_init, \
+	.open_fds	= (fd_set *)&init_files.open_fds_init, 	\
 	.rcu		= RCU_HEAD_INIT, 		\
 	.free_files	= NULL,		 		\
 	.next		= NULL,		 		\
@@ -20,9 +19,10 @@
 #define INIT_FILES \
 { 							\
 	.count		= ATOMIC_INIT(1), 		\
-	.file_lock	= SPIN_LOCK_UNLOCKED, 		\
 	.fdt		= &init_files.fdtab, 		\
 	.fdtab		= INIT_FDTABLE,			\
+	.file_lock	= SPIN_LOCK_UNLOCKED, 		\
+	.next_fd	= 0, 				\
 	.close_on_exec_init = { { 0, } }, 		\
 	.open_fds_init	= { { 0, } }, 			\
 	.fd_array	= { NULL, } 			\
--- linux-2.6.15/kernel/fork.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-edum/kernel/fork.c	2006-01-04 00:32:05.000000000 +0100
@@ -581,12 +581,12 @@
 	atomic_set(&newf->count, 1);
 
 	spin_lock_init(&newf->file_lock);
+	newf->next_fd = 0;
 	fdt = &newf->fdtab;
-	fdt->next_fd = 0;
 	fdt->max_fds = NR_OPEN_DEFAULT;
-	fdt->max_fdset = __FD_SETSIZE;
-	fdt->close_on_exec = &newf->close_on_exec_init;
-	fdt->open_fds = &newf->open_fds_init;
+	fdt->max_fdset = 8 * sizeof(embedded_fd_set);
+	fdt->close_on_exec = (fd_set *)&newf->close_on_exec_init;
+	fdt->open_fds = (fd_set *)&newf->open_fds_init;
 	fdt->fd = &newf->fd_array[0];
 	INIT_RCU_HEAD(&fdt->rcu);
 	fdt->free_files = NULL;
--- linux-2.6.15/fs/open.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-edum/fs/open.c	2006-01-04 00:32:05.000000000 +0100
@@ -928,7 +928,7 @@
 	fdt = files_fdtable(files);
  	fd = find_next_zero_bit(fdt->open_fds->fds_bits,
 				fdt->max_fdset,
-				fdt->next_fd);
+				files->next_fd);
 
 	/*
 	 * N.B. For clone tasks sharing a files structure, this test
@@ -953,7 +953,7 @@
 
 	FD_SET(fd, fdt->open_fds);
 	FD_CLR(fd, fdt->close_on_exec);
-	fdt->next_fd = fd + 1;
+	files->next_fd = fd + 1;
 #if 1
 	/* Sanity check */
 	if (fdt->fd[fd] != NULL) {
@@ -974,8 +974,8 @@
 {
 	struct fdtable *fdt = files_fdtable(files);
 	__FD_CLR(fd, fdt->open_fds);
-	if (fd < fdt->next_fd)
-		fdt->next_fd = fd;
+	if (fd < files->next_fd)
+		files->next_fd = fd;
 }
 
 void fastcall put_unused_fd(unsigned int fd)
--- linux-2.6.15/fs/fcntl.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-edum/fs/fcntl.c	2006-01-04 00:32:05.000000000 +0100
@@ -72,8 +72,8 @@
 	 * orig_start..fdt->next_fd
 	 */
 	start = orig_start;
-	if (start < fdt->next_fd)
-		start = fdt->next_fd;
+	if (start < files->next_fd)
+		start = files->next_fd;
 
 	newfd = start;
 	if (start < fdt->max_fdset) {
@@ -101,9 +101,8 @@
 	 * we reacquire the fdtable pointer and use it while holding
 	 * the lock, no one can free it during that time.
 	 */
-	fdt = files_fdtable(files);
-	if (start <= fdt->next_fd)
-		fdt->next_fd = newfd + 1;
+	if (start <= files->next_fd)
+		files->next_fd = newfd + 1;
 
 	error = newfd;
 	
--- linux-2.6.15/fs/file.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-edum/fs/file.c	2006-01-04 00:32:05.000000000 +0100
@@ -125,7 +125,8 @@
 		kmem_cache_free(files_cachep, fdt->free_files);
 		return;
 	}
-	if (fdt->max_fdset <= __FD_SETSIZE && fdt->max_fds <= NR_OPEN_DEFAULT) {
+	if (fdt->max_fdset <= 8 * sizeof(embedded_fd_set) &&
+		fdt->max_fds <= NR_OPEN_DEFAULT) {
 		/*
 		 * The fdtable was embedded
 		 */
@@ -155,8 +156,9 @@
 
 void free_fdtable(struct fdtable *fdt)
 {
-	if (fdt->free_files || fdt->max_fdset > __FD_SETSIZE ||
-					fdt->max_fds > NR_OPEN_DEFAULT)
+	if (fdt->free_files ||
+		fdt->max_fdset > 8 * sizeof(embedded_fd_set) ||
+		fdt->max_fds > NR_OPEN_DEFAULT)
 		call_rcu(&fdt->rcu, free_fdtable_rcu);
 }
 
@@ -199,7 +201,6 @@
 		       (nfdt->max_fds - fdt->max_fds) *
 					sizeof(struct file *));
 	}
-	nfdt->next_fd = fdt->next_fd;
 }
 
 /*
@@ -220,11 +221,9 @@
 
 void free_fdset(fd_set *array, int num)
 {
-	int size = num / 8;
-
-	if (num <= __FD_SETSIZE) /* Don't free an embedded fdset */
+	if (num <= 8 * sizeof(embedded_fd_set)) /* Don't free an embedded fdset */
 		return;
-	else if (size <= PAGE_SIZE)
+	else if (num <= 8 * PAGE_SIZE)
 		kfree(array);
 	else
 		vfree(array);
@@ -237,22 +236,17 @@
   	fd_set *new_openset = NULL, *new_execset = NULL;
 	struct file **new_fds;
 
-	fdt = kmalloc(sizeof(*fdt), GFP_KERNEL);
+	fdt = kzalloc(sizeof(*fdt), GFP_KERNEL);
 	if (!fdt)
   		goto out;
-	memset(fdt, 0, sizeof(*fdt));
 
-	nfds = __FD_SETSIZE;
+	nfds = 8 * L1_CACHE_BYTES;
   	/* Expand to the max in easy steps */
-  	do {
-		if (nfds < (PAGE_SIZE * 8))
-			nfds = PAGE_SIZE * 8;
-		else {
-			nfds = nfds * 2;
-			if (nfds > NR_OPEN)
-				nfds = NR_OPEN;
-		}
-	} while (nfds <= nr);
+  	while (nfds <= nr) {
+		nfds = nfds * 2;
+		if (nfds > NR_OPEN)
+			nfds = NR_OPEN;
+	}
 
   	new_openset = alloc_fdset(nfds);
   	new_execset = alloc_fdset(nfds);

--------------050301030003060602090100--
