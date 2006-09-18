Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751793AbWIRPus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbWIRPus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWIRPus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:50:48 -0400
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:23950 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751793AbWIRPur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:50:47 -0400
Date: Mon, 18 Sep 2006 11:45:32 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918154532.GF15605@Krystal>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060918150231.GA8197@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 11:23:41 up 26 days, 12:32,  5 users,  load average: 0.74, 0.60, 0.57
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

If it is less visually intrusive to declare markers as a macro, let's do it this
way. I have no preference : as long as both dynamic probes and static ones can
be hooked and that it does imply so much black magic that kernel developers
won't know what code will be called from the marker when tracing is enabled.

Back in 2005, I made a quick macro example that would benefit to everybody. It
changes following config options to either :

- nothing
- a call to printk
- a call to a static tracer (either inline function or a real call)
- no operations (a 5 bytes site for an enhanced kprobe)

The 5 bytes of NOOP used here is absolutely not the way to go : djprobes guys
has much better alternatives.

Note that this example is a userspace program that can be trivially moved to a
kernel header (printf->printk, etc).

I also wanted to identify the trace point by a symbol, so it could be easily
found dynamically, but this part is not completed.

What are your thoughts about it ? (think of it as a proof of concept, and
search+replace MAGIC_TRACE for MARK). :)


Mathieu


----- BEGIN -----


/* ltt-macro.c
 *
 * Macro example for instrumentation
 *
 * Version 0.0.1
 * 
 * Mathieu Desnoyers mathieu.desnoyers@polymtl.ca
 *
 * This is released under the GPL v2 (or better) license.
 */



/* This is an example of noop, get this from the current arch header */
#define GENERIC_NOP1    ".byte 0x90\n"


/* PUT THIS IN A INCLUDE/LINUX HEADER */

#define __stringify_1(x) #x //see include/linux/stringify.h
#define __stringify(x) __stringify_1(x)

#define KBUILD_BASENAME basename
#define KBUILD_MODNAME modulename

#define MAGIC_TRACE_SYM(event)	\
	char * __trace_symbol_##event =__stringify(KBUILD_MODNAME) "_" \
					__stringify(KBUILD_BASENAME) "_" \
					#event ;

/* With config menu mutual exclusion of choice */
#ifdef CONFIG_NOLOG
#define MAGIC_TRACE(event, format, args...)
#endif

#ifdef CONFIG_PRINTLOG
#define MAGIC_TRACE(event, format, args...) \
	printf(format, ##args);
#endif

#ifdef CONFIG_TRACELOG
#define MAGIC_TRACE(event, format, args...) \
	trace_##event( args );
#endif

#ifdef CONFIG_KPROBELOG
#define MAGIC_TRACE(event, format, args...) \
	__asm__ ( GENERIC_NOP1 GENERIC_NOP1 GENERIC_NOP1 GENERIC_NOP1 GENERIC_NOP1 )
#endif

/* PUT THIS IN A HEADER NEAR THE .C FILE */
#ifdef CONFIG_TRACELOG
static inline void trace_eventname(int a, char *b)
{
	/* log.... */
	printf("Tracing event : first arg %d, second arg %s", a, b);
}
#endif

/* PUT THIS IN THE .C FILE */

MAGIC_TRACE_SYM(eventname);

int main()
{
	int myint = 55;
	char * mystring = "blah";
	
	MAGIC_TRACE(eventname, "%d %s", myint, mystring);
	
	printf("\n");

	return 0;
}

------ END  -----




OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
