Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWFKPVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWFKPVJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 11:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWFKPVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 11:21:09 -0400
Received: from www.osadl.org ([213.239.205.134]:41890 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751629AbWFKPVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 11:21:07 -0400
Subject: Re: 2.6.17-rc6-rt3
From: Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1150029517.17158.38.camel@Homer.TheSimpsons.net>
References: <20060610082406.GA31985@elte.hu>
	 <1149942743.8340.14.camel@Homer.TheSimpsons.net>
	 <1150029517.17158.38.camel@Homer.TheSimpsons.net>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 17:22:06 +0000
Message-Id: <1150046526.9122.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-11 at 14:38 +0200, Mike Galbraith wrote:

> OK, it's dying on the very first call, with absolutely nothing between
> spin_lock_irq() and BUG_ON(!irqs_disabled()), but the spin_lock_irq()
> has become rt_lock().  Is the BUG_ON() check bogus for the rt kernel?

Yes. The patch below should help.

	tglx

Index: linux-2.6.17-rc6/kernel/posix-cpu-timers.c
===================================================================
--- linux-2.6.17-rc6.orig/kernel/posix-cpu-timers.c	2006-06-10 09:45:45.000000000 +0200
+++ linux-2.6.17-rc6/kernel/posix-cpu-timers.c	2006-06-10 14:47:10.000000000 +0200
@@ -564,7 +564,7 @@
 		p->cpu_timers : p->signal->cpu_timers);
 	head += CPUCLOCK_WHICH(timer->it_clock);
 
-	BUG_ON(!irqs_disabled());
+	BUG_ON_NONRT(!irqs_disabled());
 	spin_lock(&p->sighand->siglock);
 
 	listpos = head;
@@ -721,7 +721,7 @@
 	/*
 	 * Disarm any old timer after extracting its expiry time.
 	 */
-	BUG_ON(!irqs_disabled());
+	BUG_ON_NONRT(!irqs_disabled());
 
 	ret = 0;
 	spin_lock(&p->sighand->siglock);


