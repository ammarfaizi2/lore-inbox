Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310501AbSCCCgl>; Sat, 2 Mar 2002 21:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310502AbSCCCgb>; Sat, 2 Mar 2002 21:36:31 -0500
Received: from mtaout.telus.net ([199.185.220.235]:17824 "EHLO
	priv-edtnes10-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id <S310501AbSCCCgU>; Sat, 2 Mar 2002 21:36:20 -0500
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
cc: linux-kernel@vger.kernel.org
Subject: PATCH 2.4.18-rc2-ac1: hang on spinlock in "expand_stack"
From: Kevin Buhr <buhr@telus.net>
Date: 02 Mar 2002 18:36:12 -0800
Message-ID: <87d6ymfkdf.fsf@saurus.asaurus.invalid>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan:

I've enclosed a patch against 2.4.18-rc2-ac1, but it appears the same
bug still exists in 2.4.19-pre1-ac1.  The "ac"-branch version of
"expand_stack" in "mm/mmap.c" has a code path that doesn't unlock the
spinlock.  I noticed when a "gdb" bug tickled it and locked up my
machine.

Kevin Buhr <buhr@telus.net>

                        *       *       *

--- linux-2.4.18-rc2-ac1/mm/mmap.c	Tue Feb 19 19:13:57 2002
+++ linux-2.4.18-rc2-ac1-local/mm/mmap.c	Sat Mar  2 17:58:47 2002
@@ -762,8 +762,10 @@
 	grow = (vma->vm_start - address) >> PAGE_SHIFT;
 
 	/* Overcommit.. */
-	if(!vm_enough_memory(grow, 1))
+	if(!vm_enough_memory(grow, 1)) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
 		return -ENOMEM;
+	}
 	
 	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
 	    ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_AS].rlim_cur) {
