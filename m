Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVAQCQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVAQCQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 21:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVAQCQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 21:16:57 -0500
Received: from opersys.com ([64.40.108.71]:34564 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262665AbVAQCQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 21:16:49 -0500
Message-ID: <41EB21C2.3020608@opersys.com>
Date: Sun, 16 Jan 2005 21:24:02 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
       Nikita Danilov <nikita@clusterfs.com>,
       LKML <linux-kernel@vger.kernel.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>	 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>	 <41E7A7A6.3060502@opersys.com>	 <Pine.LNX.4.61.0501141626310.6118@scrub.home>	 <41E8358A.4030908@opersys.com>	 <Pine.LNX.4.61.0501150101010.30794@scrub.home>	 <41E899AC.3070705@opersys.com>	 <Pine.LNX.4.61.0501160245180.30794@scrub.home>	 <41EA0307.6020807@opersys.com>	 <Pine.LNX.4.61.0501161648310.30794@scrub.home> <41EADA11.70403@opersys.com> <1105925842.13265.364.camel@tglx.tec.linutronix.de>
In-Reply-To: <1105925842.13265.364.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner wrote:
> Which is every 1.42 seconds on a 3GHz machine. I guess we don't have
> GB's of data when the 1.42 seconds elapse without an event.

My argument was about being able to browse the amount of data I was
refering to. The hearbeat thing was an asside to Roman as to the
fact that we already do what he's suggesting.

> I still don't see the point. The implicit ability of LTT to allow
> tracing of up to 8192 bytes user data, strings and XML makes this
> neccecary. I do not see any neccecarity to integrate this special usage
> modes instead of an generic usable instrumentation implementation.

I've already clarified your mischaracterization of custom events,
you are being dissengenious here. If you want a generalized hooking
mechanism, feel free to ask Andrew to take kernel hooks:
http://www-124.ibm.com/developerworks/oss/linux/projects/kernelhooks/

> If relayfs is giving those users the ability to do so then they can do
> it, but I object the fact that LTT/relayfs is occupying the place of a
> more generic implementation in the way it is implemeted now.

Again, damned if we do, damned if don't. LTT isn't meant for kernel
debugging per se, though you can use it to that end to a certain extent.
However, if you are kernel debugging, you will find the ad-hoc mode I'm
talking about adding to relayfs quite useful.

> For normal event tracing you have about 32-64 byte of data per event. So
> disabling interrupts in order to copy this amount of imformation into a
> buffer is cheaper on most architectures than doing the whole magic in
> LTT and relayfs. This also keeps your buffers consistent and does not
> need any magic for postprocessing. 

Oh, now you want to lighten the weight on postprocessing? Common Thomas,
please stop wasting my time.

Note, however, that we are thinking of dropping the lockless scheme
for now. We will pick up this discussion separately further down the
road.

> Sorting out disabled events in the hot path and moving the if
> (pid/gid/grp) whatever stuff into userspace postprocessing is not an
> alien request.

It is. Have you even read what I suggested to change in my other mail:
if ((any_filtering) && !(ltt_filter(event_id, event_struct, data)))
	return -EINVAL;

You're not honestly telling me that checking for any_filtering is
going to ruin your day.

> You are talking of Gigabytes of data. In what time ?
> 
> Let's do some math.
> 
> For simplicity all events use 64 Byte event space.
> 
> ~ 64kB/sec for 1000 events/s (event frequency   1kHz) ( 1 ms)
> 1024kB/sec for  16 events/ms (event frequency  16kHz) (62 us)
> 2048kB/sec for  32 events/ms (event frequency  32kHz) (31 us)
> 4096kB/sec for  64 events/ms (event frequency  64kHz) (15 us)
> 8192kB/sec for 128 events/ms (event frequency 128kHz) ( 8 us)
> 
> where a 100Mbit network can theoretically transport 10240kB/sec and
> practically does 4000-8000 kB/sec. 
> 
> An event frequency of 8us even on a 3 GHz machine is complete illusion,
> because we spend already a couple of usecs in servicing the legacy 8254
> timer.
> 
> So the realistic assumption on a 3Ghz machine is definitely below 64kHz,
> which means we have to handle max. 4Mb of data per second. 

Actually, on a PII-350MHz, I was already generating 0.5MB/s of data
just by running an X session. If we assume that a machine 10 times
faster generates 10 times as many events, we've already got 5MB/s,
and I'm sure that there are heavier cases than X.

Here's the paper if you want to read it:
http://www.opersys.com/ftp/pub/LTT/Documentation/ltt-usenix.ps.gz

> I'm not impressed. Disabling interrupts for a couple of nano seconds to
> store the trace data in the buffer does not hurt at all. Running through
> a big bunch of out of cache line instructions does.

Like I said above, fighting for/against lockless is not our immediate
goal, and we will likely remove it.

> If you try to trace more than this amount you are toast anyway.
> 
> Please beware me of "reality has bitten" arguments. The whole if(..)
> scenario in _ltt_event_log() is doing postprocessing, which can be done
> in userspace. I don't care about the required time as long as it does
> not introduce additional burden into the kernel.

Not even Ingo hinted at getting rid of filtering. Remember the earlier
e-mail I refered to? Here's what he was suggesting:
> void trace(event, data1, data2, data3)
> {
> 	int cpu = smp_processor_id();
> 	int idx, pending, *curr = curr_idx + cpu;
> 	struct trace_event *t;
> 	unsigned long flags;
> 
> 	if (!event_wanted(current, event, data1, data2, data3))
> 		return;
> 
> 	local_irq_save(flags);
> 
>         idx = ++curr_idx[cpu] & (NR_TRACE_ENTRIES - 1);
> 	pending = ++curr_pending[cpu];
> 
>         t = trace_ring[cpu] + idx;
> 
>         t->event = event;
>         rdtscll(t->timestamp);
>         t->data1 = data1;
>         t->data2 = data2;
>         t->data3 = data3;
> 
> 	if (curr_pending == TRACE_LOW_WATERMARK && tracer_task)
> 		wake_up_process(tracer_task);
> 
> 	local_irq_restore(flags);
> }

Notice the "event_wanted()"?

Original found here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103273730326318&w=2

Again, Thomas, I don't mind hearing you out, but please don't waste
my time.

> Be aware that there are some unhappy campers in the kernel community too
> when the special purpose tracing is included instead of a general usable
> framework.

Like I said, we are willing to accomodate those who want to be able
to use relayfs for kernel debugging purposes, but we can hardly
be blamed for not making LTT a generic kernel debugging tool as this
is exactly the excuse many kernel developers had for not including
LTT to start with. It's just totally dissengenious for giving us
grief for claiming that we are doing something and then later turn
around and blame us for not doing it ... cheesh ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
