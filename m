Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbUKDCG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbUKDCG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUKDCET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:04:19 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:4756
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262057AbUKDBzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:55 -0500
Subject: [patch 07/20] uml: no duplicate current_thread definition
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:30 +0100
Message-Id: <20041103231730.B2F3155C75@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>

Currently there are two distinct definitions of current_thread_info (which has
its usual meaning) and current_thread (which is the same thing); so define the
second to be the first (for UML compatibility). If needed, a search & replace
\<current_thread\> to current_thread_info and removing current_thread can be
done (that would be a separate, low-priority patch, however).

Also, since the involved headers include each other very deeply, we must fix
somehow this recursive inclusion or things won't compile.

Jeff Dike noted that this can be done easily, since the nasty chain of includes
can be broken by eliminating an include of current.h, and implemented this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/include/asm-um/current.h        |   13 ++++---------
 vanilla-linux-2.6.9-paolo/include/asm-um/ptrace-generic.h |    2 --
 vanilla-linux-2.6.9-paolo/include/asm-um/thread_info.h    |    1 +
 3 files changed, 5 insertions(+), 11 deletions(-)

diff -puN include/asm-um/current.h~uml-no-duplicate-current-thread include/asm-um/current.h
--- vanilla-linux-2.6.9/include/asm-um/current.h~uml-no-duplicate-current-thread	2004-11-03 23:44:58.558657848 +0100
+++ vanilla-linux-2.6.9-paolo/include/asm-um/current.h	2004-11-03 23:44:58.563657088 +0100
@@ -8,18 +8,13 @@
 
 #ifndef __ASSEMBLY__
 
-struct thread_info;
-
-#include "linux/config.h"
 #include "asm/page.h"
+#include "linux/thread_info.h"
 
-#define CURRENT_THREAD(dummy) (((unsigned long) &dummy) & \
-			        (PAGE_MASK << CONFIG_KERNEL_STACK_ORDER))
-
-#define current_thread \
-	({ int dummy; ((struct thread_info *) CURRENT_THREAD(dummy)); })
+#define current (current_thread_info()->task)
 
-#define current (current_thread->task)
+/*Backward compatibility - it's used inside arch/um.*/
+#define current_thread current_thread_info()
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-um/ptrace-generic.h~uml-no-duplicate-current-thread include/asm-um/ptrace-generic.h
--- vanilla-linux-2.6.9/include/asm-um/ptrace-generic.h~uml-no-duplicate-current-thread	2004-11-03 23:44:58.559657696 +0100
+++ vanilla-linux-2.6.9-paolo/include/asm-um/ptrace-generic.h	2004-11-03 23:44:58.564656936 +0100
@@ -10,8 +10,6 @@
 
 #include "linux/config.h"
 
-#include "asm/current.h"
-
 #define pt_regs pt_regs_subarch
 #define show_regs show_regs_subarch
 
diff -puN include/asm-um/thread_info.h~uml-no-duplicate-current-thread include/asm-um/thread_info.h
--- vanilla-linux-2.6.9/include/asm-um/thread_info.h~uml-no-duplicate-current-thread	2004-11-03 23:44:58.561657392 +0100
+++ vanilla-linux-2.6.9-paolo/include/asm-um/thread_info.h	2004-11-03 23:44:58.564656936 +0100
@@ -8,6 +8,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/config.h>
 #include <asm/processor.h>
 #include <asm/types.h>
 
_
