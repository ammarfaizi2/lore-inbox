Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUGLSl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUGLSl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUGLSl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 14:41:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:24295 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261300AbUGLSly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 14:41:54 -0400
Date: Mon, 12 Jul 2004 11:40:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: geert@linux-m68k.org, torvalds@osdl.org, dhowells@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: struct_cpy() and kAFS (was: Re: Linux 2.6.8-rc1)
Message-Id: <20040712114026.7e034cf2.akpm@osdl.org>
In-Reply-To: <20040712182315.GA28281@infradead.org>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
	<Pine.GSO.4.58.0407121519380.17199@waterleaf.sonytel.be>
	<20040712111120.2094f089.akpm@osdl.org>
	<20040712182315.GA28281@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> struct_cpy is used nowehre except in arch/i386/kernel/process.c and AFS,
>  so we should probably better kill it before people start using it in other
>  places.

yup.

diff -puN arch/i386/kernel/process.c~remove-struct_cpy arch/i386/kernel/process.c
--- 25/arch/i386/kernel/process.c~remove-struct_cpy	2004-07-12 11:39:05.821241928 -0700
+++ 25-akpm/arch/i386/kernel/process.c	2004-07-12 11:39:38.202319256 -0700
@@ -355,7 +355,7 @@ int copy_thread(int nr, unsigned long cl
 	int err;
 
 	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
-	struct_cpy(childregs, regs);
+	*childregs = *regs;
 	childregs->eax = 0;
 	childregs->esp = esp;
 	p->set_child_tid = p->clear_child_tid = NULL;
diff -puN include/asm-x86_64/string.h~remove-struct_cpy include/asm-x86_64/string.h
--- 25/include/asm-x86_64/string.h~remove-struct_cpy	2004-07-12 11:39:05.862235696 -0700
+++ 25-akpm/include/asm-x86_64/string.h	2004-07-12 11:39:43.049582360 -0700
@@ -3,8 +3,6 @@
 
 #ifdef __KERNEL__
 
-#define struct_cpy(x,y) (*(x)=*(y))
-
 /* Written 2002 by Andi Kleen */ 
 
 /* Only used for special circumstances. Stolen from i386/string.h */ 
diff -puN include/asm-i386/string.h~remove-struct_cpy include/asm-i386/string.h
--- 25/include/asm-i386/string.h~remove-struct_cpy	2004-07-12 11:39:05.885232200 -0700
+++ 25-akpm/include/asm-i386/string.h	2004-07-12 11:39:52.558136840 -0700
@@ -277,22 +277,6 @@ static __inline__ void *__memcpy3d(void 
 
 #endif
 
-/*
- * struct_cpy(x,y), copy structure *x into (matching structure) *y.
- *
- * We get link-time errors if the structure sizes do not match.
- * There is no runtime overhead, it's all optimized away at
- * compile time.
- */
-extern void __struct_cpy_bug (void);
-
-#define struct_cpy(x,y) 			\
-({						\
-	if (sizeof(*(x)) != sizeof(*(y))) 	\
-		__struct_cpy_bug();		\
-	memcpy(x, y, sizeof(*(x)));		\
-})
-
 #define __HAVE_ARCH_MEMMOVE
 void *memmove(void * dest,const void * src, size_t n);
 
_

