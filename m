Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVA0LgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVA0LgR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 06:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVA0LgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 06:36:17 -0500
Received: from mx1.elte.hu ([157.181.1.137]:60581 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262572AbVA0LgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 06:36:06 -0500
Date: Thu, 27 Jan 2005 12:35:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050127113530.GA30422@elte.hu>
References: <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pszr1mi1.fsf@sulphur.joq.us>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jack O'Quin <joq@io.com> wrote:

> Well, this extremely long discussion started with a request on behalf
> of a large group of audio developers and users for a way to gain
> realtime scheduling privileges without running as root.
> 
> Several kernel developers felt that would be unacceptable, because of
> the Denial of Service implications.  We argued that the owner of a
> Digital Audio Workstation should be free to lock up his CPU any time
> he wants.  But, no one would listen. [...]

i certainly listened, but that didnt make the RT-LSM proposal better in
any way!

> Had I been in charge, I would have adopted our silly little RT-LSM
> patch, declared victory, and moved on to other matters. [...]

let me put this very bluntly: this is precisely how bad OSs get written. 
Half-done features with known limitations piling up. One or two of
crappy features might not hurt as badly, but when you start having
dozens of them it hurts big time. With time, crap _does_ pile up. So in
the Linux core code we have zero tolerance on crap. We are doing this
for the long-term fun of it.

repeat after me: we dont apply half-assed measures just to solve a
problem in a short-sighted way! And repeat after me: upstream reviewers
or maintainers are not _obliged_ to provide the proper solution either! 

The Linux acceptance process is not about "whose patch sucks least", but
whether it hits a subsystem-specific bar of architectural requirements
or not. RT-LSM didnt hit the bar, end of story. You are always free to
write something proper (or convince/pay someone to write it for you)
which _will_ be accepted. Also, you are always free to replace code or
maintainers by writing/maintaining the code in a better way.

and if nobody ends up writing the 'proper' solution then there probably
wasnt enough demand to begin with ... We'll rather live on with one less
feature for another year than with a crappy feature that is twice as
hard to get rid of!

you might ask yourself, 'why is this so, and why cannot the Linux guys
apply pretty much any hack as e.g. userspace code might': the difference
in the case of the kernel is compatibility with thousands of
applications and millions of users. If we expose some method to
applications then that decision has to stick in 99.999% of the cases. 
It's awfully hard to get rid of a bad, user-visible feature. Also,
kernel code, especially the scheduler (and the security subsystem) is
complex, interdependent, performance-sensitive and is modified very
frequently - any bad decision lives with us for long, and hinders us for
long.

ironically, i believe you are providing an additional proof that the
Linux development process worked in this particular case:

> When Con and Ingo started floating scheduler proposals, I tried to
> help them produce something useful.  I think they have succeeded.
> 
> Is this the easiest way to meet our needs?  No way.  But it's not bad,
> and I think it will work.  In some ways, it's actually better than our
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> original RT-LSM proposal.  Ingo's scheduler patch is not very large.
  ^^^^^^^^^^^^^^^^^^^^^^^^^

here you can see the concept in the works: _because_ RT-LSM was not
accepted did Con's and my work get any chance!

Put your hand on your heart and tell me, assuming RT-LSM went in, and in
a year's time i'd write the rlimit patch, would you even test my rlimit
patch with your audio apps? Or would you have told me 'sorry, RT-LSM is
good enough for our purposes and i dont have time to test this now'.

What would you have told me if my patch also removed RT-LSM (because it
implemented a superior method and i wanted to get rid of the crap)? 
Would you possibly have cried bloody murder about breaking backwards
compatibility with audio apps?

so we have two different goals. You want a feature. We want robust
features. Those goals do meet in that we both want features, but our
interests are exactly the opposite in terms of quality and timeframe:
you want a solution that meets _your_ needs, as soon as possible - while
we want a longterm solution. (i.e. a solution that is as generic, clean,
maintainable and robust as possible.)

(Dont misunderstand me, this is not any 'fault' of yours, this is simply
your interest: you are not hacking kernel code so you are at most
compassionate with our needs, but you are not directly affected by
kernel code quality issues.)

(also, believe me, this is not arrogance or some kind of game on our
part. If there was a nice clean solution that solved your and others'
problems equally well then it would already be in Linus' tree. But there
is no such solution yet, at the moment. Moreover, the pure fact that so
many patch proposals exist and none looks dominantly convincing shows
that this is a problem area for which there are no easy solutions. We
hate such moments just as much as you do, but they do happen.)

	Ingo
