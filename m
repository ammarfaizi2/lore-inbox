Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131839AbQL2SsN>; Fri, 29 Dec 2000 13:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131859AbQL2Srx>; Fri, 29 Dec 2000 13:47:53 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:7929
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S131839AbQL2Srw>; Fri, 29 Dec 2000 13:47:52 -0500
Date: Fri, 29 Dec 2000 11:17:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
Message-ID: <20001229111719.B5661@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.10.10012281220470.17769-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.10.10012281220470.17769-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 28, 2000 at 12:25:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 12:25:23PM -0800, Linus Torvalds wrote:

>  - pre5:
>    - NIIBE Yutaka: SuperH update
>    - Geert Uytterhoeven: m68k update
>    - David Miller: TCP RTO calc fix, UDP multicast fix etc
>    - Duncan Laurie: ServerWorks PIRQ routing definition.
>    - mm PageDirty cleanups, added sanity checks, and don't lose the bit. 

I just noticed this (playing with some other stuff), but ext2 as a module
is currently broken:
$ make INSTALL_MOD_PATH=/tmp/foo modules_install
...
if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b /tmp/foo -r 2.4.0-test12; fi
depmod: *** Unresolved symbols in /tmp/foo/lib/modules/2.4.0-test12/kernel/fs/ext2/ext2.o
depmod:         buffer_insert_inode_queue
depmod:         fsync_inode_buffers

I tried the following locally and it fixes it.
---<cut>---
--- fs/Makefile.orig	Fri Dec 29 10:35:50 2000
+++ fs/Makefile	Fri Dec 29 10:36:06 2000
@@ -7,7 +7,7 @@
 
 O_TARGET := fs.o
 
-export-objs :=	filesystems.o
+export-objs :=	filesystems.o buffer.o
 mod-subdirs :=	nls
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
--- fs/buffer.c.orig	Fri Dec 29 10:33:21 2000
+++ fs/buffer.c	Fri Dec 29 10:35:46 2000
@@ -29,6 +29,7 @@
 /* async buffer flushing, 1999 Andrea Arcangeli <andrea@suse.de> */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/malloc.h>
@@ -579,6 +580,8 @@
 	spin_unlock(&lru_list_lock);
 }
 
+EXPORT_SYMBOL(buffer_insert_inode_queue);
+
 /* The caller must have the lru_list lock before calling the 
    remove_inode_queue functions.  */
 static void __remove_inode_queue(struct buffer_head *bh)
@@ -900,6 +903,7 @@
 		return err2;
 }
 
+EXPORT_SYMBOL(fsync_inode_buffers);
 
 /*
  * osync is designed to support O_SYNC io.  It waits synchronously for
---<end>---

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
