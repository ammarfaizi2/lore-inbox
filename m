Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271840AbTGRPGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271833AbTGRPE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:04:27 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20101
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271754AbTGROCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:02:09 -0400
Date: Fri, 18 Jul 2003 15:16:29 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181416.h6IEGTiY017732@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: forward port 2.4 Zoom video support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also apply the right fix to the yenta hang problem

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/pcmcia/ricoh.h linux-2.6.0-test1-ac2/drivers/pcmcia/ricoh.h
--- linux-2.6.0-test1/drivers/pcmcia/ricoh.h	2003-07-14 14:11:56.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/pcmcia/ricoh.h	2003-07-14 15:42:47.000000000 +0100
@@ -116,6 +116,8 @@
 #define  RL5C4XX_CMD_SHIFT		4
 #define  RL5C4XX_HOLD_MASK		0x1c00
 #define  RL5C4XX_HOLD_SHIFT		10
+#define  RL5C4XX_MISC_CONTROL           0x2F /* 8 bit */
+#define  RL5C4XX_ZV_ENABLE              0x08
 
 #ifdef __YENTA_H
 
@@ -125,10 +127,41 @@
 #define rl_mem(socket)		((socket)->private[3])
 #define rl_config(socket)	((socket)->private[4])
 
+static void ricoh_zoom_video(struct pcmcia_socket *sock, int onoff)
+{
+        u8 reg;
+	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
+
+        reg = config_readb(socket, RL5C4XX_MISC_CONTROL);
+        if (onoff)
+                /* Zoom zoom, we will all go together, zoom zoom, zoom zoom */
+                reg |=  RL5C4XX_ZV_ENABLE;
+        else
+                reg &= ~RL5C4XX_ZV_ENABLE;
+	
+        config_writeb(socket, RL5C4XX_MISC_CONTROL, reg);
+}
+
+static void ricoh_set_zv(struct pcmcia_socket *sock)
+{
+	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
+        if(socket->dev->vendor == PCI_VENDOR_ID_RICOH)
+        {
+                switch(socket->dev->device)
+                {
+                        /* There may be more .. */
+		case  PCI_DEVICE_ID_RICOH_RL5C478:
+			sock->zoom_video = ricoh_zoom_video;
+			break;  
+                }
+        }
+}
+
 static int ricoh_init(struct pcmcia_socket *sock)
 {
 	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
 	yenta_init(sock);
+	ricoh_set_zv(sock);
 
 	config_writew(socket, RL5C4XX_MISC, rl_misc(socket));
 	config_writew(socket, RL5C4XX_16BIT_CTL, rl_ctl(socket));
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/pcmcia/ti113x.h linux-2.6.0-test1-ac2/drivers/pcmcia/ti113x.h
--- linux-2.6.0-test1/drivers/pcmcia/ti113x.h	2003-07-14 14:11:56.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/pcmcia/ti113x.h	2003-07-14 15:41:34.000000000 +0100
@@ -148,14 +148,96 @@
 	return 0;
 }
 
+/*
+ *	Zoom video control for TI122x/113x chips
+ */
+
+static void ti_zoom_video(struct pcmcia_socket *sock, int onoff)
+{
+	u8 reg;
+	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
+
+	/* If we don't have a Zoom Video switch this is harmless,
+	   we just tristate the unused (ZV) lines */
+	reg = config_readb(socket, TI113X_CARD_CONTROL);
+	if (onoff)
+		/* Zoom zoom, we will all go together, zoom zoom, zoom zoom */
+		reg |= TI113X_CCR_ZVENABLE;
+	else
+		reg &= ~TI113X_CCR_ZVENABLE;
+	config_writeb(socket, TI113X_CARD_CONTROL, reg);
+}
+
+/*
+ *	The 145x series can also use this. They have an additional
+ *	ZV autodetect mode we don't use but don't actually need.
+ *	FIXME: manual says its in func0 and func1 but disagrees with
+ *	itself about this - do we need to force func0, if so we need
+ *	to know a lot more about socket pairings in pcmcia_socket than
+ *	we do now.. uggh.
+ */
+ 
+static void ti1250_zoom_video(struct pcmcia_socket *sock, int onoff)
+{	
+	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
+	int shift = 0;
+	u8 reg;
+
+	ti_zoom_video(sock, onoff);
+
+	reg = config_readb(socket, 0x84);
+	reg |= (1<<7);	/* ZV bus enable */
+
+	if(PCI_FUNC(socket->dev->devfn)==1)
+		shift = 1;
+	
+	if(onoff)
+	{
+		reg &= ~(1<<6); 	/* Clear select bit */
+		reg |= shift<<6;	/* Favour our socket */
+		reg |= 1<<shift;	/* Socket zoom video on */
+	}
+	else
+	{
+		reg &= ~(1<<6); 	/* Clear select bit */
+		reg |= (1^shift)<<6;	/* Favour other socket */
+		reg &= ~(1<<shift);	/* Socket zoon video off */
+	}
+
+	config_writeb(socket, 0x84, reg);
+}
+
+static void ti_set_zv(struct pcmcia_socket *sock)
+{
+	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
+	if(socket->dev->vendor == PCI_VENDOR_ID_TI)
+	{
+		switch(socket->dev->device)
+		{
+			/* There may be more .. */
+			case PCI_DEVICE_ID_TI_1220:
+			case PCI_DEVICE_ID_TI_1221:
+			case PCI_DEVICE_ID_TI_1225:
+				sock->zoom_video = ti_zoom_video;
+				break;	
+			case PCI_DEVICE_ID_TI_1250:
+			case PCI_DEVICE_ID_TI_1251A:
+			case PCI_DEVICE_ID_TI_1251B:
+			case PCI_DEVICE_ID_TI_1450:
+				sock->zoom_video = ti1250_zoom_video;
+		}
+	}
+}
 static int ti_init(struct pcmcia_socket *sock)
 {
 	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
 	yenta_init(sock);
+	ti_set_zv(sock);
 	ti_intctl(socket);
 	return 0;
 }
 
+
 /*
  * Generic TI init - TI has an extension for the
  * INTCTL register that sets the PCI CSC interrupt.
@@ -176,9 +258,6 @@
 	if (new != reg)
 		exca_writeb(socket, I365_INTCTL, new);
 
-#if 0
-	/* THIS CAUSES HANGS! Disabled for now, do not know why */
-
 	/*
 	 * If ISA interrupts don't work, then fall back to routing card
 	 * interrupts to the PCI interrupt of the socket.
@@ -190,7 +269,7 @@
 		u8 irqmux, devctl;
 
 		devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
-		if (devctl & TI113X_DCR_IMODE_MASK != TI12XX_DCR_IMODE_ALL_SERIAL) {
+		if ((devctl & TI113X_DCR_IMODE_MASK) != TI12XX_DCR_IMODE_ALL_SERIAL) {
 			printk (KERN_INFO "ti113x: Routing card interrupts to PCI\n");
 
 			devctl &= ~TI113X_DCR_IMODE_MASK;
@@ -203,7 +282,6 @@
 			config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
 		}
 	}
-#endif
 
 	socket->socket.ops->init = ti_init;
 	return 0;
@@ -220,6 +298,7 @@
 {
 	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
 	yenta_init(sock);
+	ti_set_zv(sock);
 
 	config_writel(socket, TI113X_SYSTEM_CONTROL, ti_sysctl(socket));
 	config_writeb(socket, TI113X_CARD_CONTROL, ti_cardctl(socket));
@@ -248,6 +327,7 @@
 	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
 	yenta_init(sock);
 	ti113x_init(sock);
+	ti_set_zv(sock);
 	ti_irqmux(socket) = config_readl(socket, TI122X_IRQMUX);
 	ti_irqmux(socket) = (ti_irqmux(socket) & ~0x0f) | 0x02; /* route INTA */
 	if (!(ti_sysctl(socket) & TI122X_SCR_INTRTIE))
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/pcmcia/yenta_socket.c linux-2.6.0-test1-ac2/drivers/pcmcia/yenta_socket.c
--- linux-2.6.0-test1/drivers/pcmcia/yenta_socket.c	2003-07-14 14:11:56.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/pcmcia/yenta_socket.c	2003-07-14 15:34:36.000000000 +0100
@@ -297,6 +297,8 @@
 		}
 		exca_writeb(socket, I365_CSCINT, reg);
 		exca_readb(socket, I365_CSC);
+		if(sock->zoom_video)
+			sock->zoom_video(sock, state->flags & SS_ZVCARD);
 	}
 	config_writew(socket, CB_BRIDGE_CONTROL, bridge);
 	/* Socket event mask: get card insert/remove events.. */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/include/pcmcia/ss.h linux-2.6.0-test1-ac2/include/pcmcia/ss.h
--- linux-2.6.0-test1/include/pcmcia/ss.h	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test1-ac2/include/pcmcia/ss.h	2003-07-14 15:14:26.000000000 +0100
@@ -51,6 +51,7 @@
 #define SS_3VCARD	0x1000
 #define SS_XVCARD	0x2000
 #define SS_PENDING	0x4000
+#define SS_ZVCARD	0x8000
 
 /* InquireSocket capabilities */
 #define SS_CAP_PAGE_REGS	0x0001
@@ -209,6 +210,10 @@
 	/* socket operations */
 	struct pccard_operations *	ops;
 
+	/* Zoom video behaviour is so chip specific its not worth adding
+	   this to _ops */
+	void 				(*zoom_video)(struct pcmcia_socket *, int);
+                           
 	/* state thread */
 	struct semaphore		skt_sem;	/* protects socket h/w state */
 
