Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVA0FOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVA0FOc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 00:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVA0FOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 00:14:32 -0500
Received: from mail.joq.us ([67.65.12.105]:13008 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262446AbVA0FNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 00:13:48 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	<20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
	<87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu>
	<87fz0neshg.fsf@sulphur.joq.us>
	<1106782165.5158.15.camel@npiggin-nld.site>
	<874qh3bo1u.fsf@sulphur.joq.us>
	<1106796360.5158.39.camel@npiggin-nld.site>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 26 Jan 2005 23:15:02 -0600
In-Reply-To: <1106796360.5158.39.camel@npiggin-nld.site> (Nick Piggin's
 message of "Thu, 27 Jan 2005 14:26:00 +1100")
Message-ID: <87pszr1mi1.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:

> On Wed, 2005-01-26 at 20:31 -0600, Jack O'Quin wrote:
>> Nick Piggin <nickpiggin@yahoo.com.au> writes:
>> 
>> > I'm a bit concerned about this kind of policy and breakage of
>> > userspace APIs going into the kernel. I mean, if an app is
>> > succeeds in gaining SCHED_FIFO / SCHED_RR scheduling, and the
>> > scheduler does something else, that could be undesirable in some
>> > situations.
>> 
>> True.  It's similar to running out of CPU bandwidth, but not quite.
>> 
>> AFAICT, the new behavior still meets the letter of the standard[1].
>> Whether it meets the spirit of the standard is debatable.  My own
>> feeling is that it probably does, and that making SCHED_FIFO somewhat
>> less powerful but much easier to access is a reasonable tradeoff.
>
> I don't think it does. The process with the highest priority
> must run first, regardless of anything else.
>
> You could say "it is similar to running out of CPU bandwidth", or
> "it is like running on a CPU that is 80% the speed". And it may be
> similar in terms of total throughput.

I also said, "but not quite".  The differences are noticeable, but I
believe they are manageable.  I could still be convinced otherwise,
however, by a sufficiently persuasive argument.  ;-)  

I don't claim to know about every realtime system.

> But the important elements are lost. The standard provides a
> deterministic scheduling order, and a deterministic scheduling
> latency 

Where does the standard actually say this?  All I found was the
reference[1] in my previous note.  It talks about queue management,
but not scheduling latency.  The scheduling order is only defined to
be deterministic within the SCHED_FIFO class.  Ingo's patch actually
conforms to this requirement fully, AFAICT.

 [1] http://www.opengroup.org/onlinepubs/007908799/xsh/realtime.html

I'm not trying to be a "standards lawyer" about this, and I can see
your point of view.  But, we should clearly distinguish what is
*required* by POSIX from what we feel to be good engineering practice.
Both are important.

> (of course this doesn't mean a great deal for Linux, but I think
> we're good enough for a lot of soft-rt applications now).

Absolutely.  And getting noticeably better these days.

>> If I understand Ingo's proposal correctly, setting RLIMIT_RT_CPU to
>> zero and then requesting SCHED_FIFO (with CAP_SYS_NICE) yields exactly
>> the former behavior.  This will probably be the default setting.
>
> Oh yes, and that would surely have to be the only sane default
> setting. But I then ask, why put this complexity into the kernel
> in the first place? And is the cost of significantly breaking the
> API and lying to userspace acceptable?

Well, this extremely long discussion started with a request on behalf
of a large group of audio developers and users for a way to gain
realtime scheduling privileges without running as root.

Several kernel developers felt that would be unacceptable, because of
the Denial of Service implications.  We argued that the owner of a
Digital Audio Workstation should be free to lock up his CPU any time
he wants.  But, no one would listen.  We were told that we didn't
really know what we needed, and were asking the wrong question.  That
was very discouraging.  It looked like LKML was going to ignore our
needs for yet another year.

Had I been in charge, I would have adopted our silly little RT-LSM
patch, declared victory, and moved on to other matters.  But, I'm not
responsible for this particular kernel.  (Thank you, God!)  So, I am
willing to defer to the prejudices of those who are.  But, the limit
of my deference is reached when they refuse to meet my needs.

When Con and Ingo started floating scheduler proposals, I tried to
help them produce something useful.  I think they have succeeded.

Is this the easiest way to meet our needs?  No way.  But it's not bad,
and I think it will work.  In some ways, it's actually better than our
original RT-LSM proposal.  Ingo's scheduler patch is not very large.

>> The main point of discussion is: exactly what resource should it
>> limit?  Arjan and Chris proposed to limit priority.  Ingo proposed to
>> limit the percentage of each CPU available for realtime threads
>> (collectively).  Either would meet our minimum needs (AFAICT).
>
> I think the priority limit is the better way, because the % CPU
> available to real time threads approach essentially gives you no
> realtime scheduling at all.

Setting RLIMIT_RT_CPU to 100% gives exactly what you are asking for.

In fact, I will probably lower it to 98%, taking advantage of the
scheduler's ability to throttle runaway threads.  Locking up the CPU
is not a big problem in my life, but it can be annoying when it does
occur.  The JACK watchdog does not catch every bug we see during
development.

> By limiting priority, you can at least construct userspace solutions
> to managing RT threads.

I think I can do it either way.  

Further, I believe distributions will probably set a reasonably high
RLIMIT_RT_CPU for desktop users, allowing audio applications to work
quite well right out of the box.

I don't much like Mac OS X.  It annoys the hell out of me that they
can run Linux audio applications so much better than Linux.  According
to Stephane Letz (who did the JACK OSX port), their scheduler has a
similar throttle set at about 90%.  It does not seem to be causing
them any practical problems that I can tell.

>> > And finally, with rlimit support, is there any reason why lockup
>> > detection and correction can't go into userspace? Even RT
>> > throttling could probably be done in a userspace daemon.
>> 
>> It can.  But, doing it in the kernel is more efficient, and probably
>> more reliable.
>
> Possibly. But the people who want a solution seem to be in a very
> small minority, and I'm not sure how much you care about efficiency.

I do care.  The average overhead of running a watchdog daemon at max
priority is tiny.  But, its impact on worst-case trigger latencies is
non-trivial and must be added to everything else in the RT subsystem.
-- 
  joq
