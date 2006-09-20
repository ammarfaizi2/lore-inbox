Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWITTTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWITTTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWITTTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:19:11 -0400
Received: from www.osadl.org ([213.239.205.134]:39627 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932271AbWITTTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:19:10 -0400
Subject: Re: 2.6.18-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com,
       Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1158778040.5724.1020.camel@localhost.localdomain>
References: <20060920141907.GA30765@elte.hu>
	 <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20060920182553.GC1292@us.ibm.com>
	 <200609201436.47042.gene.heskett@verizon.net>
	 <1158778040.5724.1020.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 21:20:21 +0200
Message-Id: <1158780021.5724.1023.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 20:47 +0200, Thomas Gleixner wrote:
> On Wed, 2006-09-20 at 14:36 -0400, Gene Heskett wrote:
> > That looks like the chorus of the song I saw when it crashed on boot, 
> > pretty darned close to identical.
> 
> I can reproduce it. It happens when CONFIG_HIGH_RES_TIMERS is off.
> Looking into it right now.

Fix below.

	tglx

Index: linux-2.6.18/kernel/hrtimer.c
===================================================================
--- linux-2.6.18.orig/kernel/hrtimer.c	2006-09-20 19:10:05.000000000 +0200
+++ linux-2.6.18/kernel/hrtimer.c	2006-09-20 21:11:26.000000000 +0200
@@ -873,9 +873,6 @@ static inline void hrtimer_init_hres(str
 	set_bit(0, &base->check_clocks);
 	base->hres_active = 0;
 	hrtimer_init_base_cb_pending(base);
-#ifdef CONFIG_PREEMPT_SOFTIRQS
-	init_waitqueue_head(&base->wait);
-#endif
 }
 
 static inline int hrtimer_enqueue_reprogram(struct hrtimer *timer,
@@ -1643,6 +1640,9 @@ static void __devinit init_hrtimers_cpu(
 		cpu_base->clock_base[i].cpu_base = cpu_base;
 
 	hrtimer_init_hres(cpu_base);
+#ifdef CONFIG_PREEMPT_SOFTIRQS
+	init_waitqueue_head(&cpu_base->wait);
+#endif
 }
 
 #ifdef CONFIG_HOTPLUG_CPU


