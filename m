Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWCLOyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWCLOyZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 09:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWCLOyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 09:54:25 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:50152
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750803AbWCLOyZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 09:54:25 -0500
Subject: Re: [patch 5/8] hrtimer remove state field
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0603121523320.16802@scrub.home>
References: <20060312080316.826824000@localhost.localdomain>
	 <20060312080332.274315000@localhost.localdomain>
	 <Pine.LNX.4.64.0603121302590.16802@scrub.home>
	 <1142169010.19916.397.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121422180.16802@scrub.home>
	 <1142170505.19916.402.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121444530.16802@scrub.home>
	 <1142172917.19916.421.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121523320.16802@scrub.home>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 15:54:45 +0100
Message-Id: <1142175286.19916.459.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 15:30 +0100, Roman Zippel wrote:
> Hi,
> 
> On Sun, 12 Mar 2006, Thomas Gleixner wrote:
> 
> > > > > > base->unlock()
> > > > > > 			signal of previous expiry is delivered on CPU1
> > > > > > 			timer is reqeued.
> > > > 
> > > > 		------->  sig_ignore is set
> > > 
> > > ??? I can't find any symbol 'sig_ignore'.
> > 
> > Oh well. The application sets SIG_IGN for the signal in question, so
> > send_sigqueue() returns 1 because sig_ignored() returns 1.
> 
> In this case no signal is queued and the timer won't be restarted via 
> signal delivery.

Roman,

Interrupts are enable before fn() is called, so an interrupt can
actually delay it long enough that userspace on CPU1 can set SIG_IGN

CPU 0
spin_unlock_irq(base->lock)	
			CPU1
			signal is dequeued
				timer is requeued
			user space code is executed
			user space code sets SIG_IGN
restart = fn();

Now fn() calls send_sigqeue() which returns 1, resulting in ret =
HRTIMER_RESTART which leads to requeueing of an enqueued timer.

	tglx


