Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUCHV7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUCHV4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:56:54 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:460 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261232AbUCHVxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:53:35 -0500
Message-ID: <404CEA36.2000903@pacbell.net>
Date: Mon, 08 Mar 2004 13:48:38 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Grant Grundler <iod00d@hp.com>, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
References: <20031028013013.GA3991@kroah.com>	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>	<3FA12A2E.4090308@pacbell.net>	<16289.29015.81760.774530@napali.hpl.hp.com>	<16289.55171.278494.17172@napali.hpl.hp.com>	<3FA28C9A.5010608@pacbell.net>	<16457.12968.365287.561596@napali.hpl.hp.com>	<404959A5.6040809@pacbell.net>	<16457.26208.980359.82768@napali.hpl.hp.com>	<4049FE57.2060809@pacbell.net>	<20040308061802.GA25960@cup.hp.com> <16460.49761.482020.911821@napali.hpl.hp.com>
In-Reply-To: <16460.49761.482020.911821@napali.hpl.hp.com>
Content-Type: multipart/mixed;
 boundary="------------090608030203020501020502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090608030203020501020502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Mosberger wrote:

>  consistency = coherency + ordering

That's one of the things I meant when I said the docs weren't
quite there yet ... the dma_*() API docs don't address how
to achieve the ordering, or even mention that it's an issue.

Plus, there are definitions of coherency that include event
ordering; it's not clear which definition is intended.


Anyway, see the attached patch.  It goes on top of 2.6.4-bk2
and passes my unlink tests (the ones that haven't been run
much on recent kernels!) on several different OHCI hosts.

Other issues may be lurking, but this seems to fix a handful
of nasties that I could reproduce.

- Dave


--------------090608030203020501020502
Content-Type: text/plain;
 name="ohci-0308.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ohci-0308.patch"

Fixes for some recent OHCI instability.

    - Never munge ed->hwTailP once it's set up, except when appending
      to the queue.

    - Don't clear control/bulk "current ED" registers when taking
      entries off the queue.  The chip may still be using the value.

    - Revert part of previous bk1 patch, which removed a fast path
      that makes a visible difference in some common operations.
      Removing it just slowed timings, and didn't fix anything.

    - Make the "unlink during submit" path behave better (SMP).


--- 1.50/drivers/usb/host/ohci-q.c	Tue Mar  2 22:48:07 2004
+++ edited/drivers/usb/host/ohci-q.c	Mon Mar  8 13:15:08 2004
@@ -282,7 +282,6 @@
 			if (!ed->hwNextED) {
 				ohci->hc_control &= ~OHCI_CTRL_CLE;
 				writel (ohci->hc_control, &ohci->regs->control);
-				writel (0, &ohci->regs->ed_controlcurrent);
 				// post those pci writes
 				(void) readl (&ohci->regs->control);
 			}
@@ -306,7 +305,6 @@
 			if (!ed->hwNextED) {
 				ohci->hc_control &= ~OHCI_CTRL_BLE;
 				writel (ohci->hc_control, &ohci->regs->control);
-				writel (0, &ohci->regs->ed_bulkcurrent);
 				// post those pci writes
 				(void) readl (&ohci->regs->control);
 			}
@@ -331,6 +329,19 @@
 		periodic_unlink (ohci, ed);
 		break;
 	}
+
+	/* NOTE: Except for a couple of exceptionally clean unlink cases
+	 * (like unlinking the only c/b ED, with no TDs) HCs may still be
+	 * caching this operational ED (or its address).  Safe unlinking
+	 * involves not marking it ED_IDLE till INTR_SF; we always do that
+	 * if td_list isn't empty.  Otherwise the race is small; but ...
+	 */
+	if (ed->state == ED_OPER) {
+		ed->state = ED_IDLE;
+		ed->hwINFO &= ~(ED_SKIP | ED_DEQUEUE);
+		ed->hwHeadP &= ~ED_H;
+		wmb ();
+	}
 }
 
 
@@ -794,8 +805,6 @@
 		next->next_dl_td = rev;	
 		rev = next;
 
-		if (ed->hwTailP == cpu_to_le32 (next->td_dma))
-			ed->hwTailP = next->hwNextTD;
 		ed->hwHeadP = next->hwNextTD | toggle;
 	}
 
@@ -941,12 +950,7 @@
 				continue;
 			}
 
-			/* patch pointers hc uses ... tail, if we're removing
-			 * an otherwise active td, and whatever td pointer
-			 * points to this td
-			 */
-			if (ed->hwTailP == cpu_to_le32 (td->td_dma))
-				ed->hwTailP = td->hwNextTD;
+			/* patch pointer hc uses */
 			savebits = *prev & ~cpu_to_le32 (TD_MASK);
 			*prev = td->hwNextTD | savebits;
 
@@ -1041,7 +1045,7 @@
 
 		/* clean schedule:  unlink EDs that are no longer busy */
 		if (list_empty (&ed->td_list))
-			start_ed_unlink (ohci, ed);
+			ed_deschedule (ohci, ed);
 		/* ... reenabling halted EDs only after fault cleanup */
 		else if ((ed->hwINFO & (ED_SKIP | ED_DEQUEUE)) == ED_SKIP) {
 			td = list_entry (ed->td_list.next, struct td, td_list);
--- 1.57/drivers/usb/host/ohci-hcd.c	Tue Mar  2 22:48:07 2004
+++ edited/drivers/usb/host/ohci-hcd.c	Mon Mar  8 12:39:24 2004
@@ -233,7 +233,7 @@
 	spin_lock (&urb->lock);
 	if (urb->status != -EINPROGRESS) {
 		spin_unlock (&urb->lock);
-
+		urb->hcpriv = urb_priv;
 		finish_urb (ohci, urb, 0);
 		retval = 0;
 		goto fail;

--------------090608030203020501020502--


