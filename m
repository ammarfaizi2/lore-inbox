Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270383AbUJUKGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270383AbUJUKGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270641AbUJUKEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:04:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18823 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270629AbUJUKBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:01:52 -0400
Date: Thu, 21 Oct 2004 12:03:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021100312.GA31827@elte.hu>
References: <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <30690.195.245.190.93.1098349976.squirrel@195.245.190.93> <1098350190.26758.24.camel@thomas> <20041021093532.GA2482@infradead.org> <20041021094438.GA30986@elte.hu> <20041021094726.GA2652@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021094726.GA2652@infradead.org>
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


* Christoph Hellwig <hch@infradead.org> wrote:

> > yes, it is valid and perfectly fine code, but i'm trying to separate out
> > the simple 'mutex' functionality (99% of the semaphore users are just
> > that) and implement a 'counted semaphore' separately. This removes a
> > number of implementational constraints from mutexes.
> 
> So leave the good old struct semaphore alone and introduce a mutex_t..

with nearly 1000 'struct semaphore' references in the kernel and 980 of
them being simple mutex use this is rather impractical. So i instead
went for safely detecting the 20 non-mutex uses and converting those
places. (Btw., 90% of those 20 cases can be detected safely at
compile-time (and link-time) by removing DECLARE_MUTEX_LOCKED and making
sema_init() a macro that only allows constant values of 0 and 1 and
produces a link error for other cases.)

this work is still incomplete so i'm not arguing for upstream inclusion.

(But while we did this a couple of places did turn out to use semaphores
for completion which is inefficient - we converted those to completions
and are contributing those changes to mainline. But this issue is
totally orthogonal to the issue of counted semaphores.)

	Ingo
