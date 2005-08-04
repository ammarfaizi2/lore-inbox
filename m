Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVHDVE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVHDVE3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVHDVCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:02:05 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:2275 "HELO
	roinet.com") by vger.kernel.org with SMTP id S262694AbVHDVBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:01:45 -0400
Subject: [PATCH 1/2] Re: Major breakage in linux-git on x86_64, oom killer
	goes on rampage
From: Pavel Roskin <proski@gnu.org>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <1123185522.2462.14.camel@dv.roinet.com>
References: <1123185522.2462.14.camel@dv.roinet.com>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 17:01:36 -0400
Message-Id: <1123189296.2332.7.camel@dv.roinet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

here's the solution.  The x86_64 specific portion will be posted as a
separate patch.

> Now the system boot goes a little further and then the kernel reports a
> BUG in mm/memory.c:985.  Apparently __handle_mm_fault() returns
> something unexpected.

I'm getting a BUG in mm/memory.c:985.  The unexpected value is 18 or
VM_FAULT_MINOR|VM_FAULT_WRITE.  As it turns out, __handle_mm_fault()
never returns VM_FAULT_WRITE, but in combination with VM_FAULT_MINOR.
Apparently, that's what was meant, and the fallthrough to case
VM_FAULT_MINOR is an indication of that.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -963,7 +963,7 @@ int get_user_pages(struct task_struct *t
 				spin_unlock(&mm->page_table_lock);
 				switch (__handle_mm_fault(mm, vma, start,
 							write_access)) {
-				case VM_FAULT_WRITE:
+				case VM_FAULT_WRITE|VM_FAULT_MINOR:
 					/*
 					 * do_wp_page has broken COW when
 					 * necessary, even if maybe_mkwrite

-- 
Regards,
Pavel Roskin

