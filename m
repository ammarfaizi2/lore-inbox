Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUIBIgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUIBIgk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 04:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267869AbUIBIgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 04:36:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3215 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267916AbUIBIgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 04:36:00 -0400
Date: Thu, 2 Sep 2004 10:32:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: mika.penttila@kolumbus.fi
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
Message-ID: <20040902083205.GA22416@elte.hu>
References: <20040902075712.DGPM28426.fep02-app.kolumbus.fi@mta.imail.kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902075712.DGPM28426.fep02-app.kolumbus.fi@mta.imail.kolumbus.fi>
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


* mika.penttila@kolumbus.fi <mika.penttila@kolumbus.fi> wrote:

> Ingo,
> 
> I think there might be a problem with voluntary-preempt's hadling of
> softirqs. Namely, in cond_resched_softirq(), you do
> __local_bh_enable() and local_bh_disable(). But it may be the case
> that the softirq is handled from ksoftirqd, and then the preempt_count
> isn't elevated with SOFTIRQ_OFFSET (only PF_SOFTIRQ is set). So the
> __local_bh_enable() actually makes preempt_count negative, which might
> have bad effects. Or am I missing something?

you are right. Fortunately the main use of cond_resched_softirq() is via
cond_resched_all() - which is safe because it uses softirq_count(). But
the kernel/timer.c explicit call to cond_resched_softirq() is unsafe.
I've fixed this in my tree and i've added an assert to catch the
underflow when it happens.

	Ingo
