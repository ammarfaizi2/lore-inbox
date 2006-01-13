Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422710AbWAMOxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422710AbWAMOxA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 09:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422708AbWAMOxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 09:53:00 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:51419 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1422706AbWAMOw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 09:52:59 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 14/13] USBATM: semaphore to mutex conversion
User-Agent: KMail/1.9.1
References: <200601131438.30181.baldrick@free.fr> <20060113140118.GA29586@elte.hu>
In-Reply-To: <20060113140118.GA29586@elte.hu>
MIME-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Date: Fri, 13 Jan 2006 15:52:55 +0100
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_H77xD0SJAZ1SmZ6"
Message-Id: <200601131552.55795.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_H77xD0SJAZ1SmZ6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: Arjan van de Ven <arjan@infradead.org>

Hi Greg, this is the usbatm part of the Arjan, Jes and Ingo
mass semaphore to mutex conversion, reworked to apply on top
of the patches I just sent to you.  This time, with correct
attribution and signed-off lines.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Duncan Sands <baldrick@free.fr>

--Boundary-00=_H77xD0SJAZ1SmZ6
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="14-mutex"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="14-mutex"

Index: Linux/drivers/usb/atm/cxacru.c
===================================================================
--- Linux.orig/drivers/usb/atm/cxacru.c	2006-01-13 09:35:07.000000000 +0100
+++ Linux/drivers/usb/atm/cxacru.c	2006-01-13 14:14:41.000000000 +0100
@@ -36,6 +36,7 @@
 #include <linux/init.h>
 #include <linux/device.h>	/* FIXME: linux/firmware.h should include it itself */
 #include <linux/firmware.h>
+#include <linux/mutex.h>
 
 #include "usbatm.h"
 
@@ -160,7 +161,7 @@
 	struct work_struct poll_work;
 
 	/* contol handles */
-	struct semaphore cm_serialize;
+	struct mutex cm_serialize;
 	u8 *rcv_buf;
 	u8 *snd_buf;
 	struct urb *rcv_urb;
@@ -219,7 +220,7 @@
 		goto fail;
 	}
 
-	down(&instance->cm_serialize);
+	mutex_lock(&instance->cm_serialize);
 
 	/* submit reading urb before the writing one */
 	init_completion(&instance->rcv_done);
@@ -288,7 +289,7 @@
 	ret = offd;
 	dbg("cm %#x", cm);
 fail:
-	up(&instance->cm_serialize);
+	mutex_unlock(&instance->cm_serialize);
 	return ret;
 }
 
@@ -717,7 +718,7 @@
 			instance->snd_buf, PAGE_SIZE,
 			cxacru_blocking_completion, &instance->snd_done, 4);
 
-	init_MUTEX(&instance->cm_serialize);
+	mutex_init(&instance->cm_serialize);
 
 	INIT_WORK(&instance->poll_work, (void *)cxacru_poll_status, instance);
 
Index: Linux/drivers/usb/atm/ueagle-atm.c
===================================================================
--- Linux.orig/drivers/usb/atm/ueagle-atm.c	2006-01-13 09:35:07.000000000 +0100
+++ Linux/drivers/usb/atm/ueagle-atm.c	2006-01-13 14:14:41.000000000 +0100
@@ -63,6 +63,7 @@
 #include <linux/ctype.h>
 #include <linux/kthread.h>
 #include <linux/version.h>
+#include <linux/mutex.h>
 #include <asm/unaligned.h>
 
 #include "usbatm.h"
@@ -358,7 +359,7 @@
 #define INTR_PKT_SIZE 28
 
 static struct usb_driver uea_driver;
-static DECLARE_MUTEX(uea_semaphore);
+static DEFINE_MUTEX(uea_mutex);
 static const char *chip_name[] = {"ADI930", "Eagle I", "Eagle II", "Eagle III"};
 
 static int modem_index;
@@ -1418,13 +1419,13 @@
 	int ret = -ENODEV;
 	struct uea_softc *sc;
 
-	down(&uea_semaphore);
+	mutex_lock(&uea_mutex);
 	sc = dev_to_uea(dev);
 	if (!sc)
 		goto out;
 	ret = snprintf(buf, 10, "%08x\n", sc->stats.phy.state);
 out:
-	up(&uea_semaphore);
+	mutex_unlock(&uea_mutex);
 	return ret;
 }
 
@@ -1434,14 +1435,14 @@
 	int ret = -ENODEV;
 	struct uea_softc *sc;
 
-	down(&uea_semaphore);
+	mutex_lock(&uea_mutex);
 	sc = dev_to_uea(dev);
 	if (!sc)
 		goto out;
 	sc->reset = 1;
 	ret = count;
 out:
-	up(&uea_semaphore);
+	mutex_unlock(&uea_mutex);
 	return ret;
 }
 
@@ -1453,7 +1454,7 @@
 	int ret = -ENODEV;
 	struct uea_softc *sc;
 
-	down(&uea_semaphore);
+	mutex_lock(&uea_mutex);
 	sc = dev_to_uea(dev);
 	if (!sc)
 		goto out;
@@ -1473,7 +1474,7 @@
 		break;
 	}
 out:
-	up(&uea_semaphore);
+	mutex_unlock(&uea_mutex);
 	return ret;
 }
 
@@ -1485,7 +1486,7 @@
 	int ret = -ENODEV;
 	struct uea_softc *sc;
 
-	down(&uea_semaphore);
+	mutex_lock(&uea_mutex);
 	sc = dev_to_uea(dev);
 	if (!sc)
 		goto out;
@@ -1497,7 +1498,7 @@
 	else
 		ret = sprintf(buf, "GOOD\n");
 out:
-	up(&uea_semaphore);
+	mutex_unlock(&uea_mutex);
 	return ret;
 }
 
@@ -1511,7 +1512,7 @@
 	int ret = -ENODEV; 					\
 	struct uea_softc *sc; 					\
  								\
-	down(&uea_semaphore); 					\
+	mutex_lock(&uea_mutex); 					\
 	sc = dev_to_uea(dev);					\
 	if (!sc) 						\
 		goto out; 					\
@@ -1519,7 +1520,7 @@
 	if (reset)						\
 		sc->stats.phy.name = 0;				\
 out: 								\
-	up(&uea_semaphore); 					\
+	mutex_unlock(&uea_mutex); 					\
 	return ret; 						\
 } 								\
 								\
@@ -1737,9 +1738,9 @@
 	 * Pre-firmware device has one interface
 	 */
 	if (usb->config->desc.bNumInterfaces != 1 && ifnum == 0) {
-		down(&uea_semaphore);
+		mutex_lock(&uea_mutex);
 		usbatm_usb_disconnect(intf);
-		up(&uea_semaphore);
+		mutex_unlock(&uea_mutex);
 		uea_info(usb, "ADSL device removed\n");
 	}
 
Index: Linux/drivers/usb/atm/usbatm.c
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.c	2006-01-13 09:35:09.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.c	2006-01-13 14:20:19.000000000 +0100
@@ -823,7 +823,7 @@
 		return -EINVAL;
 	}
 
-	down(&instance->serialize);	/* vs self, usbatm_atm_close, usbatm_usb_disconnect */
+	mutex_lock(&instance->serialize);	/* vs self, usbatm_atm_close, usbatm_usb_disconnect */
 
 	if (instance->disconnected) {
 		atm_dbg(instance, "%s: disconnected!\n", __func__);
@@ -867,7 +867,7 @@
 	set_bit(ATM_VF_PARTIAL, &vcc->flags);
 	set_bit(ATM_VF_READY, &vcc->flags);
 
-	up(&instance->serialize);
+	mutex_unlock(&instance->serialize);
 
 	atm_dbg(instance, "%s: allocated vcc data 0x%p\n", __func__, new);
 
@@ -875,7 +875,7 @@
 
 fail:
 	kfree(new);
-	up(&instance->serialize);
+	mutex_unlock(&instance->serialize);
 	return ret;
 }
 
@@ -896,7 +896,7 @@
 
 	usbatm_cancel_send(instance, vcc);
 
-	down(&instance->serialize);	/* vs self, usbatm_atm_open, usbatm_usb_disconnect */
+	mutex_lock(&instance->serialize);	/* vs self, usbatm_atm_open, usbatm_usb_disconnect */
 
 	tasklet_disable(&instance->rx_channel.tasklet);
 	if (instance->cached_vcc == vcc_data) {
@@ -919,7 +919,7 @@
 	clear_bit(ATM_VF_PARTIAL, &vcc->flags);
 	clear_bit(ATM_VF_ADDR, &vcc->flags);
 
-	up(&instance->serialize);
+	mutex_unlock(&instance->serialize);
 
 	atm_dbg(instance, "%s successful\n", __func__);
 }
@@ -1009,9 +1009,9 @@
 	if (!ret)
 		ret = usbatm_atm_init(instance);
 
-	down(&instance->serialize);
+	mutex_lock(&instance->serialize);
 	instance->thread_pid = -1;
-	up(&instance->serialize);
+	mutex_unlock(&instance->serialize);
 
 	complete_and_exit(&instance->thread_exited, ret);
 }
@@ -1025,9 +1025,9 @@
 		return ret;
 	}
 
-	down(&instance->serialize);
+	mutex_lock(&instance->serialize);
 	instance->thread_pid = ret;
-	up(&instance->serialize);
+	mutex_unlock(&instance->serialize);
 
 	wait_for_completion(&instance->thread_started);
 
@@ -1110,7 +1110,7 @@
 	/* private fields */
 
 	kref_init(&instance->refcount);		/* dropped in usbatm_usb_disconnect */
-	init_MUTEX(&instance->serialize);
+	mutex_init(&instance->serialize);
 
 	instance->thread_pid = -1;
 	init_completion(&instance->thread_started);
@@ -1273,18 +1273,18 @@
 
 	usb_set_intfdata(intf, NULL);
 
-	down(&instance->serialize);
+	mutex_lock(&instance->serialize);
 	instance->disconnected = 1;
 	if (instance->thread_pid >= 0)
 		kill_proc(instance->thread_pid, SIGTERM, 1);
-	up(&instance->serialize);
+	mutex_unlock(&instance->serialize);
 
 	wait_for_completion(&instance->thread_exited);
 
-	down(&instance->serialize);
+	mutex_lock(&instance->serialize);
 	list_for_each_entry(vcc_data, &instance->vcc_list, list)
 		vcc_release_async(vcc_data->vcc, -EPIPE);
-	up(&instance->serialize);
+	mutex_unlock(&instance->serialize);
 
 	tasklet_disable(&instance->rx_channel.tasklet);
 	tasklet_disable(&instance->tx_channel.tasklet);
Index: Linux/drivers/usb/atm/usbatm.h
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.h	2006-01-13 09:35:09.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.h	2006-01-13 14:18:42.000000000 +0100
@@ -34,6 +34,7 @@
 #include <linux/list.h>
 #include <linux/stringify.h>
 #include <linux/usb.h>
+#include <linux/mutex.h>
 
 /*
 #define VERBOSE_DEBUG
@@ -171,7 +172,7 @@
         ********************************/
 
 	struct kref refcount;
-	struct semaphore serialize;
+	struct mutex serialize;
 	int disconnected;
 
 	/* heavy init */

--Boundary-00=_H77xD0SJAZ1SmZ6--
