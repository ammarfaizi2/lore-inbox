Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVBHOcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVBHOcr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 09:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVBHOce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 09:32:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57283 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261568AbVBHOcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 09:32:14 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH] NOMMU: Improved handling of get_unmapped_area() errors
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Tue, 08 Feb 2005 14:32:05 +0000
Message-ID: <19277.1107873125@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch does two things:

 (1) We no longer check the return value of file->f_op->get_unmapped_area()
     unless we actually called it. We know addr is zero otherwise because
     we'd've given an error earlier if it wasn't.

 (2) If -ENOSYS was returned by that operation, then we assume we actually
     called a driver (such as the framebuffer driver) that might want to
     invoke the operation in a lower level driver (such as matroxfb) if one
     exists, and that it found that one didn't.

     We translate the -ENOSYS error into -ENODEV - the error we would have
     given if the operation was not supplied in the file ops.

     Doing this permits us an opportunity for arch_get_unmapped_area() or
     something else to be called if we want that to happen, particularly in
     the MMU case.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 nommu-2611rc3.diff 
 mm/nommu.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.11-rc3/mm/nommu.c linux-2.6.11-rc3-frv/mm/nommu.c
--- /warthog/kernels/linux-2.6.11-rc3/mm/nommu.c	2005-02-04 11:50:28.000000000 +0000
+++ linux-2.6.11-rc3-frv/mm/nommu.c	2005-02-08 13:54:18.816577889 +0000
@@ -567,12 +567,14 @@ unsigned long do_mmap_pgoff(struct file 
 	 * that it represents a valid section of the address space
 	 * - this is the hook for quasi-memory character devices
 	 */
-	if (file && file->f_op->get_unmapped_area)
+	if (file && file->f_op->get_unmapped_area) {
 		addr = file->f_op->get_unmapped_area(file, addr, len, pgoff, flags);
-
-	if (IS_ERR((void *) addr)) {
-		ret = addr;
-		goto error;
+		if (IS_ERR((void *) addr)) {
+			ret = addr;
+			if (ret == (unsigned long) -ENOSYS)
+				ret = (unsigned long) -ENODEV;
+			goto error;
+		}
 	}
 
 	/* we're going to need a VMA struct as well */
