Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVAMGmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVAMGmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 01:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVAMGmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 01:42:13 -0500
Received: from waste.org ([216.27.176.166]:31363 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261166AbVAMGlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 01:41:45 -0500
Date: Wed, 12 Jan 2005 22:41:40 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Y. Ts'o" <tytso@MIT.EDU>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] random entropy debugging improvements
Message-ID: <20050113064140.GX2940@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Print pool entropy counts in all entropy debugging messages

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-11 09:40:22.000000000 -0800
+++ rnd/drivers/char/random.c	2005-01-11 10:21:31.323801128 -0800
@@ -473,7 +473,12 @@
 #endif
 
 #if 0
-#define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random: " fmt, ## arg)
+#define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random %04d %04d %04d: " \
+	fmt,\
+	random_state->entropy_count,\
+	sec_random_state->entropy_count,\
+	urandom_state->entropy_count,\
+	## arg)
 #else
 #define DEBUG_ENT(fmt, arg...) do {} while (0)
 #endif
@@ -648,8 +653,8 @@
 	} else {
 		r->entropy_count += nbits;
 		if (nbits)
-			DEBUG_ENT("Added %d entropy credits to %s, now %d\n",
-				  nbits, r->name, r->entropy_count);
+			DEBUG_ENT("added %d entropy credits to %s\n",
+				  nbits, r->name);
 	}
 
 	spin_unlock_irqrestore(&r->lock, flags);
@@ -862,6 +867,7 @@
 {
 	static unsigned char last_scancode;
 	/* ignore autorepeat (multiple key down w/o key up) */
+	DEBUG_ENT("keyboard event\n");
 	if (scancode != last_scancode) {
 		last_scancode = scancode;
 		add_timer_randomness(&keyboard_timer_state, scancode);
@@ -870,6 +876,7 @@
 
 void add_mouse_randomness(__u32 mouse_data)
 {
+	DEBUG_ENT("mouse event\n");
 	add_timer_randomness(&mouse_timer_state, mouse_data);
 }
 
@@ -880,6 +887,7 @@
 	if (irq >= NR_IRQS || irq_timer_state[irq] == 0)
 		return;
 
+	DEBUG_ENT("irq event %d\n", irq);
 	add_timer_randomness(irq_timer_state[irq], 0x100 + irq);
 }
 
@@ -888,6 +896,8 @@
 	if (!disk || !disk->random)
 		return;
 	/* first major is 1, so we get >= 0x200 here */
+	DEBUG_ENT("disk event %d:%d\n", disk->major, disk->first_minor);
+
 	add_timer_randomness(disk->random,
 			     0x100 + MKDEV(disk->major, disk->first_minor));
 }
@@ -1308,10 +1318,8 @@
 		int bytes = max_t(int, random_read_wakeup_thresh / 8,
 				min_t(int, nbytes, TMP_BUF_SIZE));
 
-		DEBUG_ENT("%04d %04d : going to reseed %s with %d bits "
+		DEBUG_ENT("going to reseed %s with %d bits "
 			  "(%d of %d requested)\n",
-			  random_state->entropy_count,
-			  sec_random_state->entropy_count,
 			  r->name, bytes * 8, nbytes * 8, r->entropy_count);
 
 		bytes=extract_entropy(random_state, tmp, bytes,
@@ -1352,9 +1360,7 @@
 	/* Hold lock while accounting */
 	spin_lock_irqsave(&r->lock, cpuflags);
 
-	DEBUG_ENT("%04d %04d : trying to extract %d bits from %s\n",
-		  random_state->entropy_count,
-		  sec_random_state->entropy_count,
+	DEBUG_ENT("trying to extract %d bits from %s\n",
 		  nbytes * 8, r->name);
 
 	if (flags & EXTRACT_ENTROPY_LIMIT && nbytes >= r->entropy_count / 8)
@@ -1368,7 +1374,7 @@
 	if (r->entropy_count < random_write_wakeup_thresh)
 		wake_up_interruptible(&random_write_wait);
 
-	DEBUG_ENT("Debiting %d entropy credits from %s%s\n",
+	DEBUG_ENT("debiting %d entropy credits from %s%s\n",
 		  nbytes * 8, r->name,
 		  flags & EXTRACT_ENTROPY_LIMIT ? "" : " (unlimited)");
 
@@ -1386,15 +1392,7 @@
 				break;
 			}
 
-			DEBUG_ENT("%04d %04d : extract feeling sleepy (%d bytes left)\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count, nbytes);
-
 			schedule();
-
-			DEBUG_ENT("%04d %04d : extract woke up\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count);
 		}
 
 		/* Hash the pool to get the output */
@@ -1603,20 +1601,14 @@
 		if (n > SEC_XFER_SIZE)
 			n = SEC_XFER_SIZE;
 
-		DEBUG_ENT("%04d %04d : reading %d bits, p: %d s: %d\n",
-			  random_state->entropy_count,
-			  sec_random_state->entropy_count,
-			  n*8, random_state->entropy_count,
-			  sec_random_state->entropy_count);
+		DEBUG_ENT("reading %d bits\n", n*8);
 
 		n = extract_entropy(sec_random_state, buf, n,
 				    EXTRACT_ENTROPY_USER |
 				    EXTRACT_ENTROPY_LIMIT |
 				    EXTRACT_ENTROPY_SECONDARY);
 
-		DEBUG_ENT("%04d %04d : read got %d bits (%d still needed)\n",
-			  random_state->entropy_count,
-			  sec_random_state->entropy_count,
+		DEBUG_ENT("read got %d bits (%d still needed)\n",
 			  n*8, (nbytes-n)*8);
 
 		if (n == 0) {
@@ -1629,10 +1621,6 @@
 				break;
 			}
 
-			DEBUG_ENT("%04d %04d : sleeping?\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count);
-
 			set_current_state(TASK_INTERRUPTIBLE);
 			add_wait_queue(&random_read_wait, &wait);
 
@@ -1642,10 +1630,6 @@
 			set_current_state(TASK_RUNNING);
 			remove_wait_queue(&random_read_wait, &wait);
 
-			DEBUG_ENT("%04d %04d : waking up\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count);
-
 			continue;
 		}
 

-- 
Mathematics is the supreme nostalgia of our time.
