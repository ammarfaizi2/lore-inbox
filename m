Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTFAOQs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 10:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264624AbTFAOQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 10:16:47 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:1773 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263610AbTFAOQl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 10:16:41 -0400
Message-ID: <3EDA0E5D.8080404@pacbell.net>
Date: Sun, 01 Jun 2003 07:31:57 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: alexh@ihatent.com
CC: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 with 250Gb disk and insane loads
Content-Type: multipart/mixed;
 boundary="------------030704050202080901030808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030704050202080901030808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> I'm trying to nail own a problem here, with my shiny new Maxtor 250Gb
> USB 2.0 disk. Under 2.4 (vanilla, latest 21-preX and 21-preX-acY) the
> disk will mount and talk nicely. As soon as any load hits it, e.g. a
> single cp from my internal CD-ROM to the disk, the mahcine load will
> sky-rocket and at some point within a few minuter hang the machine.
> 
> On 2.5 (vanilla and -mm) the load will show as i/o-wait and at some
> point hang any access to the drive, but the kernel will go on working.

That's a big clue -- nothing in the USB code ever shows up
as "i/o wait".  It can't, since USB is usually built as
modules and things like io_schedule() are, for some odd
reason, never exported for use in modules.  So USB I/O
can't use them, and won't show up as "i/o" ... and that
load must come from some place other than USB.

There are some patches that really ought to get merged
into the 2.4.21 release (2.5.70 has both of these), but
they shouldn't affect anything with an "i/o wait" symptom.

- Dave

[1] ehci-0429 ... applies to 2.4.21 with some fuzz, adds
     i/o watchdog timer, addressing both hardware (on some
     silicon) and software (suspected) irq lossage.

[2] ehci-0519 ... fixes some SMP-only problems.




--------------030704050202080901030808
Content-Type: text/plain;
 name="ehci-0429.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ehci-0429.patch"

--- 1.46/drivers/usb/host/ehci-hcd.c	Wed Mar 19 02:25:01 2003
+++ edited/drivers/usb/host/ehci-hcd.c	Thu Apr 24 13:28:01 2003
@@ -116,8 +116,10 @@
 #define	EHCI_TUNE_MULT_TT	1
 #define	EHCI_TUNE_FLS		2	/* (small) 256 frame schedule */
 
-#define EHCI_WATCHDOG_JIFFIES	(HZ/100)	/* arbitrary; ~10 msec */
+#define EHCI_IAA_JIFFIES	(HZ/100)	/* arbitrary; ~10 msec */
+#define EHCI_IO_JIFFIES		(HZ/10)		/* io watchdog > irq_thresh */
 #define EHCI_ASYNC_JIFFIES	(HZ/20)		/* async idle timeout */
+#define EHCI_SHRINK_JIFFIES	(HZ/200)	/* async qh unlink delay */
 
 /* Initial IRQ latency:  lower than default */
 static int log2_irq_thresh = 0;		// 0 to 6
@@ -266,16 +268,13 @@
 		}
 	}
 
+ 	/* stop async processing after it's idled a bit */
+	if (test_bit (TIMER_ASYNC_OFF, &ehci->actions))
+ 		start_unlink_async (ehci, ehci->async);
+
+	/* ehci could run by timer, without IRQs ... */
 	ehci_work (ehci, NULL);
-	if (ehci->reclaim && !timer_pending (&ehci->watchdog))
-		mod_timer (&ehci->watchdog,
-				jiffies + EHCI_WATCHDOG_JIFFIES);
 
- 	/* stop async processing after it's idled a while */
-	else if (ehci->async_idle) {
- 		start_unlink_async (ehci, ehci->async);
- 		ehci->async_idle = 0;
-	}
 	spin_unlock_irqrestore (&ehci->lock, flags);
 }
 
@@ -658,11 +657,18 @@
  */
 static void ehci_work (struct ehci_hcd *ehci, struct pt_regs *regs)
 {
+	timer_action_done (ehci, TIMER_IO_WATCHDOG);
 	if (ehci->reclaim_ready)
 		end_unlink_async (ehci, regs);
 	scan_async (ehci, regs);
 	if (ehci->next_uframe != -1)
 		scan_periodic (ehci, regs);
+
+	/* the IO watchdog guards against hardware or driver bugs that
+	 * misplace IRQs, and should let us run completely without IRQs.
+	 */
+	if ((ehci->async->qh_next.ptr != 0) || (ehci->periodic_sched != 0))
+		timer_action (ehci, TIMER_IO_WATCHDOG);
 }
 
 /*-------------------------------------------------------------------------*/
--- 1.44/drivers/usb/host/ehci-q.c	Mon Feb 24 03:30:38 2003
+++ edited/drivers/usb/host/ehci-q.c	Thu Apr 24 13:27:50 2003
@@ -704,8 +704,7 @@
 
 	/* (re)start the async schedule? */
 	head = ehci->async;
-	if (ehci->async_idle)
-		del_timer (&ehci->watchdog);
+	timer_action_done (ehci, TIMER_ASYNC_OFF);
 	if (!head->qh_next.qh) {
 		u32	cmd = readl (&ehci->regs->command);
 
@@ -731,8 +730,6 @@
 
 	qh->qh_state = QH_STATE_LINKED;
 	/* qtd completions reported later by interrupt */
-
-	ehci->async_idle = 0;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -914,7 +911,7 @@
 	struct ehci_qh		*qh = ehci->reclaim;
 	struct ehci_qh		*next;
 
-	del_timer (&ehci->watchdog);
+	timer_action_done (ehci, TIMER_IAA_WATCHDOG);
 
 	qh->hw_next = cpu_to_le32 (qh->qh_dma);
 	qh->qh_state = QH_STATE_IDLE;
@@ -939,12 +936,8 @@
 		 * active but idle for a while once it empties.
 		 */
 		if (HCD_IS_RUNNING (ehci->hcd.state)
-				&& ehci->async->qh_next.qh == 0
-				&& !timer_pending (&ehci->watchdog)) {
-			ehci->async_idle = 1;
-			mod_timer (&ehci->watchdog,
-					jiffies + EHCI_ASYNC_JIFFIES);
-		}
+				&& ehci->async->qh_next.qh == 0)
+			timer_action (ehci, TIMER_ASYNC_OFF);
 	}
 
 	if (next)
@@ -979,6 +972,7 @@
 			wmb ();
 			// handshake later, if we need to
 		}
+		timer_action_done (ehci, TIMER_ASYNC_OFF);
 		return;
 	} 
 
@@ -1004,9 +998,8 @@
 	ehci->reclaim_ready = 0;
 	cmd |= CMD_IAAD;
 	writel (cmd, &ehci->regs->command);
-	/* posted write need not be known to HC yet ... */
-
-	mod_timer (&ehci->watchdog, jiffies + EHCI_WATCHDOG_JIFFIES);
+	(void) readl (&ehci->regs->command);
+	timer_action (ehci, TIMER_IAA_WATCHDOG);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -1015,10 +1008,11 @@
 scan_async (struct ehci_hcd *ehci, struct pt_regs *regs)
 {
 	struct ehci_qh		*qh;
-	int			unlink_delay = 0;
+	enum ehci_timer_action	action = TIMER_IO_WATCHDOG;
 
 	if (!++(ehci->stamp))
 		ehci->stamp++;
+	timer_action_done (ehci, TIMER_ASYNC_SHRINK);
 rescan:
 	qh = ehci->async->qh_next.qh;
 	if (likely (qh != 0)) {
@@ -1050,17 +1044,14 @@
 			 */
 			if (list_empty (&qh->qtd_list)) {
 				if (qh->stamp == ehci->stamp)
-					unlink_delay = 1;
-				else if (!ehci->reclaim) {
+					action = TIMER_ASYNC_SHRINK;
+				else if (!ehci->reclaim)
 					start_unlink_async (ehci, qh);
-					unlink_delay = 0;
-				}
 			}
 
 			qh = qh->qh_next.qh;
 		} while (qh);
 	}
-
-	if (unlink_delay && !timer_pending (&ehci->watchdog))
-		mod_timer (&ehci->watchdog, jiffies + EHCI_WATCHDOG_JIFFIES/2);
+	if (action == TIMER_ASYNC_SHRINK)
+		timer_action (ehci, TIMER_ASYNC_SHRINK);
 }
--- 1.19/drivers/usb/host/ehci.h	Mon Feb 24 03:30:38 2003
+++ edited/drivers/usb/host/ehci.h	Thu Apr 24 13:29:02 2003
@@ -52,8 +52,7 @@
 	/* async schedule support */
 	struct ehci_qh		*async;
 	struct ehci_qh		*reclaim;
-	int			reclaim_ready : 1,
-				async_idle : 1;
+	int			reclaim_ready : 1;
 
 	/* periodic schedule support */
 #define	DEFAULT_I_TDPS		1024		/* some HCs can do less */
@@ -83,6 +82,7 @@
 
 	struct timer_list	watchdog;
 	struct notifier_block	reboot_notifier;
+	unsigned long		actions;
 	unsigned		stamp;
 
 	/* irq statistics */
@@ -99,6 +99,53 @@
 
 /* NOTE:  urb->transfer_flags expected to not use this bit !!! */
 #define EHCI_STATE_UNLINK	0x8000		/* urb being unlinked */
+
+enum ehci_timer_action {
+	TIMER_IO_WATCHDOG,
+	TIMER_IAA_WATCHDOG,
+	TIMER_ASYNC_SHRINK,
+	TIMER_ASYNC_OFF,
+};
+
+static inline void
+timer_action_done (struct ehci_hcd *ehci, enum ehci_timer_action action)
+{
+	clear_bit (action, &ehci->actions);
+}
+
+static inline void
+timer_action (struct ehci_hcd *ehci, enum ehci_timer_action action)
+{
+	if (!test_and_set_bit (action, &ehci->actions)) {
+		unsigned long t;
+
+		switch (action) {
+		case TIMER_IAA_WATCHDOG:
+			t = EHCI_IAA_JIFFIES;
+			break;
+		case TIMER_IO_WATCHDOG:
+			t = EHCI_IO_JIFFIES;
+			break;
+		case TIMER_ASYNC_OFF:
+			t = EHCI_ASYNC_JIFFIES;
+			break;
+		// case TIMER_ASYNC_SHRINK:
+		default:
+			t = EHCI_SHRINK_JIFFIES;
+			break;
+		}
+		t += jiffies;
+		// all timings except IAA watchdog can be overridden.
+		// async queue SHRINK often precedes IAA.  while it's ready
+		// to go OFF neither can matter, and afterwards the IO
+		// watchdog stops unless there's still periodic traffic.
+		if (action != TIMER_IAA_WATCHDOG
+				&& t > ehci->watchdog.expires
+				&& timer_pending (&ehci->watchdog))
+			return;
+		mod_timer (&ehci->watchdog, t);
+	}
+}
 
 /*-------------------------------------------------------------------------*/
 

--------------030704050202080901030808
Content-Type: text/plain;
 name="ehci-0519.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ehci-0519.patch"

--- 1.21/drivers/usb/host/ehci-q.c	Mon May 12 22:25:05 2003
+++ edited/ehci-q.c	Mon May 19 09:10:48 2003
@@ -958,11 +958,11 @@
 	qh->qh_state = QH_STATE_IDLE;
 	qh->qh_next.qh = 0;
 	qh_put (ehci, qh);			// refcount from reclaim 
-	ehci->reclaim = 0;
-	ehci->reclaim_ready = 0;
 
 	/* other unlink(s) may be pending (in QH_STATE_UNLINK_WAIT) */
 	next = qh->reclaim;
+	ehci->reclaim = next;
+	ehci->reclaim_ready = 0;
 	qh->reclaim = 0;
 
 	qh_completions (ehci, qh, regs);
@@ -981,8 +981,10 @@
 			timer_action (ehci, TIMER_ASYNC_OFF);
 	}
 
-	if (next)
+	if (next) {
+		ehci->reclaim = 0;
 		start_unlink_async (ehci, next);
+	}
 }
 
 /* makes sure the async qh will become idle */
@@ -1086,7 +1088,8 @@
 			if (list_empty (&qh->qtd_list)) {
 				if (qh->stamp == ehci->stamp)
 					action = TIMER_ASYNC_SHRINK;
-				else if (!ehci->reclaim)
+				else if (!ehci->reclaim
+					    && qh->qh_state == QH_STATE_LINKED)
 					start_unlink_async (ehci, qh);
 			}
 

--------------030704050202080901030808--

