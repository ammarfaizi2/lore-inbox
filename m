Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWC1KQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWC1KQc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 05:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWC1KQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 05:16:32 -0500
Received: from www.osadl.org ([213.239.205.134]:12699 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932082AbWC1KQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 05:16:31 -0500
Subject: [patch-mm2] PI-futex: fix timeout race
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060326231638.GA18395@elte.hu>
References: <20060325184612.GF16724@elte.hu>
	 <20060325220728.3d5c8d36.akpm@osdl.org> <20060326160353.GA13282@elte.hu>
	 <20060326231638.GA18395@elte.hu>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 12:17:28 +0200
Message-Id: <1143541048.5344.182.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The futex code has consequently the same timeout race as generic sleeper
based nanosleep. Call hrtimer_cancel() unconditionally.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.16-mm2/kernel/rtmutex.c
===================================================================
--- linux-2.6.16-mm2.orig/kernel/rtmutex.c
+++ linux-2.6.16-mm2/kernel/rtmutex.c
@@ -789,7 +789,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 	spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	/* Remove pending timer: */
-	if (unlikely(timeout && timeout->task))
+	if (unlikely(timeout))
 		hrtimer_cancel(&timeout->timer);
 
 	/*


