Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbUCJHAS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 02:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUCJHAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 02:00:18 -0500
Received: from palrel13.hp.com ([156.153.255.238]:36996 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261454AbUCJG7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 01:59:38 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16462.48341.393442.583311@napali.hpl.hp.com>
Date: Tue, 9 Mar 2004 22:59:33 -0800
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Grant Grundler <iod00d@hp.com>,
       Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <404E2B98.6080901@pacbell.net>
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
	<16461.35657.188807.501072@napali.hpl.hp.com>
	<404E00B5.5060603@pacbell.net>
	<16462.1463.686711.622754@napali.hpl.hp.com>
	<404E2B98.6080901@pacbell.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 09 Mar 2004 12:39:52 -0800, David Brownell <david-b@pacbell.net> said:

  David.B> David Mosberger wrote:
  >>  > David Mosberger wrote: >> ...  add a new state >>

  >> ED_DESCHEDULED, which is treated exactly like ED_IDLE, except >>
  >> that in this state, the HC may still be referring to the ED in >>
  >> question.  Thus, if

  David.B> Sounds exactly like ED_UNLINK -- except maybe that it's not
  David.B> been put onto ed_rm_list (with ED_DEQUEUE set).  Why add
  David.B> another state?

  >>  So you can tell them apart.  See ohci_endpoint_disable().

  David.B> Not informative.  Why doesn't UNLINK work as-is?  If
  David.B> there's a bug in how that's handled, better to fix it.  I'd
  David.B> be willing to believe there is one, given proof.

The current OHCI relies on the internals of the dma_pool()
implementation.  If the implementation changed to, say, modify the
memory that is free or, heaven forbid, return the memory to the
kernel, you'd get _extremely_ difficult to track down race conditions.
Even so, the code isn't race-free, like I explained yesterday:

 - ed_alloc() clears the ED to 0 via memset()
 - the order in which memset() clears memory is undefined (various
   from platform to platform etc)
 - thus you might get a case where hwTailP is 0 but hwHeadP
   is non-zero, which would cause the HC to happily start
   dereferencing the descriptor

There are probably other potential issues. Frankly, I _don't_ want to
have to deal with this.  Especially considering that the alternative
costs virtually nothing, requires just a few source code changes, and
contains the EDs that are potentially still referenced by the HC to
the HC code itself.

  David.B> But some parts worry me.  Like changing that code to BUG()
  David.B> on a driver behavior that's perfectly reasonable;

I think the patch below incorporates your suggestions and fixes the
problems you pointed out.  In particular:

 - dropped debug printing
 - allow URB submission during ED_UNLINK again
 - add a big fat comment in ed_deschedule() why we must not update
   controlhead when the list goes empty (it's quite counter-intuitive
   to _not_ do it and I'm worried someone in the feature may want
   to "fix" this again...)

The rest should be the samae as yesterday.

The patch is still against 2.6.4-rc2 (and still contains your hwTailP
update fixes).

Please consider for inclusion.

	--david

===== drivers/usb/host/ohci-hcd.c 1.56 vs edited =====
--- 1.56/drivers/usb/host/ohci-hcd.c	Tue Mar  2 05:52:40 2004
+++ edited/drivers/usb/host/ohci-hcd.c	Tue Mar  9 22:29:08 2004
@@ -239,8 +239,8 @@
 		goto fail;
 	}
 
-	/* schedule the ed if needed */
-	if (ed->state == ED_IDLE) {
+	if (ed->state == ED_IDLE || ed->state == ED_DESCHEDULED) {
+		/* schedule the ed if needed */
 		retval = ed_schedule (ohci, ed);
 		if (retval < 0)
 			goto fail0;
@@ -347,6 +347,10 @@
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
+++ edited/drivers/usb/host/ohci-q.c	Tue Mar  9 22:27:04 2004
@@ -172,6 +172,7 @@
 	ed->ed_prev = 0;
 	ed->ed_next = 0;
 	ed->hwNextED = 0;
+	ed->hwINFO &= ~ED_SKIP;
 	wmb ();
 
 	/* we care about rm_list when setting CLE/BLE in case the HC was at
@@ -187,6 +188,8 @@
 	switch (ed->type) {
 	case PIPE_CONTROL:
 		if (ohci->ed_controltail == NULL) {
+			/* Writing of control-head is safe only if CLE is off. */
+			BUG_ON (ohci->hc_control & OHCI_CTRL_CLE);
 			writel (ed->dma, &ohci->regs->ed_controlhead);
 		} else {
 			ohci->ed_controltail->ed_next = ed;
@@ -203,6 +206,8 @@
 
 	case PIPE_BULK:
 		if (ohci->ed_bulktail == NULL) {
+			/* Writing of bulk-head is safe only if BLE is off. */
+			BUG_ON (ohci->hc_control & OHCI_CTRL_BLE);
 			writel (ed->dma, &ohci->regs->ed_bulkhead);
 		} else {
 			ohci->ed_bulktail->ed_next = ed;
@@ -267,10 +272,15 @@
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
 static void ed_deschedule (struct ohci_hcd *ohci, struct ed *ed) 
 {
@@ -278,20 +288,33 @@
 
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
-			}
-			writel (le32_to_cpup (&ed->hwNextED),
-				&ohci->regs->ed_controlhead);
+				/*
+				 * Caveat: even though the list is
+				 * empty now, we MUST NOT write 0 to
+				 * controlhead.  The OHCI spec is
+				 * ambiguous on this point (Figure 6-5
+				 * and Section 6.4.2.2 specify
+				 * conflicting behaviors), but there
+				 * are definitely HCs out there which
+				 * will happily try to process an ED
+				 * from address 0.  It's OK not to
+				 * update controlhead because we leave
+				 * the ED alive for long enough that
+				 * this is safe.
+				 */
+			} else
+				writel (le32_to_cpup (&ed->hwNextED),
+					&ohci->regs->ed_controlhead);
 		} else {
 			ed->ed_prev->ed_next = ed->ed_next;
 			ed->ed_prev->hwNextED = ed->hwNextED;
 		}
+		/* remove ED from the HCD's list: */
 		if (ohci->ed_controltail == ed) {
 			ohci->ed_controltail = ed->ed_prev;
 			if (ohci->ed_controltail)
@@ -302,20 +325,33 @@
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
-			}
-			writel (le32_to_cpup (&ed->hwNextED),
-				&ohci->regs->ed_bulkhead);
+				/*
+				 * Caveat: even though the list is
+				 * empty now, we MUST NOT write 0 to
+				 * bulkhead.  The OHCI spec is
+				 * ambiguous on this point (Figure 6-5
+				 * and Section 6.4.2.2 specify
+				 * conflicting behaviors), but there
+				 * are definitely HCs out there which
+				 * will happily try to process an ED
+				 * from address 0.  It's OK not to
+				 * update controlhead because we leave
+				 * the ED alive for long enough that
+				 * this is safe.
+				 */
+			} else
+				writel (le32_to_cpup (&ed->hwNextED),
+					&ohci->regs->ed_bulkhead);
 		} else {
 			ed->ed_prev->ed_next = ed->ed_next;
 			ed->ed_prev->hwNextED = ed->hwNextED;
 		}
+		/* remove ED from the HCD's list: */
 		if (ohci->ed_bulktail == ed) {
 			ohci->ed_bulktail = ed->ed_prev;
 			if (ohci->ed_bulktail)
@@ -331,6 +367,12 @@
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
 
 
@@ -387,7 +429,7 @@
 	/* NOTE: only ep0 currently needs this "re"init logic, during
 	 * enumeration (after set_address, or if ep0 maxpacket >8).
 	 */
-  	if (ed->state == ED_IDLE) {
+  	if (ed->state == ED_IDLE || ed->state == ED_DESCHEDULED) {
 		u32	info;
 
 		info = usb_pipedevice (pipe);
@@ -429,15 +471,35 @@
  */
 static void start_ed_unlink (struct ohci_hcd *ohci, struct ed *ed)
 {    
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
 
 	/* rm_list is just singly linked, for simplicity */
@@ -452,6 +514,7 @@
 		// flush those pci writes
 		(void) readl (&ohci->regs->control);
 	}
+	/* ??? What if HCD isn't running?  Shouldn't that be handled as well?  */
 }
 
 /*-------------------------------------------------------------------------*
@@ -614,6 +677,7 @@
 		info = TD_CC | TD_DP_SETUP | TD_T_DATA0;
 		td_fill (ohci, info, urb->setup_dma, 8, urb, cnt++);
 		if (data_len > 0) {
+			BUG_ON(data_len >= 4096);
 			info = TD_CC | TD_R | TD_T_DATA1;
 			info |= is_out ? TD_DP_OUT : TD_DP_IN;
 			/* NOTE:  mishandles transfers >8K, some >4K */
@@ -794,8 +858,6 @@
 		next->next_dl_td = rev;	
 		rev = next;
 
-		if (ed->hwTailP == cpu_to_le32 (next->td_dma))
-			ed->hwTailP = next->hwNextTD;
 		ed->hwHeadP = next->hwNextTD | toggle;
 	}
 
@@ -941,12 +1003,7 @@
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
 
@@ -957,7 +1014,7 @@
 			/* if URB is done, clean up */
 			if (urb_priv->td_cnt == urb_priv->length) {
 				modified = completed = 1;
-				finish_urb (ohci, urb, regs);
+				finish_urb (ohci, urb, regs);	/* this drops ohci->lock! */
 			}
 		}
 		if (completed && !list_empty (&ed->td_list))
@@ -1039,9 +1096,9 @@
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
 
