Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313660AbSD0M1R>; Sat, 27 Apr 2002 08:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313690AbSD0M1Q>; Sat, 27 Apr 2002 08:27:16 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:26521 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S313660AbSD0M1P>;
	Sat, 27 Apr 2002 08:27:15 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15562.39130.683869.175699@argo.ozlabs.ibm.com>
Date: Sat, 27 Apr 2002 22:26:02 +1000 (EST)
To: dbrownell@users.sourceforge.net, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: unnecessary use of set_bit
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ohci_hub_status_data() procedure in drivers/usb/host/ohci-hub.c in
2.5.11 is broken in a couple of ways: it uses set_bit on a char *
address and it assumes little-endian byte order in the bitmap.

Here is a patch to fix both problems.  As a bonus, the file ends up
one line shorter. :)

Please, people, don't use set_bit when you don't need an atomic
operation.  set_bit(&x, n) is slower than x |= 1 << n on a lot of
platforms, including SMP x86 I believe.  (If the bitmap is more than
one word you can use __set_bit if you don't require atomicity.)

Paul.

diff -urN linux-2.5/drivers/usb/host/ohci-hub.c pmac-2.5/drivers/usb/host/ohci-hub.c
--- linux-2.5/drivers/usb/host/ohci-hub.c	Sat Apr 27 20:51:31 2002
+++ pmac-2.5/drivers/usb/host/ohci-hub.c	Sat Apr 27 15:03:06 2002
@@ -67,7 +67,7 @@
 ohci_hub_status_data (struct usb_hcd *hcd, char *buf)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
-	int		ports, i, changed = 0, length = 1;
+	int		ports, i, mask = 0, length = 1;
 
 	ports = roothub_a (ohci) & RH_A_NDP; 
 	if (ports > MAX_ROOT_PORTS) {
@@ -80,13 +80,7 @@
 
 	/* init status */
 	if (roothub_status (ohci) & (RH_HS_LPSC | RH_HS_OCIC))
-		buf [0] = changed = 1;
-	else
-		buf [0] = 0;
-	if (ports > 7) {
-		buf [1] = 0;
-		length++;
-	}
+		mask = 1;
 
 	/* look at each port */
 	for (i = 0; i < ports; i++) {
@@ -94,12 +88,17 @@
 
 		status &= RH_PS_CSC | RH_PS_PESC | RH_PS_PSSC
 				| RH_PS_OCIC | RH_PS_PRSC;
-		if (status) {
-			changed = 1;
-			set_bit (i + 1, buf);
-		}
+		if (status)
+			mask |= 1 << (i + 1);
+	}
+	if (!mask)
+		return 0;
+	buf[0] = mask;
+	if (ports > 7) {
+		length++;
+		buf[1] = mask >> 8;
 	}
-	return changed ? length : 0;
+	return length;
 }
 
 /*-------------------------------------------------------------------------*/
