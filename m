Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314965AbSD2KCD>; Mon, 29 Apr 2002 06:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314975AbSD2KCC>; Mon, 29 Apr 2002 06:02:02 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:26073 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S314965AbSD2KCB>; Mon, 29 Apr 2002 06:02:01 -0400
Date: Mon, 29 Apr 2002 12:01:46 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: viro@math.psu.edu, neilb@cse.unsw.edu.au
Subject: [PATCH 2.5.11] nfsd module breakage
Message-ID: <20020429100146.GE2740@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	viro@math.psu.edu, neilb@cse.unsw.edu.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFSD uses path_lookup, which changed from a static inline into a
kernel internal function.

The new path_lookup is not exported to modules, making at least
NFSD break when compiled as a modules.

The attached patch exports the new function to modules.

I'll leave up to Al to decide if this must be a _GPL only export...

Stelian.

===== fs/Makefile 1.21 vs edited =====
--- 1.21/fs/Makefile	Wed Apr 17 20:24:55 2002
+++ edited/fs/Makefile	Mon Apr 29 11:34:40 2002
@@ -7,7 +7,7 @@
 
 O_TARGET := fs.o
 
-export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o
+export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o namei.o
 mod-subdirs :=	nls
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
===== fs/namei.c 1.41 vs edited =====
--- 1.41/fs/namei.c	Wed Apr 24 13:29:11 2002
+++ edited/fs/namei.c	Mon Apr 29 11:37:52 2002
@@ -22,6 +22,7 @@
 #include <linux/dnotify.h>
 #include <linux/smp_lock.h>
 #include <linux/personality.h>
+#include <linux/module.h>
 
 #include <asm/namei.h>
 #include <asm/uaccess.h>
@@ -842,6 +843,7 @@
 	nd->flags |= LOOKUP_LOCKED;
 	return (path_walk(name, nd));
 }
+EXPORT_SYMBOL(path_lookup);
 
 /*
  * Restricted form of lookup. Doesn't follow links, single-component only,
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
