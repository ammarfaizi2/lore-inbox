Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVA0D1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVA0D1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 22:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVA0D1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 22:27:13 -0500
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:40840 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262447AbVA0D0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 22:26:17 -0500
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <874qh3bo1u.fsf@sulphur.joq.us>
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	 <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	 <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	 <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	 <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
	 <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu>
	 <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site>
	 <874qh3bo1u.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 14:26:00 +1100
Message-Id: <1106796360.5158.39.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 20:31 -0600, Jack O'Quin wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> writes:
> 
> > I'm a bit concerned about this kind of policy and breakage of
> > userspace APIs going into the kernel. I mean, if an app is
> > succeeds in gaining SCHED_FIFO / SCHED_RR scheduling, and the
> > scheduler does something else, that could be undesirable in some
> > situations.
> 
> True.  It's similar to running out of CPU bandwidth, but not quite.
> 
> AFAICT, the new behavior still meets the letter of the standard[1].
> Whether it meets the spirit of the standard is debatable.  My own
> feeling is that it probably does, and that making SCHED_FIFO somewhat
> less powerful but much easier to access is a reasonable tradeoff.

I don't think it does. The process with the highest priority
must run first, regardless of anything else.

You could say "it is similar to running out of CPU bandwidth", or
"it is like running on a CPU that is 80% the speed". And it may be
similar in terms of total throughput.

But the important elements are lost. The standard provides a
deterministic scheduling order, and a deterministic scheduling
latency (of course this doesn't mean a great deal for Linux, but
I think we're good enough for a lot of soft-rt applications now).

> 
>  [1] http://www.opengroup.org/onlinepubs/007908799/xsh/realtime.html
> 
> If I understand Ingo's proposal correctly, setting RLIMIT_RT_CPU to
> zero and then requesting SCHED_FIFO (with CAP_SYS_NICE) yields exactly
> the former behavior.  This will probably be the default setting.
> 

Oh yes, and that would surely have to be the only sane default
setting. But I then ask, why put this complexity into the kernel
in the first place? And is the cost of significantly breaking the
API and lying to userspace acceptable?

> > Secondly, I think we should agree upon and get the basic rlimit
> > support in ASAP, so the userspace aspect can be firmed up a bit
> > for people like Paul and Jack (this wouldn't preclude further
> > work from happening in the scheduler afterwards).
> 
> I don't sense much opposition to adding rlimit support for realtime
> scheduling.  I personally don't think it a very good way to manage
> this problem.  But, it certainly can be made to work.
> 
> The main point of discussion is: exactly what resource should it
> limit?  Arjan and Chris proposed to limit priority.  Ingo proposed to
> limit the percentage of each CPU available for realtime threads
> (collectively).  Either would meet our minimum needs (AFAICT).
> 

I think the priority limit is the better way, because the % CPU
available to real time threads approach essentially gives you no
realtime scheduling at all.

By limiting priority, you can at least construct userspace solutions
to managing RT threads.

> But, they are not identical, and the best choice depends at least
> partly on the outcome of Ingo's scheduler experiments.  I doubt that
> anyone wants to add both (though it could come down to that, I
> suppose).
> 
> > And finally, with rlimit support, is there any reason why lockup
> > detection and correction can't go into userspace? Even RT
> > throttling could probably be done in a userspace daemon.
> 
> It can.  But, doing it in the kernel is more efficient, and probably
> more reliable.

Possibly. But the people who want a solution seem to be in a very
small minority, and I'm not sure how much you care about efficiency.



