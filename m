Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWJBAHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWJBAHn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 20:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWJBAHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 20:07:43 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:35574 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932513AbWJBAHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 20:07:42 -0400
Date: Sun, 1 Oct 2006 20:07:32 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Nicholas Miell <nmiell@comcast.net>
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
Subject: Re: Performance analysis of Linux Kernel Markers 0.20 for 2.6.17
Message-ID: <20061002000731.GA22337@Krystal>
References: <20060930180157.GA25761@Krystal> <1159642933.2355.1.camel@entropy> <20061001034212.GB13527@Krystal> <1159676382.2355.13.camel@entropy> <20061001153317.GB24313@Krystal> <1159747060.2355.21.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1159747060.2355.21.camel@entropy>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 20:05:28 up 39 days, 21:14,  4 users,  load average: 0.21, 0.23, 0.24
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nicholas Miell (nmiell@comcast.net) wrote:
> On Sun, 2006-10-01 at 11:33 -0400, Mathieu Desnoyers wrote:
> > * Nicholas Miell (nmiell@comcast.net) wrote:
> > > On Sat, 2006-09-30 at 23:42 -0400, Mathieu Desnoyers wrote:
> > > > * Nicholas Miell (nmiell@comcast.net) wrote:
> > > > > 
> > > > > Has anyone done any performance measurements with the "regular function
> > > > > call replaced by a NOP" type of marker?
> > > > > 
> > > > 
> > > > Here it is (on the same setup as the other tests : Pentium 4, 3 GHz) :
> > > > 
> > > > * Execute an empty loop
> > > > 
> > > > - Without marker
> > > > NR_LOOPS : 10000000
> > > > time delta (cycles): 15026497
> > > > cycles per loop : 1.50
> > > > 
> > > > - With 5 NOPs
> > > > NR_LOOPS : 100000
> > > > time delta (cycles): 300157
> > > > cycles per loop : 3.00
> > > > added cycles per loop for nops : 3.00-1.50 = 1.50
> > > > 
> > > > 
> > > > * Execute a loop of memcpy 4096 bytes
> > > > 
> > > > - Without marker
> > > > NR_LOOPS : 10000
> > > > time delta (cycles): 12981555
> > > > cycles per loop : 1298.16
> > > > 
> > > > - With 5 NOPs
> > > > NR_LOOPS : 10000
> > > > time delta (cycles): 12983925
> > > > cycles per loop : 1298.39
> > > > added cycles per loop for nops : 0.23
> > > > 
> > > > 
> > > > If we compare this approach to the jump-over-call markers (in cycles per loop) :
> > > > 
> > > >               NOPs    Jump over call generic    Jump over call optimized
> > > > empty loop    1.50    1.17                      2.50 
> > > > memcpy        0.23    2.12                      0.07
> > > > 
> > > > 
> > > > 
> > > > Mathieu
> > > 
> > > What about with two NOPs (".byte 0x66, 0x66, 0x90, 0x66, 0x90" - this
> > > should work with everything) or one (".byte 0x0f, 0x1f, 0x44, 0x00,
> > > 0x00" - AFAIK, this should work with P6 or newer).
> > > 
> > > (Sorry, I should have mentioned this the first time.)
> > > 
> > 
> > Hi,
> > 
> > The tests I made were with : 
> > #define GENERIC_NOP1    ".byte 0x90\n"
> > #define GENERIC_NOP4        ".byte 0x8d,0x74,0x26,0x00\n"
> > #define GENERIC_NOP5        GENERIC_NOP1 GENERIC_NOP4
> > 
> > Now with the tests you ask for :
> > 
> > * Execute an empty loop
> > - 2 NOPs ".byte 0x66, 0x66, 0x90, 0x66, 0x90"
> > NR_LOOPS : 100000
> > time delta (cycles): 200190
> > cycles per loop : 2.00
> > cycles per loop for nops : 2.00-1.50 = 0.50
> > 
> > - 1 NOP "0x0f, 0x1f, 0x44, 0x00, 0x00"
> > NR_LOOPS : 100000
> > time delta (cycles): 300172
> > cycles per loop : 3.00
> > cycles per loop for nops : 3.00-1.50 = 2.50
> > 
> > 
> > * Execute a loop of memcpy 4096 bytes
> > - 2 NOPs ".byte 0x66, 0x66, 0x90, 0x66, 0x90"
> > NR_LOOPS : 10000
> > time delta (cycles): 12981293
> > cycles per loop : 1298.13
> > cycles per loop for nops : 1298.16-1298.13=0.03
> > 
> > - 1 NOP "0x0f, 0x1f, 0x44, 0x00, 0x00"
> > NR_LOOPS : 10000
> > time delta (cycles): 12985590
> > cycles per loop : 1298.56
> > cycles per loop for nops : 0.43
> > 
> 
> To summarize in chart form:
> 
>               	JoC	JoCo	2NOP	1NOP
> empty loop	1.17	2.50	0.50	2.50
> memcpy		2.12	0.07	0.03	0.43
> 
> JoC 	= Jump over call - generic
> JoCo	= Jump over call - optimized
> 2NOP	= "data16 data16 nop; data16 nop"
> 1NOP	= NOP with ModRM
> 
> I left out your "nop; lea 0(%esi), %esi" because it isn't actually a NOP
> (the CPU will do actual work even if it has no effect, and on AMD64,
> that insn is "nop; lea 0(%rdi), %esi", which will truncate RDI+0 to fit
> 32-bits.)
> 
> The performance of NOP with ModRM doesn't suprise me -- AFAIK, only the
> most recent of Intel CPUs actually special case that to be a true
> no-work-done NOP.
> 
> It'd be nice to see the results of "jump to an out-of-line call with the
> jump replaced by a NOP", but even if it performs well (and it should,
> the argument passing and stack alignment overhead won't be executed in
> the disabled probe case), actually using it in practice would be
> difficult without compiler support (call instructions are easy to find
> thanks to their relocations, which local jumps don't have).
> 

Hi,

Just to make sure we see things the same way : the JoC approach is similar to
the out-of-line call in that the argument passing and stack alignment are not
executed when the probe is disabled.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
