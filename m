Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUJBSKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUJBSKD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 14:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUJBSKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 14:10:03 -0400
Received: from cantor.suse.de ([195.135.220.2]:50131 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267452AbUJBSJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 14:09:31 -0400
Date: Sat, 2 Oct 2004 20:09:26 +0200
From: Olaf Hering <olh@suse.de>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB storage crash report in 2.6 SMP
Message-ID: <20041002180926.GA17247@suse.de>
References: <04E3EF912@server5.heliogroup.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04E3EF912@server5.heliogroup.fr>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

 On Thu, Sep 30, Hubert Tonneau wrote:

> Copying a large amount of datas (several gigabytes) between two USB 2.0 attached
> disks will crash any Linux 2.6 SMP kernel, including 2.6.9-rc3.
> 
> The stack report is:
> qh_completions 0x7B/0x118 [ehci_hcd]

this was fixed a while ago, but not yet synced with Linus.

...
Maybe the call chain is something like this:

ehci_irq
spin_lock (&ehci->lock)
  ehci_work                             ehci_watchdog
    end_unlink_async
      qh_completions
        ehci_urb_done
        spin_unlock (&ehci->lock)
          usb_hcd_giveback_urb          spin_lock (&ehci->lock)
                                          ehci_work

now ehci_watchdog could proceed until usb_hcd_giveback_urb returns, then 
ehci_urb_done must wait until the watchdog is done. both seem to operate  
on the same list. I cant test it right now, box crashed.
...


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="ehci-0802.patch"

This addresses an SMP-only issue with the EHCI driver, where only one CPU
should scan the schedule at a time (scanning is not re-entrant) but either
the IRQ handler or a watchdog timer could end up starting it.  Many thanks
to Olaf Hering for isolating the failure mode!

Once once CPU starts scanning, any other might as well finish right
away.  This fix just adds a flag to detect that case.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- 1.93/drivers/usb/host/ehci-hcd.c	Mon Aug 23 16:48:53 2004
+++ edited/ehci-hcd.c	Thu Sep  2 16:05:47 2004
@@ -695,9 +695,18 @@
 	timer_action_done (ehci, TIMER_IO_WATCHDOG);
 	if (ehci->reclaim_ready)
 		end_unlink_async (ehci, regs);
+
+	/* another CPU may drop ehci->lock during a schedule scan while
+	 * it reports urb completions.  this flag guards against bogus
+	 * attempts at re-entrant schedule scanning.
+	 */
+	if (ehci->scanning)
+		return;
+	ehci->scanning = 1;
 	scan_async (ehci, regs);
 	if (ehci->next_uframe != -1)
 		scan_periodic (ehci, regs);
+	ehci->scanning = 0;
 
 	/* the IO watchdog guards against hardware or driver bugs that
 	 * misplace IRQs, and should let us run completely without IRQs.
--- 1.43/drivers/usb/host/ehci.h	Tue Aug 24 12:18:34 2004
+++ edited/ehci.h	Thu Sep  2 15:32:30 2004
@@ -53,6 +53,7 @@
 	struct ehci_qh		*async;
 	struct ehci_qh		*reclaim;
 	unsigned		reclaim_ready : 1;
+	unsigned		scanning : 1;
 
 	/* periodic schedule support */
 #define	DEFAULT_I_TDPS		1024		/* some HCs can do less */

--d6Gm4EdcadzBjdND--
