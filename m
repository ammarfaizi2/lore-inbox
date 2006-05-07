Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWEGXUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWEGXUc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 19:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWEGXUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 19:20:32 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:36490 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750781AbWEGXUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 19:20:32 -0400
Message-ID: <445E80DD.9090507@hozac.com>
Date: Mon, 08 May 2006 01:21:01 +0200
From: Daniel Hokka Zakrisson <daniel@hozac.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>, greg@kroah.com,
       matthew@wil.cx, torvalds@osdl.org
Subject: [PATCH] fs: fcntl_setlease defies lease_init assumptions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fcntl_setlease uses a struct file_lock on the stack to find the
file_lock it's actually looking for. The problem with this approach is
that lease_init will attempt to free the file_lock if the arg argument
is invalid, causing kmem_cache_free to be called with the address of the
on-stack file_lock.
After running the following test-case, it doesn't take long for an i686
machine running 2.6.16.13 to stop responding completely. 
2.6.17-rc3-git12 shows similar results, although it takes a bit more 
activity before crashing.

Björn Steinbrink also identified a slab leak in the same piece of code, 
caused by the fasync_helper call which will allocate a new slab every 
time because it uses the wrong structure (the one on the stack) when the 
a lease on that file already exists.

#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

void die(const char *msg)
{
	perror(msg);
	exit(1);
}
int main(int argc, char *argv[])
{
	int fd;
	if (argc == 1)
	{
		fprintf(stderr, "Usage: %s file\n", argv[0]);
		exit(1);
	}
	fd = open(argv[1], O_RDONLY);
	if (fd == -1)
		die("open()");
	if (fcntl(fd, F_SETLEASE, F_RDLCK) == -1)
		die("setlease(RDLCK)");
	if (fcntl(fd, F_SETLEASE, F_RDLCK) == -1)
		die("setlease(RDLCK2)");
	if (fcntl(fd, F_SETLEASE, 5) == -1)
		die("setlease(invalid)");
	close(fd);
	return 0;
}

Signed-off-by: Daniel Hokka Zakrisson <daniel@hozac.com>

---
--- a/fs/locks.c	2006-05-07 00:29:26.000000000 +0200
+++ b/fs/locks.c	2006-05-07 23:29:12.000000000 +0200
@@ -1363,6 +1363,7 @@ static int __setlease(struct file *filp,
  		goto out;

  	if (my_before != NULL) {
+		*flp = *my_before;
  		error = lease->fl_lmops->fl_change(my_before, arg);
  		goto out;
  	}
@@ -1433,7 +1434,7 @@ EXPORT_SYMBOL(setlease);
   */
  int fcntl_setlease(unsigned int fd, struct file *filp, long arg)
  {
-	struct file_lock fl, *flp = &fl;
+	struct file_lock *fl, *flp;
  	struct dentry *dentry = filp->f_dentry;
  	struct inode *inode = dentry->d_inode;
  	int error;
@@ -1446,14 +1447,15 @@ int fcntl_setlease(unsigned int fd, stru
  	if (error)
  		return error;

-	locks_init_lock(&fl);
-	error = lease_init(filp, arg, &fl);
+	error = lease_alloc(filp, arg, &fl);
  	if (error)
  		return error;
+	flp = fl;

  	lock_kernel();

  	error = __setlease(filp, arg, &flp);
+	locks_free_lock(fl);
  	if (error || arg == F_UNLCK)
  		goto out_unlock;


