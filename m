Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWCVGXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWCVGXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWCVGXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:23:39 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:15708 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1750814AbWCVGXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:23:38 -0500
Message-ID: <4420ED66.5060703@cosmosbay.com>
Date: Wed, 22 Mar 2006 07:23:34 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC, PATCH] avoid some atomics in open()/close() for monothreaded
 processes
References: <20060315054416.GF3205@localhost.localdomain>	<1142403500.26706.2.camel@sli10-desk.sh.intel.com> <20060314233138.009414b4.akpm@osdl.org> <4417E047.70907@cosmosbay.com> <441EFE05.8040506@cosmosbay.com> <4420DB55.60803@cosmosbay.com>
In-Reply-To: <4420DB55.60803@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------010403060600040001060000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010403060600040001060000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Goal : Avoid some locking/unlocking 'struct files_struct'->file_lock for mono 
threaded processes.

We define files_multithreaded() function .

static inline int files_multithreaded(const struct files_struct *files)
{
        return sizeof(files->file_lock) > 0 && atomic_read(&files->count) > 1;
}

On plain UP kernel (not preemptable nor spinlock debug), this function is a 
const 0, so that gcc can wipe out some code.

On preemptible or SMP, or spinlock debug kernels, the result is true only if 
the ref count is greater than 1 (multi threaded process or /proc/{pid}/fd is 
under investigation by another task)

This patch increases kernel size but pros are worth the cons, as said Linus 
himself, we should increase performance of mono-threaded tasks....

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------010403060600040001060000
Content-Type: text/plain;
 name="files_multithreaded.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="files_multithreaded.patch"

--- a/include/linux/file.h	2006-03-22 06:23:02.000000000 +0100
+++ b/include/linux/file.h	2006-03-22 07:11:08.000000000 +0100
@@ -42,6 +42,11 @@
 	spinlock_t file_lock;     /* Protects concurrent writers.  Nests inside tsk->alloc_lock */
 };
 
+static inline int files_multithreaded(const struct files_struct *files)
+{
+	return sizeof(files->file_lock) > 0 && atomic_read(&files->count) > 1;
+}
+
 #define files_fdtable(files) (rcu_dereference((files)->fdt))
 
 extern void FASTCALL(__fput(struct file *));
--- a/fs/open.c.orig	2006-03-22 06:24:34.000000000 +0100
+++ b/fs/open.c	2006-03-22 06:30:54.000000000 +0100
@@ -1050,11 +1050,17 @@
 {
 	struct files_struct *files = current->files;
 	struct fdtable *fdt;
-	spin_lock(&files->file_lock);
+	int fl_locked = 0;
+
+	if (files_multithreaded(files)) {
+		spin_lock(&files->file_lock);
+		fl_locked = 1;
+	}
 	fdt = files_fdtable(files);
 	BUG_ON(fdt->fd[fd] != NULL);
 	rcu_assign_pointer(fdt->fd[fd], file);
-	spin_unlock(&files->file_lock);
+	if (fl_locked)
+		spin_unlock(&files->file_lock);
 }
 
 EXPORT_SYMBOL(fd_install);
@@ -1147,8 +1153,12 @@
 	struct file * filp;
 	struct files_struct *files = current->files;
 	struct fdtable *fdt;
+	int fl_locked = 0;
 
-	spin_lock(&files->file_lock);
+	if (files_multithreaded(files)) {
+		spin_lock(&files->file_lock);
+		fl_locked = 1;
+	}
 	fdt = files_fdtable(files);
 	if (fd >= fdt->max_fds)
 		goto out_unlock;
@@ -1158,11 +1168,13 @@
 	rcu_assign_pointer(fdt->fd[fd], NULL);
 	FD_CLR(fd, fdt->close_on_exec);
 	__put_unused_fd(files, fd);
-	spin_unlock(&files->file_lock);
+	if (fl_locked)
+		spin_unlock(&files->file_lock);
 	return filp_close(filp, files);
 
 out_unlock:
-	spin_unlock(&files->file_lock);
+	if (fl_locked)
+		spin_unlock(&files->file_lock);
 	return -EBADF;
 }
 

--------------010403060600040001060000--
