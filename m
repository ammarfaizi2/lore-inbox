Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTDZXeL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 19:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTDZXeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 19:34:11 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:43098 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263077AbTDZXeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 19:34:10 -0400
Date: Sat, 26 Apr 2003 16:46:21 -0700
Message-Id: <200304262346.h3QNkL129881@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] allow ptrace and /proc/PID/mem to read fixmap pages
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Symbolical gumption soft-serve
   (2) Fluent miscreants
   (3) Irritating metronomes
   (4) Radioactive concussions
   (5) Rebellious recalcitrant circumcision carrion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a problem now that ptrace and /proc/PID/mem pretend the vsyscall page
does not exist, and won't let you read it from the inferior.  In fact you
can read it from yourself, but programs like a debugger should not have to
know about such magic addresses.  I think access_process_vm ought to give
you access to all of the process's adddress space.

This patch is i386-specific and should probably be done another way, but
it's what I am using now.  It works and is well-tested. 


Thanks,
Roland


--- stock-2.5.68/kernel/ptrace.c	Sat Apr 19 19:51:21 2003
+++ linux-2.5.68/kernel/ptrace.c	Wed Apr 23 12:39:52 2003
@@ -201,6 +201,25 @@ int access_process_vm(struct task_struct
 	up_read(&mm->mmap_sem);
 	mmput(mm);
 	
+#ifdef FIXADDR_START
+	while (len > 0 && addr < FIXADDR_TOP && addr >= FIXADDR_START) {
+		unsigned long pg = addr & PAGE_MASK;
+		int bytes = (len < pg + PAGE_SIZE - addr
+			     ? len : pg + PAGE_SIZE - addr);
+		pte_t *pte = pte_offset_kernel(pmd_offset(pgd_offset_k(pg),
+							  pg), pg);
+		if (!pte_read(*pte) || (write && !pte_write(*pte)))
+			break;
+		if (write)
+			memcpy((void *)addr, buf, bytes);
+		else
+			memcpy(buf, (const void *)addr, bytes);
+		len -= bytes;
+		buf += bytes;
+		addr += bytes;
+	}
+#endif
+
 	return buf - old_buf;
 }
 
