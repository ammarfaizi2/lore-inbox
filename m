Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSIWAAd>; Sun, 22 Sep 2002 20:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264626AbSIWAAd>; Sun, 22 Sep 2002 20:00:33 -0400
Received: from nameservices.net ([208.234.25.16]:17400 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S264625AbSIWAAb>;
	Sun, 22 Sep 2002 20:00:31 -0400
Message-ID: <3D8E5B88.5A1BC68C@opersys.com>
Date: Sun, 22 Sep 2002 20:08:40 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: bob <bob@watson.ibm.com>, okrieg@us.ibm.com, trz@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
References: <Pine.LNX.4.44.0209230108001.3792-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> this is that a trace point should do, at most:
> 
[snip]
> this should cover most of what's needed. The event_wanted() filter
> function should be made as fast as possible. Note that the irq-disabled
> section is not strictly needed but nice and also makes it work on the
> preemptible kernel. (It's not a big issue at all to run these few
> instructions with irqs disabled.)
> 
> [there are also other details like putting curr_index and curr_pending
> into the per-cpu area and similar stuff.]

Yes, but there are a few assumptions made here which don't necessarily
hold:

1) TSC timestamping isn't appropriate for all cases. Users need to be
able to correlate the events in the buffer to the clock they actually
see when they call gettimeofday. Currently, LTT calls do_gettimeofday
for every event and does a saves the difference between the current
time and the time saved in the begining on the buffer. Hence, instead
of saving 8 bytes per event, we only save 4. However, we are moving
forward with other providing other timestamping schemes, including the
TSC. But even TSC timestamping requires a call to gettimeofday every
so often because TSC values drift on an SMP system. Measurements done
at IBM actually show significant drifts depending on whether processors
are cooling down or heating up.

2) Using a single event structure for all events causes a number of
problems. Mainly, you end up having many events that fill only part
of the event and others that end up requiring many events to record
all the data. The alternative, using the largest possible event as the
basis for all events, results in huge traces. The only way out of this
is variable sized events which is requires passing pointers instead
of actual data items to the trace function.

3) Because not all users want/should see the same types of events,
the driver needs to deal with multiple multi-purpose buffers. Also,
the number of buffers used should be user-configurable.

4) This tracer can't be used to log user-space events because it opens
the door to denial-of-service attacks (i.e. a user space process could
easily impend on the kernel's ability to deal with interrupts by
looping on the trace function). The lockless code avoids this problem.

5) Simply waking up the process doesn't provide any insight on whether
the user has missed any events. This tracer keeps on going regardless
of whether the daemon has had the chance to write the events to file
or not. For a tracer to be useful to mainstream users, it needs to
be able to report lost events.

The above tracer may indeed be very appropriate for kernel development,
but it doesn't provide enough functionality for the requirements of
mainstream users.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
