Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVI2Gwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVI2Gwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 02:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVI2Gwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 02:52:33 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:55490
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932102AbVI2Gwc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 02:52:32 -0400
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru, zippel@linux-m68k.org, tim.bird@am.sony.com
In-Reply-To: <1127956200.8195.260.camel@cog.beaverton.ibm.com>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
	 <1127956200.8195.260.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 29 Sep 2005 08:53:23 +0200
Message-Id: <1127976803.15115.281.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 18:10 -0700, john stultz wrote:

> > +	/* Auto rearm the timer ? */
> > +	if (rearm && ktime_cmp_val(timer->interval, !=, KTIME_ZERO))
> > +		enqueue_ktimer(timer, base, NULL, KTIMER_REARM);
> > +}
> 
> 
> There's a couple of places like this where you pass NULL as the ktime_t
> pointer tim to enqueue_ktimer(). However in enqueue_ktimer, you
> dereference tim in a few spots w/o checking for NULL.
> 

The KTIMER_REARM case is the broken spot. I fixed this already as it was
oopsing here to, but somehow I messed up with quilt.

tglx

Index: linux-2.6.14-rc2-rt4/kernel/ktimers.c
===================================================================
--- linux-2.6.14-rc2-rt4.orig/kernel/ktimers.c
+++ linux-2.6.14-rc2-rt4/kernel/ktimers.c
@@ -242,7 +242,7 @@ static int enqueue_ktimer(struct ktimer 
 		goto nocheck;
 	case KTIMER_REARM:
 		while ktime_cmp(timer->expires, <= , now) {
-			timer->expires = ktime_add(timer->expires, *tim);
+			timer->expires = ktime_add(timer->expires, timer->interval);
 			timer->overrun++;
 		}
 		goto nocheck;


