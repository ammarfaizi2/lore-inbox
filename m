Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVE0BKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVE0BKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 21:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVE0BIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 21:08:15 -0400
Received: from [151.97.230.9] ([151.97.230.9]:51985 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261439AbVE0BFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 21:05:22 -0400
Subject: [patch 4/4] uml: make it link in tt mode against NPTL glibc
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 27 May 2005 02:40:24 +0200
Message-Id: <20050527004024.606961AEE9A@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To make sure switcheroo() can execute when we remap all the executable image,
we used a trick to make it use a local copy of errno... this trick does not
work with NPTL glibc, only with LinuxThreads, so use another (simpler) one to
make it work anyway.

Might need compile testing on different host archs, since it changes
__syscall_return from <asm/unistd.h>.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/tt/unmap.c |   25 +++++++++++++------------
 linux-2.6.git-paolo/arch/um/kernel/uml.lds.S  |   12 +-----------
 2 files changed, 14 insertions(+), 23 deletions(-)

diff -puN arch/um/kernel/tt/unmap.c~uml-link-tt-mode-against-nptl arch/um/kernel/tt/unmap.c
--- linux-2.6.git/arch/um/kernel/tt/unmap.c~uml-link-tt-mode-against-nptl	2005-05-25 01:22:23.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/tt/unmap.c	2005-05-25 01:22:23.000000000 +0200
@@ -1,16 +1,28 @@
 /* 
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2005 Paolo 'Blaisorblade' Giarrusso (blaisorblade@yahoo.it)
  * Licensed under the GPL
  */
 
 #include <sys/mman.h>
+#include <linux/unistd.h>
+
+/* We can't rely on errno here! */
+#undef __syscall_return
+#define __syscall_return(type, res) \
+do { \
+	return (type) (res); \
+} while (0)
+
+static inline _syscall6(void *, mmap2, void *, start, size_t, length, int, prot, int, flags, int, fd, off_t, pgoffset)
+inline _syscall2(int, munmap, void *, start, size_t, length)
 
 int switcheroo(int fd, int prot, void *from, void *to, int size)
 {
 	if(munmap(to, size) < 0){
 		return(-1);
 	}
-	if(mmap(to, size, prot,	MAP_SHARED | MAP_FIXED, fd, 0) != to){
+	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
 		return(-1);
 	}
 	if(munmap(from, size) < 0){
@@ -18,14 +30,3 @@ int switcheroo(int fd, int prot, void *f
 	}
 	return(0);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/uml.lds.S~uml-link-tt-mode-against-nptl arch/um/kernel/uml.lds.S
--- linux-2.6.git/arch/um/kernel/uml.lds.S~uml-link-tt-mode-against-nptl	2005-05-25 01:22:23.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/uml.lds.S	2005-05-25 01:22:23.000000000 +0200
@@ -15,19 +15,9 @@ SECTIONS
    * is remapped.*/
   __binary_start = .;
 #ifdef MODE_TT
-  .thread_private : {
-    __start_thread_private = .;
-    errno = .;
-    . += 4;
-    arch/um/kernel/tt/unmap_fin.o (.data)
-    __end_thread_private = .;
-  }
-  . = ALIGN(4096);
+  .remap_data: { arch/um/kernel/tt/unmap_fin.o (.data) }
   .remap : { arch/um/kernel/tt/unmap_fin.o (.text) }
 
-  /* We want it only if we are in MODE_TT. In both cases, however, when MODE_TT
-   * is off the resulting binary segfaults.*/
-
   . = ALIGN(4096);		/* Init code and data */
 #endif
 
_
