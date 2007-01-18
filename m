Return-Path: <linux-kernel-owner+w=401wt.eu-S965005AbXASJTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbXASJTJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 04:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbXASJTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 04:19:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1245 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965005AbXASJTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 04:19:08 -0500
Date: Thu, 18 Jan 2007 16:54:48 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch] Extend support for PM_TRACE to include x86_64
Message-ID: <20070118165447.GA5199@ucw.cz>
References: <1168859098.4417.3.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168859098.4417.3.camel@nigel.suspend2.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch adds support for PM_TRACE for the x86_64 architecture. Thanks
> to Linus for help with my asm ignorance.
> 
> Please apply.
> 
> Signed-off-by: Nigel Cunningham <nigel@nigel.suspend2.net>

Ack, looks nice to me. i386 code does not belong to generic headers,
anyway...

							Pavel

>  arch/x86_64/kernel/vmlinux.lds.S  |    7 +++++++
>  drivers/base/power/trace.c        |    4 +++-
>  include/asm-i386/resume-trace.h   |   21 +++++++++++++++++++++
>  include/asm-x86_64/resume-trace.h |   21 +++++++++++++++++++++
>  include/linux/resume-trace.h      |   19 ++-----------------
>  kernel/power/Kconfig              |    2 +-
>  scripts/kconfig/mconf             |binary
>  7 files changed, 55 insertions(+), 19 deletions(-)
> diff -ruNp 930-PM_TRACE.patch-old/arch/x86_64/kernel/vmlinux.lds.S 930-PM_TRACE.patch-new/arch/x86_64/kernel/vmlinux.lds.S
> --- 930-PM_TRACE.patch-old/arch/x86_64/kernel/vmlinux.lds.S	2007-01-15 22:00:39.000000000 +1100
> +++ 930-PM_TRACE.patch-new/arch/x86_64/kernel/vmlinux.lds.S	2007-01-15 00:00:08.000000000 +1100
> @@ -54,6 +54,13 @@ SECTIONS
>  
>    BUG_TABLE
>  
> +  . = ALIGN(4);
> +  .tracedata : AT(ADDR(.tracedata) - LOAD_OFFSET) {
> +  	__tracedata_start = .;
> +	*(.tracedata)
> +  	__tracedata_end = .;
> +  }
> +
>    . = ALIGN(PAGE_SIZE);        /* Align data segment to page size boundary */
>  				/* Data */
>    .data : AT(ADDR(.data) - LOAD_OFFSET) {
> diff -ruNp 930-PM_TRACE.patch-old/drivers/base/power/trace.c 930-PM_TRACE.patch-new/drivers/base/power/trace.c
> --- 930-PM_TRACE.patch-old/drivers/base/power/trace.c	2007-01-11 18:25:02.000000000 +1100
> +++ 930-PM_TRACE.patch-new/drivers/base/power/trace.c	2007-01-15 00:00:08.000000000 +1100
> @@ -142,6 +142,7 @@ void set_trace_device(struct device *dev
>  {
>  	dev_hash_value = hash_string(DEVSEED, dev->bus_id, DEVHASH);
>  }
> +EXPORT_SYMBOL(set_trace_device);
>  
>  /*
>   * We could just take the "tracedata" index into the .tracedata
> @@ -162,6 +163,7 @@ void generate_resume_trace(void *traceda
>  	file_hash_value = hash_string(lineno, file, FILEHASH);
>  	set_magic_time(user_hash_value, file_hash_value, dev_hash_value);
>  }
> +EXPORT_SYMBOL(generate_resume_trace);
>  
>  extern char __tracedata_start, __tracedata_end;
>  static int show_file_hash(unsigned int value)
> @@ -170,7 +172,7 @@ static int show_file_hash(unsigned int v
>  	char *tracedata;
>  
>  	match = 0;
> -	for (tracedata = &__tracedata_start ; tracedata < &__tracedata_end ; tracedata += 6) {
> +	for (tracedata = &__tracedata_start ; tracedata < &__tracedata_end ; tracedata += 2 + sizeof(unsigned long)) {
>  		unsigned short lineno = *(unsigned short *)tracedata;
>  		const char *file = *(const char **)(tracedata + 2);
>  		unsigned int hash = hash_string(lineno, file, FILEHASH);
> diff -ruNp 930-PM_TRACE.patch-old/include/asm-i386/resume-trace.h 930-PM_TRACE.patch-new/include/asm-i386/resume-trace.h
> --- 930-PM_TRACE.patch-old/include/asm-i386/resume-trace.h	1970-01-01 10:00:00.000000000 +1000
> +++ 930-PM_TRACE.patch-new/include/asm-i386/resume-trace.h	2007-01-15 22:00:33.000000000 +1100
> @@ -0,0 +1,21 @@
> +#ifndef ARCH_RESUME_TRACE_H
> +#define ARCH_RESUME_TRACE_H
> +
> +#ifdef CONFIG_PM_TRACE
> +#define TRACE_RESUME(user) do {					\
> +	if (pm_trace_enabled) {					\
> +		void *tracedata;				\
> +		asm volatile("movl $1f,%0\n"			\
> +			".section .tracedata,\"a\"\n"		\
> +			"1:\t.word %c1\n"			\
> +			"\t.long %c2\n"				\
> +			".previous"				\
> +			:"=r" (tracedata)			\
> +			: "i" (__LINE__), "i" (__FILE__));	\
> +		generate_resume_trace(tracedata, user);		\
> +	}							\
> +} while (0)
> +#else
> +#define TRACE_RESUME(user) do { } while (0)
> +#endif
> +#endif
> diff -ruNp 930-PM_TRACE.patch-old/include/asm-x86_64/resume-trace.h 930-PM_TRACE.patch-new/include/asm-x86_64/resume-trace.h
> --- 930-PM_TRACE.patch-old/include/asm-x86_64/resume-trace.h	1970-01-01 10:00:00.000000000 +1000
> +++ 930-PM_TRACE.patch-new/include/asm-x86_64/resume-trace.h	2007-01-15 22:00:45.000000000 +1100
> @@ -0,0 +1,21 @@
> +#ifndef ARCH_RESUME_TRACE_H
> +#define ARCH_RESUME_TRACE_H
> +
> +#ifdef CONFIG_PM_TRACE
> +#define TRACE_RESUME(user) do {					\
> +	if (pm_trace_enabled) {					\
> +		void *tracedata;				\
> +		asm volatile("movq $1f,%0\n"			\
> +			".section .tracedata,\"a\"\n"		\
> +			"1:\t.word %c1\n"			\
> +			"\t.quad %c2\n"				\
> +			".previous"				\
> +			:"=r" (tracedata)			\
> +			: "i" (__LINE__), "i" (__FILE__));	\
> +		generate_resume_trace(tracedata, user);		\
> +	}							\
> +} while (0)
> +#else
> +#define TRACE_RESUME(user) do { } while (0)
> +#endif
> +#endif
> diff -ruNp 930-PM_TRACE.patch-old/include/linux/resume-trace.h 930-PM_TRACE.patch-new/include/linux/resume-trace.h
> --- 930-PM_TRACE.patch-old/include/linux/resume-trace.h	2007-01-11 18:25:16.000000000 +1100
> +++ 930-PM_TRACE.patch-new/include/linux/resume-trace.h	2007-01-15 00:00:08.000000000 +1100
> @@ -1,6 +1,8 @@
>  #ifndef RESUME_TRACE_H
>  #define RESUME_TRACE_H
>  
> +#include <asm/resume-trace.h>
> +
>  #ifdef CONFIG_PM_TRACE
>  
>  extern int pm_trace_enabled;
> @@ -10,25 +12,8 @@ extern void set_trace_device(struct devi
>  extern void generate_resume_trace(void *tracedata, unsigned int user);
>  
>  #define TRACE_DEVICE(dev) set_trace_device(dev)
> -#define TRACE_RESUME(user) do {					\
> -	if (pm_trace_enabled) {					\
> -		void *tracedata;				\
> -		asm volatile("movl $1f,%0\n"			\
> -			".section .tracedata,\"a\"\n"		\
> -			"1:\t.word %c1\n"			\
> -			"\t.long %c2\n"				\
> -			".previous"				\
> -			:"=r" (tracedata)			\
> -			: "i" (__LINE__), "i" (__FILE__));	\
> -		generate_resume_trace(tracedata, user);		\
> -	}							\
> -} while (0)
> -
>  #else
> -
>  #define TRACE_DEVICE(dev) do { } while (0)
> -#define TRACE_RESUME(dev) do { } while (0)
> -
>  #endif
>  
>  #endif
> diff -ruNp 930-PM_TRACE.patch-old/kernel/power/Kconfig 930-PM_TRACE.patch-new/kernel/power/Kconfig
> --- 930-PM_TRACE.patch-old/kernel/power/Kconfig	2007-01-15 22:00:40.000000000 +1100
> +++ 930-PM_TRACE.patch-new/kernel/power/Kconfig	2007-01-15 00:00:08.000000000 +1100
> @@ -50,7 +50,7 @@ config DISABLE_CONSOLE_SUSPEND
>  
>  config PM_TRACE
>  	bool "Suspend/resume event tracing"
> -	depends on PM && PM_DEBUG && X86_32 && EXPERIMENTAL
> +	depends on PM && PM_DEBUG && (X86_32 || X86_64) && EXPERIMENTAL
>  	default n
>  	---help---
>  	This enables some cheesy code to save the last PM event point in the
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
