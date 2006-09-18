Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751861AbWIRRrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbWIRRrr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 13:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbWIRRrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 13:47:47 -0400
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:21446 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751861AbWIRRrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 13:47:46 -0400
Date: Mon, 18 Sep 2006 13:47:42 -0400
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
Subject: Re: MARKER mechanism, try 2
Message-ID: <20060918174742.GA27398@Krystal>
References: <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu> <20060918163042.GA15192@Krystal> <20060918162828.GA22910@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060918162828.GA22910@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:28:55 up 26 days, 14:37,  4 users,  load average: 0.52, 0.44, 0.36
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
> > It supports 5 modes :
> > 
> > - marker becomes nothing
> > - marker calls printk
> > - marker calls a tracer
> > - marker puts a symbol (for kprobe)
> > - marker puts a symbol and 5 NOPS for a jump probe.
> 
> just go for 'nothing' and the 5-NOP variant, and please implement 
> support for it from within LTT, via a kprobe - if you want me to support 
> this stuff for upstream inclusion. If we support any static tracer mode 
> and LTT does not support the kprobe mode then we are back to square 1 
> wrt. dependencies ...
> 

I am open to make LTTng support kprobes as a commodity (in fact, this point has
been on the LTTng project roadmap for almost a year). But in no way does it
solve the entire tracing problem. As an example, LTTng traces the page fault
handler, when kprobes just can't instrument it.

I keep thinking that a complete marker mechanism must have the ability to be
turned into function calls or inline functions when necessary.

Going further, we could think of a marker mechanism that would be aware of the
"difficulty" level of the probe, so that even if CONFIG_KPROBELOG is selected,
it would use a direct call or inlined function for probing the page fault
handler.

i.e. :

"normal" (nothing, kprobe, jumpprobe, printk or tracer)
MARK(eventname, "%d %s", myint, mystring);

"cannot be probed dynamically" (used in kprobes itself, page fault handler)
                               (only nothing or tracer)
MARK_NOPROBE(eventname, "%d %s", myint, mystring);

"cannot use printk" (used in scheduler, NMIs, wakeup, printk itself)
                    (nothing, kprobe, jumpprobe or tracer)
MARK_NOPRINT(eventname, "%d %s", myint, mystring);

Using the following table to select the mechanism :

Config/probe declaration     |   normal      |    noprobe    |     noprint
------------------------------------------------------------------------------
nothing                      |   nothing      |   nothing     |    nothing
kprobe                       |   kprobe       |   tracer      |    kprobe
jumpprobe                    |   jumpprobe    |   tracer      |    jumpprobe
printk                       |   printk       |   tracer      |    kprobe
tracer                       |   tracer       |   tracer      |    tracer

Therefore, selecting the "kprobe" configuration option would still let people
instrument the hardest paths while having mostly dynamic probes.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
