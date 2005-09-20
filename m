Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbVITUeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbVITUeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 16:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbVITUeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 16:34:37 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:42153 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S965085AbVITUeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 16:34:36 -0400
Subject: Re: 2.6.13-rt14 fails to build (smp)
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1127197575.24044.310.camel@tglx.tec.linutronix.de>
References: <1127178337.5868.15.camel@cmn3.stanford.edu>
	 <1127197575.24044.310.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 13:34:11 -0700
Message-Id: <1127248451.4623.4.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 08:26 +0200, Thomas Gleixner wrote:
> On Mon, 2005-09-19 at 18:05 -0700, Fernando Lopez-Lezcano wrote:
> > Hi Ingo, just hit this problem trying to build rt14, this is on the SMP
> > build, with 
> > # CONFIG_HIGH_RES_TIMERS is not set
> > Find the .config I used attached...
> > 
> > kernel/ktimers.c: In function 'migrate_ktimer_list':
> 
> Uuurg. HOTPLUG_CPU
> 
> tglx
> 
> Index: linux-2.6.13-rt12/kernel/ktimers.c
> ===================================================================
> --- linux-2.6.13-rt12.orig/kernel/ktimers.c
> +++ linux-2.6.13-rt12/kernel/ktimers.c
> @@ -865,11 +865,11 @@ static void migrate_ktimer_list(struct k
>  	struct ktimer *timer;
>  	struct rb_node *node;
>  
> -	while ((node = rb_first(&old_base->root))) {
> -		timer = rb_entry(node, struct ktimer, tnode);
> +	while ((node = rb_first(&old_base->active))) {
> +		timer = rb_entry(node, struct ktimer, node);
>  		remove_ktimer(timer, old_base);
>  		timer->base = new_base;
> -		enqueue_ktimer(timer, new_base, NULL);
> +		enqueue_ktimer(timer, new_base, NULL, KTIMER_RESTART);
>  	}
>  }

Compiles with the patch, thanks!
But depmod complains:

WARNING: /lib/modules/2.6.13-0.3.rdt.rhfc4.ccrmasmp/kernel/drivers/char/hangcheck-timer.ko needs unknown symbol monotonic_clock

-- Fernando


