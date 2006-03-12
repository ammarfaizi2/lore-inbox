Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWCLPRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWCLPRq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 10:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWCLPRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 10:17:46 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:63124 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750815AbWCLPRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 10:17:45 -0500
Date: Sun, 12 Mar 2006 16:17:41 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 5/8] hrtimer remove state field
In-Reply-To: <1142175286.19916.459.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603121608440.17704@scrub.home>
References: <20060312080316.826824000@localhost.localdomain> 
 <20060312080332.274315000@localhost.localdomain>  <Pine.LNX.4.64.0603121302590.16802@scrub.home>
  <1142169010.19916.397.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0603121422180.16802@scrub.home>  <1142170505.19916.402.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121444530.16802@scrub.home>  <1142172917.19916.421.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121523320.16802@scrub.home> <1142175286.19916.459.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 12 Mar 2006, Thomas Gleixner wrote:

> > In this case no signal is queued and the timer won't be restarted via 
> > signal delivery.
> 
> Roman,
> 
> Interrupts are enable before fn() is called, so an interrupt can
> actually delay it long enough that userspace on CPU1 can set SIG_IGN
> 
> CPU 0
> spin_unlock_irq(base->lock)	
> 			CPU1
> 			signal is dequeued
> 				timer is requeued
> 			user space code is executed
> 			user space code sets SIG_IGN
> restart = fn();
> 
> Now fn() calls send_sigqeue() which returns 1, resulting in ret =
> HRTIMER_RESTART which leads to requeueing of an enqueued timer.

I'm not quite sure I follow, when the timer is running no signal should be 
queued, so nothing can be dequeued and no new timer can be requeued.
If that somehow is possible (although I don't see how), you'd found a bug 
in the signal/posix timer code, which should not be worked around in the 
hrtimer run queue.

bye, Roman
