Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTJHTV7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 15:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTJHTV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 15:21:58 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:7917 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S261763AbTJHTVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 15:21:55 -0400
Message-ID: <3F84649C.8070607@terra.com.br>
Date: Wed, 08 Oct 2003 16:25:16 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: axboe@suse.de
Cc: willy@debian.org, linux-kernel@vger.kernel.org,
       Kernel-janitors@lists.osdl.org
Subject: [PATCH] fix SMP support in cdu535 cdrom driver
Content-Type: multipart/mixed;
 boundary="------------050401020109070204060507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050401020109070204060507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Jens,

	Patch against 2.6.0-test6.

	Even though cdu535 is polled, not interrupt driven, Matthew pointed 
out[1] that is a good idea to fix SMP support on that bit, so that 
people who wants to fix cdu31a don't get that wrong.

	Move prepare_to_wait before enable_interrupts, so that if we enter 
the interrupt handler (after enable_interrupts) on a different CPU 
that's executing sony_sleep's poll version, "wait" is already on the 
irq_wait list, which I think fixes the race that Matthew pointed out, 
doesn't it?

	CC'ing kernel-janitors since it also replaces yield for
schedule_timeout[2], as Matthew suggested.

	Please consider applying.

	Thanks,

Felipe

[1]http://marc.theaimsgroup.com/?l=linux-kernel&m=106322465303649&w=2

[2]http://lists.osdl.org/pipermail/kernel-janitors/2003-October/000173.html


--------------050401020109070204060507
Content-Type: text/plain;
 name="sonycd535-yield.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sonycd535-yield.patch"

--- linux-2.6.0-test6/drivers/cdrom/sonycd535.c.orig	2003-10-08 14:42:43.000000000 -0300
+++ linux-2.6.0-test6/drivers/cdrom/sonycd535.c	2003-10-08 16:00:09.000000000 -0300
@@ -342,13 +342,14 @@
 sony_sleep(void)
 {
 	if (sony535_irq_used <= 0) {	/* poll */
-		yield();
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(1);
 	} else {	/* Interrupt driven */
 		DEFINE_WAIT(wait);
-		
+
 		spin_lock_irq(&sonycd535_lock);
-		enable_interrupts();
 		prepare_to_wait(&cdu535_irq_wait, &wait, TASK_INTERRUPTIBLE);
+		enable_interrupts();
 		spin_unlock_irq(&sonycd535_lock);
 		schedule();
 		finish_wait(&cdu535_irq_wait, &wait);


--------------050401020109070204060507--

