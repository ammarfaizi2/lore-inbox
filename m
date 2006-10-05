Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWJEOhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWJEOhB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWJEOhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:37:00 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:4062 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932099AbWJEOg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:36:59 -0400
Date: Thu, 5 Oct 2006 10:31:33 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, fche@redhat.com,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [RFC] The New and Improved Logdev (now with kprobes!)
Message-ID: <20061005143133.GA400@Krystal>
References: <1160025104.6504.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1160025104.6504.30.camel@localhost.localdomain>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 10:14:06 up 43 days, 11:22,  5 users,  load average: 0.07, 0.20, 0.54
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

The dynamic abilities of your logdev are very interesting! If I may emit some
ideas :

It would be great to have this logging information recorded into a standardized
buffer format so it could be analyzed with data gathered by other
instrumentation. Instead of using Tom's relay mechanism directly, you might
want to have a look at LTTng (http://ltt.polymtl.ca) : it would be a simple
matter of describing your own facility (group of event), the data types they
record, run genevent (serialization code generator) and call those
serialization functions when you want to record to the buffers from logdev.

One thing logdev seems to have that LTTng does't currently is the integration
with a mechanism that dumps the output upon a crash (LKCD integration). It's no
rocket science, but I just did not have time to do it.

I think it would be great to integrate those infrastructures together so we can
easily merge information coming from various sources (markers, logdev, systemTAP
scripts, LKET).

* Steven Rostedt (rostedt@goodmis.org) wrote:
> 1. break point and a watch address
> 
> This simply allows you to set a break point at some address (or pass in
> a function name if it exists in kallsyms).
> 
> logprobe -f hrtimer_start  -v jiffies_64
> 
Does it automatically get the data type, or is there any way to specify it ?

> 
> 2. break point and watch from current
> 
> This allows a user to see something on the current task_struct. You need
> to know the offset exactly. In the below example, I know that 20 (dec)
> is the offset in the task_struct to lock_depth.
> 
> example:
> 
> logprobe -f schedule -c 20 "lock_depth"
> 
> produces:
> 
>   [ 8757.854029] cpu:1 sawfish:3862 func: schedule (0xc02f8320) lock_depth index:20 = 0xffffffff
> 

Could we think of a quick hack that would involve using gcc on stdin and return
an "offsetof", all in user-space ?

> 
> 3. break point and watch fixed type
> 
> This is a catch all for me. I currently only implement preempt_count.
> 
> 
>  logprobe -t pc -f _spin_lock
> 
> produces:
> 
>    [ 9442.215693] cpu:0 logread:6398 func: _spin_lock (0xc02fab9d)  preempt_count:0x0
> 
Ouch, I can imagine the performance impact of this breakpoint though :) This is
a case where marking the code helps a lot.


Regards,

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
