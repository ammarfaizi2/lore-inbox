Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWHBNaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWHBNaJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 09:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWHBNaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 09:30:09 -0400
Received: from cantor2.suse.de ([195.135.220.15]:22980 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751126AbWHBNaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 09:30:07 -0400
Date: Wed, 2 Aug 2006 15:30:06 +0200
From: Jan Blunck <jblunck@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] fix vmstat per cpu usage
Message-ID: <20060802133006.GP4995@hasse.suse.de>
References: <20060801173620.GM4995@hasse.suse.de> <20060801140707.a55a0513.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <20060801140707.a55a0513.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here comes another idea. To find further wrong usage of percpu variables I
wrote the following patch. It still needs some work for the other archs but
I'm interested in your feedback about that.

Jan

--Y5rl02BVI9TCfPar
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="percpu_var-error.diff"

---
 include/asm-generic/percpu.h |    4 +++-
 include/asm-s390/percpu.h    |    6 ++++--
 include/linux/percpu.h       |    5 ++++-
 3 files changed, 11 insertions(+), 4 deletions(-)

Index: linux-2.6/include/asm-generic/percpu.h
===================================================================
--- linux-2.6.orig/include/asm-generic/percpu.h
+++ linux-2.6/include/asm-generic/percpu.h
@@ -14,7 +14,9 @@ extern unsigned long __per_cpu_offset[NR
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
 
 /* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
+#define per_cpu(var, cpu) (*({				\
+	int user_error_##var __attribute__ ((unused));	\
+	RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]); }))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 #define __raw_get_cpu_var(var) per_cpu(var, raw_smp_processor_id())
 
Index: linux-2.6/include/asm-s390/percpu.h
===================================================================
--- linux-2.6.orig/include/asm-s390/percpu.h
+++ linux-2.6/include/asm-s390/percpu.h
@@ -16,7 +16,8 @@
 #if defined(__s390x__) && defined(MODULE)
 
 #define __reloc_hide(var,offset) \
-  (*({ unsigned long *__ptr; \
+  (*({ int user_error_##var __attribute__ ((unused)); \
+       unsigned long *__ptr; \
        asm ( "larl %0,per_cpu__"#var"@GOTENT" \
              : "=a" (__ptr) : "X" (per_cpu__##var) ); \
        (typeof(&per_cpu__##var))((*__ptr) + (offset)); }))
@@ -24,7 +25,8 @@
 #else
 
 #define __reloc_hide(var, offset) \
-  (*({ unsigned long __ptr; \
+  (*({ int user_error_##var __attribute__ ((unused)); \
+       unsigned long __ptr; \
        asm ( "" : "=a" (__ptr) : "0" (&per_cpu__##var) ); \
        (typeof(&per_cpu__##var)) (__ptr + (offset)); }))
 
Index: linux-2.6/include/linux/percpu.h
===================================================================
--- linux-2.6.orig/include/linux/percpu.h
+++ linux-2.6/include/linux/percpu.h
@@ -12,7 +12,10 @@
 #endif
 
 /* Must be an lvalue. */
-#define get_cpu_var(var) (*({ preempt_disable(); &__get_cpu_var(var); }))
+#define get_cpu_var(var) (*({				\
+	int user_error_##var __attribute__ ((unused));	\
+	preempt_disable();				\
+	&__get_cpu_var(var); }))
 #define put_cpu_var(var) preempt_enable()
 
 #ifdef CONFIG_SMP

--Y5rl02BVI9TCfPar--
