Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751830AbWIRQaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbWIRQaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWIRQaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:30:46 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:32735 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751830AbWIRQap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:30:45 -0400
Date: Mon, 18 Sep 2006 12:30:42 -0400
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
Subject: MARKER mechanism, try 2
Message-ID: <20060918163042.GA15192@Krystal>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060918150231.GA8197@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 12:26:50 up 26 days, 13:35,  8 users,  load average: 0.37, 0.48, 0.44
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I played a bit with my marker proof of concept, it now makes a lot more sense.
Here it is. Comments are welcome.

It supports 5 modes :

- marker becomes nothing
- marker calls printk
- marker calls a tracer
- marker puts a symbol (for kprobe)
- marker puts a symbol and 5 NOPS for a jump probe.


Mathieu

-----BEGIN-----


/* Macro example for instrumentation
 *
 * Version 0.0.2
 * 
 * Mathieu Desnoyers mathieu.desnoyers@polymtl.ca
 *
 * This is released under the GPL v2 (or better) license.
 */

#include <stdio.h>

/* This is an example of noop, get this from the current arch header */
#define GENERIC_NOP1    ".byte 0x90\n"


/* PUT THIS IN A INCLUDE/LINUX HEADER */

#define __stringify_1(x) #x //see include/linux/stringify.h
#define __stringify(x) __stringify_1(x)

#define KBUILD_BASENAME basename
#define KBUILD_MODNAME modulename

#define MARK_SYM(event)	\
  __asm__ ( "__mark_"__stringify(KBUILD_MODNAME)"_"__stringify(KBUILD_BASENAME)"_"#event":" )

/* With config menu mutual exclusion of choice */
#ifdef CONFIG_NOLOG
#define MARK(event, format, args...)
#endif

#ifdef CONFIG_PRINTLOG
#define MARK(event, format, args...) \
	printf(format, ##args);
#endif

#ifdef CONFIG_TRACELOG
#define MARK(event, format, args...) \
	trace_##event( args );
#endif

#ifdef CONFIG_KPROBELOG
#define MARK(event, format, args...) \
  { \
    MARK_SYM(event); \
  }
#endif

#ifdef CONFIG_JUMPPROBELOG
#define MARK(event, format, args...) \
  { \
    MARK_SYM(event); \
	  __asm__ ( GENERIC_NOP1 GENERIC_NOP1 GENERIC_NOP1 GENERIC_NOP1 GENERIC_NOP1 ); \
  }
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

int main()
{
	int myint = 55;
	char * mystring = "blah";
	
	MARK(eventname, "%d %s", myint, mystring);
	
	printf("\n");

	return 0;
}





-----END-----



OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
