Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUJNS7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUJNS7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUJNS7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:59:23 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:64641
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S266891AbUJNS6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:58:16 -0400
Subject: [patch 1/1] SKAS3: fix mm->dumpable handling
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it,
       uml@hno.marasystems.com, mcr@sandelman.ottawa.on.ca
From: blaisorblade_spam@yahoo.it
Date: Thu, 14 Oct 2004 18:17:58 +0200
Message-Id: <20041014161758.C4CF444BE@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Henrik Nordstrom <uml@hno.marasystems.com>, Michael Richardson <mcr@sandelman.ottawa.on.ca>

When a child mm is created by opening /proc/mm, without this patch its
mm->dumpable flag is left set to 0, even when there is no reason to do so.

This way, for instance, if <pid> is the pid of a userspace thread,
/proc/<pid> is only readable by root (which was the original reason letting
this be diagnosed by Michael Richardson).

Paolo and Henrik discussed about this in detail, finally Paolo wrote the patch
and sent it for comment.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ptrace.c |    8 ++++++++
 vanilla-linux-2.6.7-SKAS-paolo/mm/proc_mm.c              |    2 ++
 2 files changed, 10 insertions(+)

diff -puN mm/proc_mm.c~fix-dumpable-handling mm/proc_mm.c
--- vanilla-linux-2.6.7-SKAS/mm/proc_mm.c~fix-dumpable-handling	2004-10-14 16:58:17.473473200 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/mm/proc_mm.c	2004-10-14 18:15:21.294545552 +0200
@@ -125,6 +125,8 @@ static int open_proc_mm(struct inode *in
 		goto out_mem;
 
 	init_new_empty_context(mm);
+	mm->dumpable = current->mm->dumpable;
+	wmb();
 
 	spin_lock(&mmlist_lock);
 	list_add(&mm->mmlist, &current->mm->mmlist);
diff -puN arch/i386/kernel/ptrace.c~fix-dumpable-handling arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.7-SKAS/arch/i386/kernel/ptrace.c~fix-dumpable-handling	2004-10-14 17:05:30.651620112 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ptrace.c	2004-10-14 18:15:21.297545096 +0200
@@ -559,6 +559,14 @@ asmlinkage int sys_ptrace(long request, 
 			break;
 		}
 
+		/* Let's be safe. If we are ptraced from a non-dumpable process,
+		 * let's not be dumpable. Don't try to be smart and turn
+		 * current->dumpable to 1: it may be unsafe.*/
+		if (!current->dumpable) {
+			new->dumpable = 0;
+			wmb();
+		}
+
 		atomic_inc(&new->mm_users);
 		child->mm = new;
 		child->active_mm = new;
_
