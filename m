Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268805AbUI2Stl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268805AbUI2Stl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 14:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268817AbUI2Ssw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 14:48:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:49115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268819AbUI2Sr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 14:47:56 -0400
Date: Wed, 29 Sep 2004 11:47:54 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: riel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] make can_do_mlock useful for mlock/mlockall
Message-ID: <20040929114754.S1924@build.pdx.osdl.net>
References: <20040929114244.Q1924@build.pdx.osdl.net> <20040929114538.R1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040929114538.R1924@build.pdx.osdl.net>; from chrisw@osdl.org on Wed, Sep 29, 2004 at 11:45:39AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the simple can_do_mlock() check before the full rlimits based
restriction checks for mlock() and mlockall().  As it is, the check
adds nothing.  This has a side-effect of eliminating an unnecessary call
to can_do_mlock() on the munlockall() path.

Signed-off-by: Chris Wright <chrisw@osdl.org>

--- 2.6.9-rc2/mm/mlock.c~can_do_mlock	2004-09-28 15:06:54.668639256 -0700
+++ 2.6.9-rc2/mm/mlock.c	2004-09-28 15:08:56.175167456 -0700
@@ -60,8 +60,6 @@ static int do_mlock(unsigned long start,
 	struct vm_area_struct * vma, * next;
 	int error;
 
-	if (on && !can_do_mlock())
-		return -EPERM;
 	len = PAGE_ALIGN(len);
 	end = start + len;
 	if (end < start)
@@ -107,6 +105,9 @@ asmlinkage long sys_mlock(unsigned long 
 	unsigned long lock_limit;
 	int error = -ENOMEM;
 
+	if (!can_do_mlock())
+		return -EPERM;
+
 	down_write(&current->mm->mmap_sem);
 	len = PAGE_ALIGN(len + (start & ~PAGE_MASK));
 	start &= PAGE_MASK;
@@ -138,13 +139,9 @@ asmlinkage long sys_munlock(unsigned lon
 
 static int do_mlockall(int flags)
 {
-	unsigned int def_flags;
 	struct vm_area_struct * vma;
+	unsigned int def_flags = 0;
 
-	if (!can_do_mlock())
-		return -EPERM;
-
-	def_flags = 0;
 	if (flags & MCL_FUTURE)
 		def_flags = VM_LOCKED;
 	current->mm->def_flags = def_flags;
@@ -174,6 +171,10 @@ asmlinkage long sys_mlockall(int flags)
 	if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE)))
 		goto out;
 
+	ret = -EPERM;
+	if (!can_do_mlock())
+		goto out;
+
 	lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 	lock_limit >>= PAGE_SHIFT;
 
