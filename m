Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSG3UOi>; Tue, 30 Jul 2002 16:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSG3UOi>; Tue, 30 Jul 2002 16:14:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8090 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316390AbSG3UOg>;
	Tue, 30 Jul 2002 16:14:36 -0400
Date: Tue, 30 Jul 2002 22:16:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sanitize TLS API
In-Reply-To: <20020730160631.R1596@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0207302214140.24227-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Jul 2002, Jakub Jelinek wrote:

> Actually, is the clear operation really necessary? IMHO the best clear
> is movw $0x03, %gs, then all accesses through %gs will trap. Calling
> set_thread_area (0, 1); will result in 0xb segment acting exactly like
> %ds or %es.

indeed. I've attached a (tested) patch against BK-curr that removes just
the clear operation. I've left the flags mask and the writable flag just
so that we have the option to introduce extensions without breaking the
ABI.

	Ingo

--- linux/arch/i386/kernel/process.c.orig	Tue Jul 30 22:13:43 2002
+++ linux/arch/i386/kernel/process.c	Tue Jul 30 22:13:52 2002
@@ -851,17 +851,6 @@
 	if (flags & ~TLS_FLAGS_MASK)
 		return -EINVAL;
 
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
 	if (flags & TLS_FLAG_WRITABLE)
 		writable = 1;
 
--- linux/include/asm-i386/desc.h.orig	Tue Jul 30 22:14:10 2002
+++ linux/include/asm-i386/desc.h	Tue Jul 30 22:14:27 2002
@@ -86,10 +86,9 @@
 	_set_tssldt_desc(&cpu_gdt_table[cpu][LDT_ENTRY], (int)addr, ((size << 3)-1), 0x82);
 }
 
-#define TLS_FLAGS_MASK			0x00000003
+#define TLS_FLAGS_MASK			0x00000001
 
 #define TLS_FLAG_WRITABLE		0x00000001
-#define TLS_FLAG_CLEAR			0x00000002
 
 static inline void load_TLS_desc(struct thread_struct *t, unsigned int cpu)
 {
--- linux/include/asm-i386/unistd.h.orig	Tue Jul 30 22:14:40 2002
+++ linux/include/asm-i386/unistd.h	Tue Jul 30 22:15:05 2002
@@ -247,6 +247,7 @@
 #define __NR_futex		240
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
+#define __NR_set_thread_area	243
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 

