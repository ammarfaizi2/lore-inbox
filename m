Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWALRYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWALRYO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWALRYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:24:13 -0500
Received: from mout1.freenet.de ([194.97.50.132]:48329 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932404AbWALRYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:24:10 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: WCONF, netlink based WE replacement.
Date: Thu, 12 Jan 2006 18:24:02 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Message-Id: <200601121824.02892.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart10633257.KghmLRjcGv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10633257.KghmLRjcGv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This is an attempt to rewrite the Wireless Extensions
userspace API, using netlink sockets.
There should also be a notification API, to inform
userspace for changes (config changes, state changes, etc).
It is not implemented, yet.

This is against the devicescape stack.
This patch is not to be used, but only to be commented on. ;)
Basically I would like comments on the API definition
in wconf.h


diff -urNX linux-2.6.15-ds060105.orig/Documentation/dontdiff linux-2.6.15-d=
s060105.orig/include/net/ieee80211.h linux-2.6.15-ds060105/include/net/ieee=
80211.h
=2D-- linux-2.6.15-ds060105.orig/include/net/ieee80211.h	2006-01-08 02:10:4=
6.000000000 +0100
+++ linux-2.6.15-ds060105/include/net/ieee80211.h	2006-01-09 16:22:59.00000=
0000 +0100
@@ -10,6 +10,8 @@
 #ifndef IEEE80211_H
 #define IEEE80211_H
=20
+#include <linux/netdevice.h>
+#include <net/wconf.h>
 #include "ieee80211_shared.h"
=20
 /* Note! Only ieee80211_tx_status_irqsafe() and ieee80211_rx_irqsave() can=
 be
@@ -591,35 +593,41 @@
 	int (*atheros_xr_in_use)(struct net_device *dev, int in_use);
 };
=20
+struct ieee80211_device {
+	/* Device name string. Usually "wlanX". */
+	__u8 name[IFNAMSIZ + 1];
+	/* Hardware data. */
+	struct ieee80211_hw *hw;
+	/* Wireless Configuration data. */
+	struct wconf_device *wconf;
+	struct net_device *dev;/*TODO: We want to get rid of the master net_device
+				 	and use ieee80211_device instead. */
+};
+
 /* Allocate a new hardware device. This must be called once for each
  * hardware device. The returned pointer must be used to refer to this
  * device when calling other functions. 802.11 code allocates a private da=
ta
  * area for the low-level driver. The size of this area is given as
  * priv_data_len. ieee80211_dev_hw_data() is used to get a pointer to the
=2D * private data area.
=2D *
=2D * Note: in this version of the interface the returned pointer is struct
=2D * net_device *. This may change in the future and low-level driver shou=
ld
=2D * not refer the device data directly to remain compatible with the futu=
re
=2D * versions of the interface. */
=2Dstruct net_device *ieee80211_alloc_hw(size_t priv_data_len,
=2D				      void (*setup)(struct net_device *));
+ * private data area. */
+struct ieee80211_device * ieee80211_alloc_hw(size_t priv_data_len,
+					     void (*setup)(struct net_device *));
=20
 /* Register hardware device to the IEEE 802.11 code and kernel. Low-level
  * drivers must call this function before using any other IEEE 802.11
  * function. */
=2Dint ieee80211_register_hw(struct net_device *dev, struct ieee80211_hw *h=
w);
+int ieee80211_register_hw(struct ieee80211_device *dev, struct ieee80211_h=
w *hw);
=20
 /* This function is allowed to update hardware configuration (e.g., list of
  * supported operation modes and rates). */
=2Dint ieee80211_update_hw(struct net_device *dev, struct ieee80211_hw *hw);
+int ieee80211_update_hw(struct ieee80211_device *dev, struct ieee80211_hw =
*hw);
=20
 /* Unregister a hardware device. This function instructs 802.11 code to fr=
ee
  * allocated resources and unregister netdevices from the kernel. */
=2Dvoid ieee80211_unregister_hw(struct net_device *dev);
+void ieee80211_unregister_hw(struct ieee80211_device *dev);
=20
 /* Free allocated net_device including private data of a driver. */
=2Dvoid ieee80211_free_hw(struct net_device *dev);
+void ieee80211_free_hw(struct ieee80211_device *dev);
=20
 /* Receive frame callback function. The low-level driver uses this functio=
n to
  * send received frames to the IEEE 802.11 code. Receive buffer (skb) must
diff -urNX linux-2.6.15-ds060105.orig/Documentation/dontdiff linux-2.6.15-d=
s060105.orig/include/net/wconf.h linux-2.6.15-ds060105/include/net/wconf.h
=2D-- linux-2.6.15-ds060105.orig/include/net/wconf.h	1970-01-01 01:00:00.00=
0000000 +0100
+++ linux-2.6.15-ds060105/include/net/wconf.h	2006-01-11 21:53:55.000000000=
 +0100
@@ -0,0 +1,151 @@
+/* wconf -- Linux Wireless Networking configuration interface. */
+
+#ifndef LINUX_WCONF_H_
+#define LINUX_WCONF_H_
+
+#include <linux/types.h>
+#include <linux/if.h>
+
+#define ESSID_MAX	32
+#define NETLINK_WCONF	17	/*TODO: move me to linux/netlink.h and assign a s=
ane number. */
+
+/*** USERMODE API ***/
+
+/*TODO: This is currently only a configuration-parameter API (like WE curr=
ently is)
+ *      This must be extened with a (separate) notification interface.
+ */
+
+enum {
+	WCONF_CMD_NAME,
+	WCONF_CMD_NICK,
+	WCONF_CMD_MODE,
+	WCONF_CMD_CHANNEL,
+	WCONF_CMD_SENSITIVITY,
+	//TODO
+	WCONF_NR_STANDARD, /* Number of standard commands. */
+	WCONF_CMD_FIRSTPRIV	=3D 0x0001FFFF,
+	WCONF_CMD_LASTPRIV	=3D 0xFFFFFFFF,
+};
+
+enum {
+	WCONF_MODE_AUTO,	/* Let the driver decides */
+	WCONF_MODE_ADHOC,	/* Single cell network */
+	WCONF_MODE_INFRA,	/* Multi cell network, roaming, ... */
+	WCONF_MODE_MASTER,	/* Synchronisation master or Access Point */
+	WCONF_MODE_REPEAT,	/* Wireless Repeater (forwarder) */
+	WCONF_MODE_SECOND,	/* Secondary master/repeater (backup) */
+	WCONF_MODE_MONITOR,	/* Passive monitor (listen only) */
+};
+
+struct wconf_cmd_name {
+	__u8 name[IFNAMSIZ];
+};
+
+struct wconf_cmd_nick {
+	__u8 nick[ESSID_MAX];
+};
+
+struct wconf_cmd_mode {
+	int mode;
+};
+
+struct wconf_cmd_channel {
+	/** Frequency in KHz, or channel number if < 1000 */
+	__u32	freq;
+	__u8	flags;
+#define WCONF_CHAN_AUTO		(1 << 0)
+#define WCONF_CHAN_FIXED	(1 << 1)
+};
+
+struct wconf_cmd_sensitivity {
+};
+//TODO
+
+struct wconf_message {
+	__u16	wconf_ver;
+#define WCONF_VERSION		1
+	__u8	dest[IFNAMSIZ + 1];
+	__u32	command;
+	__u32	flags;
+#define WCONF_FLAG_SET		(1 << 0)
+#define WCONF_FLAG_REPLY	(1 << 1)
+	__u32	seq;
+	__u32	reserved;
+	int	errorcode;
+	union {
+		struct wconf_cmd_name		name;
+		struct wconf_cmd_nick		nick;
+		struct wconf_cmd_mode		mode;
+		struct wconf_cmd_channel	channel;
+		struct wconf_cmd_sensitivity	sensitivity;
+		//TODO
+	};
+};
+
+
+#ifdef __KERNEL__
+
+/*** KERNEL API (Driver and internal) ***/
+
+/*TODO: Handler functions are currently not implemented. They must be hook=
ed up by the
+ *      ieee80211 subsystem (and must be implemented as part of the ieee80=
211 subsys).
+ *      Where applicable, the drivers must re-hook the handler functions (=
for hardware
+ *      MAC for example).
+ */
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <net/ieee80211.h>
+
+struct sock;
+struct ieee80211_device;
+
+/** Function type for standard and private handler functions. */
+typedef int (* wconf_handler_t)(struct ieee80211_device *dev,
+				struct wconf_message *msg);
+
+struct wconf_privhandler_table {
+	/** Number of "handlers" */
+	size_t nr_handlers;
+	/** Array of handler-function-pointers.
+	  * This array is accessed by
+	  * (WCONF_CMD_FIRSTPRIV - (priv command)) index.
+	  */
+	wconf_handler_t *handlers;
+};
+
+struct wconf_device {
+	struct list_head list;
+	spinlock_t lock;
+
+	struct ieee80211_device *dev;
+	wconf_handler_t handlers[WCONF_NR_STANDARD];
+	struct wconf_privhandler_table priv_handlers;
+};
+
+/*** DRIVER API ***/
+
+/** Hook one of the standard handlers.
+  * Returns the old handler (or NULL if there wasn't one)
+  */
+wconf_handler_t wconf_handler_hook(struct wconf_device *dev,
+				   __u32 command,
+				   wconf_handler_t new_handler);
+
+/** Set the private handlers table.
+  * "table" is copied, so can be temporal and deleted after this
+  * function returns.
+  */
+int wconf_set_privhandlers(struct wconf_device *wd,
+			   struct wconf_privhandler_table *table);
+
+
+/*** INTERNAL API ***/
+
+int wconf_register(struct ieee80211_device *dev);
+void wconf_unregister(struct ieee80211_device *dev);
+int wconf_init(void);
+void wconf_exit(void);
+
+#endif /* __KERNEL__ */
+#endif /* LINUX_WCONF_H_ */
diff -urNX linux-2.6.15-ds060105.orig/Documentation/dontdiff linux-2.6.15-d=
s060105.orig/net/ieee80211/ieee80211.c linux-2.6.15-ds060105/net/ieee80211/=
ieee80211.c
=2D-- linux-2.6.15-ds060105.orig/net/ieee80211/ieee80211.c	2006-01-08 02:09=
:46.000000000 +0100
+++ linux-2.6.15-ds060105/net/ieee80211/ieee80211.c	2006-01-10 22:06:55.000=
000000 +0100
@@ -24,6 +24,7 @@
 #include <linux/wireless.h>
 #include <net/iw_handler.h>
 #include <linux/compiler.h>
+#include <net/wconf.h>
=20
 #include <net/ieee80211.h>
 #include <net/ieee80211_common.h>
@@ -4359,13 +4360,14 @@
 }
=20
=20
=2Dstruct net_device *ieee80211_alloc_hw(size_t priv_data_len,
=2D				      void (*setup)(struct net_device *))
+struct ieee80211_device *ieee80211_alloc_hw(size_t priv_data_len,
+					    void (*setup)(struct net_device *))
 {
 	struct net_device *dev, *apdev, *mdev;
         struct ieee80211_local *local;
         struct ieee80211_sub_if_data *sdata;
 	int alloc_size;
+	struct ieee80211_device *ieee;
=20
 	/* Ensure 32-bit alignment of our private data and hw private data.
 	 * Each net_device is followed by a sub_if_data which which is used
@@ -4404,6 +4406,14 @@
 	if (mdev =3D=3D NULL)
 		return NULL;
=20
+	//TODO: This is only a tempoary hack.
+	ieee =3D kzalloc(sizeof(*ieee), GFP_KERNEL);
+	if (!ieee) {
+		kfree(mdev);
+		return NULL;
+	}
+	ieee->dev =3D mdev;
+
         mdev->priv =3D (struct net_device *)
                 (((long) mdev +
                   sizeof(struct net_device) +
@@ -4539,16 +4549,16 @@
 	if (setup)
 		setup(mdev);
=20
=2D	return mdev;
+	return ieee;
=20
  fail:
=2D	ieee80211_free_hw(mdev);
+	ieee80211_free_hw(ieee);
 	return NULL;
 }
=20
=2Dint ieee80211_register_hw(struct net_device *dev, struct ieee80211_hw *h=
w)
+int ieee80211_register_hw(struct ieee80211_device *dev, struct ieee80211_h=
w *hw)
 {
=2D        struct ieee80211_local *local =3D dev->priv;
+        struct ieee80211_local *local =3D dev->dev->priv;
 	int result;
=20
 	if (!hw)
@@ -4560,6 +4570,7 @@
 		       IEEE80211_VERSION, hw->version);
 		return -1;
 	}
+	dev->hw =3D hw;
=20
 	local->conf.mode =3D IW_MODE_MASTER;
 	local->conf.beacon_int =3D 1000;
@@ -4568,19 +4579,24 @@
=20
 	sta_info_start(local);
=20
+	result =3D wconf_register(dev);
+	if (result)
+		goto stop;
+
 	result =3D register_netdev(local->wdev);
 	if (result < 0)
=2D		return -1;
+		goto wconf_unreg;
=20
 	result =3D register_netdev(local->apdev);
 	if (result < 0)
 		goto fail_2nd_dev;
=20
 	if (hw->fraglist)
=2D		dev->features |=3D NETIF_F_FRAGLIST;
=2D	result =3D register_netdev(dev);
+		dev->dev->features |=3D NETIF_F_FRAGLIST;
+	result =3D register_netdev(dev->dev);
 	if (result < 0)
 		goto fail_3rd_dev;
+	strcpy(dev->name, dev->dev->name);
=20
 	if (rate_control_initialize(local) < 0) {
 		printk(KERN_DEBUG "%s: Failed to initialize rate control "
@@ -4589,25 +4605,28 @@
 	}
=20
 	/* TODO: add rtnl locking around device creation and qdisc install */
=2D	ieee80211_install_qdisc(dev);
+	ieee80211_install_qdisc(dev->dev);
=20
         ieee80211_wep_init(local);
 	ieee80211_proc_init_interface(local);
 	return 0;
=20
 fail_rate:
=2D	unregister_netdev(dev);
+	unregister_netdev(dev->dev);
 fail_3rd_dev:
 	unregister_netdev(local->apdev);
 fail_2nd_dev:
 	unregister_netdev(local->wdev);
+wconf_unreg:
+	wconf_unregister(dev);
+stop:
 	sta_info_stop(local);
 	return result;
 }
=20
=2Dint ieee80211_update_hw(struct net_device *dev, struct ieee80211_hw *hw)
+int ieee80211_update_hw(struct ieee80211_device *dev, struct ieee80211_hw =
*hw)
 {
=2D        struct ieee80211_local *local =3D dev->priv;
+        struct ieee80211_local *local =3D dev->dev->priv;
=20
 	local->hw =3D hw;
=20
@@ -4616,17 +4635,17 @@
 	if (hw->queues =3D=3D 0)
 		hw->queues =3D 1;
=20
=2D	memcpy(local->apdev->dev_addr, dev->dev_addr, ETH_ALEN);
=2D	local->apdev->base_addr =3D dev->base_addr;
=2D	local->apdev->irq =3D dev->irq;
=2D	local->apdev->mem_start =3D dev->mem_start;
=2D	local->apdev->mem_end =3D dev->mem_end;
=2D
=2D        memcpy(local->wdev->dev_addr, dev->dev_addr, ETH_ALEN);
=2D	local->wdev->base_addr =3D dev->base_addr;
=2D	local->wdev->irq =3D dev->irq;
=2D	local->wdev->mem_start =3D dev->mem_start;
=2D	local->wdev->mem_end =3D dev->mem_end;
+	memcpy(local->apdev->dev_addr, dev->dev->dev_addr, ETH_ALEN);
+	local->apdev->base_addr =3D dev->dev->base_addr;
+	local->apdev->irq =3D dev->dev->irq;
+	local->apdev->mem_start =3D dev->dev->mem_start;
+	local->apdev->mem_end =3D dev->dev->mem_end;
+
+        memcpy(local->wdev->dev_addr, dev->dev->dev_addr, ETH_ALEN);
+	local->wdev->base_addr =3D dev->dev->base_addr;
+	local->wdev->irq =3D dev->dev->irq;
+	local->wdev->mem_start =3D dev->dev->mem_start;
+	local->wdev->mem_end =3D dev->dev->mem_end;
=20
 	if (!hw->modes || !hw->modes->channels || !hw->modes->rates ||
 	    !hw->modes->num_channels || !hw->modes->num_rates)
@@ -4636,7 +4655,7 @@
 	local->conf.phymode =3D hw->modes[0].mode;
 	local->curr_rates =3D hw->modes[0].rates;
 	local->num_curr_rates =3D hw->modes[0].num_rates;
=2D	ieee80211_prepare_rates(dev);
+	ieee80211_prepare_rates(dev->dev);
=20
 	local->conf.freq =3D local->hw->modes[0].channels[0].freq;
 	local->conf.channel =3D local->hw->modes[0].channels[0].chan;
@@ -4646,22 +4665,24 @@
 	return 0;
 }
=20
=2Dvoid ieee80211_unregister_hw(struct net_device *dev)
+void ieee80211_unregister_hw(struct ieee80211_device *dev)
 {
=2D	struct ieee80211_local *local =3D dev->priv;
+	struct ieee80211_local *local =3D dev->dev->priv;
         struct list_head *ptr, *n;
 	int i;
=20
         tasklet_disable(&local->tasklet);
         /* TODO: skb_queue should be empty here, no need to do anything? */
=20
+	wconf_unregister(dev);
+
 	if (local->rate_limit)
 		del_timer_sync(&local->rate_limit_timer);
 	if (local->stat_time)
 		del_timer_sync(&local->stat_timer);
 	if (local->scan_timer.data)
 		del_timer_sync(&local->scan_timer);
=2D	ieee80211_rx_bss_list_deinit(dev);
+	ieee80211_rx_bss_list_deinit(dev->dev);
=20
 	list_for_each_safe(ptr, n, &local->sub_if_list) {
 		struct ieee80211_sub_if_data *sdata =3D
@@ -4687,19 +4708,20 @@
=20
 	if (skb_queue_len(&local->skb_queue)
 			|| skb_queue_len(&local->skb_queue_unreliable))
=2D		printk(KERN_WARNING "%s: skb_queue not empty", dev->name);
+		printk(KERN_WARNING "%s: skb_queue not empty", dev->dev->name);
 	skb_queue_purge(&local->skb_queue);
 	skb_queue_purge(&local->skb_queue_unreliable);
=20
 	rate_control_free(local);
 }
=20
=2Dvoid ieee80211_free_hw(struct net_device *dev)
+void ieee80211_free_hw(struct ieee80211_device *dev)
 {
=2D	struct ieee80211_local *local =3D dev->priv;
+	struct ieee80211_local *local =3D dev->dev->priv;
=20
 	kfree(local->sta_devs);
 	kfree(local->bss_devs);
+	kfree(dev->dev);
 	kfree(dev);
 }
=20
@@ -4819,7 +4841,9 @@
=20
 static int __init ieee80211_init(void)
 {
+	int err;
 	struct sk_buff *skb;
+
 	if (sizeof(struct ieee80211_tx_packet_data) > (sizeof(skb->cb))) {
 		printk("80211: ieee80211_tx_packet_data is bigger "
 		       "than the skb->cb (%d > %d)\n",
@@ -4828,18 +4852,23 @@
 		return -EINVAL;
 	}
=20
+	err =3D wconf_init();
+	if (err)
+		goto out;
 	ieee80211_proc_init();
=2D	{
=2D		int ret =3D ieee80211_wme_register();
=2D		if (ret) {
=2D			printk(KERN_DEBUG "ieee80211_init: failed to "
=2D			       "initialize WME (err=3D%d)\n", ret);
=2D			ieee80211_proc_deinit();
=2D			return ret;
=2D		}
+	err =3D ieee80211_wme_register();
+	if (err) {
+		printk(KERN_DEBUG "ieee80211_init: failed to "
+		       "initialize WME (err=3D%d)\n", err);
+		goto err_proc;
 	}
=20
=2D	return 0;
+out:
+	return err;
+err_proc:
+	ieee80211_proc_deinit();
+	wconf_exit();
+	goto out;
 }
=20
=20
@@ -4847,6 +4876,7 @@
 {
 	ieee80211_wme_unregister();
 	ieee80211_proc_deinit();
+	wconf_exit();
 }
=20
=20
diff -urNX linux-2.6.15-ds060105.orig/Documentation/dontdiff linux-2.6.15-d=
s060105.orig/net/ieee80211/Makefile linux-2.6.15-ds060105/net/ieee80211/Mak=
efile
=2D-- linux-2.6.15-ds060105.orig/net/ieee80211/Makefile	2006-01-08 02:09:46=
=2E000000000 +0100
+++ linux-2.6.15-ds060105/net/ieee80211/Makefile	2006-01-08 02:53:10.000000=
000 +0100
@@ -12,7 +12,8 @@
 	michael.o \
 	tkip.o \
 	aes_ccm.o \
=2D	wme.o
+	wme.o \
+	wconf.o
=20
 ifeq ($(CONFIG_NET_SCHED),)
   80211-objs +=3D fifo_qdisc.o
diff -urNX linux-2.6.15-ds060105.orig/Documentation/dontdiff linux-2.6.15-d=
s060105.orig/net/ieee80211/wconf.c linux-2.6.15-ds060105/net/ieee80211/wcon=
f.c
=2D-- linux-2.6.15-ds060105.orig/net/ieee80211/wconf.c	1970-01-01 01:00:00.=
000000000 +0100
+++ linux-2.6.15-ds060105/net/ieee80211/wconf.c	2006-01-11 21:56:42.0000000=
00 +0100
@@ -0,0 +1,221 @@
+#include <net/wconf.h>
+#include <net/netlink.h>
+#include <net/sock.h>
+#include <linux/netlink.h>
+#include <linux/slab.h>
+#include <linux/socket.h>
+#include <linux/skbuff.h>
+
+#define PFX	"WCONF: "
+
+static struct wconf {
+	/* Netlink socket. */
+	struct sock *nl;
+	/* List of all devices. */
+	struct list_head devices;
+	spinlock_t lock;
+} wc;
+
+
+static inline
+int is_priv_command(u32 cmd)
+{
+	return (cmd >=3D WCONF_CMD_FIRSTPRIV && cmd <=3D WCONF_CMD_LASTPRIV);
+}
+
+static int wconf_handle_message(struct wconf_device *wd,
+				struct wconf_message *msg)
+{
+	u32 command =3D msg->command;
+	wconf_handler_t handler;
+	unsigned long flags;
+	int err =3D -EINVAL;
+
+	spin_lock_irqsave(&wd->lock, flags);
+	if (is_priv_command(command)) {
+		command -=3D WCONF_CMD_FIRSTPRIV;
+		if (command >=3D wd->priv_handlers.nr_handlers) {
+			printk(KERN_ERR PFX "Unknown private command\n");
+			goto out_unlock;
+		}
+		handler =3D wd->priv_handlers.handlers[command];
+	} else {
+		if (command >=3D WCONF_NR_STANDARD) {
+			printk(KERN_ERR PFX "Unknown command\n");
+			goto out_unlock;
+		}
+		handler =3D wd->handlers[command];
+	}
+	if (!handler) {
+		err =3D -EOPNOTSUPP;
+		goto out_unlock;
+	}
+	err =3D handler(wd->dev, msg);
+
+out_unlock:
+	spin_unlock_irqrestore(&wd->lock, flags);
+
+	return err;
+}
+
+wconf_handler_t wconf_handler_hook(struct wconf_device *wd,
+				   __u32 command,
+				   wconf_handler_t new_handler)
+{
+	wconf_handler_t old_handler;
+	unsigned long flags;
+
+	BUG_ON(is_priv_command(command));
+	BUG_ON(command >=3D WCONF_NR_STANDARD);
+	spin_lock_irqsave(&wd->lock, flags);
+	old_handler =3D wd->handlers[command];
+	wd->handlers[command] =3D new_handler;
+	spin_unlock_irqrestore(&wd->lock, flags);
+
+	return old_handler;
+}
+EXPORT_SYMBOL_GPL(wconf_handler_hook);
+
+int wconf_set_privhandlers(struct wconf_device *wd,
+			   struct wconf_privhandler_table *table)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wd->lock, flags);
+	memcpy(&wd->priv_handlers, table, sizeof(*table));
+	spin_unlock_irqrestore(&wd->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wconf_set_privhandlers);
+
+static struct wconf_device * find_wconf(u8 *name)
+{
+	struct wconf_device *wd;
+
+	list_for_each_entry(wd, &wc.devices, list) {
+		if (strcmp(wd->dev->name, name) =3D=3D 0)
+			return wd;
+	}
+
+	return NULL;
+}
+
+static int wconf_send_reply(struct sock *sk,
+			    u32 pid,
+			    struct wconf_message *msg)
+{
+	struct nlmsghdr *nlh;
+	struct sk_buff *skb;
+
+	skb =3D __dev_alloc_skb(NLMSG_SPACE(sizeof(struct wconf_message)),
+			      GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+	nlh =3D (struct nlmsghdr *)skb->data;
+	nlh->nlmsg_len =3D NLMSG_SPACE(sizeof(struct wconf_message));
+	nlh->nlmsg_pid =3D 0;
+	nlh->nlmsg_flags =3D 0;
+	memcpy(NLMSG_DATA(nlh), msg, sizeof(*msg));
+	memset(&(NETLINK_CB(skb)), 0, sizeof(struct netlink_skb_parms));
+	NETLINK_CB(skb).dst_pid =3D pid;
+	netlink_unicast(sk, skb, pid, MSG_DONTWAIT);
+
+	return 0;
+}
+
+static void wconf_message_rx(struct sock *sk, int len)
+{
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh =3D NULL;
+	struct wconf_message *msg;
+	struct wconf_device *wd;
+	int err;
+
+	while ((skb =3D skb_dequeue(&sk->sk_receive_queue)) !=3D NULL) {
+		if (skb->len < NLMSG_SPACE(sizeof(struct wconf_message))) {
+			printk(KERN_ERR PFX "Invalid message\n");
+			goto cont;
+		}
+		nlh =3D (struct nlmsghdr *)skb->data;
+		msg =3D NLMSG_DATA(nlh);
+		if (msg->wconf_ver !=3D WCONF_VERSION) {
+			printk(KERN_ERR PFX "Version mismatch "
+					    "(msg: %u, kernel: %u)\n",
+			       msg->wconf_ver, WCONF_VERSION);
+			goto cont;
+		}
+		msg->dest[ARRAY_SIZE(msg->dest) - 1] =3D '\0';
+		wd =3D find_wconf(msg->dest);
+		if (!wd) {
+			printk(KERN_ERR PFX "Unknown destination \"%s\"\n",
+			       msg->dest);
+			goto cont;
+		}
+		err =3D wconf_handle_message(wd, msg);
+		msg->errorcode =3D err;
+		err =3D wconf_send_reply(sk, nlh->nlmsg_pid, msg);
+		if (err) {
+			printk(KERN_ERR PFX "Reply failed\n");
+			goto cont;
+		}
+		kfree_skb(skb);
+	}
+}
+
+int wconf_register(struct ieee80211_device *dev)
+{
+	int err =3D -ENOMEM;
+	struct wconf_device *wd;
+	unsigned long flags;
+
+	wd =3D kzalloc(sizeof(*wd), GFP_KERNEL);
+	if (!wd)
+		goto out;
+	wd->dev =3D dev;
+	dev->wconf =3D wd;
+	INIT_LIST_HEAD(&wd->list);
+	spin_lock_init(&wd->lock);
+
+	spin_lock_irqsave(&wc.lock, flags);
+	list_add_tail(&wd->list, &wc.devices);
+	spin_unlock_irqrestore(&wc.lock, flags);
+
+	err =3D 0;
+out:
+	return err;
+}
+
+void wconf_unregister(struct ieee80211_device *dev)
+{
+	struct wconf_device *wd =3D dev->wconf;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wc.lock, flags);
+	BUG_ON(list_empty(&wd->list));
+	list_del(&wd->list);
+	kfree(wd);
+	spin_unlock_irqrestore(&wc.lock, flags);
+}
+
+int wconf_init(void)
+{
+	int err =3D -ENOMEM;
+
+	wc.nl =3D netlink_kernel_create(NETLINK_WCONF, 1,
+				      wconf_message_rx,
+				      THIS_MODULE);
+	if (!wc.nl)
+		goto out;
+	INIT_LIST_HEAD(&wc.devices);
+	spin_lock_init(&wc.lock);
+
+	err =3D 0;
+out:
+	return err;
+}
+
+void wconf_exit(void)
+{
+	sock_release(wc.nl->sk_socket);
+}


=2D-=20
Greetings Michael.

--nextPart10633257.KghmLRjcGv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDxpCylb09HEdWDKgRAjwYAJ9jhtSRKxLY488bxYAL7mMjDYcbdACfd6YA
/XEYWe2ihXY9JW4VjtTZkWY=
=CFve
-----END PGP SIGNATURE-----

--nextPart10633257.KghmLRjcGv--
