Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbUKVDFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbUKVDFS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 22:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUKVDFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 22:05:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:5797 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261906AbUKVDFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 22:05:06 -0500
Subject: Re: [PATCH] del_timer() vs. mod_timer() SMP race
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041121185439.7fcfe514.akpm@osdl.org>
References: <1101091445.13612.31.camel@gaston>
	 <20041121185439.7fcfe514.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 22 Nov 2004 14:03:58 +1100
Message-Id: <1101092638.13597.34.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-21 at 18:54 -0800, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > --- linux-work.orig/kernel/timer.c	2004-11-22 11:50:59.000000000 +1100
> >  +++ linux-work/kernel/timer.c	2004-11-22 13:35:38.928448032 +1100
> >  @@ -308,6 +308,7 @@
> >   		goto repeat;
> >   	}
> >   	list_del(&timer->entry);
> >  +	smp_wmb();
> 
> Pretty please, always add a comment when putting an open-coded barrier into
> the kernel.  Otherwise people cannot tell why it is there.

Ok, I also added the comment to the "other" smp_wmb() which was already there just in case...

It is mandatory that this timer->base = NULL is visible to other CPUs only after
the list_del() is complete. If not, then mod timer could see it NULL, thus take it's
own CPU list lock and not the one for the CPU the timer was beeing removed from the
list, and thus the list_add in mod_timer() could race with the list_del() from
run_timers() or del_timer().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/kernel/timer.c
===================================================================
--- linux-work.orig/kernel/timer.c	2004-11-22 11:50:59.000000000 +1100
+++ linux-work/kernel/timer.c	2004-11-22 14:01:05.537368200 +1100
@@ -308,6 +308,10 @@
 		goto repeat;
 	}
 	list_del(&timer->entry);
+	smp_wmb(); /* the list del must have taken effect before timer->base
+		    * change is visible to other CPUs, or a concurrent mod_timer
+		    * would cause a race with list_add
+		    */
 	timer->base = NULL;
 	spin_unlock_irqrestore(&base->lock, flags);
 
@@ -460,7 +464,10 @@
 
 			list_del(&timer->entry);
 			set_running_timer(base, timer);
-			smp_wmb();
+			smp_wmb(); /* the list del must have taken effect before timer->base
+				    * change is visible to other CPUs, or a concurrent mod_timer
+				    * would cause a race with list_add
+				    */
 			timer->base = NULL;
 			spin_unlock_irq(&base->lock);
 			fn(data);



