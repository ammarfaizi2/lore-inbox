Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291965AbSBTQNF>; Wed, 20 Feb 2002 11:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291962AbSBTQM4>; Wed, 20 Feb 2002 11:12:56 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:5920 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S291957AbSBTQMn>; Wed, 20 Feb 2002 11:12:43 -0500
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C01101F6B@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'ultralinux@vger.kernel.org'" <ultralinux@vger.kernel.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'davem@redhat.com'" <davem@redhat.com>
Subject: 2.5.5 on Sparc, Ughh...
Date: Wed, 20 Feb 2002 11:12:31 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.  For the adventurous types, you'll at the very least need to apply the
below included patches to get Sparc64 to begin the compilation process at
all.   Here is some details:

/include/asm-sparc64/mmu_context.h - movement of the #define for MAX_PRIO_RT
in the scheduler causes the compile to fail here.  My patch below will
comment out at least the failing Function, which does not appear to be doing
anything usefull anyways.

/kernel/sched.c - Ingo changed the scheduler switch_to() to 2 arguments
rather than three, but the appropriate assembly changes have not been
applied to /asm-sparc64/system.h.  Ingo pointed me  to a work around for
this for now, by changing the swicht_to() back to three args for sched.c.
This is not the correct fix, but will get the compile to continue.

>From here, I am getting the following errors compiling filemap.c.  Anyone at
all have any luck getting Sparc to compile with 2.5.5?  

 `flush_dcache_page' doesn't match global one

/usr/src/linux-2.5.5/include/linux/highmem.h: In function
`truncate_list_pages':
 

/usr/src/linux-2.5.5/include/linux/highmem.h:112: conflicting types for
`flush_d
cache_page'

/usr/src/linux-2.5.5/include/asm/pgalloc.h:43: previous declaration of
`flush_dc
ache_page'

/usr/src/linux-2.5.5/include/linux/highmem.h:112: warning: extern
declaration of
 `flush_dcache_page' doesn't match global one

filemap.c: In function `filemap_sync_pte_range':

filemap.c:2078: warning: implicit declaration of function `pte_offset_map'

filemap.c:2078: warning: assignment makes pointer from integer without a
cast   
filemap.c:2088: warning: implicit declaration of function `pte_unmap'

make[2]: *** [filemap.o] Error 1

make[2]: Leaving directory `/usr/src/linux-2.5.5/mm'

make[1]: *** [first_rule] Error 2

make[1]: Leaving directory `/usr/src/linux-2.5.5/mm'

make: *** [_dir_mm] Error 2


Thanks,
Bruce H.

Here are the patch diffs to get Sparc to compile at all....

--- mmu_context.h.old	Wed Feb 20 09:01:26 2002
+++ mmu_context.h	Wed Feb 20 09:05:08 2002
@@ -28,14 +28,19 @@
 #include <asm/spitfire.h>
 
 /*
+ * ??? Is this needed here?  This function does not appear to be
+ * Working, and is broken after the 2.5 change to MAX_RT_PRIO being
+ * moved from sched.h to sched.c 
+ *
  * Every architecture must define this function. It's the fastest
  * way of searching a 168-bit bitmap where the first 128 bits are
  * unlikely to be set. It's guaranteed that at least one of the 168
  * bits is cleared.
+ *
+ * #if MAX_RT_PRIO != 128 || MAX_PRIO != 168
+ * # error update this function.
+ * #endif
  */
-#if MAX_RT_PRIO != 128 || MAX_PRIO != 168
-# error update this function.
-#endif
 
 static inline int sched_find_first_bit(unsigned long *b)
 {




--- sched.c.old	Wed Feb 20 09:38:37 2002
+++ sched.c	Wed Feb 20 09:39:15 2002
@@ -437,7 +437,7 @@
 	}
 
 	/* Here we just switch the register state and the stack. */
-	switch_to(prev, next);
+	switch_to(prev, next, prev);
 }
 
 unsigned long nr_running(void
