Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWJOSeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWJOSeS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 14:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWJOSeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 14:34:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9640 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030193AbWJOSeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 14:34:17 -0400
Date: Sun, 15 Oct 2006 14:34:11 -0400
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200610151834.k9FIYBK5015809@devserv.devel.redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] close mprotect noexec hole
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch closes the hole in mprotect discovered during
the noexec mount discussions.  Without this the protection is
incomplete and pretty much useless.  With it and additional techniques
like SELinux all holes can be plugged in a fine-grained way.

I think it should be in .19 since it's a security problem not to have
it.  Tested on x86-64.


Signed-off-by: Ulrich Drepper <drepper@redhat.com>

--- mm/mprotect.c	2006-10-01 09:35:14.000000000 -0700
+++ mm/mprotect.c-new	2006-10-11 14:54:55.000000000 -0700
@@ -251,6 +251,10 @@
 	error = -ENOMEM;
 	if (!vma)
 		goto out;
+	error = -EACCES;
+	if ((reqprot & PROT_EXEC) && vma->vm_file &&
+	    (vma->vm_file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
+		goto out;
 	if (unlikely(grows & PROT_GROWSDOWN)) {
 		if (vma->vm_start >= end)
 			goto out;
