Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVAZFLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVAZFLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 00:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVAZFLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 00:11:20 -0500
Received: from mail.joq.us ([67.65.12.105]:2736 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262265AbVAZFLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 00:11:11 -0500
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
References: <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	<20050124125814.GA31471@elte.hu> <87k6q2umla.fsf@sulphur.joq.us>
	<20050125083724.GA4812@elte.hu> <87oefdfaxp.fsf@sulphur.joq.us>
	<20050125214900.GA9421@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 25 Jan 2005 23:12:06 -0600
Message-ID: <87sm4osrix.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Jack O'Quin <joq@io.com> wrote:
>
>> At around 55 seconds into the run, JACK got in trouble and throttled
>> itself back to approximately the 30% limit (actually a little above).
>> Then, around second 240 it got in trouble again, this time collapsing
>> completely.  I'm a bit confused by all the messages in that log, but
>> it appears that approximately 9 of the 20 clients were evertually shut
>> down by the JACK server.  It looks like the second collapse around 240
>> also caused the scheduler to revoke RT privileges for the rest of the
>> run (just a guess).
>
> no, the scheduler doesnt revoke RT privileges, it just 'delays' RT tasks
> that violate the threshold. In other words, SCHED_OTHER tasks will have
> a higher effective priority than RT tasks, up until the CPU use average
> drops below the limit again.

When does it start working again?  Does it continue getting 80% of
each CPU in the long run?  What is the period over which this "delay"
occurs and recurs?

I know how to deal with running out of CPU cycles.  This seems to
present a new and different failure mode.  I'd like to know that I can
have 80% of the cycles for each realtime period.  (For JACK this is
determined by the audio buffer size.)  If I can't finish my work in
that allotment, then I've failed and need to scale back.

But, the scheduler doesn't know about realtime cycles.  It just knows
that I used more than 80% over some unspecified period.  So, maybe I
handled the first 8 audio buffers, but have no cycles left for buffers
9 and 10.  Is that right?  That's not a situation I currently expect
to deal with.  I need to figure out how to handle it.

> the effect is pretty similar to starting too many Jack clients - things
> degrade quickly and _all_ clients start skipping, and the whole audio
> experience escallates into a big xrun mess. Not much to be done about it
> i suspect. Maybe if the current 'RT load' was available via /proc then
> jackd could introduce some sort of threshold above which it would reject
> new clients?

It could.  

It also kicks clients out of the realtime graph if they take too long.

>> JACK can probably do a better job of shutting down hyperactive
>> realtime clients than the kernel, because it knows more about what the
>> user is trying to do.  Multiplying incomprehesible rlimits values does
>> not help much that I can see.
>
> please debug this some more - the kernel certainly doesnt do anything
> intrusive - the clients only get delayed for some time.

One simple definition of a realtime operation: there exists some
deadline beyond which, if you didn't get the job done, you might as
well not do it at all.

For many applications, it might actually be less intrusive to kill
them than to delay them.  My first thought is to revoke SCHED_FIFO and
send a signal.  The default action could be process termination, but
the process might optionally catch the signal, throttle back and try
to restart the operation.

Maybe there are other usage scenarios for which delaying the realtime
thread is a good idea.  What kind did you have in mind?

>> Sometimes musicians want to "push the envelope" using CPU-hungry
>> realtime effects like reverbs or Fourier Transforms.  It is often hard
>> to predict how much of this sort of load a given system can handle.
>> JACK reports its subsystem-wide "DSP load" as a moving average,
>> allowing users to monitor it.  It might be helpful if the kernel's
>> estimate of this number were also available somewhere (but maybe that
>> value has no meaning to users).  Often, the easiest method is to push
>> things to the breaking point, and then back off a bit.
>
> yeah, i'll add this to /proc, so that utilities can access it. Jackd
> could monitor it and refuse to start new clients if the RT load is
> dangerously close to the limit (say within 10% of it)?

That could be useful.  But, isn't it per-CPU?  

Would this be a composite value?  Average?  Does that mean anything?

>> The equivalent rlimits experiment probably requires:
>> 
>>   (1) editing /etc/security/limits.conf
>>   (2) shutting everything down
>>   (3) logout
>>   (4) login
>>   (5) restarting the test
>
> well, there's setrlimit, so you could add a jackd client callback that
> instructs all clients to change their RT_CPU_RATIO rlimit. In theory we
> could try to add a new rlimit syscall that changes another task's rlimit
> (right now the syscalls only allow the changing of the rlimit of the
> current task) - that would enable utilities to change the rlimit of all
> tasks in the system, achieving the equivalent of a global sysctl.

Sure, we could.  That does seem like an enormously complicated
mechanism to accomplish something so simple.  We are taking a global
per-CPU limit, treating it as if it were per-process, then invoking a
complex callback scheme to propagate new values, all just to shoe-horn
it into the rlimits structure.

There are many problems for which rlimits is a good solution.  This
does not seem to be one them.
-- 
  joq
  "To a man with a hammer, every problem looks like a nail."  ;-)

