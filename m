Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132295AbRAKGN0>; Thu, 11 Jan 2001 01:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132291AbRAKGNQ>; Thu, 11 Jan 2001 01:13:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13454 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132284AbRAKGNL>;
	Thu, 11 Jan 2001 01:13:11 -0500
Date: Thu, 11 Jan 2001 01:13:10 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/filesystems/Locking update
Message-ID: <Pine.GSO.4.21.0101110109440.15355-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patch updates filesystems/Locking - corrects ->writepage()
prototype, removes dead vma methods and corrects ->writepage() and
->readpage() description wrt page lock.

	Please, apply.

diff -urN S1-pre1/Documentation/filesystems/Locking S1-pre1-s_lock/Documentation/filesystems/Locking
--- S1-pre1/Documentation/filesystems/Locking	Fri Jul 28 15:50:51 2000
+++ S1-pre1-s_lock/Documentation/filesystems/Locking	Thu Jan 11 01:01:14 2001
@@ -117,7 +117,7 @@
 
 --------------------------- address_space_operations --------------------------
 prototypes:
-	int (*writepage)(struct file *, struct page *);
+	int (*writepage)(struct page *);
 	int (*readpage)(struct file *, struct page *);
 	int (*sync_page)(struct page *);
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
@@ -126,8 +126,8 @@
 locking rules:
 	All may block
 		BKL	PageLocked(page)
-writepage:	no	yes
-readpage:	no	yes
+writepage:	no	yes, unlocks
+readpage:	no	yes, unlocks
 sync_page:	no	maybe
 prepare_write:	no	yes
 commit_write:	no	yes
@@ -135,6 +135,7 @@
 
 	->prepare_write(), ->commit_write(), ->sync_page() and ->readpage()
 may be called from the request handler (/dev/loop).
+	->readpage() and ->writepage() unlock the page.
 	->sync_page() locking rules are not well-defined - usually it is called
 with lock on page, but that is not guaranteed. Considering the currently
 existing instances of this method ->sync_page() itself doesn't look
@@ -285,26 +286,13 @@
 prototypes:
 	void (*open)(struct vm_area_struct*);
 	void (*close)(struct vm_area_struct*);
-	void (*unmap)(struct vm_area_struct*, unsigned long, size_t);
-	void (*protect)(struct vm_area_struct*, unsigned long, size_t, unsigned);
-	int (*sync)(struct vm_area_struct*, unsigned long, size_t, unsigned);
 	struct page *(*nopage)(struct vm_area_struct*, unsigned long, int);
-	struct page *(*wppage)(struct vm_area_struct*, unsigned long, struct page*);
-	int (*swapout)(struct page *, struct file *);
 
 locking rules:
 		BKL	mmap_sem
 open:		no	yes
 close:		no	yes
-sync:		no	yes
-unmap:		no	yes
 nopage:		no	yes
-swapout:	yes	yes
-wpppage:				(see below)
-protect:				(see below)
-
-->wppage() and ->protect() have no instances and nothing calls them; looks like
-they must die...
 
 ================================================================================
 			Dubious stuff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
