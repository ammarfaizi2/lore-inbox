Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVBWVvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVBWVvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVBWVu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:50:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63951 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261613AbVBWVsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:48:33 -0500
Date: Wed, 23 Feb 2005 13:48:20 -0800
Message-Id: <200502232148.j1NLmKAV030044@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Alexander Nyberg <alexn@dsv.su.se>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH] fix posix-timer initialization
In-Reply-To: Alexander Nyberg's message of  Sunday, 20 February 2005 22:53:01 +0100 <1108936381.2272.20.camel@boxen>
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem arises from code touching the union in alloc_posix_timer()
> which makes firing go non-zero. When firing is checked in
> posix_cpu_timer_set() it will be positive causing an infinite loop.
> 
> So either the below fix or preferably move the INIT_LIST_HEAD(x) from
> alloc_posix_timer() to somewhere later where it doesn't disturb the other
> union members.

Thanks for finding this problem.  The latter is what I think is the right
solution.  This patch does that, and also removes some superfluous rezeroing.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/posix-timers.c
+++ linux-2.6/kernel/posix-timers.c
@@ -221,9 +221,8 @@ static inline int common_clock_set(clock
 
 static inline int common_timer_create(struct k_itimer *new_timer)
 {
-	new_timer->it.real.incr = 0;
+	INIT_LIST_HEAD(&new_timer->it.real.abs_timer_entry);
 	init_timer(&new_timer->it.real.timer);
-	new_timer->it.real.timer.expires = 0;
 	new_timer->it.real.timer.data = (unsigned long) new_timer;
 	new_timer->it.real.timer.function = posix_timer_fn;
 	set_timer_inactive(new_timer);
@@ -564,7 +563,6 @@ static struct k_itimer * alloc_posix_tim
 	if (!tmr)
 		return tmr;
 	memset(tmr, 0, sizeof (struct k_itimer));
-	INIT_LIST_HEAD(&tmr->it.real.abs_timer_entry);
 	if (unlikely(!(tmr->sigq = sigqueue_alloc()))) {
 		kmem_cache_free(posix_timers_cache, tmr);
 		tmr = NULL;

