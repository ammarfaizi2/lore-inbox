Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUCIJSe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 04:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbUCIJSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 04:18:33 -0500
Received: from palrel12.hp.com ([156.153.255.237]:20962 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261843AbUCIJP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 04:15:59 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16461.35657.188807.501072@napali.hpl.hp.com>
Date: Tue, 9 Mar 2004 01:15:53 -0800
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Grant Grundler <iod00d@hp.com>,
       Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <404CEA36.2000903@pacbell.net>
References: <20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
	<16289.29015.81760.774530@napali.hpl.hp.com>
	<16289.55171.278494.17172@napali.hpl.hp.com>
	<3FA28C9A.5010608@pacbell.net>
	<16457.12968.365287.561596@napali.hpl.hp.com>
	<404959A5.6040809@pacbell.net>
	<16457.26208.980359.82768@napali.hpl.hp.com>
	<4049FE57.2060809@pacbell.net>
	<20040308061802.GA25960@cup.hp.com>
	<16460.49761.482020.911821@napali.hpl.hp.com>
	<404CEA36.2000903@pacbell.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about something along the following lines?  The patch is relative
to 2.6.4-rc1.  What it does is add a new state ED_DESCHEDULED, which
is treated exactly like ED_IDLE, except that in this state, the HC may
still be referring to the ED in question.  Thus, if
ohci_endpoint_disable() finds an ED in this state, it will take it
down via start_ed_unlink() and once that is done, the ED will be in
ED_IDLE state and hence safe for removal (HC won't be referencing it
anymore).

I left some printk's for low-frequency events enabled, to give you a
better idea of how this is working.  Note that I removed the
posting of the PCI-writes in ed_deschedule().  I don't think those
are needed.  As far as I can see, a write-memory barrier at the
end of this routine should suffice.

With this patch applied:

 - My dual-CPU Itanium machine boots fine (doesn't hang anymore
   as with 2.6.4-rc1)

 - My home workstation (single CPU Itanium with 3 USB devices)
   now boots and works fine again.  Moreover, I don't see any
   USB keyboard/mouse disconnects anymore when doing heavy
   IDE traffic.

The BTC keyboard, however, still does NOT work.  I'm fairly certain
now that this is indeed a separate problem in the HID.  The reason
being that I'm now fairly comfortable with the OHCI HCD and if this
bug truly were in the OHCI HCD, then why does it trigger with UHCI as
well (I haven't tried EHCI yet; maybe I should try connecting the BTC
keyboard via a USB 2.0 hub).

Comments?

	--david

===== drivers/usb/host/ohci-hcd.c 1.56 vs edited =====
--- 1.56/drivers/usb/host/ohci-hcd.c	Tue Mar  2 05:52:40 2004
+++ edited/drivers/usb/host/ohci-hcd.c	Tue Mar  9 00:24:54 2004
@@ -239,8 +239,11 @@
 		goto fail;
 	}
 
-	/* schedule the ed if needed */
-	if (ed->state == ED_IDLE) {
+	if (ed->state == ED_UNLINK) {
+		printk("%s: ed %p being unlinked\n", __FUNCTION__, ed);
+		goto fail0;
+	} else if (ed->state == ED_IDLE || ed->state == ED_DESCHEDULED) {
+		/* schedule the ed if needed */
 		retval = ed_schedule (ohci, ed);
 		if (retval < 0)
 			goto fail0;
@@ -344,9 +347,15 @@
 	if (!ed)
 		goto done;
 
+	printk("%s(ed=%p, type=%d, state=%u)\n", __FUNCTION__, ed, ed->type, ed->state);
+
 	if (!HCD_IS_RUNNING (ohci->hcd.state))
 		ed->state = ED_IDLE;
 	switch (ed->state) {
+	case ED_DESCHEDULED:
+		start_ed_unlink (ohci, ed);
+		BUG_ON (ed->state != ED_UNLINK);
+		/* fall through */
 	case ED_UNLINK:		/* wait for hw to finish? */
 		/* major IRQ delivery trouble loses INTR_SF too... */
 		WARN_ON (limit-- == 0);
===== drivers/usb/host/ohci-q.c 1.48 vs edited =====
--- 1.48/drivers/usb/host/ohci-q.c	Tue Mar  2 05:52:46 2004
+++ edited/drivers/usb/host/ohci-q.c	Tue Mar  9 00:39:39 2004
@@ -168,10 +168,16 @@
 {	 
 	int	branch;
 
+#if 0
+printk("%s: ed=%p type=%d\n", __FUNCTION__, ed, ed->type);
+#endif
 	ed->state = ED_OPER;
 	ed->ed_prev = 0;
 	ed->ed_next = 0;
 	ed->hwNextED = 0;
+	ed->hwINFO &= ~ED_SKIP;
+	WARN_ON (ed->hwHeadP & ED_H);
+	ed->hwHeadP &= ~ED_H;	/* XXX is this really needed?? --davidm */
 	wmb ();
 
 	/* we care about rm_list when setting CLE/BLE in case the HC was at
@@ -267,24 +273,30 @@
 		ed, ed->branch, ed->load, ed->interval);
 }
 
-/* unlink an ed from one of the HC chains. 
+/* Deschedule an ed from one of the HC chains.
  * just the link to the ed is unlinked.
  * the link from the ed still points to another operational ed or 0
- * so the HC can eventually finish the processing of the unlinked ed
+ * so the HC can eventually finish the processing of the unlinked ed.
+ * The ED isn't idle after returning from this routine, because the HC
+ * may continue to refer to it, but as far as the HCD is concerned,
+ * the ED is reusable.  If it is necessary to get the ED into the
+ * ED_IDLE state, the full unlink-sequence needs to be performed
+ * (via start_ed_unlink()).
  */
-static void ed_deschedule (struct ohci_hcd *ohci, struct ed *ed) 
+static void ed_deschedule (struct ohci_hcd *ohci, struct ed *ed)
 {
+#if 0
+printk("%s: ed=%p type=%d\n", __FUNCTION__, ed, ed->type);
+#endif
 	ed->hwINFO |= ED_SKIP;
 
 	switch (ed->type) {
 	case PIPE_CONTROL:
+		/* remove ED from the HC's list: */
 		if (ed->ed_prev == NULL) {
 			if (!ed->hwNextED) {
 				ohci->hc_control &= ~OHCI_CTRL_CLE;
 				writel (ohci->hc_control, &ohci->regs->control);
-				writel (0, &ohci->regs->ed_controlcurrent);
-				// post those pci writes
-				(void) readl (&ohci->regs->control);
 			}
 			writel (le32_to_cpup (&ed->hwNextED),
 				&ohci->regs->ed_controlhead);
@@ -292,6 +304,7 @@
 			ed->ed_prev->ed_next = ed->ed_next;
 			ed->ed_prev->hwNextED = ed->hwNextED;
 		}
+		/* remove ED from the HCD's list: */
 		if (ohci->ed_controltail == ed) {
 			ohci->ed_controltail = ed->ed_prev;
 			if (ohci->ed_controltail)
@@ -302,13 +315,11 @@
 		break;
 
 	case PIPE_BULK:
+		/* remove ED from the singly-linked HC's list: */
 		if (ed->ed_prev == NULL) {
 			if (!ed->hwNextED) {
 				ohci->hc_control &= ~OHCI_CTRL_BLE;
 				writel (ohci->hc_control, &ohci->regs->control);
-				writel (0, &ohci->regs->ed_bulkcurrent);
-				// post those pci writes
-				(void) readl (&ohci->regs->control);
 			}
 			writel (le32_to_cpup (&ed->hwNextED),
 				&ohci->regs->ed_bulkhead);
@@ -316,6 +327,7 @@
 			ed->ed_prev->ed_next = ed->ed_next;
 			ed->ed_prev->hwNextED = ed->hwNextED;
 		}
+		/* remove ED from the HCD's list: */
 		if (ohci->ed_bulktail == ed) {
 			ohci->ed_bulktail = ed->ed_prev;
 			if (ohci->ed_bulktail)
@@ -331,6 +343,12 @@
 		periodic_unlink (ohci, ed);
 		break;
 	}
+	ed->state = ED_DESCHEDULED;
+	/*
+	 * Ensure HCD sees these updates (in particular update of
+	 * hwINFO) before any following updates.
+	 */
+	wmb ();
 }
 
 
@@ -387,7 +405,7 @@
 	/* NOTE: only ep0 currently needs this "re"init logic, during
 	 * enumeration (after set_address, or if ep0 maxpacket >8).
 	 */
-  	if (ed->state == ED_IDLE) {
+  	if (ed->state == ED_IDLE || ed->state == ED_DESCHEDULED) {
 		u32	info;
 
 		info = usb_pipedevice (pipe);
@@ -418,6 +436,9 @@
 
 done:
 	spin_unlock_irqrestore (&ohci->lock, flags);
+#if 0
+printk("new ed %p: type=%u state=%u hwTailP=%x hwHeadP=%x\n", ed, ed->type, ed->state, ed->hwTailP, ed->hwHeadP);
+#endif
 	return ed; 
 }
 
@@ -428,17 +449,38 @@
  * real work is done at the next start frame (SF) hardware interrupt
  */
 static void start_ed_unlink (struct ohci_hcd *ohci, struct ed *ed)
-{    
+{
+	u32 mask = 0;
+
+	/* deschedule ED as far as the HCD is concerned: */
+	ed_deschedule (ohci, ed);
+
+	/* now initiate the unlink sequence to ensure the HC isn't using the ED anymore: */
+	if (ed->type == PIPE_CONTROL)
+		mask = OHCI_CTRL_CLE;
+	else if (ed->type == PIPE_BULK)
+		mask = OHCI_CTRL_BLE;
+	if (mask) {
+		/*
+		 * Disable scanning of the control or bulk list; this
+		 * ensures that when we get an interrupt with a frame
+		 * # greater than the current frame #, the HC isn't
+		 * using the list anymore.
+		 */
+		ohci->hc_control &= ~mask;
+		writel (ohci->hc_control, &ohci->regs->control);
+	}
 	ed->hwINFO |= ED_DEQUEUE;
 	ed->state = ED_UNLINK;
-	ed_deschedule (ohci, ed);
 
 	/* SF interrupt might get delayed; record the frame counter value that
 	 * indicates when the HC isn't looking at it, so concurrent unlinks
 	 * behave.  frame_no wraps every 2^16 msec, and changes right before
 	 * SF is triggered.
 	 */
+	rmb();	/* ensure ed_deschedule() work is done before we read the frame # */
 	ed->tick = OHCI_FRAME_NO(ohci->hcca) + 1;
+printk("%s: ed=%p tick=%u\n", __FUNCTION__, ed, ed->tick);
 
 	/* rm_list is just singly linked, for simplicity */
 	ed->ed_next = ohci->ed_rm_list;
@@ -452,6 +494,7 @@
 		// flush those pci writes
 		(void) readl (&ohci->regs->control);
 	}
+	/* ??? What if HCD isn't running?  Shouldn't that be handled as well?  */
 }
 
 /*-------------------------------------------------------------------------*
@@ -614,6 +657,7 @@
 		info = TD_CC | TD_DP_SETUP | TD_T_DATA0;
 		td_fill (ohci, info, urb->setup_dma, 8, urb, cnt++);
 		if (data_len > 0) {
+			BUG_ON(data_len >= 4096);
 			info = TD_CC | TD_R | TD_T_DATA1;
 			info |= is_out ? TD_DP_OUT : TD_DP_IN;
 			/* NOTE:  mishandles transfers >8K, some >4K */
@@ -758,6 +802,7 @@
 	struct list_head	*tmp = td->td_list.next;
 	u32			toggle = ed->hwHeadP & ED_C;
 
+printk("%s: ed=%p\n", __FUNCTION__, ed);
 	/* clear ed halt; this is the td that caused it, but keep it inactive
 	 * until its urb->complete() has a chance to clean up.
 	 */
@@ -794,8 +839,6 @@
 		next->next_dl_td = rev;	
 		rev = next;
 
-		if (ed->hwTailP == cpu_to_le32 (next->td_dma))
-			ed->hwTailP = next->hwNextTD;
 		ed->hwHeadP = next->hwNextTD | toggle;
 	}
 
@@ -881,6 +924,7 @@
 {
 	struct ed	*ed, **last;
 
+printk("%s(tick=%u)\n", __FUNCTION__, tick);
 rescan_all:
 	for (last = &ohci->ed_rm_list, ed = *last; ed != NULL; ed = *last) {
 		struct list_head	*entry, *tmp;
@@ -941,12 +985,7 @@
 				continue;
 			}
 
-			/* patch pointers hc uses ... tail, if we're removing
-			 * an otherwise active td, and whatever td pointer
-			 * points to this td
-			 */
-			if (ed->hwTailP == cpu_to_le32 (td->td_dma))
-				ed->hwTailP = td->hwNextTD;
+			/* patch pointers hc uses  */
 			savebits = *prev & ~cpu_to_le32 (TD_MASK);
 			*prev = td->hwNextTD | savebits;
 
@@ -957,23 +996,22 @@
 			/* if URB is done, clean up */
 			if (urb_priv->td_cnt == urb_priv->length) {
 				modified = completed = 1;
-				finish_urb (ohci, urb, regs);
+				finish_urb (ohci, urb, regs);	/* this drops ohci->lock! */
 			}
 		}
 		if (completed && !list_empty (&ed->td_list))
 			goto rescan_this;
 
 		/* ED's now officially unlinked, hc doesn't see */
+#if 1
+printk("%s: done with ed %p\n", __FUNCTION__, ed);
+#endif
 		ed->state = ED_IDLE;
 		ed->hwINFO &= ~(ED_SKIP | ED_DEQUEUE);
 		ed->hwHeadP &= ~ED_H;
 		ed->hwNextED = 0;
 
-		/* but if there's work queued, reschedule */
-		if (!list_empty (&ed->td_list)) {
-			if (HCD_IS_RUNNING(ohci->hcd.state))
-				ed_schedule (ohci, ed);
-		}
+		BUG_ON (!list_empty (&ed->td_list));
 
 		if (modified)
 			goto rescan_all;
@@ -1039,9 +1077,9 @@
   		if (urb_priv->td_cnt == urb_priv->length)
   			finish_urb (ohci, urb, regs);
 
-		/* clean schedule:  unlink EDs that are no longer busy */
+		/* clean schedule:  deschedule EDs that are no longer busy */
 		if (list_empty (&ed->td_list))
-			start_ed_unlink (ohci, ed);
+			ed_deschedule (ohci, ed);
 		/* ... reenabling halted EDs only after fault cleanup */
 		else if ((ed->hwINFO & (ED_SKIP | ED_DEQUEUE)) == ED_SKIP) {
 			td = list_entry (ed->td_list.next, struct td, td_list);
===== drivers/usb/host/ohci.h 1.19 vs edited =====
--- 1.19/drivers/usb/host/ohci.h	Wed Feb 11 03:42:39 2004
+++ edited/drivers/usb/host/ohci.h	Mon Mar  8 23:03:31 2004
@@ -48,6 +48,7 @@
 #define ED_IDLE 	0x00		/* NOT linked to HC */
 #define ED_UNLINK 	0x01		/* being unlinked from hc */
 #define ED_OPER		0x02		/* IS linked to hc */
+#define ED_DESCHEDULED	0x03		/* idle for HCD, but HC may still hold reference to it */
 
 	u8			type; 		/* PIPE_{BULK,...} */
 
