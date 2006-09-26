Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWIZAuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWIZAuu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 20:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWIZAuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 20:50:50 -0400
Received: from tomts36.bellnexxia.net ([209.226.175.93]:54488 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751668AbWIZAut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 20:50:49 -0400
Date: Mon, 25 Sep 2006 20:45:35 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Karim Yaghmour <karim@opersys.com>,
       Pavel Machek <pavel@suse.cz>, Joe Perches <joe@perches.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.13 for 2.6.17
Message-ID: <20060926004535.GA2978@Krystal>
References: <20060925233349.GA2352@Krystal> <20060925235617.GA3147@Krystal> <45187146.8040302@goop.org> <20060926002551.GA18276@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060926002551.GA18276@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 20:37:18 up 33 days, 21:45,  3 users,  load average: 0.08, 0.14, 0.18
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca) wrote:
> Yes, preempt_disable() has a barrier(), on gcc :
> __asm__ __volatile__("": : :"memory").
> 
> 
> > Either way, this doesn't prevent some otherwise unrelated 
> > non-memory-using code from being scheduled in there, which would not be 
> > executed.  The gcc manual really strongly discourages jumping between 
> > inline asms, because they have basically unpredictable results.
> > 
> 
> Ok, I will do the call in assembly then.
> 

Before I rush on a solution too fast... I have a question for you :

To protect code from being preempted, the macros preempt_disable and
preempt_enable must normally be used. Logically, this macro must make sure gcc
doesn't interleave preemptible code and non-preemptible code.

Starting with this hypothesis, what makes gcc aware of this ? If we check
preempt_disable (the disable call is almost symmetric) :

linux/preempt.h:
define add_preempt_count(val) do { preempt_count() += (val); } while (0)

#define inc_preempt_count() add_preempt_count(1)

#define preempt_disable() \
do { \
        inc_preempt_count(); \
        barrier(); \
} while (0)

So the magic must be in the barrier() macro :

linux/compiler-gcc.h:
/* Optimization barrier */
/* The "volatile" is due to gcc bugs */
#define barrier() __asm__ __volatile__("": : :"memory")

Which makes me think that if I put barriers around my asm, call, asm trio, no
other code will be interleaved. Is it right ?

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
