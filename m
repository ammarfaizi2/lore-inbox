Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317888AbSG2WK1>; Mon, 29 Jul 2002 18:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318100AbSG2WKZ>; Mon, 29 Jul 2002 18:10:25 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:17222 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S317888AbSG2WJy>; Mon, 29 Jul 2002 18:09:54 -0400
Date: Mon, 29 Jul 2002 23:13:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] vmacct7/9 update overcommit doc and comment
In-Reply-To: <Pine.LNX.4.21.0207292257001.1184-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0207292312260.1184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update Doc and remove FIXME comment from fork.c now accounting right.

--- vmacct6/Documentation/vm/overcommit-accounting	Mon Jul 29 11:48:01 2002
+++ vmacct7/Documentation/vm/overcommit-accounting	Mon Jul 29 19:23:46 2002
@@ -37,13 +37,13 @@
 The overcommit is based on the following rules
 
 For a file backed map
-	SHARED or READ only	-	0 cost (the file is the map not swap)
+	SHARED or READ-only	-	0 cost (the file is the map not swap)
+	PRIVATE WRITABLE	-	size of mapping per instance
 
-	WRITABLE SHARED		-	size of mapping per instance
-
-For a direct map
-	SHARED or READ only	-	size of mapping
-	PRIVATE WRITEABLE	-	size of mapping per instance
+For an anonymous or /dev/zero map
+	SHARED			-	size of mapping
+	PRIVATE READ-only	-	0 cost (but of little use)
+	PRIVATE WRITABLE	-	size of mapping per instance
 
 Additional accounting
 	Pages made writable copies by mmap
@@ -66,5 +66,3 @@
 To Do
 -----
 o	Account ptrace pages (this is hard)
-o	Account for shared anonymous mappings properly
-	- right now we account them per instance
--- vmacct6/kernel/fork.c	Mon Jul 29 11:48:04 2002
+++ vmacct7/kernel/fork.c	Mon Jul 29 19:23:46 2002
@@ -210,17 +210,12 @@
 		retval = -ENOMEM;
 		if(mpnt->vm_flags & VM_DONTCOPY)
 			continue;
-
-		/*
-		 * FIXME: shared writable map accounting should be one off
-		 */
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned int len = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
 			if (!vm_enough_memory(len))
 				goto fail_nomem;
 			charge += len;
 		}
-
 		tmp = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (!tmp)
 			goto fail_nomem;

