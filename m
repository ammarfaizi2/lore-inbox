Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVAKDww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVAKDww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVAKDvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:51:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:7327 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262429AbVAKDti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:49:38 -0500
Date: Mon, 10 Jan 2005 19:49:36 -0800
From: Chris Wright <chrisw@osdl.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] acct_stack_growth nitpicks
Message-ID: <20050110194936.O2357@build.pdx.osdl.net>
References: <20050110164214.J2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050110164214.J2357@build.pdx.osdl.net>; from chrisw@osdl.org on Mon, Jan 10, 2005 at 04:42:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove duplicate rlim assignment in acct_stack_growth()
- allow CAP_IPC_LOCK to override mlock rlimit during stack expansion as
  in all other cases

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== mm/mmap.c 1.155 vs edited =====
--- 1.155/mm/mmap.c	2005-01-10 11:23:35 -08:00
+++ edited/mm/mmap.c	2005-01-10 19:34:05 -08:00
@@ -1346,7 +1346,6 @@ static int acct_stack_growth(struct vm_a
 	struct rlimit *rlim = current->signal->rlim;
 
 	/* address space limit tests */
-	rlim = current->signal->rlim;
 	if (mm->total_vm + grow > rlim[RLIMIT_AS].rlim_cur >> PAGE_SHIFT)
 		return -ENOMEM;
 
@@ -1360,7 +1359,7 @@ static int acct_stack_growth(struct vm_a
 		unsigned long limit;
 		locked = mm->locked_vm + grow;
 		limit = rlim[RLIMIT_MEMLOCK].rlim_cur >> PAGE_SHIFT;
-		if (locked > limit)
+		if (locked > limit && !capable(CAP_IPC_LOCK))
 			return -ENOMEM;
 	}
 
