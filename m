Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbTFMUDW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 16:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbTFMUDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 16:03:22 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:18333 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP id S265514AbTFMUDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 16:03:07 -0400
Date: Fri, 13 Jun 2003 13:19:33 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: USB 2.0 with 250Gb disk and insane loads
In-reply-to: <3EDA0E5D.8080404@pacbell.net>
To: alexh@ihatent.com
Cc: linux-kernel@vger.kernel.org
Message-id: <3EEA31D5.7060202@pacbell.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_u0uyXJlZ7XObNDGKByWiNA)"
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
References: <3EDA0E5D.8080404@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_u0uyXJlZ7XObNDGKByWiNA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

>> I'm trying to nail own a problem here, with my shiny new Maxtor 250Gb
>> USB 2.0 disk. Under 2.4 (vanilla, latest 21-preX and 21-preX-acY) the
>> disk will mount and talk nicely. As soon as any load hits it, e.g. a
>> single cp from my internal CD-ROM to the disk, the mahcine load will
>> sky-rocket and at some point within a few minuter hang the machine.

Here's a combined 2.4.21-rc8 patch, which includes:

  - two patches waiting for 2.4.22-pre ("i/o watchdog"
    and "SMP fixes"), as posted earlier;

  - another one, recently circulated for 2.5 ("short reads"
    and cleanup);

  - a bugfix for a hang that 2.4 + usb-storage seemed
    particularly ready to trigger.

I was able to reproduce a load+hang issue without this
patch; add the patch, the problem goes away and 2.4 acts
just as nicely (but not as quickly) as 2.5.

Please give it a try.

- Dave


--Boundary_(ID_u0uyXJlZ7XObNDGKByWiNA)
Content-type: text/plain; name=ehci24-0613.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=ehci24-0613.patch

--- 1.8/drivers/usb/host/ehci-dbg.c	Wed Mar 19 02:25:01 2003
+++ edited/drivers/usb/host/ehci-dbg.c	Thu Jun 12 11:17:57 2003
@@ -125,19 +125,28 @@
 #ifdef	DEBUG
 
 static void __attribute__((__unused__))
+dbg_qtd (char *label, struct ehci_hcd *ehci, struct ehci_qtd *qtd)
+{
+	ehci_dbg (ehci, "%s td %p n%08x %08x t%08x p0=%08x\n", label, qtd,
+		cpu_to_le32p (&qtd->hw_next),
+		cpu_to_le32p (&qtd->hw_alt_next),
+		cpu_to_le32p (&qtd->hw_token),
+		cpu_to_le32p (&qtd->hw_buf [0]));
+	if (qtd->hw_buf [1])
+		ehci_dbg (ehci, "  p1=%08x p2=%08x p3=%08x p4=%08x\n",
+			cpu_to_le32p (&qtd->hw_buf [1]),
+			cpu_to_le32p (&qtd->hw_buf [2]),
+			cpu_to_le32p (&qtd->hw_buf [3]),
+			cpu_to_le32p (&qtd->hw_buf [4]));
+}
+
+static void __attribute__((__unused__))
 dbg_qh (char *label, struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
-	dbg ("%s %p n%08x info1 %x info2 %x hw_curr %x qtd_next %x", label,
+	ehci_dbg (ehci, "%s qh %p n%08x info %x %x qtd %x\n", label,
 		qh, qh->hw_next, qh->hw_info1, qh->hw_info2,
-		qh->hw_current, qh->hw_qtd_next);
-	dbg ("  alt+nak+t= %x, token= %x, page0= %x, page1= %x",
-		qh->hw_alt_next, qh->hw_token,
-		qh->hw_buf [0], qh->hw_buf [1]);
-	if (qh->hw_buf [2]) {
-		dbg ("  page2= %x, page3= %x, page4= %x",
-			qh->hw_buf [2], qh->hw_buf [3],
-			qh->hw_buf [4]);
-	}
+		qh->hw_current);
+	dbg_qtd ("overlay", ehci, (struct ehci_qtd *) &qh->hw_qtd_next);
 }
 
 static int __attribute__((__unused__))
@@ -294,8 +303,7 @@
 		return '*';
 	if (token & QTD_STS_HALT)
 		return '-';
-	if (QTD_PID (token) != 1 /* not IN: OUT or SETUP */
-			|| QTD_LENGTH (token) == 0)
+	if (!IS_SHORT_READ (token))
 		return ' ';
 	/* tries to advance through hw_alt_next */
 	return '/';
@@ -317,11 +325,14 @@
 	char			*next = *nextp;
 	char			mark;
 
-	mark = token_mark (qh->hw_token);
+	if (qh->hw_qtd_next == EHCI_LIST_END)	/* NEC does this */
+		mark = '@';
+	else
+		mark = token_mark (qh->hw_token);
 	if (mark == '/') {	/* qh_alt_next controls qh advance? */
 		if ((qh->hw_alt_next & QTD_MASK) == ehci->async->hw_alt_next)
 			mark = '#';	/* blocked */
-		else if (qh->hw_alt_next & cpu_to_le32 (0x01))
+		else if (qh->hw_alt_next == EHCI_LIST_END)
 			mark = '.';	/* use hw_qtd_next */
 		/* else alt_next points to some other qtd */
 	}
@@ -334,7 +345,7 @@
 			(scratch >> 8) & 0x000f,
 			scratch, cpu_to_le32p (&qh->hw_info2),
 			cpu_to_le32p (&qh->hw_token), mark,
-			(cpu_to_le32 (0x8000000) & qh->hw_token)
+			(__constant_cpu_to_le32 (QTD_TOGGLE) & qh->hw_token)
 				? "data0" : "data1",
 			(cpu_to_le32p (&qh->hw_alt_next) >> 1) & 0x0f);
 	size -= temp;
@@ -400,6 +411,8 @@
 	char			*next;
 	struct ehci_qh		*qh;
 
+	*buf = 0;
+
 	pdev = container_of (dev, struct pci_dev, dev);
 	ehci = container_of (pci_get_drvdata (pdev), struct ehci_hcd, hcd);
 	next = buf;
@@ -422,7 +435,7 @@
 	}
 	spin_unlock_irqrestore (&ehci->lock, flags);
 
-	return PAGE_SIZE - size;
+	return strlen (buf);
 }
 static DEVICE_ATTR (async, S_IRUGO, show_async, NULL);
 
@@ -558,7 +571,8 @@
 	/* Capability Registers */
 	i = readw (&ehci->caps->hci_version);
 	temp = snprintf (next, size,
-		"EHCI %x.%02x, hcd state %d (version " DRIVER_VERSION ")\n",
+		"%s\nEHCI %x.%02x, hcd state %d (driver " DRIVER_VERSION ")\n",
+		pdev->dev.name,
 		i >> 8, i & 0x0ff, ehci->hcd.state);
 	size -= temp;
 	next += temp;
--- 1.12/drivers/usb/host/ehci-hcd.c	Wed Mar 19 02:25:01 2003
+++ edited/drivers/usb/host/ehci-hcd.c	Thu Jun 12 11:17:57 2003
@@ -31,6 +31,7 @@
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
+#include <linux/bitops.h> /* for generic_ffs */
 
 #ifdef CONFIG_USB_DEBUG
 	#define DEBUG
@@ -41,11 +42,7 @@
 #include <linux/usb.h>
 
 #include <linux/version.h>
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,32)
 #include "../hcd.h"
-#else
-#include "../core/hcd.h"
-#endif
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -94,11 +91,11 @@
  * 2001-June	Works with usb-storage and NEC EHCI on 2.4
  */
 
-#define DRIVER_VERSION "2003-Jan-22"
+#define DRIVER_VERSION "2003-Jun-12/2.4"
 #define DRIVER_AUTHOR "David Brownell"
 #define DRIVER_DESC "USB 2.0 'Enhanced' Host Controller (EHCI) Driver"
 
-static const char	hcd_name [] = "ehci-hcd";
+static const char	hcd_name [] = "ehci_hcd";
 
 
 // #define EHCI_VERBOSE_DEBUG
@@ -118,8 +115,10 @@
 #define	EHCI_TUNE_MULT_TT	1
 #define	EHCI_TUNE_FLS		2	/* (small) 256 frame schedule */
 
-#define EHCI_WATCHDOG_JIFFIES	(HZ/100)	/* arbitrary; ~10 msec */
+#define EHCI_IAA_JIFFIES	(HZ/100)	/* arbitrary; ~10 msec */
+#define EHCI_IO_JIFFIES		(HZ/10)		/* io watchdog > irq_thresh */
 #define EHCI_ASYNC_JIFFIES	(HZ/20)		/* async idle timeout */
+#define EHCI_SHRINK_JIFFIES	(HZ/200)	/* async qh unlink delay */
 
 /* Initial IRQ latency:  lower than default */
 static int log2_irq_thresh = 0;		// 0 to 6
@@ -268,16 +267,13 @@
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
 
@@ -660,11 +656,18 @@
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
@@ -1039,8 +1042,8 @@
 
 static int __init init (void) 
 {
-	dbg (DRIVER_INFO);
-	dbg ("block sizes: qh %Zd qtd %Zd itd %Zd sitd %Zd",
+	pr_debug ("%s: block sizes: qh %Zd qtd %Zd itd %Zd sitd %Zd\n",
+		hcd_name,
 		sizeof (struct ehci_qh), sizeof (struct ehci_qtd),
 		sizeof (struct ehci_itd), sizeof (struct ehci_sitd));
 
--- 1.13/drivers/usb/host/ehci-q.c	Tue Apr  1 12:23:15 2003
+++ edited/drivers/usb/host/ehci-q.c	Fri Jun 13 12:25:08 2003
@@ -88,7 +88,6 @@
 static inline void
 qh_update (struct ehci_hcd *ehci, struct ehci_qh *qh, struct ehci_qtd *qtd)
 {
-	qh->hw_current = 0;
 	qh->hw_qtd_next = QTD_NEXT (qtd->qtd_dma);
 	qh->hw_alt_next = EHCI_LIST_END;
 
@@ -99,8 +98,6 @@
 
 /*-------------------------------------------------------------------------*/
 
-#define IS_SHORT_READ(token) (QTD_LENGTH (token) != 0 && QTD_PID (token) == 1)
-
 static void qtd_copy_status (
 	struct ehci_hcd *ehci,
 	struct urb *urb,
@@ -314,16 +311,15 @@
 		/* hardware copies qtd out of qh overlay */
 		rmb ();
 		token = le32_to_cpu (qtd->hw_token);
-		stopped = stopped
-			|| (HALT_BIT & qh->hw_token) != 0
-			|| (ehci->hcd.state == USB_STATE_HALT);
 
 		/* always clean up qtds the hc de-activated */
 		if ((token & QTD_STS_ACTIVE) == 0) {
 
-			/* magic dummy for short reads; won't advance */
-			if (IS_SHORT_READ (token)
-					&& !(token & QTD_STS_HALT)
+			if ((token & QTD_STS_HALT) != 0) {
+				stopped = 1;
+
+			/* magic dummy for some short reads; qh won't advance */
+			} else if (IS_SHORT_READ (token)
 					&& (qh->hw_alt_next & QTD_MASK)
 						== ehci->async->hw_alt_next) {
 				stopped = 1;
@@ -331,10 +327,13 @@
 			}
 
 		/* stop scanning when we reach qtds the hc is using */
-		} else if (likely (!stopped)) {
+		} else if (likely (!stopped
+				|| HCD_IS_RUNNING (ehci->hcd.state))) {
 			break;
 
 		} else {
+			stopped = 1;
+
 			/* ignore active urbs unless some previous qtd
 			 * for the urb faulted (including short read) or
 			 * its urb was canceled.  we may patch qh or qtds.
@@ -393,12 +392,20 @@
 	qh->qh_state = state;
 
 	/* update qh after fault cleanup */
-	if (unlikely ((HALT_BIT & qh->hw_token) != 0)) {
-		qh_update (ehci, qh,
-			list_empty (&qh->qtd_list)
-				? qh->dummy
-				: list_entry (qh->qtd_list.next,
-					struct ehci_qtd, qtd_list));
+	if (unlikely (stopped != 0)
+			/* some EHCI 0.95 impls will overlay dummy qtds */ 
+			|| qh->hw_qtd_next == EHCI_LIST_END) {
+		if (list_empty (&qh->qtd_list))
+			end = qh->dummy;
+		else {
+			end = list_entry (qh->qtd_list.next,
+					struct ehci_qtd, qtd_list);
+			/* first qtd may already be partially processed */
+			if (cpu_to_le32 (end->qtd_dma) == qh->hw_current)
+				end = 0;
+		}
+		if (end)
+			qh_update (ehci, qh, end);
 	}
 
 	return count;
@@ -741,8 +748,7 @@
 
 	/* (re)start the async schedule? */
 	head = ehci->async;
-	if (ehci->async_idle)
-		del_timer (&ehci->watchdog);
+	timer_action_done (ehci, TIMER_ASYNC_OFF);
 	if (!head->qh_next.qh) {
 		u32	cmd = readl (&ehci->regs->command);
 
@@ -773,8 +779,6 @@
 
 	qh->qh_state = QH_STATE_LINKED;
 	/* qtd completions reported later by interrupt */
-
-	ehci->async_idle = 0;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -831,9 +835,8 @@
 			}
 		}
 
-		/* FIXME:  changing config or interface setting is not
-		 * supported yet.  preferred fix is for usbcore to tell
-		 * us to clear out each endpoint's state, but...
+		/* NOTE:  changing config or interface setting is not
+		 * supported without the 2.5 endpoint disable logic.
 		 */
 
 		/* usb_clear_halt() means qh data toggle gets reset */
@@ -955,17 +958,17 @@
 	struct ehci_qh		*qh = ehci->reclaim;
 	struct ehci_qh		*next;
 
-	del_timer (&ehci->watchdog);
+	timer_action_done (ehci, TIMER_IAA_WATCHDOG);
 
 	// qh->hw_next = cpu_to_le32 (qh->qh_dma);
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
@@ -980,16 +983,14 @@
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
 
-	if (next)
+	if (next) {
+		ehci->reclaim = 0;
 		start_unlink_async (ehci, next);
+	}
 }
 
 /* makes sure the async qh will become idle */
@@ -1020,6 +1021,7 @@
 			wmb ();
 			// handshake later, if we need to
 		}
+		timer_action_done (ehci, TIMER_ASYNC_OFF);
 		return;
 	} 
 
@@ -1045,9 +1047,8 @@
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
@@ -1056,10 +1057,11 @@
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
@@ -1091,17 +1093,15 @@
 			 */
 			if (list_empty (&qh->qtd_list)) {
 				if (qh->stamp == ehci->stamp)
-					unlink_delay = 1;
-				else if (!ehci->reclaim) {
+					action = TIMER_ASYNC_SHRINK;
+				else if (!ehci->reclaim
+					    && qh->qh_state == QH_STATE_LINKED)
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
--- 1.7/drivers/usb/host/ehci.h	Mon Mar  3 03:33:58 2003
+++ edited/drivers/usb/host/ehci.h	Thu Jun 12 11:17:57 2003
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
@@ -100,6 +100,53 @@
 /* NOTE:  urb->transfer_flags expected to not use this bit !!! */
 #define EHCI_STATE_UNLINK	0x8000		/* urb being unlinked */
 
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
+
 /*-------------------------------------------------------------------------*/
 
 /* EHCI register interface, corresponds to EHCI Revision 0.95 specification */
@@ -243,7 +290,10 @@
 	size_t			length;			/* length of buffer */
 } __attribute__ ((aligned (32)));
 
-#define QTD_MASK cpu_to_le32 (~0x1f)	/* mask NakCnt+T in qh->hw_alt_next */
+/* mask NakCnt+T in qh->hw_alt_next */
+#define QTD_MASK __constant_cpu_to_le32 (~0x1f)
+
+#define IS_SHORT_READ(token) (QTD_LENGTH (token) != 0 && QTD_PID (token) == 1)
 
 /*-------------------------------------------------------------------------*/
 

--Boundary_(ID_u0uyXJlZ7XObNDGKByWiNA)--
