Return-Path: <linux-kernel-owner+willy=40w.ods.org-S382002AbUKBIRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S382002AbUKBIRj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 03:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S382003AbUKBIRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 03:17:37 -0500
Received: from mx1.elte.hu ([157.181.1.137]:18114 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S382516AbUKBIQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 03:16:57 -0500
Date: Tue, 2 Nov 2004 09:17:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041102081750.GD21359@elte.hu>
References: <20041101143049.GA22221@elte.hu> <200411011930.iA1JULiQ009302@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411011930.iA1JULiQ009302@localhost.localdomain>
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


* Paul Davis <paul@linuxaudiosystems.com> wrote:

> >poll() is quite complex and with a good number of locks in the path the
> >maximum latency increases accordingly.
> 
> how can poll(2) be more complex than read/write? if it is, it
> shouldn't be ;)

poll() is fundamentally more complex: it has to watch multiple channels,
while read()/write() has to watch only a single event channel. The fact
that read()/write() also has to do some actual IO makes little
difference to complexity, as poll() already has to do most of the
locking read()/write() has to do, to figure out that it _could_ do the
read()/write().

> >btw., couldnt jackd use a separate input and output thread (of identical
> >priority), to be purely read()/write() based? This method should also
> >solve the priority problems of poll(): the thread woken up later will do
> >the work later. (hence the _earlier_ interrupt source will be handled
> >first.) With poll() how do you tell which fd needs attention first, if
> >both are set?
> 
> we don't really care which one needs attention "first". [...]

well, order of processing can make a difference under a high event load.
Couldnt capture and playback interrupts be separate and differently
timed? I understand your previous points that the audio 'channels' are
highly coupled and cannot be considered separate 'event sources', but is
the same true for all the fds that jackd passes into poll()? Is it true
if multiple cards are used?

the scenario that could trigger problems is that if an event (or group
of events) triggers some processing in the highprio thread, and two more
events arrive, one at the beginning of the previous processing, one at
the end of it. Once the highprio thread calls poll() again, the timing
of the two events has been lost - and jackd could end up processing the
_later_ event.

while this should normally make no difference with low audio loads, i
can very much see this causing problem as the number of cards/events
increases. What is typically the longest amount of time the highprio
thread can spend 'processing' without being actively poll()-ing? I know
it is typically short, but what is roughly the longest amount of time?
(is it the 1.4 msecs displayed in one of Rui's earlier testresults?)

	Ingo
