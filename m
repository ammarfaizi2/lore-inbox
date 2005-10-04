Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbVJDW2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbVJDW2u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 18:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVJDW2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 18:28:36 -0400
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:65452 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S965019AbVJDW2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 18:28:34 -0400
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC 2/2] simple SPI controller implementation on PXA2xx SSP port
Date: Tue, 4 Oct 2005 15:28:29 -0700
User-Agent: KMail/1.7.1
Cc: david-b@pacbell.net, spi-devel-general@lists.sourceforge.net,
       basicmark@yahoo.com, dpervushin@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041528.29953.stephen@streetfiresound.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preliminary "SPI protocol" driver for the Cirrus Logic CS8415A 
SPD/IF decoder chip.  This driver demostrates some but not all of the 
features of David Brownell's "simple SPI framework" and is intended to
demonstrate and test the PXA SSP driver posted previously.

---- snip ----
 drivers/spi/cs8415a.c       |  561 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/cirrus.h  |  200 +++++++++++++++
 include/linux/spi/cs8415a.h |  156 ++++++++++++
 3 files changed, 917 insertions(+)

--- linux-2.6.12-spi/include/linux/spi/cirrus.h 1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-spi-pxa/include/linux/spi/cirrus.h 2005-10-04 13:05:06.897768000 -0700
@@ -0,0 +1,200 @@
+/*
+ * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
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
+ */
+
+#ifndef CIRRUS_H_
+#define CIRRUS_H_
+
+#include <linux/list.h>
+#include <linux/spi.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+
+#define READ_CMD 0x21
+#define WRITE_CMD 0x20
+#define TO_MAP(x) ((x & 0x7f) | 0x80)
+#define MAX_POOL_NAME_SIZE 64
+
+struct cirrus_message_pool {
+};
+
+struct cirrus_notification {
+};
+
+struct cirrus_pooled_message {
+};
+
+inline void _cirrus_setup_async(struct spi_message *message, 
+     void (*chip_callback)(void *context), 
+     void (*user_callback)(int length))
+{
+};
+
+inline void *__cirrus_pool_alloc(struct cirrus_message_pool *pool)
+{
+ return NULL; 
+}
+
+inline void __cirrus_pool_free(struct cirrus_message_pool *pool, void* ptr)
+{
+}
+
+inline struct spi_message *_cirrus_alloc_read(struct cirrus_message_pool *pool, 
+       u8 address, 
+       const char* buffer, 
+       size_t length)
+{
+ return NULL;
+}
+
+inline struct spi_message *_cirrus_alloc_write(struct cirrus_message_pool *pool,
+       u8 address, 
+       unsigned char* buffer, 
+       unsigned int length)
+{
+ return NULL;
+}
+
+inline void _cirrus_free(struct cirrus_message_pool *pool, 
+    struct spi_message* message)
+{
+}
+
+inline struct cirrus_message_pool *_cirrus_create_pool(const char* name, 
+       size_t pool_size, 
+       size_t max_message_size)
+{
+ return NULL;
+}
+
+inline void _cirrus_release_pool(struct cirrus_message_pool *pool)
+{
+}
+
+inline ssize_t _cirrus_read_sync(struct device *dev, u8 address, 
+     const char *buffer, size_t length)
+{
+ u8 map_buffer[] = { WRITE_CMD, TO_MAP(address) };
+ u8 read_cmd_buffer[] = { READ_CMD };
+ struct spi_transfer transfers[3];
+ struct spi_message message;
+ 
+ transfers[0].tx_buf = map_buffer;
+ transfers[0].rx_buf = NULL;
+ transfers[0].len = ARRAY_SIZE(map_buffer);
+ transfers[0].cs_change = 0;
+ transfers[0].delay_usecs = 0;
+
+ transfers[1].tx_buf = read_cmd_buffer;
+ transfers[1].rx_buf = NULL;
+ transfers[1].len = ARRAY_SIZE(read_cmd_buffer);
+ transfers[1].cs_change = 1;
+ transfers[1].delay_usecs = 0;
+ 
+ transfers[2].tx_buf = NULL;
+ transfers[2].rx_buf = (void *)buffer;
+ transfers[2].len = length;
+ transfers[2].cs_change = 0;
+ transfers[2].delay_usecs = 0;
+
+ message.transfers = transfers;
+ message.n_transfer = ARRAY_SIZE(transfers);
+
+ spi_sync(to_spi_device(dev), &message);
+ 
+ return message.status < 0 ? message.status : message.actual_length;
+}
+
+inline int _cirrus_write_sync(struct device *dev, u8 address, 
+    const unsigned char *buffer, 
+    unsigned int length)
+{
+ u8 map_buffer[] = { WRITE_CMD, TO_MAP(address) };
+ struct spi_transfer transfers[2];
+ struct spi_message message;
+ 
+ transfers[0].tx_buf = map_buffer,
+ transfers[0].rx_buf = NULL;
+ transfers[0].len = ARRAY_SIZE(map_buffer),
+ transfers[0].cs_change = 1;
+ transfers[0].delay_usecs = 0;
+ 
+ transfers[1].tx_buf = (unsigned char *)buffer,
+ transfers[1].rx_buf = NULL;
+ transfers[1].len = length,
+ transfers[1].cs_change = 0;
+ transfers[1].delay_usecs = 0;
+
+ message.transfers = transfers;
+ message.n_transfer = ARRAY_SIZE(transfers);
+
+ spi_sync(to_spi_device(dev), &message);
+ 
+ return message.status < 0 ? message.status : message.actual_length;
+}
+
+inline int _cirrus_read_register_sync(struct device* dev, u8 address)
+{
+ u8 map_buffer[] = { WRITE_CMD, TO_MAP(address) };
+ u8 read_buffer[] = { READ_CMD, 0 };
+ struct spi_transfer transfers[2];
+ struct spi_message message;
+ int status;
+ 
+ transfers[0].tx_buf = map_buffer,
+ transfers[0].rx_buf = NULL;
+ transfers[0].len = ARRAY_SIZE(map_buffer),
+ transfers[0].cs_change = 1;
+ transfers[0].delay_usecs = 0;
+
+ transfers[1].tx_buf = read_buffer,
+ transfers[1].rx_buf = read_buffer,
+ transfers[1].len = ARRAY_SIZE(read_buffer),
+ transfers[1].cs_change = 0;
+ transfers[1].delay_usecs = 0;
+
+ message.transfers = transfers;
+ message.n_transfer = ARRAY_SIZE(transfers);
+ 
+ status = spi_sync(to_spi_device(dev), &message);
+ if (status < 0)
+  return status;
+ 
+ return message.status < 0 ? message.status : read_buffer[1];
+}
+
+inline int _cirrus_write_register_sync(struct device* dev, u8 address, u8 data)
+{
+ u8 write_buffer[] = { WRITE_CMD, TO_MAP(address), data };
+ struct spi_transfer transfers[1];
+ struct spi_message message;
+
+ transfers[0].tx_buf = write_buffer,
+ transfers[0].rx_buf = NULL;
+ transfers[0].len = ARRAY_SIZE(write_buffer),
+ transfers[0].cs_change = 0;
+ transfers[0].delay_usecs = 0;
+
+ message.transfers = transfers;
+ message.n_transfer = ARRAY_SIZE(transfers);
+ 
+ spi_sync(to_spi_device(dev), &message);
+ 
+ return message.status;
+}
+
+#endif /*CIRRUS_H_*/
--- linux-2.6.12-spi/include/linux/spi/cs8415a.h 1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-spi-pxa/include/linux/spi/cs8415a.h 2005-10-04 14:19:40.422850000 -0700
@@ -0,0 +1,156 @@
+/* cs8415a.h - Definitions for the CS8415A chip
+ *
+ * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
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
+ */
+
+#ifndef CS8415A_H_
+#define CS8415A_H_
+
+#include <linux/list.h>
+
+#define CS8415A_CTL1    0x01
+#define CS8415A_CTL2    0x02
+#define CS8415A_CSC     0x04
+#define CS8415A_SOF     0x06
+#define CS8415A_I1S     0x07
+#define CS8415A_I2S     0x08
+#define CS8415A_I1MK    0x09
+#define CS8415A_I1MM    0x0a
+#define CS8415A_I1ML    0x0b
+#define CS8415A_I2MK    0x0c
+#define CS8415A_I2MM    0x0d
+#define CS8415A_I2ML    0x0e
+#define CS8415A_RCS     0x0f
+#define CS8415A_RER     0x10
+#define CS8415A_REM     0x11
+#define CS8415A_CSDBC   0x12
+#define CS8415A_UDBC    0x13
+#define CS8415A_QCSB    0x14
+#define CS8415A_ORR     0x1e
+#define CS8415A_CUDB    0x20
+#define CS8415A_VER     0x7f
+
+#define CS8415A_SWCLK    (1<<7)
+#define CS8415A_MUTESAO  (1<<5)
+#define CS8415A_INT(x)   ((x&3)<<1)
+#define CS8415A_HOLD(x)  ((x&3)<<5)
+#define CS8415A_RMCKF    (1<<4)
+#define CS8415A_MMR      (1<<3)
+#define CS8415A_MUX(x)   (x&7)
+#define CS8415A_RUN      (1<<6)
+#define CS8415A_SOMS     (1<<7)
+#define CS8415A_SOSF     (1<<6)
+#define CS8415A_SORES(x) ((x&3)<<4)
+#define CS8415A_SOJUST   (1<<3)
+#define CS8415A_SODEL    (1<<2)
+#define CS8415A_SOSPOL   (1<<1)
+#define CS8415A_SOLRPOL  (1)
+#define CS8415A_OSLIP    (1<<6)
+#define CS8415A_DETC     (1<<2)
+#define CS8415A_RERR     (1)
+#define CS8415A_DETU     (1<<3)
+#define CS8415A_QCH      (1<<1)
+#define CS8415A_AUX(x)   ((x&f)<<4)
+#define CS8415A_PRO      (1<<3)
+#define CS8415A_AUDIO    (1<<2)
+#define CS8415A_COPY     (1<<1)
+#define CS8415A_ORIG     (1)
+#define CS8415A_QCRC     (1<<6)
+#define CS8415A_CCRC     (1<<5)
+#define CS8415A_UNLOCK   (1<<4)
+#define CS8415A_V        (1<<3)
+#define CS8415A_CONF     (1<<2)
+#define CS8415A_BIP      (1<<1)
+#define CS8415A_PAR      (1)
+#define CS8415A_BSEL     (1<<5)
+#define CS8415A_CBMR     (1<<4)
+#define CS8415A_DETCI    (1<<3)
+#define CS8415A_CAM      (1<<1)
+#define CS8415A_CHS      (1)
+#define CS8415A_DETUI    (1<<1)
+
+struct cs8415a_platform_data {
+ int enabled;
+ int muted;
+ int channel;
+ void (*mask_interrupt)(void);
+ void (*unmask_interrupt)(void);
+ int (*service_requested)(void);
+};
+
+struct cs8415a_event {
+ u16 events;
+ void (*event_handler)(u8 event, unsigned char *buffer, unsigned int length);
+ struct list_head event_list;
+};
+
+extern int cs8415a_get_version(struct device *dev);
+
+extern int cs8415a_get_enabled(struct device *dev);
+
+extern int cs8415a_set_enabled(struct device *dev, int value);
+
+extern int cs8415a_get_muted(struct device *dev);
+
+extern int cs8415a_set_muted(struct device *dev, int value);
+
+extern int cs8415a_get_channel(struct device *dev);
+
+extern int cs8415a_set_channel(struct device *dev, int value);
+
+extern int cs8415a_is_pll_locked(struct device *dev);
+
+extern int cs8415a_get_channel_status(struct device *dev);
+
+extern int cs8415a_read_qch(struct device *dev, unsigned char *buffer);
+
+extern int cs8415a_read_ubit(struct device *dev, unsigned char *buffer);
+
+extern int cs8415a_read_cbit(struct device *dev, unsigned char* buffer);
+
+extern int cs8415a_add_event_handler(struct device *dev, 
+     struct cs8415a_event *event);
+extern int cs8415a_remove_event_handler(struct device *dev, 
+      struct cs8415a_event *event);
+
+extern int _cs8415a_read_register(struct device *dev, u8 address);
+
+extern int _cs8415a_write_register(struct device *dev, u8 address, u8 value);
+
+extern int _cs8415a_read(struct device *dev, u8 address, 
+    unsigned char *buffer, unsigned int length);
+
+extern int _cs8415a_write(struct device *dev, u8 address, 
+    unsigned char *buffer, unsigned int length);
+
+extern int _cs8415a_read_register_async(struct device *dev, u8 address, 
+      void (*done)(int value));
+
+extern int _cs8415a_write_register_async(struct device *dev, u8 address, 
+      u8 value, 
+      void (*done)(int status));
+extern int _cs8415a_read_async(struct device *dev, u8 address, 
+     unsigned char *buffer, 
+     unsigned int length, 
+     void (*done)(int length));
+
+extern int _cs8415a_write_async(struct device *dev, u8 address, 
+     unsigned char *buffer, 
+     unsigned int length, 
+     void (*done)(int length));
+
+#endif /*CS8415A_H_*/
--- linux-2.6.12-spi/drivers/spi/cs8415a.c 1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-spi-pxa/drivers/spi/cs8415a.c 2005-10-04 14:00:12.279449000 -0700
@@ -0,0 +1,561 @@
+/*
+ * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
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
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/spi.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/spi.h>
+#include <linux/spi/cs8415a.h>
+#include <linux/spi/cirrus.h>
+
+#include <asm/hardirq.h>
+#include <asm/semaphore.h>
+#include <asm/arch/streetracer.h>
+
+MODULE_AUTHOR("Stephen Street");
+MODULE_DESCRIPTION("CS8415A SPI Protocol Driver");
+MODULE_LICENSE("GPL");
+
+#define VALID_CS8415A_VERSION (0x41)
+
+struct cs8415a_driver_data {
+ spinlock_t lock;
+ struct semaphore user_lock;
+ struct cirrus_message_pool *read_async_pool;
+ struct cirrus_message_pool *write_async_pool;
+ struct list_head event_handlers;
+ int chip_version;
+ int enabled;
+ int muted;
+ int channel;
+};
+
+int _cs8415a_read_register(struct device *dev, u8 address)
+{
+ return _cirrus_read_register_sync(dev, address);
+}
+EXPORT_SYMBOL(_cs8415a_read_register);
+
+int _cs8415a_write_register(struct device *dev, u8 address, u8 value)
+{
+ return _cirrus_write_register_sync(dev, address, value);
+}
+EXPORT_SYMBOL(_cs8415a_write_register);
+
+int _cs8415a_read(struct device *dev, u8 address, 
+   unsigned char *buffer, unsigned int length)
+{
+ return _cirrus_read_sync(dev, address, buffer, length);
+}
+EXPORT_SYMBOL(_cs8415a_read);
+
+int _cs8415a_write(struct device *dev, u8 address, 
+   unsigned char *buffer, unsigned int length)
+{
+ return _cirrus_write_sync(dev, address, buffer, length);
+}
+EXPORT_SYMBOL(_cs8415a_write);
+
+int _cs8415a_read_register_async(struct device *dev, u8 address, 
+     void (*done)(int value))
+{
+ return -1;
+}
+EXPORT_SYMBOL(_cs8415a_read_register_async);
+
+int _cs8415a_write_register_async(struct device *dev, u8 address, 
+     u8 value, void (*done)(int status))
+{
+ return -1;
+}
+EXPORT_SYMBOL(_cs8415a_write_register_async);
+
+int _cs8415a_read_async(struct device *dev, u8 address, 
+    unsigned char *buffer, unsigned int length, 
+    void (*done)(int length))
+{
+ return -1;
+}
+EXPORT_SYMBOL(_cs8415a_read_async);
+
+int _cs8415a_write_async(struct device *dev, u8 address, 
+    unsigned char *buffer, unsigned int length, 
+    void (*done)(int length))
+{
+ return -1;
+}
+EXPORT_SYMBOL(_cs8415a_write_async);
+
+static int cs8415a_reset(struct device *dev)
+{
+ unsigned char clear[6];
+ struct cs8415a_driver_data *driver_data = dev_get_drvdata(dev);
+ int status;
+ 
+ memset(clear, 0, sizeof(clear));
+ 
+ status = _cs8415a_write_register(dev, CS8415A_CSC, 0);
+ if (status < 0)
+  return status;
+  
+ status = _cs8415a_write_register(dev, CS8415A_CTL1, 
+      CS8415A_INT(0)
+      |CS8415A_MUTESAO);
+ if (status < 0)
+  return status;
+
+ status = _cs8415a_write_register(dev, CS8415A_CTL2, CS8415A_HOLD(1));
+ if (status < 0)
+  return status;
+
+ status = _cs8415a_write_register(dev, CS8415A_SOF, 
+      CS8415A_SOMS 
+      | CS8415A_SODEL 
+      | CS8415A_SOLRPOL);
+ if (status < 0)
+  return status;
+
+ status = _cs8415a_write(dev, CS8415A_I1MK, clear, sizeof(clear));
+ if (status < 0)
+  return status;
+
+ status = _cs8415a_read_register(dev, CS8415A_RER);
+ if (status < 0)
+  return status;
+
+ status = _cs8415a_read(dev, CS8415A_I1S, clear, 2);
+ if (status < 0)
+  return status;
+ 
+ driver_data->enabled = 0;
+ driver_data->channel = 0;
+ driver_data->muted = 1;
+ 
+ return 0;
+}
+
+static irqreturn_t cs8415a_int(int irq, void *dev_id, struct pt_regs *regs)
+{
+ struct cs8415a_driver_data *driver_data;
+ 
+ driver_data = dev_get_drvdata((struct device *)dev_id);
+
+ spin_lock(&driver_data->lock);
+ 
+ spin_unlock(&driver_data->lock);
+ 
+ return IRQ_HANDLED;
+}
+
+int cs8415a_get_version(struct device *dev)
+{
+ struct cs8415a_driver_data *driver_data = dev_get_drvdata(dev);
+ 
+ return driver_data->chip_version;
+}
+EXPORT_SYMBOL(cs8415a_get_version);
+
+static ssize_t version_show(struct device *dev, char *buf)
+{
+ return sprintf(buf, "0x%02x\n", cs8415a_get_version(dev));
+}
+
+DEVICE_ATTR(version, 0444, version_show, NULL);
+
+extern int cs8415a_get_enabled(struct device *dev)
+{
+ struct cs8415a_driver_data *driver_data = dev_get_drvdata(dev);
+ int value;
+
+ if (down_interruptible(&driver_data->user_lock))
+  return -ERESTARTSYS;
+  
+ value = driver_data->enabled;
+ 
+ up(&driver_data->user_lock);
+ 
+ return value;
+}
+EXPORT_SYMBOL(cs8415a_get_enabled);
+
+extern int cs8415a_set_enabled(struct device *dev, int value)
+{
+ struct cs8415a_driver_data *driver_data = dev_get_drvdata(dev);
+ int status;
+ 
+ if (down_interruptible(&driver_data->user_lock))
+  return -ERESTARTSYS;
+  
+ status = _cs8415a_write_register(dev, CS8415A_CSC, 
+      (u8)(value ? CS8415A_RUN : 0));
+ if (status == 0)
+  driver_data->enabled = value ? 1 : 0;
+  
+ up(&driver_data->user_lock);
+
+ return status;
+}
+EXPORT_SYMBOL(cs8415a_set_enabled);
+
+static ssize_t enabled_show(struct device *dev, char *buf)
+{
+ return snprintf(buf, PAGE_SIZE, "%d\n", cs8415a_get_enabled(dev));
+}
+
+static ssize_t enabled_store(struct device *dev, const char *buf, size_t count)
+{
+ int status;
+ unsigned int value;
+ 
+ status = sscanf(buf, "%u", &value);
+ 
+ if (status != 1 || (value != 0 && value != 1)) {
+  return -EINVAL;
+ }
+ 
+ cs8415a_set_enabled(dev, value);
+ 
+ return 1;
+}
+
+DEVICE_ATTR(enabled, 0644, enabled_show, enabled_store);
+
+int cs8415a_get_muted(struct device *dev)
+{
+ struct cs8415a_driver_data *driver_data = dev_get_drvdata(dev);
+ int value;
+
+ if (down_interruptible(&driver_data->user_lock))
+  return -ERESTARTSYS;
+ 
+ value = driver_data->muted;
+ 
+ up(&driver_data->user_lock);
+ 
+ return value;
+}
+EXPORT_SYMBOL(cs8415a_get_muted);
+
+int cs8415a_set_muted(struct device *dev, int value)
+{
+ struct cs8415a_driver_data *driver_data = dev_get_drvdata(dev);
+ int status;
+ 
+ if (down_interruptible(&driver_data->user_lock))
+  return -ERESTARTSYS;
+  
+ status = _cs8415a_write_register(dev, CS8415A_CTL1, 
+      (u8)(value?CS8415A_MUTESAO:0));
+ if (status == 0)
+  driver_data->muted = value ? 1 : 0;
+ 
+ up(&driver_data->user_lock);
+ 
+ return status;
+}
+EXPORT_SYMBOL(cs8415a_set_muted);
+
+static ssize_t muted_show(struct device *dev, char *buf)
+{
+ return snprintf(buf, PAGE_SIZE, "%d\n", cs8415a_get_muted(dev));
+}
+
+static ssize_t muted_store(struct device *dev, const char *buf, size_t count)
+{
+ int status;
+ unsigned int value;
+ 
+ status = sscanf(buf, "%u", &value);
+ 
+ if (status != 1 || (value != 0 && value != 1)) {
+  return -EINVAL;
+ }
+ 
+ cs8415a_set_muted(dev, value);
+ 
+ return 1;
+}
+DEVICE_ATTR(muted, 0644, muted_show, muted_store);
+
+int cs8415a_get_channel(struct device *dev)
+{
+ struct cs8415a_driver_data *driver_data = dev_get_drvdata(dev);
+ int value;
+ 
+ if (down_interruptible(&driver_data->user_lock))
+  return -ERESTARTSYS;
+ 
+ value = driver_data->channel;
+ 
+ up(&driver_data->user_lock);
+ 
+ return value;
+}
+EXPORT_SYMBOL(cs8415a_get_channel);
+
+int cs8415a_set_channel(struct device *dev, int value)
+{
+ struct cs8415a_driver_data *driver_data = dev_get_drvdata(dev);
+ int status;
+ 
+ if (down_interruptible(&driver_data->user_lock))
+  return -ERESTARTSYS;
+ 
+ status = _cs8415a_write_register(dev, CS8415A_CTL2, 
+      (u8)(CS8415A_HOLD(1) 
+       | CS8415A_MUX(value)));
+ if (status == 0)
+  driver_data->channel = value;
+  
+ up(&driver_data->user_lock);
+
+ return status;
+}
+EXPORT_SYMBOL(cs8415a_set_channel);
+
+static ssize_t channel_show(struct device *dev, char *buf)
+{
+ return snprintf(buf, PAGE_SIZE, "%d\n", cs8415a_get_channel(dev));
+}
+
+static ssize_t channel_store(struct device *dev, const char *buf, size_t count)
+{
+ int status;
+ unsigned int value;
+ 
+ status = sscanf(buf, "%u", &value);
+ 
+ if (status != 1 || value < 0 || value > 7) {
+  return -EINVAL;
+ }
+ 
+ cs8415a_set_channel(dev, value);
+ 
+ return 1;
+}
+DEVICE_ATTR(channel, 0644, channel_show, channel_store);
+
+int cs8415a_get_channel_status(struct device *dev)
+{
+ struct cs8415a_driver_data *driver_data = dev_get_drvdata(dev);
+ int value;
+ 
+ if (down_interruptible(&driver_data->user_lock))
+  return -ERESTARTSYS;
+ 
+ value = _cs8415a_read_register(dev, CS8415A_RCS);
+ 
+ up(&driver_data->user_lock);
+ 
+ return value;
+}
+static ssize_t channel_status_show(struct device *dev, char *buf)
+{
+ return snprintf(buf, PAGE_SIZE, "0x%01x\n", 
+    cs8415a_get_channel_status(dev));
+}
+DEVICE_ATTR(channel_status, 0444, channel_status_show, NULL);
+
+static int cs8415a_spi_probe(struct device *dev)
+{
+ struct spi_device *spi_dev;
+ struct cs8415a_driver_data *driver_data;
+ int status;
+
+ /* Allocate driver data */
+ driver_data = kcalloc(1, sizeof(struct cs8415a_driver_data), 
+    GFP_KERNEL);
+ if (!driver_data) {
+  dev_err(dev, "problem allocating driver memory\n");
+  status = -ENOMEM;
+  goto out_error;
+ }
+ 
+ spin_lock_init(&driver_data->lock);
+ init_MUTEX(&driver_data->user_lock);
+ INIT_LIST_HEAD(&driver_data->event_handlers);
+ 
+ dev_set_drvdata(dev, driver_data);
+ 
+ /* Initialize the message pool */
+/*
+ driver_data->read_async_pool = _cirrus_create_pool(0);
+ driver_data->write_async_pool = _cirrus_create_pool(0);
+ if (!driver_data->read_async_pool || !driver_data->write_async_pool) {
+  dev_err(dev, "problem creating pools\n");
+  status = -ENOMEM;
+  goto out_error_memalloc;
+ }
+*/
+ 
+ /* Read and validate version number */
+ driver_data->chip_version = _cs8415a_read_register(dev, CS8415A_VER);
+ if (driver_data->chip_version < 0) {
+  dev_err(dev, "problem reading chip version\n");
+  status = -ENODEV;
+  goto out_error_memalloc;
+ }
+
+ if (driver_data->chip_version != VALID_CS8415A_VERSION) {
+  dev_err(dev, "problem reading chip version "
+    "found version 0x%02x\n", 
+    driver_data->chip_version);
+  status = -ENODEV;
+  goto out_error_memalloc;
+ }
+ 
+ spi_dev = to_spi_device(dev);
+
+ /* Attach to IRQ  */ 
+ if (spi_dev->irq == 0) {
+  dev_err(dev, "problem getting irq\n");
+  status = -ENODEV;
+  goto out_error_memalloc;
+ }
+
+ status = request_irq(spi_dev->irq, cs8415a_int, 
+    SA_SHIRQ, dev->bus_id, dev);
+ if (status < 0) {
+  dev_err(dev, "problem requesting IRQ %u\n", spi_dev->irq);
+  status = -ENODEV;
+  goto out_error_memalloc;
+ }
+ 
+ status = cs8415a_reset(dev);
+ if (status != 0) {
+  dev_err(dev, "problem resetting\n");
+  status = -ENODEV;
+  goto out_error_irqalloc;
+ }
+ 
+ status = device_create_file(dev, &dev_attr_version);
+ if (status < 0) {
+  dev_err(dev, "problem creating attribute %s\n", 
+    dev_attr_version.attr.name);
+  goto out_error_attralloc;
+ }
+ 
+ status = device_create_file(dev, &dev_attr_enabled);
+ if (status < 0) {
+  dev_err(dev, "problem creating attribute %s\n", 
+    dev_attr_enabled.attr.name);
+  goto out_error_attralloc;
+ }
+ 
+ status = device_create_file(dev, &dev_attr_muted);
+ if (status < 0) {
+  dev_err(dev, "problem creating attribute %s\n", 
+    dev_attr_muted.attr.name);
+  goto out_error_attralloc;
+ }
+ 
+ status = device_create_file(dev, &dev_attr_channel);
+ if (status < 0) {
+  dev_err(dev, "problem creating attribute %s\n", 
+    dev_attr_channel.attr.name);
+  goto out_error_attralloc;
+ }
+
+ status = device_create_file(dev, &dev_attr_channel_status);
+ if (status < 0) {
+  dev_err(dev, "problem creating attribute %s\n", 
+    dev_attr_channel_status.attr.name);
+  goto out_error_attralloc;
+ }
+
+ dev_dbg(dev, "found chip version 0x%02x\n", driver_data->chip_version);
+
+ return 0;
+out_error_attralloc:
+ device_remove_file(dev, &dev_attr_version);
+ device_remove_file(dev, &dev_attr_enabled);
+ device_remove_file(dev, &dev_attr_muted);
+ device_remove_file(dev, &dev_attr_channel);
+ device_remove_file(dev, &dev_attr_channel_status);
+ 
+out_error_irqalloc:
+ free_irq(spi_dev->irq, dev);
+
+out_error_memalloc:
+ if (driver_data->read_async_pool) 
+  _cirrus_release_pool(driver_data->read_async_pool);
+  
+ if (driver_data->write_async_pool)
+  _cirrus_release_pool(driver_data->read_async_pool);
+ 
+ dev_set_drvdata(dev, NULL);
+
+ kfree(driver_data);
+ 
+out_error:
+ 
+ return status;
+}
+
+static int cs8415a_spi_remove(struct device *dev)
+{
+ struct spi_device *spi_dev = to_spi_device(dev);
+ struct cs8415a_driver_data *driver_data = dev_get_drvdata(dev);
+ unsigned long flags;
+
+ cs8415a_reset(dev);
+
+ spin_lock_irqsave(&driver_data->lock, flags);
+
+ if (spi_dev->irq != 0)
+  free_irq(spi_dev->irq, dev);
+ 
+ spin_unlock_irqrestore(&driver_data->lock, flags);
+
+ device_remove_file(dev, &dev_attr_version);
+ device_remove_file(dev, &dev_attr_enabled);
+ device_remove_file(dev, &dev_attr_muted);
+ device_remove_file(dev, &dev_attr_channel);
+ device_remove_file(dev, &dev_attr_channel_status);
+
+ _cirrus_release_pool(driver_data->read_async_pool); 
+ _cirrus_release_pool(driver_data->write_async_pool); 
+ 
+ kfree(driver_data);
+ 
+ return 0;
+}
+
+struct device_driver cs8415a_spi = {
+ .name = "cs8415a",
+ .bus = &spi_bus_type,
+ .owner = THIS_MODULE,
+ .probe = cs8415a_spi_probe,
+ .remove = cs8415a_spi_remove,
+};
+
+static int __init cs8415a_spi_init(void)
+{
+ return driver_register(&cs8415a_spi);
+}
+module_init(cs8415a_spi_init);
+
+static void __exit cs8415a_spi_exit(void)
+{
+ driver_unregister(&cs8415a_spi);
+}
+module_exit(cs8415a_spi_exit);

