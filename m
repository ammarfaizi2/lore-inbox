Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265658AbTFSAtF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbTFSAtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:49:05 -0400
Received: from palrel13.hp.com ([156.153.255.238]:7634 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265658AbTFSAtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:49:02 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16113.2972.194003.930280@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 18:02:20 -0700
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: missing bit for thread_info-next-to-task_struct patch
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch is needed to really allow the thread_info to live
in the same chunk of memory as task structure.  I missed it in my last
patch because the fix was originally keyed on INIT_THREAD_SIZE, which
was wrong but resulted in a one-liner patch which was easy to miss.
The patch below is cleaner.  I suppose it would be nice if we could
get rid of INIT_THREAD_SIZE entirely, but it looks like user-mode
Linux still relies on it.

	--david

diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Wed Jun 18 18:01:04 2003
+++ b/include/linux/sched.h	Wed Jun 18 18:01:04 2003
@@ -504,9 +509,10 @@
  */
 extern struct exec_domain	default_exec_domain;
 
-#ifndef INIT_THREAD_SIZE
-# define INIT_THREAD_SIZE	2048*sizeof(long)
-#endif
+#ifndef __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
+# ifndef INIT_THREAD_SIZE
+#  define INIT_THREAD_SIZE	2048*sizeof(long)
+# endif
 
 union thread_union {
 	struct thread_info thread_info;
@@ -514,6 +520,9 @@
 };
 
 extern union thread_union init_thread_union;
+
+#endif /* !__HAVE_ARCH_TASK_STRUCT_ALLOCATOR */
+
 extern struct task_struct init_task;
 
 extern struct   mm_struct init_mm;
