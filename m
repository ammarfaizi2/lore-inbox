Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVLUR1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVLUR1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 12:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVLUR1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 12:27:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62886 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751140AbVLUR1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 12:27:13 -0500
Date: Wed, 21 Dec 2005 12:26:25 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix race with preempt_enable()
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0512211135550.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a simple

	void foo(void) { preempt_enable(); }

produces the following code on ARM:

foo:
	bic	r3, sp, #8128
	bic	r3, r3, #63
	ldr	r2, [r3, #4]
	ldr	r1, [r3, #0]
	sub	r2, r2, #1
	tst	r1, #4
	str	r2, [r3, #4]
	blne	preempt_schedule
	mov	pc, lr

The problem is that the TIF_NEED_RESCHED flag is loaded _before_ the 
preemption count is stored back, hence any interrupt coming within that 
3 instruction window causing TIF_NEED_RESCHED to be set won't be 
seen and scheduling won't happen as it should.

Nothing currently prevents gcc from performing that reordering.  There 
is already a barrier() before the decrement of the preemption count, but 
another one is needed between this and the TIF_NEED_RESCHED flag test 
for proper code ordering.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index d9a2f52..5769d14 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -48,6 +48,7 @@ do { \
 #define preempt_enable() \
 do { \
 	preempt_enable_no_resched(); \
+	barrier(); \
 	preempt_check_resched(); \
 } while (0)
 
