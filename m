Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWDVB3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWDVB3b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 21:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWDVB3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 21:29:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42731 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750836AbWDVB3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 21:29:30 -0400
Subject: Re: [PATCH] Shrink rbtree
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060421180915.1f2d61a4.akpm@osdl.org>
References: <1145623663.11909.139.camel@pmac.infradead.org>
	 <20060421180915.1f2d61a4.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 22 Apr 2006 02:29:44 +0100
Message-Id: <1145669384.16166.130.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 18:09 -0700, Andrew Morton wrote:
> #define HRTIMER_INACTIVE        ((void *)1UL) 

Ah. That's newer than the kernel I tested on. Your patch isn't going to
make kernel/hrtimer.c compile though, surely? Let's do it the same way
everyone else marks off-tree nodes -- by setting its parent pointer to
point to itself....

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 306acf1..7d2a1b9 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -127,7 +127,7 @@ #endif
 
 static inline int hrtimer_active(const struct hrtimer *timer)
 {
-	return timer->node.rb_parent != HRTIMER_INACTIVE;
+	return rb_parent(&timer->node) != &timer->node;
 }
 
 /* Forward a hrtimer so it expires after now: */
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index d2a7296..04ab27d 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -393,7 +393,7 @@ static void __remove_hrtimer(struct hrti
 	if (base->first == &timer->node)
 		base->first = rb_next(&timer->node);
 	rb_erase(&timer->node, &base->active);
-	timer->node.rb_parent = HRTIMER_INACTIVE;
+	rb_set_parent(&timer->node, &timer->node);
 }
 
 /*
@@ -578,7 +578,7 @@ void hrtimer_init(struct hrtimer *timer,
 		clock_id = CLOCK_MONOTONIC;
 
 	timer->base = &bases[clock_id];
-	timer->node.rb_parent = HRTIMER_INACTIVE;
+	rb_set_parent(&timer->node, &timer->node);
 }
 
 /**

-- 
dwmw2

