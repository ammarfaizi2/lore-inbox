Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268799AbUI2Smu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268799AbUI2Smu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 14:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268803AbUI2Smu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 14:42:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:60375 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268799AbUI2Smp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 14:42:45 -0400
Date: Wed, 29 Sep 2004 11:42:44 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mlockall(MCL_FUTURE) unlocks currently locked mappings
Message-ID: <20040929114244.Q1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calling mlockall(MCL_FUTURE) will erroneously unlock any currently locked
mappings.  Fix this up, and while we're at it, remove the essentially
unused error variable.

Signed-off-by: Chris Wright <chrisw@osdl.org>

--- 2.6.9-rc2/mm/mlock.c~mcl_future	2004-09-28 15:00:11.781887352 -0700
+++ 2.6.9-rc2/mm/mlock.c	2004-09-28 15:27:01.784129808 -0700
@@ -138,7 +138,6 @@ asmlinkage long sys_munlock(unsigned lon
 
 static int do_mlockall(int flags)
 {
-	int error;
 	unsigned int def_flags;
 	struct vm_area_struct * vma;
 
@@ -149,8 +148,9 @@ static int do_mlockall(int flags)
 	if (flags & MCL_FUTURE)
 		def_flags = VM_LOCKED;
 	current->mm->def_flags = def_flags;
+	if (flags == MCL_FUTURE)
+		goto out;
 
-	error = 0;
 	for (vma = current->mm->mmap; vma ; vma = vma->vm_next) {
 		unsigned int newflags;
 
@@ -161,7 +161,8 @@ static int do_mlockall(int flags)
 		/* Ignore errors */
 		mlock_fixup(vma, vma->vm_start, vma->vm_end, newflags);
 	}
-	return error;
+out:
+	return 0;
 }
 
 asmlinkage long sys_mlockall(int flags)
