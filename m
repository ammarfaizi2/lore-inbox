Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbVKOUAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbVKOUAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 15:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbVKOUAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 15:00:06 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53642 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964993AbVKOUAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 15:00:02 -0500
Date: Tue, 15 Nov 2005 21:00:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john cooper <john.cooper@timesys.com>
Cc: Luca Falavigna <dktrkranz@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Softlockup detected with linux-2.6.14-rt6
Message-ID: <20051115200010.GA13802@elte.hu>
References: <4378B48E.6010006@gmail.com> <20051115153257.GA9727@elte.hu> <437A14FB.8050206@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437A14FB.8050206@timesys.com>
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


* john cooper <john.cooper@timesys.com> wrote:

> Ingo Molnar wrote:
> >* Luca Falavigna <dktrkranz@gmail.com> wrote:
> >>I found this softlockup bug involving arts daemon using a
> >>linux-2.6.14-rt6 kernel (with "Complete Preemption" and "Detect Soft
> >>Lockups" compiled in).
> >>This bug does not happen everytime: I was able to reproduce it only
> >>three times in a week. [...]
> >
> >
> >does this happen with -rt13 too? I have fixed a softlockup 
> >false-positive in it.
> 
> Just curious what the cause of the false positive was?

the fix is below - we didnt reset the 'light' counter in the else 
branch.

	Ingo

Index: linux/kernel/softlockup.c
===================================================================
--- linux.orig/kernel/softlockup.c
+++ linux/kernel/softlockup.c
@@ -90,7 +90,8 @@ void softlockup_tick(void)
 
 		wake_up_process(per_cpu(watchdog_task, this_cpu));
 		per_cpu(timeout, this_cpu) = jiffies + msecs_to_jiffies(1000);
-	}
+	} else
+		touch_light_softlockup_watchdog();
 
 	if (per_cpu(print_timestamp, this_cpu) == timestamp)
 		return;
