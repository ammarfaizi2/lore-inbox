Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWJERHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWJERHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWJERHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:07:05 -0400
Received: from tomts22.bellnexxia.net ([209.226.175.184]:29065 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932170AbWJERHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:07:01 -0400
Date: Thu, 5 Oct 2006 13:01:32 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, fche@redhat.com,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [RFC] The New and Improved Logdev (now with kprobes!)
Message-ID: <20061005170132.GA11149@Krystal>
References: <1160025104.6504.30.camel@localhost.localdomain> <20061005143133.GA400@Krystal> <Pine.LNX.4.58.0610051054300.28606@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0610051054300.28606@gandalf.stny.rr.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 12:08:43 up 43 days, 13:17,  5 users,  load average: 0.23, 0.22, 0.28
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Rostedt (rostedt@goodmis.org) wrote:
> > It would be great to have this logging information recorded into a standardized
> > buffer format so it could be analyzed with data gathered by other
> > instrumentation. Instead of using Tom's relay mechanism directly, you might
> > want to have a look at LTTng (http://ltt.polymtl.ca) : it would be a simple
> > matter of describing your own facility (group of event), the data types they
> > record, run genevent (serialization code generator) and call those
> > serialization functions when you want to record to the buffers from logdev.
> 
> Hmm, interesting. But at the mean time, what you describe seems a little
> out of scope with logdev. This doesn't mean that it can't be applied, now
> or later.  But currently, I do use logdev for 90% debugging and 10%
> analyzing.  Perhaps for the analyzing part, this would be useful.  I have
> to admit, I didn't get far trying to convert LTTng to 2.6.18. Didn't have
> the time. Ah, I see you have a patch there now for 2.6.18.  Adding this
> would be good to do.  But unfortunately, my time is currently very limited
> (who's isn't. But mine currently is more limited than it usually is).
> 

Usage of LTTng that I am aware of are not limited to analysis : some users,
Autodesk for instance, use its user space tracing capabilities extensively to
find deadlocks and deadline misses in their video applications. That I have
found is that having both some general overview of the system in the same trace
where the debugging information sits is a very powerful aid to developers.

> When things slow down for me a little, I'll see where you are at, and take
> a look.  Something we can also discuss at the next OLS.
> 

Sure, I'll be glad to discuss about it.

> To logdev, speed of the trace is important, but not that important.
> Accuracy of the trace is the most important.  Originally, I had a single
> buffer, and would use spinlocks to protect it.  All CPUs would share this
> buffer. The reason for this, is I wanted simple code to prove that the
> sequence events really did happen in a certain order.  I just recently
> changed the ring buffer to use a lockless buffer per cpu, but I still
> question it's accuracy. But I guess it does make things faster now.
> 

That's why I directly use the timestamp counter (when synchronized) of the CPUs.
I do not rely on the kernel time base when it is not needed. As I use the
timestamps to merge the events from the multiple buffers, they must be as
accurate as possible.

> >
> > I think it would be great to integrate those infrastructures together so we can
> > easily merge information coming from various sources (markers, logdev, systemTAP
> > scripts, LKET).
> 
> The one argument I have against this, is that some of these have different
> objectives.  Merging too much can dilute the objective of the app.  But I
> do think that a cooperation between the tools would be nice.
> 

Yes, I don't think that it sould become "one" big project, just that each
project should be able to interface with others.

> I know I said I'm staying out of the debate, but I need to ask this
> anyway.  Couldn't LTTng be fully implemented with dynamic traces? And if
> so, then what would be the case, to get that into the kernel, and then
> maintain a separate patch to convert those dynamic traces into static
> onces where performance is critical.  This way, you can get the
> infrastructure into the kernel, and get more eyes on it. Also make the
> patch smaller.
> 

It its current state, LTTng is already splitted into such pieces. The parts
that are the most highly reusable are :

- Code markup mechanism (markers)
- Serialization mechanism (facilities) within probes (ltt-probes kernel
  modules) dynamically connected to markers.
- Tracing control mechanism (ltt-tracer, ltt-control)
- Buffer management mechanism (ltt-relay)

To answer your question, I will distinguish elements of this "dynamic"
term that is so widely used :

* Dynamic probe connexion

LTTng 0.6.0 now supports dynamic probe connexion on the markers. A probe is a
dynamically loadable kernel module. It supports load/unload of these modules.

* Dynamic registration of new events/event record types

LTTng supports such dynamic registration since the 0.5.x series.

* Probe placement

What makes debugging information based probe placement unsuitable as the only
option for LTTng :
- inability to extract all the local variables
- performance impact
- inability to follow the kernel code changes as well as a marker inserted
  in the code itself.

Regards,

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
