Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268834AbUIQPR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268834AbUIQPR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268877AbUIQPR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:17:26 -0400
Received: from mail.convergence.de ([212.227.36.84]:45985 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268834AbUIQOi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:38:26 -0400
Message-ID: <414AF6B1.9040706@linuxtv.org>
Date: Fri, 17 Sep 2004 16:37:37 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][11/14] new DVB driver
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org> <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org> <414AF461.4050707@linuxtv.org> <414AF4CE.7000000@linuxtv.org> <414AF51D.4060308@linuxtv.org> <414AF569.2020803@linuxtv.org> <414AF5BF.4020401@linuxtv.org> <414AF605.5040605@linuxtv.org> <414AF65F.2010200@linuxtv.org>
In-Reply-To: <414AF65F.2010200@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------050807020305060701080403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050807020305060701080403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------050807020305060701080403
Content-Type: text/plain;
 name="11-DVB-new-driver-dibusb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="11-DVB-new-driver-dibusb.diff"

- [DVB] new driver for mobile USB Budget DVB-T devices, thanks to Patrick Boettcher

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/dibusb/dvb-dibusb.c linux-2.6.8.1-patched/drivers/media/dvb/dibusb/dvb-dibusb.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/dibusb/dvb-dibusb.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-patched/drivers/media/dvb/dibusb/dvb-dibusb.c	2004-09-17 11:51:57.000000000 +0200
@@ -0,0 +1,719 @@
+/*
+ * Driver for mobile USB Budget DVB-T devices based on reference 
+ * design made by DiBcom (http://www.dibcom.fr/)
+ * 
+ * dvb-dibusb.c
+ * 
+ * Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de)
+ * 
+ * based on GPL code from DiBcom, which has
+ *
+ * Copyright (C) 2004 Amaury Demol for DiBcom (ademol@dibcom.fr)
+ *
+ * 
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2.
+ *
+ * Acknowledgements
+ * 
+ *  Amaury Demol (ademol@dibcom.fr) from DiBcom for providing specs and driver
+ *  sources, on which this driver (and the dib3000mb frontend) are based.
+ *
+ *  TODO
+ *   - probing for i2c addresses, it is possible, that they have been changed 
+ *     by the vendor
+ * 
+ * see Documentation/dvb/README.dibusb for more information
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/usb.h>
+#include <linux/firmware.h>
+#include <linux/version.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+
+#include "dmxdev.h"
+#include "dvb_demux.h"
+#include "dvb_filter.h"
+#include "dvb_net.h"
+#include "dvb_frontend.h"
+
+#include "dvb-dibusb.h"
+
+/* debug */
+
+#ifdef CONFIG_DVB_DIBCOM_DEBUG
+#define dprintk_new(level,args...) \
+	    do { if ((debug & level)) { printk(args); } } while (0)
+
+#define debug_dump(b,l) if (debug) {\
+	int i; deb_xfer("%s: %d > ",__FUNCTION__,l); \
+	for (i = 0; i < l; i++) deb_xfer("%02x ", b[i]); \
+	deb_xfer("\n");\
+}
+
+static int debug;
+module_param(debug, int, 0x644);
+MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=alotmore (|-able)).");
+#else
+#define dprintk_new(args...)
+#define debug_dump(b,l)
+#endif
+
+#define deb_info(args...) dprintk_new(0x01,args)
+#define deb_xfer(args...) dprintk_new(0x02,args)
+#define deb_alot(args...) dprintk_new(0x04,args)
+
+/* Version information */
+#define DRIVER_VERSION "0.0"
+#define DRIVER_DESC "DiBcom based USB Budget DVB-T device"
+#define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
+
+/* USB Driver stuff */
+	
+/* table of devices that work with this driver */
+static struct usb_device_id dibusb_table [] = {
+	{ USB_DEVICE(USB_TWINHAN_VENDOR_ID, USB_VP7041_PRODUCT_PREFW_ID) },
+	{ USB_DEVICE(USB_TWINHAN_VENDOR_ID, USB_VP7041_PRODUCT_ID) },
+	{ USB_DEVICE(USB_IMC_NETWORKS_VENDOR_ID, USB_VP7041_PRODUCT_PREFW_ID) },
+	{ USB_DEVICE(USB_IMC_NETWORKS_VENDOR_ID, USB_VP7041_PRODUCT_ID) },
+	{ USB_DEVICE(USB_KWORLD_VENDOR_ID, USB_VSTREAM_PRODUCT_PREFW_ID) },
+	{ USB_DEVICE(USB_KWORLD_VENDOR_ID, USB_VSTREAM_PRODUCT_ID) },
+	{ USB_DEVICE(USB_DIBCOM_VENDOR_ID, USB_DIBCOM_PRODUCT_PREFW_ID) },
+	{ USB_DEVICE(USB_DIBCOM_VENDOR_ID, USB_DIBCOM_PRODUCT_ID) },
+	{ USB_DEVICE(USB_ULTIMA_ELECTRONIC_ID, USB_ULTIMA_ELEC_PROD_PREFW_ID) },
+	{ USB_DEVICE(USB_ULTIMA_ELECTRONIC_ID, USB_ULTIMA_ELEC_PROD_ID) },
+	{ }					/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE (usb, dibusb_table);
+
+static int dibusb_readwrite_usb(struct usb_dibusb *dib, 
+		u8 *wbuf, u16 wlen, u8 *rbuf, u16 rlen)
+{
+	int actlen,ret = -ENOMEM;
+
+	if (wbuf == NULL || wlen == 0)
+		return -EINVAL;
+
+/*	if (dib->disconnecting)
+		return -EINVAL;*/
+
+	if ((ret = down_interruptible(&dib->usb_sem)))
+		return ret;
+
+	debug_dump(wbuf,wlen);
+		
+	ret = usb_bulk_msg(dib->udev,COMMAND_PIPE,
+			wbuf,wlen,&actlen,DIBUSB_I2C_TIMEOUT);
+		
+	if (ret)
+		err("bulk message failed: %d (%d/%d)",ret,wlen,actlen);
+	else
+		ret = actlen != wlen ? -1 : 0;
+
+	/* an answer is expected */
+	if (!ret && rbuf && rlen) {
+		ret = usb_bulk_msg(dib->udev,RESULT_PIPE,rbuf,rlen,
+				&actlen,DIBUSB_I2C_TIMEOUT);
+
+		if (ret)
+			err("recv bulk message failed: %d",ret);
+		else {
+			deb_alot("rlen: %d\n",rlen);
+			debug_dump(rbuf,actlen);
+		}
+	}
+	
+	up(&dib->usb_sem);
+	return ret;
+}
+
+static int dibusb_write_usb(struct usb_dibusb *dib, u8 *buf, u16 len)
+{
+	return dibusb_readwrite_usb(dib,buf,len,NULL,0);
+}
+
+static int dibusb_i2c_msg(struct usb_dibusb *dib, u8 addr, 
+		u8 *wbuf, u16 wlen, u8 *rbuf, u16 rlen)
+{
+	u8 sndbuf[wlen+4]; /* lead(1) devaddr,direction(1) addr(2) data(wlen) (len(2) (when reading)) */
+	/* write only ? */
+	int wo = (rbuf == NULL || rlen == 0), 
+		len = 2 + wlen + (wo ? 0 : 2);
+
+	deb_alot("wo: %d, wlen: %d, len: %d\n",wo,wlen,len);
+	
+	sndbuf[0] = wo ? DIBUSB_REQ_I2C_WRITE : DIBUSB_REQ_I2C_READ;
+	sndbuf[1] = (addr & 0xfe) | (wo ? 0 : 1);
+
+	memcpy(&sndbuf[2],wbuf,wlen);
+	
+	if (!wo) {
+		sndbuf[wlen+2] = (rlen >> 8) & 0xff;
+		sndbuf[wlen+3] = rlen & 0xff;
+	}
+	
+	return dibusb_readwrite_usb(dib,sndbuf,len,rbuf,rlen);
+}
+
+/*
+ * DVB stuff 
+ */
+
+static struct dibusb_pid * dibusb_get_free_pid(struct usb_dibusb *dib)
+{
+	int i;
+	unsigned long flags;
+	struct dibusb_pid *dpid = NULL;
+
+	spin_lock_irqsave(&dib->pid_list_lock,flags);
+	for (i=0; i < DIBUSB_MAX_PIDS; i++)
+		if (!dib->pid_list[i].active) {
+			dpid = dib->pid_list + i;
+			dpid->active = 1;
+			break;
+		}
+	spin_unlock_irqrestore(&dib->pid_list_lock,flags);
+	return dpid;
+}
+
+static int dibusb_start_xfer(struct usb_dibusb *dib)
+{
+	u8 b[4] = { 
+		(DIB3000MB_REG_FIFO >> 8) & 0xff,
+		(DIB3000MB_REG_FIFO) & 0xff,
+		(DIB3000MB_FIFO_ACTIVATE >> 8) & 0xff,
+		(DIB3000MB_FIFO_ACTIVATE) & 0xff
+	};
+	return dibusb_i2c_msg(dib,DIBUSB_DEMOD_I2C_ADDR_DEFAULT,b,4,NULL,0);
+}
+
+static int dibusb_stop_xfer(struct usb_dibusb *dib)
+{
+	u8 b[4] = { 
+		(DIB3000MB_REG_FIFO >> 8) & 0xff,
+		(DIB3000MB_REG_FIFO) & 0xff,
+		(DIB3000MB_FIFO_INHIBIT >> 8) & 0xff,
+		(DIB3000MB_FIFO_INHIBIT) & 0xff
+	};
+	return dibusb_i2c_msg(dib,DIBUSB_DEMOD_I2C_ADDR_DEFAULT,b,4,NULL,0);
+}
+
+static int dibusb_set_pid(struct dibusb_pid *dpid)
+{
+	u16 pid = dpid->pid | (dpid->active ? DIB3000MB_ACTIVATE_FILTERING : 0);
+	u8 b[4] = { 
+		(dpid->reg >> 8) & 0xff,
+		(dpid->reg) & 0xff,
+		(pid >> 8) & 0xff,
+		(pid) & 0xff
+	};
+	
+	return dibusb_i2c_msg(dpid->dib,DIBUSB_DEMOD_I2C_ADDR_DEFAULT,b,4,NULL,0);
+}
+
+static void dibusb_urb_complete(struct urb *urb, struct pt_regs *ptregs)
+{
+	struct usb_dibusb *dib = urb->context;
+
+	if (!dib->streaming)
+		return;
+
+	if (urb->status == 0) {
+		deb_info("URB return len: %d\n",urb->actual_length);
+		if (urb->actual_length % 188)
+			deb_info("TS Packets: %d, %d\n", urb->actual_length/188,urb->actual_length % 188);
+		dvb_dmx_swfilter_packets(&dib->demux, (u8*) urb->transfer_buffer,urb->actual_length/188);
+	}
+
+	if (dib->streaming)
+		usb_submit_urb(urb,GFP_KERNEL);
+}
+
+
+static int dibusb_start_feed(struct dvb_demux_feed *dvbdmxfeed)
+{
+//	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
+	struct usb_dibusb *dib = dvbdmxfeed->demux->priv;
+	struct dibusb_pid *dpid;
+	int ret = 0;
+
+	deb_info("pid: 0x%04x, feedtype: %d\n", dvbdmxfeed->pid,dvbdmxfeed->type);
+
+	if ((dpid = dibusb_get_free_pid(dib)) == NULL) {
+		err("no free pid in list.");
+		return -ENODEV;
+	}
+	dvbdmxfeed->priv = dpid;
+	dpid->pid = dvbdmxfeed->pid;
+
+	dibusb_set_pid(dpid);
+
+	if (0 == dib->feed_count++) {
+		usb_fill_bulk_urb( dib->buf_urb, dib->udev, DATA_PIPE,
+			dib->buffer, 8192, dibusb_urb_complete, dib);
+		dib->buf_urb->transfer_flags = 0;
+		dib->buf_urb->timeout = 0;
+
+		if ((ret = usb_submit_urb(dib->buf_urb,GFP_KERNEL))) {
+			dibusb_stop_xfer(dib);
+			err("could not submit buffer urb.");
+			return ret;
+		}
+		
+		if ((ret = dibusb_start_xfer(dib)))
+			return ret;
+
+		dib->streaming = 1;
+	}
+	return 0;
+}
+
+static int dibusb_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
+{
+	struct usb_dibusb *dib = dvbdmxfeed->demux->priv;
+	struct dibusb_pid *dpid = (struct dibusb_pid *) dvbdmxfeed->priv;
+
+	deb_info("stopfeed pid: 0x%04x, feedtype: %d",dvbdmxfeed->pid, dvbdmxfeed->type);
+
+	if (dpid == NULL)
+		err("channel in dmxfeed->priv was NULL");
+	else {
+		dpid->active = 0;
+		dpid->pid = 0;
+		dibusb_set_pid(dpid);
+	}
+
+	if (--dib->feed_count == 0) {
+		dib->streaming = 0;
+		usb_unlink_urb(dib->buf_urb);
+		dibusb_stop_xfer(dib);
+	}		
+	return 0;
+}
+
+/*
+ * firmware transfers
+ */
+
+/*
+ * do not use this, just a workaround for a bug, 
+ * which will never occur :).
+ */
+static int dibusb_interrupt_read_loop(struct usb_dibusb *dib)
+{
+	u8 b[1] = { DIBUSB_REQ_INTR_READ };
+	return dibusb_write_usb(dib,b,1);
+}
+
+/*
+ * TODO: a tasklet should run with a delay of 1/10 second
+ * and fill an appropriate event device ?
+ */
+static int dibusb_read_remote_control(struct usb_dibusb *dib) 
+{
+	u8 b[1] = { DIBUSB_REQ_POLL_REMOTE }, rb[5];
+	int ret;
+	if ((ret = dibusb_readwrite_usb(dib,b,1,rb,5))) 
+		return ret;
+
+	return 0;
+}
+
+/*
+ * ioctl for the firmware 
+ */
+static int dibusb_ioctl_cmd(struct usb_dibusb *dib, u8 cmd, u8 *param, int plen)
+{
+	u8 b[34];
+	int size = plen > 32 ? 32 : plen;
+	b[0] = DIBUSB_REQ_SET_IOCTL;
+	b[1] = cmd;
+	memcpy(&b[2],param,size);
+
+	return dibusb_write_usb(dib,b,2+size);
+}
+
+/*
+ * ioctl for power control
+ */
+static int dibusb_hw_sleep(struct usb_dibusb *dib)
+{
+	u8 b[1] = { DIBUSB_IOCTL_POWER_SLEEP };
+	return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
+}
+
+static int dibusb_hw_wakeup(struct usb_dibusb *dib)
+{
+	u8 b[1] = { DIBUSB_IOCTL_POWER_WAKEUP };
+	return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
+}
+
+/*
+ * I2C
+ */
+static int dibusb_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num)
+{
+	struct usb_dibusb *dib = i2c_get_adapdata(adap);
+	int i;
+
+	if (down_interruptible(&dib->i2c_sem) < 0) 
+		return -EAGAIN;
+	
+	for (i = 0; i < num; i++) {
+		/* write/read request */
+		if (i+1 < num && (msg[i+1].flags & I2C_M_RD)) {
+			if (dibusb_i2c_msg(dib, msg[i].addr, msg[i].buf,msg[i].len,
+						msg[i+1].buf,msg[i+1].len) < 0)
+				break;
+			i++;
+		} else 
+			if (dibusb_i2c_msg(dib, msg[i].addr, msg[i].buf,msg[i].len,NULL,0) < 0)
+				break;
+	}
+	
+	up(&dib->i2c_sem);
+	return i;	
+}
+
+static u32 dibusb_i2c_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C;
+}
+
+static int dibusb_i2c_client_register (struct i2c_client *i2c)
+{
+	struct usb_dibusb *dib = i2c_get_adapdata(i2c->adapter);
+	if (i2c->driver->command)
+		return i2c->driver->command(i2c,FE_REGISTER,dib->adapter);
+	return 0;
+}
+
+static int dibusb_i2c_client_unregister (struct i2c_client *i2c)
+{
+	struct usb_dibusb *dib = i2c_get_adapdata(i2c->adapter);
+	if (i2c->driver->command)
+		return i2c->driver->command(i2c,FE_UNREGISTER,dib->adapter);
+	return 0;
+}
+
+static struct i2c_algorithm dibusb_algo = {
+	.name			= "DiBcom USB i2c algorithm",
+	.id				= I2C_ALGO_BIT,
+	.master_xfer	= dibusb_i2c_xfer,
+	.functionality	= dibusb_i2c_func,
+};
+
+static int dibusb_dvb_init(struct usb_dibusb *dib)
+{
+	int ret;
+
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,4)
+    if ((ret = dvb_register_adapter(&dib->adapter, DRIVER_DESC)) < 0) {
+#else
+    if ((ret = dvb_register_adapter(&dib->adapter, DRIVER_DESC , 
+			THIS_MODULE)) < 0) {
+#endif
+		deb_info("dvb_register_adapter failed: error %d", ret);
+		goto err;
+	}
+
+	strncpy(dib->i2c_adap.name,dib->dibdev->name,I2C_NAME_SIZE);
+#ifdef I2C_ADAP_CLASS_TV_DIGITAL
+	dib->i2c_adap.class = I2C_ADAP_CLASS_TV_DIGITAL,
+#else
+	dib->i2c_adap.class = I2C_CLASS_TV_DIGITAL,
+#endif
+	dib->i2c_adap.algo 		= &dibusb_algo;
+	dib->i2c_adap.algo_data = NULL;
+	dib->i2c_adap.id		= I2C_ALGO_BIT;
+	dib->i2c_adap.client_register   = dibusb_i2c_client_register,
+	dib->i2c_adap.client_unregister = dibusb_i2c_client_unregister,
+	
+	i2c_set_adapdata(&dib->i2c_adap, dib);
+	
+	if ((i2c_add_adapter(&dib->i2c_adap) < 0)) {
+		err("could not add i2c adapter");
+		goto err_i2c;
+	}
+
+	dib->demux.dmx.capabilities = DMX_TS_FILTERING | DMX_SECTION_FILTERING;
+
+	dib->demux.priv = (void *)dib;
+	dib->demux.filternum = DIBUSB_MAX_PIDS;
+	dib->demux.feednum = DIBUSB_MAX_PIDS;
+	dib->demux.start_feed = dibusb_start_feed;
+	dib->demux.stop_feed = dibusb_stop_feed;
+	dib->demux.write_to_decoder = NULL;
+	if ((ret = dvb_dmx_init(&dib->demux)) < 0) {
+		err("dvb_dmx_init failed: error %d",ret);
+		goto err_dmx;
+	}
+
+	dib->dmxdev.filternum = dib->demux.filternum;
+	dib->dmxdev.demux = &dib->demux.dmx;
+	dib->dmxdev.capabilities = 0;
+	if ((ret = dvb_dmxdev_init(&dib->dmxdev, dib->adapter)) < 0) {
+		err("dvb_dmxdev_init failed: error %d",ret);
+		goto err_dmx_dev;
+	}
+
+	dvb_net_init(dib->adapter, &dib->dvb_net, &dib->demux.dmx);
+	
+	goto success;
+err_dmx_dev:
+	dvb_dmx_release(&dib->demux);
+err_dmx:
+	i2c_del_adapter(&dib->i2c_adap);
+err_i2c:
+	dvb_unregister_adapter(dib->adapter);
+err:
+	return ret;
+success:
+	return 0;
+}
+
+static int dibusb_dvb_exit(struct usb_dibusb *dib)
+{
+	deb_info("unregistering DVB part\n");
+	dvb_net_release(&dib->dvb_net);
+	dib->demux.dmx.close(&dib->demux.dmx);
+	dvb_dmxdev_release(&dib->dmxdev);
+	dvb_dmx_release(&dib->demux);
+	i2c_del_adapter(&dib->i2c_adap);
+	dvb_unregister_adapter(dib->adapter);
+
+	return 0;
+}
+
+static int dibusb_exit(struct usb_dibusb *dib)
+{
+	usb_free_urb(dib->buf_urb);
+	pci_free_consistent(NULL,8192,dib->buffer,dib->dma_handle);
+	return 0;
+}
+
+static int dibusb_init(struct usb_dibusb *dib)
+{
+	int ret,i;
+	sema_init(&dib->usb_sem, 1);
+	sema_init(&dib->i2c_sem, 1);
+	
+	/*
+	 * when reloading the driver w/o replugging the device 
+	 * a timeout occures, this helps
+	 */
+	usb_clear_halt(dib->udev,COMMAND_PIPE);
+	usb_clear_halt(dib->udev,RESULT_PIPE);
+	usb_clear_halt(dib->udev,DATA_PIPE);
+
+	/* dibusb_reset_cpu(dib); */
+
+	dib->buffer = pci_alloc_consistent(NULL,8192, &dib->dma_handle);
+	memset(dib->buffer,0,8192);
+	if (!(dib->buf_urb = usb_alloc_urb(0,GFP_KERNEL))) {
+		dibusb_exit(dib);
+		return -ENOMEM;
+	}
+	
+	for (i=0; i < DIBUSB_MAX_PIDS; i++) {
+		dib->pid_list[i].reg = i+DIB3000MB_REG_FIRST_PID;
+		dib->pid_list[i].pid = 0;
+		dib->pid_list[i].active = 0;
+		dib->pid_list[i].dib = dib;
+	}
+
+	dib->streaming = 0;
+	dib->feed_count = 0;
+	
+	if ((ret = dibusb_dvb_init(dib))) {
+		dibusb_exit(dib);
+		return ret;
+	}
+	return 0;
+}
+
+/*
+ * load a firmware packet to the device 
+ */
+static int dibusb_writemem(struct usb_device *udev,u16 addr,u8 *data, u8 len)
+{
+	return usb_control_msg(udev, usb_sndctrlpipe(udev,0),
+			0xa0, USB_TYPE_VENDOR, addr, 0x00, data, len, 5*HZ);
+}
+
+static int dibusb_loadfirmware(struct usb_device *udev,
+		struct dibusb_device *dibdev) 
+{
+	const struct firmware *fw = NULL;
+	u16 addr;
+	u8 *b,*p;
+	int ret = 0,i;
+
+	for (i = 0; i < sizeof(valid_firmware_filenames)/sizeof(const char*); i++) {
+		if ((ret = request_firmware(&fw, valid_firmware_filenames[i], &udev->dev)) == 0) {
+			info("using firmware file (%s).",valid_firmware_filenames[i]);
+			break;
+		}
+		deb_info("tried to find '%s' firmware - unsuccessful. (%d)\n",
+				valid_firmware_filenames[i],ret);
+	}
+		
+	if (fw == NULL) {
+		err("did not find a valid firmware file. "
+			"Please see linux/Documentation/dvb/ for more details on firmware-problems.");
+		return -EINVAL;
+	} 
+	p = kmalloc(fw->size,GFP_KERNEL);	
+	if (p != NULL) {
+		u8 reset;
+		/*
+		 * you cannot use the fw->data as buffer for 
+		 * usb_control_msg, a new buffer has to be
+		 * created
+		 */
+		memcpy(p,fw->data,fw->size);
+
+		/* stop the CPU */
+		reset = 1;
+		if ((ret = dibusb_writemem(udev,DIBUSB_CPU_CSREG,&reset,1)) != 1) 
+			err("could not stop the USB controller CPU.");
+		for(i = 0; p[i+3] == 0 && i < fw->size; ) { 
+			b = (u8 *) &p[i];
+			addr = *((u16 *) &b[1]);
+
+			ret = dibusb_writemem(udev,addr,&b[4],b[0]);
+		
+			if (ret != b[0]) {
+				err("error while transferring firmware "
+					"(transferred size: %d, block size: %d)",
+					ret,b[1]);
+				ret = -EINVAL;
+				break;
+			}
+			i += 5 + b[0];
+		}
+		/* restart the CPU */
+		reset = 0;
+		if ((ret = dibusb_writemem(udev,DIBUSB_CPU_CSREG,&reset,1)) != 1) 
+			err("could not restart the USB controller CPU.");
+
+		kfree(p);
+		ret = 0;
+	} else { 
+		ret = -ENOMEM;
+	}
+	release_firmware(fw);
+
+	return ret;
+}
+
+/*
+ * USB 
+ */
+static int dibusb_probe(struct usb_interface *intf, 
+		const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct usb_dibusb *dib = NULL;
+	struct dibusb_device *dibdev = NULL;
+	
+	int ret = -ENOMEM,i,cold=0;
+
+	for (i = 0; i < DIBUSB_SUPPORTED_DEVICES; i++)
+		if (dibusb_devices[i].cold_product_id == udev->descriptor.idProduct || 
+			dibusb_devices[i].warm_product_id == udev->descriptor.idProduct) {
+			dibdev = &dibusb_devices[i];
+			
+			cold = dibdev->cold_product_id == udev->descriptor.idProduct;
+			
+			if (cold)
+				info("found a '%s' in cold state, will try to load a firmware",dibdev->name);
+			else
+				info("found a '%s' in warm state.",dibdev->name);
+		}
+	
+	if (dibdev == NULL) {
+		err("something went very wrong, "
+				"unknown product ID: %.4x",udev->descriptor.idProduct);
+		return -ENODEV;
+	}
+	
+	if (cold)
+		ret = dibusb_loadfirmware(udev,dibdev);
+	else {
+		dib = kmalloc(sizeof(struct usb_dibusb),GFP_KERNEL);
+		if (dib == NULL) {
+			err("no memory");
+			return ret;
+		}
+		memset(dib,0,sizeof(struct usb_dibusb));
+		
+		dib->udev = udev;
+		dib->dibdev = dibdev;
+		
+		usb_set_intfdata(intf, dib);
+
+		ret = dibusb_init(dib);
+	}
+	
+	if (ret == 0)
+		info("%s successfully initialized and connected.",dibdev->name);
+	else 
+		info("%s error while loading driver (%d)",dibdev->name,ret);
+	return ret;
+}
+
+static void dibusb_disconnect(struct usb_interface *intf)
+{
+	struct usb_dibusb *dib = usb_get_intfdata(intf);
+	const char *name = DRIVER_DESC;
+	
+	usb_set_intfdata(intf,NULL);
+	if (dib != NULL) {
+		name = dib->dibdev->name;
+		dibusb_dvb_exit(dib);
+		dibusb_exit(dib);
+		kfree(dib);
+	}
+	info("%s successfully deinitialized and disconnected.",name);
+	
+}
+
+/* usb specific object needed to register this driver with the usb subsystem */
+static struct usb_driver dibusb_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "dvb_dibusb",
+	.probe 		= dibusb_probe,
+	.disconnect = dibusb_disconnect,
+	.id_table 	= dibusb_table,
+};
+
+/* module stuff */
+static int __init usb_dibusb_init(void)
+{
+	int result;
+	if ((result = usb_register(&dibusb_driver))) {
+		err("usb_register failed. Error number %d",result);
+		return result;
+	}
+	
+	return 0;
+}
+
+static void __exit usb_dibusb_exit(void)
+{
+	/* deregister this driver from the USB subsystem */
+	usb_deregister(&dibusb_driver);
+}
+
+module_init (usb_dibusb_init);
+module_exit (usb_dibusb_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/dibusb/dvb-dibusb.h linux-2.6.8.1-patched/drivers/media/dvb/dibusb/dvb-dibusb.h
--- linux-2.6.8.1-dvb1/drivers/media/dvb/dibusb/dvb-dibusb.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-patched/drivers/media/dvb/dibusb/dvb-dibusb.h	2004-09-13 23:28:47.000000000 +0200
@@ -0,0 +1,175 @@
+/*
+ * dvb-dibusb.h
+ * 
+ * Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de)
+ * 
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2.
+ *
+ *
+ * for more information see dvb-dibusb.c .
+ */
+
+#ifndef __DVB_DIBUSB_H__
+#define __DVB_DIBUSB_H__
+
+/* Vendor IDs */
+#define USB_TWINHAN_VENDOR_ID			0x1822
+#define USB_IMC_NETWORKS_VENDOR_ID		0x13d3
+#define USB_KWORLD_VENDOR_ID			0xeb1a
+#define USB_DIBCOM_VENDOR_ID			0x10b8
+#define USB_ULTIMA_ELECTRONIC_ID		0x05d8
+
+/* Product IDs before loading the firmware */
+#define USB_VP7041_PRODUCT_PREFW_ID		0x3201
+#define USB_VSTREAM_PRODUCT_PREFW_ID	0x17de
+#define USB_DIBCOM_PRODUCT_PREFW_ID		0x0bb8
+#define USB_ULTIMA_ELEC_PROD_PREFW_ID	0x8105
+
+/* product ID afterwards */
+#define USB_VP7041_PRODUCT_ID			0x3202
+#define USB_VSTREAM_PRODUCT_ID			0x17df
+#define USB_DIBCOM_PRODUCT_ID			0x0bb9
+#define USB_ULTIMA_ELEC_PROD_ID			0x8106
+
+/* CS register start/stop the usb controller cpu */
+#define DIBUSB_CPU_CSREG				0x7F92
+
+// 0x10 is the I2C address of the first demodulator on the board
+#define DIBUSB_DEMOD_I2C_ADDR_DEFAULT	0x10
+#define DIBUSB_I2C_TIMEOUT 				HZ*5
+
+#define DIBUSB_MAX_PIDS					16
+
+#define DIB3000MB_REG_FIRST_PID			(   153)
+
+struct usb_dibusb;
+
+struct dibusb_pid {
+	u16 reg;
+	u16 pid;
+	int active;
+	struct usb_dibusb *dib;
+};
+
+struct usb_dibusb {
+	/* usb */
+	struct usb_device * udev;
+
+	struct dibusb_device * dibdev;
+
+	int streaming;
+	int feed_count;
+	struct urb *buf_urb;
+	u8 *buffer;
+	dma_addr_t dma_handle;
+	
+	spinlock_t pid_list_lock;
+	struct dibusb_pid pid_list[DIBUSB_MAX_PIDS];
+
+	/* I2C */
+	struct i2c_adapter i2c_adap;
+	struct i2c_client i2c_client;
+
+	/* locking */
+	struct semaphore usb_sem;
+	struct semaphore i2c_sem;
+
+	/* dvb */
+	struct dvb_adapter *adapter;
+	struct dmxdev dmxdev;
+	struct dvb_demux demux;
+	struct dvb_net dvb_net;
+};
+
+
+struct dibusb_device {
+	u16 cold_product_id;
+	u16 warm_product_id;
+	u8 demod_addr;
+	const char *name;
+};
+
+/* static array of valid firmware names, the best one first */
+static const char * valid_firmware_filenames[] = {
+	"dvb-dibusb-5.0.0.11.fw",
+};
+
+#define DIBUSB_SUPPORTED_DEVICES	4
+
+/* USB Driver stuff */
+static struct dibusb_device dibusb_devices[DIBUSB_SUPPORTED_DEVICES] = {
+	{	.cold_product_id = USB_VP7041_PRODUCT_PREFW_ID, 
+		.warm_product_id = USB_VP7041_PRODUCT_ID,
+		.name = "Twinhan VisionDTV USB-Ter/HAMA USB DVB-T device", 
+		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
+	},
+	{	.cold_product_id = USB_VSTREAM_PRODUCT_PREFW_ID,
+		.warm_product_id = USB_VSTREAM_PRODUCT_ID,
+		.name = "KWorld V-Stream XPERT DTV - DVB-T USB",
+		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
+	},
+	{	.cold_product_id = USB_DIBCOM_PRODUCT_PREFW_ID,
+		.warm_product_id = USB_DIBCOM_PRODUCT_ID,
+		.name = "DiBcom USB reference design",
+		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
+	},
+	{
+ 		.cold_product_id = USB_ULTIMA_ELEC_PROD_PREFW_ID,
+		.warm_product_id = USB_ULTIMA_ELEC_PROD_ID,
+		.name = "Ultima Electronic/Artec T1 USB TVBOX",
+		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
+	}, 
+};
+
+#define COMMAND_PIPE	usb_sndbulkpipe(dib->udev, 0x01)
+#define RESULT_PIPE		usb_rcvbulkpipe(dib->udev, 0x81)
+#define DATA_PIPE		usb_rcvbulkpipe(dib->udev, 0x82)
+/* 
+ * last endpoint 0x83 only used for chaining the buffers 
+ * of the endpoints in the cypress 
+ */
+#define CHAIN_PIPE_DO_NOT_USE	usb_rcvbulkpipe(dib->udev, 0x83)
+
+/* types of first byte of each buffer */
+
+#define DIBUSB_REQ_START_READ			0x00
+#define DIBUSB_REQ_START_DEMOD			0x01
+#define DIBUSB_REQ_I2C_READ  			0x02
+#define DIBUSB_REQ_I2C_WRITE 			0x03
+
+/* prefix for reading the current RC key */
+#define DIBUSB_REQ_POLL_REMOTE			0x04
+
+/* 0x05 0xXX */
+#define DIBUSB_REQ_SET_STREAMING_MODE	0x05
+
+/* interrupt the internal read loop, when blocking */
+#define DIBUSB_REQ_INTR_READ		   	0x06
+
+/* IO control 
+ * 0x07 <cmd 1 byte> <param 32 bytes>
+ */ 
+#define DIBUSB_REQ_SET_IOCTL			0x07
+
+/* IOCTL commands */
+
+/* change the power mode in firmware */ 
+#define DIBUSB_IOCTL_CMD_POWER_MODE		0x00
+#define DIBUSB_IOCTL_POWER_SLEEP			0x00
+#define DIBUSB_IOCTL_POWER_WAKEUP			0x01
+
+
+/* 
+ * values from the demodulator which are needed in
+ * the usb driver as well 
+ */
+
+#define DIB3000MB_REG_FIFO              (   145)
+#define DIB3000MB_FIFO_INHIBIT              (     1)
+#define DIB3000MB_FIFO_ACTIVATE             (     0)
+
+#define DIB3000MB_ACTIVATE_FILTERING            (0x2000)
+
+#endif
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/dibusb/Kconfig linux-2.6.8.1-patched/drivers/media/dvb/dibusb/Kconfig
--- linux-2.6.8.1-dvb1/drivers/media/dvb/dibusb/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-patched/drivers/media/dvb/dibusb/Kconfig	2004-09-13 23:28:47.000000000 +0200
@@ -0,0 +1,31 @@
+config DVB_DIBUSB
+	tristate "Twinhan/KWorld/Hama/Artec USB DVB-T devices"
+	depends on DVB_CORE && USB
+	select FW_LOADER
+	help
+	  Support for USB 1.1 DVB-T devices based on a reference design made by 
+	  DiBcom (http://www.dibcom.fr).
+
+	  Devices supported by this driver:
+
+	    Twinhan VisionPlus VisionDTV USB-Ter (VP7041)
+	    KWorld V-Stream XPERT DTV - DVB-T USB
+	    Hama DVB-T USB-Box
+	    DiBcom reference device (non-public)
+	    Ultima Electronic/Artec T1 USB TVBOX
+
+	  The VP7041 seems to be identical to "CTS Portable" (Chinese 
+	  Television System).
+
+	  These devices can be understood as budget ones, they "only" deliver
+	  the MPEG data.
+
+	  Currently all known copies of the DiBcom reference design have the DiBcom 3000MB 
+	  frontend onboard. Please enable and load this one manually in order to use this
+	  device.
+	  
+	  A firmware is needed to use the device. See Documentation/dvb/README.dibusb
+	  details.
+
+	  Say Y if you own such a device and want to use it. You should build it as
+	  a module.
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/dibusb/Makefile linux-2.6.8.1-patched/drivers/media/dvb/dibusb/Makefile
--- linux-2.6.8.1-dvb1/drivers/media/dvb/dibusb/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-patched/drivers/media/dvb/dibusb/Makefile	2004-09-07 20:14:10.000000000 +0200
@@ -0,0 +1,3 @@
+obj-$(CONFIG_DVB_DIBUSB) += dvb-dibusb.o
+
+EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/Makefile linux-2.6.8.1-patched/drivers/media/dvb/Makefile
--- linux-2.6.8.1-dvb1/drivers/media/dvb/Makefile	2004-09-15 15:34:22.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/Makefile	2004-09-15 10:26:44.000000000 +0200
@@ -2,5 +2,4 @@
 # Makefile for the kernel multimedia device drivers.
 #
 
-obj-y        := dvb-core/ frontends/ ttpci/ ttusb-dec/ ttusb-budget/ b2c2/ bt8xx/
-
+obj-y        := dvb-core/ frontends/ ttpci/ ttusb-dec/ ttusb-budget/ b2c2/ bt8xx/ dibusb/
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/Kconfig linux-2.6.8.1-patched/drivers/media/dvb/frontends/Kconfig
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/Kconfig	2004-09-17 12:26:24.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/Kconfig	2004-09-15 10:26:44.000000000 +0200
@@ -63,13 +63,9 @@
 	help
  	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
-	  This driver needs a copy of the Avermedia firmware. The version tested
-	  is part of the Avermedia DVB-T 1.3.26.3 Application. If the software is
-	  installed in Windoze the file will be in the /Program Files/AVerTV DVB-T/
-	  directory and is called sc_main.mc. Alternatively it can "extracted" from
-	  the install cab files.
-   
-   	  Copy this file to '/usr/lib/hotplug/firmware/dvb-fe-sp887x.fw'.
+	  This driver needs external firmware. Please use the command
+	  "<kerneldir>/Documentation/dvb/get_dvb_firmware sp887x" to
+	  download/extract it, and then copy it to /usr/lib/hotplug/firmware.
 
 	  If you don't know what tuner module is soldered on your 
 	  DVB adapter simply enable all supported frontends, the 
@@ -81,9 +77,9 @@
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
-	  This driver needs a copy of the firmware file from the Haupauge
-	  Windoze driver. Copy 'Sc_main.mc' to
-	  '/usr/lib/hotplug/firmware/dvb-fe-tdlb7.fw'.
+	  This driver needs external firmware. Please use the command
+	  "<kerneldir>/Documentation/dvb/get_dvb_firmware alps_tdlb7" to
+	  download/extract it, and then copy it to /usr/lib/hotplug/firmware.
 
 	  If you don't know what tuner module is soldered on your 
 	  DVB adapter simply enable all supported frontends, the 
@@ -99,6 +95,16 @@
 	  DVB adapter simply enable all supported frontends, the 
 	  right one will get autodetected.
 
+config DVB_CX22702
+ 	tristate "Conexant cx22702 demodulator (OFDM)"
+ 	depends on DVB_CORE
+ 	help
+ 	  A DVB-T tuner module. Say Y when you want to support this frontend.
+ 
+ 	  If you don't know what tuner module is soldered on your
+ 	  DVB adapter simply enable all supported frontends, the
+ 	  right one will get autodetected.
+
 config DVB_GRUNDIG_29504_401
 	tristate "Grundig 29504-401 based"
 	depends on DVB_CORE
@@ -115,6 +121,11 @@
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
+	  This driver needs external firmware. Please use the commands
+	  "<kerneldir>/Documentation/dvb/get_dvb_firmware tda10045",
+  	  "<kerneldir>/Documentation/dvb/get_dvb_firmware tda10046" to
+	  download/extract them, and then copy them to /usr/lib/hotplug/firmware.
+
 	  If you don't know what tuner module is soldered on your 
 	  DVB adapter simply enable all supported frontends, the 
 	  right one will get autodetected.
@@ -139,6 +150,21 @@
 	  DVB adapter simply enable all supported frontends, the
 	  right one will get autodetected.
 
+config DVB_DIB3000MB
+	tristate "DiBcom 3000-MB" 
+	depends on DVB_CORE
+	help
+	  A DVB-T tuner module. Designed for mobile usage. Say Y when you want
+	  to support this frontend.
+	 
+	  Used on USB-powered devices. You should also say Y to DVB_DIBUSB 
+	  (DiBcom USB DVB-T Adapter) to support the actual device, 
+	  this is "only" the frontend/tuner.
+	 
+	  If you don't know what tuner module is soldered on your
+	  DVB adapter simply enable all supported frontends, the
+	  right one will get autodetected.
+
 comment "DVB-C (cable) frontends"
 	depends on DVB_CORE
 

--------------050807020305060701080403--
