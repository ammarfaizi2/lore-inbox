Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263532AbTKKPJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTKKPJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:09:32 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:21634 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263531AbTKKPJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:09:20 -0500
Date: Tue, 11 Nov 2003 16:09:15 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: [PATCH?] 2.6.0-test9: mm/memory.c:1075: spin_unlock(kernel/fork.c:c0efed90) not locked
Message-ID: <20031111150915.GA14601@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Kasperski's kavscanner went mad today and eat all memory it was able to get.
While system was attempting to recover (one thing I do not understand: there was
one 2GB process (kavscanner) and dozen of ~100MB ones, but kernel killed everyone 
else EXCEPT kavscanner - apache, mysqld) I got several warnings that mm/memory.c:1075 
(do_wp_page) attempts to unlock unlocked spinlock mm->page_table_lock.

  As far as I can tell, problem is that no_mem case should NOT release page_table_lock
as it was already released before call to pte_chain_alloc(), and was not reacquired
yet.
							Petr Vandrovec

Nov 11 15:44:46 vana kernel: VM: killing process apache
Nov 11 15:44:47 vana kernel: apache: page allocation failure. order:0, mode:0xd2
Nov 11 15:44:47 vana kernel: kswapd0: page allocation failure. order:0, mode:0x20
Nov 11 15:44:47 vana last message repeated 5 times
Nov 11 15:44:47 vana kernel: apache: page allocation failure. order:0, mode:0xd2
Nov 11 15:44:47 vana kernel: apache: page allocation failure. order:0, mode:0xd2
Nov 11 15:44:47 vana kernel: mm/memory.c:1075: spin_unlock(kernel/fork.c:c0efed90) not locked
Nov 11 15:44:47 vana kernel: VM: killing process apache
Nov 11 15:44:47 vana kernel: Out of Memory: Killed process 13479 (apache).


P.S.: I'm not subscribed on linux-mm.

--- linux/mm/memory.c.orig	2003-11-06 11:51:56.000000000 +0100
+++ linux/mm/memory.c	2003-11-11 16:03:38.000000000 +0100
@@ -1013,7 +1013,8 @@
 		pte_unmap(page_table);
 		printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n",
 				address);
-		goto oom;
+		ret = VM_FAULT_OOM;
+		goto out;
 	}
 	old_page = pfn_to_page(pfn);
 
@@ -1065,16 +1066,15 @@
 	page_cache_release(new_page);
 	page_cache_release(old_page);
 	ret = VM_FAULT_MINOR;
-	goto out;
-
-no_mem:
-	page_cache_release(old_page);
-oom:
-	ret = VM_FAULT_OOM;
 out:
 	spin_unlock(&mm->page_table_lock);
 	pte_chain_free(pte_chain);
 	return ret;
+
+no_mem:
+	page_cache_release(old_page);
+	pte_chain_free(pte_chain);
+	return VM_FAULT_OOM;
 }
 
 /*
