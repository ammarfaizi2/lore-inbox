Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030578AbVKIRcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030578AbVKIRcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030579AbVKIRcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:32:54 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:44308 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030578AbVKIRcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:32:53 -0500
Message-ID: <437234EB.6090004@sw.ru>
Date: Wed, 09 Nov 2005 20:42:03 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Andrey Savochkin" <saw@sawoct.com>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] stop_machine() vs. synchronous IPI send deadlock
References: <4371DAA1.4040300@sw.ru>
In-Reply-To: <4371DAA1.4040300@sw.ru>
Content-Type: multipart/mixed;
 boundary="------------020508070702040808040807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020508070702040808040807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, hunk with corresponding preempt_enable was lost, sending patch again.

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

--------------020508070702040808040807
Content-Type: text/plain;
 name="diff-ms-stopmachine-ipi-deadlock-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-stopmachine-ipi-deadlock-2"

--- ./kernel/stop_machine.c.stpmach	2005-11-01 12:06:03.000000000 +0300
+++ ./kernel/stop_machine.c	2005-11-09 20:38:23.000000000 +0300
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
@@ -130,6 +129,7 @@ static void restart_machine(void)
 {
 	stopmachine_set_state(STOPMACHINE_EXIT);
 	local_irq_enable();
+	preempt_enable_no_resched();
 }
 
 struct stop_machine_data

--------------020508070702040808040807--

