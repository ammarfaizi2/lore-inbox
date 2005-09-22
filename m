Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbVIVHuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbVIVHuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbVIVHun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:50:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:40115 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751450AbVIVHu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:50:29 -0400
Date: Thu, 22 Sep 2005 00:49:51 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       stern@rowland.harvard.edu
Subject: [patch 18/18] USB: Update Documentation/usb/URB.txt
Message-ID: <20050922074950.GS15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-update-urb.txt.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch (as564) updates Documentation/usb/URB.txt, bringing it roughly 
up to the current level.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/usb/URB.txt |   76 +++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

--- scsi-2.6.orig/Documentation/usb/URB.txt	2005-09-20 05:59:35.000000000 -0700
+++ scsi-2.6/Documentation/usb/URB.txt	2005-09-21 17:29:56.000000000 -0700
@@ -1,5 +1,6 @@
 Revised: 2000-Dec-05.
 Again:   2002-Jul-06
+Again:   2005-Sep-19
 
     NOTE:
 
@@ -18,8 +19,8 @@
   and deliver the data and status back. 
 
 - Execution of an URB is inherently an asynchronous operation, i.e. the 
-  usb_submit_urb(urb) call returns immediately after it has successfully queued 
-  the requested action. 
+  usb_submit_urb(urb) call returns immediately after it has successfully
+  queued the requested action.
 
 - Transfers for one URB can be canceled with usb_unlink_urb(urb) at any time. 
 
@@ -94,8 +95,9 @@
 
 	void usb_free_urb(struct urb *urb)
 
-You may not free an urb that you've submitted, but which hasn't yet been
-returned to you in a completion callback.
+You may free an urb that you've submitted, but which hasn't yet been
+returned to you in a completion callback.  It will automatically be
+deallocated when it is no longer in use.
 
 
 1.4. What has to be filled in?
@@ -145,30 +147,36 @@
 
 1.6. How to cancel an already running URB?
 
-For an URB which you've submitted, but which hasn't been returned to
-your driver by the host controller, call
+There are two ways to cancel an URB you've submitted but which hasn't
+been returned to your driver yet.  For an asynchronous cancel, call
 
 	int usb_unlink_urb(struct urb *urb)
 
 It removes the urb from the internal list and frees all allocated
-HW descriptors. The status is changed to reflect unlinking. After 
-usb_unlink_urb() returns with that status code, you can free the URB
-with usb_free_urb().
-
-There is also an asynchronous unlink mode.  To use this, set the
-the URB_ASYNC_UNLINK flag in urb->transfer flags before calling
-usb_unlink_urb().  When using async unlinking, the URB will not
-normally be unlinked when usb_unlink_urb() returns.  Instead, wait
-for the completion handler to be called.
+HW descriptors. The status is changed to reflect unlinking.  Note
+that the URB will not normally have finished when usb_unlink_urb()
+returns; you must still wait for the completion handler to be called.
+
+To cancel an URB synchronously, call
+
+	void usb_kill_urb(struct urb *urb)
+
+It does everything usb_unlink_urb does, and in addition it waits
+until after the URB has been returned and the completion handler
+has finished.  It also marks the URB as temporarily unusable, so
+that if the completion handler or anyone else tries to resubmit it
+they will get a -EPERM error.  Thus you can be sure that when
+usb_kill_urb() returns, the URB is totally idle.
 
 
 1.7. What about the completion handler?
 
 The handler is of the following type:
 
-	typedef void (*usb_complete_t)(struct urb *);
+	typedef void (*usb_complete_t)(struct urb *, struct pt_regs *)
 
-i.e. it gets just the URB that caused the completion call.
+I.e., it gets the URB that caused the completion call, plus the
+register values at the time of the corresponding interrupt (if any).
 In the completion handler, you should have a look at urb->status to
 detect any USB errors. Since the context parameter is included in the URB,
 you can pass information to the completion handler. 
@@ -176,17 +184,11 @@
 Note that even when an error (or unlink) is reported, data may have been
 transferred.  That's because USB transfers are packetized; it might take
 sixteen packets to transfer your 1KByte buffer, and ten of them might
-have transferred succesfully before the completion is called.
+have transferred succesfully before the completion was called.
 
 
 NOTE:  ***** WARNING *****
-Don't use urb->dev field in your completion handler; it's cleared
-as part of giving urbs back to drivers.  (Addressing an issue with
-ownership of periodic URBs, which was otherwise ambiguous.) Instead,
-use urb->context to hold all the data your driver needs.
-
-NOTE:  ***** WARNING *****
-Also, NEVER SLEEP IN A COMPLETION HANDLER.  These are normally called
+NEVER SLEEP IN A COMPLETION HANDLER.  These are normally called
 during hardware interrupt processing.  If you can, defer substantial
 work to a tasklet (bottom half) to keep system latencies low.  You'll
 probably need to use spinlocks to protect data structures you manipulate
@@ -229,24 +231,10 @@
 Interrupt transfers, like isochronous transfers, are periodic, and happen
 in intervals that are powers of two (1, 2, 4 etc) units.  Units are frames
 for full and low speed devices, and microframes for high speed ones.
-
-Currently, after you submit one interrupt URB, that urb is owned by the
-host controller driver until you cancel it with usb_unlink_urb().  You
-may unlink interrupt urbs in their completion handlers, if you need to.
-
-After a transfer completion is called, the URB is automagically resubmitted.
-THIS BEHAVIOR IS EXPECTED TO BE REMOVED!!
-
-Interrupt transfers may only send (or receive) the "maxpacket" value for
-the given interrupt endpoint; if you need more data, you will need to
-copy that data out of (or into) another buffer.  Similarly, you can't
-queue interrupt transfers.
-THESE RESTRICTIONS ARE EXPECTED TO BE REMOVED!!
-
-Note that this automagic resubmission model does make it awkward to use
-interrupt OUT transfers.  The portable solution involves unlinking those
-OUT urbs after the data is transferred, and perhaps submitting a final
-URB for a short packet.
-
 The usb_submit_urb() call modifies urb->interval to the implemented interval
 value that is less than or equal to the requested interval value.
+
+In Linux 2.6, unlike earlier versions, interrupt URBs are not automagically
+restarted when they complete.  They end when the completion handler is
+called, just like other URBs.  If you want an interrupt URB to be restarted,
+your completion handler must resubmit it.

--
