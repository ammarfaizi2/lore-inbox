Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUELU7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUELU7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUELU7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:59:40 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:41702 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S265222AbUELUyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:54:08 -0400
Date: Wed, 12 May 2004 16:54:07 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>,
       Sridhar Samudrala <sri@us.ibm.com>, davem@redhat.com,
       George Anzinger <george@mvista.com>
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040512205407.GD25515@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
	linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>,
	Sridhar Samudrala <sri@us.ibm.com>, davem@redhat.com,
	George Anzinger <george@mvista.com>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <40A26FFA.4030701@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 12, 2004 at 02:42:02PM -0400, Jeff Garzik wrote:
> One of the SCTP folks was cleaning up all the random jif-to-msec and 
> msec-to-jif macros into include/linux/time.h.  Need to dig that up and 
> merge it.
 
Yes, that was Sridhar Samudrala <sri@us.ibm.com>.  I've done some work
to create an accurate implementation of msecs_to_jiffies() and jiffies_to_msecs(),
which I was going to submit later this week after clearing it with George Anziger.
[I have a follow-on patch that reworks the select/poll/epoll timeout fixes
to use timeval_to_jiffies() and msecs_to_jiffies().]

The attached patch combines Sridhar's consolidation patch with my
more accurate routines in the spirit of the rest of time.h.  It is against
2.6.6-rc3-bk3.  Feedback welcome.  I'm happy to rediff against latest kernel,
I just haven't had time the last few days.

George's userland test harness was used to test this on x86 and x86_64.
Below are excerpts from my test output for powers of 2.

The kernel patch compiles and boots on x86, but hasn't been tested extensively.

On x86:

HZ=1535
00: jiffies_to_msecs(1): 1
00: msecs_to_jiffies(1): 2
01: jiffies_to_msecs(2): 2
01: msecs_to_jiffies(2): 4
...
30: jiffies_to_msecs(1073741824): 699221750
30: msecs_to_jiffies(1073741824): 1648863906
31: jiffies_to_msecs(2147483648): 1398443499
31: msecs_to_jiffies(2147483648): 2147483646

HZ=100
00: jiffies_to_msecs(1): 10
00: msecs_to_jiffies(1): 1
01: jiffies_to_msecs(2): 20
01: msecs_to_jiffies(2): 1
...
30: jiffies_to_msecs(1073741824): 2147483640
30: msecs_to_jiffies(1073741824): 107374183
31: jiffies_to_msecs(2147483648): 2147483640
31: msecs_to_jiffies(2147483648): 214748365

HZ=12
00: jiffies_to_msecs(1): 84
00: msecs_to_jiffies(1): 1
01: jiffies_to_msecs(2): 167
01: msecs_to_jiffies(2): 1
...
30: jiffies_to_msecs(1073741824): 2147483576
30: msecs_to_jiffies(1073741824): 12884902
31: jiffies_to_msecs(2147483648): 2147483576
31: msecs_to_jiffies(2147483648): 25769804


On x86_64:

HZ=1535
00: jiffies_to_msecs(1): 1
00: msecs_to_jiffies(1): 2
01: jiffies_to_msecs(2): 2
01: msecs_to_jiffies(2): 4
...
61: jiffies_to_msecs(2305843009213693952): 1501567273914073088
61: msecs_to_jiffies(2305843009213693952): 3540908275912409088
62: jiffies_to_msecs(4611686018427387904): 3003134547828146176
62: msecs_to_jiffies(4611686018427387904): 7081816551824818176
63: jiffies_to_msecs(9223372036854775808): 6006269095656292351
63: msecs_to_jiffies(9223372036854775808): 9223372024794783097

HZ=100
00: jiffies_to_msecs(1): 10
00: msecs_to_jiffies(1): 1
01: jiffies_to_msecs(2): 20
01: msecs_to_jiffies(2): 1
...
61: jiffies_to_msecs(2305843009213693952): 9223372033096679414
61: msecs_to_jiffies(2305843009213693952): 230584301001900032
62: jiffies_to_msecs(4611686018427387904): 9223372033096679414
62: msecs_to_jiffies(4611686018427387904): 461168602003800064
63: jiffies_to_msecs(9223372036854775808): 9223372033096679414
63: msecs_to_jiffies(9223372036854775808): 922337202396987392

HZ=12
00: jiffies_to_msecs(1): 84
00: msecs_to_jiffies(1): 1
01: jiffies_to_msecs(2): 167
01: msecs_to_jiffies(2): 1
...
61: jiffies_to_msecs(2305843009213693952): 9223371701044963021
61: msecs_to_jiffies(2305843009213693952): 27670116233641984
62: jiffies_to_msecs(4611686018427387904): 9223371701044963021
62: msecs_to_jiffies(4611686018427387904): 55340232467283968
63: jiffies_to_msecs(9223372036854775808): 9223371701044963021
63: msecs_to_jiffies(9223372036854775808): 110680463286911100

Regards,

	Bill Rugolsky

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.6-rc3-bk3-msecs-to-jiffies.patch"

--- linux/include/linux/time.h.msecs-to-jiffies	2004-04-03 22:37:36.000000000 -0500
+++ linux/include/linux/time.h	2004-05-07 15:33:49.000000000 -0400
@@ -66,6 +66,10 @@
 #define NSEC_PER_SEC (1000000000L)
 #endif
 
+#ifndef NSEC_PER_MSEC
+#define NSEC_PER_MSEC (1000000L)
+#endif
+
 #ifndef NSEC_PER_USEC
 #define NSEC_PER_USEC (1000L)
 #endif
@@ -148,6 +152,18 @@
 #endif
 #define NSEC_JIFFIE_SC (SEC_JIFFIE_SC + 29)
 #define USEC_JIFFIE_SC (SEC_JIFFIE_SC + 19)
+#define MSEC_JIFFIE_SC (SEC_JIFFIE_SC + 9)
+
+/*
+ * As above, test the sign bit for the jiffie to msec conversion, and if it
+ * is not set, bump the shift count to gain an extra bit of precision.
+ */
+#define JIFFIE_MSEC_SC (31 + SHIFT_HZ - 10)
+#if !((((TICK_NSEC << 2) / NSEC_PER_MSEC) << (JIFFIE_MSEC_SC - 2)) & 0x80000000)
+#undef JIFFIE_MSEC_SC
+#define JIFFIE_MSEC_SC (32 + SHIFT_HZ - 10)
+#endif
+
 #define SEC_CONVERSION ((unsigned long)((((u64)NSEC_PER_SEC << SEC_JIFFIE_SC) +\
                                 TICK_NSEC -1) / (u64)TICK_NSEC))
 
@@ -156,14 +172,24 @@
 #define USEC_CONVERSION  \
                     ((unsigned long)((((u64)NSEC_PER_USEC << USEC_JIFFIE_SC) +\
                                         TICK_NSEC -1) / (u64)TICK_NSEC))
+#define MSEC_CONVERSION \
+                    ((unsigned long)((((u64)NSEC_PER_MSEC << MSEC_JIFFIE_SC) +\
+                                        TICK_NSEC -1) / (u64)TICK_NSEC))
+#define JIFFIE_MSEC_CONVERSION \
+                    ((unsigned long)((((u64)TICK_NSEC << JIFFIE_MSEC_SC) +\
+                                        NSEC_PER_MSEC -1) / (u64)NSEC_PER_MSEC))
 /*
  * USEC_ROUND is used in the timeval to jiffie conversion.  See there
  * for more details.  It is the scaled resolution rounding value.  Note
  * that it is a 64-bit value.  Since, when it is applied, we are already
- * in jiffies (albit scaled), it is nothing but the bits we will shift
- * off.
+ * in jiffies (albeit scaled), it is nothing but the bits we will shift
+ * off.  Similarly for MSEC_ROUND and JIFFIE_MSEC_ROUND.
  */
+
 #define USEC_ROUND (u64)(((u64)1 << USEC_JIFFIE_SC) - 1)
+#define MSEC_ROUND (((u64)1 << MSEC_JIFFIE_SC) - 1)
+#define JIFFIE_MSEC_ROUND (((u64)1 << JIFFIE_MSEC_SC) - 1)
+
 /*
  * The maximum jiffie value is (MAX_INT >> 1).  Here we translate that
  * into seconds.  The 64-bit case will overflow if we are not careful,
@@ -175,8 +201,39 @@
 #else	/* take care of overflow on 64 bits machines */
 # define MAX_SEC_IN_JIFFIES \
 	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 1) - 1)
+#endif
+
+/*
+ * Since a tick can be longer or shorter than a millisecond, we need
+ * to cap one of the MAX_ values at MAX_JIFFY_OFFSET when translating
+ * between jiffies and milliseconds.
+ */
 
+#if TICK_NSEC < NSEC_PER_MSEC
+# define MAX_JIFFIE_IN_MSECS MAX_JIFFY_OFFSET
+#if BITS_PER_LONG < 64
+# define MAX_MSEC_IN_JIFFIES \
+	(long)((u64)((u64)MAX_JIFFY_OFFSET * TICK_NSEC) / NSEC_PER_MSEC)
+#else
+# define MAX_MSEC_IN_JIFFIES \
+	((((MAX_JIFFY_OFFSET & ~(~0UL >> MSEC_JIFFIE_SC)) / \
+	MSEC_CONVERSION) << MSEC_JIFFIE_SC) -1)
+#endif
+#elif TICK_NSEC > NSEC_PER_MSEC
+# define MAX_MSEC_IN_JIFFIES MAX_JIFFY_OFFSET
+#if BITS_PER_LONG < 64
+# define MAX_JIFFIE_IN_MSECS \
+	(long)((u64)((u64)MAX_JIFFY_OFFSET *  NSEC_PER_MSEC) / TICK_NSEC)
+#else
+# define MAX_JIFFIE_IN_MSECS \
+	((((MAX_JIFFY_OFFSET & ~(~0UL >> JIFFIE_MSEC_SC)) / \
+	JIFFIE_MSEC_CONVERSION) << JIFFIE_MSEC_SC) -1)
 #endif
+#else
+# define MAX_JIFFIE_IN_MSECS MAX_JIFFY_OFFSET
+# define MAX_MSEC_IN_JIFFIES MAX_JIFFY_OFFSET
+#endif
+
 /*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
@@ -254,6 +311,37 @@
 	value->tv_usec /= NSEC_PER_USEC;
 }
 
+static __inline__ unsigned long
+msecs_to_jiffies(unsigned long msec)
+{
+	if (msec >= MAX_MSEC_IN_JIFFIES)
+		msec = MAX_MSEC_IN_JIFFIES;
+
+#if BITS_PER_LONG < 64
+	return ((u64)msec * MSEC_CONVERSION + MSEC_ROUND) >> MSEC_JIFFIE_SC;
+#else
+	return (msec >> MSEC_JIFFIE_SC) * MSEC_CONVERSION +
+		(((msec & (~0UL >> MSEC_JIFFIE_SC)) * MSEC_CONVERSION +
+		MSEC_ROUND) >> MSEC_JIFFIE_SC);
+#endif
+}
+
+static __inline__ unsigned long
+jiffies_to_msecs(unsigned long jiffies)
+{
+	if (jiffies >= MAX_JIFFIE_IN_MSECS)
+		jiffies = MAX_JIFFIE_IN_MSECS;
+
+#if BITS_PER_LONG < 64
+	return ((u64)jiffies * JIFFIE_MSEC_CONVERSION +
+		JIFFIE_MSEC_ROUND) >> JIFFIE_MSEC_SC;
+#else
+	return (jiffies >> JIFFIE_MSEC_SC) * JIFFIE_MSEC_CONVERSION +
+		(((jiffies & (~0UL >> JIFFIE_MSEC_SC)) * JIFFIE_MSEC_CONVERSION +
+		JIFFIE_MSEC_ROUND) >> JIFFIE_MSEC_SC);
+#endif
+}
+
 static __inline__ int timespec_equal(struct timespec *a, struct timespec *b) 
 { 
 	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
--- linux/drivers/net/tulip/de2104x.c.msecs-to-jiffies	2004-05-07 15:28:53.000000000 -0400
+++ linux/drivers/net/tulip/de2104x.c	2004-05-07 15:30:19.000000000 -0400
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
 
--- linux/drivers/net/irda/act200l-sir.c.msecs-to-jiffies	2004-04-03 22:36:55.000000000 -0500
+++ linux/drivers/net/irda/act200l-sir.c	2004-05-07 15:30:19.000000000 -0400
@@ -178,7 +178,7 @@
 	/* Write control bytes */
 	sirdev_raw_write(dev, control, 3);
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(5));
+	schedule_timeout(msecs_to_jiffies(5));
 
 	/* Go back to normal mode */
 	sirdev_set_dtr_rts(dev, TRUE, TRUE);
--- linux/drivers/net/irda/act200l.c.msecs-to-jiffies	2004-04-03 22:37:07.000000000 -0500
+++ linux/drivers/net/irda/act200l.c	2004-05-07 15:30:19.000000000 -0400
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
--- linux/drivers/net/irda/actisys.c.msecs-to-jiffies	2004-04-03 22:38:28.000000000 -0500
+++ linux/drivers/net/irda/actisys.c	2004-05-07 15:30:19.000000000 -0400
@@ -238,7 +238,7 @@
 		self->set_dtr_rts(self->dev, TRUE, TRUE);
 		
 		/* Sleep 50 ms to make sure capacitor is charged */
-		ret = MSECS_TO_JIFFIES(50);
+		ret = msecs_to_jiffies(50);
 		irda_task_next_state(task, IRDA_TASK_WAIT);
 		break;
 	case IRDA_TASK_WAIT:			
--- linux/drivers/net/irda/girbil.c.msecs-to-jiffies	2004-04-03 22:36:12.000000000 -0500
+++ linux/drivers/net/irda/girbil.c	2004-05-07 15:30:19.000000000 -0400
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
--- linux/drivers/net/irda/irda-usb.c.msecs-to-jiffies	2004-05-07 15:28:53.000000000 -0400
+++ linux/drivers/net/irda/irda-usb.c	2004-05-07 15:30:19.000000000 -0400
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
--- linux/drivers/net/irda/irport.c.msecs-to-jiffies	2004-05-07 15:28:53.000000000 -0400
+++ linux/drivers/net/irda/irport.c	2004-05-07 15:30:19.000000000 -0400
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
--- linux/drivers/net/irda/irtty-sir.c.msecs-to-jiffies	2004-04-03 22:36:11.000000000 -0500
+++ linux/drivers/net/irda/irtty-sir.c	2004-05-07 15:30:19.000000000 -0400
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
 
--- linux/drivers/net/irda/ma600-sir.c.msecs-to-jiffies	2004-04-03 22:37:36.000000000 -0500
+++ linux/drivers/net/irda/ma600-sir.c	2004-05-07 15:30:19.000000000 -0400
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
 
--- linux/drivers/net/irda/ma600.c.msecs-to-jiffies	2004-04-03 22:37:06.000000000 -0500
+++ linux/drivers/net/irda/ma600.c	2004-05-07 15:30:19.000000000 -0400
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
--- linux/drivers/net/irda/mcp2120.c.msecs-to-jiffies	2004-04-03 22:38:20.000000000 -0500
+++ linux/drivers/net/irda/mcp2120.c	2004-05-07 15:30:19.000000000 -0400
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
--- linux/drivers/net/irda/sir_dev.c.msecs-to-jiffies	2004-05-07 15:28:53.000000000 -0400
+++ linux/drivers/net/irda/sir_dev.c	2004-05-07 15:30:19.000000000 -0400
@@ -74,7 +74,7 @@
 	while (dev->tx_buff.len > 0) {			/* wait until tx idle */
 		spin_unlock_irqrestore(&dev->tx_lock, flags);
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(MSECS_TO_JIFFIES(10));
+		schedule_timeout(msecs_to_jiffies(10));
 		spin_lock_irqsave(&dev->tx_lock, flags);
 	}
 
--- linux/drivers/net/irda/sir_kthread.c.msecs-to-jiffies	2004-05-07 15:28:53.000000000 -0400
+++ linux/drivers/net/irda/sir_kthread.c	2004-05-07 15:30:19.000000000 -0400
@@ -415,7 +415,7 @@
 		fsm->state = next_state;
 	} while(!delay);
 
-	irda_queue_delayed_request(&fsm->rq, MSECS_TO_JIFFIES(delay));
+	irda_queue_delayed_request(&fsm->rq, msecs_to_jiffies(delay));
 }
 
 /* schedule some device configuration task for execution by kIrDAd
--- linux/drivers/net/irda/stir4200.c.msecs-to-jiffies	2004-05-07 15:28:53.000000000 -0400
+++ linux/drivers/net/irda/stir4200.c	2004-05-07 15:30:19.000000000 -0400
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
 
--- linux/drivers/net/irda/tekram-sir.c.msecs-to-jiffies	2004-04-03 22:36:52.000000000 -0500
+++ linux/drivers/net/irda/tekram-sir.c	2004-05-07 15:30:19.000000000 -0400
@@ -211,7 +211,7 @@
 
 	/* Should sleep 1 ms */
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(1));
+	schedule_timeout(msecs_to_jiffies(1));
 
 	/* Set DTR, Set RTS */
 	sirdev_set_dtr_rts(dev, TRUE, TRUE);
--- linux/drivers/net/irda/tekram.c.msecs-to-jiffies	2004-04-03 22:37:23.000000000 -0500
+++ linux/drivers/net/irda/tekram.c	2004-05-07 15:30:19.000000000 -0400
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
--- linux/drivers/char/watchdog/shwdt.c.msecs-to-jiffies	2004-04-03 22:36:54.000000000 -0500
+++ linux/drivers/char/watchdog/shwdt.c	2004-05-07 15:30:19.000000000 -0400
@@ -64,8 +64,7 @@
  */
 static int clock_division_ratio = WTCSR_CKS_4096;
 
-#define msecs_to_jiffies(msecs)	(jiffies + (HZ * msecs + 9999) / 10000)
-#define next_ping_period(cks)	msecs_to_jiffies(cks - 4)
+#define next_ping_period(cks)	(jiffies + msecs_to_jiffies(cks - 4))
 
 static unsigned long shwdt_is_open;
 static struct watchdog_info sh_wdt_info;
--- linux/drivers/block/carmel.c.msecs-to-jiffies	2004-04-03 22:37:38.000000000 -0500
+++ linux/drivers/block/carmel.c	2004-05-07 15:30:19.000000000 -0400
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
--- linux/drivers/block/genhd.c.msecs-to-jiffies	2004-04-03 22:37:06.000000000 -0500
+++ linux/drivers/block/genhd.c	2004-05-07 15:30:19.000000000 -0400
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
--- linux/drivers/input/joydev.c.msecs-to-jiffies	2004-04-03 22:37:06.000000000 -0500
+++ linux/drivers/input/joydev.c	2004-05-07 15:30:19.000000000 -0400
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
--- linux/drivers/atm/fore200e.c.msecs-to-jiffies	2004-05-07 15:28:52.000000000 -0400
+++ linux/drivers/atm/fore200e.c	2004-05-07 15:30:19.000000000 -0400
@@ -95,9 +95,6 @@
 #define FORE200E_NEXT_ENTRY(index, modulo)         (index = ++(index) % (modulo))
 
 
-#define MSECS(ms)  (((ms)*HZ/1000)+1)
-
-
 #if 1
 #define ASSERT(expr)     if (!(expr)) { \
 			     printk(FORE200E "assertion failed! %s[%d]: %s\n", \
@@ -244,7 +241,7 @@
 static void
 fore200e_spin(int msecs)
 {
-    unsigned long timeout = jiffies + MSECS(msecs);
+    unsigned long timeout = jiffies + msecs_to_jiffies(msecs);
     while (time_before(jiffies, timeout));
 }
 
@@ -252,7 +249,7 @@
 static int
 fore200e_poll(struct fore200e* fore200e, volatile u32* addr, u32 val, int msecs)
 {
-    unsigned long timeout = jiffies + MSECS(msecs);
+    unsigned long timeout = jiffies + msecs_to_jiffies(msecs);
     int           ok;
 
     mb();
@@ -276,7 +273,7 @@
 static int
 fore200e_io_poll(struct fore200e* fore200e, volatile u32* addr, u32 val, int msecs)
 {
-    unsigned long timeout = jiffies + MSECS(msecs);
+    unsigned long timeout = jiffies + msecs_to_jiffies(msecs);
     int           ok;
 
     do {
@@ -2597,7 +2594,7 @@
 fore200e_monitor_getc(struct fore200e* fore200e)
 {
     struct cp_monitor* monitor = fore200e->cp_monitor;
-    unsigned long      timeout = jiffies + MSECS(50);
+    unsigned long      timeout = jiffies + msecs_to_jiffies(50);
     int                c;
 
     while (time_before(jiffies, timeout)) {
--- linux/include/linux/libata.h.msecs-to-jiffies	2004-05-07 15:28:55.000000000 -0400
+++ linux/include/linux/libata.h	2004-05-07 15:30:19.000000000 -0400
@@ -411,11 +411,6 @@
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
 
 
-static inline unsigned long msecs_to_jiffies(unsigned long msecs)
-{
-	return ((HZ * msecs + 999) / 1000);
-}
-
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
 	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
--- linux/include/net/irda/irda.h.msecs-to-jiffies	2004-04-03 22:36:55.000000000 -0500
+++ linux/include/net/irda/irda.h	2004-05-07 15:30:19.000000000 -0400
@@ -83,8 +83,6 @@
 #define MESSAGE(args...) printk(KERN_INFO args)
 #define ERROR(args...)   printk(KERN_ERR args)
 
-#define MSECS_TO_JIFFIES(ms) (((ms)*HZ+999)/1000)
-
 /*
  *  Magic numbers used by Linux-IrDA. Random numbers which must be unique to 
  *  give the best protection
--- linux/include/net/sctp/sctp.h.msecs-to-jiffies	2004-05-07 15:28:55.000000000 -0400
+++ linux/include/net/sctp/sctp.h	2004-05-07 15:30:19.000000000 -0400
@@ -116,10 +116,6 @@
 #define SCTP_STATIC static
 #endif
 
-#define MSECS_TO_JIFFIES(msec) \
-	(((msec / 1000) * HZ) + ((msec % 1000) * HZ) / 1000)
-#define JIFFIES_TO_MSECS(jiff) \
-	(((jiff / HZ) * 1000) + ((jiff % HZ) * 1000) / HZ)
 
 /*
  * Function declarations.
--- linux/net/irda/ircomm/ircomm_tty.c.msecs-to-jiffies	2004-04-03 22:36:55.000000000 -0500
+++ linux/net/irda/ircomm/ircomm_tty.c	2004-05-07 15:30:19.000000000 -0400
@@ -873,7 +873,7 @@
 	orig_jiffies = jiffies;
 
 	/* Set poll time to 200 ms */
-	poll_time = IRDA_MIN(timeout, MSECS_TO_JIFFIES(200));
+	poll_time = IRDA_MIN(timeout, msecs_to_jiffies(200));
 
 	spin_lock_irqsave(&self->spinlock, flags);
 	while (self->tx_skb && self->tx_skb->len) {
--- linux/net/irda/irlap_event.c.msecs-to-jiffies	2004-05-07 15:28:55.000000000 -0400
+++ linux/net/irda/irlap_event.c	2004-05-07 15:30:19.000000000 -0400
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
--- linux/net/sctp/associola.c.msecs-to-jiffies	2004-05-07 15:28:55.000000000 -0400
+++ linux/net/sctp/associola.c	2004-05-07 15:30:19.000000000 -0400
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
@@ -507,7 +507,7 @@
 	/* Initialize the peer's heartbeat interval based on the
 	 * sock configured value.
 	 */
-	peer->hb_interval = MSECS_TO_JIFFIES(sp->paddrparam.spp_hbinterval);
+	peer->hb_interval = msecs_to_jiffies(sp->paddrparam.spp_hbinterval);
 
 	/* Set the path max_retrans.  */
 	peer->max_retrans = asoc->max_retrans;
--- linux/net/sctp/endpointola.c.msecs-to-jiffies	2004-04-03 22:36:24.000000000 -0500
+++ linux/net/sctp/endpointola.c	2004-05-07 15:30:19.000000000 -0400
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
--- linux/net/sctp/socket.c.msecs-to-jiffies	2004-05-07 15:28:55.000000000 -0400
+++ linux/net/sctp/socket.c	2004-05-07 15:30:19.000000000 -0400
@@ -1224,7 +1224,7 @@
 			}
 			if (sinit->sinit_max_init_timeo) {
 				asoc->max_init_timeo = 
-				 MSECS_TO_JIFFIES(sinit->sinit_max_init_timeo);
+				 msecs_to_jiffies(sinit->sinit_max_init_timeo);
 			}
 		}
 
@@ -1662,7 +1662,7 @@
 		if (params.spp_hbinterval) {
 			trans->hb_allowed = 1;
 			trans->hb_interval = 
-				MSECS_TO_JIFFIES(params.spp_hbinterval);
+				msecs_to_jiffies(params.spp_hbinterval);
 		} else
 			trans->hb_allowed = 0;
 	}
@@ -1835,11 +1835,11 @@
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
@@ -2379,14 +2379,14 @@
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
@@ -2396,7 +2396,7 @@
 	sp->assocparams.sasoc_peer_rwnd = 0;
 	sp->assocparams.sasoc_local_rwnd = 0;
 	sp->assocparams.sasoc_cookie_life = 
-		JIFFIES_TO_MSECS(sctp_valid_cookie_life);
+		jiffies_to_msecs(sctp_valid_cookie_life);
 
 	/* Initialize default event subscriptions. By default, all the
 	 * options are off. 
@@ -2406,7 +2406,7 @@
 	/* Default Peer Address Parameters.  These defaults can
 	 * be modified via SCTP_PEER_ADDR_PARAMS
 	 */
-	sp->paddrparam.spp_hbinterval = JIFFIES_TO_MSECS(sctp_hb_interval);
+	sp->paddrparam.spp_hbinterval = jiffies_to_msecs(sctp_hb_interval);
 	sp->paddrparam.spp_pathmaxrxt = sctp_max_retrans_path;
 
 	/* If enabled no SCTP message fragmentation will be performed.
@@ -2552,7 +2552,7 @@
 	status.sstat_primary.spinfo_state = transport->active;
 	status.sstat_primary.spinfo_cwnd = transport->cwnd;
 	status.sstat_primary.spinfo_srtt = transport->srtt;
-	status.sstat_primary.spinfo_rto = JIFFIES_TO_MSECS(transport->rto);
+	status.sstat_primary.spinfo_rto = jiffies_to_msecs(transport->rto);
 	status.sstat_primary.spinfo_mtu = transport->pmtu;
 
 	if (put_user(len, optlen)) {
@@ -2607,7 +2607,7 @@
 	pinfo.spinfo_state = transport->active;
 	pinfo.spinfo_cwnd = transport->cwnd;
 	pinfo.spinfo_srtt = transport->srtt;
-	pinfo.spinfo_rto = JIFFIES_TO_MSECS(transport->rto);
+	pinfo.spinfo_rto = jiffies_to_msecs(transport->rto);
 	pinfo.spinfo_mtu = transport->pmtu;
 
 	if (put_user(len, optlen)) {
@@ -2811,7 +2811,7 @@
 	if (!trans->hb_allowed)
 		params.spp_hbinterval = 0;
 	else
-		params.spp_hbinterval = JIFFIES_TO_MSECS(trans->hb_interval);
+		params.spp_hbinterval = jiffies_to_msecs(trans->hb_interval);
 
 	/* spp_pathmaxrxt contains the maximum number of retransmissions
 	 * before this address shall be considered unreachable.
@@ -3168,9 +3168,9 @@
 
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
--- linux/net/sctp/chunk.c.msecs-to-jiffies	2004-05-07 15:28:55.000000000 -0400
+++ linux/net/sctp/chunk.c	2004-05-07 15:31:51.000000000 -0400
@@ -186,7 +186,7 @@
 	if (sinfo->sinfo_timetolive) {
 		/* sinfo_timetolive is in milliseconds */
 		msg->expires_at = jiffies +
-				    MSECS_TO_JIFFIES(sinfo->sinfo_timetolive);
+				    msecs_to_jiffies(sinfo->sinfo_timetolive);
 		msg->can_abandon = 1;
 		SCTP_DEBUG_PRINTK("%s: msg:%p expires_at: %ld jiffies:%ld\n",
 				  __FUNCTION__, msg, msg->expires_at, jiffies);

--cWoXeonUoKmBZSoM--
