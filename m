Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTEIU44 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 16:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTEIU44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 16:56:56 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:19103 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263447AbTEIU4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 16:56:54 -0400
Message-Id: <200305092109.h49L9TvW023069@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: 2.5.69 Interrupt Latency
To: Paul Fulghum <paulkf@microgate.com>, linux-kernel@vger.kernel.org
Date: Fri, 09 May 2003 23:06:05 +0200
References: <20030507162013$0b67@gated-at.bofh.it> <20030507195008$71e6@gated-at.bofh.it> <20030507224009$4228@gated-at.bofh.it> <20030508140022$2498@gated-at.bofh.it> <20030508193016$1083@gated-at.bofh.it> <20030509182012$49f0@gated-at.bofh.it> <20030509204010$3c9b@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum wrote:

> One machine (server) was using usb-uhci and
> the other (laptop) was using usb-ohci.
> 
> So it looks like something with USB in 2.5.68-bk11

The change below was part of 2.5.68-bk11, and adds a 20ms
delay to the uhci interrupt handler. Could that be
the culprit?

        Arnd <><

ChangeSet 1.1042.1.129 2003/04/29 15:30:31 stern@rowland.harvard.edu
  [PATCH] USB: Minor patch for uhci-hcd.c
--- 1.32/drivers/usb/host/uhci-hcd.c    Mon Apr 14 11:51:40 2003
+++ 1.33/drivers/usb/host/uhci-hcd.c    Fri Apr 18 13:37:24 2003
@@ -1283,7 +1283,8 @@
        }
 
        if (last_urb) {
-               *end = (last_urb->start_frame + last_urb->number_of_packets) & 1023;
+               *end = (last_urb->start_frame + last_urb->number_of_packets *
+                               last_urb->interval) & (UHCI_NUMFRAMES-1);
                ret = 0;
        } else
                ret = -1;       /* no previous urb found */
@@ -1933,9 +1934,10 @@
 
        dbg("%x: suspend_hc", io_addr);
 
-       outw(USBCMD_EGSM, io_addr + USBCMD);
-
        uhci->is_suspended = 1;
+       smp_wmb();
+
+       outw(USBCMD_EGSM, io_addr + USBCMD);
 }
 
 static void wakeup_hc(struct uhci_hcd *uhci)
@@ -1945,6 +1947,9 @@
 
        dbg("%x: wakeup_hc", io_addr);
 
+       /* Global resume for 20ms */
+       outw(USBCMD_FGR | USBCMD_EGSM, io_addr + USBCMD);
+       wait_ms(20);
        outw(0, io_addr + USBCMD);
        
        /* wait for EOP to be sent */
@@ -1965,7 +1970,7 @@
        int i;
 
        for (i = 0; i < uhci->rh_numports; i++)
-               connection |= (inw(io_addr + USBPORTSC1 + i * 2) & 0x1);
+               connection |= (inw(io_addr + USBPORTSC1 + i * 2) & USBPORTSC_CCS);
 
        return connection;
 }
