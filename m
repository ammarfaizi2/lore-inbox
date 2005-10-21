Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVJUIFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVJUIFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 04:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVJUIFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 04:05:02 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:4524 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964901AbVJUIFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 04:05:00 -0400
Date: Fri, 21 Oct 2005 10:05:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: William Weston <weston@lysdexia.org>, cc@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
Message-ID: <20051021080504.GA5088@elte.hu>
References: <20051017160536.GA2107@elte.hu> <1129576885.4720.3.camel@cmn3.stanford.edu> <1129599029.10429.1.camel@cmn3.stanford.edu> <20051018072844.GB21915@elte.hu> <1129669474.5929.8.camel@cmn3.stanford.edu> <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org> <20051019111943.GA31410@elte.hu> <1129835571.14374.11.camel@cmn3.stanford.edu> <20051020191620.GA21367@elte.hu> <1129852531.5227.4.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129852531.5227.4.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Found this on the logs:
> 
> Oct 20 15:52:57 cmn3 kernel: BUG in hydrogen:4810, ktimer expired 
> short without user signal!:

hm. This suggests that hydrogen executing schedule_ktimer() was waken up 
45 microseconds too early, and most likely it was not woken up by the 
hres timer code (which should have done the wakeup 45 microseconds later 
anyway).

I've added special hres-wakeup-debugging code to the scheduler in 
-rc5-rt2 to catch this particular scenario, you might want to give it a 
try. The new code is always enabled and it should pinpoint the precise 
place that does the wrong wakeup. You should see a new type of warning 
in your log:

 BUG: foo:1234 waking up bar:4321, expiring ktimer short without user signal!

in shortly before the usual "BUG: ktimer expired short" message. Both 
messages will be triggered only once per bootup - but the condition 
itself likely occurs much more often on your box.

	Ingo
