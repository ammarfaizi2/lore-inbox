Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbWADLp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWADLp4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbWADLp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:45:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40168 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751747AbWADLpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:45:55 -0500
Date: Wed, 4 Jan 2006 03:45:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
Message-Id: <20060104034534.45d9c18a.akpm@osdl.org>
In-Reply-To: <43BB1178.7020409@cosmosbay.com>
References: <20051108185349.6e86cec3.akpm@osdl.org>
	<437226B1.4040901@cosmosbay.com>
	<20051109220742.067c5f3a.akpm@osdl.org>
	<4373698F.9010608@cosmosbay.com>
	<43BB1178.7020409@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> [PATCH] shrink the fdset and reorder fields to give better multi-threaded 
>  performance.

Boy, this is going to need some elaborate performance testing..

We can't have that `8 * sizeof(embedded_fd_set)' splattered all over the
tree.  This? 

 fs/file.c                 |    6 +++---
 include/linux/file.h      |    5 +++++
 include/linux/init_task.h |    2 +-
 kernel/fork.c             |    2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff -puN fs/file.c~shrinks-sizeoffiles_struct-and-better-layout-tidy fs/file.c
--- devel/fs/file.c~shrinks-sizeoffiles_struct-and-better-layout-tidy	2006-01-04 03:45:10.000000000 -0800
+++ devel-akpm/fs/file.c	2006-01-04 03:45:10.000000000 -0800
@@ -125,7 +125,7 @@ static void free_fdtable_rcu(struct rcu_
 		kmem_cache_free(files_cachep, fdt->free_files);
 		return;
 	}
-	if (fdt->max_fdset <= 8 * sizeof(embedded_fd_set) &&
+	if (fdt->max_fdset <= EMBEDDED_FD_SET_SIZE &&
 		fdt->max_fds <= NR_OPEN_DEFAULT) {
 		/*
 		 * The fdtable was embedded
@@ -157,7 +157,7 @@ static void free_fdtable_rcu(struct rcu_
 void free_fdtable(struct fdtable *fdt)
 {
 	if (fdt->free_files ||
-		fdt->max_fdset > 8 * sizeof(embedded_fd_set) ||
+		fdt->max_fdset > EMBEDDED_FD_SET_SIZE ||
 		fdt->max_fds > NR_OPEN_DEFAULT)
 		call_rcu(&fdt->rcu, free_fdtable_rcu);
 }
@@ -221,7 +221,7 @@ fd_set * alloc_fdset(int num)
 
 void free_fdset(fd_set *array, int num)
 {
-	if (num <= 8 * sizeof(embedded_fd_set)) /* Don't free an embedded fdset */
+	if (num <= EMBEDDED_FD_SET_SIZE) /* Don't free an embedded fdset */
 		return;
 	else if (num <= 8 * PAGE_SIZE)
 		kfree(array);
diff -puN include/linux/file.h~shrinks-sizeoffiles_struct-and-better-layout-tidy include/linux/file.h
--- devel/include/linux/file.h~shrinks-sizeoffiles_struct-and-better-layout-tidy	2006-01-04 03:45:10.000000000 -0800
+++ devel-akpm/include/linux/file.h	2006-01-04 03:45:10.000000000 -0800
@@ -25,6 +25,11 @@ typedef struct {
 	unsigned long fds_bits[1];
 } embedded_fd_set;
 
+/*
+ * More than this number of fds: we use a separately allocated fd_set
+ */
+#define EMBEDDED_FD_SET_SIZE	(8 * sizeof(struct embedded_fd_set))
+
 struct fdtable {
 	unsigned int max_fds;
 	int max_fdset;
diff -puN include/linux/init_task.h~shrinks-sizeoffiles_struct-and-better-layout-tidy include/linux/init_task.h
--- devel/include/linux/init_task.h~shrinks-sizeoffiles_struct-and-better-layout-tidy	2006-01-04 03:45:10.000000000 -0800
+++ devel-akpm/include/linux/init_task.h	2006-01-04 03:45:10.000000000 -0800
@@ -7,7 +7,7 @@
 #define INIT_FDTABLE \
 {							\
 	.max_fds	= NR_OPEN_DEFAULT, 		\
-	.max_fdset	= 8 * sizeof(embedded_fd_set),	\
+	.max_fdset	= EMBEDDED_FD_SET_SIZE,		\
 	.fd		= &init_files.fd_array[0], 	\
 	.close_on_exec	= (fd_set *)&init_files.close_on_exec_init, \
 	.open_fds	= (fd_set *)&init_files.open_fds_init, 	\
diff -puN kernel/fork.c~shrinks-sizeoffiles_struct-and-better-layout-tidy kernel/fork.c
--- devel/kernel/fork.c~shrinks-sizeoffiles_struct-and-better-layout-tidy	2006-01-04 03:45:10.000000000 -0800
+++ devel-akpm/kernel/fork.c	2006-01-04 03:45:10.000000000 -0800
@@ -584,7 +584,7 @@ static struct files_struct *alloc_files(
 	newf->next_fd = 0;
 	fdt = &newf->fdtab;
 	fdt->max_fds = NR_OPEN_DEFAULT;
-	fdt->max_fdset = 8 * sizeof(embedded_fd_set);
+	fdt->max_fdset = EMBEDDED_FD_SET_SIZE;
 	fdt->close_on_exec = (fd_set *)&newf->close_on_exec_init;
 	fdt->open_fds = (fd_set *)&newf->open_fds_init;
 	fdt->fd = &newf->fd_array[0];
_

