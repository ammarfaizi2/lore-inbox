Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbUKUMl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbUKUMl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 07:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbUKUMlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 07:41:25 -0500
Received: from mx1.elte.hu ([157.181.1.137]:30945 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261954AbUKUMlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 07:41:23 -0500
Date: Sun, 21 Nov 2004 14:43:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
Message-ID: <20041121134354.GA17759@elte.hu>
References: <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <1100920963.1424.1.camel@krustophenia.net> <20041120125536.GC8091@elte.hu> <1100971141.6879.18.camel@krustophenia.net> <20041120191403.GA16262@elte.hu> <1100975745.6879.35.camel@krustophenia.net> <20041120201155.6dc43c39@mango.fruits.de> <20041120214035.2deceaeb@mango.fruits.de> <20041121125439.GA8224@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121125439.GA8224@elte.hu>
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


> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > Hmm, the max jitter rtc_wakeup shows at 1024hz is around 150us. Which
> > seems a tiny bit large, too, as the rtc histogram shows a max wakeup
> > latency of 16us..
> 
> yep, that's a bit too large too. What type of load does it need to
> trigger such a 150 usec delay reliably?

on a 2 GHz UP box the worst-case max jitter i can trigger via rtc_wakeup
is 11 usecs, using the -5 kernel. The workload i used was 40 parallel
copies of LTP plus a few hackbench runs. This is how i started
rtc_wakeup:

 chrt -f 80 -p `pidof 'IRQ 0'`
 chrt -f 98 -p `pidof 'IRQ 8'`

 cd rtc_wakeup
 ./rtc_wakeup -f 1024 -t 100000

i.e. IRQ0 is below IRQ8 and the rtc_wakeup threads, but above every
other IRQ thread. Here's the histogram of a short (~5 minutes) run:

  1 247383
  2 34842
  3 1488
  4 3188
  5 125
  6 1

so this a 6 usecs max delay measured by /dev/rtc. So on your box, if the
max histogram delay was 16 usecs, i'd not expect a worse than ~30 usecs
jitter measured by rtc_wakeup. Can you reproduce the 150 usecs jitter
with the above IRQ setup?

	Ingo
