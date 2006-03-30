Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWC3TZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWC3TZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWC3TZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:25:26 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:27666 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750780AbWC3TZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:25:25 -0500
Message-ID: <442C30A4.3010207@vmware.com>
Date: Thu, 30 Mar 2006 11:25:24 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pazke@donpac.ru, James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] Cleanup subarch definitions in Linux/i386
References: <442B5BF8.5000502@vmware.com> <20060330080025.GC14724@sorel.sous-sol.org>
In-Reply-To: <20060330080025.GC14724@sorel.sous-sol.org>
Content-Type: multipart/mixed;
 boundary="------------000502060207050202090305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000502060207050202090305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
>   
>> Comments, suggestions, anything welcome.  I think this is a much cleaner 
>> approach, and both new and existing sub-architectures will benefit.  I 
>> am sorry this patch is so large, but it is very difficult to separate 
>> into multiple steps that still allow all the subarches to compile.
>>     

Thanks for looking over these.  There is a bit more cleanup on top of 
this, mostly due to the include mess.  I have attached another patch.

> Zach, looks nice.  Saves Xen a partial copy of setup.c.  Did you have
> further/similar consolidations in mind?
>   

Exactly.
>   
>> --- linux-2.6.16.1.orig/arch/i386/Makefile	2006-03-29 19:38:47.000000000 -0800
>> +++ linux-2.6.16.1/arch/i386/Makefile	2006-03-29 19:38:54.000000000 -0800
>> @@ -45,37 +45,32 @@ CFLAGS				+= $(shell if [ $(call cc-vers
>>  
>>  CFLAGS += $(cflags-y)
>>  
>> -# Default subarch .c files
>> -mcore-y  := mach-default
>> +# Default subarch .c files (none)
>> +mcore-y  := 
>>  
>>  # Voyager subarch support
>>  mflags-$(CONFIG_X86_VOYAGER)	:= -Iinclude/asm-i386/mach-voyager
>> -mcore-$(CONFIG_X86_VOYAGER)	:= mach-voyager
>> +mcore-$(CONFIG_X86_VOYAGER)	:= arch/i386/mach-voyager/
>>     
>
> Is this intended to make way for possible fine tuning?  Smth like:
>
> mcore-$(CONFIG_X86_VOYAGER)	+= arch/i386/another_default.o
> (hmm, not sure if that would even work)
>
> Or just an aesthetic change?
>   

No - it was required in order to leave the subarch blank for the default 
case.  Including "arch/i386//" wasn't so happy in the makefile.

>   
>> --- linux-2.6.16.1.orig/include/asm-i386/acpi.h	2006-03-29 19:38:47.000000000 -0800
>> +++ linux-2.6.16.1/include/asm-i386/acpi.h	2006-03-29 19:38:54.000000000 -0800
>> @@ -31,6 +31,7 @@
>>  #include <acpi/pdc_intel.h>
>>  
>>  #include <asm/system.h>		/* defines cmpxchg */
>> +#include <asm/processor.h>	/* defines boot_cpu_data */
>>     
>
> that one necessary?
>   

Needed for mach-generic subarch to compile with CPU defined as I386 -- 
the definition of cmpxchg on older CPUs depends on boot_cpu_data.  
Removing this opens a giant rat hole.  This ginourmous rat hole is quite 
annoying.  What goes in system.h vs. processor.h is so poorly defined.  
I had to hoist boot_cpu_data into system.h as the cleanest way to fix 
this without introducing circular dependencies - processor.h already 
depends on system.h for alternative_input(), read_cr4(), write_cr4(), 
write_cr3(), and there is no end to this mess.  Trying to move dependent 
processor.h pieces into system.h didn't work, since the include/linux 
headers make the assumption that they can include asm/processor.h to 
determine if the architecture already has a prefetch instruction 
defined.  What a nightmare.  Trying to move system.h pieces into 
processor.h also doesn't work, since you basically need to move the 
whole file.

Maybe that is the way to go, but I would rather not go there now.


>>  #define COMPILER_DEPENDENT_INT64   long long
>>  #define COMPILER_DEPENDENT_UINT64  unsigned long long
>> Index: linux-2.6.16.1/include/asm-i386/arch_hooks.h
>> ===================================================================
>> --- linux-2.6.16.1.orig/include/asm-i386/arch_hooks.h	2006-03-29 19:38:47.000000000 -0800
>> +++ linux-2.6.16.1/include/asm-i386/arch_hooks.h	2006-03-29 19:38:54.000000000 -0800
>> @@ -1,7 +1,13 @@
>>  #ifndef _ASM_ARCH_HOOKS_H
>>  #define _ASM_ARCH_HOOKS_H
>>  
>> +#include <linux/config.h>
>> +#include <linux/smp.h>
>> +#include <linux/init.h>
>>  #include <linux/interrupt.h>
>> +#include <asm/acpi.h>
>> +#include <asm/arch_hooks.h>
>>     
>
> extraneous include
>   

Yes, somewhat extraneous.

>   
>> --- linux-2.6.16.1.orig/include/asm-i386/mach-default/mach_hooks.h	2006-03-29 19:38:54.000000000 -0800
>> +++ linux-2.6.16.1/include/asm-i386/mach-default/mach_hooks.h	2006-03-29 19:38:54.000000000 -0800
>> @@ -0,0 +1,6 @@
>> +#ifndef _MACH_HOOKS_H
>> +#define _MACH_HOOKS_H
>>     
>
> should probably be consistent (_MACH_HOOKS_H vs. MACH_HOOKS_H)
>   
Patch attached.

--------------000502060207050202090305
Content-Type: text/plain;
 name="i386-tidy-subarch-cleanup"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-tidy-subarch-cleanup"

Tidy up the subarch cleanup patch with nits noticed by Chris Wright.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16.1/include/asm-i386/arch_hooks.h
===================================================================
--- linux-2.6.16.1.orig/include/asm-i386/arch_hooks.h	2006-03-30 10:53:45.000000000 -0800
+++ linux-2.6.16.1/include/asm-i386/arch_hooks.h	2006-03-30 10:54:27.000000000 -0800
@@ -1,13 +1,9 @@
 #ifndef _ASM_ARCH_HOOKS_H
 #define _ASM_ARCH_HOOKS_H
 
-#include <linux/config.h>
-#include <linux/smp.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <asm/acpi.h>
 #include <asm/arch_hooks.h>
-#include <asm/desc.h>
 
 /*
  *	linux/include/asm/arch_hooks.h
Index: linux-2.6.16.1/include/asm-i386/acpi.h
===================================================================
--- linux-2.6.16.1.orig/include/asm-i386/acpi.h	2006-03-30 10:53:45.000000000 -0800
+++ linux-2.6.16.1/include/asm-i386/acpi.h	2006-03-30 10:54:27.000000000 -0800
@@ -31,7 +31,6 @@
 #include <acpi/pdc_intel.h>
 
 #include <asm/system.h>		/* defines cmpxchg */
-#include <asm/processor.h>	/* defines boot_cpu_data */
 
 #define COMPILER_DEPENDENT_INT64   long long
 #define COMPILER_DEPENDENT_UINT64  unsigned long long
Index: linux-2.6.16.1/include/asm-i386/processor.h
===================================================================
--- linux-2.6.16.1.orig/include/asm-i386/processor.h	2006-03-30 10:53:45.000000000 -0800
+++ linux-2.6.16.1/include/asm-i386/processor.h	2006-03-30 11:03:16.000000000 -0800
@@ -16,7 +16,6 @@
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
 #include <asm/system.h>
-#include <linux/cache.h>
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <asm/percpu.h>
@@ -39,82 +38,13 @@ struct desc_struct {
  */
 #define current_text_addr() ({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
 
-/*
- *  CPU type and hardware bug flags. Kept separately for each CPU.
- *  Members of this structure are referenced in head.S, so think twice
- *  before touching them. [mj]
- */
-
-struct cpuinfo_x86 {
-	__u8	x86;		/* CPU family */
-	__u8	x86_vendor;	/* CPU vendor */
-	__u8	x86_model;
-	__u8	x86_mask;
-	char	wp_works_ok;	/* It doesn't on 386's */
-	char	hlt_works_ok;	/* Problems on some 486Dx4's and old 386's */
-	char	hard_math;
-	char	rfu;
-       	int	cpuid_level;	/* Maximum supported CPUID level, -1=no CPUID */
-	unsigned long	x86_capability[NCAPINTS];
-	char	x86_vendor_id[16];
-	char	x86_model_id[64];
-	int 	x86_cache_size;  /* in KB - valid for CPUS which support this
-				    call  */
-	int 	x86_cache_alignment;	/* In bytes */
-	char	fdiv_bug;
-	char	f00f_bug;
-	char	coma_bug;
-	char	pad0;
-	int	x86_power;
-	unsigned long loops_per_jiffy;
-	unsigned char x86_max_cores;	/* cpuid returned max cores value */
-	unsigned char booted_cores;	/* number of cores as seen by OS */
-	unsigned char apicid;
-} __attribute__((__aligned__(SMP_CACHE_BYTES)));
-
-#define X86_VENDOR_INTEL 0
-#define X86_VENDOR_CYRIX 1
-#define X86_VENDOR_AMD 2
-#define X86_VENDOR_UMC 3
-#define X86_VENDOR_NEXGEN 4
-#define X86_VENDOR_CENTAUR 5
-#define X86_VENDOR_RISE 6
-#define X86_VENDOR_TRANSMETA 7
-#define X86_VENDOR_NSC 8
-#define X86_VENDOR_NUM 9
-#define X86_VENDOR_UNKNOWN 0xff
-
-/*
- * capabilities of CPUs
- */
-
-extern struct cpuinfo_x86 boot_cpu_data;
-extern struct cpuinfo_x86 new_cpu_data;
 extern struct tss_struct doublefault_tss;
 DECLARE_PER_CPU(struct tss_struct, init_tss);
 
-#ifdef CONFIG_SMP
-extern struct cpuinfo_x86 cpu_data[];
-#define current_cpu_data cpu_data[smp_processor_id()]
-#else
-#define cpu_data (&boot_cpu_data)
-#define current_cpu_data boot_cpu_data
-#endif
-
 extern	int phys_proc_id[NR_CPUS];
 extern	int cpu_core_id[NR_CPUS];
 extern char ignore_fpu_irq;
 
-extern void identify_cpu(struct cpuinfo_x86 *);
-extern void print_cpu_info(struct cpuinfo_x86 *);
-extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
-
-#ifdef CONFIG_X86_HT
-extern void detect_ht(struct cpuinfo_x86 *c);
-#else
-static inline void detect_ht(struct cpuinfo_x86 *c) {}
-#endif
-
 /*
  * EFLAGS bits
  */
@@ -720,8 +650,6 @@ static inline void prefetchw(const void 
 
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 
-#define cache_line_size() (boot_cpu_data.x86_cache_alignment)
-
 extern unsigned long boot_option_idle_override;
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
Index: linux-2.6.16.1/include/asm-i386/system.h
===================================================================
--- linux-2.6.16.1.orig/include/asm-i386/system.h	2006-03-30 10:53:45.000000000 -0800
+++ linux-2.6.16.1/include/asm-i386/system.h	2006-03-30 11:04:28.000000000 -0800
@@ -5,12 +5,80 @@
 #include <linux/kernel.h>
 #include <asm/segment.h>
 #include <asm/cpufeature.h>
+#include <linux/cache.h>
 #include <linux/bitops.h> /* for LOCK_PREFIX */
 
 #ifdef __KERNEL__
 
-struct task_struct;	/* one of the stranger aspects of C forward declarations.. */
-extern struct task_struct * FASTCALL(__switch_to(struct task_struct *prev, struct task_struct *next));
+/*
+ *  CPU type and hardware bug flags. Kept separately for each CPU.
+ *  Members of this structure are referenced in head.S, so think twice
+ *  before touching them. [mj]
+ */
+
+struct cpuinfo_x86 {
+	__u8	x86;		/* CPU family */
+	__u8	x86_vendor;	/* CPU vendor */
+	__u8	x86_model;
+	__u8	x86_mask;
+	char	wp_works_ok;	/* It doesn't on 386's */
+	char	hlt_works_ok;	/* Problems on some 486Dx4's and old 386's */
+	char	hard_math;
+	char	rfu;
+       	int	cpuid_level;	/* Maximum supported CPUID level, -1=no CPUID */
+	unsigned long	x86_capability[NCAPINTS];
+	char	x86_vendor_id[16];
+	char	x86_model_id[64];
+	int 	x86_cache_size;  /* in KB - valid for CPUS which support this
+				    call  */
+	int 	x86_cache_alignment;	/* In bytes */
+	char	fdiv_bug;
+	char	f00f_bug;
+	char	coma_bug;
+	char	pad0;
+	int	x86_power;
+	unsigned long loops_per_jiffy;
+	unsigned char x86_max_cores;	/* cpuid returned max cores value */
+	unsigned char booted_cores;	/* number of cores as seen by OS */
+	unsigned char apicid;
+} __attribute__((__aligned__(SMP_CACHE_BYTES)));
+
+#define X86_VENDOR_INTEL 0
+#define X86_VENDOR_CYRIX 1
+#define X86_VENDOR_AMD 2
+#define X86_VENDOR_UMC 3
+#define X86_VENDOR_NEXGEN 4
+#define X86_VENDOR_CENTAUR 5
+#define X86_VENDOR_RISE 6
+#define X86_VENDOR_TRANSMETA 7
+#define X86_VENDOR_NSC 8
+#define X86_VENDOR_NUM 9
+#define X86_VENDOR_UNKNOWN 0xff
+
+/*
+ * capabilities of CPUs
+ */
+extern struct cpuinfo_x86 boot_cpu_data;
+extern struct cpuinfo_x86 new_cpu_data;
+#define cache_line_size() (boot_cpu_data.x86_cache_alignment)
+
+#ifdef CONFIG_SMP
+extern struct cpuinfo_x86 cpu_data[];
+#define current_cpu_data cpu_data[smp_processor_id()]
+#else
+#define cpu_data (&boot_cpu_data)
+#define current_cpu_data boot_cpu_data
+#endif
+
+extern void identify_cpu(struct cpuinfo_x86 *);
+extern void print_cpu_info(struct cpuinfo_x86 *);
+extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
+
+#ifdef CONFIG_X86_HT
+extern void detect_ht(struct cpuinfo_x86 *c);
+#else
+static inline void detect_ht(struct cpuinfo_x86 *c) {}
+#endif
 
 #define switch_to(prev,next,last) do {					\
 	unsigned long esi,edi;						\
Index: linux-2.6.16.1/include/asm-i386/mach-visws/mach_hooks.h
===================================================================
--- linux-2.6.16.1.orig/include/asm-i386/mach-visws/mach_hooks.h	2006-03-30 10:53:45.000000000 -0800
+++ linux-2.6.16.1/include/asm-i386/mach-visws/mach_hooks.h	2006-03-30 10:54:27.000000000 -0800
@@ -1,5 +1,5 @@
-#ifndef MACH_HOOKS_H
-#define MACH_HOOKS_H
+#ifndef _MACH_HOOKS_H
+#define _MACH_HOOKS_H
 
 #define pre_intr_init_hook() init_VISWS_APIC_irqs()
 
Index: linux-2.6.16.1/include/asm-i386/mach-voyager/mach_hooks.h
===================================================================
--- linux-2.6.16.1.orig/include/asm-i386/mach-voyager/mach_hooks.h	2006-03-30 10:53:45.000000000 -0800
+++ linux-2.6.16.1/include/asm-i386/mach-voyager/mach_hooks.h	2006-03-30 10:54:27.000000000 -0800
@@ -1,5 +1,5 @@
-#ifndef MACH_HOOKS_H
-#define MACH_HOOKS_H
+#ifndef _MACH_HOOKS_H
+#define _MACH_HOOKS_H
 
 /**
  * intr_init_hook - post gate setup interrupt initialisation

--------------000502060207050202090305--
