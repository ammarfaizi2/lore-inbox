Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTJCX6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTJCX4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:56:41 -0400
Received: from users.ccur.com ([208.248.32.211]:19060 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S261549AbTJCXy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:54:58 -0400
Date: Fri, 3 Oct 2003 19:54:16 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com, andrea@suse.de
Subject: Re: mlockall and mmap of IO devices don't mix
Message-ID: <20031003235416.GA27201@rudolph.ccur.com>
References: <20031003214411.GA25802@rudolph.ccur.com> <20031003152349.7194b73d.akpm@osdl.org> <20031003225509.GA26590@rudolph.ccur.com> <20031003161540.42ff98bb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031003161540.42ff98bb.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 03, 2003 at 04:15:40PM -0700, Andrew Morton wrote:
>> Sigh.  No go; it *looks* good but my app still locks up....
> 
> Or we could use that VM_RESERVED thing?

Hi Andrew,
 Your third patch worked perfectly for all the tested cases:
    o /dev/mem at offset fd000000 (my video card mem addr)
    o /dev/mem at offset 0
    o with an mmapable device driver.

I did have to make two changes to get it to compile:

--- mm/memory.c.am3	2003-10-03 19:44:17.000000000 -0400
+++ mm/memory.c	2003-10-03 19:43:47.000000000 -0400
@@ -738,7 +738,7 @@
 #endif
 
 		special = vma->vm_flags & (VM_IO | VM_RESERVED);
-		if (!vma || (pages && vm_io) || !(flags & vma->vm_flags))
+		if (!vma || (pages && special) || !(flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
 		if (is_vm_hugetlb_page(vma)) {
@@ -755,7 +755,7 @@
 			 * mappings of /dev/mem - they may have no pageframes.
 			 * And the caller passed NULL for `pages' anyway.
 			 */
-			while (!special && !(map=follow_page(mm,start,write)) {
+			while (!special && !(map=follow_page(mm,start,write))) {
 				spin_unlock(&mm->page_table_lock);
 				switch (handle_mm_fault(mm,vma,start,write)) {
 				case VM_FAULT_MINOR:

In the first change, 'special' != '(vma->vma_flags & VM_IO)' which
was what was originally being tested.  Could that cause a problem?

Also, could the use of VM_RESERVED cause in some cases memory with
pageframes to skip adjustment/use of those pageframes?

Regards, and thanks,
Joe
