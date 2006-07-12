Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWGLNg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWGLNg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 09:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWGLNg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 09:36:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27606 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751364AbWGLNg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 09:36:27 -0400
Subject: PATCH: Minimal fix for sysrq on serial console hang
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jul 2006 14:54:21 +0100
Message-Id: <1152712461.22943.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I originally did this change I used oops_in_progress as a locking
guide. However it turns out there is one other place that turns all the
locking on its head and that is sysrq.

The fix below is a minimal fix to avoid this hanging and worst case may
lead to the very rare stuck character as it did pre 2.6.16 anyway but
only when using sysrq [which right now hangs the box]

The right fix is probably to unlock on the sysrq path and relock and
reconfigure the uart but thats more complex and not low risk at this
point in time although I will revisit it after (or during KS/OLS)
depending on rmk's view.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc1/drivers/serial/8250.c linux-2.6.18-rc1/drivers/serial/8250.c
--- linux.vanilla-2.6.18-rc1/drivers/serial/8250.c	2006-07-12 12:16:47.000000000 +0100
+++ linux-2.6.18-rc1/drivers/serial/8250.c	2006-07-12 12:21:10.000000000 +0100
@@ -2240,10 +2240,12 @@
 
 	touch_nmi_watchdog();
 
-	if (oops_in_progress) {
-		locked = spin_trylock_irqsave(&up->port.lock, flags);
-	} else
-		spin_lock_irqsave(&up->port.lock, flags);
+	/*
+	 *	This can occur during an oops, in which case we want to
+	 *	do our best, or sysrq which is hairier and eventually needs
+	 *	a nicer solution
+	 */
+	locked = spin_trylock_irqsave(&up->port.lock, flags);
 
 	/*
 	 *	First save the IER then disable the interrupts

