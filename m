Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756767AbWKUWXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767AbWKUWXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756774AbWKUWXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:23:00 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756767AbWKUWW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:22:59 -0500
Date: Tue, 21 Nov 2006 14:18:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
cc: Adrian Bunk <bunk@stusta.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Pavel Emelianov <xemul@openvz.org>, mingo@redhat.com, dev@sw.ru
Subject: Re: 2.6.19-rc6: known regressions (v4)
In-Reply-To: <20061121213335.GB30010@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0611211410460.3338@woody.osdl.org>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
 <20061121212424.GQ5200@stusta.de> <20061121213335.GB30010@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Nov 2006, Vivek Goyal wrote:

> On Tue, Nov 21, 2006 at 10:24:24PM +0100, Adrian Bunk wrote:
> > This email lists some known regressions in 2.6.19-rc6 compared to 2.6.18
> > that are not yet fixed in Linus' tree.
> > 
> > If you find your name in the Cc header, you are either submitter of one
> > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > of you caused a breakage or I'm considering you in any other way possibly
> > involved with one or more of these issues.
> > 
> > Due to the huge amount of recipients, please trim the Cc when answering.
> > 
> > 
> > Subject    : kernel hangs when booting with irqpoll
> > References : http://lkml.org/lkml/2006/11/20/233
> > Submitter  : Vivek Goyal <vgoyal@in.ibm.com>
> > Caused-By  : Pavel Emelianov <xemul@openvz.org>
> >              commit f72fa707604c015a6625e80f269506032d5430dc
> > Handled-By : Vivek Goyal <vgoyal@in.ibm.com>
> > Status     : problem is being debugged
> > 
> 
> Adrian,
> 
> Pavel already provided a fix for this issue.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116409933100117&w=2

I really think this is wrong.

The original patch was wrong, and the _real_ problem is in __do_IRQ() that 
got the desc->lock too early.

I _think_ the correct fix is to simply revert the broken commit, and fix 
the _one_ place that called "misnote_interrupt()" with the lock held.

Something like this..

I also think that the real fix will be to move the whole

	if (!noirqdebug)
		note_interrupt(irq, desc, action_ret);


into handle_IRQ_event itself, since every caller (except for 
"misrouted_irq()" itself, and that should probably be done separately) 
should always do it. Right now we have a lot of people that just do

	action_ret = handle_IRQ_event(irq, action);
	if (!noirqdebug)
		note_interrupt(irq, desc, action_ret);

explicitly.

The only thing that keeps us from doing that is that we don't pass in 
"desc", but we should just do that.

But in the meantime, this appears to be the minimal fix. Can people please 
test and verify?

		Linus

---
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 42aa6f1..a681912 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -231,10 +231,10 @@ fastcall unsigned int __do_IRQ(unsigned
 		spin_unlock(&desc->lock);
 
 		action_ret = handle_IRQ_event(irq, action);
-
-		spin_lock(&desc->lock);
 		if (!noirqdebug)
 			note_interrupt(irq, desc, action_ret);
+
+		spin_lock(&desc->lock);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 9c7e2e4..543ea2e 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -147,11 +147,7 @@ void note_interrupt(unsigned int irq, st
 	if (unlikely(irqfixup)) {
 		/* Don't punish working computers */
 		if ((irqfixup == 2 && irq == 0) || action_ret == IRQ_NONE) {
-			int ok;
-
-			spin_unlock(&desc->lock);
-			ok = misrouted_irq(irq);
-			spin_lock(&desc->lock);
+			int ok = misrouted_irq(irq);
 			if (action_ret == IRQ_NONE)
 				desc->irqs_unhandled -= ok;
 		}
