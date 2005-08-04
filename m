Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVHDT6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVHDT6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbVHDT6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:58:52 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:46050
	"HELO roinet.com") by vger.kernel.org with SMTP id S261514AbVHDT6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:58:47 -0400
Subject: Major breakage in linux-git on x86_64, oom killer goes on rampage
From: Pavel Roskin <proski@gnu.org>
To: discuss@x86-64.org, linux <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 15:58:42 -0400
Message-Id: <1123185522.2462.14.camel@dv.roinet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This fix breaks x64_64:

commit f33ea7f404e592e4563b12101b7a4d17da6558d7 
tree 1d587ad8a06cb6d2e3a187f0312c8a524ffefe53 
parent 5cb4cc0d8211c490537c8568001958fc76741312 
author Nick Piggin <nickpiggin@yahoo.com.au> Wed, 03 Aug 2005 20:24:01
+1000 
committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 03 Aug 2005
09:12:05 -0700 

    * include/linux/mm.h, mm/memory.c:

    [PATCH] fix get_user_pages bug
...

The system doesn't boot.  Most processes are killed by VM.

The patch does more than it claims.  It actually redefines VM_FAULT_OOM
and VM_FAULT_SIGBUS.  Unfortunately, a quick look at
arch/x86_64/mm/fault.c shows that the return value of handle_mm_fault()
is compared with numerical constants.  This patch helps partly:

--- arch/x86_64/mm/fault.c
+++ arch/x86_64/mm/fault.c
@@ -439,15 +439,15 @@ good_area:
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
-	case 1:
+	case VM_FAULT_MINOR:
 		tsk->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
-	default:
+	case VM_FAULT_OOM:
 		goto out_of_memory;
 	}
 
Now the system boot goes a little further and then the kernel reports a
BUG in mm/memory.c:985.  Apparently __handle_mm_fault() returns
something unexpected.  My guess is that some x86_64 specific functions
return -1 and 0 when they mean VM_FAULT_SIGBUS and VM_FAULT_OOM.
Returning -1 would trigger BUG(), returning 0 would be treated as
VM_FAULT_OOM rather than VM_FAULT_SIGBUS.

I'm not sure I'll be able to fix it quickly, but I hope the gurus will
beat me at that.  In the meantime, please don't make any releases unless
the "commit f33ea7f404e592e4563b12101b7a4d17da6558d7" is reverted.

-- 
Regards,
Pavel Roskin

