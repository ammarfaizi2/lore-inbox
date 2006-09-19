Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWISSvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWISSvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWISSvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:51:47 -0400
Received: from xenotime.net ([66.160.160.81]:34187 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750903AbWISSvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:51:46 -0400
Date: Tue, 19 Sep 2006 11:51:41 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Tom Zanussi <zanussi@us.ibm.com>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap@sources.redhat.com, ltt-dev@shafik.org
Subject: Re: [PATCH] Linux Kernel Markers 0.2 for Linux 2.6.17
In-Reply-To: <20060919183447.GA16095@Krystal>
Message-ID: <Pine.LNX.4.58.0609191140370.5184@shark.he.net>
References: <20060919183447.GA16095@Krystal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006, Mathieu Desnoyers wrote:

> Good afternoon,
>
> Following some very interesting ideas from Martin that shows that even
> static function calls and inlined functions can be used in interesting
> ways with markers to deploy dynamic tracers with easy access to local
> function variables, I send this slightly improved version of Linux Kernel
> Markers.
>
> It has the same capabilities as the previous one and additionnaly checks
> for string format consistency in every kernel configuration. The idea
> behind this is to be told be the compiler as soon as a marker is broken.
>
> These last emails convince me even more that a markup mechanism must
> interface with every kind of instrumentation hooking we can think about,
> both dynamic and static.
>
> Mathieu
>
> --- BEGIN ---
>
> --- a/arch/i386/Kconfig
> +++ b/arch/i386/Kconfig
> @@ -1082,6 +1082,8 @@ config KPROBES
>  	  for kernel debugging, non-intrusive instrumentation and testing.
>  	  If in doubt, say "N".
>
> +source "kernel/Kconfig.marker"
> +
>  source "ltt/Kconfig"
>
>  endmenu
> --- /dev/null
> +++ b/include/asm-i386/marker.h
> @@ -0,0 +1,12 @@
> +/*****************************************************************************
> + * marker.h
> + *
> + * Code markup for dynamic and static tracing. i386 support.
> + *
> + * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> + *
> + * September 2006
> + */
> +
> +#define JPROBE_TARGET \
> +	__asm__ ( GENERIC_NOP5 )

Too many spaces; use:
	__asm__ (GENERIC_NOP5)

> --- /dev/null
> +++ b/include/linux/marker.h
> @@ -0,0 +1,93 @@
> +/*****************************************************************************
> + * marker.h
> + *
> + * Code markup for dynamic and static tracing.
> + *
> + * Use either :
> + * MARK
> + * MARK_NOPRINT (will never call printk)
> + * MARK_STATIC (not dynamically instrumentable, will never call printk)
> + *
> + * Example :
> + *
> + * MARK(subsystem_event, "%d %s", someint, somestring);
> + * Where :
> + * - Subsystem is the name of your subsystem.
> + * - event is the name of the event to mark.
> + * - "%d %s" is the formatted string for printk.
> + * - someint is an integer.
> + * - somestring is a char *.
> + * - subsystem_event must be unique thorough the kernel!
> + *
> + * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> + *
> + * September 2006
> + */
> +
> +#include <asm/marker.h>
> +
> +#define MARK_SYM(event) \
> +	__asm__ ( "__mark_" #event ":" )
> +
> +#define MARK_INACTIVE(event, format, args...) \
> +	__mark_check_format(format, ## args)
> +
> +#define MARK_PRINT(event, format, args...) \
> +	do { \
> +		__mark_check_format(format, ## args); \
> +		printk(#event ": " format, ## args); \
> +	} while(0)
> +
> +#define MARK_FPROBE(event, format, args...) \
> +	do { \
> +		__mark_check_format(format, ## args); \
> +		fprobe_##event(args); \
> +	} while(0)
> +
> +#define MARK_KPROBE(event, format, args...) \
> +	do { \
> +		__mark_check_format(format, ## args); \
> +		MARK_SYM(event); \
> +	} while(0)
> +
> +#define MARK_JPROBE(event, format, args...) \
> +	do { \
> +		__mark_check_format(format, ## args); \
> +		MARK_SYM(event); \
> +		JPROBE_TARGET; \
> +	} while(0)
> +
> +/* Menu configured markers */
> +#ifndef CONFIG_MARK
> +#define MARK	MARK_INACTIVE
> +#elif defined(CONFIG_MARK_PRINT)
> +#define MARK	MARK_PRINT
> +#elif defined(CONFIG_MARK_FPROBE)
> +#define MARK	MARK_FPROBE
> +#elif defined(CONFIG_MARK_KPROBE)
> +#define MARK	MARK_KPROBE
> +#elif defined(CONFIG_MARK_JPROBE)
> +#define MARK	MARK_JPROBE
> +#endif
> +
> +#ifndef CONFIG_MARK_NOPRINT
> +#define MARK_NOPRINT	MARK_INACTIVE
> +#elif defined(CONFIG_MARK_NOPRINT_FPROBE)
> +#define MARK_NOPRINT	MARK_FPROBE
> +#elif defined(CONFIG_MARK_NOPRINT_KPROBE)
> +#define MARK_NOPRINT	MARK_KPROBE
> +#elif defined(CONFIG_MARK_NOPRINT_JPROBE)
> +#define MARK_NOPRINT	MARK_JPROBE
> +#endif
> +
> +#ifndef CONFIG_MARK_STATIC
> +#define MARK_STATIC	MARK_INACTIVE
> +#else
> +#define MARK_STATIC	MARK_FPROBE
> +#endif
> +
> +static inline void __mark_check_format(const char *fmt, ...)
> +	__attribute__ ((format (printf, 1, 2)));
> +void __mark_check_format(const char *fmt, ...) {  }

That last line is confusing (to me).  What's it for?
Is it just an empty (inline) function definition?
If so, why repeat the void + function name?

> --- /dev/null
> +++ b/kernel/Kconfig.marker
> @@ -0,0 +1,75 @@
> +# Code markers configuration
> +
> +menu "Marker configuration"
> +
> +
> +config MARK
> +	bool "Enable MARK code markers"
> +	default y

Please justify using 'y' as the default value.

> +	help
> +	  Activate markers that can call printk or can be instrumented
> +	  dynamically.
> +
> +choice
> +	prompt "MARK code marker behavior"
> +	default MARK_KPROBE
> +	depends on MARK
> +	help
> +	  Configuration of markers that can call printk or can be
> +	  instrumented dynamically.
> +
> +config MARK_KPROBE
> +	bool "KPROBE"
> +	---help---
> +	Change markers for a symbol "__mark_modulename_event".

Indent help text by 2 spaces (above & below here).

> +config MARK_JPROBE
> +	bool "JPROBE"
> +	---help---
> +	Change markers for a symbol "__mark_modulename_event"
> +	and create a target for a high speed dynamic probe.
> +config MARK_FPROBE
> +	bool "FPROBE"
> +	---help---
> +	Change markers for a function call.
> +config MARK_PRINT
> +	bool "PRINT"
> +	---help---
> +	Call printk from the marker.
> +endchoice
> +
> +config MARK_NOPRINT
> +	bool "Enable MARK_NOPRINT code markers"
> +	default y
> +	help
> +	  Activate markers that cannot call printk.
> +
> +choice
> +	prompt "MARK_NOPRINT code marker behavior"
> +	default MARK_NOPRINT_KPROBE
> +	depends on MARK_NOPRINT
> +	help
> +	  Configuration of markers that cannot call printk.
> +
> +config MARK_NOPRINT_KPROBE
> +	bool "KPROBE"
> +	---help---
> +	Change markers for a symbol "__mark_modulename_event".
> +config MARK_NOPRINT_JPROBE
> +	bool "JPROBE"
> +	---help---
> +	Change markers for a symbol "__mark_modulename_event"
> +	and create a target for a high speed dynamic probe.
> +config MARK_NOPRINT_FPROBE
> +	bool "FPROBE"
> +	---help---
> +	Change markers for a function call.
> +endchoice
> +
> +config MARK_STATIC
> +	bool "Enable MARK_STATIC code markers"
> +	default n
> +	help
> +	  Activate markers that cannot be instrumented dynamically. They will
> +	  generate function calls to each function-style probe.
> +
> +endmenu
>
> --- END ---

-- 
~Randy
