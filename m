Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVCRVo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVCRVo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 16:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVCRVo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 16:44:27 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:20354 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261417AbVCRVoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 16:44:13 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Jonas Oreland <jonas.oreland@mysql.com>
Subject: Re: yenta_socket "nobody cared - Disabling IRQ #4"
Date: Fri, 18 Mar 2005 22:43:24 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503182243.24174.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

it's the second time now i see this problem with an atheros chipset in
combination with a TI bridge. last time it was the 1225...
attached a patch that could help...

rgds
-daniel

--------------

for TI bridges: turn off interrupts during card power-on. this seems
to be neccessary for some combination of TI bridges with at least CB cards
with atheros chipset...problem is that they produce an interrupt storm
during power-on so the kernel happens to disable the IRQ which is a bad
thing (tm).
adds a generic hook function so that a socket driver can hook into
almost anywhere (by adding more hook points of course). this is the
cleanest way i can think of. and it allows adding more workarounds
for more problems...
for the TI specific interrupt on-off stuff just save the MFUNC register
and set it to 0 to disable all interrupts, restore it afterwards.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>



--- 1.22/drivers/pcmcia/ti113x.h	2005-03-11 21:32:12 +01:00
+++ edited/drivers/pcmcia/ti113x.h	2005-03-18 22:06:12 +01:00
@@ -591,6 +591,35 @@
 	}
 }
 
+
+/* 
+ * TI specifiy parts for generic hook. generic hook really is specifiy to the
+ * chipset so there's no point having it in yenta_socket.c (for now)
+ *
+ * some TI's with some CB's produces interrupt storm on power on. it has been
+ * seen with atheros wlan cards on TI1225 and TI1410. solution is simply to
+ * disable any CB interrupts during this time.
+ */
+static int ti12xx_hook(struct pcmcia_socket *sock, int operation)
+{
+	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
+
+	switch (operation) {
+	case HOOK_POWER_PRE:
+		socket->saved_state[0] = config_readl(socket, TI122X_MFUNC);
+		config_writel(socket, TI122X_MFUNC, 0);
+		break;
+		
+	case HOOK_POWER_POST:
+		config_writel(socket, TI122X_MFUNC, socket->saved_state[0]);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int ti12xx_override(struct yenta_socket *socket)
 {
 	u32 val, val_orig;
@@ -633,6 +662,9 @@
 		ti12xx_irqroute_func0(socket);
 	else
 		ti12xx_irqroute_func1(socket);
+
+	/* install generic hook */
+	socket->socket.ops->generic_hook = ti12xx_hook;
 
 	return ti_override(socket);
 }
--- 1.125/drivers/pcmcia/cs.c	2005-03-11 21:32:13 +01:00
+++ edited/drivers/pcmcia/cs.c	2005-03-12 21:22:38 +01:00
@@ -508,6 +508,10 @@
 		cs_err(skt, "unsupported voltage key.\n");
 		return CS_BAD_TYPE;
 	}
+
+	if (skt->ops->generic_hook)
+		skt->ops->generic_hook(skt, HOOK_POWER_PRE);
+
 	skt->socket.flags = 0;
 	skt->ops->set_socket(skt, &skt->socket);
 
@@ -522,7 +526,12 @@
 		return CS_BAD_TYPE;
 	}
 
-	return socket_reset(skt);
+	status = socket_reset(skt);
+
+	if (skt->ops->generic_hook)
+		skt->ops->generic_hook(skt, HOOK_POWER_POST);
+
+	return status;
 }
 
 /*
--- 1.48/include/pcmcia/ss.h	2005-03-11 21:32:13 +01:00
+++ edited/include/pcmcia/ss.h	2005-03-12 21:22:39 +01:00
@@ -77,6 +77,11 @@
 /* Use this just for bridge windows */
 #define MAP_IOSPACE	0x20
 
+/* generic hook operations */
+#define HOOK_POWER_PRE	0x01
+#define HOOK_POWER_POST	0x02
+
+
 typedef struct pccard_io_map {
     u_char	map;
     u_char	flags;
@@ -113,6 +118,7 @@
 	int (*set_socket)(struct pcmcia_socket *sock, socket_state_t *state);
 	nt (*set_io_map)(struct pcmcia_socket *sock, struct pccard_io_map *io);
 	int (*set_mem_map)(struct pcmcia_socket *sock, struct pccard_mem_map *mem);
+	int (*generic_hook)(struct pcmcia_socket *sock, int operation);
 };
 
 struct pccard_resource_ops {

