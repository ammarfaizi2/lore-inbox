Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTJRXBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 19:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTJRXBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 19:01:25 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:43221 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261931AbTJRXBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 19:01:23 -0400
Message-ID: <3F91C645.6060906@colorfullife.com>
Date: Sun, 19 Oct 2003 01:01:25 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: migh_sleep during early boot
Content-Type: multipart/mixed;
 boundary="------------020909030602030300050207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020909030602030300050207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

With might_sleep reports several calls from invalid contexts during 
early boot:

First some calls due to irq off, preempt off: This are the first stages 
of start_kernel, irqs are not yet enabled.
Then calls with only preemption off: The kernel runs on the future idle 
thread, and these threads have preempt_count==1.

Attached is a patch that fixes the latter bug: ignore the preemption 
counter for the idle threads. I haven't figured out how to identify the 
calls before the first local_irq_enable().

--
    Manfred



--------------020909030602030300050207
Content-Type: text/plain;
 name="patch-might_sleep_2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-might_sleep_2"

--- 2.6/kernel/sched.c	2003-10-18 21:17:11.000000000 +0200
+++ build-2.6/kernel/sched.c	2003-10-19 00:49:03.000000000 +0200
@@ -2848,7 +2848,7 @@
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
-	if (in_atomic() || irqs_disabled()) {
+	if ((in_atomic() && current->pid) || irqs_disabled()) {
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;
 		prev_jiffy = jiffies;

--------------020909030602030300050207--

