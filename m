Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270619AbTGNMhr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270584AbTGNMhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:37:25 -0400
Received: from maild.telia.com ([194.22.190.101]:49888 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S270600AbTGNMZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:25:02 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Software suspend and RTL 8139too in 2.6.0-test1
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jul 2003 14:37:47 +0200
Message-ID: <m2wuelqo6c.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch is needed to make software suspend work with the 8139too
driver loaded.

--- linux/drivers/net/8139too.c.old	Mon Jul 14 14:28:27 2003
+++ linux/drivers/net/8139too.c	Mon Jul 14 13:23:07 2003
@@ -110,6 +110,7 @@
 #include <linux/mii.h>
 #include <linux/completion.h>
 #include <linux/crc32.h>
+#include <linux/suspend.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -1597,6 +1598,9 @@
 		timeout = next_tick;
 		do {
 			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
+			/* make swsusp happy with our thread */
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_IOTHREAD);
 		} while (!signal_pending (current) && (timeout > 0));
 
 		if (signal_pending (current)) {

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
