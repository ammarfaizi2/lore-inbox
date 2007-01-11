Return-Path: <linux-kernel-owner+w=401wt.eu-S932257AbXAKXjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbXAKXjH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 18:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932823AbXAKXjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 18:39:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:3294 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932817AbXAKXjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 18:39:05 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,175,1167638400"; 
   d="scan'208"; a="35382442:sNHT25250634"
Date: Thu, 11 Jan 2007 15:34:53 -0800
From: Mark Gross <mgross@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mgross@linux.intel.com
Subject: [PATCH] tlclk: bug fix + misc fixes 
Message-ID: <20070111233453.GA25923@linux.intel.com>
Reply-To: mgross@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes a few problems with the tlclk driver.
* bug in the select_amcb1_transmit_clock 
* racy read sys call
* racy open sys call
* use of add_timer where mod_timer would be better
* change to the timer data parameter use

Signed-off-by: Mark Gross <mark.gross@intel.com>

thanks,

--mgross

diff -urN -X linux-2.6.20-rc2-mm1/Documentation/dontdiff linux-2.6.20-rc2-mm1/drivers/char/tlclk.c linux-2.6.20-rc2-mm1-tlclk/drivers/char/tlclk.c
--- linux-2.6.20-rc2-mm1/drivers/char/tlclk.c	2007-01-03 08:46:18.000000000 -0800
+++ linux-2.6.20-rc2-mm1-tlclk/drivers/char/tlclk.c	2007-01-11 13:37:30.000000000 -0800
@@ -186,6 +186,7 @@
 static void switchover_timeout(unsigned long data);
 static struct timer_list switchover_timer =
 	TIMER_INITIALIZER(switchover_timeout , 0, 0);
+static unsigned long tlclk_timer_data;
 
 static struct tlclk_alarms *alarm_events;
 
@@ -197,10 +198,19 @@
 
 static DECLARE_WAIT_QUEUE_HEAD(wq);
 
+static unsigned long useflags;
+static DEFINE_MUTEX(tlclk_mutex);
+
 static int tlclk_open(struct inode *inode, struct file *filp)
 {
 	int result;
 
+	if (test_and_set_bit(0, &useflags))
+		return -EBUSY;
+		/* this legacy device is always one per system and it doesn't
+		 * know how to handle multiple concurrent clients.
+		 */
+
 	/* Make sure there is no interrupt pending while
 	 * initialising interrupt handler */
 	inb(TLCLK_REG6);
@@ -221,6 +231,7 @@
 static int tlclk_release(struct inode *inode, struct file *filp)
 {
 	free_irq(telclk_interrupt, tlclk_interrupt);
+	useflags &= ~0x1;
 
 	return 0;
 }
@@ -230,26 +241,25 @@
 {
 	if (count < sizeof(struct tlclk_alarms))
 		return -EIO;
+	if (mutex_lock_interruptible(&tlclk_mutex))
+		return -EINTR;
+
 
 	wait_event_interruptible(wq, got_event);
-	if (copy_to_user(buf, alarm_events, sizeof(struct tlclk_alarms)))
+	if (copy_to_user(buf, alarm_events, sizeof(struct tlclk_alarms))) {
+		mutex_unlock(&tlclk_mutex);
 		return -EFAULT;
+	}
 
 	memset(alarm_events, 0, sizeof(struct tlclk_alarms));
 	got_event = 0;
 
+	mutex_unlock(&tlclk_mutex);
 	return  sizeof(struct tlclk_alarms);
 }
 
-static ssize_t tlclk_write(struct file *filp, const char __user *buf, size_t count,
-	    loff_t *f_pos)
-{
-	return 0;
-}
-
 static const struct file_operations tlclk_fops = {
 	.read = tlclk_read,
-	.write = tlclk_write,
 	.open = tlclk_open,
 	.release = tlclk_release,
 
@@ -540,7 +550,7 @@
 			SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x7);
 			switch (val) {
 			case CLK_8_592MHz:
-				SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
 				break;
 			case CLK_11_184MHz:
 				SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
@@ -549,7 +559,7 @@
 				SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
 				break;
 			case CLK_44_736MHz:
-				SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
 				break;
 			}
 		} else
@@ -839,11 +849,13 @@
 
 static void switchover_timeout(unsigned long data)
 {
-	if ((data & 1)) {
-		if ((inb(TLCLK_REG1) & 0x08) != (data & 0x08))
+	unsigned long flags = *(unsigned long *) data;
+
+	if ((flags & 1)) {
+		if ((inb(TLCLK_REG1) & 0x08) != (flags & 0x08))
 			alarm_events->switchover_primary++;
 	} else {
-		if ((inb(TLCLK_REG1) & 0x08) != (data & 0x08))
+		if ((inb(TLCLK_REG1) & 0x08) != (flags & 0x08))
 			alarm_events->switchover_secondary++;
 	}
 
@@ -901,8 +913,9 @@
 
 		/* TIMEOUT in ~10ms */
 		switchover_timer.expires = jiffies + msecs_to_jiffies(10);
-		switchover_timer.data = inb(TLCLK_REG1);
-		add_timer(&switchover_timer);
+		tlclk_timer_data = inb(TLCLK_REG1);
+		switchover_timer.data = (unsigned long) &tlclk_timer_data;
+		mod_timer(&switchover_timer, switchover_timer.expires);
 	} else {
 		got_event = 1;
 		wake_up(&wq);
