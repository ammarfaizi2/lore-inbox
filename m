Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWJCTth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWJCTth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWJCTth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:49:37 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:50139 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S964799AbWJCTtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:49:36 -0400
Message-ID: <4522BEC9.4050806@free.fr>
Date: Tue, 03 Oct 2006 21:49:29 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060809 Debian/1.7.13-0.3
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: [PATCH 1/3] UEAGLE : use interruptible sleep
Content-Type: multipart/mixed;
 boundary="------------040308050509050405070208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040308050509050405070208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


this patch use wait_event_interruptible_timeout and msleep_interruptible 
beacause uninterruptible sleep (task state 'D') is counted as 1 towards 
load average, like running processes.


Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>



--------------040308050509050405070208
Content-Type: text/plain;
 name="eagle-interruptible"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="eagle-interruptible"

use *_interruptible :
Uninterruptible sleep (task state 'D') is counted as 1 towards load average, lik
e running processes.  Interruptible sleep is not.

Signed-off-by: matthieu castet <castet.matthieu@free.fr>
Index: linux/drivers/usb/atm/ueagle-atm.c
===================================================================
--- linux.orig/drivers/usb/atm/ueagle-atm.c	2006-09-22 22:05:13.000000000 +0200
+++ linux/drivers/usb/atm/ueagle-atm.c	2006-09-22 22:06:16.000000000 +0200
@@ -744,7 +744,7 @@
 
 static inline int wait_cmv_ack(struct uea_softc *sc)
 {
-	int ret = wait_event_timeout(sc->cmv_ack_wait,
+	int ret = wait_event_interruptible_timeout(sc->cmv_ack_wait,
 						   sc->cmv_ack, ACK_TIMEOUT);
 	sc->cmv_ack = 0;
 
@@ -1176,7 +1176,7 @@
 		if (!ret)
 			ret = uea_stat(sc);
 		if (ret != -EAGAIN)
-			msleep(1000);
+			msleep_interruptible(1000);
  		if (try_to_freeze())
 			uea_err(INS_TO_USBDEV(sc), "suspend/resume not supported, "
 				"please unplug/replug your modem\n");
@@ -1605,7 +1605,7 @@
 {
 	struct uea_softc *sc = usbatm->driver_data;
 
-	wait_event(sc->sync_q, IS_OPERATIONAL(sc));
+	wait_event_interruptible(sc->sync_q, IS_OPERATIONAL(sc));
 
 	return 0;
 

--------------040308050509050405070208--
