Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265397AbTIFJ63 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 05:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265443AbTIFJ63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 05:58:29 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:4494 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S265397AbTIFJ61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 05:58:27 -0400
Date: Sat, 6 Sep 2003 10:58:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] idle using PNI monitor/mwait (take 2)
Message-ID: <20030906095812.GA9796@mail.jlokier.co.uk>
References: <7F740D512C7C1046AB53446D3720017304A72D@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D3720017304A72D@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:
> > The result is a halted CPU even though need_resched is set, and the
> > idle loop isn't broken until the next interrupt, often a timer tick.
> 
> I'm aware of the window, but did not realize that it could cause high
> latency spikes. Is that still the case with 2.6 where we have higher HZ
> (1000)? Anyway, I think it's a cheap way of removing such spikes.

HZ is irrelevant.  If you receive an interrupt, and typical wakeup
latency is 0.05ms, then waiting until the next timer tick in 1ms is a spike.
Some applications tolerate that, some don't.

> > So you can remove it from your loop.
> Okay we'll remove local_irq_enable() at entry. So in that case we can
> remove the local_irq_enable() below as well?
> 
> static void poll_idle (void)
> {
> 	int oldval;
> 
> =>	local_irq_enable();

I misunderstood you and now you misunderstood me :)

It's ok to _disable_ irqs for the reasons I gave.  I thought of that
because you pointed to the _disable_ in your quote of default_idle.

The _enable_ is there for a different reason.

Scheduling is not allowed with interrupts disabled.  So we know that
when schedule() returns, local irqs are enabled.  So poll_idle() doesn't
need to enable them.  I suggest this change:

        - remove the local_irq_enable() from poll_idle().

        - add local_irq_enable() at the start of cpu_idle(), before the loop.

-- Jamie

diff -urN --exclude-from=dontdiff orig-2.6.0-test4/arch/i386/kernel/process.c idle_irqs-2.6.0-test4/arch/i386/kernel/process.c
--- orig-2.6.0-test4/arch/i386/kernel/process.c	2003-09-02 23:05:06.000000000 +0100
+++ idle_irqs-2.6.0-test4/arch/i386/kernel/process.c	2003-09-06 10:50:59.000000000 +0100
@@ -105,8 +105,6 @@
 {
 	int oldval;
 
-	local_irq_enable();
-
 	/*
 	 * Deal with another CPU just having chosen a thread to
 	 * run here:
@@ -136,6 +134,8 @@
  */
 void cpu_idle (void)
 {
+	local_irq_enable();
+
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
