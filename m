Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269111AbUHXX3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269111AbUHXX3B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269109AbUHXX21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:28:27 -0400
Received: from holomorphy.com ([207.189.100.168]:7815 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269111AbUHXXY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:24:27 -0400
Date: Tue, 24 Aug 2004 16:24:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: fix text reporting in O(1) proc_pid_statm()
Message-ID: <20040824232424.GI2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1093388816.434.355.camel@cube> <20040824231236.GG2793@holomorphy.com> <20040824231841.GH2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824231841.GH2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 04:12:36PM -0700, William Lee Irwin III wrote:
>> This would not be difficult to perform additional accounting for.
>> I'll follow up with that shortly.

On Tue, Aug 24, 2004 at 04:18:41PM -0700, William Lee Irwin III wrote:
> Account reserved memory properly as per acahalan's sepecified semantics.

Unrelated fix. Unaccount VM_DONTCOPY vmas properly; the child inherits
the whole of the parent's virtual accounting from the memcpy() in
copy_mm(), but the VM_DONTCOPY check here is where a decision is made
for the child not to inherit the vmas corresponding to some accounted
memory usages. Hence, unaccount them when skipping over them here.


-- wli

Index: mm4-2.6.8.1/kernel/fork.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/fork.c	2004-08-23 16:19:50.000000000 -0700
+++ mm4-2.6.8.1/kernel/fork.c	2004-08-24 16:19:45.404121128 -0700
@@ -391,8 +391,11 @@
 	for (mpnt = current->mm->mmap ; mpnt ; mpnt = mpnt->vm_next) {
 		struct file *file;
 
-		if(mpnt->vm_flags & VM_DONTCOPY)
+		if (mpnt->vm_flags & VM_DONTCOPY) {
+			__vm_stat_account(mm, mpnt->vm_flags, mpnt->vm_file,
+							-vma_pages(mpnt));
 			continue;
+		}
 		charge = 0;
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned int len = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
