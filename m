Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbUJWMut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUJWMut (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 08:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUJWMut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 08:50:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35245 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261158AbUJWMuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 08:50:46 -0400
Date: Sat, 23 Oct 2004 14:51:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
Message-ID: <20041023125104.GA10883@elte.hu>
References: <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <32871.192.168.1.5.1098491242.squirrel@192.168.1.5> <20041023102909.GD30270@elte.hu> <32880.192.168.1.5.1098534617.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32880.192.168.1.5.1098534617.squirrel@192.168.1.5>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> > does the patch below help?

> Nope. Same result:

> SysRq : <3>BUG: sleeping function called from invalid context IRQ 1(776)
> at kernel/mutex.c:37
> in_atomic():0 [00000000], irqs_disabled():1

interrupts are disabled. You used a -RT-U10.2/3 kernel, and have 
CONFIG_REALTIME enabled, right? Do you have this in 
drivers/net/netconsole.c, line 77:

 #ifdef PREEMPT_REALTIME
         /*
          * A bit hairy. Netconsole uses mutexes (indirectly) and
          * thus must have interrupts enabled:
          */
         local_irq_enable();
 #endif

correct? Could you do this a few lines below:

                WARN_ON_RT(irqs_disabled());
                netpoll_send_udp(&np, msg, frag);
                WARN_ON_RT(irqs_disabled());

to figure out who disables interrupts. Also, could you add the same two
lines to net/core/netpoll.c, line 83:

        WARN_ON_RT(irqs_disabled());
        np->dev->poll_controller(np->dev);
        WARN_ON_RT(irqs_disabled());

and send me either the full bootlog, or the _first_ such BUG message
you'll be getting. Which network controller is this?

	Ingo
