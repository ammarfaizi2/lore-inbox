Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbTLUXrs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 18:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbTLUXrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 18:47:48 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:37578 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264255AbTLUXrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 18:47:37 -0500
Message-ID: <3FE630D7.7070007@pacbell.net>
Date: Sun, 21 Dec 2003 15:46:31 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-net@vger.kernel.org, jgarzik@pobox.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let USB_{PEGASUS,USBNET} depend on NET_ETHERNET
References: <20031221022242.GT12750@fs.tum.de>
In-Reply-To: <20031221022242.GT12750@fs.tum.de>
Content-Type: multipart/mixed;
 boundary="------------080504040508000509010204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080504040508000509010204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> I observed the following small problem in 2.6:
> 
> - MII depends on NET_ETHERNET
> - USB_PEGASUS and USB_USBNET select MII, but they depend only on NET
>  
> The patch below lets USB_PEGASUS and USB_USBNET depend on NET_ETHERNET 
> instead of NET to fix this issue.

Actually how about this one instead?  The PEGASUS bit is the same.
The difference is that MII (and CRC32) are only attributed to the
driver code that needs those ... AX8817X needs both, ZAURUS just
needs CRC32.  The core (which should eventually become a separate
module) shouldn't depend on those modules at all.

Also both CDCETHER and AX8817X are marked as non-experimental;
I recall Dave Hollis submitted a patch to do that for AX8817X,
and CDCETHER now seems to have gotten enough success reports too.

- Dave


--------------080504040508000509010204
Content-Type: text/plain;
 name="kconf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kconf.patch"

--- 1.12/drivers/usb/net/Kconfig	Sat Sep 27 03:23:06 2003
+++ edited/drivers/usb/net/Kconfig	Sun Dec 21 15:24:41 2003
@@ -69,7 +69,7 @@
 
 config USB_PEGASUS
 	tristate "USB Pegasus/Pegasus-II based ethernet device support"
-	depends on USB && NET
+	depends on USB && NET_ETHERNET
 	select MII
 	---help---
 	  Say Y here if you know you have Pegasus or Pegasus-II based adapter.
@@ -96,8 +96,6 @@
 config USB_USBNET
 	tristate "Multi-purpose USB Networking Framework"
 	depends on USB && NET
-	select CRC32
-	select MII
 	---help---
 	  This driver supports several kinds of network links over USB,
 	  with "minidrivers" built around a common network driver core
@@ -206,6 +204,7 @@
 config USB_ZAURUS
 	boolean "Sharp Zaurus (stock ROMs)"
 	depends on USB_USBNET
+	select CRC32
 	default y
 	help
 	  Choose this option to support the usb networking links used by
@@ -217,9 +216,7 @@
 
 config USB_CDCETHER
 	boolean "CDC Ethernet support (smart devices such as cable modems)"
-	# experimental primarily because cdc-ether was.
-	# make it non-experimental after more interop testing
-	depends on USB_USBNET && EXPERIMENTAL
+	depends on USB_USBNET
 	default y
 	help
 	  This option supports devices conforming to the Communication Device
@@ -247,7 +244,9 @@
 
 config USB_AX8817X
 	boolean "ASIX AX88172 Based USB 2.0 Ethernet Devices"
-	depends on USB_USBNET && EXPERIMENTAL
+	depends on USB_USBNET && NET_ETHERNET
+	select CRC32
+	select MII
 	default y
 	help
 

--------------080504040508000509010204--

