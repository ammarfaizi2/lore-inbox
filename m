Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264351AbTLVIrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 03:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264347AbTLVIrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 03:47:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:57768 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264351AbTLVIre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 03:47:34 -0500
Date: Mon, 22 Dec 2003 09:48:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christian Meder <chris@onestepahead.de>
Cc: linux-kernel@vger.kernel.org, gnomemeeting-devel-list@gnome.org
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
Message-ID: <20031222084824.GA4562@elte.hu>
References: <3FE3C6FC.7050401@cyberone.com.au> <1071893802.1363.21.camel@localhost> <3FE3D0CB.603@cyberone.com.au> <1071897314.1363.43.camel@localhost> <20031220111917.GA18267@elte.hu> <1071938978.1025.48.camel@localhost> <20031220174232.GA29189@elte.hu> <1071970825.1025.87.camel@localhost> <20031221085716.GA21322@elte.hu> <1072055962.999.69.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072055962.999.69.camel@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christian Meder <chris@onestepahead.de> wrote:

> > 	nice -19 ./loop &
> > 
> > do a couple of such loops still degrade gnomemeeting?
> 
> I found the culprit. It's sched_yield again. When I straced
> gnomemeeting even without load I saw a lot of sched_yields. [...]

this is definitely broken code. Such code already causes big CPU
overhead in certain circumstances (under 2.4 too) - but in 2.6 it also
shows up as an interactivity problem. So 2.4 hid the problem, 2.6
exposes it.

> So the questionable code in pwlib is probably: 

> > BOOL PSemaphore::Wait(const PTimeInterval & waitTime)

yeah. pwlib should be fixed. The quick fix is, instead of sched_yield(),
to do:

	{
		struct timespec timer = { 0, 1 };

		nanosleep (&timer, NULL);
	}

this does what pwlib really wants to do: sleep for the shortest amount
of time posssible, because its semaphore implementation is polling
based.

(but pwlib should perhaps use sem_timedwait(sem, abs_timeout) instead -
which does exactly what PSemaphore::Wait() tries to implement.)

	Ingo
