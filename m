Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTJCWXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTJCWXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:23:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:52098 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261362AbTJCWXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:23:51 -0400
Date: Fri, 3 Oct 2003 15:23:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com, andrea@suse.de
Subject: Re: mlockall and mmap of IO devices don't mix
Message-Id: <20031003152349.7194b73d.akpm@osdl.org>
In-Reply-To: <20031003214411.GA25802@rudolph.ccur.com>
References: <20031003214411.GA25802@rudolph.ccur.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> wrote:
>
> 2.6.0-test6: the use of mlockall(2) in a process that has mmap(2)ed
> the registers of an IO device will hang that process uninterruptibly.
> The task runs in an infinite loop in get_user_pages(), invoking
> follow_page() forever.

whoops.

I think the right fix is in get_user_pages(): if the region is VM_IO then
don't call follow_page() at all.

Something like this?

 25-akpm/mm/memory.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff -puN mm/memory.c~get_user_pages-handle-VM_IO mm/memory.c
--- 25/mm/memory.c~get_user_pages-handle-VM_IO	Fri Oct  3 15:22:18 2003
+++ 25-akpm/mm/memory.c	Fri Oct  3 15:22:18 2003
@@ -683,6 +683,7 @@ int get_user_pages(struct task_struct *t
 		struct page **pages, struct vm_area_struct **vmas)
 {
 	int i;
+	int vm_io;
 	unsigned int flags;
 
 	/* 
@@ -739,8 +740,8 @@ int get_user_pages(struct task_struct *t
 		}
 #endif
 
-		if (!vma || (pages && (vma->vm_flags & VM_IO))
-				|| !(flags & vma->vm_flags))
+		vm_io = vma->vm_flags & VM_IO;
+		if (!vma || (pages && vm_io) || !(flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
 		if (is_vm_hugetlb_page(vma)) {
@@ -750,8 +751,14 @@ int get_user_pages(struct task_struct *t
 		}
 		spin_lock(&mm->page_table_lock);
 		do {
-			struct page *map;
-			while (!(map = follow_page(mm, start, write))) {
+			struct page *map = NULL;
+
+			/*
+			 * We don't follow pagetables for VM_IO regions - they
+			 * have no pageframes.  And the caller passed NULL
+			 * for `pages' anyway.
+			 */
+			while (!vm_io && !(map = follow_page(mm,start,write))) {
 				spin_unlock(&mm->page_table_lock);
 				switch (handle_mm_fault(mm,vma,start,write)) {
 				case VM_FAULT_MINOR:

_

