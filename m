Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVAELwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVAELwm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVAELwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:52:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48081 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262341AbVAELwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:52:40 -0500
Date: Wed, 5 Jan 2005 12:52:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050105115213.GA17816@elte.hu>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <87u0pxhvn0.fsf@sulphur.joq.us> <1104865198.8346.8.camel@krustophenia.net> <1104878646.17166.63.camel@localhost.localdomain> <20050104175043.H469@build.pdx.osdl.net> <1104890131.18410.32.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104890131.18410.32.camel@krustophenia.net>
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


the RT-LSM thing is a bit dangerous because it doesnt really protect
against a runaway, buggy app. So i think the right way to approach this
problem is to not apply RT-LSM for the time being, but to provide an
'advanced latency needs' scheduling class that is _still_ safe even if
the task is runaway, but behaves with near-RT priorities if the task is
'nice' (i.e. doesnt use up large amount of CPU time.)

incidentally, there is such a scheduling class already: negative nice
levels. Please skip any preconceptions you might have about nice levels,
nice levels have been improved in 2.6.10, the timeslices are now given
out exponentially, giving nice -20 tasks far more weight and priority
than they used to have. (They are obviously still preemptable if they
keep looping burning CPU - but that we can consider a feature.) (Also,
in 2.6 the negative nice levels have a much more agressive interactivity
setting, allowing them to preempt everything lower-prio.)

so, could you try vanilla 2.6.10 (without LSM and without jackd running
with RT priorities), with jackd set to nice -20? Make sure the
jack-client process gets this priority too. Best to achieve this is to
renice a shell to -20 and start up everything from there - the nice
settings will be inherited. How does such an audio test compare to a
test done with jackd running at SCHED_FIFO with RT priority 1?

if this works out well then we could achieve something comparable to
RT-LSM, via nice levels alone.

	Ingo
