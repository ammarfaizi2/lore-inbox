Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272132AbTG2VNq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272129AbTG2VK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:10:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:35202 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272167AbTG2VIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:08:18 -0400
Date: Tue, 29 Jul 2003 13:56:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: linas@austin.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-Id: <20030729135643.2e9b74bc.akpm@osdl.org>
In-Reply-To: <20030729104135.A48598@forte.austin.ibm.com>
References: <20030729104135.A48598@forte.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linas@austin.ibm.com wrote:
>
> I have been chasing a pointer corruption bug in the timer code, and
> found the following race in the mod_timer() routine.  I am still 
> testing to see if this fixes my bug ... 

Andrea says that we need to take the per-timer lock in add_timer() and
del_timer(), but I haven't yet got around to working out why.

Does this (untested) patch fix whatever race it is which you are observing?


 25-akpm/kernel/timer.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff -puN kernel/timer.c~timer-locking-fixes kernel/timer.c
--- 25/kernel/timer.c~timer-locking-fixes	Tue Jul 29 13:52:21 2003
+++ 25-akpm/kernel/timer.c	Tue Jul 29 13:54:55 2003
@@ -167,10 +167,12 @@ void add_timer(struct timer_list *timer)
 
 	check_timer(timer);
 
-	spin_lock_irqsave(&base->lock, flags);
+	spin_lock_irqsave(&timer->lock, flags);
+	spin_lock(&base->lock);
 	internal_add_timer(base, timer);
 	timer->base = base;
-	spin_unlock_irqrestore(&base->lock, flags);
+	spin_unlock(&base->lock);
+	spin_unlock_irqrestore(&timer->lock, flags);
 	put_cpu();
 }
 
@@ -190,10 +192,12 @@ void add_timer_on(struct timer_list *tim
 
 	check_timer(timer);
 
-	spin_lock_irqsave(&base->lock, flags);
+	spin_lock_irqsave(&timer->lock, flags);
+	spin_lock(&base->lock);
 	internal_add_timer(base, timer);
 	timer->base = base;
-	spin_unlock_irqrestore(&base->lock, flags);
+	spin_unlock(&base->lock);
+	spin_unlock_irqrestore(&timer->lock, flags);
 }
 
 /***
@@ -298,19 +302,22 @@ int del_timer(struct timer_list *timer)
 	tvec_base_t *base;
 
 	check_timer(timer);
-
+	spin_lock_irqsave(&timer->lock, flags);
 repeat:
  	base = timer->base;
-	if (!base)
+	if (!base) {
+		spin_unlock_irqrestore(&timer->lock, flags);
 		return 0;
-	spin_lock_irqsave(&base->lock, flags);
+	}
+	spin_lock(&base, flags);
 	if (base != timer->base) {
-		spin_unlock_irqrestore(&base->lock, flags);
+		spin_unlock(&base->lock);
 		goto repeat;
 	}
 	list_del(&timer->entry);
 	timer->base = NULL;
-	spin_unlock_irqrestore(&base->lock, flags);
+	spin_unlock(&base->lock);
+	spin_unlock_irqrestore(&timer->lock, flags);
 
 	return 1;
 }

_

