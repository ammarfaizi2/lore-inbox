Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbUBBFnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 00:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265627AbUBBFnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 00:43:52 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:62443 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S265624AbUBBFnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 00:43:49 -0500
Date: Sun, 1 Feb 2004 21:43:42 -0800
Message-Id: <200402020543.i125hgoa009640@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Daniel Jacobowitz <dan@debian.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc3 broke ptrace in the vsyscall dso area
In-Reply-To: Daniel Jacobowitz's message of  Sunday, 1 February 2004 22:55:08 -0500 <20040202035508.GA10286@nevyn.them.org>
X-Windows: garbage at your fingertips.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any idea what might have disabled this?

...Mosberger!!  When Andrew asked me to sign off on David's rework of that
code, I did so with the caveat that it be tested on i386 before being
accepted, and evidently it never was.

The #include is the part of this patch that matters, so the #ifdef below
works.  (Frankly, I have never seen the rationale for conditionalizing this
code on AT_SYSINFO_EHDR rather than just FIXADDR_USER_START.  But David
wanted it that way and Andrew approved it.)  The rest of the patch removes
gratuitous duplication due to some strange aversion to concision in the
presence of #ifdef, the kind that is all too common, utterly pointless, and
error prone.


Thanks,
Roland


Index: linux-2.6/include/linux/mm.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/linux/mm.h,v
retrieving revision 1.137
diff -p -u -r1.137 mm.h
--- linux-2.6/include/linux/mm.h 20 Jan 2004 05:12:38 -0000 1.137
+++ linux-2.6/include/linux/mm.h 2 Feb 2004 05:20:11 -0000
@@ -12,6 +12,7 @@
 #include <linux/mmzone.h>
 #include <linux/rbtree.h>
 #include <linux/fs.h>
+#include <linux/elf.h>
 
 #ifndef CONFIG_DISCONTIGMEM          /* Don't use mapnrs, do it properly */
 extern unsigned long max_mapnr;
@@ -643,31 +644,24 @@ kernel_map_pages(struct page *page, int 
 #endif
 
 #ifndef CONFIG_ARCH_GATE_AREA
-#ifdef AT_SYSINFO_EHDR
 static inline int in_gate_area(struct task_struct *task, unsigned long addr)
 {
+#ifdef AT_SYSINFO_EHDR
 	if ((addr >= FIXADDR_USER_START) && (addr < FIXADDR_USER_END))
 		return 1;
-	else
-		return 0;
+#endif
+	return 0;
 }
 
 extern struct vm_area_struct gate_vma;
 static inline struct vm_area_struct *get_gate_vma(struct task_struct *tsk)
 {
+#ifdef AT_SYSINFO_EHDR
 	return &gate_vma;
-}
 #else
-static inline int in_gate_area(struct task_struct *task, unsigned long addr)
-{
 	return 0;
-}
-
-static inline struct vm_area_struct *get_gate_vma(struct task_struct *tsk)
-{
-	return NULL;
-}
 #endif
+}
 #endif
 
 #endif /* __KERNEL__ */
