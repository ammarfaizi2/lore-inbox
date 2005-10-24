Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVJXSkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVJXSkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVJXSka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:40:30 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:17628 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751233AbVJXSka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:40:30 -0400
Subject: Re: 2.6.14-rc5-rt5 - softirq-timer/0/3[CPU#0]: BUG in ktime_get at
	kernel/ktimers.c:103
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark Knecht <markknecht@gmail.com>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20051024181320.GA9736@elte.hu>
References: <5bdc1c8b0510240907mc90490eoe111188ee874c8a5@mail.gmail.com>
	 <1130173552.7377.6.camel@localhost.localdomain>
	 <20051024181320.GA9736@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 24 Oct 2005 14:39:52 -0400
Message-Id: <1130179192.7377.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 20:13 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:

> > 
> > Thomas, this hasn't been done yet, has it?
> 
> not yet, but it's in progress. Meanwhile i increased the number of times 
> the warning will be printed per bootup (from 1 to 3), so that if a time 
> warp happens outside of that clock-switch case it should be printed too.
> 

Unfortunately, the problem doesn't go away until the clocks are
eventually updated.  So as Mark got, we see three outputs for every time
this happens until the now catches up with the prev.

Perhaps we should also add another update of prev?

-- Steve

Index: kernels/linux-2.6.14-rc5-rt5/kernel/ktimers.c
===================================================================
--- kernels.orig/linux-2.6.14-rc5-rt5/kernel/ktimers.c	2005-10-24 14:34:32.000000000 -0400
+++ kernels/linux-2.6.14-rc5-rt5/kernel/ktimers.c	2005-10-24 14:34:53.000000000 -0400
@@ -102,6 +102,7 @@
 				ktime_to_ns(prev), ktime_to_ns(now));
 			WARN_ON(1);
 		}
+		per_cpu(prev_mono_time, cpu) = now;
 		return prev;
 	}
 	per_cpu(prev_mono_time, cpu) = now;


