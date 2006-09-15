Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWIOPEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWIOPEt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWIOPEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:04:49 -0400
Received: from tomts36.bellnexxia.net ([209.226.175.93]:15532 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751617AbWIOPEs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:04:48 -0400
Date: Fri, 15 Sep 2006 11:04:44 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Michel Dagenais <michel.dagenais@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915150444.GA11834@Krystal>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <1158247596.5068.19.camel@localhost> <20060914174830.GA19720@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060914174830.GA19720@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 10:36:57 up 23 days, 11:45,  4 users,  load average: 0.37, 0.26, 0.20
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Michel Dagenais <michel.dagenais@polymtl.ca> wrote:
> 
> > This is the crucial point. Using an INT3 at each dynamic tracepoint is 
> > both costly and is a larger perturbation on the system under study. 
> > [...]
> 
> have you measured this?
> 

Hi Ingo,

A very quick test (yes, done in user space, but should be accurate enough for
our needs) on a pentium 4 3 GHz shows that generating a int3 breakpoint in a
loop (connected to an empty handler) takes an average of 2.01탎 per breakpoint.

LTT has an impact of about 0.220탎 per probe (10 times smaller).

Please refer to this kind of high event rate workload :
http://www.listserv.shafik.org/pipermail/ltt-dev/2005-December/001139.html

On the same pentium 4, 3 GHz (in the following results, I do not consider the
fact that the CPU had hyperthreading enabled) :

Probe execution time at probe site : 220ns/event

220ns * 9588836 events = 2.11s

Event rate : 749994 events per second

LTT :
749994 events/s * 0.220탎/event = 16.5 % of cpu time

With a breakpoint :
749994 events/s * 2.01탎/event = 150 % of cpu time


Considering the limitations of these tests :
- int3 timings taken from user space, which implies calling an empty handler in
  user space.
- The machine had hyperthreading enabled, but considered UP here.

It shows that tracing the same workload with breakpoints would make the machine
more than twice slower when a direct memory write has a relatively small impact
(16.5% of cpu time spent in probes).

In high event rate/low perturbation scenarios where instrumentation is put at
arbitrary locations in the code, it shows necessary to use the static
instrumentation alternative because the breakpoint approach is just too slow.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
