Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266688AbUF3PDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266688AbUF3PDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUF3PDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:03:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8619 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266688AbUF3PDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:03:16 -0400
Date: Wed, 30 Jun 2004 17:04:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
Message-ID: <20040630150430.GA28506@elte.hu>
References: <200406301341.i5UDfkKX010518@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406301341.i5UDfkKX010518@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Davis <paul@linuxaudiosystems.com> wrote:

> The first and most visible issue is with inheritance of SCHED_FIFO
> scheduling. Although there are other mechanisms available under 2.6,
> many people use the "jackstart" helper application which runs setuid
> root and uses capabilities to start up JACK with the required caps to
> allow use of SCHED_FIFO and mlockall(). This has worked very well in
> 2.4 for about 2 years, but in 2.6 JACK fails to get its threads to be
> in the SCHED_FIFO scheduling class without a bunch of nasty kludges.
> 
> Things work correctly as soon as LD_ASSUME_KERNEL is used. 

A simple "strace -f" should show whether the setscheduler() call
succeeds or not. Does 'jackstart' do anything with glibc internals?

> We also see apparently impossible thread scheduling, where a thread
> that should run immediately is delayed by a significant time, and the
> thread that woke the first one up (and should be waiting for it to
> execute) runs again, apparently without ever having blocked. Once
> more, it all works correctly is LD_ASSUME_KERNEL is used to avoid
> NPTL.

there was a SCHED_FIFO bug in all 2.6 kernels prior 2.6.5, causing
erratic scheduling. Have you tried 2.6.6 or 2.6.7?

> Are there known issues with the implementation of NPTL that might give
> rise to this behaviour? What can we do to help understand and debug
> it?

there's nothing special about NPTL, scheduling-wise. But if SCHED_FIFO
is not properly set for all JACK threads that could explain the
symptoms. You talked about kludges that are necessary to make all
threads SCHED_FIFO - are you 100% sure that all JACK threads are indeed
SCHED_FIFO after these kludges are applied? If yes and you are running a
later kernel then it's something new and probably NPTL-unrelated.

	Ingo
