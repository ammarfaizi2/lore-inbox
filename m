Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVAYVoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVAYVoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVAYVlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:41:52 -0500
Received: from mail.joq.us ([67.65.12.105]:9366 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262169AbVAYVgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:36:14 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: /proc/sys/kernel/rt_cpu_limit
 tunable
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	<20050124125814.GA31471@elte.hu> <87k6q2umla.fsf@sulphur.joq.us>
	<20050125083724.GA4812@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 25 Jan 2005 15:36:34 -0600
In-Reply-To: <20050125083724.GA4812@elte.hu> (Ingo Molnar's message of "Tue,
 25 Jan 2005 09:37:24 +0100")
Message-ID: <87oefdfaxp.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Jack O'Quin <joq@io.com> wrote:
>
>> It works great...
>> 
>>   http://www.joq.us/jack/benchmarks/rt_cpu_limit
>>   http://www.joq.us/jack/benchmarks/rt_cpu_limit+compile
>>   http://www.joq.us/jack/benchmarks/.SUMMARY
>> 
>> I'll experiment with it some more, but this seems to meet all my
>> needs.  As one would expect, the results are indistinguishable from
>> SCHED_FIFO...

> very good. Could you try another thing, and set the rt_cpu_limit to less
> than the CPU utilization 'top' reports during the test (or to less than
> the DSP CPU utilization in the stats), to deliberately trigger the
> limiting code? This both tests the limit and shows the effects it has. 
> (there should be xruns and a large Delay Maximum.)

Here are some runs with rt_cpu_limit set to 30%.  (No point in trying
to compile in the background.)

   http://www.joq.us/jack/benchmarks/rt_cpu_limit.30

As expected, the Delay Max and XRUN Count do go to hell...

# rt_cpu_limit
Delay Maximum . . . . . . . . :   290   usecs
Delay Maximum . . . . . . . . :   443   usecs
Delay Maximum . . . . . . . . :   232   usecs

# rt_cpu_limit.30
Delay Maximum . . . . . . . . : 60294   usecs
Delay Maximum . . . . . . . . : 77742   usecs
Delay Maximum . . . . . . . . : 589697   usecs

# rt_cpu_limit
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     0
XRUN Count  . . . . . . . . . :     0

# rt_cpu_limit.30
XRUN Count  . . . . . . . . . :    25
XRUN Count  . . . . . . . . . :    12
XRUN Count  . . . . . . . . . :    15

So, the throttling obviously does work, in the sense of the system
being able to protect itself from RT CPU hogging.  The failure of the
JACK subsystem is rather catastophic, however.

Look at this graph...

   http://www.joq.us/jack/benchmarks/rt_cpu_limit.30/jack_test3-2.6.11-rc2-q2-200501251346.png

At around 55 seconds into the run, JACK got in trouble and throttled
itself back to approximately the 30% limit (actually a little above).
Then, around second 240 it got in trouble again, this time collapsing
completely.  I'm a bit confused by all the messages in that log, but
it appears that approximately 9 of the 20 clients were evertually shut
down by the JACK server.  It looks like the second collapse around 240
also caused the scheduler to revoke RT privileges for the rest of the
run (just a guess).

This brings us to the issue of graceful degradation.  IMHO, if we
follow the LKML bias for seeing questions from a kernel and not user
perspective, the results will not be very satisfactory.

JACK can probably do a better job of shutting down hyperactive
realtime clients than the kernel, because it knows more about what the
user is trying to do.  Multiplying incomprehesible rlimits values does
not help much that I can see.

Sometimes musicians want to "push the envelope" using CPU-hungry
realtime effects like reverbs or Fourier Transforms.  It is often hard
to predict how much of this sort of load a given system can handle.
JACK reports its subsystem-wide "DSP load" as a moving average,
allowing users to monitor it.  It might be helpful if the kernel's
estimate of this number were also available somewhere (but maybe that
value has no meaning to users).  Often, the easiest method is to push
things to the breaking point, and then back off a bit.

For this kind of usage scenario, the simpler `rt_cpu_limit' (B4) patch
works much better than the `rt_cpu_ratio' (D4) patch, allowing a
suitably privileged user to adjust the per-CPU limit directly while
experimenting with system limits.  (Don't ask me what any of this
means in an SMP complex.)

The equivalent rlimits experiment probably requires: 

  (1) editing /etc/security/limits.conf
  (2) shutting everything down
  (3) logout
  (4) login
  (5) restarting the test

Eventually there will be ulimit support in the shells.  Then, I
suppose this can be streamlined a little, but not much.  The problem
is that there are often many audio applications running, with complex
connections between them.  So, this is not a simple matter of stopping
and starting a single program (as most of you probably imagine).
-- 
  joq
