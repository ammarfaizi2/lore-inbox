Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271973AbTHDRIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271966AbTHDRH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:07:28 -0400
Received: from tandu.perlsupport.com ([66.220.6.226]:28359 "EHLO
	tandu.perlsupport.com") by vger.kernel.org with ESMTP
	id S271968AbTHDRGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:06:52 -0400
Date: Mon, 4 Aug 2003 13:06:53 -0400
From: Chip Salzenberg <chip@pobox.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030804170653.GA7537@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GCC is warning about a pointer-to-int conversion when the likely() and
unlikely() macros are used with pointer values.  So, for architectures
where pointers are larger than 'int', I suggest this patch.

PS: This patch was made against 2.4.22pre10 plus many patches from the
'aa' kernel series, so it should be considered an example of the patch
that might be required in other kernel versions.

Index: linux/include/linux/compiler.h
--- linux/include/linux/compiler.h.old	2001-09-18 17:12:45.000000000 -0400
+++ linux/include/linux/compiler.h	2003-08-04 12:24:15.000000000 -0400
@@ -11,6 +11,8 @@
 #endif
 
-#define likely(x)	__builtin_expect((x),1)
-#define unlikely(x)	__builtin_expect((x),0)
+#define likely(x)	__builtin_expect((x),      1)
+#define likely_p(x)	__builtin_expect((x) != 0, 1)
+#define unlikely(x)	__builtin_expect((x)      ,0)
+#define unlikely_p(x)	__builtin_expect((x) != 0 ,0)
 
 #endif /* __LINUX_COMPILER_H */

Index: linux/kernel/sched.c
--- linux/kernel/sched.c.old	2003-08-04 12:09:47.000000000 -0400
+++ linux/kernel/sched.c	2003-08-04 12:25:44.000000000 -0400
@@ -477,5 +477,5 @@
 	if (unlikely(!prev->mm)) {
 		prev->active_mm = NULL;
-		if (unlikely(rq->prev_mm)) {
+		if (unlikely_p(rq->prev_mm)) {
 			printk(KERN_ERR "rq->prev_mm was %p set to %p - %s\n", rq->prev_mm, oldmm, current->comm);
 			dump_stack();

Index: linux/mm/filemap.c
--- linux/mm/filemap.c.old	2003-08-04 12:09:41.000000000 -0400
+++ linux/mm/filemap.c	2003-08-04 12:27:07.000000000 -0400
@@ -3749,5 +3749,5 @@
 		pr_debug("attempting to read %lu\n", page->index);
 		io->did_read = 1;
-		if (likely(page->mapping)) {
+		if (likely_p(page->mapping)) {
 			locked = 0;
 			io->err = page->mapping->a_ops->readpage(io->file, page);
@@ -3813,5 +3813,5 @@
 		 */
 		if (!TryLockPage(page)) {
-			if (likely(page->mapping)) {
+			if (likely_p(page->mapping)) {
 				int ret = readpage(io->file, page);
 				if (ret)



-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
