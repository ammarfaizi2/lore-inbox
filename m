Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbUKBOgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUKBOgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUKBOLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:11:25 -0500
Received: from mx1.elte.hu ([157.181.1.137]:22686 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261240AbUKBNvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:51:15 -0500
Date: Tue, 2 Nov 2004 14:52:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] optional non-interactive mode for cpu scheduler
Message-ID: <20041102135220.GA20237@elte.hu>
References: <41871BA7.6070300@kolivas.org> <20041102125218.GH15290@elte.hu> <4187854C.6000803@kolivas.org> <20041102131105.GA17535@elte.hu> <41878E47.5090805@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41878E47.5090805@kolivas.org>
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


* Con Kolivas <kernel@kolivas.org> wrote:

> I'll look into coding it later this week (thanks for suggesting I do
> it btw). This ordeal has left me seriously sleep deprived :P

:-|

> Since we're considering providing a special cpu policy for high
> latency high cpu usage, does that mean we can now talk about other
> policies like batch, isochronous etc? And in the medium to long term
> future, gang and group?

SCHED_ISO would be interesting, but all SCHED_BATCH patches that i've
seen so far were fundamentally broken. [ none protects against the
possibility of a simple CPU hog starving a SCHED_BATCH task in kernel
mode holding say /home's i_sem forever. None except the one i wrote a
couple of years ago that is ;-) ]

but obviously any new scheduling policy first needs considerable
testing, exposure and concensus. The main thing that makes
SCHED_CPUBOUND possibly objectionable is that it could easily be used as
a flag to 'turn off the interactivity code', which is wrong and just
prolongs the fixing of interactivity-estimator bugs. Scientific apps
burn CPU time exclusively and they have a stable priority at the low end
of the range.

One exception would be CPU-bound code with multiple threads which
interact with each other - one always runs but the others always sleep.
A possible solution would be to exclude all inter-task synchronization
methods from the 'interactivity boost' and only hard-device-waits would
be considered true 'waiting', such as keyboard, mouse, disk or network
IO.

	Ingo
