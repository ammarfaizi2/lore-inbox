Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVCVCDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVCVCDy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVCVCCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:02:49 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:24971 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262335AbVCVBfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:42 -0500
Message-Id: <20050322013457.163532000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:54 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-swpidfilter-refactor.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 21/48] refactor sw pid filter to drop redundant code
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o added index field to struct dvb_demux_feed for having a unique feed id, which
  can be used for hardware pid filter tables
o dibusb: adding the index to struct dvb_demux_feed makes dibusb-pid-filtering redundant
o ttusb-budget: struct channel removed in favour of dvbdmxfeed->index
(Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dibusb/dvb-dibusb-pid.c                              |   80 ---------
 linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/Makefile                 |    3 
 linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c        |    2 
 linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c         |   24 --
 linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h             |   10 -
 linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_demux.c            |    4 
 linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_demux.h            |    1 
 linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |   86 +---------
 8 files changed, 24 insertions(+), 186 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/Makefile
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/Makefile	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/Makefile	2005-03-22 00:17:09.000000000 +0100
@@ -3,8 +3,7 @@ dvb-dibusb-objs = dvb-dibusb-core.o \
 	dvb-dibusb-fe-i2c.o \
 	dvb-dibusb-firmware.o \
 	dvb-dibusb-remote.o \
-	dvb-dibusb-usb.o \
-	dvb-dibusb-pid.o
+	dvb-dibusb-usb.o
 
 obj-$(CONFIG_DVB_DIBUSB) += dvb-dibusb.o
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:16:28.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:17:09.000000000 +0100
@@ -349,7 +349,6 @@ static int dibusb_exit(struct usb_dibusb
 	dibusb_remote_exit(dib);
 	dibusb_fe_exit(dib);
 	dibusb_i2c_exit(dib);
-	dibusb_pid_list_exit(dib);
 	dibusb_dvb_exit(dib);
 	dibusb_urb_exit(dib);
 	deb_info("init_state should be zero now: %x\n",dib->init_state);
@@ -368,7 +367,6 @@ static int dibusb_init(struct usb_dibusb
 	
 	if ((ret = dibusb_urb_init(dib)) ||
 		(ret = dibusb_dvb_init(dib)) || 
-		(ret = dibusb_pid_list_init(dib)) ||
 		(ret = dibusb_i2c_init(dib))) {
 		dibusb_exit(dib);
 		return ret;
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c	2005-03-22 00:15:37.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c	2005-03-22 00:17:09.000000000 +0100
@@ -22,7 +22,6 @@ static u32 urb_compl_count;
 void dibusb_urb_complete(struct urb *urb, struct pt_regs *ptregs)
 {
 	struct usb_dibusb *dib = urb->context;
-	int ret;
 
 	deb_ts("urb complete feedcount: %d, status: %d, length: %d\n",dib->feedcount,urb->status,
 			urb->actual_length);
@@ -45,24 +44,12 @@ void dibusb_urb_complete(struct urb *urb
 	}
 
 	if (dib->feedcount > 0) {
-		deb_ts("URB return len: %d\n",urb->actual_length);
-		if (urb->actual_length % 188) 
-			deb_ts("TS Packets: %d, %d\n", urb->actual_length/188,urb->actual_length % 188);
-
-		/* Francois recommends to drop not full-filled packets, even if they may 
-		 * contain valid TS packets, at least for USB1.1
-		 *
-		 * if (urb->actual_length == dib->dibdev->parm->default_size && dib->dvb_is_ready) */
 		if (dib->init_state & DIBUSB_STATE_DVB)
 			dvb_dmx_swfilter(&dib->demux, (u8*) urb->transfer_buffer,urb->actual_length);
-		else
-			deb_ts("URB dropped because of the " 
-					"actual_length or !dvb_is_ready (%d).\n",dib->init_state & DIBUSB_STATE_DVB);
 	} else 
 		deb_ts("URB dropped because of feedcount.\n");
 
-	ret = usb_submit_urb(urb,GFP_ATOMIC);
-	deb_ts("urb resubmitted, (%d)\n",ret);
+	usb_submit_urb(urb,GFP_ATOMIC);
 }
 
 static int dibusb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff) 
@@ -90,11 +77,10 @@ static int dibusb_ctrl_feed(struct dvb_d
 	
 	dib->feedcount = newfeedcount;
 
-	/* get a free pid from the list and activate it on the device
-	 * specific pid_filter
-	 */
-	if (dib->pid_parse)
-		dibusb_ctrl_pid(dib,dvbdmxfeed,onoff);
+	/* activate the pid on the device specific pid_filter */
+	deb_ts("setting pid: %5d %04x at index %d '%s'\n",dvbdmxfeed->pid,dvbdmxfeed->pid,dvbdmxfeed->index,onoff ? "on" : "off");
+	if (dib->pid_parse && dib->xfer_ops.pid_ctrl != NULL)
+		dib->xfer_ops.pid_ctrl(dib->fe,dvbdmxfeed->index,dvbdmxfeed->pid,onoff);
 
 	/* 
 	 * start the feed if this was the first pid to set and there is still a pid
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-pid.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-pid.c	2005-03-22 00:15:37.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,80 +0,0 @@
-/*
- * dvb-dibusb-pid.c is part of the driver for mobile USB Budget DVB-T devices 
- * based on reference design made by DiBcom (http://www.dibcom.fr/)
- *
- * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
- *
- * see dvb-dibusb-core.c for more copyright details.
- *
- * This file contains functions for initializing and handling the internal
- * pid-list. This pid-list mirrors the information currently stored in the
- * devices pid-list.
- */
-#include "dvb-dibusb.h"
-
-int dibusb_pid_list_init(struct usb_dibusb *dib)
-{
-	int i;
-	dib->pid_list = kmalloc(sizeof(struct dibusb_pid) * dib->dibdev->dev_cl->demod->pid_filter_count,GFP_KERNEL);
-	if (dib->pid_list == NULL)
-		return -ENOMEM;
-
-	deb_xfer("initializing %d pids for the pid_list.\n",dib->dibdev->dev_cl->demod->pid_filter_count);
-	
-	dib->pid_list_lock = SPIN_LOCK_UNLOCKED;
-	memset(dib->pid_list,0,dib->dibdev->dev_cl->demod->pid_filter_count*(sizeof(struct dibusb_pid)));
-	for (i=0; i < dib->dibdev->dev_cl->demod->pid_filter_count; i++) {
-		dib->pid_list[i].index = i;
-		dib->pid_list[i].pid = 0;
-		dib->pid_list[i].active = 0;
-	}
-
-	dib->init_state |= DIBUSB_STATE_PIDLIST;
-	return 0;
-}
-
-void dibusb_pid_list_exit(struct usb_dibusb *dib)
-{
-	if (dib->init_state & DIBUSB_STATE_PIDLIST)
-		kfree(dib->pid_list);
-	dib->init_state &= ~DIBUSB_STATE_PIDLIST;
-}
-
-/* fetch a pid from pid_list and set it on or off */
-int dibusb_ctrl_pid(struct usb_dibusb *dib, struct dvb_demux_feed *dvbdmxfeed , int onoff)
-{
-	int i,ret = -1;
-	unsigned long flags;
-	u16 pid = dvbdmxfeed->pid;
-
-	if (onoff) {
-		spin_lock_irqsave(&dib->pid_list_lock,flags);
-		for (i=0; i < dib->dibdev->dev_cl->demod->pid_filter_count; i++)
-			if (!dib->pid_list[i].active) {
-				dib->pid_list[i].pid = pid;
-				dib->pid_list[i].active = 1;
-				ret = i;
-				break;
-			}
-		dvbdmxfeed->priv = &dib->pid_list[ret];
-		spin_unlock_irqrestore(&dib->pid_list_lock,flags);
-		
-		if (dib->xfer_ops.pid_ctrl != NULL) 
-			dib->xfer_ops.pid_ctrl(dib->fe,dib->pid_list[ret].index,dib->pid_list[ret].pid,1);
-	} else {
-		struct dibusb_pid *dpid = dvbdmxfeed->priv;
-		
-		if (dib->xfer_ops.pid_ctrl != NULL) 
-			dib->xfer_ops.pid_ctrl(dib->fe,dpid->index,0,0);
-		
-		ret = dpid->index;
-		dpid->pid = 0;
-		dpid->active = 0;
-	}
-	
-	/* a free pid from the list */
-	deb_xfer("setting pid: %5d %04x at index %d '%s'\n",pid,pid,ret,onoff ? "on" : "off");
-
-	return ret;
-}
-
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-03-22 00:16:28.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-03-22 00:17:09.000000000 +0100
@@ -157,7 +157,6 @@ struct usb_dibusb {
 #define DIBUSB_STATE_DVB        0x008
 #define DIBUSB_STATE_I2C        0x010
 #define DIBUSB_STATE_REMOTE		0x020
-#define DIBUSB_STATE_PIDLIST    0x040
 	int init_state;
 
 	int feedcount;
@@ -176,10 +175,6 @@ struct usb_dibusb {
 	struct semaphore usb_sem;
 	struct semaphore i2c_sem;
 
-	/* pid filtering */
-	spinlock_t pid_list_lock;
-	struct dibusb_pid *pid_list;
-
 	/* dvb */
 	struct dvb_adapter *adapter;
 	struct dmxdev dmxdev;
@@ -232,11 +227,6 @@ int dibusb_streaming(struct usb_dibusb *
 int dibusb_urb_init(struct usb_dibusb *);
 int dibusb_urb_exit(struct usb_dibusb *);
 
-/* dvb-dibusb-pid.c */
-int dibusb_pid_list_init(struct usb_dibusb *dib);
-void dibusb_pid_list_exit(struct usb_dibusb *dib);
-int dibusb_ctrl_pid(struct usb_dibusb *dib, struct dvb_demux_feed *dvbdmxfeed , int onoff);
-
 /* i2c and transfer stuff */
 #define DIBUSB_I2C_TIMEOUT				5000
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_demux.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dvb_demux.h	2005-03-22 00:16:28.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_demux.h	2005-03-22 00:17:09.000000000 +0100
@@ -98,6 +98,7 @@ struct dvb_demux_feed {
         u16 peslen;
 
 	struct list_head list_head;
+		int index; /* a unique index for each feed (can be used as hardware pid filter index) */
 };
 
 struct dvb_demux {
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_demux.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dvb_demux.c	2005-03-22 00:16:28.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_demux.c	2005-03-22 00:17:09.000000000 +0100
@@ -1226,8 +1226,10 @@ int dvb_dmx_init(struct dvb_demux *dvbde
 		dvbdemux->filter[i].state = DMX_STATE_FREE;
 		dvbdemux->filter[i].index = i;
 	}
-	for (i=0; i<dvbdemux->feednum; i++)
+	for (i=0; i<dvbdemux->feednum; i++) {
 		dvbdemux->feed[i].state = DMX_STATE_FREE;
+		dvbdemux->feed[i].index = i;
+	}
 	dvbdemux->frontend_list.next=
 	  dvbdemux->frontend_list.prev=
 	    &dvbdemux->frontend_list;
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-03-22 00:17:09.000000000 +0100
@@ -79,9 +79,8 @@ struct ttusb {
 	struct dmxdev dmxdev;
 	struct dvb_net dvbnet;
 
-	/* our semaphore, for channel allocation/deallocation */
-	struct semaphore sem;
 	/* and one for USB access. */
+	struct semaphore semi2c;
 	struct semaphore semusb;
 
 	struct dvb_adapter *adapter;
@@ -121,18 +120,6 @@ struct ttusb {
 
 	u8 last_result[32];
 
-	struct ttusb_channel {
-		struct ttusb *ttusb;
-		struct dvb_demux_feed *dvbdmxfeed;
-
-		int active;
-		int id;
-		int pid;
-		int type;	/* 1 - TS, 2 - Filter */
-#ifdef TTUSB_HWSECTIONS
-		int filterstate[TTUSB_MAXFILTER];	/* 0: not busy, 1: busy */
-#endif
-	} channel[TTUSB_MAXCHANNEL];
 #if 0
 	devfs_handle_t stc_devfs_handle;
 #endif
@@ -258,7 +245,7 @@ static int master_xfer(struct i2c_adapte
 	int i = 0;
 	int inc;
 
-	if (down_interruptible(&ttusb->sem) < 0)
+	if (down_interruptible(&ttusb->semi2c) < 0)
 		return -EAGAIN;
 
 	while (i < num) {
@@ -292,7 +279,7 @@ static int master_xfer(struct i2c_adapte
 		i += inc;
 	}
 
-	up(&ttusb->sem);
+	up(&ttusb->semi2c);
 	return i;
 }
 
@@ -888,15 +875,13 @@ static int ttusb_start_iso_xfer(struct t
 }
 
 #ifdef TTUSB_HWSECTIONS
-static void ttusb_handle_ts_data(struct ttusb_channel *channel, const u8 * data,
+static void ttusb_handle_ts_data(struct dvb_demux_feed *dvbdmxfeed, const u8 * data,
 			  int len)
 {
-	struct dvb_demux_feed *dvbdmxfeed = channel->dvbdmxfeed;
-
 	dvbdmxfeed->cb.ts(data, len, 0, 0, &dvbdmxfeed->feed.ts, 0);
 }
 
-static void ttusb_handle_sec_data(struct ttusb_channel *channel, const u8 * data,
+static void ttusb_handle_sec_data(struct dvb_demux_feed *dvbdmxfeed, const u8 * data,
 			   int len)
 {
 //      struct dvb_demux_feed *dvbdmxfeed = channel->dvbdmxfeed;
@@ -905,31 +890,10 @@ static void ttusb_handle_sec_data(struct
 }
 #endif
 
-static struct ttusb_channel *ttusb_channel_allocate(struct ttusb *ttusb)
-{
-	int i;
-
-	if (down_interruptible(&ttusb->sem))
-		return NULL;
-
-	/* lock! */
-	for (i = 0; i < TTUSB_MAXCHANNEL; ++i) {
-		if (!ttusb->channel[i].active) {
-			ttusb->channel[i].active = 1;
-			up(&ttusb->sem);
-			return ttusb->channel + i;
-		}
-	}
-
-	up(&ttusb->sem);
-
-	return NULL;
-}
-
 static int ttusb_start_feed(struct dvb_demux_feed *dvbdmxfeed)
 {
 	struct ttusb *ttusb = (struct ttusb *) dvbdmxfeed->demux;
-	struct ttusb_channel *channel;
+	int feed_type = 1;
 
 	dprintk("ttusb_start_feed\n");
 
@@ -949,35 +913,22 @@ static int ttusb_start_feed(struct dvb_d
 		case DMX_TS_PES_TELETEXT:
 		case DMX_TS_PES_PCR:
 		case DMX_TS_PES_OTHER:
-			channel = ttusb_channel_allocate(ttusb);
 			break;
 		default:
 			return -EINVAL;
 		}
-	} else {
-		channel = ttusb_channel_allocate(ttusb);
 	}
 
-	if (!channel)
-		return -EBUSY;
-
-	dvbdmxfeed->priv = channel;
-	channel->dvbdmxfeed = dvbdmxfeed;
-
-	channel->pid = dvbdmxfeed->pid;
-
 #ifdef TTUSB_HWSECTIONS
+#error TODO: allocate filters
 	if (dvbdmxfeed->type == DMX_TYPE_TS) {
-		channel->type = 1;
+		feed_type = 1;
 	} else if (dvbdmxfeed->type == DMX_TYPE_SEC) {
-		channel->type = 2;
-#error TODO: allocate filters
+		feed_type = 2;
 	}
-#else
-	channel->type = 1;
 #endif
 
-	ttusb_set_channel(ttusb, channel->id, channel->type, channel->pid);
+	ttusb_set_channel(ttusb, dvbdmxfeed->index, feed_type, dvbdmxfeed->pid);
 
 	if (0 == ttusb->running_feed_count++)
 		ttusb_start_iso_xfer(ttusb);
@@ -987,17 +938,13 @@ static int ttusb_start_feed(struct dvb_d
 
 static int ttusb_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
 {
-	struct ttusb_channel *channel =
-	    (struct ttusb_channel *) dvbdmxfeed->priv;
 	struct ttusb *ttusb = (struct ttusb *) dvbdmxfeed->demux;
 
-	ttusb_del_channel(channel->ttusb, channel->id);
+	ttusb_del_channel(ttusb, dvbdmxfeed->index);
 
 	if (--ttusb->running_feed_count == 0)
 		ttusb_stop_iso_xfer(ttusb);
 
-	channel->active = 0;
-
 	return 0;
 }
 
@@ -1406,7 +1353,7 @@ static int ttusb_probe(struct usb_interf
 {
 	struct usb_device *udev;
 	struct ttusb *ttusb;
-	int result, channel;
+	int result;
 
 	dprintk("%s: TTUSB DVB connected\n", __FUNCTION__);
 
@@ -1419,15 +1366,10 @@ static int ttusb_probe(struct usb_interf
 
 	memset(ttusb, 0, sizeof(struct ttusb));
 
-	for (channel = 0; channel < TTUSB_MAXCHANNEL; ++channel) {
-		ttusb->channel[channel].id = channel;
-		ttusb->channel[channel].ttusb = ttusb;
-	}
-
 	ttusb->dev = udev;
 	ttusb->c = 0;
 	ttusb->mux_state = 0;
-	sema_init(&ttusb->sem, 0);
+	sema_init(&ttusb->semi2c, 0);
 	sema_init(&ttusb->semusb, 1);
 
 	ttusb_setup_interfaces(ttusb);
@@ -1436,7 +1378,7 @@ static int ttusb_probe(struct usb_interf
 	if (ttusb_init_controller(ttusb))
 		printk("ttusb_init_controller: error\n");
 
-	up(&ttusb->sem);
+	up(&ttusb->semi2c);
 
 	dvb_register_adapter(&ttusb->adapter, "Technotrend/Hauppauge Nova-USB", THIS_MODULE);
 	ttusb->adapter->priv = ttusb;

--

