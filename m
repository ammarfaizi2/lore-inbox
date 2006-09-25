Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751818AbWIZAGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWIZAGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 20:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWIZAGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 20:06:40 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:44211 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751818AbWIZAGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 20:06:39 -0400
Date: Mon, 25 Sep 2006 19:56:17 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Karim Yaghmour <karim@opersys.com>, Pavel Machek <pavel@suse.cz>,
       Joe Perches <joe@perches.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.13 for 2.6.17
Message-ID: <20060925235617.GA3147@Krystal>
References: <20060925233349.GA2352@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060925233349.GA2352@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:51:23 up 33 days, 21:00,  3 users,  load average: 0.29, 0.13, 0.16
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just as a precision :

The following sequence (please refer to the code below for local symbols
1 and 2) :

1:
preempt_disable()
call (*__mark_call_##name)(format, ## args);
preempt_enable_no_resched()
2:

is insured because :

1 is part of an inline assembly with rw dependency on __marker_sequencer
the call is surrounded by memory barriers.
2 is part of an inline assembly with rw dependency on __marker_sequencer

Mathieu

* Mathieu Desnoyers (compudj@krystal.dyndns.org) wrote:
> +++ b/include/asm-generic/marker.h
> @@ -0,0 +1,22 @@
> +/*
> + * marker.h
> + *
> + * Code markup for dynamic and static tracing. Generic header.
> + * 
> + * This file is released under the GPLv2.
> + * See the file COPYING for more details.
> + */
> +
> +#define MARK_CALL(name, format, args...) \
> +	do { \
> +		static marker_probe_func *__mark_call_##name = \
> +					__mark_empty_function; \
> +		asm volatile(	".section .markers, \"a\";\n\t" \
> +				".long %1, %2;\n\t" \
> +				".previous;\n\t" : "+m" (__marker_sequencer) : \
> +			"m" (__mark_call_##name), \
> +			"m" (*format)); \
> +		preempt_disable(); \
> +		(*__mark_call_##name)(format, ## args); \
> +		preempt_enable_no_resched(); \
> +	} while(0)

> --- /dev/null
> +++ b/include/asm-i386/marker.h
> @@ -0,0 +1,30 @@
> +/*
> + * marker.h
> + *
> + * Code markup for dynamic and static tracing. i386 architecture optimisations.
> + *
> + * (C) Copyright 2006 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> + *
> + * This file is released under the GPLv2.
> + * See the file COPYING for more details.
> + */
> +
> +#include <asm-generic/marker.h>
> +
> +#define ARCH_HAS_MARK_JUMP
> +
> +/* Note : max 256 bytes between over_label and near_jump */
> +#define MARK_JUMP(name, format, args...) \
> +	do { \
> +		asm volatile(	".section .markers, \"a\";\n\t" \
> +				".long 0f, 1f, 2f;\n\t" \
> +				".previous;\n\t" \
> +				".align 16;\n\t" \
> +				".byte 0xeb;\n\t" \
> +				"0:\n\t" \
> +				".byte 2f-1f;\n\t" \
> +				"1:\n\t" \
> +			: "+m" (__marker_sequencer) : ); \
> +		MARK_CALL(name, format, ## args); \
> +		asm volatile (	"2:\n\t" : "+m" (__marker_sequencer) : ); \
> +	} while(0)
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
