Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVHAS5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVHAS5s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVHAS5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:57:48 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:25823 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261163AbVHAS5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:57:47 -0400
Subject: Re: [PATCH] Real-Time Preemption V0.7.52-07: rt_init_MUTEX_LOCKED
	declaration
From: Steven Rostedt <rostedt@goodmis.org>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <42EE4D27.8060500@gmail.com>
References: <42EE4D27.8060500@gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 01 Aug 2005 14:57:38 -0400
Message-Id: <1122922658.6759.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 16:26 +0000, Luca Falavigna wrote:
> This patch fixes broken rt_init_MUTEX_LOCKED declaration using rt_sema_init()
> macro. This way we fix a potential compile bug: rt_init_MUTEX_LOCKED calls
> there_is_no_init_MUTEX_LOCKED_for_RT_semaphores, which is not referenced.
> (e.g. drivers/char/watchdog/cpu5wdt.c: "cpu5wdt: Unknown symbol
> there_is_no_init_MUTEX_LOCKED_for_RT_semaphores")
> 
> 

Ingo,

When did you solve the problem of ownership of locked semaphores? ;-)

Luca,
Unless Ingo did solve the problem of semaphores that can be locked by
one task and unlocked by another task, I wouldn't use your patch.
There's a problem with priority inheritance when it comes to these
semaphores.  That is who owns a locked semaphore that will later be
unlocked by someone else?  When a RT process blocks on this semaphore,
who does it boost to release it?  Ingo purposely put this in to crash
the compile so that we know where this can be a problem right away.

The patch you wanted to send was:

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_ernie/drivers/char/watchdog/cpu5wdt.c
===================================================================
--- linux_realtime_ernie/drivers/char/watchdog/cpu5wdt.c	(revision 265)
+++ linux_realtime_ernie/drivers/char/watchdog/cpu5wdt.c	(working copy)
@@ -56,7 +56,7 @@
 /* some device data */
 
 static struct {
-	struct semaphore stop;
+	struct compat_semaphore stop;
 	volatile int running;
 	struct timer_list timer;
 	volatile int queue;


