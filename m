Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWBRO2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWBRO2u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 09:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWBRO2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 09:28:50 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:63946 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1751170AbWBRO2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 09:28:49 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix race condition in hvc console.
Message-Id: <E1FAT5z-0004nt-V8@heater.watson.ibm.com>
From: Michal Ostrowski <mostrows@watson.ibm.com>
Date: Sat, 18 Feb 2006 09:29:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tty_schedule_flip() would schedule a thread that would call flush_to_ldisc().
If tty_buffer_request_room() gets called prior to that thread running --
which is likely in this loop in hvc_poll(), it would set the active flag
in the tty buffer and consequently flush_to_ldisc() would ignore it.

The result is that input on the hvc console is not processed.

This fix calls tty_flip_buffer_push (and flags the tty as
"low_latency").  The push to the ldisc thus happens synchronously.

Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 drivers/char/hvc_console.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

1d719e2972f0c02d62a428aa84ca60793ad79666
diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index 1994a92..67f368f 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -335,6 +335,8 @@ static int hvc_open(struct tty_struct *t
 	} /* else count == 0 */
 
 	tty->driver_data = hp;
+	tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
+
 	hp->tty = tty;
 	/* Save for request_irq outside of spin_lock. */
 	irq = hp->irq;
@@ -633,9 +635,6 @@ static int hvc_poll(struct hvc_struct *h
 			tty_insert_flip_char(tty, buf[i], 0);
 		}
 
-		if (count)
-			tty_schedule_flip(tty);
-
 		/*
 		 * Account for the total amount read in one loop, and if above
 		 * 64 bytes, we do a quick schedule loop to let the tty grok
@@ -656,6 +655,10 @@ static int hvc_poll(struct hvc_struct *h
  bail:
 	spin_unlock_irqrestore(&hp->lock, flags);
 
+	if (read_total) {
+		tty_flip_buffer_push(tty);
+	}
+	
 	return poll_mask;
 }
 
-- 
1.1.4.g0b63-dirty

