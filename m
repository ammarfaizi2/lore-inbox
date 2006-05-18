Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWERM6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWERM6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 08:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWERM6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 08:58:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:38305 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751320AbWERM6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 08:58:10 -0400
X-Authenticated: #14349625
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, tim.c.chen@linux.intel.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1147935878.7481.20.camel@homer>
References: <4t16i2$142pji@orsmga001.jf.intel.com>
	 <200605181138.26399.kernel@kolivas.org> <1147931064.7514.39.camel@homer>
	 <200605181552.19868.kernel@kolivas.org>  <1147935878.7481.20.camel@homer>
Content-Type: text/plain
Date: Thu, 18 May 2006 14:59:03 +0200
Message-Id: <1147957143.7632.8.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-18 at 09:04 +0200, Mike Galbraith wrote:

> OK, after some brief testing, I think this is a step in the right
> direct, but there is another problem.  In the case where the queue isn't
> empty, the stated intent is utterly defeated by the on runqueue bonus.

The overly verbose one liner below could serve as a minimal ~fix.

Prevent the on-runqueue bonus logic from defeating the idle sleep logic.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.17-rc4-mm1/kernel/sched.c.org	2006-05-18 08:38:13.000000000 +0200
+++ linux-2.6.17-rc4-mm1/kernel/sched.c	2006-05-18 14:47:09.000000000 +0200
@@ -917,6 +917,16 @@ static int recalc_task_prio(task_t *p, u
 			 * with one single large enough sleep.
 			 */
 			p->sleep_avg = ceiling;
+			/*
+			 * Using INTERACTIVE_SLEEP() as a ceiling places a
+			 * nice(0) task 1ms sleep away from promotion, and
+			 * gives it 700ms to round-robin with no chance of
+			 * being demoted.  This is more than generous, so
+			 * mark this sleep as non-interactive to prevent the
+			 * on-runqueue bonus logic from intervening should
+			 * this task not receive cpu immediately.
+			 */
+			p->sleep_type = SLEEP_NONINTERACTIVE;
 		} else {
 			/*
 			 * Tasks waking from uninterruptible sleep are


