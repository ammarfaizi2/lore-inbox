Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbVIOVI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbVIOVI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbVIOVI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:08:27 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:48501 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1030499AbVIOVI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:08:27 -0400
Message-ID: <4329E2C6.4030106@cosmosbay.com>
Date: Thu, 15 Sep 2005 23:08:22 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Sonny Rao <sonny@burdell.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org> <20050913063359.GA29715@kevlar.burdell.org> <43267A00.1010405@cosmosbay.com> <20050915201356.GA20966@kvack.org> <Pine.LNX.4.58.0509151328260.26803@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509151328260.26803@g5.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020308000703010501000309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020308000703010501000309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Linus Torvalds a écrit :
> 
> On Thu, 15 Sep 2005, Benjamin LaHaise wrote:
> 
>>Alternatively, the kernel could track available file descriptors using a 
>>tree to efficiently insert freed slots into an ordered list of free 
>>regions (something similar to the avl tree used in vmas).  Is it worth 
>>doing?
> 
> 
> For file descriptors, even a few hundred is considered a _lot_ in almost 
> all settings. Yes, you can certainly have more, but it's unusual.
> 
> And we keep track of the fd reservations with a bitmap _and_ a "lowest
> possible" count. So we can check 32 fd's in one go (64 on modern setups),
> starting from the last one we allocated.
> 
> In other words, no. It's not worth doing anything more than we already do. 
> 
> I bet all the expense in this area tends under heavy load to be the
> cacheline bouncing of the updates. Keeping the lock close to the bitmap is 
> probably advantageous, since the bitmap tends to be looked at only when we 
> need to change them (and we hold the lock).

Absolutely :)

Here is the patch I use to :

- place modified bits (file_lock & next_fd) in a separate cache line, reducing 
cacheline bouncing for multi threaded apps.
- Reduce the size of struct (files_struct), using small embedded fd_sets 
matching fd_array[NR_OPEN_DEFAULT] (ie one long per 'fd_set' instead of 128 bytes)
- 10 % gain on a benchmark ran on a dual HT Xeon 2GHz, one thread per logical CPU.

Eric

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------020308000703010501000309
Content-Type: text/plain;
 name="patch_reorder_1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_reorder_1"

--- linux-2.6.14-rc1/include/linux/file.h	2005-09-13 05:12:09.000000000 +0200
+++ linux-2.6.14-rc1-ed/include/linux/file.h	2005-09-16 00:54:41.000000000 +0200
@@ -16,11 +16,17 @@
  * as this is the granularity returned by copy_fdset().
  */
 #define NR_OPEN_DEFAULT BITS_PER_LONG
+/*
+ * The embedded_fd_set is a small subset of a fd_set.
+ * One long is enough for most tasks.
+ */
+typedef struct {
+	unsigned long fds_bits[NR_OPEN_DEFAULT/BITS_PER_LONG];
+} embedded_fd_set;
 
 struct fdtable {
 	unsigned int max_fds;
-	int max_fdset;
-	int next_fd;
+	unsigned int max_fdset;
 	struct file ** fd;      /* current fd array */
 	fd_set *close_on_exec;
 	fd_set *open_fds;
@@ -33,13 +39,21 @@
  * Open file table structure
  */
 struct files_struct {
-        atomic_t count;
-        spinlock_t file_lock;     /* Protects all the below members.  Nests inside tsk->alloc_lock */
+/*
+ * Mostly read part
+ */
+	atomic_t count;
 	struct fdtable *fdt;
 	struct fdtable fdtab;
-        fd_set close_on_exec_init;
-        fd_set open_fds_init;
-        struct file * fd_array[NR_OPEN_DEFAULT];
+
+/*
+ * Modified part (open()/close()) in a separate cache line
+ */
+	spinlock_t file_lock ____cacheline_aligned_in_smp;     /* Writers take this lock.  Nests inside tsk->alloc_lock */
+	int next_fd;
+	embedded_fd_set close_on_exec_init;
+	embedded_fd_set open_fds_init;
+	struct file * fd_array[NR_OPEN_DEFAULT];
 };
 
 #define files_fdtable(files) (rcu_dereference((files)->fdt))
@@ -63,13 +77,11 @@
 extern void filp_ctor(void * objp, struct kmem_cache_s *cachep, unsigned long cflags);
 extern void filp_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags);
 
-extern struct file ** alloc_fd_array(int);
-extern void free_fd_array(struct file **, int);
+extern void free_fd_array(struct file **, unsigned int);
 
-extern fd_set *alloc_fdset(int);
-extern void free_fdset(fd_set *, int);
+extern void free_fdset(fd_set *, unsigned int);
 
-extern int expand_files(struct files_struct *, int nr);
+extern int expand_files(struct files_struct *, unsigned int nr);
 extern void free_fdtable(struct fdtable *fdt);
 extern void __init files_defer_init(void);
 
--- linux-2.6.14-rc1/include/linux/init_task.h	2005-09-13 05:12:09.000000000 +0200
+++ linux-2.6.14-rc1-ed/include/linux/init_task.h	2005-09-16 00:09:19.000000000 +0200
@@ -8,10 +8,9 @@
 {							\
 	.max_fds	= NR_OPEN_DEFAULT, 		\
 	.max_fdset	= __FD_SETSIZE, 		\
-	.next_fd	= 0, 				\
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
--- linux-2.6.14-rc1/fs/file.c	2005-09-13 05:12:09.000000000 +0200
+++ linux-2.6.14-rc1-ed/fs/file.c	2005-09-16 00:53:15.000000000 +0200
@@ -38,10 +38,10 @@
  * Allocate an fd array, using kmalloc or vmalloc.
  * Note: the array isn't cleared at allocation time.
  */
-struct file ** alloc_fd_array(int num)
+static struct file ** alloc_fd_array(unsigned int num)
 {
 	struct file **new_fds;
-	int size = num * sizeof(struct file *);
+	unsigned int size = num * sizeof(struct file *);
 
 	if (size <= PAGE_SIZE)
 		new_fds = (struct file **) kmalloc(size, GFP_KERNEL);
@@ -50,12 +50,12 @@
 	return new_fds;
 }
 
-void free_fd_array(struct file **array, int num)
+void free_fd_array(struct file **array, unsigned int num)
 {
-	int size = num * sizeof(struct file *);
+	unsigned int size = num * sizeof(struct file *);
 
-	if (!array) {
-		printk (KERN_ERR "free_fd_array: array = 0 (num = %d)\n", num);
+	if (unlikely(!array)) {
+		printk (KERN_ERR "free_fd_array: array = 0 (num = %u)\n", num);
 		return;
 	}
 
@@ -69,7 +69,7 @@
 
 static void __free_fdtable(struct fdtable *fdt)
 {
-	int fdset_size, fdarray_size;
+	unsigned int fdset_size, fdarray_size;
 
 	fdset_size = fdt->max_fdset / 8;
 	fdarray_size = fdt->max_fds * sizeof(struct file *);
@@ -129,7 +129,8 @@
 		kmem_cache_free(files_cachep, fdt->free_files);
 		return;
 	}
-	if (fdt->max_fdset <= __FD_SETSIZE && fdt->max_fds <= NR_OPEN_DEFAULT) {
+	if (fdt->max_fdset <= 8 * sizeof(embedded_fd_set) &&
+	    fdt->max_fds <= NR_OPEN_DEFAULT) {
 		/*
 		 * The fdtable was embedded
 		 */
@@ -159,8 +160,9 @@
 
 void free_fdtable(struct fdtable *fdt)
 {
-	if (fdt->free_files || fdt->max_fdset > __FD_SETSIZE ||
-					fdt->max_fds > NR_OPEN_DEFAULT)
+	if (fdt->free_files ||
+		fdt->max_fdset > 8 * sizeof(embedded_fd_set) ||
+		fdt->max_fds > NR_OPEN_DEFAULT)
 		call_rcu(&fdt->rcu, free_fdtable_rcu);
 }
 
@@ -170,7 +172,7 @@
  */
 static void copy_fdtable(struct fdtable *nfdt, struct fdtable *fdt)
 {
-	int i;
+	unsigned int i;
 	int count;
 
 	BUG_ON(nfdt->max_fdset < fdt->max_fdset);
@@ -203,17 +205,17 @@
 		       (nfdt->max_fds - fdt->max_fds) *
 					sizeof(struct file *));
 	}
-	nfdt->next_fd = fdt->next_fd;
+//	nfdt->next_fd = fdt->next_fd;
 }
 
 /*
  * Allocate an fdset array, using kmalloc or vmalloc.
  * Note: the array isn't cleared at allocation time.
  */
-fd_set * alloc_fdset(int num)
+static fd_set * alloc_fdset(unsigned int num)
 {
 	fd_set *new_fdset;
-	int size = num / 8;
+	unsigned int size = num / 8;
 
 	if (size <= PAGE_SIZE)
 		new_fdset = (fd_set *) kmalloc(size, GFP_KERNEL);
@@ -222,11 +224,11 @@
 	return new_fdset;
 }
 
-void free_fdset(fd_set *array, int num)
+void free_fdset(fd_set *array, unsigned int num)
 {
-	int size = num / 8;
+	unsigned int size = num / 8;
 
-	if (num <= __FD_SETSIZE) /* Don't free an embedded fdset */
+	if (size <= sizeof(embedded_fd_set)) /* Don't free an embedded fdset */
 		return;
 	else if (size <= PAGE_SIZE)
 		kfree(array);
@@ -234,10 +236,10 @@
 		vfree(array);
 }
 
-static struct fdtable *alloc_fdtable(int nr)
+static struct fdtable *alloc_fdtable(unsigned int nr)
 {
 	struct fdtable *fdt = NULL;
-	int nfds = 0;
+	unsigned int nfds = 0;
   	fd_set *new_openset = NULL, *new_execset = NULL;
 	struct file **new_fds;
 
@@ -246,16 +248,12 @@
   		goto out;
 	memset(fdt, 0, sizeof(*fdt));
 
-	nfds = __FD_SETSIZE;
+	nfds = 8 * L1_CACHE_BYTES;
   	/* Expand to the max in easy steps */
   	do {
-		if (nfds < (PAGE_SIZE * 8))
-			nfds = PAGE_SIZE * 8;
-		else {
-			nfds = nfds * 2;
-			if (nfds > NR_OPEN)
-				nfds = NR_OPEN;
-		}
+		nfds = nfds * 2;
+		if (nfds > NR_OPEN)
+			nfds = NR_OPEN;
 	} while (nfds <= nr);
 
   	new_openset = alloc_fdset(nfds);
@@ -306,7 +304,7 @@
  * both fd array and fdset. It is expected to be called with the
  * files_lock held.
  */
-static int expand_fdtable(struct files_struct *files, int nr)
+static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	__releases(files->file_lock)
 	__acquires(files->file_lock)
 {
@@ -348,7 +346,7 @@
  * Return <0 on error; 0 nothing done; 1 files expanded, we may have blocked.
  * Should be called with the files->file_lock spinlock held for write.
  */
-int expand_files(struct files_struct *files, int nr)
+int expand_files(struct files_struct *files, unsigned int nr)
 {
 	int err, expand = 0;
 	struct fdtable *fdt;
--- linux-2.6.14-rc1/fs/fcntl.c	2005-09-13 05:12:09.000000000 +0200
+++ linux-2.6.14-rc1-ed/fs/fcntl.c	2005-09-16 00:09:19.000000000 +0200
@@ -69,11 +69,11 @@
 	fdt = files_fdtable(files);
 	/*
 	 * Someone might have closed fd's in the range
-	 * orig_start..fdt->next_fd
+	 * orig_start..files->next_fd
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
 	
--- linux-2.6.14-rc1/fs/open.c	2005-09-13 05:12:09.000000000 +0200
+++ linux-2.6.14-rc1-ed/fs/open.c	2005-09-16 00:11:23.000000000 +0200
@@ -852,7 +852,7 @@
 	fdt = files_fdtable(files);
  	fd = find_next_zero_bit(fdt->open_fds->fds_bits,
 				fdt->max_fdset,
-				fdt->next_fd);
+				files->next_fd);
 
 	/*
 	 * N.B. For clone tasks sharing a files structure, this test
@@ -877,7 +877,7 @@
 
 	FD_SET(fd, fdt->open_fds);
 	FD_CLR(fd, fdt->close_on_exec);
-	fdt->next_fd = fd + 1;
+	files->next_fd = fd + 1;
 #if 1
 	/* Sanity check */
 	if (fdt->fd[fd] != NULL) {
@@ -898,8 +898,8 @@
 {
 	struct fdtable *fdt = files_fdtable(files);
 	__FD_CLR(fd, fdt->open_fds);
-	if (fd < fdt->next_fd)
-		fdt->next_fd = fd;
+	if (fd < files->next_fd)
+		files->next_fd = fd;
 }
 
 void fastcall put_unused_fd(unsigned int fd)
--- linux-2.6.14-rc1/kernel/fork.c	2005-09-13 05:12:09.000000000 +0200
+++ linux-2.6.14-rc1-ed/kernel/fork.c	2005-09-16 00:21:18.000000000 +0200
@@ -592,12 +592,12 @@
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

--------------020308000703010501000309--
