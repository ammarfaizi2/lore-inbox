Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUIGJ0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUIGJ0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 05:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267754AbUIGJ0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 05:26:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11141 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267760AbUIGJ0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 05:26:34 -0400
Date: Tue, 7 Sep 2004 11:26:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Alexander Nyberg <alexn@dsv.su.se>
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk12-R7
Message-ID: <20040907092659.GA17677@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu> <200409061348.41324.rjw@sisk.pl> <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906122954.GA7720@elte.hu>
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


i've ported the VP patch to x64. I havent boot-tested it, but it
compiles cleanly and it might even boot:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-R7

Caveats: normal kernel with PREEMPT, PREEMPT_VOLUNTARY, PREEMPT_SOFTIRQS
and PREEMPT_HARDIRQS disabled should work just fine.

A kernel with PREEMPT=y and PREEMPT_VOLUNTARY=y ought to work too - with
a smaller probability though. PREEMPT_SOFTIRQS=y should be the next step
- this one might work too. (PREEMPT_HARDIRQS=y doesnt do anything on x64
yet, because i havent changed the irq code. I'd like to keep non-x86
changes small, unless a developer picks it up - like it happened for the
ppc and ppc64 port of the VP patch.)

PREEMPT_TIMING=y might work too if the previous ones worked. The most
problematic one is probably LATENCY_TRACE=y - i've added the proper
mcount assembly code but mostly blindly. It does compile.

so please try this kernel on real hw and try to figure out step by step
at which stage in the following order of parameters it breaks:

 PREEMPT=y
 PREEMPT_VOLUNTARY=y
 PREEMPT_SOFTIRQS=y
 PREEMPT_TIMING=y
 LATENCY_TRACE=y

(when enabling a new option in this sequence keep all the previous
options enabled.)

Worst-case it already breaks with all these options disabled - in this
case please double-check whether vanilla -bk12 x64 boots fine with the
same .config.

Best-case it works fine with all options enabled - quite unlikely.

If it breaks it will break early and hard during bootup, so data is
probably not at risk - but be careful nevertheless.

to get a 2.6.9-rc1-bk12 kernel the patching order is:

    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
  + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc1.bz2
  + http://redhat.com/~mingo/voluntary-preempt/patch-2.6.9-rc1-bk12.bz2

	Ingo
