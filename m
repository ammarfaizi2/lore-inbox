Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbUJZP3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbUJZP3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 11:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbUJZP3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 11:29:38 -0400
Received: from colino.net ([213.41.131.56]:24046 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262295AbUJZP3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:29:15 -0400
Date: Tue, 26 Oct 2004 17:28:43 +0200
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sf.net
Subject: 2.6.10-rc1 OHCI usb error messages
Message-ID: <20041026172843.6ac07c1a.colin@colino.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs132.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.10-rc1 gives the following error messages on my iBook G4, which uses
the ohci-hcd driver:

usb usb2: usbfs: USBDEVFS_CONTROL failed cmd usbmodules rqt 128 rq 6 len 18 ret -113
usb usb2: usbfs: USBDEVFS_CONTROL failed cmd usbmodules rqt 128 rq 6 len 18 ret -113
usb usb2: usbfs: USBDEVFS_CONTROL failed cmd usbmodules rqt 128 rq 6 len 18 ret -113
usb usb3: usbfs: USBDEVFS_CONTROL failed cmd usbmodules rqt 128 rq 6 len 18 ret -113
usb usb3: usbfs: USBDEVFS_CONTROL failed cmd usbmodules rqt 128 rq 6 len 18 ret -113
usb usb3: usbfs: USBDEVFS_CONTROL failed cmd usbmodules rqt 128 rq 6 len 18 ret -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb2: string descriptor 0 read error: -113
usb usb2: string descriptor 0 read error: -113
...
usb usb2: string descriptor 0 read error: -113
usb usb2: string descriptor 0 read error: -113

It worked correctly under 2.6.9. Give the error number, I'd guess the culprit 
is this hunk:
--- a/drivers/usb/host/ohci-hub.c       2004-10-22 14:40:57 -07:00
+++ b/drivers/usb/host/ohci-hub.c       2004-10-22 14:40:57 -07:00
...
@@ -146,10 +120,11 @@
        ohci->next_statechange = jiffies + msecs_to_jiffies (5);
                                                                                
 succeed:
-       /* it's not USB_STATE_SUSPENDED unless access to this
+       /* it's not HCD_STATE_SUSPENDED unless access to this
         * hub from the non-usb side (PCI, SOC, etc) stopped
         */
        root->dev.power.power_state = 3;
+       usb_set_device_state (root, USB_STATE_SUSPENDED);
 done:
        spin_unlock_irq (&ohci->lock);
        return status;

(Note also that this may be due to the patch to swsusp to make it work on 
PPC, but I had this patch with 2.6.9 too.)

-- 
Colin
