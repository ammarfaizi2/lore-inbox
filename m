Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUCYUTY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 15:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbUCYUTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 15:19:24 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:8327 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263565AbUCYUSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 15:18:37 -0500
Date: Thu, 25 Mar 2004 12:17:41 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: davem@redhat.com, jgarzik@pobox.com
cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] Consolidate multiple implementations of jiffies-msecs
 conversions.
Message-ID: <Pine.LNX.4.58.0403251142110.3037@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch to 2.6.5-rc2 consolidates 6 different implementations
of msecs to jiffies and 3 different implementation of jiffies to msecs.
All of them now use the generic msecs_to_jiffies() and jiffies_to_msecs()
that are added to include/linux/time.h

Thanks
Sridhar

--------------------------------------------------------------------------

diff -Nru a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
--- a/drivers/atm/fore200e.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/atm/fore200e.c	Wed Mar 24 16:27:13 2004
@@ -86,9 +86,6 @@
 #define FORE200E_NEXT_ENTRY(index, modulo)    (index = ++(index) % (modulo))


-#define MSECS(ms)  (((ms)*HZ/1000)+1)
-
-
 extern const struct atmdev_ops   fore200e_ops;
 extern const struct fore200e_bus fore200e_bus[];

@@ -247,7 +244,7 @@
 static void
 fore200e_spin(int msecs)
 {
-    unsigned long timeout = jiffies + MSECS(msecs);
+    unsigned long timeout = jiffies + msecs_to_jiffies(msecs);
     while (time_before(jiffies, timeout));
 }

@@ -255,7 +252,7 @@
 static int
 fore200e_poll(struct fore200e* fore200e, volatile u32* addr, u32 val, int msecs)
 {
-    unsigned long timeout = jiffies + MSECS(msecs);
+    unsigned long timeout = jiffies + msecs_to_jiffies(msecs);
     int           ok;

     mb();
@@ -279,7 +276,7 @@
 static int
 fore200e_io_poll(struct fore200e* fore200e, volatile u32* addr, u32 val, int msecs)
 {
-    unsigned long timeout = jiffies + MSECS(msecs);
+    unsigned long timeout = jiffies + msecs_to_jiffies(msecs);
     int           ok;

     do {
@@ -2398,7 +2395,7 @@
 fore200e_monitor_getc(struct fore200e* fore200e)
 {
     struct cp_monitor* monitor = fore200e->cp_monitor;
-    unsigned long      timeout = jiffies + MSECS(50);
+    unsigned long      timeout = jiffies + msecs_to_jiffies(50);
     int                c;

     while (time_before(jiffies, timeout)) {
diff -Nru a/drivers/block/carmel.c b/drivers/block/carmel.c
--- a/drivers/block/carmel.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/block/carmel.c	Wed Mar 24 16:27:13 2004
@@ -438,11 +438,6 @@
 	return -EOPNOTSUPP;
 }

-static inline unsigned long msecs_to_jiffies(unsigned long msecs)
-{
-	return ((HZ * msecs + 999) / 1000);
-}
-
 static void msleep(unsigned long msecs)
 {
 	set_current_state(TASK_UNINTERRUPTIBLE);
diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/block/genhd.c	Wed Mar 24 16:27:13 2004
@@ -357,34 +357,24 @@
 	return sprintf(page, "%llu\n", (unsigned long long)get_capacity(disk));
 }

-static inline unsigned jiffies_to_msec(unsigned jif)
-{
-#if 1000 % HZ == 0
-	return jif * (1000 / HZ);
-#elif HZ % 1000 == 0
-	return jif / (HZ / 1000);
-#else
-	return (jif / HZ) * 1000 + (jif % HZ) * 1000 / HZ;
-#endif
-}
 static ssize_t disk_stats_read(struct gendisk * disk, char *page)
 {
 	disk_round_stats(disk);
 	return sprintf(page,
-		"%8u %8u %8llu %8u "
-		"%8u %8u %8llu %8u "
-		"%8u %8u %8u"
+		"%8u %8u %8llu %8lu "
+		"%8u %8u %8llu %8lu "
+		"%8u %8lu %8lu"
 		"\n",
 		disk_stat_read(disk, reads), disk_stat_read(disk, read_merges),
 		(unsigned long long)disk_stat_read(disk, read_sectors),
-		jiffies_to_msec(disk_stat_read(disk, read_ticks)),
+		jiffies_to_msecs(disk_stat_read(disk, read_ticks)),
 		disk_stat_read(disk, writes),
 		disk_stat_read(disk, write_merges),
 		(unsigned long long)disk_stat_read(disk, write_sectors),
-		jiffies_to_msec(disk_stat_read(disk, write_ticks)),
+		jiffies_to_msecs(disk_stat_read(disk, write_ticks)),
 		disk->in_flight,
-		jiffies_to_msec(disk_stat_read(disk, io_ticks)),
-		jiffies_to_msec(disk_stat_read(disk, time_in_queue)));
+		jiffies_to_msecs(disk_stat_read(disk, io_ticks)),
+		jiffies_to_msecs(disk_stat_read(disk, time_in_queue)));
 }
 static struct disk_attribute disk_attr_dev = {
 	.attr = {.name = "dev", .mode = S_IRUGO },
@@ -494,17 +484,17 @@
 	*/

 	disk_round_stats(gp);
-	seq_printf(s, "%4d %4d %s %u %u %llu %u %u %u %llu %u %u %u %u\n",
+	seq_printf(s, "%4d %4d %s %u %u %llu %lu %u %u %llu %lu %u %lu %lu\n",
 		gp->major, n + gp->first_minor, disk_name(gp, n, buf),
 		disk_stat_read(gp, reads), disk_stat_read(gp, read_merges),
 		(unsigned long long)disk_stat_read(gp, read_sectors),
-		jiffies_to_msec(disk_stat_read(gp, read_ticks)),
+		jiffies_to_msecs(disk_stat_read(gp, read_ticks)),
 		disk_stat_read(gp, writes), disk_stat_read(gp, write_merges),
 		(unsigned long long)disk_stat_read(gp, write_sectors),
-		jiffies_to_msec(disk_stat_read(gp, write_ticks)),
+		jiffies_to_msecs(disk_stat_read(gp, write_ticks)),
 		gp->in_flight,
-		jiffies_to_msec(disk_stat_read(gp, io_ticks)),
-		jiffies_to_msec(disk_stat_read(gp, time_in_queue)));
+		jiffies_to_msecs(disk_stat_read(gp, io_ticks)),
+		jiffies_to_msecs(disk_stat_read(gp, time_in_queue)));

 	/* now show all non-0 size partitions of it */
 	for (n = 0; n < gp->minors - 1; n++) {
diff -Nru a/drivers/char/watchdog/shwdt.c b/drivers/char/watchdog/shwdt.c
--- a/drivers/char/watchdog/shwdt.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/char/watchdog/shwdt.c	Wed Mar 24 16:27:13 2004
@@ -64,8 +64,7 @@
  */
 static int clock_division_ratio = WTCSR_CKS_4096;

-#define msecs_to_jiffies(msecs)	(jiffies + (HZ * msecs + 9999) / 10000)
-#define next_ping_period(cks)	msecs_to_jiffies(cks - 4)
+#define next_ping_period(cks)	(jiffies + msecs_to_jiffies(cks - 4))

 static unsigned long shwdt_is_open;
 static struct watchdog_info sh_wdt_info;
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/input/joydev.c	Wed Mar 24 16:27:13 2004
@@ -37,8 +37,6 @@
 #define JOYDEV_MINORS		16
 #define JOYDEV_BUFFER_SIZE	64

-#define MSECS(t)	(1000 * ((t) / HZ) + 1000 * ((t) % HZ) / HZ)
-
 struct joydev {
 	int exist;
 	int open;
@@ -117,7 +115,7 @@
 			return;
 	}

-	event.time = MSECS(jiffies);
+	event.time = jiffies_to_msecs(jiffies);

 	list_for_each_entry(list, &joydev->list, node) {

@@ -245,7 +243,7 @@

 		struct js_event event;

-		event.time = MSECS(jiffies);
+		event.time = jiffies_to_msecs(jiffies);

 		if (list->startup < joydev->nkey) {
 			event.type = JS_EVENT_BUTTON | JS_EVENT_INIT;
diff -Nru a/drivers/net/irda/act200l-sir.c b/drivers/net/irda/act200l-sir.c
--- a/drivers/net/irda/act200l-sir.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/net/irda/act200l-sir.c	Wed Mar 24 16:27:13 2004
@@ -178,7 +178,7 @@
 	/* Write control bytes */
 	sirdev_raw_write(dev, control, 3);
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(5));
+	schedule_timeout(msecs_to_jiffies(5));

 	/* Go back to normal mode */
 	sirdev_set_dtr_rts(dev, TRUE, TRUE);
diff -Nru a/drivers/net/irda/act200l.c b/drivers/net/irda/act200l.c
--- a/drivers/net/irda/act200l.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/net/irda/act200l.c	Wed Mar 24 16:27:13 2004
@@ -148,7 +148,7 @@
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);

 			/* Give reset 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = msecs_to_jiffies(1000);
 		}
 		break;
 	case IRDA_TASK_CHILD_WAIT:
@@ -187,7 +187,7 @@
 		/* Write control bytes */
 		self->write(self->dev, control, 3);
 		irda_task_next_state(task, IRDA_TASK_WAIT);
-		ret = MSECS_TO_JIFFIES(5);
+		ret = msecs_to_jiffies(5);
 		break;
 	case IRDA_TASK_WAIT:
 		/* Go back to normal mode */
@@ -237,14 +237,14 @@
 		self->set_dtr_rts(self->dev, TRUE, TRUE);

 		irda_task_next_state(task, IRDA_TASK_WAIT1);
-		ret = MSECS_TO_JIFFIES(50);
+		ret = msecs_to_jiffies(50);
 		break;
 	case IRDA_TASK_WAIT1:
 		/* Reset the dongle : set RTS low for 25 ms */
 		self->set_dtr_rts(self->dev, TRUE, FALSE);

 		irda_task_next_state(task, IRDA_TASK_WAIT2);
-		ret = MSECS_TO_JIFFIES(50);
+		ret = msecs_to_jiffies(50);
 		break;
 	case IRDA_TASK_WAIT2:
 		/* Clear DTR and set RTS to enter command mode */
@@ -253,7 +253,7 @@
 		/* Write control bytes */
 		self->write(self->dev, control, 9);
 		irda_task_next_state(task, IRDA_TASK_WAIT3);
-		ret = MSECS_TO_JIFFIES(15);
+		ret = msecs_to_jiffies(15);
 		break;
 	case IRDA_TASK_WAIT3:
 		/* Go back to normal mode */
diff -Nru a/drivers/net/irda/actisys.c b/drivers/net/irda/actisys.c
--- a/drivers/net/irda/actisys.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/net/irda/actisys.c	Wed Mar 24 16:27:13 2004
@@ -238,7 +238,7 @@
 		self->set_dtr_rts(self->dev, TRUE, TRUE);

 		/* Sleep 50 ms to make sure capacitor is charged */
-		ret = MSECS_TO_JIFFIES(50);
+		ret = msecs_to_jiffies(50);
 		irda_task_next_state(task, IRDA_TASK_WAIT);
 		break;
 	case IRDA_TASK_WAIT:
diff -Nru a/drivers/net/irda/girbil.c b/drivers/net/irda/girbil.c
--- a/drivers/net/irda/girbil.c	Wed Mar 24 16:27:12 2004
+++ b/drivers/net/irda/girbil.c	Wed Mar 24 16:27:12 2004
@@ -119,7 +119,7 @@
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);

 			/* Give reset 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = msecs_to_jiffies(1000);
 		}
 		break;
 	case IRDA_TASK_CHILD_WAIT:
@@ -153,7 +153,7 @@
 		/* Write control bytes */
 		self->write(self->dev, control, 2);
 		irda_task_next_state(task, IRDA_TASK_WAIT);
-		ret = MSECS_TO_JIFFIES(100);
+		ret = msecs_to_jiffies(100);
 		break;
 	case IRDA_TASK_WAIT:
 		/* Go back to normal mode */
@@ -194,19 +194,19 @@
 		self->set_dtr_rts(self->dev, TRUE, FALSE);
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
 		/* Sleep at least 5 ms */
-		ret = MSECS_TO_JIFFIES(20);
+		ret = msecs_to_jiffies(20);
 		break;
 	case IRDA_TASK_WAIT1:
 		/* Set DTR and clear RTS to enter command mode */
 		self->set_dtr_rts(self->dev, FALSE, TRUE);
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
-		ret = MSECS_TO_JIFFIES(20);
+		ret = msecs_to_jiffies(20);
 		break;
 	case IRDA_TASK_WAIT2:
 		/* Write control byte */
 		self->write(self->dev, &control, 1);
 		irda_task_next_state(task, IRDA_TASK_WAIT3);
-		ret = MSECS_TO_JIFFIES(20);
+		ret = msecs_to_jiffies(20);
 		break;
 	case IRDA_TASK_WAIT3:
 		/* Go back to normal mode */
diff -Nru a/drivers/net/irda/irda-usb.c b/drivers/net/irda/irda-usb.c
--- a/drivers/net/irda/irda-usb.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/net/irda/irda-usb.c	Wed Mar 24 16:27:13 2004
@@ -268,7 +268,7 @@
                       speed_bulk_callback, self);
 	urb->transfer_buffer_length = USB_IRDA_HEADER;
 	urb->transfer_flags = URB_ASYNC_UNLINK;
-	urb->timeout = MSECS_TO_JIFFIES(100);
+	urb->timeout = msecs_to_jiffies(100);

 	/* Irq disabled -> GFP_ATOMIC */
 	if ((ret = usb_submit_urb(urb, GFP_ATOMIC))) {
@@ -412,7 +412,7 @@
 	 * This is how the dongle will detect the end of packet - Jean II */
 	urb->transfer_flags |= URB_ZERO_PACKET;
 	/* Timeout need to be shorter than NET watchdog timer */
-	urb->timeout = MSECS_TO_JIFFIES(200);
+	urb->timeout = msecs_to_jiffies(200);

 	/* Generate min turn time. FIXME: can we do better than this? */
 	/* Trying to a turnaround time at this level is trying to measure
@@ -1311,7 +1311,7 @@
 		IU_REQ_GET_CLASS_DESC,
 		USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
 		0, intf->altsetting->desc.bInterfaceNumber, desc,
-		sizeof(*desc), MSECS_TO_JIFFIES(500));
+		sizeof(*desc), msecs_to_jiffies(500));

 	IRDA_DEBUG(1, "%s(), ret=%d\n", __FUNCTION__, ret);
 	if (ret < sizeof(*desc)) {
diff -Nru a/drivers/net/irda/irport.c b/drivers/net/irda/irport.c
--- a/drivers/net/irda/irport.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/net/irda/irport.c	Wed Mar 24 16:27:13 2004
@@ -452,7 +452,7 @@
 			task->state = IRDA_TASK_WAIT;

 			/* Try again later */
-			ret = MSECS_TO_JIFFIES(20);
+			ret = msecs_to_jiffies(20);
 			break;
 		}

@@ -474,7 +474,7 @@
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);

 			/* Give dongle 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = msecs_to_jiffies(1000);
 		} else
 			/* Child finished immediately */
 			irda_task_next_state(task, IRDA_TASK_CHILD_DONE);
diff -Nru a/drivers/net/irda/irtty-sir.c b/drivers/net/irda/irtty-sir.c
--- a/drivers/net/irda/irtty-sir.c	Wed Mar 24 16:27:12 2004
+++ b/drivers/net/irda/irtty-sir.c	Wed Mar 24 16:27:12 2004
@@ -93,12 +93,12 @@
 	tty = priv->tty;
 	if (tty->driver->wait_until_sent) {
 		lock_kernel();
-		tty->driver->wait_until_sent(tty, MSECS_TO_JIFFIES(100));
+		tty->driver->wait_until_sent(tty, msecs_to_jiffies(100));
 		unlock_kernel();
 	}
 	else {
 		set_task_state(current, TASK_UNINTERRUPTIBLE);
-		schedule_timeout(MSECS_TO_JIFFIES(USBSERIAL_TX_DONE_DELAY));
+		schedule_timeout(msecs_to_jiffies(USBSERIAL_TX_DONE_DELAY));
 	}
 }

diff -Nru a/drivers/net/irda/ma600-sir.c b/drivers/net/irda/ma600-sir.c
--- a/drivers/net/irda/ma600-sir.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/net/irda/ma600-sir.c	Wed Mar 24 16:27:13 2004
@@ -192,7 +192,7 @@

 	/* Wait at least 10ms: fake wait_until_sent - 10 bits at 9600 baud*/
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(15));		/* old ma600 uses 15ms */
+	schedule_timeout(msecs_to_jiffies(15));		/* old ma600 uses 15ms */

 #if 1
 	/* read-back of the control byte. ma600 is the first dongle driver
@@ -216,7 +216,7 @@

 	/* Wait at least 10ms */
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(10));
+	schedule_timeout(msecs_to_jiffies(10));

 	/* dongle is now switched to the new speed */
 	dev->speed = speed;
@@ -246,12 +246,12 @@
 	/* Reset the dongle : set DTR low for 10 ms */
 	sirdev_set_dtr_rts(dev, FALSE, TRUE);
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(10));
+	schedule_timeout(msecs_to_jiffies(10));

 	/* Go back to normal mode */
 	sirdev_set_dtr_rts(dev, TRUE, TRUE);
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(10));
+	schedule_timeout(msecs_to_jiffies(10));

 	dev->speed = 9600;      /* That's the dongle-default */

diff -Nru a/drivers/net/irda/ma600.c b/drivers/net/irda/ma600.c
--- a/drivers/net/irda/ma600.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/net/irda/ma600.c	Wed Mar 24 16:27:13 2004
@@ -184,7 +184,7 @@

 	if (self->speed_task && self->speed_task != task) {
 		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__);
-		return MSECS_TO_JIFFIES(10);
+		return msecs_to_jiffies(10);
 	} else {
 		self->speed_task = task;
 	}
@@ -202,7 +202,7 @@
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);

 			/* give 1 second to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = msecs_to_jiffies(1000);
 		} else {
 			irda_task_next_state(task, IRDA_TASK_CHILD_DONE);
 		}
@@ -217,7 +217,7 @@
 		/* Set DTR, Clear RTS */
 		self->set_dtr_rts(self->dev, TRUE, FALSE);

-		ret = MSECS_TO_JIFFIES(1);		/* Sleep 1 ms */
+		ret = msecs_to_jiffies(1);		/* Sleep 1 ms */
 		irda_task_next_state(task, IRDA_TASK_WAIT);
 		break;

@@ -231,7 +231,7 @@
 		irda_task_next_state(task, IRDA_TASK_WAIT1);

 		/* Wait at least 10 ms */
-		ret = MSECS_TO_JIFFIES(15);
+		ret = msecs_to_jiffies(15);
 		break;

 	case IRDA_TASK_WAIT1:
@@ -258,7 +258,7 @@
 		irda_task_next_state(task, IRDA_TASK_WAIT2);

 		/* Wait at least 10 ms */
-		ret = MSECS_TO_JIFFIES(10);
+		ret = msecs_to_jiffies(10);
 		break;

 	case IRDA_TASK_WAIT2:
@@ -298,7 +298,7 @@

 	if (self->reset_task && self->reset_task != task) {
 		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__);
-		return MSECS_TO_JIFFIES(10);
+		return msecs_to_jiffies(10);
 	} else
 		self->reset_task = task;

@@ -307,13 +307,13 @@
 		/* Clear DTR and Set RTS */
 		self->set_dtr_rts(self->dev, FALSE, TRUE);
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
-		ret = MSECS_TO_JIFFIES(10);		/* Sleep 10 ms */
+		ret = msecs_to_jiffies(10);		/* Sleep 10 ms */
 		break;
 	case IRDA_TASK_WAIT1:
 		/* Set DTR and RTS */
 		self->set_dtr_rts(self->dev, TRUE, TRUE);
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
-		ret = MSECS_TO_JIFFIES(10);		/* Sleep 10 ms */
+		ret = msecs_to_jiffies(10);		/* Sleep 10 ms */
 		break;
 	case IRDA_TASK_WAIT2:
 		irda_task_next_state(task, IRDA_TASK_DONE);
diff -Nru a/drivers/net/irda/mcp2120.c b/drivers/net/irda/mcp2120.c
--- a/drivers/net/irda/mcp2120.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/net/irda/mcp2120.c	Wed Mar 24 16:27:13 2004
@@ -99,7 +99,7 @@
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);

 			/* Give reset 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = msecs_to_jiffies(1000);
 		}
 		break;
 	case IRDA_TASK_CHILD_WAIT:
@@ -140,7 +140,7 @@
                 self->write(self->dev, control, 2);

                 irda_task_next_state(task, IRDA_TASK_WAIT);
-		ret = MSECS_TO_JIFFIES(100);
+		ret = msecs_to_jiffies(100);
                 //printk("mcp2120_change_speed irda_child_done\n");
 		break;
 	case IRDA_TASK_WAIT:
@@ -189,14 +189,14 @@
 		/* Reset dongle by setting RTS*/
 		self->set_dtr_rts(self->dev, TRUE, TRUE);
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
-		ret = MSECS_TO_JIFFIES(50);
+		ret = msecs_to_jiffies(50);
 		break;
 	case IRDA_TASK_WAIT1:
                 //printk("mcp2120_reset irda_task_wait1\n");
                 /* clear RTS and wait for at least 30 ms. */
 		self->set_dtr_rts(self->dev, FALSE, FALSE);
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
-		ret = MSECS_TO_JIFFIES(50);
+		ret = msecs_to_jiffies(50);
 		break;
 	case IRDA_TASK_WAIT2:
                 //printk("mcp2120_reset irda_task_wait2\n");
diff -Nru a/drivers/net/irda/sir_dev.c b/drivers/net/irda/sir_dev.c
--- a/drivers/net/irda/sir_dev.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/net/irda/sir_dev.c	Wed Mar 24 16:27:13 2004
@@ -74,7 +74,7 @@
 	while (dev->tx_buff.len > 0) {			/* wait until tx idle */
 		spin_unlock_irqrestore(&dev->tx_lock, flags);
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(MSECS_TO_JIFFIES(10));
+		schedule_timeout(msecs_to_jiffies(10));
 		spin_lock_irqsave(&dev->tx_lock, flags);
 	}

diff -Nru a/drivers/net/irda/sir_kthread.c b/drivers/net/irda/sir_kthread.c
--- a/drivers/net/irda/sir_kthread.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/net/irda/sir_kthread.c	Wed Mar 24 16:27:13 2004
@@ -415,7 +415,7 @@
 		fsm->state = next_state;
 	} while(!delay);

-	irda_queue_delayed_request(&fsm->rq, MSECS_TO_JIFFIES(delay));
+	irda_queue_delayed_request(&fsm->rq, msecs_to_jiffies(delay));
 }

 /* schedule some device configuration task for execution by kIrDAd
diff -Nru a/drivers/net/irda/stir4200.c b/drivers/net/irda/stir4200.c
--- a/drivers/net/irda/stir4200.c	Wed Mar 24 16:27:12 2004
+++ b/drivers/net/irda/stir4200.c	Wed Mar 24 16:27:13 2004
@@ -208,7 +208,7 @@
 			       REQ_WRITE_SINGLE,
 			       USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_DEVICE,
 			       value, reg, NULL, 0,
-			       MSECS_TO_JIFFIES(CTRL_TIMEOUT));
+			       msecs_to_jiffies(CTRL_TIMEOUT));
 }

 /* Send control message to read multiple registers */
@@ -221,7 +221,7 @@
 			       REQ_READ_REG,
 			       USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			       0, reg, data, count,
-			       MSECS_TO_JIFFIES(CTRL_TIMEOUT));
+			       msecs_to_jiffies(CTRL_TIMEOUT));
 }

 static inline int isfir(u32 speed)
@@ -745,7 +745,7 @@

 	if (usb_bulk_msg(stir->usbdev, usb_sndbulkpipe(stir->usbdev, 1),
 			 stir->io_buf, wraplen,
-			 NULL, MSECS_TO_JIFFIES(TRANSMIT_TIMEOUT)))
+			 NULL, msecs_to_jiffies(TRANSMIT_TIMEOUT)))
 		stir->stats.tx_errors++;
 }

diff -Nru a/drivers/net/irda/tekram-sir.c b/drivers/net/irda/tekram-sir.c
--- a/drivers/net/irda/tekram-sir.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/net/irda/tekram-sir.c	Wed Mar 24 16:27:13 2004
@@ -211,7 +211,7 @@

 	/* Should sleep 1 ms */
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(1));
+	schedule_timeout(msecs_to_jiffies(1));

 	/* Set DTR, Set RTS */
 	sirdev_set_dtr_rts(dev, TRUE, TRUE);
diff -Nru a/drivers/net/irda/tekram.c b/drivers/net/irda/tekram.c
--- a/drivers/net/irda/tekram.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/net/irda/tekram.c	Wed Mar 24 16:27:13 2004
@@ -113,7 +113,7 @@

 	if (self->speed_task && self->speed_task != task) {
 		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__ );
-		return MSECS_TO_JIFFIES(10);
+		return msecs_to_jiffies(10);
 	} else
 		self->speed_task = task;

@@ -150,7 +150,7 @@
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);

 			/* Give reset 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = msecs_to_jiffies(1000);
 		} else
 			irda_task_next_state(task, IRDA_TASK_CHILD_DONE);
 		break;
@@ -171,7 +171,7 @@
 		irda_task_next_state(task, IRDA_TASK_WAIT);

 		/* Wait at least 100 ms */
-		ret = MSECS_TO_JIFFIES(150);
+		ret = msecs_to_jiffies(150);
 		break;
 	case IRDA_TASK_WAIT:
 		/* Set DTR, Set RTS */
@@ -214,7 +214,7 @@

 	if (self->reset_task && self->reset_task != task) {
 		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__ );
-		return MSECS_TO_JIFFIES(10);
+		return msecs_to_jiffies(10);
 	} else
 		self->reset_task = task;

@@ -227,7 +227,7 @@
 		irda_task_next_state(task, IRDA_TASK_WAIT1);

 		/* Sleep 50 ms */
-		ret = MSECS_TO_JIFFIES(50);
+		ret = msecs_to_jiffies(50);
 		break;
 	case IRDA_TASK_WAIT1:
 		/* Clear DTR, Set RTS */
@@ -236,7 +236,7 @@
 		irda_task_next_state(task, IRDA_TASK_WAIT2);

 		/* Should sleep 1 ms */
-		ret = MSECS_TO_JIFFIES(1);
+		ret = msecs_to_jiffies(1);
 		break;
 	case IRDA_TASK_WAIT2:
 		/* Set DTR, Set RTS */
diff -Nru a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
--- a/drivers/net/tulip/de2104x.c	Wed Mar 24 16:27:13 2004
+++ b/drivers/net/tulip/de2104x.c	Wed Mar 24 16:27:13 2004
@@ -357,13 +357,6 @@
 static u16 t21041_csr15[] = { 0x0008, 0x0006, 0x000E, 0x0008, 0x0008, };


-static inline unsigned long
-msec_to_jiffies(unsigned long ms)
-{
-	return (((ms)*HZ+999)/1000);
-}
-
-
 #define dr32(reg)		readl(de->regs + (reg))
 #define dw32(reg,val)		writel((val), de->regs + (reg))

@@ -1216,7 +1209,7 @@

 		/* de4x5.c delays, so we do too */
 		current->state = TASK_UNINTERRUPTIBLE;
-		schedule_timeout(msec_to_jiffies(10));
+		schedule_timeout(msecs_to_jiffies(10));
 	}
 }

diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	Wed Mar 24 16:27:12 2004
+++ b/include/linux/libata.h	Wed Mar 24 16:27:12 2004
@@ -435,11 +435,6 @@
 			      sector_t capacity, int geom[]);


-static inline unsigned long msecs_to_jiffies(unsigned long msecs)
-{
-	return ((HZ * msecs + 999) / 1000);
-}
-
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
 	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
diff -Nru a/include/linux/time.h b/include/linux/time.h
--- a/include/linux/time.h	Wed Mar 24 16:27:13 2004
+++ b/include/linux/time.h	Wed Mar 24 16:27:13 2004
@@ -259,6 +259,28 @@
 	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
 }

+static inline unsigned long msecs_to_jiffies(unsigned long msecs)
+{
+#if 1000 % HZ == 0
+        return msecs / (1000 / HZ);
+#elif HZ % 1000 == 0
+        return msecs * (HZ / 1000);
+#else
+        return (msecs / 1000) * HZ + (msecs % 1000) * HZ / 1000;
+#endif
+}
+
+static inline unsigned long jiffies_to_msecs(unsigned long jiffs)
+{
+#if 1000 % HZ == 0
+        return jiffs * (1000 / HZ);
+#elif HZ % 1000 == 0
+        return jiffs / (HZ / 1000);
+#else
+        return (jiffs / HZ) * 1000 + (jiffs % HZ) * 1000 / HZ;
+#endif
+}
+
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
  * => year=1980, mon=12, day=31, hour=23, min=59, sec=59.
diff -Nru a/include/net/irda/irda.h b/include/net/irda/irda.h
--- a/include/net/irda/irda.h	Wed Mar 24 16:27:13 2004
+++ b/include/net/irda/irda.h	Wed Mar 24 16:27:13 2004
@@ -83,8 +83,6 @@
 #define MESSAGE(args...) printk(KERN_INFO args)
 #define ERROR(args...)   printk(KERN_ERR args)

-#define MSECS_TO_JIFFIES(ms) (((ms)*HZ+999)/1000)
-
 /*
  *  Magic numbers used by Linux-IrDA. Random numbers which must be unique to
  *  give the best protection
diff -Nru a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
--- a/include/net/sctp/sctp.h	Wed Mar 24 16:27:13 2004
+++ b/include/net/sctp/sctp.h	Wed Mar 24 16:27:13 2004
@@ -115,10 +115,6 @@
 #define SCTP_STATIC static
 #endif

-#define MSECS_TO_JIFFIES(msec) \
-	(((msec / 1000) * HZ) + ((msec % 1000) * HZ) / 1000)
-#define JIFFIES_TO_MSECS(jiff) \
-	(((jiff / HZ) * 1000) + ((jiff % HZ) * 1000) / HZ)

 /*
  * Function declarations.
diff -Nru a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
--- a/net/irda/ircomm/ircomm_tty.c	Wed Mar 24 16:27:13 2004
+++ b/net/irda/ircomm/ircomm_tty.c	Wed Mar 24 16:27:13 2004
@@ -873,7 +873,7 @@
 	orig_jiffies = jiffies;

 	/* Set poll time to 200 ms */
-	poll_time = IRDA_MIN(timeout, MSECS_TO_JIFFIES(200));
+	poll_time = IRDA_MIN(timeout, msecs_to_jiffies(200));

 	spin_lock_irqsave(&self->spinlock, flags);
 	while (self->tx_skb && self->tx_skb->len) {
diff -Nru a/net/irda/irlap_event.c b/net/irda/irlap_event.c
--- a/net/irda/irlap_event.c	Wed Mar 24 16:27:13 2004
+++ b/net/irda/irlap_event.c	Wed Mar 24 16:27:13 2004
@@ -627,7 +627,7 @@
 		if (irda_device_is_receiving(self->netdev) && !self->add_wait) {
 			IRDA_DEBUG(2, "%s(), device is slow to answer, "
 				   "waiting some more!\n", __FUNCTION__);
-			irlap_start_slot_timer(self, MSECS_TO_JIFFIES(10));
+			irlap_start_slot_timer(self, msecs_to_jiffies(10));
 			self->add_wait = TRUE;
 			return ret;
 		}
@@ -849,7 +849,7 @@
  *  1.5 times the time taken to transmit a SNRM frame. So this time should
  *  between 15 msecs and 45 msecs.
  */
-			irlap_start_backoff_timer(self, MSECS_TO_JIFFIES(20 +
+			irlap_start_backoff_timer(self, msecs_to_jiffies(20 +
 						        (jiffies % 30)));
 		} else {
 			/* Always switch state before calling upper layers */
@@ -1506,7 +1506,7 @@
 		if (irda_device_is_receiving(self->netdev) && !self->add_wait) {
 			IRDA_DEBUG(1, "FINAL_TIMER_EXPIRED when receiving a "
 			      "frame! Waiting a little bit more!\n");
-			irlap_start_final_timer(self, MSECS_TO_JIFFIES(300));
+			irlap_start_final_timer(self, msecs_to_jiffies(300));

 			/*
 			 *  Don't allow this to happen one more time in a row,
diff -Nru a/net/sctp/associola.c b/net/sctp/associola.c
--- a/net/sctp/associola.c	Wed Mar 24 16:27:12 2004
+++ b/net/sctp/associola.c	Wed Mar 24 16:27:12 2004
@@ -142,9 +142,9 @@
 	 * socket values.
 	 */
 	asoc->max_retrans = sp->assocparams.sasoc_asocmaxrxt;
-	asoc->rto_initial = MSECS_TO_JIFFIES(sp->rtoinfo.srto_initial);
-	asoc->rto_max = MSECS_TO_JIFFIES(sp->rtoinfo.srto_max);
-	asoc->rto_min = MSECS_TO_JIFFIES(sp->rtoinfo.srto_min);
+	asoc->rto_initial = msecs_to_jiffies(sp->rtoinfo.srto_initial);
+	asoc->rto_max = msecs_to_jiffies(sp->rtoinfo.srto_max);
+	asoc->rto_min = msecs_to_jiffies(sp->rtoinfo.srto_min);

 	asoc->overall_error_count = 0;

@@ -170,7 +170,7 @@
 	asoc->max_init_attempts	= sp->initmsg.sinit_max_attempts;

 	asoc->max_init_timeo =
-		 MSECS_TO_JIFFIES(sp->initmsg.sinit_max_init_timeo);
+		 msecs_to_jiffies(sp->initmsg.sinit_max_init_timeo);

 	/* Allocate storage for the ssnmap after the inbound and outbound
 	 * streams have been negotiated during Init.
@@ -510,7 +510,7 @@
 	/* Initialize the peer's heartbeat interval based on the
 	 * sock configured value.
 	 */
-	peer->hb_interval = MSECS_TO_JIFFIES(sp->paddrparam.spp_hbinterval);
+	peer->hb_interval = msecs_to_jiffies(sp->paddrparam.spp_hbinterval);

 	/* Set the path max_retrans.  */
 	peer->max_retrans = asoc->max_retrans;
diff -Nru a/net/sctp/endpointola.c b/net/sctp/endpointola.c
--- a/net/sctp/endpointola.c	Wed Mar 24 16:27:12 2004
+++ b/net/sctp/endpointola.c	Wed Mar 24 16:27:12 2004
@@ -129,7 +129,7 @@
 	ep->timeouts[SCTP_EVENT_TIMEOUT_T1_INIT] =
 		SCTP_DEFAULT_TIMEOUT_T1_INIT;
 	ep->timeouts[SCTP_EVENT_TIMEOUT_T2_SHUTDOWN] =
-		MSECS_TO_JIFFIES(sp->rtoinfo.srto_initial);
+		msecs_to_jiffies(sp->rtoinfo.srto_initial);
 	ep->timeouts[SCTP_EVENT_TIMEOUT_T3_RTX] = 0;
 	ep->timeouts[SCTP_EVENT_TIMEOUT_T4_RTO] = 0;

@@ -138,7 +138,7 @@
 	 * recommended value of 5 times 'RTO.Max'.
 	 */
         ep->timeouts[SCTP_EVENT_TIMEOUT_T5_SHUTDOWN_GUARD]
-		= 5 * MSECS_TO_JIFFIES(sp->rtoinfo.srto_max);
+		= 5 * msecs_to_jiffies(sp->rtoinfo.srto_max);

 	ep->timeouts[SCTP_EVENT_TIMEOUT_HEARTBEAT] =
 		SCTP_DEFAULT_TIMEOUT_HEARTBEAT;
diff -Nru a/net/sctp/socket.c b/net/sctp/socket.c
--- a/net/sctp/socket.c	Wed Mar 24 16:27:13 2004
+++ b/net/sctp/socket.c	Wed Mar 24 16:27:13 2004
@@ -1218,7 +1218,7 @@
 			}
 			if (sinit->sinit_max_init_timeo) {
 				asoc->max_init_timeo =
-				 MSECS_TO_JIFFIES(sinit->sinit_max_init_timeo);
+				 msecs_to_jiffies(sinit->sinit_max_init_timeo);
 			}
 		}

@@ -1657,7 +1657,7 @@
 		if (params.spp_hbinterval) {
 			trans->hb_allowed = 1;
 			trans->hb_interval =
-				MSECS_TO_JIFFIES(params.spp_hbinterval);
+				msecs_to_jiffies(params.spp_hbinterval);
 		} else
 			trans->hb_allowed = 0;
 	}
@@ -1830,11 +1830,11 @@
 	if (asoc) {
 		if (rtoinfo.srto_initial != 0)
 			asoc->rto_initial =
-				MSECS_TO_JIFFIES(rtoinfo.srto_initial);
+				msecs_to_jiffies(rtoinfo.srto_initial);
 		if (rtoinfo.srto_max != 0)
-			asoc->rto_max = MSECS_TO_JIFFIES(rtoinfo.srto_max);
+			asoc->rto_max = msecs_to_jiffies(rtoinfo.srto_max);
 		if (rtoinfo.srto_min != 0)
-			asoc->rto_min = MSECS_TO_JIFFIES(rtoinfo.srto_min);
+			asoc->rto_min = msecs_to_jiffies(rtoinfo.srto_min);
 	} else {
 		/* If there is no association or the association-id = 0
 		 * set the values to the endpoint.
@@ -2363,14 +2363,14 @@
 	sp->initmsg.sinit_num_ostreams   = sctp_max_outstreams;
 	sp->initmsg.sinit_max_instreams  = sctp_max_instreams;
 	sp->initmsg.sinit_max_attempts   = sctp_max_retrans_init;
-	sp->initmsg.sinit_max_init_timeo = JIFFIES_TO_MSECS(sctp_rto_max);
+	sp->initmsg.sinit_max_init_timeo = jiffies_to_msecs(sctp_rto_max);

 	/* Initialize default RTO related parameters.  These parameters can
 	 * be modified for with the SCTP_RTOINFO socket option.
 	 */
-	sp->rtoinfo.srto_initial = JIFFIES_TO_MSECS(sctp_rto_initial);
-	sp->rtoinfo.srto_max     = JIFFIES_TO_MSECS(sctp_rto_max);
-	sp->rtoinfo.srto_min     = JIFFIES_TO_MSECS(sctp_rto_min);
+	sp->rtoinfo.srto_initial = jiffies_to_msecs(sctp_rto_initial);
+	sp->rtoinfo.srto_max     = jiffies_to_msecs(sctp_rto_max);
+	sp->rtoinfo.srto_min     = jiffies_to_msecs(sctp_rto_min);

 	/* Initialize default association related parameters. These parameters
 	 * can be modified with the SCTP_ASSOCINFO socket option.
@@ -2380,7 +2380,7 @@
 	sp->assocparams.sasoc_peer_rwnd = 0;
 	sp->assocparams.sasoc_local_rwnd = 0;
 	sp->assocparams.sasoc_cookie_life =
-		JIFFIES_TO_MSECS(sctp_valid_cookie_life);
+		jiffies_to_msecs(sctp_valid_cookie_life);

 	/* Initialize default event subscriptions. By default, all the
 	 * options are off.
@@ -2390,7 +2390,7 @@
 	/* Default Peer Address Parameters.  These defaults can
 	 * be modified via SCTP_PEER_ADDR_PARAMS
 	 */
-	sp->paddrparam.spp_hbinterval = JIFFIES_TO_MSECS(sctp_hb_interval);
+	sp->paddrparam.spp_hbinterval = jiffies_to_msecs(sctp_hb_interval);
 	sp->paddrparam.spp_pathmaxrxt = sctp_max_retrans_path;

 	/* If enabled no SCTP message fragmentation will be performed.
@@ -2540,7 +2540,7 @@
 	status.sstat_primary.spinfo_state = transport->active;
 	status.sstat_primary.spinfo_cwnd = transport->cwnd;
 	status.sstat_primary.spinfo_srtt = transport->srtt;
-	status.sstat_primary.spinfo_rto = JIFFIES_TO_MSECS(transport->rto);
+	status.sstat_primary.spinfo_rto = jiffies_to_msecs(transport->rto);
 	status.sstat_primary.spinfo_mtu = transport->pmtu;

 	if (put_user(len, optlen)) {
@@ -2595,7 +2595,7 @@
 	pinfo.spinfo_state = transport->active;
 	pinfo.spinfo_cwnd = transport->cwnd;
 	pinfo.spinfo_srtt = transport->srtt;
-	pinfo.spinfo_rto = JIFFIES_TO_MSECS(transport->rto);
+	pinfo.spinfo_rto = jiffies_to_msecs(transport->rto);
 	pinfo.spinfo_mtu = transport->pmtu;

 	if (put_user(len, optlen)) {
@@ -2799,7 +2799,7 @@
 	if (!trans->hb_allowed)
 		params.spp_hbinterval = 0;
 	else
-		params.spp_hbinterval = JIFFIES_TO_MSECS(trans->hb_interval);
+		params.spp_hbinterval = jiffies_to_msecs(trans->hb_interval);

 	/* spp_pathmaxrxt contains the maximum number of retransmissions
 	 * before this address shall be considered unreachable.
@@ -3156,9 +3156,9 @@

 	/* Values corresponding to the specific association. */
 	if (asoc) {
-		rtoinfo.srto_initial = JIFFIES_TO_MSECS(asoc->rto_initial);
-		rtoinfo.srto_max = JIFFIES_TO_MSECS(asoc->rto_max);
-		rtoinfo.srto_min = JIFFIES_TO_MSECS(asoc->rto_min);
+		rtoinfo.srto_initial = jiffies_to_msecs(asoc->rto_initial);
+		rtoinfo.srto_max = jiffies_to_msecs(asoc->rto_max);
+		rtoinfo.srto_min = jiffies_to_msecs(asoc->rto_min);
 	} else {
 		/* Values corresponding to the endpoint. */
 		struct sctp_opt *sp = sctp_sk(sk);
