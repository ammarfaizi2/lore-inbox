Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVCUXma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVCUXma (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVCUXkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:40:23 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:186 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262169AbVCUXho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:37:44 -0500
From: Ron Gage <ron@rongage.org>
To: daniel.ritz@gmx.ch
Subject: Re: [PATCH]Fw: Major problem with PCMCIA/Yenta system
Date: Mon, 21 Mar 2005 18:32:51 -0500
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Wolf <webmaster@checkpoint-computer.de>,
       Jonas Oreland <jonas.oreland@mysql.com>
References: <20050320164619.565f4470.akpm@osdl.org> <200503212353.22924.daniel.ritz@gmx.ch>
In-Reply-To: <200503212353.22924.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503211832.51193.ron@rongage.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 17:53, Daniel Ritz wrote:
> On Monday 21 March 2005 01:46, Andrew Morton wrote:
> > Do you think your recent work on ti12xx_hook() will help this guy?
Everyone:

Let there be no confusion here - Daniel came up with this patch.  I am only 
reporting the aggregate result.

Daniel:

Here is the aggregate patch I am using that is working nicely here...

diff -ur linux-2.6.11.5/drivers/pcmcia/cs.c 
linux-2.6.11.5.new/drivers/pcmcia/cs.c
--- linux-2.6.11.5/drivers/pcmcia/cs.c 2005-03-19 01:34:53.000000000 -0500
+++ linux-2.6.11.5.new/drivers/pcmcia/cs.c 2005-03-21 06:49:17.000000000 -0500
@@ -507,6 +507,10 @@
   cs_err(skt, "unsupported voltage key.\n");
   return CS_BAD_TYPE;
  }
+
+ if (skt->ops->generic_hook)
+  skt->ops->generic_hook(skt,HOOK_POWER_PRE);
+  
  skt->socket.flags = 0;
  skt->ops->set_socket(skt, &skt->socket);
 
@@ -521,7 +525,12 @@
   return CS_BAD_TYPE;
  }
 
- return socket_reset(skt);
+ status = socket_reset(skt);
+ 
+ if (skt->ops->generic_hook)
+  skt->ops->generic_hook(skt, HOOK_POWER_POST);
+ 
+ return status;
 }
 
 /*
diff -ur linux-2.6.11.5/drivers/pcmcia/ti113x.h 
linux-2.6.11.5.new/drivers/pcmcia/ti113x.h
--- linux-2.6.11.5/drivers/pcmcia/ti113x.h 2005-03-19 01:34:55.000000000 -0500
+++ linux-2.6.11.5.new/drivers/pcmcia/ti113x.h 2005-03-21 06:54:40.000000000 
-0500
@@ -590,6 +590,38 @@
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
+ struct yenta_socket *socket = container_of(sock, struct yenta_socket, 
socket);
+ u32 tmp;
+ 
+ switch (operation) {
+ case HOOK_POWER_PRE:
+  tmp = config_readl(socket, TI122X_MFUNC);
+  socket->saved_state[0] = tmp;
+  config_writel(socket, TI122X_MFUNC, tmp & ~(TI122X_MFUNC0_MASK | 
TI122X_MFUNC3_MASK));
+  break;
+  
+ case HOOK_POWER_POST:
+  config_writel(socket, TI122X_MFUNC, socket->saved_state[0]);
+  break;
+ default:
+  break;
+ }
+
+ return 0;
+}
+
+
 static int ti12xx_override(struct yenta_socket *socket)
 {
  u32 val, val_orig;
@@ -632,6 +664,7 @@
   ti12xx_irqroute_func0(socket);
  else
   ti12xx_irqroute_func1(socket);
+ socket->socket.ops->generic_hook = ti12xx_hook;
 
  return ti_override(socket);
 }
diff -ur linux-2.6.11.5/include/pcmcia/ss.h 
linux-2.6.11.5.new/include/pcmcia/ss.h
--- linux-2.6.11.5/include/pcmcia/ss.h 2005-03-19 01:35:03.000000000 -0500
+++ linux-2.6.11.5.new/include/pcmcia/ss.h 2005-03-21 06:51:35.000000000 -0500
@@ -77,6 +77,10 @@
 /* Use this just for bridge windows */
 #define MAP_IOSPACE 0x20
 
+/* generic hook operations */
+#define HOOK_POWER_PRE  0x01
+#define HOOK_POWER_POST 0x02
+
 typedef struct pccard_io_map {
     u_char map;
     u_char flags;
@@ -113,6 +117,7 @@
  int (*set_socket)(struct pcmcia_socket *sock, socket_state_t *state);
  int (*set_io_map)(struct pcmcia_socket *sock, struct pccard_io_map *io);
  int (*set_mem_map)(struct pcmcia_socket *sock, struct pccard_mem_map *mem);
+ int (*generic_hook)(struct pcmcia_socket *sock, int operation);
 };
 
 struct pccard_resource_ops {

-- 
Ron Gage - Pontiac, Michigan
(MCP, LPIC1, A+, Net+)
