Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbUKVLiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbUKVLiC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 06:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbUKVLfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 06:35:51 -0500
Received: from mx1.elte.hu ([157.181.1.137]:26340 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261276AbUKVLfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 06:35:15 -0500
Date: Mon, 22 Nov 2004 13:37:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041122123741.GA13574@elte.hu>
References: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk> <20041122092302.GA7210@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122092302.GA7210@nietzsche.lynx.com>
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


* Bill Huey <bhuey@lnxw.com> wrote:

> [...] There might be places where, if algorithmically bounded somehow,
> reverting some of the heavy hammered sleeping locks back to spinlocks
> would make the system faster and more controlled. rtc_lock possibly
> could be one of those places and other places that are as heavily as
> used as that.

in the -RT patchset one of the reasons why i've gone for the completely
preemptible variant is to trigger all priority inversion problems
outright. In the first variant they didnt really trigger - but they were
present. Once the locks were almost all preemptible, PI problems
surfaced in a big way - causing people to report them and forcing me to
fix them :-)

There are lots of critical sections in Linux and we cannot design around
them - so if the goal is hard-RT properties and latencies then priority
inversion is a problem that has to be solved. Later on we could easily
revert some of the hw-related spinlocks to raw spinlocks, and/or the
known-O(1) critical sections as well.

the paper cited is not very persuasive to me though. It lists problems
of an incomplete/incorrect PI implementation, and comes to the IMO false
(and unrelated) conclusion that somehow PI-handling is not desired.
Obviously PI makes only sense if it's implemented correctly. I think i
managed to fix the problems Esben's testsuite uncovered, in the current
-RT patch. Anyway, this implementation is also special in that it relies
on correct SMP locking of Linux:

> Turning this into a "priority inheritance world" is just going to turn
> this project into the FreeBSD SMP project [...]

i dont have any intentions to turn Linux into a 'priority inheritance
world'. PI handling is only a property of the PREEMPT_RT feature
intended for the most latency-sensitive applications - the main and
primary critical-section model of Linux is and should still be a healthy
mix of spinlocks and mutexes. Having only mutexes (or only spinlocks) is
an extreme that _does_ hurt the common case. PREEMPT_RT 'only' lives on
the back of SMP-Linux.

	Ingo
