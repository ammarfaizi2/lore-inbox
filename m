Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154512AbPH0WdX>; Fri, 27 Aug 1999 18:33:23 -0400
Received: by vger.rutgers.edu id <S154490AbPH0Wcc>; Fri, 27 Aug 1999 18:32:32 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:10806 "EHLO pneumatic-tube.sgi.com") by vger.rutgers.edu with ESMTP id <S154336AbPH0WcS>; Fri, 27 Aug 1999 18:32:18 -0400
Date: Fri, 27 Aug 1999 14:31:08 -0700
From: Dimitris Michailidis <dimitris@darkside.engr.sgi.com>
Message-Id: <199908272131.OAA01412@darkside.engr.sgi.com>
To: linux-kernel@vger.rutgers.edu
Subject: [PATCH] kernel event tracing
Sender: owner-linux-kernel@vger.rutgers.edu

This is the first release of a facility to allow tracing of kernel events.
It comes in two parts, a patch for the Linux kernel (this one is against
2.2.12, it probably applies without changes to other 2.2.x kernels and
with only minor, if any, changes against 2.3.x), and a pair of user level
commands, ktrace and dtrace.

* The kernel patch

Tracing an event is achieved with the TRACE macro in <linux/trace.h>.  Each
trace record contains a 64-bit timestamp (the value of the TSC), an event
code, and up to two 32-bit arguments.  The evevt code has two parts and this
allows us to support 22 "event groups" (such as scheduling event or I/O event)
with each group having up to 256 subevents.  In case more than two arguments
are needed we provide a special continuation event group that just supplies
more args to the most recent event.  Tracing can be turned on or off at run
time and event filtering at the group level is supported (that is, you can
request that only events in certain groups be recorded).

Care has been taken to keep any performance penalties to a minimum.  To this
end each CPU maintains its own event buffer and there is absolutely no locking.

To trace an event, you first need to include <linux/trace.h> in the 
appropriate source file, and use the TRACE macro at the point in the source
where you need to record an event.  Most of the event groups are available at
this time so feel free to define new events as appropriate.

* The ktrace user level command

ktrace is used to control kernel tracing and also to write out the trace files
(one per cpu).  At this point it supports only a handful of options:

use ktrace -e <event mask> to turn tracing on/off and to specify which events
  should be recorded;

use ktrace -s to see which events are currently being traced (the event mask);

use ktrace -c <cpu> to request that a trace file be produced containing any
  events recorded on CPU <cpu>.  This will give a binary file trace.cpu<cpu>
  that you can postprocess to get the info you need.  More than one -c <cpu>
  can be specified on the command line.

use ktrace -w <sleep> to specify how long ktrace should sleep between
  successive reads of the kernel event buffers.  In order to provide low
  latency for copying out the event buffers, ktrace executes as a low priority
  RT process, so it is important that it doesn't run too frequently.  By
  default it sleeps for 100 ms between reads, which I have found to be
  adequate for the cases I have tried, but it may be too low if there is a 
  flood of events or you're tracing many different types of events.  To aid
  you ktrace will tell you when it believes that the buffers may have 
  overflown.

* The dtrace user level command

dtrace is provided as an example of a command that post processes the output
of ktrace.  Presently, it takes a number of trace files, merges them together,
and prints out the events in ASCII.  Modify it as appropriate.

Any comments or suggestions are welcome.

----
Dimitris Michailidis			dimitris@engr.sgi.com


begin 644 ktrace.tar.gz
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
"````
`
end

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
