Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269077AbTGORAh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268715AbTGORAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:00:37 -0400
Received: from mail.convergence.de ([212.84.236.4]:21169 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S269077AbTGOQ6E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:58:04 -0400
Subject: [PATCH 1/1] Add two drivers for USB based DVB-T adapters
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 15 Jul 2003 19:12:53 +0200
Message-Id: <10582891731946@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 17 of the patchset I send earlier. I guess the message was
eaten by the list server because of the size. I removed the data for the
firmware bootloader, so here it comes again.
[DVB] - add two new usb dvb drivers:
        - dvb-ttusb-budget.c for Technotrend/Hauppauge Nova-USB devices (Thanks to Holger Waechtler <holger@convergence.de> and elix Domke <tmbinc@gmx.net>)
	- dvb-ttusb-dec.c for Technotrend/Hauppauge USB DEC2000-T devices (Thanks to Alex Woods <linux-dvb@giblets.org>)
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttusb-budget/Kconfig linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-budget/Kconfig
--- linux-2.6.0-test1.work/drivers/media/dvb/ttusb-budget/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-budget/Kconfig	2003-06-21 17:43:27.000000000 +0200
@@ -0,0 +1,11 @@
+config DVB_TTUSB_BUDGET
+	tristate "Technotrend/Hauppauge Nova-USB devices"
+	depends on DVB_CORE && USB
+	help
+	  Support for external USB adapters designed by Technotrend and
+	  produced by Hauppauge, shipped under the brand name 'Nova-USB'.
+
+          These devices don't have a MPEG decoder built in, so you need
+	  an external software decoder to watch TV.	  
+
+	  Say Y if you own such a device and want to use it.
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttusb-budget/Makefile linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-budget/Makefile
--- linux-2.6.0-test1.work/drivers/media/dvb/ttusb-budget/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-budget/Makefile	2003-04-30 12:07:36.000000000 +0200
@@ -0,0 +1,3 @@
+obj-$(CONFIG_DVB_TTUSB_BUDGET) += dvb-ttusb-budget.o
+
+EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- linux-2.6.0-test1.work/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2003-07-15 09:38:04.000000000 +0200
@@ -0,0 +1,1271 @@
+/*
+ * TTUSB DVB driver
+ *
+ * Copyright (c) 2002 Holger Waechtler <holger@convergence.de>
+ * Copyright (c) 2003 Felix Domke <tmbinc@gmx.net>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation; either version 2 of
+ *	the License, or (at your option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/delay.h>
+#include <linux/time.h>
+#include <linux/errno.h>
+#include <asm/semaphore.h>
+
+#include "dvb_frontend.h"
+#include "dmxdev.h"
+#include "dvb_demux.h"
+#include "dvb_net.h"
+
+#include <linux/dvb/frontend.h>
+#include <linux/dvb/dmx.h>
+#include <linux/pci.h>
+#include <linux/usb.h>
+
+#include "dvb_functions.h"
+
+/*
+  TTUSB_HWSECTIONS:
+    the DSP supports filtering in hardware, however, since the "muxstream"
+    is a bit braindead (no matching channel masks or no matching filter mask),
+    we won't support this - yet. it doesn't event support negative filters,
+    so the best way is maybe to keep TTUSB_HWSECTIONS undef'd and just
+    parse TS data. USB bandwith will be a problem when having large
+    datastreams, especially for dvb-net, but hey, that's not my problem.
+	
+  TTUSB_DISEQC, TTUSB_TONE:
+    let the STC do the diseqc/tone stuff. this isn't supported at least with
+    my TTUSB, so let it undef'd unless you want to implement another
+    frontend. never tested.
+		
+  DEBUG:
+    define it to > 3 for really hardcore debugging. you probably don't want
+    this unless the device doesn't load at all. > 2 for bandwidth statistics.
+*/
+
+static int debug = 0;
+
+#define dprintk(x...) do { if (debug) printk(KERN_DEBUG x); } while (0)
+
+#define ISO_BUF_COUNT      4
+#define FRAMES_PER_ISO_BUF 4
+#define ISO_FRAME_SIZE     912
+#define TTUSB_MAXCHANNEL   32
+#ifdef TTUSB_HWSECTIONS
+#define TTUSB_MAXFILTER    16	/* ??? */
+#endif
+
+#define TTUSB_BUDGET_NAME "ttusb_stc_fw"
+
+/**
+ *  since we're casting (struct ttusb*) <-> (struct dvb_demux*) around
+ *  the dvb_demux field must be the first in struct!!
+ */
+struct ttusb {
+	struct dvb_demux dvb_demux;
+	struct dmxdev dmxdev;
+	struct dvb_net dvbnet;
+
+	/* our semaphore, for channel allocation/deallocation */
+	struct semaphore sem;
+	/* and one for USB access. */
+	struct semaphore semusb;
+
+	struct dvb_adapter *adapter;
+	struct usb_device *dev;
+
+	int disconnecting;
+	int iso_streaming;
+
+	unsigned int bulk_out_pipe;
+	unsigned int bulk_in_pipe;
+	unsigned int isoc_in_pipe;
+
+	void *iso_buffer;
+	dma_addr_t iso_dma_handle;
+
+	struct urb *iso_urb[ISO_BUF_COUNT];
+
+	int running_feed_count;
+	int last_channel;
+	int last_filter;
+
+	u8 c;			/* transaction counter, wraps around...  */
+	fe_sec_tone_mode_t tone;
+	fe_sec_voltage_t voltage;
+
+	int mux_state;		// 0..2 - MuxSyncWord, 3 - nMuxPacks,    4 - muxpack
+	u8 mux_npacks;
+	u8 muxpack[256 + 8];
+	int muxpack_ptr, muxpack_len;
+
+	int insync;
+
+	u16 cc;			/* MuxCounter - will increment on EVERY MUX PACKET */
+	/* (including stuffing. yes. really.) */
+
+	u8 last_result[32];
+
+	struct ttusb_channel {
+		struct ttusb *ttusb;
+		struct dvb_demux_feed *dvbdmxfeed;
+
+		int active;
+		int id;
+		int pid;
+		int type;	/* 1 - TS, 2 - Filter */
+#ifdef TTUSB_HWSECTIONS
+		int filterstate[TTUSB_MAXFILTER];	/* 0: not busy, 1: busy */
+#endif
+	} channel[TTUSB_MAXCHANNEL];
+#if 0
+	devfs_handle_t stc_devfs_handle;
+#endif
+};
+
+/* ugly workaround ... don't know why it's neccessary to read */
+/* all result codes. */
+
+#define DEBUG 0
+static int ttusb_cmd(struct ttusb *ttusb,
+	      const u8 * data, int len, int needresult)
+{
+	int actual_len;
+	int err;
+#if DEBUG >= 3
+	int i;
+
+	printk(">");
+	for (i = 0; i < len; ++i)
+		printk(" %02x", data[i]);
+	printk("\n");
+#endif
+
+	if (down_interruptible(&ttusb->semusb) < 0)
+		return -EAGAIN;
+
+	err = usb_bulk_msg(ttusb->dev, ttusb->bulk_out_pipe,
+			   (u8 *) data, len, &actual_len, HZ);
+	if (err != 0) {
+		dprintk("%s: usb_bulk_msg(send) failed, err == %i!\n",
+			__FUNCTION__, err);
+		up(&ttusb->semusb);
+		return err;
+	}
+	if (actual_len != len) {
+		dprintk("%s: only wrote %d of %d bytes\n", __FUNCTION__,
+			actual_len, len);
+		up(&ttusb->semusb);
+		return -1;
+	}
+
+	err = usb_bulk_msg(ttusb->dev, ttusb->bulk_in_pipe,
+			   ttusb->last_result, 32, &actual_len, HZ);
+
+	if (err != 0) {
+		printk("%s: failed, receive error %d\n", __FUNCTION__,
+		       err);
+		up(&ttusb->semusb);
+		return err;
+	}
+#if DEBUG >= 3
+	actual_len = ttusb->last_result[3] + 4;
+	printk("<");
+	for (i = 0; i < actual_len; ++i)
+		printk(" %02x", ttusb->last_result[i]);
+	printk("\n");
+#endif
+	if (!needresult)
+		up(&ttusb->semusb);
+	return 0;
+}
+
+static int ttusb_result(struct ttusb *ttusb, u8 * data, int len)
+{
+	memcpy(data, ttusb->last_result, len);
+	up(&ttusb->semusb);
+	return 0;
+}
+
+static int ttusb_i2c_msg(struct ttusb *ttusb,
+		  u8 addr, u8 * snd_buf, u8 snd_len, u8 * rcv_buf,
+		  u8 rcv_len)
+{
+	u8 b[0x28];
+	u8 id = ++ttusb->c;
+	int i, err;
+
+	if (snd_len > 0x28 - 7 || rcv_len > 0x20 - 7)
+		return -EINVAL;
+
+	b[0] = 0xaa;
+	b[1] = id;
+	b[2] = 0x31;
+	b[3] = snd_len + 3;
+	b[4] = addr << 1;
+	b[5] = snd_len;
+	b[6] = rcv_len;
+
+	for (i = 0; i < snd_len; i++)
+		b[7 + i] = snd_buf[i];
+
+	err = ttusb_cmd(ttusb, b, snd_len + 7, 1);
+
+	if (err)
+		return -EREMOTEIO;
+
+	err = ttusb_result(ttusb, b, 0x20);
+
+	if (rcv_len > 0) {
+
+		if (err || b[0] != 0x55 || b[1] != id) {
+			dprintk
+			    ("%s: usb_bulk_msg(recv) failed, err == %i, id == %02x, b == ",
+			     __FUNCTION__, err, id);
+			return -EREMOTEIO;
+		}
+
+		for (i = 0; i < rcv_len; i++)
+			rcv_buf[i] = b[7 + i];
+	}
+
+	return rcv_len;
+}
+
+static int ttusb_i2c_xfer(struct dvb_i2c_bus *i2c, const struct i2c_msg msg[],
+		   int num)
+{
+	struct ttusb *ttusb = i2c->data;
+	int i = 0;
+	int inc;
+
+	if (down_interruptible(&ttusb->sem) < 0)
+		return -EAGAIN;
+
+	while (i < num) {
+		u8 addr, snd_len, rcv_len, *snd_buf, *rcv_buf;
+		int err;
+
+		if (num > i + 1 && (msg[i + 1].flags & I2C_M_RD)) {
+			addr = msg[i].addr;
+			snd_buf = msg[i].buf;
+			snd_len = msg[i].len;
+			rcv_buf = msg[i + 1].buf;
+			rcv_len = msg[i + 1].len;
+			inc = 2;
+		} else {
+			addr = msg[i].addr;
+			snd_buf = msg[i].buf;
+			snd_len = msg[i].len;
+			rcv_buf = NULL;
+			rcv_len = 0;
+			inc = 1;
+		}
+
+		err = ttusb_i2c_msg(ttusb, addr,
+				    snd_buf, snd_len, rcv_buf, rcv_len);
+
+		if (err < rcv_len) {
+			printk("%s: i == %i\n", __FUNCTION__, i);
+			break;
+		}
+
+		i += inc;
+	}
+
+	up(&ttusb->sem);
+	return i;
+}
+
+#include "dvb-ttusb-dspbootcode.h"
+
+static int ttusb_boot_dsp(struct ttusb *ttusb)
+{
+	int i, err;
+	u8 b[40];
+
+	/* BootBlock */
+	b[0] = 0xaa;
+	b[2] = 0x13;
+	b[3] = 28;
+
+	/* upload dsp code in 32 byte steps (36 didn't work for me ...) */
+	/* 32 is max packet size, no messages should be splitted. */
+	for (i = 0; i < sizeof(dsp_bootcode); i += 28) {
+		memcpy(&b[4], &dsp_bootcode[i], 28);
+
+		b[1] = ++ttusb->c;
+
+		err = ttusb_cmd(ttusb, b, 32, 0);
+		if (err)
+			goto done;
+	}
+
+	/* last block ... */
+	b[1] = ++ttusb->c;
+	b[2] = 0x13;
+	b[3] = 0;
+
+	err = ttusb_cmd(ttusb, b, 4, 0);
+	if (err)
+		goto done;
+
+	/* BootEnd */
+	b[1] = ++ttusb->c;
+	b[2] = 0x14;
+	b[3] = 0;
+
+	err = ttusb_cmd(ttusb, b, 4, 0);
+
+      done:
+	if (err) {
+		dprintk("%s: usb_bulk_msg() failed, return value %i!\n",
+			__FUNCTION__, err);
+	}
+
+	return err;
+}
+
+static int ttusb_set_channel(struct ttusb *ttusb, int chan_id, int filter_type,
+		      int pid)
+{
+	int err;
+	/* SetChannel */
+	u8 b[] = { 0xaa, ++ttusb->c, 0x22, 4, chan_id, filter_type,
+		(pid >> 8) & 0xff, pid & 0xff
+	};
+
+	err = ttusb_cmd(ttusb, b, sizeof(b), 0);
+	return err;
+}
+
+static int ttusb_del_channel(struct ttusb *ttusb, int channel_id)
+{
+	int err;
+	/* DelChannel */
+	u8 b[] = { 0xaa, ++ttusb->c, 0x23, 1, channel_id };
+
+	err = ttusb_cmd(ttusb, b, sizeof(b), 0);
+	return err;
+}
+
+#ifdef TTUSB_HWSECTIONS
+static int ttusb_set_filter(struct ttusb *ttusb, int filter_id,
+		     int associated_chan, u8 filter[8], u8 mask[8])
+{
+	int err;
+	/* SetFilter */
+	u8 b[] = { 0xaa, 0, 0x24, 0x1a, filter_id, associated_chan,
+		filter[0], filter[1], filter[2], filter[3],
+		filter[4], filter[5], filter[6], filter[7],
+		filter[8], filter[9], filter[10], filter[11],
+		mask[0], mask[1], mask[2], mask[3],
+		mask[4], mask[5], mask[6], mask[7],
+		mask[8], mask[9], mask[10], mask[11]
+	};
+
+	err = ttusb_cmd(ttusb, b, sizeof(b), 0);
+	return err;
+}
+
+static int ttusb_del_filter(struct ttusb *ttusb, int filter_id)
+{
+	int err;
+	/* DelFilter */
+	u8 b[] = { 0xaa, ++ttusb->c, 0x25, 1, filter_id };
+
+	err = ttusb_cmd(ttusb, b, sizeof(b), 0);
+	return err;
+}
+#endif
+
+static int ttusb_init_controller(struct ttusb *ttusb)
+{
+	u8 b0[] = { 0xaa, ++ttusb->c, 0x15, 1, 0 };
+	u8 b1[] = { 0xaa, ++ttusb->c, 0x15, 1, 1 };
+	u8 b2[] = { 0xaa, ++ttusb->c, 0x32, 1, 0 };
+	/* i2c write read: 5 bytes, addr 0x10, 0x02 bytes write, 1 bytes read. */
+	u8 b3[] =
+	    { 0xaa, ++ttusb->c, 0x31, 5, 0x10, 0x02, 0x01, 0x00, 0x1e };
+	u8 b4[] =
+	    { 0x55, ttusb->c, 0x31, 4, 0x10, 0x02, 0x01, 0x00, 0x1e };
+
+	u8 get_version[] = { 0xaa, ++ttusb->c, 0x17, 5, 0, 0, 0, 0, 0 };
+	u8 get_dsp_version[0x20] =
+	    { 0xaa, ++ttusb->c, 0x26, 28, 0, 0, 0, 0, 0 };
+	int err;
+
+	/* reset board */
+	if ((err = ttusb_cmd(ttusb, b0, sizeof(b0), 0)))
+		return err;
+
+	/* reset board (again?) */
+	if ((err = ttusb_cmd(ttusb, b1, sizeof(b1), 0)))
+		return err;
+
+	ttusb_boot_dsp(ttusb);
+
+	/* set i2c bit rate */
+	if ((err = ttusb_cmd(ttusb, b2, sizeof(b2), 0)))
+		return err;
+
+	if ((err = ttusb_cmd(ttusb, b3, sizeof(b3), 1)))
+		return err;
+
+	err = ttusb_result(ttusb, b4, sizeof(b4));
+
+	if ((err = ttusb_cmd(ttusb, get_version, sizeof(get_version), 1)))
+		return err;
+
+	if ((err = ttusb_result(ttusb, get_version, sizeof(get_version))))
+		return err;
+
+	dprintk("%s: stc-version: %c%c%c%c%c\n", __FUNCTION__,
+		get_version[4], get_version[5], get_version[6],
+		get_version[7], get_version[8]);
+
+	if (memcmp(get_version + 4, "V 0.0", 5) &&
+	    memcmp(get_version + 4, "V 1.1", 5)) {
+		printk
+		    ("%s: unknown STC version %c%c%c%c%c, please report!\n",
+		     __FUNCTION__, get_version[4], get_version[5],
+		     get_version[6], get_version[7], get_version[8]);
+	}
+
+	err =
+	    ttusb_cmd(ttusb, get_dsp_version, sizeof(get_dsp_version), 1);
+	if (err)
+		return err;
+
+	err =
+	    ttusb_result(ttusb, get_dsp_version, sizeof(get_dsp_version));
+	if (err)
+		return err;
+	printk("%s: dsp-version: %c%c%c\n", __FUNCTION__,
+	       get_dsp_version[4], get_dsp_version[5], get_dsp_version[6]);
+	return 0;
+}
+
+#ifdef TTUSB_DISEQC
+static int ttusb_send_diseqc(struct ttusb *ttusb,
+		      const struct dvb_diseqc_master_cmd *cmd)
+{
+	u8 b[12] = { 0xaa, ++ttusb->c, 0x18 };
+
+	int err;
+
+	b[3] = 4 + 2 + cmd->msg_len;
+	b[4] = 0xFF;		/* send diseqc master, not burst */
+	b[5] = cmd->msg_len;
+
+	memcpy(b + 5, cmd->msg, cmd->msg_len);
+
+	/* Diseqc */
+	if ((err = ttusb_cmd(ttusb, b, 4 + b[3], 0))) {
+		dprintk("%s: usb_bulk_msg() failed, return value %i!\n",
+			__FUNCTION__, err);
+	}
+
+	return err;
+}
+#endif
+
+static int ttusb_update_lnb(struct ttusb *ttusb)
+{
+	u8 b[] = { 0xaa, ++ttusb->c, 0x16, 5, /*power: */ 1,
+		ttusb->voltage == SEC_VOLTAGE_18 ? 0 : 1,
+		ttusb->tone == SEC_TONE_ON ? 1 : 0, 1, 1
+	};
+	int err;
+
+	/* SetLNB */
+	if ((err = ttusb_cmd(ttusb, b, sizeof(b), 0))) {
+		dprintk("%s: usb_bulk_msg() failed, return value %i!\n",
+			__FUNCTION__, err);
+	}
+
+	return err;
+}
+
+static int ttusb_set_voltage(struct ttusb *ttusb, fe_sec_voltage_t voltage)
+{
+	ttusb->voltage = voltage;
+	return ttusb_update_lnb(ttusb);
+}
+
+#ifdef TTUSB_TONE
+static int ttusb_set_tone(struct ttusb *ttusb, fe_sec_tone_mode_t tone)
+{
+	ttusb->tone = tone;
+	return ttusb_update_lnb(ttusb);
+}
+#endif
+
+static int ttusb_lnb_ioctl(struct dvb_frontend *fe, unsigned int cmd, void *arg)
+{
+	struct ttusb *ttusb = fe->i2c->data;
+
+	switch (cmd) {
+	case FE_SET_VOLTAGE:
+		return ttusb_set_voltage(ttusb, (fe_sec_voltage_t) arg);
+#ifdef TTUSB_TONE
+	case FE_SET_TONE:
+		return ttusb_set_tone(ttusb, (fe_sec_tone_mode_t) arg);
+#endif
+#ifdef TTUSB_DISEQC
+	case FE_DISEQC_SEND_MASTER_CMD:
+		return ttusb_send_diseqc(ttusb,
+					 (struct dvb_diseqc_master_cmd *)
+					 arg);
+#endif
+	default:
+		return -EOPNOTSUPP;
+	};
+}
+
+#if 0
+static void ttusb_set_led_freq(struct ttusb *ttusb, u8 freq)
+{
+	u8 b[] = { 0xaa, ++ttusb->c, 0x19, 1, freq };
+	int err, actual_len;
+
+	err = ttusb_cmd(ttusb, b, sizeof(b), 0);
+	if (err) {
+		dprintk("%s: usb_bulk_msg() failed, return value %i!\n",
+			__FUNCTION__, err);
+	}
+}
+#endif
+
+/*****************************************************************************/
+
+#ifdef TTUSB_HWSECTIONS
+static void ttusb_handle_ts_data(struct ttusb_channel *channel,
+				 const u8 * data, int len);
+static void ttusb_handle_sec_data(struct ttusb_channel *channel,
+				  const u8 * data, int len);
+#endif
+
+int numpkt = 0, lastj, numts, numstuff, numsec, numinvalid;
+
+static void ttusb_process_muxpack(struct ttusb *ttusb, const u8 * muxpack,
+			   int len)
+{
+	u16 csum = 0, cc;
+	int i;
+	for (i = 0; i < len; i += 2)
+		csum ^= le16_to_cpup((u16 *) (muxpack + i));
+	if (csum) {
+		printk("%s: muxpack with incorrect checksum, ignoring\n",
+		       __FUNCTION__);
+		numinvalid++;
+		return;
+	}
+
+	cc = (muxpack[len - 4] << 8) | muxpack[len - 3];
+	cc &= 0x7FFF;
+	if (cc != ttusb->cc)
+		printk("%s: cc discontinuity (%d frames missing)\n",
+		       __FUNCTION__, (cc - ttusb->cc) & 0x7FFF);
+	ttusb->cc = (cc + 1) & 0x7FFF;
+	if (muxpack[0] & 0x80) {
+#ifdef TTUSB_HWSECTIONS
+		/* section data */
+		int pusi = muxpack[0] & 0x40;
+		int channel = muxpack[0] & 0x1F;
+		int payload = muxpack[1];
+		const u8 *data = muxpack + 2;
+		/* check offset flag */
+		if (muxpack[0] & 0x20)
+			data++;
+
+		ttusb_handle_sec_data(ttusb->channel + channel, data,
+				      payload);
+		data += payload;
+
+		if ((!!(ttusb->muxpack[0] & 0x20)) ^
+		    !!(ttusb->muxpack[1] & 1))
+			data++;
+#warning TODO: pusi
+		printk("cc: %04x\n", (data[0] << 8) | data[1]);
+#endif
+		numsec++;
+	} else if (muxpack[0] == 0x47) {
+#ifdef TTUSB_HWSECTIONS
+		/* we have TS data here! */
+		int pid = ((muxpack[1] & 0x0F) << 8) | muxpack[2];
+		int channel;
+		for (channel = 0; channel < TTUSB_MAXCHANNEL; ++channel)
+			if (ttusb->channel[channel].active
+			    && (pid == ttusb->channel[channel].pid))
+				ttusb_handle_ts_data(ttusb->channel +
+						     channel, muxpack,
+						     188);
+#endif
+		numts++;
+		dvb_dmx_swfilter_packets(&ttusb->dvb_demux, muxpack, 1);
+	} else if (muxpack[0] != 0) {
+		numinvalid++;
+		printk("illegal muxpack type %02x\n", muxpack[0]);
+	} else
+		numstuff++;
+}
+
+static void ttusb_process_frame(struct ttusb *ttusb, u8 * data, int len)
+{
+	int maxwork = 1024;
+	while (len) {
+		if (!(maxwork--)) {
+			printk("%s: too much work\n", __FUNCTION__);
+			break;
+		}
+
+		switch (ttusb->mux_state) {
+		case 0:
+		case 1:
+		case 2:
+			len--;
+			if (*data++ == 0xAA)
+				++ttusb->mux_state;
+			else {
+				ttusb->mux_state = 0;
+#if DEBUG > 3
+				if (ttusb->insync)
+					printk("%02x ", data[-1]);
+#else
+				if (ttusb->insync) {
+					printk("%s: lost sync.\n",
+					       __FUNCTION__);
+					ttusb->insync = 0;
+				}
+#endif
+			}
+			break;
+		case 3:
+			ttusb->insync = 1;
+			len--;
+			ttusb->mux_npacks = *data++;
+			++ttusb->mux_state;
+			ttusb->muxpack_ptr = 0;
+			/* maximum bytes, until we know the length */
+			ttusb->muxpack_len = 2;
+			break;
+		case 4:
+			{
+				int avail;
+				avail = len;
+				if (avail >
+				    (ttusb->muxpack_len -
+				     ttusb->muxpack_ptr))
+					avail =
+					    ttusb->muxpack_len -
+					    ttusb->muxpack_ptr;
+				memcpy(ttusb->muxpack + ttusb->muxpack_ptr,
+				       data, avail);
+				ttusb->muxpack_ptr += avail;
+				if (ttusb->muxpack_ptr > 264)
+					BUG();
+				data += avail;
+				len -= avail;
+				/* determine length */
+				if (ttusb->muxpack_ptr == 2) {
+					if (ttusb->muxpack[0] & 0x80) {
+						ttusb->muxpack_len =
+						    ttusb->muxpack[1] + 2;
+						if (ttusb->
+						    muxpack[0] & 0x20)
+							ttusb->
+							    muxpack_len++;
+						if ((!!
+						     (ttusb->
+						      muxpack[0] & 0x20)) ^
+						    !!(ttusb->
+						       muxpack[1] & 1))
+							ttusb->
+							    muxpack_len++;
+						ttusb->muxpack_len += 4;
+					} else if (ttusb->muxpack[0] ==
+						   0x47)
+						ttusb->muxpack_len =
+						    188 + 4;
+					else if (ttusb->muxpack[0] == 0x00)
+						ttusb->muxpack_len =
+						    ttusb->muxpack[1] + 2 +
+						    4;
+					else {
+						dprintk
+						    ("%s: invalid state: first byte is %x\n",
+						     __FUNCTION__,
+						     ttusb->muxpack[0]);
+						ttusb->mux_state = 0;
+					}
+				}
+
+			/**
+			 * if length is valid and we reached the end:
+			 * goto next muxpack
+			 */
+				if ((ttusb->muxpack_ptr >= 2) &&
+				    (ttusb->muxpack_ptr ==
+				     ttusb->muxpack_len)) {
+					ttusb_process_muxpack(ttusb,
+							      ttusb->
+							      muxpack,
+							      ttusb->
+							      muxpack_ptr);
+					ttusb->muxpack_ptr = 0;
+					/* maximum bytes, until we know the length */
+					ttusb->muxpack_len = 2;
+
+				/**
+				 * no muxpacks left?
+				 * return to search-sync state
+				 */
+					if (!ttusb->mux_npacks--) {
+						ttusb->mux_state = 0;
+						break;
+					}
+				}
+				break;
+			}
+		default:
+			BUG();
+			break;
+		}
+	}
+}
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+static void ttusb_iso_irq(struct urb *urb)
+#else
+static void ttusb_iso_irq(struct urb *urb, struct pt_regs *ptregs)
+#endif
+{
+	struct ttusb *ttusb = urb->context;
+
+	if (!ttusb->iso_streaming)
+		return;
+
+#if 0
+	printk("%s: status %d, errcount == %d, length == %i\n",
+	       __FUNCTION__,
+	       urb->status, urb->error_count, urb->actual_length);
+#endif
+
+	if (!urb->status) {
+		int i;
+		for (i = 0; i < urb->number_of_packets; ++i) {
+			struct usb_iso_packet_descriptor *d;
+			u8 *data;
+			int len;
+			numpkt++;
+			if ((jiffies - lastj) >= HZ) {
+#if DEBUG > 2
+				printk
+				    ("frames/s: %d (ts: %d, stuff %d, sec: %d, invalid: %d, all: %d)\n",
+				     numpkt * HZ / (jiffies - lastj),
+				     numts, numstuff, numsec, numinvalid,
+				     numts + numstuff + numsec +
+				     numinvalid);
+#endif
+				numts = numstuff = numsec = numinvalid = 0;
+				lastj = jiffies;
+				numpkt = 0;
+			}
+			d = &urb->iso_frame_desc[i];
+			data = urb->transfer_buffer + d->offset;
+			len = d->actual_length;
+			d->actual_length = 0;
+			d->status = 0;
+			ttusb_process_frame(ttusb, data, len);
+		}
+	}
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+	usb_submit_urb(urb, GFP_KERNEL);
+#endif
+}
+
+static void ttusb_free_iso_urbs(struct ttusb *ttusb)
+{
+	int i;
+
+	for (i = 0; i < ISO_BUF_COUNT; i++)
+		if (ttusb->iso_urb[i])
+			usb_free_urb(ttusb->iso_urb[i]);
+
+	pci_free_consistent(NULL,
+			    ISO_FRAME_SIZE * FRAMES_PER_ISO_BUF *
+			    ISO_BUF_COUNT, ttusb->iso_buffer,
+			    ttusb->iso_dma_handle);
+}
+
+static int ttusb_alloc_iso_urbs(struct ttusb *ttusb)
+{
+	int i;
+
+	ttusb->iso_buffer = pci_alloc_consistent(NULL,
+						 ISO_FRAME_SIZE *
+						 FRAMES_PER_ISO_BUF *
+						 ISO_BUF_COUNT,
+						 &ttusb->iso_dma_handle);
+
+	memset(ttusb->iso_buffer, 0,
+	       ISO_FRAME_SIZE * FRAMES_PER_ISO_BUF * ISO_BUF_COUNT);
+
+	for (i = 0; i < ISO_BUF_COUNT; i++) {
+		struct urb *urb;
+
+		if (!
+		    (urb =
+		     usb_alloc_urb(FRAMES_PER_ISO_BUF, GFP_KERNEL))) {
+			ttusb_free_iso_urbs(ttusb);
+			return -ENOMEM;
+		}
+
+		ttusb->iso_urb[i] = urb;
+	}
+
+	return 0;
+}
+
+static void ttusb_stop_iso_xfer(struct ttusb *ttusb)
+{
+	int i;
+
+	for (i = 0; i < ISO_BUF_COUNT; i++)
+		usb_unlink_urb(ttusb->iso_urb[i]);
+
+	ttusb->iso_streaming = 0;
+}
+
+static int ttusb_start_iso_xfer(struct ttusb *ttusb)
+{
+	int i, j, err, buffer_offset = 0;
+
+	if (ttusb->iso_streaming) {
+		printk("%s: iso xfer already running!\n", __FUNCTION__);
+		return 0;
+	}
+
+	ttusb->insync = 0;
+	ttusb->mux_state = 0;
+
+	for (i = 0; i < ISO_BUF_COUNT; i++) {
+		int frame_offset = 0;
+		struct urb *urb = ttusb->iso_urb[i];
+
+		urb->dev = ttusb->dev;
+		urb->context = ttusb;
+		urb->complete = ttusb_iso_irq;
+		urb->pipe = ttusb->isoc_in_pipe;
+		urb->transfer_flags = URB_ISO_ASAP;
+		urb->number_of_packets = FRAMES_PER_ISO_BUF;
+		urb->transfer_buffer_length =
+		    ISO_FRAME_SIZE * FRAMES_PER_ISO_BUF;
+		urb->transfer_buffer = ttusb->iso_buffer + buffer_offset;
+		buffer_offset += ISO_FRAME_SIZE * FRAMES_PER_ISO_BUF;
+
+		for (j = 0; j < FRAMES_PER_ISO_BUF; j++) {
+			urb->iso_frame_desc[j].offset = frame_offset;
+			urb->iso_frame_desc[j].length = ISO_FRAME_SIZE;
+			frame_offset += ISO_FRAME_SIZE;
+		}
+	}
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+	for (i = 0; i < ISO_BUF_COUNT; i++) {
+		int next = (i + 1) % ISO_BUF_COUNT;
+		ttusb->iso_urb[i]->next = ttusb->iso_urb[next];
+	}
+#endif
+
+	for (i = 0; i < ISO_BUF_COUNT; i++) {
+		if ((err = usb_submit_urb(ttusb->iso_urb[i], GFP_KERNEL))) {
+			ttusb_stop_iso_xfer(ttusb);
+			printk
+			    ("%s: failed urb submission (%i: err = %i)!\n",
+			     __FUNCTION__, i, err);
+			return err;
+		}
+	}
+
+	ttusb->iso_streaming = 1;
+
+	return 0;
+}
+
+#ifdef TTUSB_HWSECTIONS
+static void ttusb_handle_ts_data(struct ttusb_channel *channel, const u8 * data,
+			  int len)
+{
+	struct dvb_demux_feed *dvbdmxfeed = channel->dvbdmxfeed;
+
+	dvbdmxfeed->cb.ts(data, len, 0, 0, &dvbdmxfeed->feed.ts, 0);
+}
+
+static void ttusb_handle_sec_data(struct ttusb_channel *channel, const u8 * data,
+			   int len)
+{
+//      struct dvb_demux_feed *dvbdmxfeed = channel->dvbdmxfeed;
+#error TODO: handle ugly stuff
+//      dvbdmxfeed->cb.sec(data, len, 0, 0, &dvbdmxfeed->feed.sec, 0);
+}
+#endif
+
+static struct ttusb_channel *ttusb_channel_allocate(struct ttusb *ttusb)
+{
+	int i;
+
+	if (down_interruptible(&ttusb->sem))
+		return NULL;
+
+	/* lock! */
+	for (i = 0; i < TTUSB_MAXCHANNEL; ++i) {
+		if (!ttusb->channel[i].active) {
+			ttusb->channel[i].active = 1;
+			up(&ttusb->sem);
+			return ttusb->channel + i;
+		}
+	}
+
+	up(&ttusb->sem);
+
+	return NULL;
+}
+
+static int ttusb_start_feed(struct dvb_demux_feed *dvbdmxfeed)
+{
+	struct ttusb *ttusb = (struct ttusb *) dvbdmxfeed->demux;
+	struct ttusb_channel *channel;
+
+	printk("ttusb_start_feed\n");
+
+	switch (dvbdmxfeed->type) {
+	case DMX_TYPE_TS:
+		break;
+	case DMX_TYPE_SEC:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (dvbdmxfeed->type == DMX_TYPE_TS) {
+		switch (dvbdmxfeed->pes_type) {
+		case DMX_TS_PES_VIDEO:
+		case DMX_TS_PES_AUDIO:
+		case DMX_TS_PES_TELETEXT:
+		case DMX_TS_PES_PCR:
+		case DMX_TS_PES_OTHER:
+			channel = ttusb_channel_allocate(ttusb);
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		channel = ttusb_channel_allocate(ttusb);
+	}
+
+	if (!channel)
+		return -EBUSY;
+
+	dvbdmxfeed->priv = channel;
+	channel->dvbdmxfeed = dvbdmxfeed;
+
+	channel->pid = dvbdmxfeed->pid;
+
+#ifdef TTUSB_HWSECTIONS
+	if (dvbdmxfeed->type == DMX_TYPE_TS) {
+		channel->type = 1;
+	} else if (dvbdmxfeed->type == DMX_TYPE_SEC) {
+		channel->type = 2;
+#error TODO: allocate filters
+	}
+#else
+	channel->type = 1;
+#endif
+
+	ttusb_set_channel(ttusb, channel->id, channel->type, channel->pid);
+
+	if (0 == ttusb->running_feed_count++)
+		ttusb_start_iso_xfer(ttusb);
+
+	return 0;
+}
+
+static int ttusb_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
+{
+	struct ttusb_channel *channel =
+	    (struct ttusb_channel *) dvbdmxfeed->priv;
+	struct ttusb *ttusb = (struct ttusb *) dvbdmxfeed->demux;
+
+	ttusb_del_channel(channel->ttusb, channel->id);
+
+	if (--ttusb->running_feed_count == 0)
+		ttusb_stop_iso_xfer(ttusb);
+
+	channel->active = 0;
+
+	return 0;
+}
+
+static int ttusb_setup_interfaces(struct ttusb *ttusb)
+{
+	usb_set_configuration(ttusb->dev, 1);
+	usb_set_interface(ttusb->dev, 1, 1);
+
+	ttusb->bulk_out_pipe = usb_sndbulkpipe(ttusb->dev, 1);
+	ttusb->bulk_in_pipe = usb_rcvbulkpipe(ttusb->dev, 1);
+	ttusb->isoc_in_pipe = usb_rcvisocpipe(ttusb->dev, 2);
+
+	return 0;
+}
+
+#if 0
+static u8 stc_firmware[8192];
+
+static int stc_open(struct inode *inode, struct file *file)
+{
+	struct ttusb *ttusb = file->private_data;
+	int addr;
+
+	for (addr = 0; addr < 8192; addr += 16) {
+		u8 snd_buf[2] = { addr >> 8, addr & 0xFF };
+		ttusb_i2c_msg(ttusb, 0x50, snd_buf, 2, stc_firmware + addr,
+			      16);
+	}
+
+	return 0;
+}
+
+static ssize_t stc_read(struct file *file, char *buf, size_t count,
+		 loff_t * offset)
+{
+	int tc = count;
+
+	if ((tc + *offset) > 8192)
+		tc = 8192 - *offset;
+
+	if (tc < 0)
+		return 0;
+
+	copy_to_user(buf, stc_firmware + *offset, tc);
+
+	*offset += tc;
+
+	return tc;
+}
+
+static int stc_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static struct file_operations stc_fops = {
+	.owner = THIS_MODULE,
+	.read = stc_read,
+	.open = stc_open,
+	.release = stc_release,
+};
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+static void *ttusb_probe(struct usb_device *udev, unsigned int ifnum,
+		  const struct usb_device_id *id)
+{
+	struct ttusb *ttusb;
+	int result, channel;
+
+	if (ifnum != 0)
+		return NULL;
+
+	dprintk("%s: TTUSB DVB connected\n", __FUNCTION__);
+
+	if (!(ttusb = kmalloc(sizeof(struct ttusb), GFP_KERNEL)))
+		return NULL;
+
+#else
+static int ttusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
+{
+	struct usb_device *udev;
+	struct ttusb *ttusb;
+	int result, channel;
+
+	dprintk("%s: TTUSB DVB connected\n", __FUNCTION__);
+
+	udev = interface_to_usbdev(intf);
+
+	if (!(ttusb = kmalloc(sizeof(struct ttusb), GFP_KERNEL)))
+		return -ENOMEM;
+
+#endif
+
+	memset(ttusb, 0, sizeof(struct ttusb));
+
+	for (channel = 0; channel < TTUSB_MAXCHANNEL; ++channel) {
+		ttusb->channel[channel].id = channel;
+		ttusb->channel[channel].ttusb = ttusb;
+	}
+
+	ttusb->dev = udev;
+	ttusb->c = 0;
+	ttusb->mux_state = 0;
+	sema_init(&ttusb->sem, 0);
+	sema_init(&ttusb->semusb, 1);
+
+	ttusb_setup_interfaces(ttusb);
+
+	ttusb_alloc_iso_urbs(ttusb);
+	if (ttusb_init_controller(ttusb))
+		printk("ttusb_init_controller: error\n");
+
+	up(&ttusb->sem);
+
+	dvb_register_adapter(&ttusb->adapter,
+			     "Technotrend/Hauppauge Nova-USB");
+
+	dvb_register_i2c_bus(ttusb_i2c_xfer, ttusb, ttusb->adapter, 0);
+	dvb_add_frontend_ioctls(ttusb->adapter, ttusb_lnb_ioctl, NULL,
+				ttusb);
+
+	memset(&ttusb->dvb_demux, 0, sizeof(ttusb->dvb_demux));
+
+	ttusb->dvb_demux.dmx.capabilities =
+	    DMX_TS_FILTERING | DMX_SECTION_FILTERING;
+	ttusb->dvb_demux.priv = 0;
+#ifdef TTUSB_HWSECTIONS
+	ttusb->dvb_demux.filternum = TTUSB_MAXFILTER;
+#else
+	ttusb->dvb_demux.filternum = 32;
+#endif
+	ttusb->dvb_demux.feednum = TTUSB_MAXCHANNEL;
+	ttusb->dvb_demux.start_feed = ttusb_start_feed;
+	ttusb->dvb_demux.stop_feed = ttusb_stop_feed;
+	ttusb->dvb_demux.write_to_decoder = 0;
+
+	if ((result = dvb_dmx_init(&ttusb->dvb_demux)) < 0) {
+		printk("ttusb_dvb: dvb_dmx_init failed (errno = %d)\n",
+		       result);
+		goto err;
+	}
+//FIXME dmxdev (nur WAS?)
+	ttusb->dmxdev.filternum = ttusb->dvb_demux.filternum;
+	ttusb->dmxdev.demux = &ttusb->dvb_demux.dmx;
+	ttusb->dmxdev.capabilities = 0;
+
+	if ((result = dvb_dmxdev_init(&ttusb->dmxdev, ttusb->adapter)) < 0) {
+		printk("ttusb_dvb: dvb_dmxdev_init failed (errno = %d)\n",
+		       result);
+		dvb_dmx_release(&ttusb->dvb_demux);
+		goto err;
+	}
+
+	if (dvb_net_init
+	    (ttusb->adapter, &ttusb->dvbnet, &ttusb->dvb_demux.dmx)) {
+		printk("ttusb_dvb: dvb_net_init failed!\n");
+	}
+
+      err:
+#if 0
+	ttusb->stc_devfs_handle =
+	    devfs_register(ttusb->adapter->devfs_handle, TTUSB_BUDGET_NAME,
+			   DEVFS_FL_DEFAULT, 0, 192,
+			   S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP
+			   | S_IROTH | S_IWOTH, &stc_fops, ttusb);
+#endif
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+	return (void *) ttusb;
+#else
+	usb_set_intfdata(intf, (void *) ttusb);
+
+	return 0;
+#endif
+}
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+static void ttusb_disconnect(struct usb_device *udev, void *data)
+{
+	struct ttusb *ttusb = data;
+#else
+static void ttusb_disconnect(struct usb_interface *intf)
+{
+	struct ttusb *ttusb = usb_get_intfdata(intf);
+
+	usb_set_intfdata(intf, NULL);
+#endif
+
+	ttusb->disconnecting = 1;
+
+	ttusb_stop_iso_xfer(ttusb);
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,69))
+#undef devfs_remove
+#define devfs_remove(x)	devfs_unregister(ttusb->stc_devfs_handle);
+#endif
+#if 0
+	devfs_remove(TTUSB_BUDGET_NAME);
+#endif
+	ttusb->dvb_demux.dmx.close(&ttusb->dvb_demux.dmx);
+	dvb_net_release(&ttusb->dvbnet);
+	dvb_dmxdev_release(&ttusb->dmxdev);
+	dvb_dmx_release(&ttusb->dvb_demux);
+
+	dvb_unregister_i2c_bus(ttusb_i2c_xfer, ttusb->adapter, 0);
+	dvb_unregister_adapter(ttusb->adapter);
+
+	ttusb_free_iso_urbs(ttusb);
+
+	kfree(ttusb);
+
+	dprintk("%s: TTUSB DVB disconnected\n", __FUNCTION__);
+}
+
+static struct usb_device_id ttusb_table[] = {
+	{USB_DEVICE(0xb48, 0x1003)},
+	{USB_DEVICE(0xb48, 0x1004)},	/* to be confirmed ????  */
+	{USB_DEVICE(0xb48, 0x1005)},	/* to be confirmed ????  */
+	{}
+};
+
+MODULE_DEVICE_TABLE(usb, ttusb_table);
+
+static struct usb_driver ttusb_driver = {
+      .name 		= "Technotrend/Hauppauge USB-Nova",
+      .probe 		= ttusb_probe,
+      .disconnect 	= ttusb_disconnect,
+      .id_table 	= ttusb_table,
+};
+
+static int __init ttusb_init(void)
+{
+	int err;
+
+	if ((err = usb_register(&ttusb_driver)) < 0) {
+		printk("%s: usb_register failed! Error number %d",
+		       __FILE__, err);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void __exit ttusb_exit(void)
+{
+	usb_deregister(&ttusb_driver);
+}
+
+module_init(ttusb_init);
+module_exit(ttusb_exit);
+
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "Debug or not");
+
+MODULE_AUTHOR("Holger Waechtler <holger@convergence.de>");
+MODULE_DESCRIPTION("TTUSB DVB Driver");
+MODULE_LICENSE("GPL");
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttusb-budget/dvb-ttusb-dspbootcode.h linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-budget/dvb-ttusb-dspbootcode.h
--- linux-2.6.0-test1.work/drivers/media/dvb/ttusb-budget/dvb-ttusb-dspbootcode.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-budget/dvb-ttusb-dspbootcode.h	2003-07-15 09:39:13.000000000 +0200
@@ -0,0 +1,9 @@
+
+#include <asm/types.h>
+
+u8 dsp_bootcode [] __initdata = {
+	0x08, 0xaa, 0x00, 0x18, 0x00, 0x03, 0x08, 0x00, 
+ // firmware bootloader missing, this won't work!
+	0x07, 0xef, 0xf4, 0x95, 0xf4, 0x95, 0x00, 0x00, 
+};
+
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttusb-dec/Kconfig linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-dec/Kconfig
--- linux-2.6.0-test1.work/drivers/media/dvb/ttusb-dec/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-dec/Kconfig	2003-06-24 02:06:18.000000000 +0200
@@ -0,0 +1,24 @@
+config DVB_TTUSB_DEC
+	tristate "Technotrend/Hauppauge USB DEC2000-T devices"
+	depends on DVB_CORE && USB
+	help
+	  Support for external USB adapters designed by Technotrend and
+	  produced by Hauppauge, shipped under the brand name 'DEC2000-T'.
+
+          Even if these devices have a MPEG decoder built in, they transmit
+	  only compressed MPEG data over the USB bus, so you need
+	  an external software decoder to watch TV on your computer.	  
+
+	  Say Y if you own such a device and want to use it.
+
+config DVB_TTUSB_DEC_FIRMWARE_FILE
+	string "Full pathname of dec2000t.bin firmware file"
+	depends on DVB_TTUSB_DEC
+	default "/etc/dvb/dec2000t.bin"
+	help
+	  The DEC2000-T requires a firmware in order to boot into a mode in
+	  which it is a slave to the PC.  The firmware file can obtained as
+	  follows:
+	    wget http://hauppauge.lightpath.net/de/dec215a.exe
+	    unzip -j dec215a.exe Software/Oem/STB/App/Boot/STB_PC_T.bin
+	    mv STB_PC_T.bin /etc/dvb/dec2000t.bin
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttusb-dec/Makefile linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-dec/Makefile
--- linux-2.6.0-test1.work/drivers/media/dvb/ttusb-dec/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-dec/Makefile	2003-06-24 02:06:18.000000000 +0200
@@ -0,0 +1,11 @@
+
+obj-$(CONFIG_DVB_TTUSB_DEC) += ttusb_dec.o dec2000_frontend.o
+
+EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/
+
+host-progs	:= fdump
+
+$(obj)/ttusb_dec.o: $(obj)/dsp_dec2000.h
+
+$(obj)/dsp_dec2000.h: $(patsubst "%", %, $(CONFIG_DVB_TTUSB_DEC_FIRMWARE_FILE)) $(obj)/fdump
+	$(obj)/fdump $< dsp_dec2000 > $@
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttusb-dec/dec2000_frontend.c linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-dec/dec2000_frontend.c
--- linux-2.6.0-test1.work/drivers/media/dvb/ttusb-dec/dec2000_frontend.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-dec/dec2000_frontend.c	2003-07-14 11:56:39.000000000 +0200
@@ -0,0 +1,180 @@
+/*
+ * TTUSB DEC-2000-t Frontend
+ *
+ * Copyright (C) 2003 Alex Woods <linux-dvb@giblets.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include "dvb_frontend.h"
+#include "dvb_functions.h"
+
+static int debug = 0;
+
+#define dprintk	if (debug) printk
+
+static struct dvb_frontend_info dec2000_frontend_info = {
+	name:			"TechnoTrend/Hauppauge DEC-2000-t Frontend",
+	type:			FE_OFDM,
+	frequency_min:		51000000,
+	frequency_max:		858000000,
+	frequency_stepsize:	62500,
+	caps:	FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+		FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+		FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
+		FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO |
+		FE_CAN_HIERARCHY_AUTO,
+};
+
+static int dec2000_frontend_ioctl(struct dvb_frontend *fe, unsigned int cmd,
+				  void *arg)
+{
+	dprintk("%s\n", __FUNCTION__);
+
+	switch (cmd) {
+
+	case FE_GET_INFO:
+		dprintk("%s: FE_GET_INFO\n", __FUNCTION__);
+		memcpy(arg, &dec2000_frontend_info,
+		       sizeof (struct dvb_frontend_info));
+		break;
+
+	case FE_READ_STATUS: {
+			fe_status_t *status = (fe_status_t *)arg;
+			dprintk("%s: FE_READ_STATUS\n", __FUNCTION__);
+			*status = FE_HAS_SIGNAL | FE_HAS_VITERBI |
+				  FE_HAS_SYNC | FE_HAS_CARRIER | FE_HAS_LOCK;
+			break;
+		}
+
+	case FE_READ_BER: {
+			u32 *ber = (u32 *)arg;
+			dprintk("%s: FE_READ_BER\n", __FUNCTION__);
+			*ber = 0;
+			return -ENOSYS;
+			break;
+		}
+
+	case FE_READ_SIGNAL_STRENGTH: {
+			dprintk("%s: FE_READ_SIGNAL_STRENGTH\n", __FUNCTION__);
+			*(s32 *)arg = 0xFF;
+			return -ENOSYS;
+			break;
+		}
+
+	case FE_READ_SNR:
+		dprintk("%s: FE_READ_SNR\n", __FUNCTION__);
+		*(s32 *)arg = 0;
+		return -ENOSYS;
+		break;
+
+	case FE_READ_UNCORRECTED_BLOCKS:
+		dprintk("%s: FE_READ_UNCORRECTED_BLOCKS\n", __FUNCTION__);
+		*(u32 *)arg = 0;
+		return -ENOSYS;
+		break;
+
+	case FE_SET_FRONTEND:{
+			struct dvb_frontend_parameters *p =
+				(struct dvb_frontend_parameters *)arg;
+			u8 b[] = { 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00,
+				   0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
+				   0x00, 0xff, 0x00, 0x00, 0x00, 0xff };
+			u32 freq;
+			struct i2c_msg msg = { addr: 0x71, flags: 0, len:20 };
+
+			dprintk("%s: FE_SET_FRONTEND\n", __FUNCTION__);
+
+			dprintk("            frequency->%d\n", p->frequency);
+			dprintk("            symbol_rate->%d\n",
+				p->u.qam.symbol_rate);
+			dprintk("            inversion->%d\n", p->inversion);
+
+			freq = htonl(p->frequency / 1000);
+			memcpy(&b[4], &freq, sizeof (int));
+			msg.buf = b;
+			fe->i2c->xfer(fe->i2c, &msg, 1);
+
+			break;
+		}
+
+	case FE_GET_FRONTEND:
+		dprintk("%s: FE_GET_FRONTEND\n", __FUNCTION__);
+		break;
+
+	case FE_SLEEP:
+		dprintk("%s: FE_SLEEP\n", __FUNCTION__);
+		return -ENOSYS;
+		break;
+
+	case FE_INIT:
+		dprintk("%s: FE_INIT\n", __FUNCTION__);
+		break;
+
+	case FE_RESET:
+		dprintk("%s: FE_RESET\n", __FUNCTION__);
+		break;
+
+	default:
+		dprintk("%s: unknown IOCTL (0x%X)\n", __FUNCTION__, cmd);
+		return -EINVAL;
+
+	}
+
+	return 0;
+}
+
+static int dec2000_frontend_attach(struct dvb_i2c_bus *i2c)
+{
+	dprintk("%s\n", __FUNCTION__);
+
+	dvb_register_frontend(dec2000_frontend_ioctl, i2c, NULL,
+			      &dec2000_frontend_info);
+
+	return 0;
+}
+
+static void dec2000_frontend_detach(struct dvb_i2c_bus *i2c)
+{
+	dprintk("%s\n", __FUNCTION__);
+
+	dvb_unregister_frontend(dec2000_frontend_ioctl, i2c);
+}
+
+static int __init dec2000_frontend_init(void)
+{
+	return dvb_register_i2c_device(THIS_MODULE, dec2000_frontend_attach,
+				       dec2000_frontend_detach);
+}
+
+static void __exit dec2000_frontend_exit(void)
+{
+	dvb_unregister_i2c_device(dec2000_frontend_attach);
+}
+
+module_init(dec2000_frontend_init);
+module_exit(dec2000_frontend_exit);
+
+MODULE_DESCRIPTION("TechnoTrend/Hauppauge DEC-2000-t Frontend");
+MODULE_AUTHOR("Alex Woods <linux-dvb@giblets.org");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "Debug level");
+
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttusb-dec/fdump.c linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-dec/fdump.c
--- linux-2.6.0-test1.work/drivers/media/dvb/ttusb-dec/fdump.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-dec/fdump.c	2003-06-24 02:06:18.000000000 +0200
@@ -0,0 +1,36 @@
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+
+int main (int argc, char **argv)
+{
+	unsigned char buf[8];
+	unsigned int i, count, bytes = 0;
+	int fd;
+
+	if (argc != 3) {
+		fprintf (stderr, "\n\tusage: %s <ucode.bin> <array_name>\n\n",
+			 argv[0]);
+		return -1;
+	}
+
+	fd = open (argv[1], O_RDONLY);
+
+	printf ("\n#include <asm/types.h>\n\nu8 %s [] __initdata = {",
+		argv[2]);
+
+	while ((count = read (fd, buf, 8)) > 0) {
+		printf ("\n\t");
+		for (i=0;i<count;i++, bytes++)
+			printf ("0x%02x, ", buf[i]);
+	}
+
+	printf ("\n};\n\n");
+	close (fd);
+
+	return 0;
+}
+
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- linux-2.6.0-test1.work/drivers/media/dvb/ttusb-dec/ttusb_dec.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2003-07-14 11:56:39.000000000 +0200
@@ -0,0 +1,991 @@
+/*
+ * TTUSB DEC Driver
+ *
+ * Copyright (C) 2003 Alex Woods <linux-dvb@giblets.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+
+#include "ttusb_dec.h"
+#include "dvb_frontend.h"
+
+static int debug = 0;
+
+#define dprintk	if (debug) printk
+
+static int ttusb_dec_send_command(struct ttusb_dec *dec, const u8 command,
+				  int param_length, const u8 params[],
+				  int *result_length, u8 cmd_result[])
+{
+	int result, actual_len, i;
+	u8 b[COMMAND_PACKET_SIZE + 4];
+	u8 c[COMMAND_PACKET_SIZE + 4];
+
+	dprintk("%s\n", __FUNCTION__);
+
+	if ((result = down_interruptible(&dec->usb_sem))) {
+		printk("%s: Failed to down usb semaphore.\n", __FUNCTION__);
+		return result;
+	}
+
+	b[0] = 0xaa;
+	b[1] = ++dec->trans_count;
+	b[2] = command;
+	b[3] = param_length;
+
+	if (params)
+		memcpy(&b[4], params, param_length);
+
+	if (debug) {
+		printk("%s: command: ", __FUNCTION__);
+		for (i = 0; i < param_length + 4; i++)
+			printk("0x%02X ", b[i]);
+		printk("\n");
+	}
+
+	result = usb_bulk_msg(dec->udev, dec->command_pipe, b, sizeof(b),
+			      &actual_len, HZ);
+
+	if (result) {
+		printk("%s: command bulk message failed: error %d\n",
+		       __FUNCTION__, result);
+		up(&dec->usb_sem);
+		return result;
+	}
+
+	result = usb_bulk_msg(dec->udev, dec->result_pipe, c, sizeof(c),
+			      &actual_len, HZ);
+
+	if (result) {
+		printk("%s: result bulk message failed: error %d\n",
+		       __FUNCTION__, result);
+		up(&dec->usb_sem);
+		return result;
+	} else {
+		if (debug) {
+			printk("%s: result: ", __FUNCTION__);
+			for (i = 0; i < actual_len; i++)
+				printk("0x%02X ", c[i]);
+			printk("\n");
+		}
+
+		if (result_length)
+			*result_length = c[3];
+		if (cmd_result && c[3] > 0)
+			memcpy(cmd_result, &c[4], c[3]);
+
+		up(&dec->usb_sem);
+
+		return 0;
+	}
+}
+
+static int ttusb_dec_av_pes2ts_cb(void *priv, unsigned char *data)
+{
+	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *)priv;
+
+	dvbdmxfeed->cb.ts(data, 188, 0, 0, &dvbdmxfeed->feed.ts, DMX_OK);
+
+	return 0;
+}
+
+static void ttusb_dec_set_pids(struct ttusb_dec *dec)
+{
+	u8 b[] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+		   0xff, 0xff };
+
+	u16 pcr = htons(dec->pid[DMX_PES_PCR]);
+	u16 audio = htons(dec->pid[DMX_PES_AUDIO]);
+	u16 video = htons(dec->pid[DMX_PES_VIDEO]);
+
+	dprintk("%s\n", __FUNCTION__);
+
+	memcpy(&b[0], &pcr, 2);
+	memcpy(&b[2], &audio, 2);
+	memcpy(&b[4], &video, 2);
+
+	ttusb_dec_send_command(dec, 0x50, sizeof(b), b, NULL, NULL);
+
+	if (!down_interruptible(&dec->pes2ts_sem)) {
+		dvb_filter_pes2ts_init(&dec->a_pes2ts, dec->pid[DMX_PES_AUDIO],
+				       ttusb_dec_av_pes2ts_cb, dec->demux.feed);
+		dvb_filter_pes2ts_init(&dec->v_pes2ts, dec->pid[DMX_PES_VIDEO],
+				       ttusb_dec_av_pes2ts_cb, dec->demux.feed);
+
+		up(&dec->pes2ts_sem);
+	}
+}
+
+static int ttusb_dec_i2c_master_xfer(struct dvb_i2c_bus *i2c,
+				     const struct i2c_msg msgs[], int num)
+{
+	int result, i;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	for (i = 0; i < num; i++)
+		if ((result = ttusb_dec_send_command(i2c->data, msgs[i].addr,
+						     msgs[i].len, msgs[i].buf,
+						     NULL, NULL)))
+			return result;
+
+	return 0;
+}
+
+static void ttusb_dec_process_av_pes(struct ttusb_dec * dec, u8 * av_pes,
+				     int length)
+{
+	int i;
+	u16 csum = 0;
+	u8 c;
+
+	if (length < 16) {
+		printk("%s: packet too short.\n", __FUNCTION__);
+		return;
+	}
+
+	for (i = 0; i < length; i += 2) {
+		csum ^= le16_to_cpup((u16 *)(av_pes + i));
+		c = av_pes[i];
+		av_pes[i] = av_pes[i + 1];
+		av_pes[i + 1] = c;
+	}
+
+	if (csum) {
+		printk("%s: checksum failed.\n", __FUNCTION__);
+		return;
+	}
+
+	if (length > 8 + MAX_AV_PES_LENGTH + 4) {
+		printk("%s: packet too long.\n", __FUNCTION__);
+		return;
+	}
+
+	if (!(av_pes[0] == 'A' && av_pes[1] == 'V')) {
+		printk("%s: invalid AV_PES packet.\n", __FUNCTION__);
+		return;
+	}
+
+	switch (av_pes[2]) {
+
+	case 0x01: {		/* VideoStream */
+			int prebytes = av_pes[5] & 0x03;
+			int postbytes = (av_pes[5] & 0x0c) >> 2;
+			u16 v_pes_payload_length;
+
+			if (dec->v_pes_postbytes > 0 &&
+			    dec->v_pes_postbytes == prebytes) {
+				memcpy(&dec->v_pes[dec->v_pes_length],
+				       &av_pes[12], prebytes);
+
+				if (!down_interruptible(&dec->pes2ts_sem)) {
+					dvb_filter_pes2ts(&dec->v_pes2ts,
+							  dec->v_pes,
+							  dec->v_pes_length +
+							  prebytes);
+
+					up(&dec->pes2ts_sem);
+				}
+			}
+
+			if (av_pes[5] & 0x10) {
+				dec->v_pes[7] = 0x80;
+				dec->v_pes[8] = 0x05;
+
+				dec->v_pes[9] = 0x21 |
+						((av_pes[8] & 0xc0) >> 5);
+				dec->v_pes[10] = ((av_pes[8] & 0x3f) << 2) |
+						 ((av_pes[9] & 0xc0) >> 6);
+				dec->v_pes[11] = 0x01 |
+						 ((av_pes[9] & 0x3f) << 2) |
+						 ((av_pes[10] & 0x80) >> 6);
+				dec->v_pes[12] = ((av_pes[10] & 0x7f) << 1) |
+						 ((av_pes[11] & 0xc0) >> 7);
+				dec->v_pes[13] = 0x01 |
+						 ((av_pes[11] & 0x7f) << 1);
+
+				memcpy(&dec->v_pes[14], &av_pes[12 + prebytes],
+				       length - 16 - prebytes);
+				dec->v_pes_length = 14 + length - 16 - prebytes;
+			} else {
+				dec->v_pes[7] = 0x00;
+				dec->v_pes[8] = 0x00;
+
+				memcpy(&dec->v_pes[9], &av_pes[8], length - 12);
+				dec->v_pes_length = 9 + length - 12;
+			}
+
+			dec->v_pes_postbytes = postbytes;
+
+			if (dec->v_pes[9 + dec->v_pes[8]] == 0x00 &&
+			    dec->v_pes[10 + dec->v_pes[8]] == 0x00 &&
+			    dec->v_pes[11 + dec->v_pes[8]] == 0x01)
+				dec->v_pes[6] = 0x84;
+			else
+				dec->v_pes[6] = 0x80;
+
+			v_pes_payload_length = htons(dec->v_pes_length - 6 +
+						     postbytes);
+			memcpy(&dec->v_pes[4], &v_pes_payload_length, 2);
+
+			if (postbytes == 0) {
+				if (!down_interruptible(&dec->pes2ts_sem)) {
+					dvb_filter_pes2ts(&dec->v_pes2ts,
+							  dec->v_pes,
+							  dec->v_pes_length);
+
+					up(&dec->pes2ts_sem);
+				}
+			}
+
+			break;
+		}
+
+	case 0x02:		/* MainAudioStream */
+		dvb_filter_pes2ts(&dec->a_pes2ts, &av_pes[8], length - 12);
+		break;
+
+	default:
+		printk("%s: unknown AV_PES type: %02x.\n", __FUNCTION__,
+		       av_pes[2]);
+		break;
+
+	}
+}
+
+static void ttusb_dec_process_urb_frame(struct ttusb_dec * dec, u8 * b,
+					int length)
+{
+	while (length) {
+		switch (dec->av_pes_state) {
+
+		case 0:
+		case 1:
+		case 3:
+			if (*b++ == 0xaa) {
+				dec->av_pes_state++;
+				if (dec->av_pes_state == 4)
+					dec->av_pes_length = 0;
+			} else {
+				dec->av_pes_state = 0;
+			}
+
+			length--;
+			break;
+
+		case 2:
+			if (*b++ == 0x00) {
+				dec->av_pes_state++;
+			} else {
+				dec->av_pes_state = 0;
+			}
+
+			length--;
+			break;
+
+		case 4:
+			dec->av_pes[dec->av_pes_length++] = *b++;
+
+			if (dec->av_pes_length == 8) {
+				dec->av_pes_state++;
+				dec->av_pes_payload_length = le16_to_cpup(
+						(u16 *)(dec->av_pes + 6));
+			}
+
+			length--;
+			break;
+
+		case 5: {
+				int remainder = dec->av_pes_payload_length +
+						8 - dec->av_pes_length;
+
+				if (length >= remainder) {
+					memcpy(dec->av_pes + dec->av_pes_length,
+					       b, remainder);
+					dec->av_pes_length += remainder;
+					b += remainder;
+					length -= remainder;
+					dec->av_pes_state++;
+				} else {
+					memcpy(&dec->av_pes[dec->av_pes_length],
+					       b, length);
+					dec->av_pes_length += length;
+					length = 0;
+				}
+
+				break;
+			}
+
+		case 6:
+			dec->av_pes[dec->av_pes_length++] = *b++;
+
+			if (dec->av_pes_length ==
+			    8 + dec->av_pes_payload_length + 4) {
+				ttusb_dec_process_av_pes(dec, dec->av_pes,
+							 dec->av_pes_length);
+				dec->av_pes_state = 0;
+			}
+
+			length--;
+			break;
+
+		default:
+			printk("%s: illegal packet state encountered.\n",
+			       __FUNCTION__);
+			dec->av_pes_state = 0;
+
+		}
+
+	}
+}
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+static void ttusb_dec_process_urb(struct urb *urb)
+#else
+static void ttusb_dec_process_urb(struct urb *urb, struct pt_regs *ptregs)
+#endif
+{
+	struct ttusb_dec *dec = urb->context;
+
+	if (!urb->status) {
+		int i;
+
+		for (i = 0; i < FRAMES_PER_ISO_BUF; i++) {
+			struct usb_iso_packet_descriptor *d;
+			u8 *b;
+			int length;
+
+			d = &urb->iso_frame_desc[i];
+			b = urb->transfer_buffer + d->offset;
+			length = d->actual_length;
+
+			ttusb_dec_process_urb_frame(dec, b, length);
+		}
+	} else {
+		 /* -ENOENT is expected when unlinking urbs */
+		if (urb->status != -ENOENT)
+			dprintk("%s: urb error: %d\n", __FUNCTION__,
+				urb->status);
+	}
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+	if (dec->iso_stream_count)
+		usb_submit_urb(urb, GFP_KERNEL);
+#endif
+}
+
+static void ttusb_dec_setup_urbs(struct ttusb_dec *dec)
+{
+	int i, j, buffer_offset = 0;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	for (i = 0; i < ISO_BUF_COUNT; i++) {
+		int frame_offset = 0;
+		struct urb *urb = dec->iso_urb[i];
+
+		urb->dev = dec->udev;
+		urb->context = dec;
+		urb->complete = ttusb_dec_process_urb;
+		urb->pipe = dec->stream_pipe;
+		urb->transfer_flags = URB_ISO_ASAP;
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+		urb->interval = 1;
+#endif
+		urb->number_of_packets = FRAMES_PER_ISO_BUF;
+		urb->transfer_buffer_length = ISO_FRAME_SIZE *
+					      FRAMES_PER_ISO_BUF;
+		urb->transfer_buffer = dec->iso_buffer + buffer_offset;
+		buffer_offset += ISO_FRAME_SIZE * FRAMES_PER_ISO_BUF;
+
+		for (j = 0; j < FRAMES_PER_ISO_BUF; j++) {
+			urb->iso_frame_desc[j].offset = frame_offset;
+			urb->iso_frame_desc[j].length = ISO_FRAME_SIZE;
+			frame_offset += ISO_FRAME_SIZE;
+		}
+	}
+}
+
+static void ttusb_dec_stop_iso_xfer(struct ttusb_dec *dec)
+{
+	int i;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	if (down_interruptible(&dec->iso_sem))
+		return;
+
+	dec->iso_stream_count--;
+
+	if (!dec->iso_stream_count) {
+		u8 b0[] = { 0x00 };
+
+		for (i = 0; i < ISO_BUF_COUNT; i++)
+			usb_unlink_urb(dec->iso_urb[i]);
+
+		ttusb_dec_send_command(dec, 0x81, sizeof(b0), b0, NULL, NULL);
+	}
+
+	up(&dec->iso_sem);
+}
+
+/* Setting the interface of the DEC tends to take down the USB communications
+ * for a short period, so it's important not to call this function just before
+ * trying to talk to it.
+ */
+static void ttusb_dec_set_streaming_interface(struct ttusb_dec *dec)
+{
+	if (!dec->interface) {
+		usb_set_interface(dec->udev, 0, 8);
+		dec->interface = 8;
+	}
+}
+
+static int ttusb_dec_start_iso_xfer(struct ttusb_dec *dec)
+{
+	int i, result;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	if (down_interruptible(&dec->iso_sem))
+		return -EAGAIN;
+
+	if (!dec->iso_stream_count) {
+		u8 b0[] = { 0x05 };
+
+		ttusb_dec_send_command(dec, 0x80, sizeof(b0), b0, NULL, NULL);
+
+		ttusb_dec_setup_urbs(dec);
+
+		for (i = 0; i < ISO_BUF_COUNT; i++) {
+			if ((result = usb_submit_urb(dec->iso_urb[i]
+						    , GFP_KERNEL))) {
+				printk("%s: failed urb submission %d: "
+				       "error %d\n", __FUNCTION__, i, result);
+
+				while (i) {
+					usb_unlink_urb(dec->iso_urb[i - 1]);
+					i--;
+				}
+
+				up(&dec->iso_sem);
+				return result;
+			}
+		}
+
+		dec->av_pes_state = 0;
+		dec->v_pes_postbytes = 0;
+	}
+
+	dec->iso_stream_count++;
+
+	up(&dec->iso_sem);
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+	ttusb_dec_set_streaming_interface(dec);
+#endif
+
+	return 0;
+}
+
+static int ttusb_dec_start_feed(struct dvb_demux_feed *dvbdmxfeed)
+{
+	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
+	struct ttusb_dec *dec = dvbdmx->priv;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	if (!dvbdmx->dmx.frontend)
+		return -EINVAL;
+
+	dprintk("  pid: 0x%04X\n", dvbdmxfeed->pid);
+
+	switch (dvbdmxfeed->type) {
+
+	case DMX_TYPE_TS:
+		dprintk("  type: DMX_TYPE_TS\n");
+		break;
+
+	case DMX_TYPE_SEC:
+		dprintk("  type: DMX_TYPE_SEC\n");
+		break;
+
+	default:
+		dprintk("  type: unknown (%d)\n", dvbdmxfeed->type);
+		return -EINVAL;
+
+	}
+
+	dprintk("  ts_type:");
+
+	if (dvbdmxfeed->ts_type & TS_DECODER)
+		dprintk(" TS_DECODER");
+
+	if (dvbdmxfeed->ts_type & TS_PACKET)
+		dprintk(" TS_PACKET");
+
+	if (dvbdmxfeed->ts_type & TS_PAYLOAD_ONLY)
+		dprintk(" TS_PAYLOAD_ONLY");
+
+	dprintk("\n");
+
+	switch (dvbdmxfeed->pes_type) {
+
+	case DMX_TS_PES_VIDEO:
+		dprintk("  pes_type: DMX_TS_PES_VIDEO\n");
+		dec->pid[DMX_PES_PCR] = dvbdmxfeed->pid;
+		dec->pid[DMX_PES_VIDEO] = dvbdmxfeed->pid;
+		ttusb_dec_set_pids(dec);
+		break;
+
+	case DMX_TS_PES_AUDIO:
+		dprintk("  pes_type: DMX_TS_PES_AUDIO\n");
+		dec->pid[DMX_PES_AUDIO] = dvbdmxfeed->pid;
+		ttusb_dec_set_pids(dec);
+		break;
+
+	case DMX_TS_PES_TELETEXT:
+		dec->pid[DMX_PES_TELETEXT] = dvbdmxfeed->pid;
+		dprintk("  pes_type: DMX_TS_PES_TELETEXT\n");
+		break;
+
+	case DMX_TS_PES_PCR:
+		dprintk("  pes_type: DMX_TS_PES_PCR\n");
+		dec->pid[DMX_PES_PCR] = dvbdmxfeed->pid;
+		ttusb_dec_set_pids(dec);
+		break;
+
+	case DMX_TS_PES_OTHER:
+		dprintk("  pes_type: DMX_TS_PES_OTHER\n");
+		break;
+
+	default:
+		dprintk("  pes_type: unknown (%d)\n", dvbdmxfeed->pes_type);
+		return -EINVAL;
+
+	}
+
+	ttusb_dec_start_iso_xfer(dec);
+
+	return 0;
+}
+
+static int ttusb_dec_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
+{
+	struct ttusb_dec *dec = dvbdmxfeed->demux->priv;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	ttusb_dec_stop_iso_xfer(dec);
+
+	return 0;
+}
+
+static void ttusb_dec_free_iso_urbs(struct ttusb_dec *dec)
+{
+	int i;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	for (i = 0; i < ISO_BUF_COUNT; i++)
+		if (dec->iso_urb[i])
+			usb_free_urb(dec->iso_urb[i]);
+
+	pci_free_consistent(NULL,
+			    ISO_FRAME_SIZE * (FRAMES_PER_ISO_BUF *
+					      ISO_BUF_COUNT),
+			    dec->iso_buffer, dec->iso_dma_handle);
+}
+
+static int ttusb_dec_alloc_iso_urbs(struct ttusb_dec *dec)
+{
+	int i;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	dec->iso_buffer = pci_alloc_consistent(NULL,
+					       ISO_FRAME_SIZE *
+					       (FRAMES_PER_ISO_BUF *
+						ISO_BUF_COUNT),
+				 	       &dec->iso_dma_handle);
+
+	memset(dec->iso_buffer, 0,
+	       sizeof(ISO_FRAME_SIZE * (FRAMES_PER_ISO_BUF * ISO_BUF_COUNT)));
+
+	for (i = 0; i < ISO_BUF_COUNT; i++) {
+		struct urb *urb;
+
+		if (!(urb = usb_alloc_urb(FRAMES_PER_ISO_BUF, GFP_KERNEL))) {
+			ttusb_dec_free_iso_urbs(dec);
+			return -ENOMEM;
+		}
+
+		dec->iso_urb[i] = urb;
+	}
+
+	ttusb_dec_setup_urbs(dec);
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+	for (i = 0; i < ISO_BUF_COUNT; i++) {
+		int next = (i + 1) % ISO_BUF_COUNT;
+		dec->iso_urb[i]->next = dec->iso_urb[next];
+	}
+#endif
+
+	return 0;
+}
+
+static void ttusb_dec_init_v_pes(struct ttusb_dec *dec)
+{
+	dprintk("%s\n", __FUNCTION__);
+
+	dec->v_pes[0] = 0x00;
+	dec->v_pes[1] = 0x00;
+	dec->v_pes[2] = 0x01;
+	dec->v_pes[3] = 0xe0;
+}
+
+static void ttusb_dec_init_usb(struct ttusb_dec *dec)
+{
+	dprintk("%s\n", __FUNCTION__);
+
+	sema_init(&dec->usb_sem, 1);
+	sema_init(&dec->iso_sem, 1);
+
+	dec->command_pipe = usb_sndbulkpipe(dec->udev, COMMAND_PIPE);
+	dec->result_pipe = usb_rcvbulkpipe(dec->udev, RESULT_PIPE);
+	dec->stream_pipe = usb_rcvisocpipe(dec->udev, STREAM_PIPE);
+
+	ttusb_dec_alloc_iso_urbs(dec);
+}
+
+#include "dsp_dec2000.h"
+
+static int ttusb_dec_boot_dsp(struct ttusb_dec *dec)
+{
+	int i, j, actual_len, result, size, trans_count;
+	u8 b0[] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1b, 0xc8, 0x61,
+		    0x00 };
+	u8 b1[] = { 0x61 };
+	u8 b[ARM_PACKET_SIZE];
+	u32 dsp_length = htonl(sizeof(dsp_dec2000));
+
+	dprintk("%s\n", __FUNCTION__);
+
+	memcpy(b0, &dsp_length, 4);
+
+	result = ttusb_dec_send_command(dec, 0x41, sizeof(b0), b0, NULL, NULL);
+
+	if (result)
+		return result;
+
+	trans_count = 0;
+	j = 0;
+
+	for (i = 0; i < sizeof(dsp_dec2000); i += COMMAND_PACKET_SIZE) {
+		size = sizeof(dsp_dec2000) - i;
+		if (size > COMMAND_PACKET_SIZE)
+			size = COMMAND_PACKET_SIZE;
+
+		b[j + 0] = 0xaa;
+		b[j + 1] = trans_count++;
+		b[j + 2] = 0xf0;
+		b[j + 3] = size;
+		memcpy(&b[j + 4], &dsp_dec2000[i], size);
+
+		j += COMMAND_PACKET_SIZE + 4;
+
+		if (j >= ARM_PACKET_SIZE) {
+			result = usb_bulk_msg(dec->udev, dec->command_pipe, b,
+					      ARM_PACKET_SIZE, &actual_len,
+					      HZ / 10);
+			j = 0;
+		} else if (size < COMMAND_PACKET_SIZE) {
+			result = usb_bulk_msg(dec->udev, dec->command_pipe, b,
+					      j - COMMAND_PACKET_SIZE + size,
+					      &actual_len, HZ / 10);
+		}
+	}
+
+	result = ttusb_dec_send_command(dec, 0x43, sizeof(b1), b1, NULL, NULL);
+
+	return result;
+}
+
+static void ttusb_dec_init_stb(struct ttusb_dec *dec)
+{
+	u8 c[COMMAND_PACKET_SIZE];
+	int c_length;
+	int result;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	result = ttusb_dec_send_command(dec, 0x08, 0, NULL, &c_length, c);
+
+	if (!result)
+		if (c_length != 0x0c || (c_length == 0x0c && c[9] != 0x63))
+			ttusb_dec_boot_dsp(dec);
+}
+
+static int ttusb_dec_init_dvb(struct ttusb_dec *dec)
+{
+	int result;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	if ((result = dvb_register_adapter(&dec->adapter, "dec2000")) < 0) {
+		printk("%s: dvb_register_adapter failed: error %d\n",
+		       __FUNCTION__, result);
+
+		return result;
+	}
+
+	if (!(dec->i2c_bus = dvb_register_i2c_bus(ttusb_dec_i2c_master_xfer,
+						  dec, dec->adapter, 0))) {
+		printk("%s: dvb_register_i2c_bus failed\n", __FUNCTION__);
+
+		dvb_unregister_adapter(dec->adapter);
+
+		return -ENOMEM;
+	}
+
+	dec->demux.dmx.capabilities = DMX_TS_FILTERING | DMX_SECTION_FILTERING;
+
+	dec->demux.priv = (void *)dec;
+	dec->demux.filternum = 31;
+	dec->demux.feednum = 31;
+	dec->demux.start_feed = ttusb_dec_start_feed;
+	dec->demux.stop_feed = ttusb_dec_stop_feed;
+	dec->demux.write_to_decoder = NULL;
+
+	if ((result = dvb_dmx_init(&dec->demux)) < 0) {
+		printk("%s: dvb_dmx_init failed: error %d\n", __FUNCTION__,
+		       result);
+
+		dvb_unregister_i2c_bus(ttusb_dec_i2c_master_xfer, dec->adapter,
+				       0);
+		dvb_unregister_adapter(dec->adapter);
+
+		return result;
+	}
+
+	dec->dmxdev.filternum = 32;
+	dec->dmxdev.demux = &dec->demux.dmx;
+	dec->dmxdev.capabilities = 0;
+
+	if ((result = dvb_dmxdev_init(&dec->dmxdev, dec->adapter)) < 0) {
+		printk("%s: dvb_dmxdev_init failed: error %d\n",
+		       __FUNCTION__, result);
+
+		dvb_dmx_release(&dec->demux);
+		dvb_unregister_i2c_bus(ttusb_dec_i2c_master_xfer, dec->adapter,
+				       0);
+		dvb_unregister_adapter(dec->adapter);
+
+		return result;
+	}
+
+	dec->frontend.source = DMX_FRONTEND_0;
+
+	if ((result = dec->demux.dmx.add_frontend(&dec->demux.dmx,
+						  &dec->frontend)) < 0) {
+		printk("%s: dvb_dmx_init failed: error %d\n", __FUNCTION__,
+		       result);
+
+		dvb_dmxdev_release(&dec->dmxdev);
+		dvb_dmx_release(&dec->demux);
+		dvb_unregister_i2c_bus(ttusb_dec_i2c_master_xfer, dec->adapter,
+				       0);
+		dvb_unregister_adapter(dec->adapter);
+
+		return result;
+	}
+
+	if ((result = dec->demux.dmx.connect_frontend(&dec->demux.dmx,
+						      &dec->frontend)) < 0) {
+		printk("%s: dvb_dmx_init failed: error %d\n", __FUNCTION__,
+		       result);
+
+		dec->demux.dmx.remove_frontend(&dec->demux.dmx, &dec->frontend);
+		dvb_dmxdev_release(&dec->dmxdev);
+		dvb_dmx_release(&dec->demux);
+		dvb_unregister_i2c_bus(ttusb_dec_i2c_master_xfer, dec->adapter,
+				       0);
+		dvb_unregister_adapter(dec->adapter);
+
+		return result;
+	}
+
+	sema_init(&dec->pes2ts_sem, 1);
+
+	dvb_net_init(dec->adapter, &dec->dvb_net, &dec->demux.dmx);
+
+	return 0;
+}
+
+static void ttusb_dec_exit_dvb(struct ttusb_dec *dec)
+{
+	dprintk("%s\n", __FUNCTION__);
+
+	dvb_net_release(&dec->dvb_net);
+	dec->demux.dmx.close(&dec->demux.dmx);
+	dec->demux.dmx.remove_frontend(&dec->demux.dmx, &dec->frontend);
+	dvb_dmxdev_release(&dec->dmxdev);
+	dvb_dmx_release(&dec->demux);
+	dvb_unregister_i2c_bus(ttusb_dec_i2c_master_xfer, dec->adapter, 0);
+	dvb_unregister_adapter(dec->adapter);
+}
+
+static void ttusb_dec_exit_usb(struct ttusb_dec *dec)
+{
+	int i;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	dec->iso_stream_count = 0;
+
+	for (i = 0; i < ISO_BUF_COUNT; i++)
+		usb_unlink_urb(dec->iso_urb[i]);
+
+	ttusb_dec_free_iso_urbs(dec);
+}
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+static void *ttusb_dec_probe(struct usb_device *udev, unsigned int ifnum,
+			     const struct usb_device_id *id)
+{
+	struct ttusb_dec *dec;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	if (ifnum != 0)
+		return NULL;
+
+	if (!(dec = kmalloc(sizeof(struct ttusb_dec), GFP_KERNEL))) {
+		printk("%s: couldn't allocate memory.\n", __FUNCTION__);
+		return NULL;
+	}
+
+	memset(dec, 0, sizeof(struct ttusb_dec));
+
+	dec->udev = udev;
+
+	ttusb_dec_init_usb(dec);
+	ttusb_dec_init_stb(dec);
+	ttusb_dec_init_dvb(dec);
+	ttusb_dec_init_v_pes(dec);
+
+	return (void *)dec;
+}
+#else
+static int ttusb_dec_probe(struct usb_interface *intf,
+			   const struct usb_device_id *id)
+{
+	struct usb_device *udev;
+	struct ttusb_dec *dec;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	udev = interface_to_usbdev(intf);
+
+	if (!(dec = kmalloc(sizeof(struct ttusb_dec), GFP_KERNEL))) {
+		printk("%s: couldn't allocate memory.\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+
+	memset(dec, 0, sizeof(struct ttusb_dec));
+
+	dec->udev = udev;
+
+	ttusb_dec_init_usb(dec);
+	ttusb_dec_init_stb(dec);
+	ttusb_dec_init_dvb(dec);
+	ttusb_dec_init_v_pes(dec);
+
+	usb_set_intfdata(intf, (void *)dec);
+	ttusb_dec_set_streaming_interface(dec);
+
+	return 0;
+}
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+static void ttusb_dec_disconnect(struct usb_device *udev, void *data)
+{
+	struct ttusb_dec *dec = data;
+#else
+static void ttusb_dec_disconnect(struct usb_interface *intf)
+{
+	struct ttusb_dec *dec = usb_get_intfdata(intf);
+
+	usb_set_intfdata(intf, NULL);
+#endif
+
+	dprintk("%s\n", __FUNCTION__);
+
+	ttusb_dec_exit_usb(dec);
+	ttusb_dec_exit_dvb(dec);
+
+	kfree(dec);
+}
+
+static struct usb_device_id ttusb_dec_table[] = {
+	{USB_DEVICE(0x0b48, 0x1006)},	/* Unconfirmed */
+	{USB_DEVICE(0x0b48, 0x1007)},	/* Unconfirmed */
+	{USB_DEVICE(0x0b48, 0x1008)},	/* DEC 2000 t */
+	{}
+};
+
+static struct usb_driver ttusb_dec_driver = {
+      name:		DRIVER_NAME,
+      probe:		ttusb_dec_probe,
+      disconnect:	ttusb_dec_disconnect,
+      id_table:		ttusb_dec_table,
+};
+
+static int __init ttusb_dec_init(void)
+{
+	int result;
+
+	if ((result = usb_register(&ttusb_dec_driver)) < 0) {
+		printk("%s: initialisation failed: error %d.\n", __FUNCTION__,
+		       result);
+		return result;
+	}
+
+	return 0;
+}
+
+static void __exit ttusb_dec_exit(void)
+{
+	usb_deregister(&ttusb_dec_driver);
+}
+
+module_init(ttusb_dec_init);
+module_exit(ttusb_dec_exit);
+
+MODULE_AUTHOR("Alex Woods <linux-dvb@giblets.org>");
+MODULE_DESCRIPTION(DRIVER_NAME);
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(usb, ttusb_dec_table);
+
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "Debug level");
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttusb-dec/ttusb_dec.h linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-dec/ttusb_dec.h
--- linux-2.6.0-test1.work/drivers/media/dvb/ttusb-dec/ttusb_dec.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttusb-dec/ttusb_dec.h	2003-07-14 11:56:39.000000000 +0200
@@ -0,0 +1,87 @@
+/*
+ * TTUSB DEC Driver
+ *
+ * Copyright (C) 2003 Alex Woods <linux-dvb@giblets.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#ifndef _TTUSB_DEC_H
+#define _TTUSB_DEC_H
+
+#include "asm/semaphore.h"
+#include "dmxdev.h"
+#include "dvb_demux.h"
+#include "dvb_filter.h"
+#include "dvb_i2c.h"
+#include "dvb_net.h"
+
+#define DRIVER_NAME		"TechnoTrend/Hauppauge DEC USB"
+
+#define COMMAND_PIPE		0x03
+#define RESULT_PIPE		0x84
+#define STREAM_PIPE		0x88
+
+#define COMMAND_PACKET_SIZE	0x3c
+#define ARM_PACKET_SIZE		0x1000
+
+#define ISO_BUF_COUNT		0x04
+#define FRAMES_PER_ISO_BUF	0x04
+#define ISO_FRAME_SIZE		0x0380
+
+#define	MAX_AV_PES_LENGTH	6144
+
+struct ttusb_dec {
+	/* DVB bits */
+	struct dvb_adapter	*adapter;
+	struct dmxdev		dmxdev;
+	struct dvb_demux	demux;
+	struct dmx_frontend	frontend;
+	struct dvb_i2c_bus	*i2c_bus;
+	struct dvb_net		dvb_net;
+
+	u16			pid[DMX_PES_OTHER];
+
+	/* USB bits */
+	struct usb_device	*udev;
+	u8			trans_count;
+	unsigned int		command_pipe;
+	unsigned int		result_pipe;
+	unsigned int		stream_pipe;
+	int			interface;
+	struct semaphore	usb_sem;
+
+	void			*iso_buffer;
+	dma_addr_t		iso_dma_handle;
+	struct urb		*iso_urb[ISO_BUF_COUNT];
+	int			iso_stream_count;
+	struct semaphore	iso_sem;
+
+	u8			av_pes[MAX_AV_PES_LENGTH + 4];
+	int			av_pes_state;
+	int			av_pes_length;
+	int			av_pes_payload_length;
+
+	struct dvb_filter_pes2ts	a_pes2ts;
+	struct dvb_filter_pes2ts	v_pes2ts;
+	struct semaphore		pes2ts_sem;
+
+	u8			v_pes[16 + MAX_AV_PES_LENGTH];
+	int			v_pes_length;
+	int			v_pes_postbytes;
+};
+
+#endif

