Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUIDUEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUIDUEK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 16:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUIDUEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 16:04:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17032 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266006AbUIDUEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 16:04:06 -0400
Date: Sat, 4 Sep 2004 22:05:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R3
Message-ID: <20040904200501.GA15383@elte.hu>
References: <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <4138A56B.4050006@cybsft.com> <20040903181710.GA10217@elte.hu> <20040903193052.GA16617@elte.hu> <413939F8.1030806@cybsft.com> <20040904085717.GA15744@elte.hu> <4139D2C1.2020202@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4139D2C1.2020202@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> I am glad that it's reproducible for you as well. How did you trigger
> it? Because it seems to only crash under heavy load for me. The system
> has been up since I rebooted last night after the crash and I haven't
> seen any problems. Same thing goes for up until last night when I
> booted the new patch. Even building the new patch didn't seem to be
> enough to trigger it.

i triggered it via two IO-intense scripts running on a 256 MB RAM
testbox:

  cd /tmp; while true; do dd if=/dev/zero of=bigfile bs=1000000 
  count=500 >/dev/null 2>/dev/null; sync; date; sleep 60; done &

  while true; do du /usr >/dev/null 2>/dev/null; date; done &

usually it triggers within half an hour or so of runtime. With -R4 it
didnt crash yet after ~1 hour of running so i'm quite optimistic that 
this particular bug has been fixed.

i think the key to reproduce was to use KP=0,SP=0,HP=0 - this
concentrates all preemption activity to the places the VP patch adds -
amongst them the one in the do_exit() path that is necessary to trigger
the race.

	Ingo
