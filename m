Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWISPF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWISPF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWISPF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:05:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:11933 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750712AbWISPF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:05:57 -0400
Message-ID: <4510072C.7020100@us.ibm.com>
Date: Tue, 19 Sep 2006 10:05:16 -0500
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
References: <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com> <1158320406.29932.16.camel@localhost.localdomain> <Pine.LNX.4.64.0609151339190.6761@scrub.home> <1158323938.29932.23.camel@localhost.localdomain> <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain> <450AEC92.7090409@us.ibm.com> <20060915194937.GA7133@Krystal> <450B1309.9020800@us.ibm.com> <20060915214604.GB18958@Krystal>
In-Reply-To: <20060915214604.GB18958@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> > Trace event headers are very similar between both LTT and LKET which is 
> > good in other to get some synergy between our projects.  One thing that 
> > LKET has on each trace event that LTT doesn't is the tid and CPU id of 
> > each event.  We find this extremely useful for post-processing.  Also, 
> > why have the event_size on every event taken?  Why not describe the 
> > event during the trace header and remove this redundant information from 
> > the event header and save some trace file space.
> > 
>
> A standard event header has to have only crucial information, nothing more, or
> it becomes bloated and quickly grow trace size. We decided not to put tid and
> CPU id in the event header because tid is already available with the schedchange
> events at post-processing time and CPU id is already available too, as we have
> per CPU buffers.
>   

We still keep the CPU id because LKET still support ASCII tracing which 
mixes the output of all the CPUs together.  It is still debatable 
whether this is a useful feature or not though.  If we remove ASCII 
event tracing from LKET, we could remove CPU id from the event header as 
well.

The tid we still include because LKET supports turning on individual 
tracepoints unlike LTT, which if I remember correctly turns on all the 
tracepoint that are compiled into the running kernel.  Since the user is 
free to chose which tracepoints he wants to use for his workload, we can 
not guarantee that scheduler tracepoints are going to be available.  We 
consider taking the tid as one of those absolute minimum pieces of data 
required to do meaningful analysis.

We chose to control performance and trace output size by letting users 
have control of number of tracepoint he can activate at any given time.  
This is important to us since we plan to add many dynamic tracepoints to 
different sub-systems (filesystem, device drivers, core kernel 
facilities, etc...).  Turning on all of these tracepoint at the same 
time would slow down the system to much and change the performance 
characteristics of the environment being studied.
> The event size is completely unnecessary, but in reality very, very useful to
> authenticate the correspondance between the size of the data recorded by the
> kernel and the size of data the viewer thinks it is reading. Think of it as a
> consistency check between kernel and viewer algorithms.
>   

I understand.  But if the size of each event is fixed, why would you 
expect the data sizes that the tool reports in the trace header for each 
event to change over the course of a trace.  If the data on the per-CPU 
buffers is serialized, a similar authentication could be done using the 
timestamp by checking the timestamps of the events before and after the 
current event, thus validating the current timestamp as well as the size 
offset of the previous event.  Just a thought.

-JRS
