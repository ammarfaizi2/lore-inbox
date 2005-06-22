Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVFVKOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVFVKOJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVFVKMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 06:12:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11434 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262768AbVFVKIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 06:08:22 -0400
Date: Wed, 22 Jun 2005 12:08:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050622100802.GA9207@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org> <20050621131249.GB22691@elte.hu> <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org> <20050622082450.GA19957@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050622082450.GA19957@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * William Weston <weston@sysex.net> wrote:
> 
> > Attached are two typical traces and the .config from my Xeon/HT box, 
> > currently running -50-06 with a normal desktop workload (X, wmaker, 
> > ten dockapps, several xterms, and firefox).
> 
> the second trace seems to be a cross-CPU wakeup bug. It's not 
> completely clear from the trace what happened - but we measured the 
> latency of a task (wmcube-3191), where the wakeup happened on CPU#0 
> and wmcube-3191 was queued to CPU#1 which was idle at that time. The 
> bug is that it wasnt until timestamp 306us that this actually happened 
> - and CPU#1 was just idling around in default_idle() for no good 
> reason. CPU#1 should have run wmcube-3191 at around timestamp 13us.

ok, managed to reproduce it on a HT box, and it turned out to be a bug 
in the SMT scheduler: the dependent sleeper logic incorrectly delayed 
high-prio tasks, causing these latencies. I fixed it in the -50-10 
kernel - could you redo your tests with that kernel (or later versions)?

	Ingo
