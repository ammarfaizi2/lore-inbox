Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318311AbSG3Pkj>; Tue, 30 Jul 2002 11:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318307AbSG3Pki>; Tue, 30 Jul 2002 11:40:38 -0400
Received: from verein.lst.de ([212.34.181.86]:2067 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S318305AbSG3Pkg>;
	Tue, 30 Jul 2002 11:40:36 -0400
Date: Tue, 30 Jul 2002 17:43:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sanitize TLS API
Message-ID: <20020730174336.A18385@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently sys_set_thread_area has a magic flags argument that might
change it's behaivour completly.

Split out the TLS_FLAG_CLEAR case that has nothing in common with the
rest into it's own syscall, sys_clear_thread_area and change the
second argument to int writable.


--- 1.39/arch/i386/kernel/entry.S	Tue Jul 30 00:08:08 2002
+++ edited/arch/i386/kernel/entry.S	Tue Jul 30 11:46:01 2002
@@ -753,6 +753,7 @@
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
 	.long sys_set_thread_area
+	.long sys_clear_thread_area
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
--- 1.29/arch/i386/kernel/process.c	Mon Jul 29 04:07:12 2002
+++ edited/arch/i386/kernel/process.c	Tue Jul 30 12:34:21 2002
@@ -831,38 +831,15 @@
 /*
  * Set the Thread-Local Storage area:
  */
-asmlinkage int sys_set_thread_area(unsigned long base, unsigned long flags)
+asmlinkage int sys_set_thread_area(unsigned long base, int writable)
 {
 	struct thread_struct *t = &current->thread;
-	int writable = 0;
-	int cpu;
+	int cpu = get_cpu();
 
-	/* do not allow unused flags */
-	if (flags & ~TLS_FLAGS_MASK)
-		return -EINVAL;
-
-	/*
-	 * Clear the TLS?
-	 */
-	if (flags & TLS_FLAG_CLEAR) {
-		cpu = get_cpu();
-        	t->tls_desc.a = t->tls_desc.b = 0;
-		load_TLS_desc(t, cpu);
-		put_cpu();
-		return 0;
-	}
-
-	if (flags & TLS_FLAG_WRITABLE)
-		writable = 1;
-
-	/*
-	 * We must not get preempted while modifying the TLS.
-	 */
-	cpu = get_cpu();
+	writable = !!writable; /* must be one or zero */
 
-        t->tls_desc.a = ((base & 0x0000ffff) << 16) | 0xffff;
-
-        t->tls_desc.b = (base & 0xff000000) | ((base & 0x00ff0000) >> 16) |
+	t->tls_desc.a = ((base & 0x0000ffff) << 16) | 0xffff;
+	t->tls_desc.b = (base & 0xff000000) | ((base & 0x00ff0000) >> 16) |
 				0xf0000 | (writable << 9) | (1 << 15) |
 					(1 << 22) | (1 << 23) | 0x7000;
 
@@ -872,3 +849,17 @@
 	return TLS_ENTRY*8 + 3;
 }
 
+
+/*
+ * Clear the Thread-Local Storage area:
+ */
+asmlinkage void sys_clear_thread_area(void)
+{
+	struct thread_struct *t = &current->thread;
+	int cpu = get_cpu();
+
+	t->tls_desc.a = t->tls_desc.b = 0;
+	load_TLS_desc(t, cpu);
+
+	put_cpu();
+}
--- 1.7/include/asm-i386/desc.h	Mon Jul 29 04:07:52 2002
+++ edited/include/asm-i386/desc.h	Tue Jul 30 11:48:40 2002
@@ -86,11 +86,6 @@
 	_set_tssldt_desc(&cpu_gdt_table[cpu][LDT_ENTRY], (int)addr, ((size << 3)-1), 0x82);
 }
 
-#define TLS_FLAGS_MASK			0x00000003
-
-#define TLS_FLAG_WRITABLE		0x00000001
-#define TLS_FLAG_CLEAR			0x00000002
-
 static inline void load_TLS_desc(struct thread_struct *t, unsigned int cpu)
 {
 	cpu_gdt_table[cpu][TLS_ENTRY] = t->tls_desc;
--- 1.11/include/asm-i386/unistd.h	Tue Jul 30 00:08:09 2002
+++ edited/include/asm-i386/unistd.h	Tue Jul 30 11:47:20 2002
@@ -247,6 +247,8 @@
 #define __NR_futex		240
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
+#define __NR_set_thread_area	243
+#define __NR_clear_thread_area	244
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
