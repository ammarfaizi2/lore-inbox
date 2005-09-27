Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVI0CrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVI0CrW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 22:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVI0CrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 22:47:22 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:44366 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S964786AbVI0CrV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 22:47:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.4] asus vt8235 router buggy bios workaround
Date: Mon, 26 Sep 2005 19:47:18 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C3616DE2@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.4] asus vt8235 router buggy bios workaround
Thread-Index: AcXDDca6z8ZBNfFxTECHywjFEH9owA==
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: <marcelo.tosatti@cyclades.com>
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, <pavol_gono@yahoo.com>
X-OriginalArrivalTime: 27 Sep 2005 02:47:21.0444 (UTC) FILETIME=[C86C0240:01C5C30D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,
 
  Here is backport to 2.4 for fix to
http://bugzilla.kernel.org/show_bug.cgi?id=5235.

Similar problem has been reported before here:
http://groups.google.com/group/linux.kernel/browse_thread/thread/def4ca1
9dbc3cd4/5cffbf349f2c87a4?tvc=2&q=Aleksey+Gorelov&hl=en#5cffbf349f2c87a4
and was related to bug in BIOS reporting 82C686 router compatible to
586.

I suspect BIOS on this board has similar issue: reports VT8235 router to
be
compatible with 586 one - which is obviously not true.  Patch from the
link
above has already incorporated in both 2.6 & 2.4 series, but might not
work
in this particular case.

Signed-off-by: Aleksey Gorelov <aleksey_gorelov@phoenix.com>
 
--- linux-2.4.32-rc1/arch/i386/kernel/pci-irq.c.orig	2005-09-26
19:32:48.000000000 -0700
+++ linux-2.4.32-rc1/arch/i386/kernel/pci-irq.c	2005-09-26
19:34:42.000000000 -0700
@@ -665,10 +665,27 @@
 {
 	/* FIXME: We should move some of the quirk fixup stuff here */
 
-	if (router->device == PCI_DEVICE_ID_VIA_82C686 &&
-		device == PCI_DEVICE_ID_VIA_82C586_0) {
-		/* Asus k7m bios wrongly reports 82C686A as
586-compatible */
-		device = PCI_DEVICE_ID_VIA_82C686;
+	/*
+	 * work arounds for some buggy BIOSes
+	 */
+	if (device == PCI_DEVICE_ID_VIA_82C586_0) {
+		switch(router->device)
+		{
+			case PCI_DEVICE_ID_VIA_82C686:
+				/*
+				 * Asus k7m bios wrongly reports 82C686A

+				 * as 586-compatible 
+				 */
+				device = PCI_DEVICE_ID_VIA_82C686;
+				break;
+			case PCI_DEVICE_ID_VIA_8235:
+				/**
+				 * Asus a7v-x bios wrongly reports 8235
+				 * as 586-compatible
+				 */
+				device = PCI_DEVICE_ID_VIA_8235;
+				break;
+		}	
 	}
 
 	switch(device)
@@ -681,6 +698,7 @@
 		case PCI_DEVICE_ID_VIA_82C596:
 		case PCI_DEVICE_ID_VIA_82C686:
 		case PCI_DEVICE_ID_VIA_8231:
+		case PCI_DEVICE_ID_VIA_8235:
 		/* FIXME: add new ones for 8233/5 */
 			r->name = "VIA";
 			r->get = pirq_via_get;
