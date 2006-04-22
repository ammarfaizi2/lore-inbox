Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWDVBKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWDVBKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 21:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWDVBKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 21:10:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750827AbWDVBKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 21:10:24 -0400
Date: Fri, 21 Apr 2006 18:09:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrink rbtree
Message-Id: <20060421180915.1f2d61a4.akpm@osdl.org>
In-Reply-To: <1145623663.11909.139.camel@pmac.infradead.org>
References: <1145623663.11909.139.camel@pmac.infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> git://git.infradead.org/~dwmw2/rbtree-2.6

include/linux/hrtimer.h: In function `hrtimer_active':
include/linux/hrtimer.h:130: structure has no member named `rb_parent'

Might I cast aspersions upon the quality of your testing?



#define HRTIMER_INACTIVE	((void *)1UL)

...

static inline int hrtimer_active(const struct hrtimer *timer)
{
	return rb_parent(timer->node) != HRTIMER_INACTIVE;
}


So we have somewhat-competing hackery here.

Testing this...

--- devel/include/linux/hrtimer.h~git-rbtree-hrtimer-fix	2006-04-21 18:03:44.000000000 -0700
+++ devel-akpm/include/linux/hrtimer.h	2006-04-21 18:08:02.000000000 -0700
@@ -34,7 +34,7 @@ enum hrtimer_restart {
 	HRTIMER_RESTART,
 };
 
-#define HRTIMER_INACTIVE	((void *)1UL)
+#define HRTIMER_INACTIVE	((void *)-2)
 
 struct hrtimer_base;
 
@@ -127,7 +127,7 @@ extern ktime_t hrtimer_get_next_event(vo
 
 static inline int hrtimer_active(const struct hrtimer *timer)
 {
-	return timer->node.rb_parent != HRTIMER_INACTIVE;
+	return rb_parent(&timer->node) != HRTIMER_INACTIVE;
 }
 
 /* Forward a hrtimer so it expires after now: */
_

