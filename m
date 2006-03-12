Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWCLPl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWCLPl2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 10:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWCLPl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 10:41:28 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:14313
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750840AbWCLPl2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 10:41:28 -0500
Subject: Re: [patch 5/8] hrtimer remove state field
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0603121608440.17704@scrub.home>
References: <20060312080316.826824000@localhost.localdomain>
	 <20060312080332.274315000@localhost.localdomain>
	 <Pine.LNX.4.64.0603121302590.16802@scrub.home>
	 <1142169010.19916.397.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121422180.16802@scrub.home>
	 <1142170505.19916.402.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121444530.16802@scrub.home>
	 <1142172917.19916.421.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121523320.16802@scrub.home>
	 <1142175286.19916.459.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121608440.17704@scrub.home>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 16:41:48 +0100
Message-Id: <1142178108.19916.475.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 16:17 +0100, Roman Zippel wrote:
> > 
> > CPU 0
> > spin_unlock_irq(base->lock)	
> > 			CPU1
> > 			signal is dequeued
> > 				timer is requeued
> > 			user space code is executed
> > 			user space code sets SIG_IGN
> > restart = fn();
> > 
> > Now fn() calls send_sigqeue() which returns 1, resulting in ret =
> > HRTIMER_RESTART which leads to requeueing of an enqueued timer.
> 
> I'm not quite sure I follow, when the timer is running no signal should be 
> queued, so nothing can be dequeued and no new timer can be requeued.
> If that somehow is possible (although I don't see how), you'd found a bug 
> in the signal/posix timer code, which should not be worked around in the 
> hrtimer run queue.

How do you want to prevent that a signal is dequeued on one CPU while
the softirq expires the timer on another CPU ? This can not be
prevented.

Of course we can check hrtimer_active() in posix_timer_fn(), but I have
to check if there is a problem the other way round. I cook up a patch.

	tglx



