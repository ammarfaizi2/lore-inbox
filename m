Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUIAHD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUIAHD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 03:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266633AbUIAHD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 03:03:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43992 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266626AbUIAHDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 03:03:53 -0400
Date: Wed, 1 Sep 2004 09:05:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040901070519.GA19398@elte.hu>
References: <2zaWk-4Yj-9@gated-at.bofh.it> <2zmE8-4Zz-11@gated-at.bofh.it> <2zngP-5wD-9@gated-at.bofh.it> <2zngP-5wD-7@gated-at.bofh.it> <2znJS-5Pm-25@gated-at.bofh.it> <2znJS-5Pm-27@gated-at.bofh.it> <2znJS-5Pm-29@gated-at.bofh.it> <2znJS-5Pm-31@gated-at.bofh.it> <2znJS-5Pm-33@gated-at.bofh.it> <m3hdqij44z.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3hdqij44z.fsf@averell.firstfloor.org>
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


* Andi Kleen <ak@muc.de> wrote:

> > the third wbinvd() in post_set() seems unnecessary too - what kind of
> > cache do we expect to flush, we've disabled caching in the CPU ... But
> > the Intel pseudocode does it too - this is a thinko i think.
> 
> The multiple steps are needed, otherwise there can be problems with
> hyperthreading (the first x86-64 didn't do it in all cases, and it
> causes occassional problens with Intel CPUs)

i'm quite sure the first one is unnecessary - any interrupt could
already come inbetween and generate dirty cachelines, so it has zero
guaranteed effect.

the third one _seems_ unnecessary - what dirty cachelines can there be
after we've disabled the cache?

the hyperthreading question is valid but no way does the flush solve the
HT problems this code already has! The only proper way i can see to
_guarantee_ zero cache effects is to do a 'catch CPUs', 'disable IRQs,
all caches and flush them', and 'set MTRR's on all CPUs', 'enable all
caches', 'continue CPUs' sequence, SMP-synchronized at every point.
Otherwise you can always get some dirty cache state due to HT races and
whatever data corruption there might occur. I believe the MTRR code is
quite incorrectly coded as-is.

> Also repeated calls of this are relatively cheap because at the second
> time there is not much to flush anymore.

the trace shows that the first one is 300 usecs, the second and third 
one is 150 usecs each, so it's not exactly cheap.

	Ingo
