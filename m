Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316796AbSE3SOU>; Thu, 30 May 2002 14:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316797AbSE3SOU>; Thu, 30 May 2002 14:14:20 -0400
Received: from ppp-217-133-209-102.dialup.tiscali.it ([217.133.209.102]:54200
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S316796AbSE3SNa>; Thu, 30 May 2002 14:13:30 -0400
Subject: [PATCH] [2.4] ATM driver for the Alcatel SpeedTouch USB DSL modem
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-uN67HeQs0ONrJXRFq53X"
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 May 2002 20:13:22 +0200
Message-Id: <1022782402.1920.130.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uN67HeQs0ONrJXRFq53X
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Depends:
- [PATCH] [2.4, 2.5] printk helper functions
- [PATCH] [2.4] Waitable counter structure
- [PATCH] [2.4] ATM SAR support, based on SARlib

Recommends:
- [PATCH] [2.4] [2.5] Fix PPPoATM crash on disconnection
(tasklet_disable; kfree(tasklet)) <merged in 2.4.19-pre9>

Look at Configure.help for the description.

This driver is based on the 1.5 driver written and maintained by Johan
Verrept.
I sent an older version of this set of patches to him on 16/may/2002. On
20/may/2002 he replied saying that he would look at the patch, but he
didn't send me any further messages.
So, since the identity of the maintainer doesn't matter when deciding
whether to apply a patch or not, I'm sending this to linux-kernel
without waiting for an answer from the 1.5 maintainer in order to save
time.

diff --exclude-from=/home/ldb/src/linux-exclude -u -r -N linux-base/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-base/Documentation/Configure.help	Thu May 30 13:09:51 2002
+++ linux/Documentation/Configure.help	Mon May 27 15:29:08 2002
@@ -13824,6 +13824,48 @@
   Say Y here to include additional code to support the Sandisk SDDR-09
   SmartMedia reader in the USB Mass Storage driver.
 
+USB Alcatel SpeedTouch USB DSL modem support
+CONFIG_USB_SPEEDTOUCH
+  Say Y here if you want to connect an Alcatel SpeedTouch USB modem to
+  your computer's USB port.
+
+  This driver provides an ATM interface that uses the modem to
+  transfer data.  You must enable (Y or M in config) ATM (under
+  Networking Options) to use this driver. Information on this API may
+  be found on the WWW at <http://linux-atm.sourceforge.net>.
+
+  This driver is a revised version (that doesn't look much like the
+  original) of Johan Verrept's 1.5 SpeedTouch Driver.
+  Among the improvements of this 2.x branch are:
+  - Much more stability (hopefully); no deadlocks on shutdown
+  - Tons of locking added: SMP should work (not tested, I don't have a
+    suitable machine)
+  - Unlimited number of devices without compile-time configuration
+  - Processing of received data in URB completion handler, by default,
+    or in separate thread if configured at compile time
+  - If using PPPoATM, pppd will notice disconnection (thus you can
+    disable LCP echos and set configure request to 100000000)
+  - Inside the kernel tree
+
+  To use the device you also need a user-mode daemon that downloads
+  the firmware and (re)initializes the modem. Currently the only
+  working one is a closed source one from Alcatel that you can get at
+  <http://www.alcateldsl.com/support.htm>.
+
+  However, there is a lot of hope, since Benoit Papillaut has written
+  an user-mode driver that contains a program that with some
+  modifications can be used to replace the closed source
+  daemon. Anyway, you will still need the Alcatel daemon package to
+  extract the modem firmware from it.
+
+  For more information, see Johan Verrept's webpages at
+  <http://linux-usb.sourceforge.net/SpeedTouch/>.
+
+  This code is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called speedtouch.o. If you want to compile it as
+  a module, say M here and read <file:Documentation/modules.txt>.
+
 USB Diamond Rio500 support
 CONFIG_USB_RIO500
   Say Y here if you want to connect a USB Rio500 mp3 player to your
diff --exclude-from=/home/ldb/src/linux-exclude -u -r -N linux-base/drivers/usb/Config.in linux/drivers/usb/Config.in
--- linux-base/drivers/usb/Config.in	Thu May 30 13:09:51 2002
+++ linux/drivers/usb/Config.in	Mon May 27 15:29:08 2002
@@ -110,5 +110,6 @@
 comment 'USB Miscellaneous drivers'
 dep_tristate '  USB Diamond Rio500 support (EXPERIMENTAL)' CONFIG_USB_RIO500 $CONFIG_USB $CONFIG_EXPERIMENTAL
 dep_tristate '  USB Auerswald ISDN support (EXPERIMENTAL)' CONFIG_USB_AUERSWALD $CONFIG_USB $CONFIG_EXPERIMENTAL
+dep_tristate '  USB Alcatel SpeedTouch USB DSL modem support (needs ATM enabled)' CONFIG_USB_SPEEDTOUCH $CONFIG_USB $CONFIG_ATM
 
 endmenu
diff --exclude-from=/home/ldb/src/linux-exclude -u -r -N linux-base/drivers/usb/Makefile linux/drivers/usb/Makefile
--- linux-base/drivers/usb/Makefile	Thu May 30 13:09:51 2002
+++ linux/drivers/usb/Makefile	Mon May 27 15:29:08 2002
@@ -90,6 +90,7 @@
 obj-$(CONFIG_USB_USBDNET)	+= usbdnet.o
 obj-$(CONFIG_USB_USBVISION)     += usbvision.o saa7111-new.o i2c-algo-usb.o
 obj-$(CONFIG_USB_AUERSWALD)	+= auerswald.o
+obj-$(CONFIG_USB_SPEEDTOUCH)	+= speedtouch.o
 
 # Object files in subdirectories
 mod-subdirs	:= serial hcd
diff --exclude-from=/home/ldb/src/linux-exclude -u -r -N linux-base/drivers/usb/speedtouch.c linux/drivers/usb/speedtouch.c
--- linux-base/drivers/usb/speedtouch.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/usb/speedtouch.c	Thu May 30 17:17:06 2002
@@ -0,0 +1,1208 @@
+/*
+ *  ATM driver for the Alcatel SpeedTouch USB DSL modem, version 2.x
+ *  Copyright 2002 Luca Barbieri
+ *  Derived from the 1.5 version of Johan Verrept's driver (see notice below).
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version 2
+ *  of the License, or (at your option) any later version.
+ *  
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *  
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *  
+ *  
+ *  Driver Module for Alcatel SpeedTouch USB xDSL modem
+ *  Copyright 2001, Alcatel
+ *  Written by Johan Verrept (Johan.Verrept@advalvas.be)
+ *  
+ *  This package is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+
+2.0 (30/may/2002, Luca Barbieri <ldb@ldb.ods.org>):
+	- lots of improvements, almost rewritten (see Configure.help entry
+	  and read this file)
+	- adaptations for inclusion in kernel tree
+
+1.5:
+	- fixed memory leak when sarlib_decode_aal5 returned NULL.
+	 (reported by stephen.robinson@zen.co.uk)
+
+1.4:
+	- changed the spin_lock() under interrupt to spin_lock_irqsave()
+	- unlink all active send urbs of a vcc that is being closed.
+
+1.3.1:
+	- added the version number
+
+1.3:
+	- Added multiple send urb support
+	- fixed memory leak and vcc->tx_inuse starvation bug
+	  when not enough memory left in vcc.
+
+1.2:
+	- Fixed race condition in udsl_usb_send_data()
+
+1.1:
+	- Turned off packet debugging
+ 
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/errno.h>
+#include <linux/proc_fs.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <asm/uaccess.h>
+#include <linux/usb.h>
+#include <linux/smp_lock.h>
+#include <linux/waitcount.h>
+
+#include <linux/atm.h>
+#include <linux/atmdev.h>
+#include <linux/atmsar.h>
+
+static const char printk_header[] = "SpeedTouch USB: ";
+
+MODULE_AUTHOR
+    ("Luca Barbieri <ldb@ldb.ods.org> (2.x), Johan Verrept <Johan.Verrept@advalvas.be> (1.x)");
+MODULE_DESCRIPTION
+    ("ATM driver for the Alcatel SpeedTouch USB DSL modem, version 2.x");
+MODULE_LICENSE("GPL");
+static const char stu_device_name[] = "Alcatel SpeedTouch USB";
+
+#undef STU_USE_SAR_THREAD
+/* #define STU_USE_SAR_THREAD 1 */
+
+#define STU_VENDORID  0x06b9
+#define STU_PRODUCTID 0x4061
+
+#define STU_NUMBER_RCV_URBS     1
+#define STU_NUMBER_SND_URBS     1
+#define STU_RECEIVE_BUFFER_SIZE 64*53
+#define STU_MAX_AAL5_MRU        2048  /* max should be (1500 IP mtu + 2 ppp bytes + 32 * 5 cellheader overhead) for PPPoA and (1500 + 14 + 32*5 cellheader overhead) for PPPoE */
+
+/* speedmgmt is the user of these ioctls */
+#define STU_IOCTL_START   1
+#define STU_IOCTL_STOP    2
+#define STU_IOCTL_RESTART 3
+
+#define STU_ENDPOINT_DATA_OUT      0x7
+#define STU_ENDPOINT_DATA_IN      0x87
+
+
+static struct usb_device_id stu_usb_ids[] = {
+	{USB_DEVICE(STU_VENDORID, STU_PRODUCTID)},
+	{}
+};
+
+/* not exporting this prevents the depmod from generating the map that causes the modules to be inserted as driver.
+ * we do not want this, we want the script run, because we need a user-mode management daemon to sync the modem
+ MODULE_DEVICE_TABLE ( usb, stu_usb_ids);
+*/
+
+
+typedef struct stu_data_ctx {
+	urb_t urb;
+	struct sk_buff *skb;
+	struct stu_instance_data *instance;
+} stu_data_ctx_t;
+
+typedef struct stu_usb_send_data_context {
+	urb_t urb;
+	struct sk_buff *skb;
+	struct atm_vcc *vcc;
+	struct stu_instance_data *instance;
+} stu_usb_send_data_context_t;
+
+/*
+ * STU main driver data
+ */
+
+#define STU_STATUS_DATA_ENABLED 0
+#define STU_STATUS_DATA_DISABLED 1
+#define STU_STATUS_DISCONNECTED 2
+
+
+
+
+struct stu_instance_data {
+	struct list_head list;
+
+	struct usb_device *usb_dev;
+	stu_data_ctx_t rcvbufs[STU_NUMBER_RCV_URBS];
+	struct sk_buff_head sndqueue;
+	stu_usb_send_data_context_t send_ctx[STU_NUMBER_SND_URBS];
+	int status;
+	rwlock_t lock;
+	atomic_t vcc_count;
+
+	struct atm_dev *atm_dev;
+
+#if STU_USE_SAR_THREAD
+	struct sk_buff_head recvqueue;
+	int threadstamp;
+#endif
+
+	struct atmsar_vcc_data *atmsar_vcc_list;
+	rwlock_t atmsar_vcc_list_lock;
+} stu_instance_t;
+
+static LIST_HEAD(devices_list);
+static rwlock_t devices_list_lock = RW_LOCK_UNLOCKED;
+
+#if STU_USE_SAR_THREAD
+static int sar_pid = 0;
+static struct completion sar_completion =
+COMPLETION_INITIALIZER(sar_completion);
+static atomic_t sar_refcnt = ATOMIC_INIT(0);
+DECLARE_WAITABLE_COUNT (sar_nzcount);
+#endif
+
+#ifdef PACKET_DEBUG
+/*******************************************************************************
+ *
+ * Debug 
+ *
+ *******************************************************************************/
+
+static int
+stu_print_packet(const unsigned char *data, int len)
+{
+	unsigned char buffer[256];
+	int i = 0, j = 0;
+
+	for (i = 0; i < len;) {
+		buffer[0] = '\0';
+		sprintf(buffer, "%.3d :", i);
+		for (j = 0; (j < 16) && (i < len); j++, i++) {
+			sprintf(buffer, "%s %2.2x", buffer, data[i]);
+		}
+		printk_dbg("%s", buffer);
+	}
+	return i;
+};
+#else
+
+#define stu_print_packet(...)
+
+#endif
+
+typedef struct stu_atm_vcc_data {
+	struct atmsar_vcc_data *atmsar_vcc;
+	struct waitable_count skb_zcount;
+} stu_atm_vcc_data_t;
+
+#define hex2int(c) ((c >= '0') && (c <= '9') ?  (c - '0') : ((c & 0xf) + 9))
+
+struct atm_dev *
+stu_atm_start(struct stu_instance_data *instance, struct atmdev_ops *devops)
+{
+	MOD_INC_USE_COUNT;
+
+	instance->atm_dev = atm_dev_register(stu_device_name, devops, -1, 0);
+	instance->atm_dev->dev_data = instance;
+	instance->atm_dev->ci_range.vpi_bits = ATM_CI_MAX;
+	instance->atm_dev->ci_range.vci_bits = ATM_CI_MAX;
+	instance->atm_dev->signal = ATM_PHY_SIG_LOST;
+
+#if STU_USE_SAR_THREAD
+	skb_queue_head_init(&instance->recvqueue);
+#endif
+
+	/* tmp init atm device, set to 128kbit */
+	instance->atm_dev->link_rate = 128 * 1000 / 424;
+
+	return instance->atm_dev;
+}
+
+void
+stu_atm_stop(struct stu_instance_data *instance)
+{
+	struct atm_vcc *walk;
+	struct atm_dev *atm_dev;
+
+	if (!instance->atm_dev)
+		return;
+
+	atm_dev = instance->atm_dev;
+
+#if STU_USE_SAR_THREAD
+	skb_queue_purge(&instance->recvqueue);
+#endif
+
+	atm_dev->signal = ATM_PHY_SIG_LOST;
+	walk = atm_dev->vccs;
+	shutdown_atm_dev(atm_dev);
+
+	/* TODO: is this really needed? */
+	for (; walk; walk = walk->next)
+		wake_up(&walk->sleep);
+
+	instance->atm_dev = NULL;
+	MOD_DEC_USE_COUNT;
+}
+
+/* called from encode */
+struct sk_buff *
+stu_atm_alloc_tx(struct atm_vcc *vcc, unsigned int size)
+{
+	atmsar_vcc_data_t *atmsar_vcc =
+	    ((struct stu_atm_vcc_data *) vcc->dev_data)->atmsar_vcc;
+
+	if (atmsar_vcc)
+		return atmsar_alloc_tx(atmsar_vcc, size);
+
+	printk_err("stu_atm_alloc_tx could not find correct alloc_tx function!\n");
+	return NULL;
+}
+
+int
+stu_atm_proc_read(struct atm_dev *atm_dev, loff_t * pos, char *page)
+{
+	int left = *pos;
+
+	if (!left--)
+		return sprintf(page,
+			       "SpeedTouch USB (%02x:%02x:%02x:%02x:%02x:%02x)\n",
+			       atm_dev->esi[0], atm_dev->esi[1],
+			       atm_dev->esi[2], atm_dev->esi[3],
+			       atm_dev->esi[4], atm_dev->esi[5]);
+
+	if (!left--)
+		return sprintf(page,
+			       "AAL0: tx %d ( %d err ), rx %d ( %d err, %d drop )\n",
+			       atomic_read(&atm_dev->stats.aal0.tx),
+			       atomic_read(&atm_dev->stats.aal0.tx_err),
+			       atomic_read(&atm_dev->stats.aal0.rx),
+			       atomic_read(&atm_dev->stats.aal0.rx_err),
+			       atomic_read(&atm_dev->stats.aal0.rx_drop));
+
+	if (!left--)
+		return sprintf(page,
+			       "AAL5: tx %d ( %d err ), rx %d ( %d err, %d drop )\n",
+			       atomic_read(&atm_dev->stats.aal5.tx),
+			       atomic_read(&atm_dev->stats.aal5.tx_err),
+			       atomic_read(&atm_dev->stats.aal5.rx),
+			       atomic_read(&atm_dev->stats.aal5.rx_err),
+			       atomic_read(&atm_dev->stats.aal5.rx_drop));
+
+	return 0;
+}
+
+typedef struct stu_cb {
+	struct atm_vcc *vcc;
+} stu_cb_t;
+
+/* doesn't sleep */
+static void
+stu_usb_send_next(urb_t * urb)
+{
+	stu_usb_send_data_context_t *ctx =
+	    (stu_usb_send_data_context_t *) urb->context;
+	struct stu_atm_vcc_data *dev_data =
+	    (struct stu_atm_vcc_data *) ctx->vcc->dev_data;
+	struct stu_instance_data *instance = ctx->instance;
+	struct sk_buff *skb;
+	int err;
+	unsigned long flags;
+
+	printk_dbg("vcc = %p, skb = %p, status %d", ctx->vcc, ctx->skb, urb->status);
+
+	read_lock(&instance->lock);
+	if (instance->status != STU_STATUS_DATA_ENABLED)
+		goto out;
+
+      errloop:
+	spin_lock_irqsave(&instance->sndqueue.lock, flags);
+
+	ctx->vcc->pop(ctx->vcc, ctx->skb);
+	/* ctx->skb = NULL; */
+
+	dec_zero (&dev_data->skb_zcount);
+
+	/* submit next skb */
+	ctx->skb = skb = __skb_dequeue(&(instance->sndqueue));
+
+	spin_unlock_irqrestore(&instance->sndqueue.lock, flags);
+
+	if (!skb)
+		goto out;
+
+	ctx->vcc = ((stu_cb_t *) (skb->cb))->vcc;
+
+	FILL_BULK_URB(urb,
+		      instance->usb_dev,
+		      usb_sndbulkpipe(instance->usb_dev, STU_ENDPOINT_DATA_OUT),
+		      (unsigned char *) skb->data,
+		      skb->len, (usb_complete_t) stu_usb_send_next, ctx);
+	urb->transfer_flags |= USB_QUEUE_BULK;
+
+	err = usb_submit_urb(urb);
+
+	if (err != 0) {
+		printk_err ("usb_submit_urb for ATM data failed (result = %d)\n", err);
+		goto errloop;
+	}
+
+	printk_dbg("send packet %p with length %d, retval = %d", ctx->skb, ctx->skb->len, err);
+
+      out:
+	read_unlock(&instance->lock);
+}
+
+/* doesn't sleep */
+int
+stu_send_encoded(struct stu_instance_data *instance, struct atm_vcc *vcc,
+		     struct sk_buff *skb)
+{
+	int i;
+	int res = 0;
+	urb_t *urb;
+	unsigned long flags;
+	stu_usb_send_data_context_t *ctx;
+	struct stu_atm_vcc_data *dev_data =
+	    (struct stu_atm_vcc_data *) vcc->dev_data;
+
+	printk_dbg("sending packet %p with length %d", skb, skb->len);
+
+	stu_print_packet(skb->data, skb->len);
+
+	((stu_cb_t *) skb->cb)->vcc = vcc;
+
+	inc_zero (&dev_data->skb_zcount);
+
+	spin_lock_irqsave(&instance->sndqueue.lock, flags);
+
+	/* we are already queueing */
+	if (!skb_queue_empty(&instance->sndqueue)) {
+		__skb_queue_tail(&instance->sndqueue, skb);
+		spin_unlock_irqrestore(&instance->sndqueue.lock, flags);
+		printk_dbg("already queing, skb (0x%p) queued", skb);
+		goto ok;
+	}
+
+	for (i = 0; i < STU_NUMBER_SND_URBS; i++)
+		if (instance->send_ctx[i].skb == NULL)
+			break;
+
+	/* we must start queueing */
+	if (i == STU_NUMBER_SND_URBS) {
+		__skb_queue_tail(&instance->sndqueue, skb);
+		spin_unlock_irqrestore(&instance->sndqueue.lock, flags);
+		printk_dbg("skb (0x%p) queued", skb);
+		goto ok;
+	};
+
+	ctx = &instance->send_ctx[i];
+	/* init context */
+	urb = &(ctx->urb);
+	ctx->skb = skb;
+	ctx->vcc = vcc;
+	ctx->instance = instance;
+
+	spin_unlock_irqrestore(&instance->sndqueue.lock, flags);
+
+	/* submit packet */
+	FILL_BULK_URB(urb,
+		      instance->usb_dev,
+		      usb_sndbulkpipe(instance->usb_dev, STU_ENDPOINT_DATA_OUT),
+		      (unsigned char *) skb->data,
+		      skb->len,
+		      (usb_complete_t) stu_usb_send_next,
+		      &(instance->send_ctx[i])
+	    );
+	urb->transfer_flags |= USB_QUEUE_BULK;
+
+	res = usb_submit_urb(urb);
+
+	if (res != 0) {
+		printk_err ("usb_submit_urb for ATM data failed (result = %d) in stu_usb_send_data", res);
+
+		stu_usb_send_next(urb);
+
+		return res;
+	}
+
+      ok:
+	printk_ok();
+	return 0;
+}
+
+/* doesn't sleep */
+int
+stu_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	struct stu_atm_vcc_data *dev_data =
+	    (struct stu_atm_vcc_data *) vcc->dev_data;
+	struct stu_instance_data *instance =
+	    (struct stu_instance_data *) vcc->dev->dev_data;
+	struct sk_buff *new = NULL;
+	int res = -EAGAIN;
+
+	printk_call();
+
+	if (!dev_data)
+		return -EINVAL;
+
+	read_lock(&instance->lock);
+	if (instance->status != STU_STATUS_DATA_ENABLED) {
+		if (instance->status == STU_STATUS_DISCONNECTED)
+			res = -ENETDOWN;
+		goto out;
+	}
+
+	/* TODO: check if sk_buff's are leaked */
+	switch (vcc->qos.aal) {
+	case ATM_AAL5:
+		if (instance->status != STU_STATUS_DATA_ENABLED) {
+			res = -EAGAIN;
+			goto out;
+		}
+
+		res = -ENOMEM;
+		new = atmsar_encode_aal5(dev_data->atmsar_vcc, skb);
+		if (!new)
+			goto out;
+		if (new != skb) {
+			vcc->pop(vcc, skb);
+			skb = new;
+		}
+		new = atmsar_encode_rawcell(dev_data->atmsar_vcc, skb);
+		if (!new)
+			goto out;
+		if (new != skb) {
+			vcc->pop(vcc, skb);
+			skb = new;
+		}
+		res = stu_send_encoded(instance, vcc, skb);
+
+		printk_res(res);
+		break;
+	default:
+		res = -EINVAL;
+	};
+
+      out:
+	read_unlock(&instance->lock);
+	return res;
+};
+
+void
+stu_sar_decode(struct stu_instance_data *instance, struct sk_buff *skb)
+{
+	struct sk_buff *new = NULL, *tmp = NULL;
+	struct atmsar_vcc_data *atmsar_vcc = NULL;
+
+	read_lock(&instance->atmsar_vcc_list_lock);
+	/* NOTE: multiple concurrent decode calls on the same device must be locked (currently we call it only here so we don't need to lock) */
+	while ((new =
+		atmsar_decode_rawcell(instance->atmsar_vcc_list, skb,
+				      &atmsar_vcc)) != NULL) {
+		printk_dbg("after cell processing: skb->len = %d", new->len);
+		switch (atmsar_vcc->type) {
+		case ATMSAR_TYPE_AAL5:
+			tmp = new;
+			new = atmsar_decode_aal5(atmsar_vcc, new);
+
+			/* we can't send NULL skbs upstream, the ATM layer would try to close the vcc... */
+			if (new) {
+				printk_dbg("after aal5 decap: skb->len = %d",
+				       new->len);
+				if (new->len
+				    && atm_charge(atmsar_vcc->vcc,
+						  new->truesize)) {
+					stu_print_packet(new->data, new->len);
+					atmsar_vcc->vcc->push(atmsar_vcc->vcc,
+							      new);
+				} else {
+					printk_dbg
+					    ("dropping incoming packet: rx_inuse = %d, vcc->sk->rcvbuf = %d, skb->true_size = %d",
+					     atomic_read(&atmsar_vcc->vcc->
+							 rx_inuse),
+					     atmsar_vcc->vcc->sk->rcvbuf,
+					     new->truesize);
+					dev_kfree_skb(new);
+				}
+			} else {
+				printk_dbg("atmsar_decode_aal5 returned NULL!");
+				dev_kfree_skb(tmp);
+			}
+			break;
+		default:
+			printk_warn("illegal vcc type: dropping packet");
+			dev_kfree_skb(new);
+			break;
+		}
+	};
+	read_unlock(&instance->atmsar_vcc_list_lock);
+	printk_dbg("freeing skb after processqueue executed");
+	dev_kfree_skb(skb);
+}
+
+#if STU_USE_SAR_THREAD
+/* doesn't sleep */
+void
+stu_sar_processqueue(struct stu_instance_data *instance)
+{
+	struct sk_buff *skb = NULL;
+
+	read_lock(&instance->lock);
+	if (instance->status != STU_STATUS_DATA_ENABLED)
+		goto out;
+
+	while ((skb = skb_dequeue(&instance->recvqueue)) != NULL) {
+		stu_sar_decode(instance, skb);
+		dec_nonzero(&sar_nzcount);
+
+		printk_dbg("skb = %p, skb->len = %d", skb, skb->len);
+		stu_print_packet(skb->data, skb->len);
+	};
+
+      out:
+	read_unlock(&instance->lock);
+}
+
+int
+stu_sar_threadproc(void *data)
+{
+	struct list_head *i;
+	int threadstamp;
+
+	lock_kernel();
+	exit_files(current);	/* daemonize doesn't do exit_files */
+	daemonize();
+
+	strcpy(current->comm, "kstusard");
+
+	for (threadstamp = 1;; threadstamp++) {
+		wait_count(&sar_nzcount, 1, TASK_INTERRUPTIBLE);
+		if (signal_pending(current))
+			break;
+		printk_dbg("kstusard awoke");
+
+	      repeat:
+		read_lock(&devices_list_lock);
+		list_for_each(i, &devices_list) {
+			struct stu_instance_data *instance =
+			    (struct stu_instance_data *) i;
+			
+			/* avoid reprocessing a device if we processed it before having to schedule */
+			if (threadstamp != instance->threadstamp) {
+				stu_sar_processqueue(instance);
+				instance->threadstamp = threadstamp;
+				if (current->need_resched) {
+					read_unlock(&devices_list_lock);
+					schedule();
+					goto repeat;
+				}
+			}
+		}
+		read_unlock(&devices_list_lock);
+	}
+
+	sar_pid = 0;
+	complete(&sar_completion);
+	printk_dbg("kstusard is exiting");
+	return 0;
+}
+
+void
+stu_sar_start(void)
+{
+	init_completion(&sar_completion);
+	sar_pid = kernel_thread(stu_sar_threadproc, (void *) NULL,
+				CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
+}
+
+void
+stu_sar_stop(void)
+{
+	int pid = sar_pid;
+	if (pid) {
+		kill_proc(pid, SIGTERM, 1);
+		wait_for_completion(&sar_completion);
+	}
+}
+#endif
+
+int
+stu_atm_open(struct atm_vcc *vcc, short vpi, int vci)
+{
+	struct stu_atm_vcc_data *dev_data;
+	struct atmsar_vcc_data *atmsar_vcc;
+	struct stu_instance_data *instance =
+	    (struct stu_instance_data *) vcc->dev->dev_data;
+
+	/* at the moment only AAL5 support */
+	if (vcc->qos.aal != ATM_AAL5)
+		return -EINVAL;
+
+	printk_call();
+
+	read_lock(&instance->lock);
+	if (instance->status == STU_STATUS_DISCONNECTED) {
+		read_unlock(&instance->lock);
+		return -ENODEV;
+	}
+
+	/* NOTE
+	   When data gets disabled (as result of loss of sync -> ioctl or device disconnection), vccs are closed and return -ENETDOWN on send/recv.
+	   However, if the cause was an ioctl, it's still possible to open vccs and get -EAGAIN on send/recv.
+
+	   The reason is that right now there is no easy way of restarting pppd when the modem gets sync and pppd terminates if open fails.
+	   Thus, open must not fail, but we obviously can't keep the old vccs because if we are using PPPoATM the ISP has probably already closed the PPP link.
+
+	   As a result we get this strange situation, which isn't so strange if you consider that the only difference from the "normal" one is that open succeeds earlier.
+	 */
+
+	instance = (struct stu_instance_data *) vcc->dev->dev_data;
+
+	atomic_inc(&instance->vcc_count);
+
+	read_unlock(&instance->lock);
+
+	dev_data =
+	    (struct stu_atm_vcc_data *)
+	    kmalloc(sizeof (struct stu_atm_vcc_data), GFP_KERNEL);
+	if (!dev_data)
+		return -ENOMEM;
+	INITIALIZE_WAITABLE_COUNT(dev_data->skb_zcount);
+
+	dev_data->atmsar_vcc =
+	    atmsar_open(&atmsar_vcc, vcc, ATMSAR_TYPE_AAL5, vpi, vci, 0, 0,
+			ATMSAR_USE_53BYTE_CELL | ATMSAR_SET_PTI);
+
+	write_lock(&instance->atmsar_vcc_list_lock);
+	atmsar_vcc->next = instance->atmsar_vcc_list;
+	instance->atmsar_vcc_list = atmsar_vcc;
+	write_unlock(&instance->atmsar_vcc_list_lock);
+
+	if (!dev_data->atmsar_vcc) {
+		kfree(dev_data);
+		return -ENOMEM;	/* this is the only reason atmsar_open can fail... */
+	}
+
+	vcc->vpi = vpi;
+	vcc->vci = vci;
+	set_bit(ATM_VF_ADDR, &vcc->flags);
+	set_bit(ATM_VF_PARTIAL, &vcc->flags);
+	set_bit(ATM_VF_READY, &vcc->flags);
+	vcc->dev_data = dev_data;
+	vcc->alloc_tx = stu_atm_alloc_tx;
+
+	dev_data->atmsar_vcc->mtu = STU_MAX_AAL5_MRU;
+
+	MOD_INC_USE_COUNT;
+
+	return 0;
+}
+
+void
+stu_cancelsends(struct stu_instance_data *instance)
+{
+	int i;
+	unsigned long flags;
+	struct sk_buff *skb;
+	
+	spin_lock_irqsave(&instance->sndqueue.lock, flags);
+	for (skb = instance->sndqueue.next;
+	     (skb != (struct sk_buff *) (&instance->sndqueue));) {
+		struct sk_buff *next = skb->next;
+		struct atm_vcc *vcc = ((stu_cb_t *) (skb->cb))->vcc;
+		struct stu_atm_vcc_data *dev_data =
+		    (struct stu_atm_vcc_data *) vcc->dev_data;
+
+		__skb_unlink(skb, &instance->sndqueue);
+		vcc->pop(vcc, skb);
+		dec_zero(&dev_data->skb_zcount);
+
+		skb = next;
+	}
+	spin_unlock_irqrestore(&instance->sndqueue.lock, flags);
+
+	for (i = 0; i < STU_NUMBER_SND_URBS; i++) {
+		stu_usb_send_data_context_t *ctx = &instance->send_ctx[i];
+		if (!ctx->skb)
+			continue;
+		usb_unlink_urb(&ctx->urb);
+	}
+
+	return;
+}
+
+void
+stu_finish_close(struct stu_instance_data *instance)
+{
+	kfree(instance);
+
+	MOD_DEC_USE_COUNT;
+}
+
+void
+stu_atm_close(struct atm_vcc *vcc)
+{
+
+	struct stu_instance_data *instance =
+	    (struct stu_instance_data *) vcc->dev->dev_data;
+	struct stu_atm_vcc_data *dev_data =
+	    (struct stu_atm_vcc_data *) vcc->dev_data;
+
+	wait_count(&dev_data->skb_zcount, 0, TASK_UNINTERRUPTIBLE);
+
+	write_lock(&instance->atmsar_vcc_list_lock);
+	atmsar_close(&(instance->atmsar_vcc_list), dev_data->atmsar_vcc);
+	write_unlock(&instance->atmsar_vcc_list_lock);
+
+	kfree(dev_data);
+	vcc->dev_data = NULL;
+	clear_bit(ATM_VF_PARTIAL, &vcc->flags);
+
+	/* freeing address */
+	vcc->vpi = ATM_VPI_UNSPEC;
+	vcc->vci = ATM_VCI_UNSPEC;
+	clear_bit(ATM_VF_ADDR, &vcc->flags);
+
+	if (atomic_dec_and_test(&instance->vcc_count)
+	    && (instance->status == STU_STATUS_DISCONNECTED)) {
+		stu_finish_close(instance);
+	}
+
+	MOD_DEC_USE_COUNT;
+
+	printk_ok();
+	return;
+};
+
+int
+stu_atm_ioctl(struct atm_dev *dev, unsigned int cmd, void *arg)
+{
+	switch (cmd) {
+	case ATM_QUERYLOOP:
+		return put_user(ATM_LM_NONE, (int *) arg) ? -EFAULT : 0;
+	default:
+		return -ENOIOCTLCMD;
+	}
+};
+
+static struct atmdev_ops stu_atm_devops = {
+	open:stu_atm_open,
+	close:stu_atm_close,
+	ioctl:stu_atm_ioctl,
+	send:stu_atm_send,
+	proc_read:stu_atm_proc_read,
+};
+
+/* doesn't sleep */
+void
+stu_usb_receive(urb_t * urb)
+{
+	stu_data_ctx_t *ctx;
+	struct stu_instance_data *instance;
+	int err;
+
+	if (!urb)
+		return;
+
+	printk_dbg("got packet %p with length %d an status %d", urb,
+	       urb->actual_length, urb->status);
+
+	ctx = (stu_data_ctx_t *) urb->context;
+	if (!ctx || !ctx->skb)
+		return;
+
+	instance = ctx->instance;
+
+	read_lock(&instance->lock);
+
+	if (instance->status == STU_STATUS_DISCONNECTED)
+		goto out;
+
+	switch (urb->status) {
+	case 0:
+		printk_dbg("processing urb with ctx %p, urb %p, skb %p", ctx, urb,
+		       ctx ? ctx->skb : NULL);
+
+		if (instance->status == STU_STATUS_DATA_ENABLED) {
+			/* update the skb structure */
+			skb_put(ctx->skb, urb->actual_length);
+
+#if STU_USE_SAR_THREAD
+			/* queue the skb for processing and wake the SAR */
+			skb_queue_tail(&instance->recvqueue, ctx->skb);
+			inc_nonzero(&sar_nzcount);
+#else
+			stu_sar_decode(instance, ctx->skb);
+#endif
+
+			/* get a new skb */
+			ctx->skb = dev_alloc_skb(STU_RECEIVE_BUFFER_SIZE);
+			if (!ctx->skb) {
+				printk_err ("dev_alloc_skb for receive buffer (%d bytes) failed: losing receive urb!", STU_RECEIVE_BUFFER_SIZE);
+				goto out;
+			}
+		}
+		break;
+	case -EPIPE:		/* stall or babble */
+		usb_clear_halt(urb->dev,
+			       usb_rcvbulkpipe(urb->dev, STU_ENDPOINT_DATA_IN));
+		break;
+	case -ENOENT:		/* buffer was unlinked */
+	case -EILSEQ:		/* unplug or timeout */
+	case -ETIMEDOUT:	/* unplug or timeout */
+		goto out;
+	default:
+		printk_err ("urb->status is an error: %d\n", urb->status);
+		goto out;
+	}
+
+	FILL_BULK_URB(urb,
+		      instance->usb_dev,
+		      usb_rcvbulkpipe(instance->usb_dev, STU_ENDPOINT_DATA_IN),
+		      (unsigned char *) ctx->skb->data,
+		      STU_RECEIVE_BUFFER_SIZE,
+		      (usb_complete_t) stu_usb_receive, ctx);
+	urb->transfer_flags |= USB_QUEUE_BULK;
+
+	if ((err = usb_submit_urb(urb)) < 0)
+		printk_err ("usb_submit_urb failed: %d\n", err);
+
+      out:
+	read_unlock(&instance->lock);
+}
+
+/* doesn't sleep */
+int
+__stu_data_enable(struct stu_instance_data *instance)
+{
+	int i, succes, res;
+
+	/* set alternate setting 1 on interface 1 */
+	usb_set_interface(instance->usb_dev, 1, 2);
+
+	printk_dbg("max packet size on endpoint %d is %d", STU_ENDPOINT_DATA_OUT,
+	       usb_maxpacket(instance->usb_dev,
+			     usb_sndbulkpipe(instance->usb_dev,
+					     STU_ENDPOINT_DATA_OUT), 0));
+
+	for (i = 0, succes = 0; i < STU_NUMBER_RCV_URBS; i++) {
+		stu_data_ctx_t *ctx = &(instance->rcvbufs[i]);
+
+		ctx->skb = dev_alloc_skb(STU_RECEIVE_BUFFER_SIZE);
+		if (!ctx->skb) {
+			printk_err ("dev_alloc_skb for receive buffer (%d bytes) failed: losing receive urb!", STU_RECEIVE_BUFFER_SIZE);
+			continue;
+		}
+
+		ctx->instance = instance;
+
+		FILL_BULK_URB(&ctx->urb,
+			      instance->usb_dev,
+			      usb_rcvbulkpipe(instance->usb_dev,
+					      STU_ENDPOINT_DATA_IN),
+			      (unsigned char *) ctx->skb->data,
+			      STU_RECEIVE_BUFFER_SIZE,
+			      (usb_complete_t) stu_usb_receive, ctx);
+		ctx->urb.transfer_flags |= USB_QUEUE_BULK;
+
+		printk_dbg("submitting receive urb with skb->truesize = %d (asked for %d)",
+		       ctx->skb->truesize, STU_RECEIVE_BUFFER_SIZE);
+
+		if ((res = usb_submit_urb(&ctx->urb)) < 0)
+			printk_dbg("submit failed (%d): losing receive urb!", res);
+		else
+			succes++;
+	}
+
+#if STU_USE_SAR_THREAD
+	atomic_inc(&sar_refcnt);
+	if (!sar_pid)
+		stu_sar_start();
+#endif
+
+	instance->atm_dev->signal = ATM_PHY_SIG_FOUND;
+
+	printk_dbg("%d urb%s queued for receive", succes,
+	       (succes != 1) ? "s" : "");
+
+	return 0;
+}
+
+/* doesn't sleep */
+int
+__stu_data_disable(struct stu_instance_data *instance)
+{
+	int i;
+	struct atmsar_vcc_data *vcc;
+
+	printk_call();
+
+	instance->atm_dev->signal = ATM_PHY_SIG_LOST;
+
+	/* destroy urbs */
+	for (i = 0; i < STU_NUMBER_RCV_URBS; i++) {
+		stu_data_ctx_t *ctx = &(instance->rcvbufs[i]);
+
+		/* must be done before unlink to prevent deadlock */
+		if (ctx->skb) {
+			printk_dbg("freeing skb");
+			kfree_skb(ctx->skb);
+			ctx->skb = NULL;
+		}
+
+		usb_unlink_urb(&ctx->urb);
+	};
+
+#if STU_USE_SAR_THREAD
+	if (atomic_dec_and_test(&sar_refcnt)) {
+		stu_sar_stop();
+	}
+#endif
+
+	stu_cancelsends(instance);
+
+	read_lock(&instance->atmsar_vcc_list_lock);
+	for (vcc = instance->atmsar_vcc_list; vcc; vcc = vcc->next) {
+		atm_async_release_vcc(vcc->vcc, -ENETDOWN);
+		vcc->vcc->push(vcc->vcc, NULL);	/* close PPPoATM */
+	}
+	read_unlock(&instance->atmsar_vcc_list_lock);
+
+	return 0;
+};
+
+int
+stu_data_disable(struct stu_instance_data *instance)
+{
+	int res = 0;
+	unsigned long flags;
+
+	write_lock_irqsave(&instance->lock, flags);
+
+	if (instance->status != STU_STATUS_DATA_ENABLED)
+		goto out;
+
+	printk_info ("disabling data transmission");
+	res = __stu_data_disable(instance);
+
+	instance->status = STU_STATUS_DATA_DISABLED;
+
+      out:
+	write_unlock_irqrestore(&instance->lock, flags);
+	return res;
+}
+
+int
+stu_data_enable(struct stu_instance_data *instance)
+{
+	int res = 0;
+	unsigned long flags;
+
+	write_lock_irqsave(&instance->lock, flags);
+
+	if (instance->status != STU_STATUS_DATA_DISABLED)
+		goto out;
+
+	printk_info ("enabling data transmission");
+	res = __stu_data_enable(instance);
+
+	instance->status = STU_STATUS_DATA_ENABLED;
+
+      out:
+	write_unlock_irqrestore(&instance->lock, flags);
+	return res;
+}
+
+int
+stu_data_restart(struct stu_instance_data *instance)
+{
+	int res = 0;
+	unsigned long flags;
+
+	write_lock_irqsave(&instance->lock, flags);
+
+	printk_info ("restarting data transmission");	
+	if (instance->status)
+		__stu_data_disable(instance);
+
+	res = __stu_data_enable(instance);
+
+	instance->status = 1;
+
+	write_unlock_irqrestore(&instance->lock, flags);
+	return res;
+}
+
+static int
+stu_usb_ioctl(struct usb_device *dev, unsigned int code, void *user_data)
+{
+	struct stu_instance_data *instance = NULL;
+	struct list_head *i;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* Sigh... we don't have any direct to way to get our instance data... fix usb! */
+	read_lock(&devices_list_lock);
+	list_for_each(i, &devices_list) {
+		if (((struct stu_instance_data *) i)->usb_dev == dev) {
+			instance = (struct stu_instance_data *) i;
+			break;
+		}
+	}
+	read_unlock(&devices_list_lock);
+
+	if (!instance)
+		return -EINVAL;
+
+	switch (code) {
+	case STU_IOCTL_RESTART:
+		return stu_data_restart(instance);
+	case STU_IOCTL_STOP:
+		return stu_data_disable(instance);
+	case STU_IOCTL_START:
+		return stu_data_enable(instance);
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+void *
+stu_usb_probe(struct usb_device *dev, unsigned int ifnum,
+	      const struct usb_device_id *id)
+{
+	int i;
+	unsigned char mac[6];
+	unsigned char mac_str[13];
+	struct stu_instance_data *instance = NULL;
+
+	printk_dbg("trying device with vendor=0x%x, product=0x%x, ifnum %d",
+	       dev->descriptor.idVendor, dev->descriptor.idProduct, ifnum);
+
+	if ((dev->descriptor.bDeviceClass != USB_CLASS_VENDOR_SPEC) ||
+	    (dev->descriptor.idVendor != STU_VENDORID) ||
+	    (dev->descriptor.idProduct != STU_PRODUCTID) || (ifnum != 1))
+		return NULL;
+
+	MOD_INC_USE_COUNT;
+
+	instance = kmalloc(sizeof (struct stu_instance_data), GFP_KERNEL);
+	if (!instance) {
+		printk_err ("kmalloc for instance data (size %u) failed!",
+		     sizeof (struct stu_instance_data));
+		return NULL;
+	}
+
+	memset(instance, 0, sizeof (struct stu_instance_data));
+	instance->usb_dev = dev;
+	skb_queue_head_init(&instance->sndqueue);
+	rwlock_init(&instance->lock);
+	rwlock_init(&instance->atmsar_vcc_list_lock);
+	instance->status = STU_STATUS_DATA_DISABLED;
+
+	stu_atm_start(instance, &stu_atm_devops);
+	if (!instance->atm_dev) {
+		printk_err ("couldn't start ATM device");
+		return NULL;
+	}
+
+	/* MAC address is in serial number */
+	usb_string(instance->usb_dev,
+		   instance->usb_dev->descriptor.iSerialNumber, mac_str, 13);
+	for (i = 0; i < 6; i++)
+		mac[i] =
+		    (hex2int(mac_str[i * 2]) * 16) +
+		    (hex2int(mac_str[i * 2 + 1]));
+
+	printk_info("handling device with vendor=0x%x, product=0x%x, ifnum=%d, mac=%02x:%02x:%02x:%02x:%02x:%02x",
+		dev->descriptor.idVendor, dev->descriptor.idProduct, ifnum, mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);	
+	
+	memcpy(instance->atm_dev->esi, mac, 6);
+
+	write_lock(&devices_list_lock);
+	list_add_tail(&instance->list, &devices_list);
+	write_unlock(&devices_list_lock);
+
+	return instance;
+}
+
+void
+stu_usb_disconnect(struct usb_device *dev, void *ptr)
+{
+	struct stu_instance_data *instance = (struct stu_instance_data *) ptr;
+	unsigned long flags;
+
+	write_lock_irqsave(&instance->lock, flags);
+
+	if (instance->status == STU_STATUS_DATA_ENABLED)
+		__stu_data_disable(instance);
+
+	instance->status = STU_STATUS_DISCONNECTED;
+
+	if (instance->atm_dev)
+		stu_atm_stop(instance);
+
+	printk_info("device disconnected");
+
+	write_unlock_irqrestore(&instance->lock, flags);
+
+	write_lock(&devices_list_lock);
+	list_del(&instance->list);
+	write_unlock(&devices_list_lock);
+
+	if (!atomic_read(&instance->vcc_count))
+		stu_finish_close(instance);
+}
+
+static struct usb_driver stu_usb_driver = {
+	name: stu_device_name,
+	probe: stu_usb_probe,
+	disconnect: stu_usb_disconnect,
+	ioctl: stu_usb_ioctl,
+	id_table: stu_usb_ids,
+};
+
+int
+stu_mod_init(void)
+{
+	printk_dbg("initializing %s", __module_description);
+
+	return usb_register(&stu_usb_driver);
+}
+
+int
+stu_mod_cleanup(void)
+{
+#if STU_USE_SAR_THREAD
+	stu_sar_stop();
+#endif
+
+	usb_deregister(&stu_usb_driver);
+	return 0;
+}
+
+#ifdef MODULE
+int
+init_module(void)
+{
+	return stu_mod_init();
+}
+
+int
+cleanup_module(void)
+{
+	return stu_mod_cleanup();
+}
+#endif

--=-uN67HeQs0ONrJXRFq53X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA89mvCdjkty3ft5+cRAqLmAJ0aX4E2FtZimnSks9kVEB43Up6mhwCgzAwD
l8o7HcKqnH/2CiMGenOXhNQ=
=9Yl5
-----END PGP SIGNATURE-----

--=-uN67HeQs0ONrJXRFq53X--
