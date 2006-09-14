Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWINUEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWINUEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWINUEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:04:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38307 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751105AbWINUEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:04:36 -0400
Date: Thu, 14 Sep 2006 21:56:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@jikos.cz>, lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
Message-ID: <20060914195641.GA5812@elte.hu>
References: <Pine.LNX.4.64.0609141028540.22181@twin.jikos.cz> <d120d5000609140618h6e929883u2ed82d1cab677e57@mail.gmail.com> <Pine.LNX.4.64.0609141635040.2721@twin.jikos.cz> <d120d5000609140758w7ba5cfdbs399d6831082e7cb4@mail.gmail.com> <Pine.LNX.4.64.0609141700250.2721@twin.jikos.cz> <d120d5000609140851r2299c64cv8b0a365be795a1bc@mail.gmail.com> <Pine.LNX.4.64.0609141754480.2721@twin.jikos.cz> <d120d5000609140918j18d68a4dmd9d9e1e72d2fd718@mail.gmail.com> <Pine.LNX.4.64.0609142037110.2721@twin.jikos.cz> <d120d5000609141156h5e06eb68k87a6fe072a701dab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000609141156h5e06eb68k87a6fe072a701dab@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> I think it is - as far as I understand the reason for not tracking 
> every lock individually is just that it is too expensive to do by 
> default.

that is not at all the reason! The reason is that we want to find 
deadlocks _as early as mathematically possible_ (in a running system, 
where locking patterns are observed). That is we want to gather the 
_most generic_ locking rules.

For example, if there are lock_1A, lock_1B of the same lock class, and 
lock_2A and lock_2B of another lock class. If we observed the following 
usage patterns:

	acquire(lock_1A);
	acquire(lock_2A);
	release(lock_2A);
	release(lock_1A);

and another piece of kernel code did:

	acquire(lock_2B);
	acquire(lock_1B);
	release(lock_1B);
	release(lock_1B);

with per-lock rules there's no problem detected, because the 4 locks are 
independent and we only observed a 1A->2A and a 2B->1B dependency.

But with per-class rule gather we'd observe the 1->2 and the 2->1 
dependency, and we'd warn that there's a deadlock.

So we want to create as broad, as generic rules as possible, to catch 
deadlocks as soon as it's _provable_ that they could occur. In that 
sense lockdep wants to have a '100% proof' of correctness: the first 
time a bad even happens we flag it.

	Ingo
