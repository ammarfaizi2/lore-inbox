Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWDBQnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWDBQnz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 12:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWDBQny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 12:43:54 -0400
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:52883 "EHLO
	localhost") by vger.kernel.org with ESMTP id S932387AbWDBQny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 12:43:54 -0400
Message-ID: <442FFF49.50303@free.fr>
Date: Sun, 02 Apr 2006 18:43:53 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: Re: [PATCH 1/4] UEAGLE : cosmetic
References: <442FFE44.70507@free.fr>
In-Reply-To: <442FFE44.70507@free.fr>
Content-Type: multipart/mixed;
 boundary="------------060202010008050804030404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060202010008050804030404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

matthieu castet wrote:
> Hi,
> 
> this patch :
> - improve debug trace in order to make easy to solve user problems.
> - indent some code
> - increase version number
> 
add correct path for the file name

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>


--------------060202010008050804030404
Content-Type: text/plain;
 name="ueagle1.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="ueagle1.patch"

Index: ueagle-atm.c
===================================================================
--- linux-2.6.15.old/drivers/usb/atm/ueagle-atm.c	(révision 263)
+++ linux-2.6.15/drivers/usb/atm/ueagle-atm.c	(révision 264)
@@ -68,7 +68,7 @@
 
 #include "usbatm.h"
 
-#define EAGLEUSBVERSION "ueagle 1.2"
+#define EAGLEUSBVERSION "ueagle 1.3"
 
 
 /*
@@ -314,6 +314,10 @@
 	 ((d) & 0xff) << 16 |						\
 	 ((a) & 0xff) << 8  |						\
 	 ((b) & 0xff))
+#define GETSA1(a) ((a >> 8) & 0xff)
+#define GETSA2(a) (a & 0xff)
+#define GETSA3(a) ((a >> 24) & 0xff)
+#define GETSA4(a) ((a >> 16) & 0xff)
 
 #define SA_CNTL MAKESA('C', 'N', 'T', 'L')
 #define SA_DIAG MAKESA('D', 'I', 'A', 'G')
@@ -728,11 +732,12 @@
 	uea_err(INS_TO_USBDEV(sc), "sending DSP block %u failed\n", i);
 	return;
 bad1:
-	uea_err(INS_TO_USBDEV(sc), "invalid DSP page %u requested\n",pageno);
+	uea_err(INS_TO_USBDEV(sc), "invalid DSP page %u requested\n", pageno);
 }
 
 static inline void wake_up_cmv_ack(struct uea_softc *sc)
 {
+	BUG_ON(sc->cmv_ack);
 	sc->cmv_ack = 1;
 	wake_up(&sc->cmv_ack_wait);
 }
@@ -743,6 +748,9 @@
 						   sc->cmv_ack, ACK_TIMEOUT);
 	sc->cmv_ack = 0;
 
+	uea_dbg(INS_TO_USBDEV(sc), "wait_event_timeout : %d ms\n",
+			jiffies_to_msecs(ret));
+	
 	if (ret < 0)
 		return ret;
 
@@ -791,6 +799,12 @@
 	struct cmv cmv;
 	int ret;
 
+	uea_enters(INS_TO_USBDEV(sc));
+	uea_vdbg(INS_TO_USBDEV(sc), "Function : %d-%d, Address : %c%c%c%c, "
+			"offset : 0x%04x, data : 0x%08x\n", 
+			FUNCTION_TYPE(function), FUNCTION_SUBTYPE(function), 
+			GETSA1(address), GETSA2(address), GETSA3(address),
+			GETSA4(address), offset, data);
 	/* we send a request, but we expect a reply */
 	sc->cmv_function = function | 0x2;
 	sc->cmv_idx++;
@@ -808,7 +822,9 @@
 	ret = uea_request(sc, UEA_SET_BLOCK, UEA_MPTX_START, CMV_SIZE, &cmv);
 	if (ret < 0)
 		return ret;
-	return wait_cmv_ack(sc);
+	ret = wait_cmv_ack(sc);
+	uea_leaves(INS_TO_USBDEV(sc));
+	return ret;
 }
 
 static inline int uea_read_cmv(struct uea_softc *sc,
@@ -922,7 +938,7 @@
 	 * we check the status again in order to detect the failure earlier
 	 */
 	if (sc->stats.phy.flags) {
-		uea_dbg(INS_TO_USBDEV(sc), "Stat flag = %d\n",
+		uea_dbg(INS_TO_USBDEV(sc), "Stat flag = 0x%x\n",
 		       sc->stats.phy.flags);
 		return 0;
 	}
@@ -1101,6 +1117,8 @@
 	if (ret < 0)
 		return ret;
 
+	uea_vdbg(INS_TO_USBDEV(sc), "Ready CMV received\n");
+
 	/* Enter in R-IDLE (cmv) until instructed otherwise */
 	ret = uea_write_cmv(sc, SA_CNTL, 0, 1);
 	if (ret < 0)
@@ -1121,6 +1139,7 @@
 	}
 	/* Enter in R-ACT-REQ */
 	ret = uea_write_cmv(sc, SA_CNTL, 0, 2);
+	uea_vdbg(INS_TO_USBDEV(sc), "Entering in R-ACT-REQ state\n");
 out:
 	release_firmware(cmvs_fw);
 	sc->reset = 0;
@@ -1235,6 +1254,7 @@
 
 	if (cmv->bFunction == MAKEFUNCTION(ADSLDIRECTIVE, MODEMREADY)) {
 		wake_up_cmv_ack(sc);
+		uea_leaves(INS_TO_USBDEV(sc));
 		return;
 	}
 
@@ -1249,6 +1269,7 @@
 	sc->data = sc->data << 16 | sc->data >> 16;
 
 	wake_up_cmv_ack(sc);
+	uea_leaves(INS_TO_USBDEV(sc));
 	return;
 
 bad2:
@@ -1256,12 +1277,14 @@
 			"Function : %d, Subfunction : %d\n",
 			FUNCTION_TYPE(cmv->bFunction),
 			FUNCTION_SUBTYPE(cmv->bFunction));
+	uea_leaves(INS_TO_USBDEV(sc));
 	return;
 
 bad1:
 	uea_err(INS_TO_USBDEV(sc), "invalid cmv received, "
 			"wPreamble %d, bDirection %d\n",
 			le16_to_cpu(cmv->wPreamble), cmv->bDirection);
+	uea_leaves(INS_TO_USBDEV(sc));
 }
 
 /*
@@ -1508,7 +1531,7 @@
 	int ret = -ENODEV; 					\
 	struct uea_softc *sc; 					\
  								\
-	mutex_lock(&uea_mutex); 					\
+	mutex_lock(&uea_mutex); 				\
 	sc = dev_to_uea(dev);					\
 	if (!sc) 						\
 		goto out; 					\
@@ -1516,7 +1539,7 @@
 	if (reset)						\
 		sc->stats.phy.name = 0;				\
 out: 								\
-	mutex_unlock(&uea_mutex); 					\
+	mutex_unlock(&uea_mutex); 				\
 	return ret; 						\
 } 								\
 								\

--------------060202010008050804030404--
