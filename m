Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTGFQm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTGFQm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:42:27 -0400
Received: from shower.ispgateway.de ([62.67.200.219]:53445 "HELO
	shower.ispgateway.de") by vger.kernel.org with SMTP id S262931AbTGFQmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:42:23 -0400
Message-ID: <3F0854D6.5040908@dot-heine.de>
Date: Sun, 06 Jul 2003 18:56:54 +0200
From: Claus-Justus Heine <ch@dot-heine.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: yenta-socket oops with 2.5.73-mm3, 2.5.74, 2.5.74-mm1
References: <6412.5pV.9@gated-at.bofh.it> <68xC.6U.1@gated-at.bofh.it>
In-Reply-To: <68xC.6U.1@gated-at.bofh.it>
X-Enigmail-Version: 0.74.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020405050401000308020606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020405050401000308020606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

have the same problem, however ...


>  void pcmcia_parse_events(struct pcmcia_socket *s, u_int events)
>  {
> +       if (unlikely(&s->init_done == 0))

... this cannot work because of the "&". Of course, the _address_ of
s->init_done is always non-zero. Also, the problems are related to yenta_socket.c

The interrupt occurs during irq-probing in yenta-socket.c, so the problem should
be fixed _inside_ yenta-socket.c and not touch any other part of the pcmcia stuff.

I.e. add that "init_done" flag to "struct yenta_socket"; not to struct socket.
It should work then, just trying now ...

Greetings

Claus

P.s.:
I'm not subscribed to linux-kernel, please Cc: to my address. Thanks.



--------------020405050401000308020606
Content-Type: text/plain;
 name="foo.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foo.diff"

--- yenta_socket.c.old	2003-07-02 22:49:32.000000000 +0200
+++ yenta_socket.c	2003-07-06 16:13:55.000000000 +0200
@@ -426,7 +426,8 @@
 
 	events = yenta_events(socket);
 	if (events) {
-		pcmcia_parse_events(&socket->socket, events);
+		if (likely(socket->init_done))
+			pcmcia_parse_events(&socket->socket, events);
 		return IRQ_HANDLED;
 	}
 	return IRQ_NONE;
@@ -501,8 +502,8 @@
 	socket->socket.features |= SS_CAP_PAGE_REGS | SS_CAP_PCCARD | SS_CAP_CARDBUS;
 	socket->socket.map_size = 0x1000;
 	socket->socket.pci_irq = socket->cb_irq;
-	socket->socket.irq_mask = yenta_probe_irq(socket, isa_irq_mask);
 	socket->socket.cb_dev = socket->dev;
+	socket->socket.irq_mask = yenta_probe_irq(socket, isa_irq_mask);
 
 	printk("Yenta IRQ list %04x, PCI irq%d\n", socket->socket.irq_mask, socket->cb_irq);
 }
@@ -821,6 +822,7 @@
 {
 	struct yenta_socket *socket;
 	struct cardbus_override_struct *d;
+	int ret;
 	
 	socket = kmalloc(sizeof(struct yenta_socket), GFP_KERNEL);
 	if (!socket)
@@ -888,12 +890,18 @@
 		add_timer(&socket->poll_timer);
 	}
 
+	socket->init_done = 0; /* should still be 0, paranoya ... */
+
 	/* Figure out what the dang thing can do for the PCMCIA layer... */
 	yenta_get_socket_capabilities(socket, isa_interrupts);
 	printk("Socket status: %08x\n", cb_readl(socket, CB_SOCKET_STATE));
 
 	/* Register it with the pcmcia layer.. */
-	return pcmcia_register_socket(&socket->socket);
+	ret = pcmcia_register_socket(&socket->socket);
+	if (ret == 0) {
+		socket->init_done = 1;
+	}
+	return ret;
 }
 
 
--- yenta_socket.h.old	2003-07-02 22:45:05.000000000 +0200
+++ yenta_socket.h	2003-07-06 16:05:40.000000000 +0200
@@ -103,6 +103,8 @@
 
 	struct pcmcia_socket socket;
 
+	unsigned int init_done:1; /* used during initialization */
+
 	/* A few words of private data for special stuff of overrides... */
 	unsigned int private[8];
 };

--------------020405050401000308020606--

