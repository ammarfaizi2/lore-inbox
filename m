Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268026AbUIBJOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268026AbUIBJOk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUIBJOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:14:39 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:19336 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S268026AbUIBJOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:14:16 -0400
Date: Thu, 2 Sep 2004 11:14:05 +0200 (DFT)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@isabelle.frec.bull.fr
To: Andrew Morton <akpm@osdl.org>
cc: Simon Derr <Simon.Derr@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Possible race in sysfs_read_file() and sysfs_write_file()
In-Reply-To: <20040901163436.263802bc.akpm@osdl.org>
Message-ID: <Pine.A41.4.53.0409020917350.122970@isabelle.frec.bull.fr>
References: <Pine.A41.4.53.0409010924250.122970@isabelle.frec.bull.fr>
 <20040901163436.263802bc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004, Andrew Morton wrote:

> Simon Derr <Simon.Derr@bull.net> wrote:
> >
> > I think there is a possibility for two threads from a single process to
> > race in sysfs_read_file() if they call read() on the same file at the same
> > time.
>
> I think there is, too.
>
> I also wonder what happens if the first read of a sysfs file is not at
> offset zero (eg: pread()):
>
> static ssize_t
> sysfs_read_file(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> {
> 	struct sysfs_buffer * buffer = file->private_data;
> 	ssize_t retval = 0;
>
> 	if (!*ppos) {
> 		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
>
>
> we seem to not allocate the buffer at all?

Indeed.

And one would expect flush_read_buffer() to handle this by returning zero
since the buffer has not been allocated, and its length is zero. But it
seems there is also something wrong in flush_read_buffer().

fs/sysfs/file.c, flush_read_buffer():

	if (count > (buffer->count - *ppos))
        	        count = buffer->count - *ppos;

	error = copy_to_user(buf,buffer->page + *ppos,count);

Several issues:

* case 1: the buffer has been previously allocated by a call to read(),
but now we call pread() (or have called lseek()) with a "large" offset:

Let's say buffer->count is 20 and *ppos is 1000:

buffer->count - *ppos is negative, but buffer->count is unsigned, so there
is an overflow and the comparison (count > (buffer->count - *ppos)) is
false, even though `count' is bigger than `buffer->count'

The user here can call copy_to_user() with about any length he wants.

* case 2: the buffer has not yet been allocated, and we call pread() with
a non-null offset. Due to the overflow, we can again call copy_to_user
with about any length we want (`count'), from about any location we want
(`*ppos')




Here's an updated patch:

1/fixes the race between threads by adding a semaphore in sysfs_buffer
2/allocates the buffer upon call to pread(). We still call again
fill_read_buffer() if the file is "rewinded" to offset zero.
3/fixes the comparison in flush_read_buffer().

Still against 2.6.9-rc1-mm2.

Signed-off-by: Simon Derr <simon.derr@null.net>

Index: 269mm2kdb/fs/sysfs/file.c
===================================================================
--- 269mm2kdb.orig/fs/sysfs/file.c	2004-08-31 11:29:16.000000000 +0200
+++ 269mm2kdb/fs/sysfs/file.c	2004-09-02 10:58:52.344480007 +0200
@@ -6,6 +6,7 @@
 #include <linux/dnotify.h>
 #include <linux/kobject.h>
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>

 #include "sysfs.h"

@@ -53,6 +54,7 @@
 	loff_t			pos;
 	char			* page;
 	struct sysfs_ops	* ops;
+	struct semaphore	sem;
 };


@@ -106,6 +108,9 @@
 {
 	int error;

+	if (*ppos > buffer->count)
+		return 0;
+
 	if (count > (buffer->count - *ppos))
 		count = buffer->count - *ppos;

@@ -140,13 +145,17 @@
 	struct sysfs_buffer * buffer = file->private_data;
 	ssize_t retval = 0;

-	if (!*ppos) {
+	down(&buffer->sem);
+	if ((!*ppos) || (!buffer->page)) {
 		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
-			return retval;
+			goto out;
 	}
 	pr_debug("%s: count = %d, ppos = %lld, buf = %s\n",
 		 __FUNCTION__,count,*ppos,buffer->page);
-	return flush_read_buffer(buffer,buf,count,ppos);
+	retval = flush_read_buffer(buffer,buf,count,ppos);
+out:
+	up(&buffer->sem);
+	return retval;
 }


@@ -220,11 +229,13 @@
 {
 	struct sysfs_buffer * buffer = file->private_data;

+	down(&buffer->sem);
 	count = fill_write_buffer(buffer,buf,count);
 	if (count > 0)
 		count = flush_write_buffer(file->f_dentry,buffer,count);
 	if (count > 0)
 		*ppos += count;
+	up(&buffer->sem);
 	return count;
 }

@@ -287,6 +298,7 @@
 	buffer = kmalloc(sizeof(struct sysfs_buffer),GFP_KERNEL);
 	if (buffer) {
 		memset(buffer,0,sizeof(struct sysfs_buffer));
+		init_MUTEX(&buffer->sem);
 		buffer->ops = ops;
 		file->private_data = buffer;
 	} else
