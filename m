Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265764AbUG1GDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUG1GDR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 02:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUG1GDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 02:03:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:35805 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265764AbUG1GDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 02:03:15 -0400
Date: Wed, 28 Jul 2004 07:05:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
Message-ID: <20040728050535.GA14742@elte.hu>
References: <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu> <1090968457.743.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090968457.743.3.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > i've done a softirq lock-break in the atkbd and ps2mouse drivers - this
> > should fix the big latencies triggered by NumLock/CapsLock, reported by
> > Lee Revell.
> 
> L2 does not fix this problem.  Previously, toggling CapsLock would
> trigger a single large XRUN.  Now it seems to actually prevent the
> soundcard interrupt handler from executing in time, as well as
> triggering smaller XRUNs.  This is with preempt=1,
> voluntary-preempt=3.

yeah, this is because right now irqd lacks any configurability: it is
executing all hardirqs (and all softirqs) in one context without any
particular prioritization.

if your soundcard doesnt share the irq line with any other 'heavy' 
interrupt then you can make the irq 'direct' via a simple change to 
arch/i386/kernel/irq.c, change this line from:

 #define redirectable_irq(irq) ((irq) != 0)

to:

 #define redirectable_irq(irq) (((irq) != 0) && ((irq) != 10))

(if the soundcard is on IRQ 10).

does such a change combined with v=3 fix the latencies you are seeing?

	Ingo
