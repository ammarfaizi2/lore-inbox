Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbVKILHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbVKILHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 06:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbVKILHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 06:07:42 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:7859 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030516AbVKILHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 06:07:40 -0500
Message-ID: <4371DAA1.4040300@sw.ru>
Date: Wed, 09 Nov 2005 14:16:49 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] stop_machine() vs. synchronous IPI send deadlock
Content-Type: multipart/mixed;
 boundary="------------010907080405040503000702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010907080405040503000702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Andrew,

This patch fixes deadlock of stop_machine() vs. synchronous IPI send.
The problem is that stop_machine() disables interrupts before disabling 
preemption on other CPUs. So if another CPU is preempted and then calls 
something like flush_tlb_all() it will deadlock with CPU doing 
stop_machine() and which can't process IPI due to disabled IRQs.

I changed stop_machine() to do the same things exactly as it does on 
other CPUs, i.e. it should disable preemption first on _all_ CPUs 
including itself and only after that disable IRQs.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

--------------010907080405040503000702
Content-Type: text/plain;
 name="diff-stopmachine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-stopmachine"

--- ./kernel/stop_machine.c.stpmach	2005-11-01 12:06:03.000000000 +0300
+++ ./kernel/stop_machine.c	2005-11-09 13:58:03.000000000 +0300
@@ -114,13 +114,12 @@ static int stop_machine(void)
 		return ret;
 	}
 
-	/* Don't schedule us away at this point, please. */
-	local_irq_disable();
-
 	/* Now they are all started, make them hold the CPUs, ready. */
+	preempt_disable();
 	stopmachine_set_state(STOPMACHINE_PREPARE);
 
 	/* Make them disable irqs. */
+	local_irq_disable();
 	stopmachine_set_state(STOPMACHINE_DISABLE_IRQ);
 
 	return 0;

--------------010907080405040503000702--

