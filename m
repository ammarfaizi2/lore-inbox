Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265076AbUELAPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265076AbUELAPR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbUELANH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:13:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:10933 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265087AbUELAH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:07:59 -0400
Date: Tue, 11 May 2004 17:10:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH} H8/300 update (2/9) ldscripts fix
Message-Id: <20040511171032.12c2f024.akpm@osdl.org>
In-Reply-To: <m2zn8erkdv.wl%ysato@users.sourceforge.jp>
References: <m2zn8erkdv.wl%ysato@users.sourceforge.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoshinori Sato <ysato@users.sourceforge.jp> wrote:
>
> - symbol prefix (use h8300 and v850) support
> - include headers

This generates a reject agaisnt Linus's current
include/asm-generic/vmlinux.lds.h due to post-2.6.6 changes.

I fixed it up as below.

But I am wondering about this:

  #define SECURITY_INIT							\
  	.security_initcall.init : {					\
+ 		SYMBOL(__security_initcall_start) = .;			\
  		*(.security_initcall.init) 				\
  		__security_initcall_end = .;				\
  	}

Shouldn't __security_initcall_end also have a SYMBOL() wrapper?




From: Yoshinori Sato <ysato@users.sourceforge.jp>

- symbol prefix (use h8300 and v850) support
- include headers


---

 25-akpm/arch/h8300/kernel/vmlinux.lds.S   |    2 ++
 25-akpm/include/asm-generic/vmlinux.lds.h |   30 +++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff -puN arch/h8300/kernel/vmlinux.lds.S~h8-300-update-2-9-ldscripts-fix arch/h8300/kernel/vmlinux.lds.S
--- 25/arch/h8300/kernel/vmlinux.lds.S~h8-300-update-2-9-ldscripts-fix	Tue May 11 17:06:30 2004
+++ 25-akpm/arch/h8300/kernel/vmlinux.lds.S	Tue May 11 17:06:30 2004
@@ -1,3 +1,5 @@
+#include <asm-generic/vmlinux.lds.h>
+#include <asm/thread_info.h>
 #include <linux/config.h>
 
 #ifdef CONFIG_H8300H_GENERIC
diff -puN include/asm-generic/vmlinux.lds.h~h8-300-update-2-9-ldscripts-fix include/asm-generic/vmlinux.lds.h
--- 25/include/asm-generic/vmlinux.lds.h~h8-300-update-2-9-ldscripts-fix	Tue May 11 17:06:30 2004
+++ 25-akpm/include/asm-generic/vmlinux.lds.h	Tue May 11 17:08:18 2004
@@ -1,7 +1,15 @@
+#include <linux/config.h>
+
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
 #endif
 
+#if defined(CONFIG_H8300) || defined(CONFIG_V850)
+#define SYMBOL(_sym_) _##_sym_
+#else
+#define SYMBOL(_sym_) _sym_
+#endif
+
 #define RODATA								\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		*(.rodata) *(.rodata.*)					\
@@ -14,30 +22,30 @@
 									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
-		__start___ksymtab = .;					\
+		SYMBOL(__start___ksymtab) = .;				\
 		*(__ksymtab)						\
-		__stop___ksymtab = .;					\
+		SYMBOL(__stop___ksymtab) = .;				\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
 	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
-		__start___ksymtab_gpl = .;				\
+		SYMBOL(__start___ksymtab_gpl) = .;			\
 		*(__ksymtab_gpl)					\
-		__stop___ksymtab_gpl = .;				\
+		SYMBOL(__stop___ksymtab_gpl) = .;			\
 	}								\
 									\
 	/* Kernel symbol table: Normal symbols */			\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
-		__start___kcrctab = .;					\
+		SYMBOL(__start___kcrctab) = .;				\
 		*(__kcrctab)						\
-		__stop___kcrctab = .;					\
+		SYMBOL(__stop___kcrctab) = .;				\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
 	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
-		__start___kcrctab_gpl = .;				\
+		SYMBOL(__start___kcrctab_gpl) = .;			\
 		*(__kcrctab_gpl)					\
-		__stop___kcrctab_gpl = .;				\
+		SYMBOL(__stop___kcrctab_gpl) = .;			\
 	}								\
 									\
 	/* Kernel symbol table: strings */				\
@@ -47,12 +55,12 @@
 
 #define SECURITY_INIT							\
 	.security_initcall.init : {					\
-		__security_initcall_start = .;				\
+		SYMBOL(__security_initcall_start) = .;			\
 		*(.security_initcall.init) 				\
 		__security_initcall_end = .;				\
 	}
 
 #define SCHED_TEXT							\
-		__sched_text_start = .;					\
+		SYMBOL(__sched_text_start) = .;				\
 		*(.sched.text)						\
-		__sched_text_end = .;
+		SYMBOL(__sched_text_end) = .;

_

