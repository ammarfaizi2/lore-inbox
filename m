Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVCHDId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVCHDId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVCGU0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:26:44 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:65456 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261751AbVCGUM3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:29 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [5/many] acrypto: crypto_conn.c
In-Reply-To: <11102278533364@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:33 +0300
Message-Id: <1110227853764@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/crypto_conn.c	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/crypto_conn.c	2005-03-07 21:11:01.000000000 +0300
@@ -0,0 +1,160 @@
+/*
+ * 	crypto_conn.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/vmalloc.h>
+#include <linux/connector.h>
+
+#include "acrypto.h"
+#include "crypto_lb.h"
+#include "crypto_conn.h"
+#include "crypto_user_ioctl.h"
+#include "crypto_user_direct.h"
+
+struct cb_id crypto_conn_id = { 0xdead, 0x0000 };
+static char crypto_conn_name[] = "crconn";
+
+static void crypto_conn_callback(void *data)
+{
+	struct cn_msg *msg, *reply;
+	struct crypto_conn_data *d, *cmd;
+	struct crypto_device *dev;
+	u32 sessions;
+
+	msg = (struct cn_msg *)data;
+	d = (struct crypto_conn_data *)msg->data;
+
+	if (msg->len < sizeof(*d)) {
+		dprintk(KERN_ERR "Wrong message to crypto connector: msg->len=%u < %u.\n",
+			msg->len, sizeof(*d));
+		return;
+	}
+
+	if (msg->len != sizeof(*d) + d->len) {
+		dprintk(KERN_ERR "Wrong message to crypto connector: msg->len=%u != %u.\n",
+			msg->len, sizeof(*d) + d->len);
+		return;
+	}
+
+	dev = crypto_device_get_name(d->name);
+	if (!dev) {
+		dprintk(KERN_INFO "Crypto device %s was not found.\n", d->name);
+		return;
+	}
+
+	switch (d->cmd) {
+	case CRYPTO_READ_SESSIONS:
+		reply = kmalloc(sizeof(*msg) + sizeof(*cmd) + sizeof(sessions), GFP_ATOMIC);
+		if (reply) {
+			memcpy(reply, msg, sizeof(*reply));
+			reply->len = sizeof(*cmd) + sizeof(sessions);
+
+			/*
+			 * See protocol description in connector.c
+			 */
+			reply->ack++;
+
+			cmd = (struct crypto_conn_data *)(reply + 1);
+			memcpy(cmd, d, sizeof(*cmd));
+			cmd->len = sizeof(sessions);
+
+			sessions = atomic_read(&dev->refcnt);
+
+			memcpy(cmd + 1, &sessions, sizeof(sessions));
+
+			cn_netlink_send(reply, 0);
+
+			kfree(reply);
+		} else
+			dprintk(KERN_ERR "Failed to allocate %d bytes in reply to comamnd 0x%x.\n",
+				sizeof(*msg) + sizeof(*cmd), d->cmd);
+		break;
+	case CRYPTO_GET_STAT:
+		reply = kmalloc(sizeof(*msg) + sizeof(*cmd) + sizeof(struct crypto_device_stat), GFP_ATOMIC);
+		if (reply) {
+			struct crypto_device_stat *ptr;
+
+			memcpy(reply, msg, sizeof(*reply));
+			reply->len = sizeof(*cmd) + sizeof(*ptr);
+
+			/*
+			 * See protocol description in connector.c
+			 */
+			reply->ack++;
+
+			cmd = (struct crypto_conn_data *)(reply + 1);
+			memcpy(cmd, d, sizeof(*cmd));
+			cmd->len = sizeof(*ptr);
+
+			ptr = (struct crypto_device_stat *)(cmd + 1);
+			memcpy(ptr, &dev->stat, sizeof(*ptr));
+
+			cn_netlink_send(reply, 0);
+
+			kfree(reply);
+		} else
+			dprintk(KERN_ERR "Failed to allocate %d bytes in reply to comamnd 0x%x.\n",
+				sizeof(*msg) + sizeof(*cmd), d->cmd);
+		break;
+	case CRYPTO_REQUEST:
+#if 1
+		{
+			struct crypto_user_direct *usr;
+
+			usr = (struct crypto_user_direct *)(d->data);
+			
+			crypto_user_direct_add_request(msg->seq, msg->ack, usr);
+		}
+#endif
+		break;
+	default:
+		dprintk(KERN_ERR "Wrong operation 0x%04x for crypto connector.\n",
+			d->cmd);
+		return;
+	}
+
+	crypto_device_put(dev);
+}
+
+int crypto_conn_init(void)
+{
+	int err;
+
+	err = cn_add_callback(&crypto_conn_id, crypto_conn_name, crypto_conn_callback);
+	if (err)
+		return err;
+
+	dprintk(KERN_INFO "Crypto connector callback is registered.\n");
+
+	return 0;
+}
+
+void crypto_conn_fini(void)
+{
+	cn_del_callback(&crypto_conn_id);
+	dprintk(KERN_INFO "Crypto connector callback is unregistered.\n");
+}

