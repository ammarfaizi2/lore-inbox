Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWISPaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWISPaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWISPaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:30:08 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:40132 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751221AbWISPaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:30:06 -0400
Date: Tue, 19 Sep 2006 11:30:03 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: "Jose R. Santos" <jrs@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060919153003.GA2617@Krystal>
References: <1158320406.29932.16.camel@localhost.localdomain> <Pine.LNX.4.64.0609151339190.6761@scrub.home> <1158323938.29932.23.camel@localhost.localdomain> <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain> <450AEC92.7090409@us.ibm.com> <20060915194937.GA7133@Krystal> <450B1309.9020800@us.ibm.com> <20060915214604.GB18958@Krystal> <4510072C.7020100@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <4510072C.7020100@us.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 11:13:10 up 27 days, 12:21,  4 users,  load average: 0.04, 0.15, 0.12
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jose R. Santos (jrs@us.ibm.com) wrote:
> Mathieu Desnoyers wrote:
> >A standard event header has to have only crucial information, nothing 
> >more, or
> >it becomes bloated and quickly grow trace size. We decided not to put tid 
> >and
> >CPU id in the event header because tid is already available with the 
> >schedchange
> >events at post-processing time and CPU id is already available too, as we 
> >have
> >per CPU buffers.
> >  
> 
> We still keep the CPU id because LKET still support ASCII tracing which 
> mixes the output of all the CPUs together.  It is still debatable 
> whether this is a useful feature or not though.  If we remove ASCII 
> event tracing from LKET, we could remove CPU id from the event header as 
> well.
> 

How hard would it be to make LKET send its ASCII output to multiple "channels"
(buffers) and then fetch and combine them in user space ? Have a look at lttd
and lttv in the ltt-control package from the LTTng project : it would be
trivial to adapt. In fact, there is already a text dump module available.

> The tid we still include because LKET supports turning on individual 
> tracepoints unlike LTT, which if I remember correctly turns on all the 
> tracepoint that are compiled into the running kernel.  Since the user is 
> free to chose which tracepoints he wants to use for his workload, we can 
> not guarantee that scheduler tracepoints are going to be available.  We 
> consider taking the tid as one of those absolute minimum pieces of data 
> required to do meaningful analysis.
> 

I understand, but it does not have to be included in the bare-boned event
header. We could think of an optional "event context" header that would have its
individual parts enabled or not depending on the events recorded in the trace.
For instance :

With scheduler instrumentation activated :

Event Header  |  Variable data

Without scheduler instrumentation activated :

Event Header  |  PID  |  Variable data

The information about whether or not the optional event context is present in
the trace or not could be saved in the trace header.

This way, we could not add unnecessary data when it is not needed. And
furthermore, this is extensible for other event context information.

> We chose to control performance and trace output size by letting users 
> have control of number of tracepoint he can activate at any given time.  
> This is important to us since we plan to add many dynamic tracepoints to 
> different sub-systems (filesystem, device drivers, core kernel 
> facilities, etc...).  Turning on all of these tracepoint at the same 
> time would slow down the system to much and change the performance 
> characteristics of the environment being studied.

Yes, I know that overhead is a big problem with dynamic instrumentation ;) I
think we can find a way to both have an optimal trace format while giving
a dynamic probe based tracer enough context when needed.


> >The event size is completely unnecessary, but in reality very, very useful 
> >to
> >authenticate the correspondance between the size of the data recorded by 
> >the
> >kernel and the size of data the viewer thinks it is reading. Think of it 
> >as a
> >consistency check between kernel and viewer algorithms.
> >  
> 
> I understand.  But if the size of each event is fixed, why would you 
> expect the data sizes that the tool reports in the trace header for each 
> event to change over the course of a trace.  If the data on the per-CPU 
> buffers is serialized, a similar authentication could be done using the 
> timestamp by checking the timestamps of the events before and after the 
> current event, thus validating the current timestamp as well as the size 
> offset of the previous event.  Just a thought.
> 

Yes, but if there is a bug with the timestamp (time going backward because of
problematic event record serialization), it becomes harder to pinpoint the
source of the problem (if it is due to a bug in the variable data serialization
mechanism, a bug in the user space "unserialization" mechanism or a bug in event
serialization within the kernel). LTTng hasn't suffered of this kind of issue
for quite some time, but when under heavy development, those indicators of data
consistency have all proven their usefulness.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
