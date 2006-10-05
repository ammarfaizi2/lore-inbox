Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWJEUSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWJEUSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWJEUSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:18:25 -0400
Received: from tomts40-srv.bellnexxia.net ([209.226.175.97]:8128 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751214AbWJEUSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:18:24 -0400
Date: Thu, 5 Oct 2006 16:18:20 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Daniel Walker <dwalker@mvista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, fche@redhat.com,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [RFC] The New and Improved Logdev (now with kprobes!)
Message-ID: <20061005201820.GA1865@Krystal>
References: <1160025104.6504.30.camel@localhost.localdomain> <20061005143133.GA400@Krystal> <Pine.LNX.4.58.0610051054300.28606@gandalf.stny.rr.com> <20061005170132.GA11149@Krystal> <Pine.LNX.4.58.0610051309090.30291@gandalf.stny.rr.com> <1160072999.6660.5.camel@c-67-180-230-165.hsd1.ca.comcast.net> <Pine.LNX.4.58.0610051438010.31280@gandalf.stny.rr.com> <1160074147.6660.10.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1160074147.6660.10.camel@c-67-180-230-165.hsd1.ca.comcast.net>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:13:33 up 43 days, 17:22,  6 users,  load average: 0.25, 0.28, 0.41
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Walker (dwalker@mvista.com) wrote:
> On Thu, 2006-10-05 at 14:38 -0400, Steven Rostedt wrote:
> > On Thu, 5 Oct 2006, Daniel Walker wrote:
> > 
> > > On Thu, 2006-10-05 at 14:09 -0400, Steven Rostedt wrote:
> > >
> > > >
> > > > My problem with using a timestamp, is that I ran logdev on too many archs.
> > > > So I need to have a timestamp that I can get to that is always reliable.
> > > > How does LTTng get the time for different archs?  Does it have separate
> > > > code for each arch?
> > > >
> > >
> > > I just got done updating a patchset that exposes the clocksources from
> > > generic time to take low level time stamps.. But even without that you
> > > can just call gettimeofday() directly to get a timestamp .
> > >
> > 
> > unless you're tracing something that his holding the xtime_lock ;-)
> 
> That's part of the reason for the changes that I made to the clocksource
> API . It makes it so instrumentation, with other things, can generically
> read a low level cycle clock. Like on PPC you would read the
> decrementer, and on x86 you would read the TSC . However, the
> application has no idea what it's reading.
> 
> I submitted one version to LKML already, but I'm planning to submit
> another version shortly.
> 

Just as a detail : LTTng traces NMI, which can happen on top of a
xtime_lock. So yes, I have to consider the impact of this kind of lock when I
choose my time source, which is currently a per architecture TSC read,
or a read of the jiffies counter when the architecture does not have a
synchronised TSC over the CPUs. This is abstracted in include/asm-*/ltt.h.

I know it doesn't support dynamic ticks, I'm working on using the HRtimers
instead, but I must make sure that the seqlock read will fail if it nests over
a write seqlock.

MAthieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
