Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWISQjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWISQjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWISQjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:39:47 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:65498 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030229AbWISQjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:39:46 -0400
Message-ID: <45101D2C.8000609@us.ibm.com>
Date: Tue, 19 Sep 2006 11:39:08 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <1158320406.29932.16.camel@localhost.localdomain> <Pine.LNX.4.64.0609151339190.6761@scrub.home> <1158323938.29932.23.camel@localhost.localdomain> <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain> <450AEC92.7090409@us.ibm.com> <20060915194937.GA7133@Krystal> <450B1309.9020800@us.ibm.com> <20060915214604.GB18958@Krystal> <4510072C.7020100@us.ibm.com> <20060919153003.GA2617@Krystal>
In-Reply-To: <20060919153003.GA2617@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> > We still keep the CPU id because LKET still support ASCII tracing which 
> > mixes the output of all the CPUs together.  It is still debatable 
> > whether this is a useful feature or not though.  If we remove ASCII 
> > event tracing from LKET, we could remove CPU id from the event header as 
> > well.
> > 
>
> How hard would it be to make LKET send its ASCII output to multiple "channels"
> (buffers) and then fetch and combine them in user space ? Have a look at lttd
> and lttv in the ltt-control package from the LTTng project : it would be
> trivial to adapt. In fact, there is already a text dump module available.
>   

Actually, ASCII trace should output to multiple channels if we use bulk 
mode.  The original idea for keeping ASCII trace (this was the original 
output mechanism) was that a user may have wanted to look at trace 
output information in real-time as it was being printed onto the screen 
(which requires merging all the output channels).  Again, I question the 
usability of this feature and if a user really wanted to look at ASCII 
trace data in real time, a better solution would be for the lket-b2a 
conversion tool to have a mode were it could print the output of 
constantly changing trace buffers to the screen.  The ASCII output mode 
in LKET is cryptic and having lket-b2a do this would perform better and 
produce prettier output while also reducing the trace file output size a 
bit.
> > The tid we still include because LKET supports turning on individual 
> > tracepoints unlike LTT, which if I remember correctly turns on all the 
> > tracepoint that are compiled into the running kernel.  Since the user is 
> > free to chose which tracepoints he wants to use for his workload, we can 
> > not guarantee that scheduler tracepoints are going to be available.  We 
> > consider taking the tid as one of those absolute minimum pieces of data 
> > required to do meaningful analysis.
> > 
>
> I understand, but it does not have to be included in the bare-boned event
> header. We could think of an optional "event context" header that would have its
> individual parts enabled or not depending on the events recorded in the trace.
> For instance :
>
> With scheduler instrumentation activated :
>
> Event Header  |  Variable data
>
> Without scheduler instrumentation activated :
>
> Event Header  |  PID  |  Variable data
>
> The information about whether or not the optional event context is present in
> the trace or not could be saved in the trace header.
>
> This way, we could not add unnecessary data when it is not needed. And
> furthermore, this is extensible for other event context information.
>   
Thats also a possible and it should not be difficult to implement. 
> > We chose to control performance and trace output size by letting users 
> > have control of number of tracepoint he can activate at any given time.  
> > This is important to us since we plan to add many dynamic tracepoints to 
> > different sub-systems (filesystem, device drivers, core kernel 
> > facilities, etc...).  Turning on all of these tracepoint at the same 
> > time would slow down the system to much and change the performance 
> > characteristics of the environment being studied.
>
> Yes, I know that overhead is a big problem with dynamic instrumentation ;) I
> think we can find a way to both have an optimal trace format while giving
> a dynamic probe based tracer enough context when needed.
>   

Actually, we started doing this six years ago on our internal *static* 
trace tool before we started implementing event tracing using 
SystemTap.  Regardless of whether the tool uses static or dynamic 
probes, if the problem only requires 3 tracepoints to figure out, why 
would you want to activate 50+ hooks.
>
> > I understand.  But if the size of each event is fixed, why would you 
> > expect the data sizes that the tool reports in the trace header for each 
> > event to change over the course of a trace.  If the data on the per-CPU 
> > buffers is serialized, a similar authentication could be done using the 
> > timestamp by checking the timestamps of the events before and after the 
> > current event, thus validating the current timestamp as well as the size 
> > offset of the previous event.  Just a thought.
> > 
>
> Yes, but if there is a bug with the timestamp (time going backward because of
> problematic event record serialization), it becomes harder to pinpoint the
> source of the problem (if it is due to a bug in the variable data serialization
> mechanism, a bug in the user space "unserialization" mechanism or a bug in event
> serialization within the kernel). LTTng hasn't suffered of this kind of issue
> for quite some time, but when under heavy development, those indicators of data
> consistency have all proven their usefulness.
>
>   
Look like the example you propose above could also apply to this as 
well.  You could implement some sort of debug mode to the trace data 
that provides extra information useful for debugging the tool.  If the 
information is really only useful when debugging the trace tool during 
development,  wouldn't it make sense to have a way to disable debugging 
junk as needed?

-JRS
