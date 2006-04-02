Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWDBQj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWDBQj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 12:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWDBQj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 12:39:57 -0400
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:53660 "EHLO
	localhost") by vger.kernel.org with ESMTP id S932390AbWDBQjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 12:39:44 -0400
Message-ID: <442FFE4F.9060307@free.fr>
Date: Sun, 02 Apr 2006 18:39:43 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: [PATCH 2/4] UEAGLE : support geode
Content-Type: multipart/mixed;
 boundary="------------030808090007000609030306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030808090007000609030306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch :
- increase ack timeout for slow system (geode 233MHz where HZ=100)
- reset the cmv ack flag when rebooting

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>



--------------030808090007000609030306
Content-Type: text/plain;
 name="ueagle2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="ueagle2.patch"

Index: ueagle-atm.c
===================================================================
--- ueagle-atm.c	(révision 264)
+++ ueagle-atm.c	(révision 265)
@@ -243,7 +243,7 @@
 #define BULK_TIMEOUT 300
 #define CTRL_TIMEOUT 1000
 
-#define ACK_TIMEOUT msecs_to_jiffies(1500)
+#define ACK_TIMEOUT msecs_to_jiffies(3000)
 
 #define UEA_INTR_IFACE_NO 	0
 #define UEA_US_IFACE_NO		1
@@ -1079,7 +1079,13 @@
 	uea_enters(INS_TO_USBDEV(sc));
 	uea_info(INS_TO_USBDEV(sc), "(re)booting started\n");
 
+	/* mask interrupt */
 	sc->booting = 1;
+	/* We need to set this here because, a ack timeout could have occured, 
+	 * but before we start the reboot, the ack occurs and set this to 1.
+	 * So we will failed to wait Ready CMV.
+	 */
+	sc->cmv_ack = 0;
 	UPDATE_ATM_STAT(signal, ATM_PHY_SIG_LOST);
 
 	/* reset statistics */
@@ -1105,6 +1111,7 @@
 
 	msleep(1000);
 	sc->cmv_function = MAKEFUNCTION(ADSLDIRECTIVE, MODEMREADY);
+	/* demask interrupt */
 	sc->booting = 0;
 
 	/* start loading DSP */

--------------030808090007000609030306--
