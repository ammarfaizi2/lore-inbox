Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVAPXWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVAPXWw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 18:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVAPXWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 18:22:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:12698 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262645AbVAPXWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 18:22:50 -0500
Date: Mon, 17 Jan 2005 00:22:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050116232224.GD24610@elte.hu>
References: <20050107134941.11cecbfc.akpm@osdl.org> <20050107221059.GA17392@infradead.org> <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us> <20050111212139.GA22817@elte.hu> <87ekgnwaqx.fsf@sulphur.joq.us> <20050115144302.GG10114@elte.hu> <87r7kmuw3i.fsf@sulphur.joq.us> <87r7kmf8kg.fsf@sulphur.joq.us> <87y8euc7x9.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y8euc7x9.fsf@sulphur.joq.us>
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

> Studying the test script, I discovered that it starts a separate
> program running in the background.  So, I hacked the script to run it
> with nice -15 in order not to interfere with the realtime threads. The
> XRUNS didn't get much better, but the maximum delay went way down,
> from 1/2 sec to a much more believable (but still too high) 32.5 msec.
> I ran this with the same patched scheduler.

> This supports my intuition that lack of per-thread granularity is the
> main problem.  Where I was able to isolate some non-realtime code and
> run it at lower priority, it helped quite a bit.

ok, makes perfect sense. My suggestion for the next step would be to try
nice() or setpriority() to do priority isolation.

If that experiment works out fine (i.e. the xrun count is comparable to
the SCHED_FIFO case) then it would also be nice to do a nice --19 run
(under the hacked kernel), which is a priority level that doesnt have
starvation turned off in the patched kernel but is otherwise very close
in behavior to nice --20.

i.e. as an end result we'd have the following 3 priority setups
compared: SCHED_FIFO:RT-prio-1, SCHED_NORMAL:nice--20,
SCHED_NORMAL:nice--19. The (ideal) goal would be for them to have
near-identical audio-latency performance.

	Ingo
