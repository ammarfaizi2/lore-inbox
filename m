Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751977AbWCYXsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbWCYXsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 18:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbWCYXsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 18:48:09 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:15259 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751977AbWCYXsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 18:48:08 -0500
Date: Sun, 26 Mar 2006 06:44:53 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH 2.6.16-mm1] __mod_timer: simplify ->base changing
Message-ID: <20060326024453.GA9292@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of
	kill-__init_timer_base-in-favor-of-boot_tvec_bases.patch

Since base and new_base are of the same type now, we can save one
'if' branch and simplify the code a bit.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/kernel/timer.c~	2006-03-25 18:44:18.000000000 +0300
+++ MM/kernel/timer.c	2006-03-25 18:50:07.000000000 +0300
@@ -215,21 +215,19 @@ int __mod_timer(struct timer_list *timer
 		 * handler yet has not finished. This also guarantees that
 		 * the timer is serialized wrt itself.
 		 */
-		if (unlikely(base->running_timer == timer)) {
-			/* The timer remains on a former base */
-			new_base = base;
-		} else {
+		if (likely(base->running_timer != timer)) {
 			/* See the comment in lock_timer_base() */
 			timer->base = NULL;
 			spin_unlock(&base->lock);
-			spin_lock(&new_base->lock);
-			timer->base = new_base;
+			base = new_base;
+			spin_lock(&base->lock);
+			timer->base = base;
 		}
 	}
 
 	timer->expires = expires;
-	internal_add_timer(new_base, timer);
-	spin_unlock_irqrestore(&new_base->lock, flags);
+	internal_add_timer(base, timer);
+	spin_unlock_irqrestore(&base->lock, flags);
 
 	return ret;
 }

