Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTJLJJl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 05:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbTJLJJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 05:09:41 -0400
Received: from smtp1.pacifier.net ([64.255.237.171]:37026 "EHLO
	smtp1.pacifier.net") by vger.kernel.org with ESMTP id S263439AbTJLJJj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 05:09:39 -0400
Date: Sun, 12 Oct 2003 02:09:36 -0700
From: "B. D. Elliott" <bde@nwlink.com>
To: linux-usb-users@lists.sourceforge.net
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Ehci_hcd on Sparc64? [PATCH]
Mail-Followup-To: linux-usb-users@lists.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Message-Id: <20031012090937.57E656EFA1@smtp1.pacifier.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This is also being sent to L-K, because someone asked the same question
there.)

It appears that the ehci breakage is caused by a single mal-formed "if"
in ehci-q.c.  With this fixed, I am able to access directly-connected
devices on my Ultra30.

There still is a problem, in that I cannot access anything through my
external hub, although it is properly recognized.  Connecting a device
to the hub causes no action at all.  The hub does work with ohci.

The patch against test6-bk3 is:

====================================================================
--- ./drivers/usb/host/ehci-q.c.orig	2003-10-08 12:24:27.000000000 -0700
+++ ./drivers/usb/host/ehci-q.c	2003-10-11 22:47:43.000000000 -0700
@@ -778,7 +778,7 @@
 		/* control qh may need patching after enumeration */
 		if (unlikely (epnum == 0)) {
 			/* set_address changes the address */
-			if (le32_to_cpu (qh->hw_info1 & 0x7f) == 0)
+			if ((le32_to_cpu (qh->hw_info1) & 0x7f) == 0)
 				qh->hw_info1 |= cpu_to_le32 (
 						usb_pipedevice (urb->pipe));
 
====================================================================

The /proc/bus/usb/devices file looks like this:

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 5
B:  Alloc=  0/800 us ( 0%), #Int=  1, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test7-bk3 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0001:01:08.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=05ab ProdID=0060 Rev=11.05
S:  Manufacturer=In-System Design
S:  Product=USB Storage Adapter
S:  SerialNumber=11100E00005BD99F
C:* #Ifs= 1 Cfg#= 2 Atr=c0 MxPwr= 98mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=32ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  2 Spd=480 MxCh= 4
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0409 ProdID=0058 Rev= 1.00
S:  Manufacturer=NEC Corporation
S:  Product=USB2.0 Hub Controller
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms

-- 
B. D. Elliott   bde@nwlink.com


-- 
B. D. Elliott   bde@nwlink.com
