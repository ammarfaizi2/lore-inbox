Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVIAMCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVIAMCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 08:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVIAMCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 08:02:49 -0400
Received: from fmr18.intel.com ([134.134.136.17]:27623 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750741AbVIAMCs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 08:02:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: [RFC] A more general timeout specification
Date: Thu, 1 Sep 2005 04:59:37 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A042B057C@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: [RFC] A more general timeout specification
Thread-Index: AcWu1lS+ehYdILyLQwyYRfTV88K0sAAE8c3A
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Roman Zippel" <zippel@linux-m68k.org>
Cc: <akpm@osdl.org>, <joe.korty@ccur.com>, <george@mvista.com>,
       <johnstul@us.ibm.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Sep 2005 12:01:39.0242 (UTC) FILETIME=[E8DFC0A0:01C5AEEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Roman Zippel [mailto:zippel@linux-m68k.org]
>On Wed, 31 Aug 2005, Perez-Gonzalez, Inaky wrote:
>
>> Hmm, I cannot think of more ways to specify a timeout than how
>> long I want to wait (relative) or until when (absolute) and which
>> is the reference clock. And they don't seem broken to me, common
>> sense, in any case. Do you have any examples?
>
>You still didn't explain what's the point in choosing different clock
>sources for a _timeout_.

The same reasons that compel to have CLOCK_REALTIME or 
CLOCK_MONOTONIC, for example. Or the need to time out on a
high resolution clock. 

A certain application might have a need for a 10ms timeout, 
but another one might have it on 100us--modern CPUs make that
more than possible. The precission of your time source permeates
to the precission of your timeout.

[of course, now at the end it is still kernel time, but the 
ongoing revamp work on timers will change some of that, one
way or another].

>> Different versions of the same function that do relative, absolute.
>> If I keep going that way, the reason becomes:
>>
>> sys_mutex_lock
>> sys_mutex_lock_timed_relative_clock_realtime
>> sys_mutex_lock_timed_absolute_clock_realtime
>> sys_mutex_lock_timed_relative_clock_monotonic
>> sys_mutex_lock_timed_absolute_clock_monotonic
>> sys_mutex_lock_timed_relative_clock_monotonic_highres
>> sys_mutex_lock_timed_absolute_clock_monotonic_highres
>
>Hiding it behind an API makes it better?

It certainly cuts out cruft and to my not-so-trained eye, makes it
cleaner and easier to maintain.

>You didn't answer my other question, let's assume we add such a timeout
>structure, what's wrong with converting it to kernel time (which would
>automatically validate it).

And again, that's what at the end this API is doing, convering it to 
kernel time. 

Give it a more "human" specification (timespec) and gets the job done.
No need to care on how long a jiffy is today in this system, no need
to replicate endlessly the conversion code, which happens to be
non-trivial (for the absolute time case--but still way more trivial 
than userspace asking the kernel for the time, computing a relative 
shift and dealing with the skews that preemption at a Murphy moment 
could cause). 

It is mostly the same as schedule_timeout(), but it takes the sleep
time in a more general format. As every other API, it is designed so 
that the caller doesn't need to care or know about the gory details 
on how it has to be converted.

-- Inaky
