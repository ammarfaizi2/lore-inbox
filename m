Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132047AbQKXHFZ>; Fri, 24 Nov 2000 02:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131987AbQKXHFP>; Fri, 24 Nov 2000 02:05:15 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:2571 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S132047AbQKXHFC>; Fri, 24 Nov 2000 02:05:02 -0500
Date: Fri, 24 Nov 2000 00:31:11 -0600
To: Greg KH <greg@wirex.com>, f5ibh <f5ibh@db0bm.ampr.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre, usb mouse messages
Message-ID: <20001124003111.E8881@wire.cadcamlab.org>
In-Reply-To: <200011232132.WAA29552@db0bm.ampr.org> <20001123134804.C28923@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001123134804.C28923@wirex.com>; from greg@wirex.com on Thu, Nov 23, 2000 at 01:48:04PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > usb-uhci.c: interrupt, status 3, frame# 212
> > hub.c: already running port 2 disabled by hub (EMI?), re-enabling...

[Greg KH]
> The messages are harmless debug messages.  Anyone want to whip up a
> patch to turn them off (like was recently done for 2.4.0-test)?

Is this what you mean?

Peter


diff -urk.bak 2.2.18-19/drivers/usb/hub.c.bak 2.2.18-19/drivers/usb/hub.c
--- 2.2.18-19/drivers/usb/hub.c.bak	Fri Nov  3 19:20:45 2000
+++ 2.2.18-19/drivers/usb/hub.c	Fri Nov 24 00:29:50 2000
@@ -530,11 +530,8 @@
 				// be shutdown by the hub, this hack enables them again.
 				// Works at least with mouse driver. 
 				if (!(portstatus & USB_PORT_STAT_ENABLE) && 
-				    (portstatus & USB_PORT_STAT_CONNECTION) && (dev->children[i])) {
-					err("already running port %i disabled by hub (EMI?), re-enabling...",
-						i + 1);
+				    (portstatus & USB_PORT_STAT_CONNECTION) && (dev->children[i]))
 					usb_hub_port_connect_change(dev, i);
-				}
 			}
 
 			if (portstatus & USB_PORT_STAT_SUSPEND) {
diff -urk.bak 2.2.18-19/drivers/usb/usb-uhci.c.bak 2.2.18-19/drivers/usb/usb-uhci.c
--- 2.2.18-19/drivers/usb/usb-uhci.c.bak	Fri Nov  3 19:20:46 2000
+++ 2.2.18-19/drivers/usb/usb-uhci.c	Fri Nov 24 00:21:16 2000
@@ -2538,16 +2538,10 @@
 
 	dbg("interrupt");
 
-	if (status != 1) {
-		warn("interrupt, status %x, frame# %i", status, 
-		     UHCI_GET_CURRENT_FRAME(s));
+	// remove host controller halted state
+	if ((status&0x20) && (s->running))
+		outw (USBCMD_RS | inw(io_addr + USBCMD), io_addr + USBCMD);
 
-		// remove host controller halted state
-		if ((status&0x20) && (s->running)) {
-			outw (USBCMD_RS | inw(io_addr + USBCMD), io_addr + USBCMD);
-		}
-		//uhci_show_status (s);
-	}
 	/*
 	 * traverse the list in *reverse* direction, because new entries
 	 * may be added at the end.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
