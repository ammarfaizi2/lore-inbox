Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268838AbUI2Sti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268838AbUI2Sti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 14:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268816AbUI2Ssh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 14:48:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:37595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268817AbUI2Spm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 14:45:42 -0400
Date: Wed, 29 Sep 2004 11:45:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: riel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mlockall() check rlimit only when MCL_CURRENT is set
Message-ID: <20040929114538.R1924@build.pdx.osdl.net>
References: <20040929114244.Q1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040929114244.Q1924@build.pdx.osdl.net>; from chrisw@osdl.org on Wed, Sep 29, 2004 at 11:42:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only check memlock rlimit against mm->total_vm when mlockall() flags
include MCL_CURRENT.

Signed-off-by: Chris Wright <chrisw@osdl.org>

--- 2.6.9-rc2/mm/mlock.c~mcl_current_acct	2004-09-28 15:00:48.962235080 -0700
+++ 2.6.9-rc2/mm/mlock.c	2004-09-28 15:03:35.192964168 -0700
@@ -178,7 +178,8 @@ asmlinkage long sys_mlockall(int flags)
 	lock_limit >>= PAGE_SHIFT;
 
 	ret = -ENOMEM;
-	if ((current->mm->total_vm <= lock_limit) || capable(CAP_IPC_LOCK))
+	if (!(flags & MCL_CURRENT) || (current->mm->total_vm <= lock_limit) ||
+	    capable(CAP_IPC_LOCK))
 		ret = do_mlockall(flags);
 out:
 	up_write(&current->mm->mmap_sem);
