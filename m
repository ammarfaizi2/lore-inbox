Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWELJWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWELJWP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 05:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWELJWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 05:22:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54472 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751099AbWELJWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 05:22:14 -0400
Date: Fri, 12 May 2006 11:21:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Hounschell <markh@compro.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt20 patch question
Message-ID: <20060512092159.GC18145@elte.hu>
References: <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com> <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > one solution would be to forbid disable_irq() from softirq contexts, and
> > to convert the vortex timeout function to a workqueue and use the
> > *_delayed_work() APIs to drive it - and cross fingers there's not many
> > places to fix.
> 
> I prefer the above. Maybe even add a WARN_ON(in_softirq()) in 
> disable_irq.
> 
> But I must admit, I wouldn't know how to make that change without 
> spending more time on it then I have for this.

the simplest fix for now would be to use the _nosync variant in the 
vortex timeout function.

Mark, does this fix the problem?

	Ingo

Index: linux-rt.q/drivers/net/3c59x.c
===================================================================
--- linux-rt.q.orig/drivers/net/3c59x.c
+++ linux-rt.q/drivers/net/3c59x.c
@@ -1897,7 +1897,8 @@ vortex_timer(unsigned long data)
 
 	if (vp->medialock)
 		goto leave_media_alone;
-	disable_irq(dev->irq);
+	/* hack! */
+	disable_irq_nosync(dev->irq);
 	old_window = ioread16(ioaddr + EL3_CMD) >> 13;
 	EL3WINDOW(4);
 	media_status = ioread16(ioaddr + Wn4_Media);
