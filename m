Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUANQuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 11:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUANQuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 11:50:50 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:24276 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S262153AbUANQuq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 11:50:46 -0500
Date: Wed, 14 Jan 2004 09:50:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: setjmp/longjmp hooks for kgdb 2.0.2
Message-ID: <20040114165034.GB17509@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  I'm currently starting down the road to adding PPC32 support to
kgdb 2.0.x.  The first patch I've got for you adds in hooks to allow for
doing setjmp/longjmp, if the arch wants to do so.  This isn't tested,
yet (I haven't gotten that far in fixing ppc32 backend bits) but should
be OK.  Comments?

===== include/linux/kgdb.h 1.1 vs edited =====
--- 1.1/include/linux/kgdb.h	Tue Jan 13 11:09:23 2004
+++ edited/include/linux/kgdb.h	Wed Jan 14 09:02:54 2004
@@ -81,6 +81,10 @@
 	int  (*remove_break) (unsigned long addr, int type);
 	void (*correct_hw_break) (void);
 	void (*handler_exit) (void);
+	void (*setjmp) (long *buf);
+	void (*longjmp) (long *buf, int val);
+	void (*clearjmp) (void);
+	int  (*issetjmp) (void);
 	void (*shadowinfo)(struct pt_regs *regs, char *buffer, unsigned threadid);
 	struct task_struct *(*get_shadow_thread)(struct pt_regs *regs, int threadid);
 	struct pt_regs *(*shadow_regs)(struct pt_regs *regs, int threadid);
===== kernel/kgdbstub.c 1.1 vs edited =====
--- 1.1/kernel/kgdbstub.c	Tue Jan 13 11:09:24 2004
+++ edited/kernel/kgdbstub.c	Wed Jan 14 09:02:33 2004
@@ -72,6 +72,7 @@
 int kgdb_initialized = 0;
 int kgdb_enter = 0;
 static const char hexchars[] = "0123456789abcdef";
+static u_int fault_jmp_buf[100];
 
 int get_char(char *addr, unsigned char *data, int can_fault);
 int set_char(char *addr, int data, int can_fault);
@@ -255,6 +256,9 @@
 	int i;
 	unsigned char ch;
 	
+	if (kgdb_ops->setjmp)
+		kgdb_ops->setjmp((long *)fault_jmp_buf);
+
 	for (i = 0; i < count; i++) {
 
 		if (get_char(mem++, &ch, can_fault) < 0) 
@@ -263,6 +267,10 @@
 		*buf++ = hexchars[ch >> 4];
 		*buf++ = hexchars[ch % 16];
 	}
+
+	if (kgdb_ops->clearjmp)
+		kgdb_ops->clearjmp();
+
 	*buf = 0;
 	return (buf);
 }
@@ -275,12 +283,19 @@
 	int i;
 	unsigned char ch;
 	
+	if (kgdb_ops->setjmp)
+		kgdb_ops->setjmp((long *)fault_jmp_buf);
+
 	for (i = 0; i < count; i++) {
 		ch = hex(*buf++) << 4;
 		ch = ch + hex(*buf++);
 		if (set_char(mem++, ch, can_fault) < 0) 
 			break;
 	}
+
+	if (kgdb_ops->clearjmp)
+		kgdb_ops->clearjmp();
+
 	return (mem);
 }
 
@@ -295,6 +310,9 @@
 
 	*longValue = 0;
 
+	if (kgdb_ops->setjmp)
+		kgdb_ops->setjmp((long *)fault_jmp_buf);
+
 	while (**ptr) {
 		hexValue = hex(**ptr);
 		if (hexValue >= 0) {
@@ -306,6 +324,9 @@
 		(*ptr)++;
 	}
 
+	if (kgdb_ops->clearjmp)
+		kgdb_ops->clearjmp();
+
 	return (numChars);
 }
 
@@ -579,6 +600,11 @@
 	static char tmpstr[256];
 	int numshadowth = num_online_cpus() + kgdb_ops->shadowth;
 	int kgdb_usethreadid = 0;
+
+	if (kgdb_ops->issetjmp && kgdb_ops->issetjmp()) {
+		kgdb_ops->longjmp((long*)fault_jmp_buf, 1);
+		panic("longjmp failed!");
+	}
 
 	/* 
 	 * Interrupts will be restored by the 'trap return' code, except when

Also, how should I send a patch that touches both things in the core,
i386 and x86_64 patches (# HW breakpoints is arch-dependant.) ?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
