Return-Path: <linux-kernel-owner+w=401wt.eu-S1751371AbXAKVMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbXAKVMi (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 16:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbXAKVMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 16:12:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:59976 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751371AbXAKVMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 16:12:37 -0500
X-Authenticated: #1045983
Content-Disposition: inline
From: Helge Deller <deller@gmx.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] shmat() and CONFIG_STACK_GROWSUP
Date: Thu, 11 Jan 2007 22:12:33 +0100
User-Agent: KMail/1.9.5
X-Face: *4/{KL3=jWs!v\UO#3e7~Vb1~CL@oP'~|*/M$!9`tb2[;fY@)WscF2iV7`,a$141g'o,7X
	?Bt1Wb:L7K6z-<?-+-13|S_ixrq58*E`)ZkSe~NSI?u=89G'J<n]7\?[)LCCBZc}~[j(e}
	`-QV{#%&[?^fAke6t8QbP;b'XB,ZU84HeThMrO(@/K.`jxq9P({V(AzezCKMxk\F2^p^+"
	["ppalbA!zy-l)^Qa3*u/Z-1W3,o?2fes2_d\u=1\E9N+~Qo
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200701112212.34000.deller@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On PARISC-Linux the stack grows up, which is why on this platform CONFIG_STACK_GROWSUP is #defined by default.
The patch below allows shmat() to map the requested memory region on this platform directly below the start of the stack, without the need to reserve memory for a downward-growing stack.
Basically it gains a small region of 4 Pages in which shmat() may map memory on this platform.

Helge

diff --git a/ipc/shm.c b/ipc/shm.c
index 6d16bb6..f5cc635 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -852,6 +852,7 @@ long do_shmat(int shmid, char __user *sh
 		user_addr = ERR_PTR(-EINVAL);
 		if (find_vma_intersection(current->mm, addr, addr + size))
 			goto invalid;
+#ifndef CONFIG_STACK_GROWSUP
 		/*
 		 * If shm segment goes below stack, make sure there is some
 		 * space left for the stack to grow (at least 4 pages).
@@ -859,6 +860,7 @@ long do_shmat(int shmid, char __user *sh
 		if (addr < current->mm->start_stack &&
 		    addr > current->mm->start_stack - size - PAGE_SIZE * 5)
 			goto invalid;
+#endif
 	}
 		
 	user_addr = (void*) do_mmap (file, addr, size, prot, flags, 0);
