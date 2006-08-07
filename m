Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWHGMmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWHGMmc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 08:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWHGMmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 08:42:32 -0400
Received: from mail.suse.de ([195.135.220.2]:9453 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932111AbWHGMmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 08:42:31 -0400
Date: Mon, 7 Aug 2006 14:42:29 +0200
From: Jan Blunck <jblunck@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [PATCH] fix vmstat per cpu usage
Message-ID: <20060807124229.GS4995@hasse.suse.de>
References: <20060801173620.GM4995@hasse.suse.de> <20060801140707.a55a0513.akpm@osdl.org> <20060802133006.GP4995@hasse.suse.de> <20060802074308.babd264e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <20060802074308.babd264e.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 02, Andrew Morton wrote:

> > +#define per_cpu(var, cpu) (*({				\
> > +	int user_error_##var __attribute__ ((unused));	\
> > +	RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]); }))
> 
> What's it do?  Forces a syntax error if `var' isn't a simple identifier?
> 
> Seems sane, although I'd check that the compiler doesn't accidentally
> waste a stack slot for that local.  Perhaps it's be safer to make
> it a non-existing function:
> 
> 	extern int user_error#var(void);
> 

Yes, that is even better. See attached patch with the modifications for my
major archs (s390, x86-64, generic). I did a run of 'make allmodconfig' with
the attached patch and it produced some errors. I'll send the patches in a
seperate mail.

--48TaNjbzBVislYPb
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="percpu-simple-identifier-error.diff"

From: Jan Blunck <jblunck@suse.de>
Subject: trigger a syntax error if percpu macros are incorrectly used

get_cpu_var()/per_cpu()/__get_cpu_var() arguments must be simple identifiers.
Otherwise the arch dependant implementations might break. This patch enforces
the correct usage of the macros by producing a syntax error if the variable is
not a simple identifier.

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 include/asm-generic/percpu.h |    4 +++-
 include/asm-s390/percpu.h    |   20 +++++++++++---------
 include/asm-x86_64/percpu.h  |   12 +++++++++---
 include/linux/percpu.h       |   10 ++++++++--
 4 files changed, 31 insertions(+), 15 deletions(-)

Index: linux-2.6/include/asm-generic/percpu.h
===================================================================
--- linux-2.6.orig/include/asm-generic/percpu.h
+++ linux-2.6/include/asm-generic/percpu.h
@@ -14,7 +14,9 @@ extern unsigned long __per_cpu_offset[NR
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
 
 /* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
+#define per_cpu(var, cpu) (*({				\
+	extern int simple_indentifier_##var(void);	\
+	RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]); }))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 #define __raw_get_cpu_var(var) per_cpu(var, raw_smp_processor_id())
 
Index: linux-2.6/include/asm-s390/percpu.h
===================================================================
--- linux-2.6.orig/include/asm-s390/percpu.h
+++ linux-2.6/include/asm-s390/percpu.h
@@ -15,18 +15,20 @@
  */
 #if defined(__s390x__) && defined(MODULE)
 
-#define __reloc_hide(var,offset) \
-  (*({ unsigned long *__ptr; \
-       asm ( "larl %0,per_cpu__"#var"@GOTENT" \
-             : "=a" (__ptr) : "X" (per_cpu__##var) ); \
-       (typeof(&per_cpu__##var))((*__ptr) + (offset)); }))
+#define __reloc_hide(var,offset) (*({			\
+	extern int simple_indentifier_##var(void);	\
+	unsigned long *__ptr;				\
+	asm ( "larl %0,per_cpu__"#var"@GOTENT"		\
+	    : "=a" (__ptr) : "X" (per_cpu__##var) );	\
+	(typeof(&per_cpu__##var))((*__ptr) + (offset));	}))
 
 #else
 
-#define __reloc_hide(var, offset) \
-  (*({ unsigned long __ptr; \
-       asm ( "" : "=a" (__ptr) : "0" (&per_cpu__##var) ); \
-       (typeof(&per_cpu__##var)) (__ptr + (offset)); }))
+#define __reloc_hide(var, offset) (*({				\
+	extern int simple_indentifier_##var(void);		\
+	unsigned long __ptr;					\
+	asm ( "" : "=a" (__ptr) : "0" (&per_cpu__##var) );	\
+	(typeof(&per_cpu__##var)) (__ptr + (offset)); }))
 
 #endif
 
Index: linux-2.6/include/asm-x86_64/percpu.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/percpu.h
+++ linux-2.6/include/asm-x86_64/percpu.h
@@ -21,9 +21,15 @@
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
 
 /* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset(cpu)))
-#define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
-#define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
+#define per_cpu(var, cpu) (*({				\
+	extern int simple_indentifier_##var(void);	\
+	RELOC_HIDE(&per_cpu__##var, __per_cpu_offset(cpu)); }))
+#define __get_cpu_var(var) (*({				\
+	extern int simple_indentifier_##var(void);	\
+	RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()); }))
+#define __raw_get_cpu_var(var) (*({			\
+	extern int simple_indentifier_##var(void);	\
+	RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()); }))
 
 /* A macro to avoid #include hell... */
 #define percpu_modcopy(pcpudst, src, size)			\
Index: linux-2.6/include/linux/percpu.h
===================================================================
--- linux-2.6.orig/include/linux/percpu.h
+++ linux-2.6/include/linux/percpu.h
@@ -11,8 +11,14 @@
 #define PERCPU_ENOUGH_ROOM 32768
 #endif
 
-/* Must be an lvalue. */
-#define get_cpu_var(var) (*({ preempt_disable(); &__get_cpu_var(var); }))
+/*
+ * Must be an lvalue. Since @var must be a simple identifier,
+ * we force a syntax error here if it isn't.
+ */
+#define get_cpu_var(var) (*({				\
+	extern int simple_indentifier_##var(void);	\
+	preempt_disable();				\
+	&__get_cpu_var(var); }))
 #define put_cpu_var(var) preempt_enable()
 
 #ifdef CONFIG_SMP

--48TaNjbzBVislYPb--
