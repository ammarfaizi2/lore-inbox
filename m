Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUHSHqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUHSHqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUHSHps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:45:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10665 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263093AbUHSHpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 03:45:44 -0400
Date: Thu, 19 Aug 2004 09:47:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
Message-ID: <20040819074702.GA2075@elte.hu>
References: <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu> <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092831726.5777.160.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092831726.5777.160.camel@localhost>
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


* Thomas Charbonnel <thomas@undata.org> wrote:

> The next problem I have relates to irq sharing. 
> On my laptop I can't avoid it :
>  10:    1070631          XT-PIC  yenta, yenta, uhci_hcd, Intel
> 82801CA-ICH3, hdsp, eth0
> If I set the sound card's interrupt to be non threaded, then I get a
> rather long non preemptible section :
> http://www.undata.org/~thomas/irq_sharing.trace

i'm not sure the IRQ sharing problem can be solved.

we could execute certain handlers immediately, and defer others to an
IRQ thread. But when we defer an IRQ we must keep the IRQ masked - which
prevents further interrupts (possibly from a high-prio non-threaded
handler) to be executed. So we'd see similar (or in fact worse, due to
the redirection cost) latencies than with the current 'all or nothing'
approach.

now in theory we only have to keep the IRQ line masked for level
triggered interrupts (most APIC interrupts are level-triggered). 
Edge-triggered interrupts (such as the XT-PIC ones you have) could be
acked immediately. I'll try to do something later, but right now there
are still some IRQ problems (USB issues, PS2 mouse/keyboard issues) so
i'd not like to complicate the design just yet.

	Ingo
