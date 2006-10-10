Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWJJNk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWJJNk3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWJJNk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:40:29 -0400
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:44031 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750778AbWJJNk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:40:27 -0400
Date: Tue, 10 Oct 2006 09:40:14 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Martin Bligh <mbligh@google.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Proof of concept:  Logdev with "almost-non" intrusive markers.
Message-ID: <20061010134014.GD6200@Krystal>
References: <20060921232024.GA16155@Krystal> <1160189237.21768.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1160189237.21768.47.camel@localhost.localdomain>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 09:26:51 up 48 days, 10:35,  4 users,  load average: 0.32, 0.37, 0.69
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Those are great ideas! Kernel compile-time type checking is interesting, but has
the following disadvantages (compared to Linux Kernel Markers 0.20
  http://sources.redhat.com/ml/systemtap/2006-q3/msg00794.html) :

- It requires to keep a system-wide header file with all the marker functions
  prototypes around. When a change is done in the code, the header must match.
  My goal being to provide a self-describing, one liner marker, such system-wide
  header file makes me uncomfortable.
- Knowing the number of parameters (LD_MARK[1-4]) instead of using variable
  arguments (MARK) adds the ability to use typeof() on the parameters, which is
  clearly great. On the downside, it multiplies the number of macros and limits
  the number of parameters that can be passed (I guess we will never do an
  LD_MARK10). Wether
    MARK4(label, args1, arg2, arg3, arg4)
  or
    MARK(label, format, arg1, arg2, arg3, arg4)
  is better is a matter of visual impact and level of self-description of the
  probe. While I personally prefer the format string because of its
  flexibility, it could be useful to have other insight about which is the
  less visually hurting approach.

Regards,

Mathieu


* Steven Rostedt (rostedt@goodmis.org) wrote:
> OK, I've been catching up a little on the threads, but I'm still behind
> (4036 unread in LKML folder). But I wanted to show this proof of
> concept, just to get some more ideas rolling around.
> 
> Yesterday, I posted a way to save a location and register of a contained
> local variable.  Today I've implemented it in Logdev.  So my markers are
> almost non intrusive. The only thing that the markers do, is force gcc
> to put the wanted variables into a register at a certain point. 
> 
> Jeremy mentioned a way to also store the values in memory, but this is
> just a proof of concept, and further ideas can be built upon it.
> 
> 
> My logdev patch and tool set can be downloaded at
> http://rostedt.homelinux.com/logdev
> 
> The topic of this email is not about logdev, but about the markers.  So
> my patch on top of logdev is included here (also available for download
> at the mentioned url).
> 
> What did I do?
> 
> I've added 5 markers.
>   LD_MARK(label)
>   LD_MARK1(label,arg1)
>   LD_MARK2(label,arg1,arg2)
>   LD_MARK3(label,arg1,arg2,arg3)
>   LD_MARK4(label,arg1,arg2,arg3,arg4)
> 
> Here's an example of LD_MARK2: (defined in my patch at
> include/asm-i386/logdev_marker.h)
> 
> #define LD_MARK2(label, arg1, arg2)					\
> 	{								\
> 		extern void __logdev_caller__ ## label(typeof(arg1),	\
> 						       typeof(arg2));	\
> 		asm("1:"						\
> 		    ".section .__logdev_markers,\"a\"\n"		\
> 		    ".long 1b," LD_STR(__logdev_caller__ ## label) "\n"	\
> 		    ".long 2\n"						\
> 		    "xorl %0, %0\n"					\
> 		    ".short 0\n"					\
> 		    "xorl %1, %1\n"					\
> 		    ".short 0\n"					\
> 		    ".previous"						\
> 		    : :							\
> 		    "r"(arg1), "r"(arg2));				\
> 	}
> 
> 
> 
> So basically in the elf section __logdev_markers  I have dynamic records
> that are sizeof(long) defined.  The records would look like this.
> 
> struct {
> 	unsigned long probe_address;
> 	unsigned long function_to_call;
> 	unsigned long num_of_args;
> 	unsigned long regs[0];
> };
> 
> My logdev program reads these in to a descriptor, and puts them into a
> link list.  It calls an arch specific function to translate what was in
> the regs[] record to some id that can be used later to find what
> register the argument is used in.
> 
> 
> Now note in the macro:
> 
> 	extern void __logdev_caller__ ## label(typeof(arg1),	\
> 					       typeof(arg2));	\
> 
> This forces strict type checking of the tracer to the function that is
> called.  How is that done?  Well in include/linux/logdev_marker.h I have
> all my tracing prototypes declared. If it doesn't match the marker, then
> I get a compile time error.
> 
> In linux/logdev_marker.h:
> 
> #define LDCALLER(caller) __logdev_caller__ ## caller
> 
> void LDCALLER(context_switch) (struct task_struct *prev,
> 			       struct task_struct *next);
> void LDCALLER(mm_fault) (struct mm_struct *mm, struct vm_area_struct *vma,
> 			 unsigned long address, int write_access);
> 
> 
> Here you see two trace functions. The markers I have for these is in
> context_switch and __handle_mm_fault respectively.
> 
> in kernel/sched.c:
> 
> static inline struct task_struct *
> context_switch(struct rq *rq, struct task_struct *prev,
> 	       struct task_struct *next)
> {
> 	struct mm_struct *mm = next->mm;
> 	struct mm_struct *oldmm = prev->active_mm;
> 
> 	LD_MARK2(context_switch, prev, next);
> 
> 
> in mm/memory.c:
> 
> int __handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> 		unsigned long address, int write_access)
> {
> 	pgd_t *pgd;
> 	pud_t *pud;
> 	pmd_t *pmd;
> 	pte_t *pte;
> 
> 	LD_MARK4(mm_fault, mm, vma, address, write_access);
> 
> 
> If the prototype doesn't match, then there's a compile time error.  That
> header file is also included in the same place that the trace functions
> are defined, so the match must be true there too.
> 
> These examples are just proof in concept.  The context_switch one is
> very hard to get kprobes to see prev and next, because context_switch is
> an static inline, and every modification of sched.c may make gcc
> optimize what it does with prev and next differently.  They are not
> passed as parameters.
> 
> The __handle_mm_fault can easily be done by jprobes, but I was testing
> my LD_MARK4 with it.
> 
> So what this proof-of-conecpt is doing, is showing a way to use kprobes
> with little to no performance hit to the binary, when tracing is off.
> We save on the L1 cache and barely change the optimization that gcc
> does.
> 
> This also shows a way to strongly type check the parameters used between
> the markers and the tracers that are using the markers.
> 
> What this proof-of-concept does *not* do, is solve the issues that LTTng
> are trying to solve, (as well as dprobes).   This only works with
> kprobes that are currently in the kernel, or basically any other "int 3"
> type method.
> 
> But this was done to get ideas out in the open, and perhaps this will
> trigger an idea in those that are much brighter than I, and we will have
> some utopia of a solution :-)
> 
> -------------
> 
> End of proof-of-concept
> 
> For those interested, here's a little description of what I've done with
> Logdev and the markers.
> 
> my logdev device has a /debugfs/logdev/marker file that shows what's
> been registered:
> 
> # cat /debugfs/logdev/marker
> probe address:  c0154599
> func address:   c0260ae3
> args:           4
> arg 0 reg:      eax
> arg 1 reg:      edx
> arg 2 reg:      ecx
> arg 3 reg:      ebx
> 
> probe address:  c02f8aa5
> func address:   c0260928
> args:           2
> arg 0 reg:      eax
> arg 1 reg:      edx
> 
> 
> Here we see that c0154599 is the address of where the marker is in
> __handle_mm_fault. Also the address of the function is shown, and number
> of args.  We also see what registers are used.
> 
> 
> To turn on the probes, an ioctl is called to that same file.  The logdev
> tool "logmark" can do this for you.  "logmark 1" turns on the probes,
> and "logmark 0" turns them off.
> 
> logread still shows the output of what is done:
> 
> # ./logread
> [...]
> [  367.829418] cpu:1 gnome-settings-:3858(115:120:115) -->> gnome-terminal:3875(116:120:116)
> [  367.829429] cpu:0 swapper:0(140:120:140) -->> logread:4323(116:120:116)
> [  367.829740] cpu:0 logread:4323  mm=0xf0f12200 vma=0xf293a41c  address=8065044  write_access=1
> [  367.830089] cpu:0 logread:4323(116:120:116) -->> swapper:0(140:120:140)
> [  367.835167] cpu:0 swapper:0(140:120:140) -->> logread:4323(115:120:115)
> [  367.835476] cpu:0 logread:4323  mm=0xf0f12200 vma=0xf293a41c  address=8066004  write_access=1
> 
> 
> Well if anyone wants to play with this.  The code is (once again) at
> http://rostedt.homelinux.com/logdev.  You will need to apply the two
> patches for 2.6.18:
> 
> http://rostedt.homelinux.com/logdev/logdev-0.5.3-2.6.18.patch
> http://rostedt.homelinux.com/logdev/logdev-markers-0.5.3-2.6.18.patch
> 
> and the tools are here
> 
> http://rostedt.homelinux.com/logdev/logdev-tools-0.5.3-1.tar.bz2
> 
> You need to build them yourself.
> 
> Currently, logdev-markers only works for i386. But it would be really
> easy to port it to any other arch that already has kprobes.
> 
> 
> Here's the marker patch:
> 
> Index: linux-2.6.18/include/asm-i386/logdev_marker.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.18/include/asm-i386/logdev_marker.h	2006-10-06 21:21:37.000000000 -0400
> @@ -0,0 +1,182 @@
> +/*
> + * logdev_marker.h
> + *
> + * Copyright - 2006 - Steven Rostedt, Red Hat Inc, (srostedt at redhat dot com)
> + */
> +#ifndef _ASM_LOGDEV_MARKER_H
> +#define _ASM_LOGDEV_MARKER_H
> +
> +
> +/*
> + * eax = 0
> + * ebx = 3
> + * ecx = 1
> + * edx = 2
> + * edi = 7
> + * ebp = 5
> + * esp = 4
> + * esi = 6
> + */
> +enum {
> +	LD_REGA = 0,
> +	LD_REGB = 3,
> +	LD_REGC = 1,
> +	LD_REGD = 2,
> +	LD_REGDI = 7,
> +	LD_REGBP = 5,
> +	LD_REGSP = 4,
> +	LD_REGSI = 6
> +};
> +
> +static inline int logdev_mark_get_reg(unsigned long op)
> +{
> +	/*
> +	 * Strip out the register:
> +	 */
> +	return (op >> 8) & 0x7;
> +}
> +
> +static inline unsigned long
> +logdev_mark_get_reg_content(int reg, struct pt_regs *regs)
> +{
> +	static int once;
> +
> +	switch (reg) {
> +	case LD_REGA:
> +		return regs->eax;
> +	case LD_REGB:
> +		return regs->ebx;
> +	case LD_REGC:
> +		return regs->ecx;
> +	case LD_REGD:
> +		return regs->edx;
> +	case LD_REGDI:
> +		return regs->edi;
> +	case LD_REGBP:
> +		return regs->ebp;
> +	case LD_REGSP:
> +		return regs->esp;
> +	case LD_REGSI:
> +		return regs->esi;
> +	default:
> +		if (!once) {
> +			printk("unknown reg type %d\n", reg);
> +			once = 1;
> +		}
> +	}
> +	return 0;
> +}
> +
> +
> +static inline const char *logdev_reg_to_name(int reg)
> +{
> +	switch (reg) {
> +	case LD_REGA:
> +		return "eax";
> +	case LD_REGB:
> +		return "ebx";
> +	case LD_REGC:
> +		return "ecx";
> +	case LD_REGD:
> +		return "edx";
> +	case LD_REGDI:
> +		return "edi";
> +	case LD_REGBP:
> +		return "ebp";
> +	case LD_REGSP:
> +		return "esp";
> +	case LD_REGSI:
> +		return "esi";
> +	}
> +	return "unknown reg!";
> +}
> +
> +#define _LD_STR(x) #x
> +#define LD_STR(x) _LD_STR(x)
> +
> +#define LD_MARK(label)							\
> +	{								\
> +		extern void __logdev_caller__ ## label(void);		\
> +		asm("1:"						\
> +		    ".section .__logdev_markers,\"a\"\n"		\
> +		    ".long 1b," LD_STR(__logdev_caller__ ## label) "\n"	\
> +		    ".long 0\n"						\
> +		    ".previous"						\
> +		    : :	);						\
> +	}
> +
> +#define LD_MARK1(label, arg1)						\
> +	{								\
> +		extern void __logdev_caller__ ## label(typeof(arg1));	\
> +		asm("1:"						\
> +		    ".section .__logdev_markers,\"a\"\n"		\
> +		    ".long 1b," LD_STR(__logdev_caller__ ## label) "\n"	\
> +		    ".long 1\n"						\
> +		    "xorl %0, %0\n"					\
> +		    ".short 0\n"					\
> +		    ".previous"						\
> +		    : :							\
> +		    "r"(arg1));						\
> +	}
> +
> +#define LD_MARK2(label, arg1, arg2)					\
> +	{								\
> +		extern void __logdev_caller__ ## label(typeof(arg1),	\
> +						       typeof(arg2));	\
> +		asm("1:"						\
> +		    ".section .__logdev_markers,\"a\"\n"		\
> +		    ".long 1b," LD_STR(__logdev_caller__ ## label) "\n"	\
> +		    ".long 2\n"						\
> +		    "xorl %0, %0\n"					\
> +		    ".short 0\n"					\
> +		    "xorl %1, %1\n"					\
> +		    ".short 0\n"					\
> +		    ".previous"						\
> +		    : :							\
> +		    "r"(arg1), "r"(arg2));				\
> +	}
> +
> +#define LD_MARK3(label, arg1, arg2, arg3)				\
> +	{								\
> +		extern void __logdev_caller__ ## label(typeof(arg1),	\
> +						       typeof(arg2),	\
> +						       typeof(arg3));	\
> +		asm("1:"						\
> +		    ".section .__logdev_markers,\"a\"\n"		\
> +		    ".long 1b," LD_STR(__logdev_caller__ ## label) "\n"	\
> +		    ".long 3\n"						\
> +		    "xorl %0, %0\n"					\
> +		    ".short 0\n"					\
> +		    "xorl %1, %1\n"					\
> +		    ".short 0\n"					\
> +		    "xorl %2, %2\n"					\
> +		    ".short 0\n"					\
> +		    ".previous"						\
> +		    : :							\
> +		    "r"(arg1), "r"(arg2), "r"(arg3));			\
> +	}
> +
> +#define LD_MARK4(label, arg1, arg2, arg3, arg4)				\
> +	{								\
> +		extern void __logdev_caller__ ## label(typeof(arg1),	\
> +						       typeof(arg2),	\
> +						       typeof(arg3),	\
> +						       typeof(arg4));	\
> +		asm("1:"						\
> +		    ".section .__logdev_markers,\"a\"\n"		\
> +		    ".long 1b," LD_STR(__logdev_caller__ ## label) "\n"	\
> +		    ".long 4\n"						\
> +		    "xorl %0, %0\n"					\
> +		    ".short 0\n"					\
> +		    "xorl %1, %1\n"					\
> +		    ".short 0\n"					\
> +		    "xorl %2, %2\n"					\
> +		    ".short 0\n"					\
> +		    "xorl %3, %3\n"					\
> +		    ".short 0\n"					\
> +		    ".previous"						\
> +		    : :							\
> +		    "r"(arg1), "r"(arg2), "r"(arg3), "r"(arg4));	\
> +	}
> +
> +#endif /* _ASM_LOGDEV_MARKER_H */
> Index: linux-2.6.18/include/linux/logdev_marker.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.18/include/linux/logdev_marker.h	2006-10-06 21:08:40.000000000 -0400
> @@ -0,0 +1,30 @@
> +/*
> + * logdev_marker.h
> + *
> + * Copyright - 2006 - Steven Rostedt, Red Hat Inc, (srostedt at redhat dot com)
> + */
> +#ifndef _LINUX_LOGDEV_MARKER_H
> +#define _LINUX_LOGDEV_MARKER_H
> +
> +#ifdef CONFIG_LOGDEV_MARKER
> +
> +#include <asm/logdev_marker.h>
> +
> +#define LDCALLER(caller) __logdev_caller__ ## caller
> +
> +void LDCALLER(context_switch) (struct task_struct *prev,
> +			       struct task_struct *next);
> +void LDCALLER(mm_fault) (struct mm_struct *mm, struct vm_area_struct *vma,
> +			 unsigned long address, int write_access);
> +
> +#else
> +
> +#define LD_MARK(label)				do { } while(0)
> +#define LD_MARK1(label,arg1)			do { } while(0)
> +#define LD_MARK2(label,arg1,arg2)		do { } while(0)
> +#define LD_MARK3(label,arg1,arg2,arg3)		do { } while(0)
> +#define LD_MARK4(label,arg1,arg2,arg3,arg4)	do { } while(0)
> +
> +#endif /* CONFIG_LOGDEV_MARKER */
> +
> +#endif /* _LINUX_LOGDEV_MARKER_H */
> Index: linux-2.6.18/kernel/sched.c
> ===================================================================
> --- linux-2.6.18.orig/kernel/sched.c	2006-10-06 17:49:36.000000000 -0400
> +++ linux-2.6.18/kernel/sched.c	2006-10-06 21:05:44.000000000 -0400
> @@ -53,7 +53,7 @@
>  #include <linux/kprobes.h>
>  #include <linux/delayacct.h>
>  #include <asm/tlb.h>
> -
> +#include <linux/logdev_marker.h>
>  #include <linux/logdev.h>
>  
>  #include <asm/unistd.h>
> @@ -1806,6 +1806,8 @@ context_switch(struct rq *rq, struct tas
>  	struct mm_struct *mm = next->mm;
>  	struct mm_struct *oldmm = prev->active_mm;
>  
> +	LD_MARK2(context_switch, prev, next);
> +
>  	if (unlikely(!mm)) {
>  		next->active_mm = oldmm;
>  		atomic_inc(&oldmm->mm_count);
> Index: linux-2.6.18/arch/i386/Kconfig.debug
> ===================================================================
> --- linux-2.6.18.orig/arch/i386/Kconfig.debug	2006-10-06 18:25:05.000000000 -0400
> +++ linux-2.6.18/arch/i386/Kconfig.debug	2006-10-06 20:59:41.000000000 -0400
> @@ -76,6 +76,11 @@ config X86_MPPARSE
>  	depends on X86_LOCAL_APIC && !X86_VISWS
>  	default y
>  
> +config LOGDEV_MARKER
> +	bool
> +	depends on LOGDEV && KPROBES
> +	default y
> +
>  config DOUBLEFAULT
>  	default y
>  	bool "Enable doublefault exception handler" if EMBEDDED
> Index: linux-2.6.18/arch/i386/kernel/vmlinux.lds.S
> ===================================================================
> --- linux-2.6.18.orig/arch/i386/kernel/vmlinux.lds.S	2006-10-06 18:20:17.000000000 -0400
> +++ linux-2.6.18/arch/i386/kernel/vmlinux.lds.S	2006-10-06 18:24:13.000000000 -0400
> @@ -44,6 +44,15 @@ SECTIONS
>    }
>    __tracedata_end = .;
>  
> +#ifdef CONFIG_LOGDEV_MARKER
> +  . = ALIGN(4);
> +  __logdev_marker_start = .;
> +  .__logdev_markers : AT(ADDR(.__logdev_markers) - LOAD_OFFSET) {
> +	*(.__logdev_markers)
> +  }
> +  __logdev_marker_end = .;
> +#endif
> +
>    /* writeable */
>    .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
>  	*(.data)
> Index: linux-2.6.18/drivers/char/Makefile
> ===================================================================
> --- linux-2.6.18.orig/drivers/char/Makefile	2006-10-06 18:26:16.000000000 -0400
> +++ linux-2.6.18/drivers/char/Makefile	2006-10-06 18:26:46.000000000 -0400
> @@ -100,6 +100,7 @@ obj-$(CONFIG_LOGDEV)		+= logdev.o
>  obj-$(CONFIG_LOGDEV_PROBE)	+= logdev_probe.o
>  obj-$(CONFIG_LOGDEV_RINGBUF)	+= logdev_ringbuf.o
>  obj-$(CONFIG_LOGDEV_RELAY)	+= logdev_relay.o
> +obj-$(CONFIG_LOGDEV_MARKER)	+= logdev_marker.o
>  
>  obj-$(CONFIG_HANGCHECK_TIMER)	+= hangcheck-timer.o
>  obj-$(CONFIG_TCG_TPM)		+= tpm/
> Index: linux-2.6.18/drivers/char/logdev_marker.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.18/drivers/char/logdev_marker.c	2006-10-06 21:45:40.000000000 -0400
> @@ -0,0 +1,497 @@
> +/*
> + * logdev_marker.c
> + *
> + * Copyright (C) 2006 Steven Rostedt <steven.rostedt@kihontech.com>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License (not later!)
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/logdev.h>
> +#include <linux/uaccess.h>
> +#include <linux/seq_file.h>
> +#include <linux/debugfs.h>
> +#include <linux/kprobes.h>
> +#include <linux/ptrace.h>
> +#include <linux/kallsyms.h>
> +#include <linux/list.h>
> +#include <linux/logdev_marker.h>
> +
> +#include <asm/atomic.h>
> +
> +#include "logdev_priv.h"
> +
> +#define MAX_ARGS 4
> +
> +#undef DPRINTK
> +#if 1
> +#  define DPRINTK(x...) printk(x)
> +#else
> +#  define DPRINTK(x...) do { } while(0)
> +#endif
> +
> +static LIST_HEAD(logdev_probes);
> +
> +typedef void (*logdev_func0_t)(void);
> +typedef void (*logdev_func1_t)(unsigned long);
> +typedef void (*logdev_func2_t)(unsigned long, unsigned long);
> +typedef void (*logdev_func3_t)(unsigned long, unsigned long,
> +			       unsigned long);
> +typedef void (*logdev_func4_t)(unsigned long, unsigned long,
> +			       unsigned long, unsigned long);
> +
> +union logdev_func {
> +	logdev_func0_t func0;
> +	logdev_func1_t func1;
> +	logdev_func2_t func2;
> +	logdev_func3_t func3;
> +	logdev_func4_t func4;
> +};
> +
> +struct logdev_mark_probe {
> +	struct list_head list;
> +	struct kprobe kp;
> +	union logdev_func func;
> +	unsigned long address;
> +	int args;
> +	int arg_regs[MAX_ARGS];
> +};
> +
> +/* ---------------- cut here for user space headers -------------------- */
> +
> +#define LOGMARK_IOCTL_BASE 'm'
> +
> +#define MARK_IO(nr) _IO(LOGMARK_IOCTL_BASE, nr)
> +#define MARK_IOW(nr, type) _IOW(LOGMARK_IOCTL_BASE, nr, type)
> +
> +#define LOGMARK_START  MARK_IO(0)
> +#define LOGMARK_STOP   MARK_IO(1)
> +
> +#define LOGMARK_ID_MARK		0x56580000
> +
> +#define LOGMARK_CNTXTSW		0x56580001
> +#define LOGMARK_MM_FAULT	0x56580002
> +
> +struct logdev_mark_hdr {
> +	unsigned long long t;
> +	int id;
> +};
> +
> +struct logdev_mark_switch {
> +	struct logdev_mark_hdr hdr;
> +	short pid_prev;
> +	short pid_next;
> +	int prev_prio;
> +	int prev_static_prio;
> +	int prev_normal_prio;
> +	int prev_state;
> +	int next_prio;
> +	int next_static_prio;
> +	int next_normal_prio;
> +	char prev_comm[TASK_COMM_LEN];
> +	char next_comm[TASK_COMM_LEN];
> +};
> +
> +struct logdev_mark_mm_fault {
> +	struct logdev_mark_hdr hdr;
> +	short pid;
> +	char comm[TASK_COMM_LEN];
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	unsigned long address;
> +	int write_access;
> +};
> +
> +
> +/* ---------------- end of user space header cut ---------------- */
> +
> +struct logdev_probe_hdr {
> +	unsigned long addr;
> +	unsigned long offset;
> +	int func_symbol_size;
> +	char func_symbol[KSYM_NAME_LEN+1];
> +};
> +
> +
> +/* TODO, put this in logdev.c so I don't keep copying it */
> +static void logdev_print_time_cpu(unsigned long long t, int cpu)
> +{
> +	unsigned long usec_rem;
> +	unsigned long secs;
> +
> +	usec_rem = do_div(t, 1000000000)/1000;
> +	secs = (unsigned long)t;
> +
> +	printk("[%5lu.%06lu] cpu:%d ",
> +	       secs, usec_rem, cpu);
> +}
> +
> +/* ------------------- cut here for user space print -------------- */
> +
> +/* "s/printk/printf" */
> +
> +static void logdev_print_hdr(int cpu,
> +			     struct logdev_mark_hdr *hdr)
> +{
> +	logdev_print_time_cpu(hdr->t, cpu);
> +}
> +
> +static void logdev_mark_switch_print(int cpu, int size,
> +				     struct logdev_mark_switch *lm)
> +{
> +	logdev_print_hdr(cpu, &lm->hdr);
> +
> +	printk("%s:%d(%d:%d:%d) -->> ",
> +	       lm->prev_comm,
> +	       lm->pid_prev,
> +	       lm->prev_prio,
> +	       lm->prev_static_prio,
> +	       lm->prev_normal_prio);
> +
> +	printk("%s:%d(%d:%d:%d)\n",
> +	       lm->next_comm,
> +	       lm->pid_next,
> +	       lm->next_prio,
> +	       lm->next_static_prio,
> +	       lm->next_normal_prio);
> +}
> +
> +static void logdev_mark_mm_fault_print(int cpu, int size,
> +				       struct logdev_mark_mm_fault *lm)
> +{
> +	logdev_print_hdr(cpu, &lm->hdr);
> +
> +	printk("%s:%d  mm=%p vma=%p  address=%lx  write_access=%d\n",
> +	       lm->comm,
> +	       lm->pid,
> +	       lm->mm,
> +	       lm->vma,
> +	       lm->address,
> +	       lm->write_access);
> +}
> +
> +static void logdev_mark_callback(struct logdev_header *hdr,
> +				 struct logdev_custom *custom,
> +				 int cpu,
> +				 void *rec)
> +{
> +	struct logdev_mark_hdr *lm = rec;
> +
> +	switch (lm->id) {
> +	case LOGMARK_CNTXTSW:
> +		logdev_mark_switch_print(cpu, hdr->size, rec);
> +		break;
> +	case LOGMARK_MM_FAULT:
> +		logdev_mark_mm_fault_print(cpu, hdr->size, rec);
> +		break;
> +	default:
> +		printk("Unknown marker callback id %x\n",
> +		       custom->id);
> +		break;
> +	}
> +}
> +/* ------------------ end cut for user space printing ------------------- */
> +
> +
> +static void __kprobes logmark_hdr(struct logdev_mark_hdr *lm, int id)
> +{
> +	lm->t = sched_clock();
> +	lm->id = id;
> +}
> +
> +
> +void LDCALLER(context_switch) (struct task_struct *prev,
> +			       struct task_struct *next)
> +{
> +	struct logdev_mark_switch lm;
> +
> +	logmark_hdr(&lm.hdr, LOGMARK_CNTXTSW);
> +
> +	lm.pid_prev = prev->pid;
> +	lm.prev_prio = prev->prio;
> +	lm.prev_static_prio = prev->static_prio;
> +	lm.prev_normal_prio = prev->normal_prio;
> +	lm.prev_state = prev->state;
> +	lm.pid_next = next->pid;
> +	lm.next_prio = next->prio;
> +	lm.next_static_prio = next->static_prio;
> +	lm.next_normal_prio = next->normal_prio;
> +	memcpy(lm.prev_comm, prev->comm, TASK_COMM_LEN);
> +	memcpy(lm.next_comm, next->comm, TASK_COMM_LEN);
> +
> +	logdev_record(LOGMARK_ID_MARK, sizeof(lm),
> +		      &lm, sizeof(lm), NULL);
> +}
> +
> +void LDCALLER(mm_fault) (struct mm_struct *mm, struct vm_area_struct *vma,
> +			 unsigned long address, int write_access)
> +{
> +	struct logdev_mark_mm_fault lm;
> +
> +	logmark_hdr(&lm.hdr, LOGMARK_MM_FAULT);
> +
> +	lm.pid = current->pid;
> +	memcpy(lm.comm, current->comm, TASK_COMM_LEN);
> +
> +	lm.mm = mm;
> +	lm.vma = vma;
> +	lm.address = address;
> +	lm.write_access = write_access;
> +
> +	logdev_record(LOGMARK_ID_MARK, sizeof(lm),
> +		      &lm, sizeof(lm), NULL);
> +}
> +
> +/************************ Kprobes ******************************/
> +
> +static int __kprobes logmark_probe(struct kprobe *kp, struct pt_regs *regs)
> +{
> +	struct logdev_mark_probe *p =
> +		container_of(kp, struct logdev_mark_probe, kp);
> +	unsigned long args[MAX_ARGS];
> +	int i;
> +
> +	for (i=0; i < p->args; i++)
> +		args[i] = logdev_mark_get_reg_content(p->arg_regs[i], regs);
> +
> +	switch (p->args) {
> +	case 0:
> +		p->func.func0();
> +		break;
> +	case 1:
> +		p->func.func1(args[0]);
> +		break;
> +	case 2:
> +		p->func.func2(args[0], args[1]);
> +		break;
> +	case 3:
> +		p->func.func3(args[0], args[1], args[2]);
> +		break;
> +	case 4:
> +		p->func.func4(args[0], args[1], args[2], args[3]);
> +		break;
> +
> +	}
> +	return 0;
> +}
> +
> +
> +/************************ User Land ******************************/
> +
> +static DEFINE_MUTEX(logdev_marker_lock);
> +
> +static int mark_is_on;
> +
> +static int logdev_mark_ioctl(struct inode *inode, struct file *filp,
> +			     unsigned int cmd, unsigned long arg)
> +{
> +	int ret = 0;
> +	struct logdev_mark_probe *probe;
> +
> +	switch (cmd) {
> +	case LOGMARK_START:
> +
> +		mutex_lock(&logdev_marker_lock);
> +		if (!mark_is_on) {
> +			list_for_each_entry(probe, &logdev_probes, list) {
> +				probe->kp.pre_handler = logmark_probe;
> +				probe->kp.addr =
> +					(kprobe_opcode_t *)probe->address;
> +
> +				ret = register_kprobe(&probe->kp);
> +				if (ret < 0) {
> +					ret = -EINVAL;
> +					printk(KERN_WARNING
> +					       "logdev_marker: can't register probe\n");
> +					break;
> +				}
> +			}
> +			mark_is_on = 1;
> +		}
> +		mutex_unlock(&logdev_marker_lock);
> +
> +		break;
> +
> +	case LOGMARK_STOP:
> +
> +		mutex_lock(&logdev_marker_lock);
> +		if (mark_is_on) {
> +			list_for_each_entry(probe, &logdev_probes, list) {
> +				unregister_kprobe(&probe->kp);
> +			}
> +			mark_is_on = 0;
> +		}
> +		mutex_unlock(&logdev_marker_lock);
> +
> +		break;
> +
> +	default:
> +		ret = -ENOTTY;
> +	}
> +
> +	return ret;
> +}
> +
> +
> +/******************* List mark entries *****************/
> +
> +static void __kprobes *s_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +	struct logdev_mark_probe *p = NULL;
> +	int l = 0;
> +
> +	list_for_each_entry(p, &logdev_probes, list) {
> +		if (l++ >= *pos)
> +			break;
> +	}
> +
> +	(*pos)++;
> +
> +	if (&p->list == &logdev_probes)
> +		return NULL;
> +
> +	return p;
> +}
> +
> +static void __kprobes *s_start(struct seq_file *m, loff_t *pos)
> +	__acquires(logdev_dev.lock)
> +{
> +	struct logdev_mark_probe *p = NULL;
> +	loff_t l = 0;
> +
> +	list_for_each_entry(p, &logdev_probes, list) {
> +		if (l++ >= *pos)
> +			break;
> +	}
> +
> +	if (&p->list == &logdev_probes)
> +		return NULL;
> +
> +	(*pos)++;
> +
> +	return p;
> +}
> +
> +static void __kprobes s_stop(struct seq_file *m, void *p)
> +	__releases(logdev_dev.lock)
> +{
> +}
> +
> +static int __kprobes s_show(struct seq_file *m, void *v)
> +{
> +	struct logdev_mark_probe *lm = v;
> +	int i;
> +
> +	seq_printf(m, "probe address:\t%p\n", (void*)lm->address);
> +	seq_printf(m, "func address:\t%p\n", (void*)lm->func.func0);
> +	seq_printf(m, "args:\t\t%d\n", lm->args);
> +	for (i=0; i < lm->args; i++) {
> +		seq_printf(m, "arg %d reg:\t%s\n",
> +			   i, logdev_reg_to_name(lm->arg_regs[i]));
> +	}
> +	seq_printf(m,"\n");
> +	return 0;
> +}
> +
> +static struct seq_operations logdev_seq_op = {
> +	.start = s_start,
> +	.next = s_next,
> +	.stop = s_stop,
> +	.show = s_show,
> +};
> +
> +/******************* end list kprobes *****************/
> +
> +static int logdev_mark_open (struct inode *inode, struct file *filp)
> +{
> +	int ret;
> +
> +	ret = seq_open(filp, &logdev_seq_op);
> +	if (!ret) {
> +		struct seq_file *m = filp->private_data;
> +		m->private = inode->u.generic_ip;
> +	}
> +
> +	return ret;
> +}
> +
> +
> +static struct file_operations logdev_mark_fops = {
> +	.read		= seq_read,
> +	.ioctl		= logdev_mark_ioctl,
> +	.open		= logdev_mark_open,
> +	.llseek		= seq_lseek,
> +	.release	= seq_release,
> +};
> +
> +/************************ End User Land ******************************/
> +
> +
> +extern unsigned long __logdev_marker_start;
> +extern unsigned long __logdev_marker_end;
> +
> +static int __init logdev_marker_init(void)
> +{
> +	unsigned long *p;
> +	struct logdev_mark_probe *probe;
> +
> +	debugfs_create_file("marker", 0600, logdev_d,
> +			    NULL, &logdev_mark_fops);
> +
> +	logdev_register_callback(LOGMARK_ID_MARK, logdev_mark_callback);
> +
> +	/*
> +	 * Arch must make sure that these are aligned by sizeof(long)
> +	 *
> +	 *  (p is incremented in the loop)
> +	 */
> +	for (p = &__logdev_marker_start; p < &__logdev_marker_end; ) {
> +		int i;
> +
> +		probe = kzalloc(sizeof(*probe), GFP_KERNEL);
> +		if (!probe) {
> +			printk(KERN_WARNING "logdev_marker: ran out of memory!\n");
> +			break;
> +		}
> +		probe->address = *p++;
> +		probe->func.func0 = (logdev_func0_t)*p++;
> +		probe->args = *p++;
> +		if (probe->args > MAX_ARGS) {
> +			printk(KERN_WARNING "logdev_marker: corrupted mark section\n");
> +			kfree(probe);
> +			break;
> +		}
> +		for (i=0; i < probe->args; i++) {
> +			probe->arg_regs[i] = logdev_mark_get_reg(*p++);
> +			if (probe->arg_regs[i] < 0)
> +				break;
> +		}
> +		if (i < probe->args) {
> +			printk(KERN_WARNING "logdev_marker: unknown reg\n");
> +			kfree(probe);
> +			break;
> +		}
> +
> +		list_add(&probe->list, &logdev_probes);
> +	}
> +
> +	return 0;
> +}
> +
> +module_init(logdev_marker_init);
> Index: linux-2.6.18/mm/memory.c
> ===================================================================
> --- linux-2.6.18.orig/mm/memory.c	2006-10-06 21:06:52.000000000 -0400
> +++ linux-2.6.18/mm/memory.c	2006-10-06 21:20:10.000000000 -0400
> @@ -49,6 +49,7 @@
>  #include <linux/module.h>
>  #include <linux/delayacct.h>
>  #include <linux/init.h>
> +#include <linux/logdev_marker.h>
>  
>  #include <asm/pgalloc.h>
>  #include <asm/uaccess.h>
> @@ -2326,6 +2327,8 @@ int __handle_mm_fault(struct mm_struct *
>  	pmd_t *pmd;
>  	pte_t *pte;
>  
> +	LD_MARK4(mm_fault, mm, vma, address, write_access);
> +
>  	__set_current_state(TASK_RUNNING);
>  
>  	count_vm_event(PGFAULT);
> 
> 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
