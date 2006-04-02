Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWDBQoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWDBQoW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 12:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWDBQoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 12:44:22 -0400
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:54419 "EHLO
	localhost") by vger.kernel.org with ESMTP id S932391AbWDBQoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 12:44:21 -0400
Message-ID: <442FFF64.3030309@free.fr>
Date: Sun, 02 Apr 2006 18:44:20 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: Re: [PATCH 2/4] UEAGLE : support geode
References: <442FFE4F.9060307@free.fr>
In-Reply-To: <442FFE4F.9060307@free.fr>
Content-Type: multipart/mixed;
 boundary="------------000709020108000309050606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000709020108000309050606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

matthieu castet wrote:
> Hi,
> 
> this patch :
> - increase ack timeout for slow system (geode 233MHz where HZ=100)
> - reset the cmv ack flag when rebooting
> 
add correct path for the file name

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>


--------------000709020108000309050606
Content-Type: text/plain;
 name="ueagle2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="ueagle2.patch"

Index: ueagle-atm.c
===================================================================
--- linux-2.6.15.old/drivers/usb/atm/ueagle-atm.c	(révision 264)
+++ linux-2.6.15/drivers/usb/atm/ueagle-atm.c	(révision 265)
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

--------------000709020108000309050606--
