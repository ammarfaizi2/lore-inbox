Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262893AbTDAWYP>; Tue, 1 Apr 2003 17:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262895AbTDAWYP>; Tue, 1 Apr 2003 17:24:15 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:15749 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262893AbTDAWYL>; Tue, 1 Apr 2003 17:24:11 -0500
Date: Tue, 1 Apr 2003 23:37:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, CaT <cat@zip.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 6/6 percentile size
In-Reply-To: <Pine.LNX.4.44.0304012328390.1730-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0304012335220.1730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From CaT <cat@zip.com.au>:
What this patch does is allow you to specify the max amount of memory
tmpfs can use as a percentage of available real ram. This (in my eyes)
is useful so that you do not have to remember to change the setting if
you want something other then 50% and some of your ram goes.

Hugh redid the arithmetic to not overflow at 4GB; the particular order
of lines helps RH2.96-110 not to get confused in the do_div.  2.5 can
use totalram_pages.  Update mount options in tmpfs Doc.

There's an argument that the percentage should be of ram+swap, that's
what Christoph originally intended.  But we set the default at 50% of
ram only, so I believe it's more consistent to follow that precedent.

--- tmpfs5/Documentation/filesystems/tmpfs.txt	Thu Oct 31 05:39:34 2002
+++ tmpfs6/Documentation/filesystems/tmpfs.txt	Tue Apr  1 21:35:43 2003
@@ -54,18 +54,21 @@
 4) And probably a lot more I do not know about :-)
 
 
-tmpfs has a couple of mount options:
+tmpfs has three mount options for sizing:
 
-size:	   The limit of allocated bytes for this tmpfs instance. The 
+size:      The limit of allocated bytes for this tmpfs instance. The 
            default is half of your physical RAM without swap. If you
-	   oversize your tmpfs instances the machine will deadlock
-	   since the OOM handler will not be able to free that memory.
-nr_blocks: The same as size, but in blocks of PAGECACHE_SIZE.
+           oversize your tmpfs instances the machine will deadlock
+           since the OOM handler will not be able to free that memory.
+nr_blocks: The same as size, but in blocks of PAGE_CACHE_SIZE.
 nr_inodes: The maximum number of inodes for this instance. The default
            is half of the number of your physical RAM pages.
 
 These parameters accept a suffix k, m or g for kilo, mega and giga and
-can be changed on remount.
+can be changed on remount.  The size parameter also accepts a suffix %
+to limit this tmpfs instance to that percentage of your physical RAM:
+the default, when neither size nor nr_blocks is specified, is size=50%
+
 
 To specify the initial root directory you can use the following mount
 options:
@@ -83,15 +86,7 @@
 RAM/SWAP in 10240 inodes and it is only accessible by root.
 
 
-TODOs:
-
-1) give the size option a percent semantic: If you give a mount option
-   size=50% the tmpfs instance should be able to grow to 50 percent of
-   RAM + swap. So the instance should adapt automatically if you add
-   or remove swap space.
-2) Show the number of tmpfs RAM pages. (As shared?)
-
 Author:
    Christoph Rohland <cr@sap.com>, 1.12.01
 Updated:
-   Hugh Dickins <hugh@veritas.com>, 17 Oct 2002
+   Hugh Dickins <hugh@veritas.com>, 01 April 2003
--- tmpfs5/mm/shmem.c	Tue Apr  1 21:35:32 2003
+++ tmpfs6/mm/shmem.c	Tue Apr  1 21:35:43 2003
@@ -35,6 +35,7 @@
 #include <linux/vfs.h>
 #include <linux/blkdev.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 /* This magic number is used in glibc for posix shared memory */
 #define TMPFS_MAGIC	0x01021994
@@ -1587,6 +1588,12 @@
 		if (!strcmp(this_char,"size")) {
 			unsigned long long size;
 			size = memparse(value,&rest);
+			if (*rest == '%') {
+				size <<= PAGE_SHIFT;
+				size *= totalram_pages;
+				do_div(size, 100);
+				rest++;
+			}
 			if (*rest)
 				goto bad_val;
 			*blocks = size >> PAGE_CACHE_SHIFT;
@@ -1652,7 +1659,6 @@
 	uid_t uid = current->fsuid;
 	gid_t gid = current->fsgid;
 	struct shmem_sb_info *sbinfo;
-	struct sysinfo si;
 	int err = -ENOMEM;
 
 	sbinfo = kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
@@ -1665,8 +1671,7 @@
 	 * Per default we only allow half of the physical ram per
 	 * tmpfs instance
 	 */
-	si_meminfo(&si);
-	blocks = inodes = si.totalram / 2;
+	blocks = inodes = totalram_pages / 2;
 
 #ifdef CONFIG_TMPFS
 	if (shmem_parse_options(data, &mode, &uid, &gid, &blocks, &inodes)) {

