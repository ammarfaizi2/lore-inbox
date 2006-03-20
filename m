Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWCTNiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWCTNiL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWCTNiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:38:10 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:45134 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964787AbWCTNiB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:38:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XpwjHbh80p2updkCXt6uGmbXuHUvoxxQvoQNSvpy7ZcN+itb5WgQ4CTjqVaQojw9BcDy21FRyZG6gVCYMqFaLQvia6Go30z+qTvJ6KHTvXnNB7uJkSj0j9cPRtlpEB7XlLPnMV8ETaoIpMiZIV+aIh9nTbUA/M5+VopgkuEjWfg=
Message-ID: <bc56f2f0603200537s6157aec8m@mail.gmail.com>
Date: Mon, 20 Mar 2006 08:37:59 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: akpm@osdl.org
Subject: [PATCH][6/8] mm: munmap/munmap/mremap and relative
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust VM_LOCKED relative operations in munmap/mmap/mremap:
 replacing make_pages_present with make_pages_wired.

Signed-off-by: Shaoping Wang <pwstone@gmail.com>

 mmap.c   |    8 ++++----
 mremap.c |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)
--

diff -urN linux-2.6.15.orig/mm/mmap.c linux-2.6.15/mm/mmap.c
--- linux-2.6.15.orig/mm/mmap.c	2006-02-17 05:24:09.000000000 -0500
+++ linux-2.6.15/mm/mmap.c	2006-03-06 06:30:08.000000000 -0500
@@ -1119,7 +1119,7 @@
 	vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += len >> PAGE_SHIFT;
-		make_pages_present(addr, addr + len);
+		make_pages_wired(addr, addr + len);
 	}
 	if (flags & MAP_POPULATE) {
 		up_write(&mm->mmap_sem);
@@ -1551,7 +1551,7 @@
 	if (!prev || expand_stack(prev, addr))
 		return NULL;
 	if (prev->vm_flags & VM_LOCKED) {
-		make_pages_present(addr, prev->vm_end);
+		make_pages_wired(addr, prev->vm_end);
 	}
 	return prev;
 }
@@ -1614,7 +1614,7 @@
 	if (expand_stack(vma, addr))
 		return NULL;
 	if (vma->vm_flags & VM_LOCKED) {
-		make_pages_present(addr, start);
+		make_pages_wired(addr, start);
 	}
 	return vma;
 }
@@ -1921,7 +1921,7 @@
 	mm->total_vm += len >> PAGE_SHIFT;
 	if (flags & VM_LOCKED) {
 		mm->locked_vm += len >> PAGE_SHIFT;
-		make_pages_present(addr, addr + len);
+		make_pages_wired(addr, addr + len);
 	}
 	return addr;
 }
diff -urN linux-2.6.15.orig/mm/mremap.c linux-2.6.15/mm/mremap.c
--- linux-2.6.15.orig/mm/mremap.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/mremap.c	2006-03-06 06:30:08.000000000 -0500
@@ -230,7 +230,7 @@
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += new_len >> PAGE_SHIFT;
 		if (new_len > old_len)
-			make_pages_present(new_addr + old_len,
+			make_pages_wired(new_addr + old_len,
 					   new_addr + new_len);
 	}

@@ -367,7 +367,7 @@
 			vm_stat_account(mm, vma->vm_flags, vma->vm_file, pages);
 			if (vma->vm_flags & VM_LOCKED) {
 				mm->locked_vm += pages;
-				make_pages_present(addr + old_len,
+				make_pages_wired(addr + old_len,
 						   addr + new_len);
 			}
 			ret = addr;
