Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUI2S5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUI2S5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 14:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268839AbUI2SzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 14:55:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:59099 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268819AbUI2Stt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 14:49:49 -0400
Date: Wed, 29 Sep 2004 11:49:43 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: riel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mlockall() take mmap_sem a bit later
Message-ID: <20040929114943.T1924@build.pdx.osdl.net>
References: <20040929114244.Q1924@build.pdx.osdl.net> <20040929114538.R1924@build.pdx.osdl.net> <20040929114754.S1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040929114754.S1924@build.pdx.osdl.net>; from chrisw@osdl.org on Wed, Sep 29, 2004 at 11:47:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In sys_mlockall(), flags validation and can_do_mlock() check don't
require holding mmap_sem.  Move down_write() down a bit, and adjust
appropriately.

Signed-off-by: Chris Wright <chrisw@osdl.org>

--- 2.6.9-rc2/mm/mlock.c~move_sem	2004-09-28 23:46:01.000000000 -0700
+++ 2.6.9-rc2/mm/mlock.c	2004-09-29 00:22:25.625969360 -0700
@@ -119,7 +119,7 @@ asmlinkage long sys_mlock(unsigned long 
 	lock_limit >>= PAGE_SHIFT;
 
 	/* check against resource limits */
-	if ( (locked <= lock_limit) || capable(CAP_IPC_LOCK))
+	if ((locked <= lock_limit) || capable(CAP_IPC_LOCK))
 		error = do_mlock(start, len, 1);
 	up_write(&current->mm->mmap_sem);
 	return error;
@@ -167,7 +167,6 @@ asmlinkage long sys_mlockall(int flags)
 	unsigned long lock_limit;
 	int ret = -EINVAL;
 
-	down_write(&current->mm->mmap_sem);
 	if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE)))
 		goto out;
 
@@ -175,6 +174,8 @@ asmlinkage long sys_mlockall(int flags)
 	if (!can_do_mlock())
 		goto out;
 
+	down_write(&current->mm->mmap_sem);
+
 	lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 	lock_limit >>= PAGE_SHIFT;
 
@@ -182,8 +183,8 @@ asmlinkage long sys_mlockall(int flags)
 	if (!(flags & MCL_CURRENT) || (current->mm->total_vm <= lock_limit) ||
 	    capable(CAP_IPC_LOCK))
 		ret = do_mlockall(flags);
-out:
 	up_write(&current->mm->mmap_sem);
+out:
 	return ret;
 }
 
