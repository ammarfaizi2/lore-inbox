Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVA0Fyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVA0Fyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 00:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVA0Fyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 00:54:31 -0500
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:61339 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262483AbVA0FyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 00:54:15 -0500
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <87pszr1mi1.fsf@sulphur.joq.us>
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	 <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	 <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	 <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	 <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
	 <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu>
	 <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site>
	 <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site>
	 <87pszr1mi1.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 16:54:09 +1100
Message-Id: <1106805249.5158.77.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 23:15 -0600, Jack O'Quin wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> writes:
> 

> > But the important elements are lost. The standard provides a
> > deterministic scheduling order, and a deterministic scheduling
> > latency 
> 
> Where does the standard actually say this?  All I found was the
> reference[1] in my previous note.  It talks about queue management,
> but not scheduling latency.  The scheduling order is only defined to
> be deterministic within the SCHED_FIFO class.  Ingo's patch actually
> conforms to this requirement fully, AFAICT.
> 
>  [1] http://www.opengroup.org/onlinepubs/007908799/xsh/realtime.html
> 
> I'm not trying to be a "standards lawyer" about this, and I can see
> your point of view.  But, we should clearly distinguish what is
> *required* by POSIX from what we feel to be good engineering practice.
> Both are important.

Yes I see what you mean. And in fact it does say that scheduling
of SCHED_OTHER tasks with SCHED_FIFO and SCHED_RR tasks is
implementation specific, however that must be within the framework
of their queued scheduler specification.

And in Linux, sched_get_priority_max() and sched_get_priority_min()
for SCHED_OTHER tasks are both 0, which is below the minimum RT
policy's minimum priority. So in that case, the standard is broken
by the patch.

> 
> > (of course this doesn't mean a great deal for Linux, but I think
> > we're good enough for a lot of soft-rt applications now).
> 
> Absolutely.  And getting noticeably better these days.
> 
> >> If I understand Ingo's proposal correctly, setting RLIMIT_RT_CPU to
> >> zero and then requesting SCHED_FIFO (with CAP_SYS_NICE) yields exactly
> >> the former behavior.  This will probably be the default setting.
> >
> > Oh yes, and that would surely have to be the only sane default
> > setting. But I then ask, why put this complexity into the kernel
> > in the first place? And is the cost of significantly breaking the
> > API and lying to userspace acceptable?
> 
> Well, this extremely long discussion started with a request on behalf
> of a large group of audio developers and users for a way to gain
> realtime scheduling privileges without running as root.
> 
> Several kernel developers felt that would be unacceptable, because of
> the Denial of Service implications.  We argued that the owner of a
> Digital Audio Workstation should be free to lock up his CPU any time
> he wants.  But, no one would listen.  We were told that we didn't
> really know what we needed, and were asking the wrong question.  That
> was very discouraging.  It looked like LKML was going to ignore our
> needs for yet another year.
> 
> Had I been in charge, I would have adopted our silly little RT-LSM
> patch, declared victory, and moved on to other matters.  But, I'm not
> responsible for this particular kernel.  (Thank you, God!)  So, I am
> willing to defer to the prejudices of those who are.  But, the limit
> of my deference is reached when they refuse to meet my needs.
> 
> When Con and Ingo started floating scheduler proposals, I tried to
> help them produce something useful.  I think they have succeeded.
> 
> Is this the easiest way to meet our needs?  No way.  But it's not bad,
> and I think it will work.  In some ways, it's actually better than our
> original RT-LSM proposal.  Ingo's scheduler patch is not very large.
> 

I have sympathy for you. I'm just observing that if we add the
simple rlimit first, this solves your (and this large group of
audio developers') particular problem. In fact, this will be the
_quickest_ path to get your requirement into the kernel, too.

At which point, there doesn't appear to be a need for more
complexity (which is what us kernel developers would like to hear!).

And I still maintain that it is stupid to run two unrelated (ie.
neither has knowledge of the other) realtime systems on the same
computer. One or both could easily break. So I agree with your point
that we needn't have to make realtime scheduling "nice" for a multi
user situation.

> >> The main point of discussion is: exactly what resource should it
> >> limit?  Arjan and Chris proposed to limit priority.  Ingo proposed to
> >> limit the percentage of each CPU available for realtime threads
> >> (collectively).  Either would meet our minimum needs (AFAICT).
> >
> > I think the priority limit is the better way, because the % CPU
> > available to real time threads approach essentially gives you no
> > realtime scheduling at all.
> 
> Setting RLIMIT_RT_CPU to 100% gives exactly what you are asking for.
> 

But now I have no control over priorities. So root cannot be
guaranteed to have its highest-priority watchdog run.

> In fact, I will probably lower it to 98%, taking advantage of the
> scheduler's ability to throttle runaway threads.  Locking up the CPU
> is not a big problem in my life, but it can be annoying when it does
> occur.  The JACK watchdog does not catch every bug we see during
> development.
> 

We've got Alt+SysRq+N now, which is nice for development.

> > By limiting priority, you can at least construct userspace solutions
> > to managing RT threads.
> 
> I think I can do it either way.  
> 
> Further, I believe distributions will probably set a reasonably high
> RLIMIT_RT_CPU for desktop users, allowing audio applications to work
> quite well right out of the box.
> 
> I don't much like Mac OS X.  It annoys the hell out of me that they
> can run Linux audio applications so much better than Linux.  According
> to Stephane Letz (who did the JACK OSX port), their scheduler has a
> similar throttle set at about 90%.  It does not seem to be causing
> them any practical problems that I can tell.
> 

Well in the context of a multi user system, this really is a privileged
operation. Witness: a normal user isn't even allowed to raise the nice
priority of a normal task. Note that I think everyone agrees here, but
I'm just repeating the point.

> >> > And finally, with rlimit support, is there any reason why lockup
> >> > detection and correction can't go into userspace? Even RT
> >> > throttling could probably be done in a userspace daemon.
> >> 
> >> It can.  But, doing it in the kernel is more efficient, and probably
> >> more reliable.
> >
> > Possibly. But the people who want a solution seem to be in a very
> > small minority, and I'm not sure how much you care about efficiency.
> 
> I do care.  The average overhead of running a watchdog daemon at max
> priority is tiny.  But, its impact on worst-case trigger latencies is
> non-trivial and must be added to everything else in the RT subsystem.

Oh yeah maybe. But you and the audio guys don't care about multi-user
security, so you don't need this.

Nick



