Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWJBAxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWJBAxK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 20:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWJBAxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 20:53:10 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:7929 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932546AbWJBAxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 20:53:06 -0400
Subject: Re: Performance analysis of Linux Kernel Markers 0.20 for 2.6.17
From: Nicholas Miell <nmiell@comcast.net>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Karim Yaghmour <karim@opersys.com>, Pavel Machek <pavel@suse.cz>,
       Joe Perches <joe@perches.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
In-Reply-To: <20061002000731.GA22337@Krystal>
References: <20060930180157.GA25761@Krystal>
	 <1159642933.2355.1.camel@entropy> <20061001034212.GB13527@Krystal>
	 <1159676382.2355.13.camel@entropy> <20061001153317.GB24313@Krystal>
	 <1159747060.2355.21.camel@entropy>  <20061002000731.GA22337@Krystal>
Content-Type: text/plain
Date: Sun, 01 Oct 2006 17:53:00 -0700
Message-Id: <1159750380.2355.41.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-01 at 20:07 -0400, Mathieu Desnoyers wrote:
> * Nicholas Miell (nmiell@comcast.net) wrote:
> > To summarize in chart form:
> > 
> >               JoC	JoCo	2NOP	1NOP
> > empty loop	1.17	2.50	0.50	2.50
> > memcpy	2.12	0.07	0.03	0.43
> > 
> > JoC 	= Jump over call - generic
> > JoCo	= Jump over call - optimized
> > 2NOP	= "data16 data16 nop; data16 nop"
> > 1NOP	= NOP with ModRM
> > 
> > I left out your "nop; lea 0(%esi), %esi" because it isn't actually a NOP
> > (the CPU will do actual work even if it has no effect, and on AMD64,
> > that insn is "nop; lea 0(%rdi), %esi", which will truncate RDI+0 to fit
> > 32-bits.)
> > 
> > The performance of NOP with ModRM doesn't suprise me -- AFAIK, only the
> > most recent of Intel CPUs actually special case that to be a true
> > no-work-done NOP.
> > 
> > It'd be nice to see the results of "jump to an out-of-line call with the
> > jump replaced by a NOP", but even if it performs well (and it should,
> > the argument passing and stack alignment overhead won't be executed in
> > the disabled probe case), actually using it in practice would be
> > difficult without compiler support (call instructions are easy to find
> > thanks to their relocations, which local jumps don't have).
> > 
> 
> Hi,
> 
> Just to make sure we see things the same way : the JoC approach is similar to
> the out-of-line call in that the argument passing and stack alignment are not
> executed when the probe is disabled.
> 

Yeah, I assumed that.

For the jump-over-call, you'll always have to do a test and a
conditional jump (even when the probe is disabled), and that test takes
work and that conditional jump will consume "useless" space in the
predictor cache.

For an unconditional-call-replaced-by-NOP, you'll always be doing the
work involved in the setup and cleanup for a function call, but there's
no conditional branching (which is a win, as your test results
demonstrate).

For the ideal case, you'd have a single unconditional jump to an
out-of-line function call, which you'd replace with a single NOP. No
unnecessary work (beyond the NOP instruction itself) gets done in the
disabled probe case, and in the enabled case, you don't have to do any
tests to see if the probe should be run. It should be an improvement all
around, if we could just get gcc to do the hard part of replacing the
unconditional jump with a NOP for us.

-- 
Nicholas Miell <nmiell@comcast.net>

