Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316540AbSEUHpg>; Tue, 21 May 2002 03:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSEUHpf>; Tue, 21 May 2002 03:45:35 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:9896 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S316540AbSEUHpe>; Tue, 21 May 2002 03:45:34 -0400
Date: Tue, 21 May 2002 03:45:34 -0400
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.17 build hides errors
Message-ID: <20020521074532.GA27185@ravel.coda.cs.cmu.edu>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch allows the kernel compile to abort on errors again.
It also fixes some missing includes in filesystems that were broken by
the removal of locks.h.

Jan


diff -urN linux-2.5.17/Rules.make linux-trivial/Rules.make
--- linux-2.5.17/Rules.make	Tue May 21 01:46:03 2002
+++ linux-trivial/Rules.make	Tue May 21 03:35:35 2002
@@ -380,5 +380,5 @@
 if_changed = $(if $(strip $? \
 		          $(filter-out $($(1)),$(cmd_$@))\
 			  $(filter-out $(cmd_$@),$($(1)))),\
-	       @echo $($(1)); $($(1)); echo 'cmd_$@ := $($(1))' > .$@.cmd)
+	       @echo $($(1)) && $($(1)) && echo 'cmd_$@ := $($(1))' > .$@.cmd)
 
diff -urN linux-2.5.17/fs/bfs/dir.c linux-trivial/fs/bfs/dir.c
--- linux-2.5.17/fs/bfs/dir.c	Tue May 21 01:46:05 2002
+++ linux-trivial/fs/bfs/dir.c	Tue May 21 03:08:26 2002
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/bfs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/sched.h>
 
 #include "bfs_defs.h"
 
diff -urN linux-2.5.17/fs/hfs/inode.c linux-trivial/fs/hfs/inode.c
--- linux-2.5.17/fs/hfs/inode.c	Tue May 21 03:05:20 2002
+++ linux-trivial/fs/hfs/inode.c	Tue May 21 03:13:02 2002
@@ -21,6 +21,7 @@
 #include <linux/hfs_fs_i.h>
 #include <linux/hfs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/mm.h>
 
 /*================ Variable-like macros ================*/
 
diff -urN linux-2.5.17/fs/udf/ialloc.c linux-trivial/fs/udf/ialloc.c
--- linux-2.5.17/fs/udf/ialloc.c	Tue May 21 01:46:09 2002
+++ linux-trivial/fs/udf/ialloc.c	Tue May 21 02:42:27 2002
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/quotaops.h>
 #include <linux/udf_fs.h>
+#include <linux/sched.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
diff -urN linux-2.5.17/fs/ufs/balloc.c linux-trivial/fs/ufs/balloc.c
--- linux-2.5.17/fs/ufs/balloc.c	Tue May 21 01:46:09 2002
+++ linux-trivial/fs/ufs/balloc.c	Tue May 21 03:36:39 2002
@@ -12,6 +12,7 @@
 #include <linux/time.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
+#include <linux/sched.h>
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
 
diff -urN linux-2.5.17/fs/ufs/dir.c linux-trivial/fs/ufs/dir.c
--- linux-2.5.17/fs/ufs/dir.c	Tue May 21 01:46:09 2002
+++ linux-trivial/fs/ufs/dir.c	Tue May 21 03:37:48 2002
@@ -17,6 +17,7 @@
 #include <linux/fs.h>
 #include <linux/ufs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/sched.h>
 
 #include "swab.h"
 #include "util.h"
diff -urN linux-2.5.17/fs/ufs/ialloc.c linux-trivial/fs/ufs/ialloc.c
--- linux-2.5.17/fs/ufs/ialloc.c	Tue May 21 01:46:09 2002
+++ linux-trivial/fs/ufs/ialloc.c	Tue May 21 03:39:34 2002
@@ -26,6 +26,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
+#include <linux/sched.h>
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
 
diff -urN linux-2.5.17/fs/ufs/truncate.c linux-trivial/fs/ufs/truncate.c
--- linux-2.5.17/fs/ufs/truncate.c	Tue May 21 01:46:09 2002
+++ linux-trivial/fs/ufs/truncate.c	Tue May 21 03:40:19 2002
@@ -37,6 +37,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/sched.h>
 
 #include "swab.h"
 #include "util.h"
