Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261949AbTCLUtz>; Wed, 12 Mar 2003 15:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261981AbTCLUty>; Wed, 12 Mar 2003 15:49:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4621 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261949AbTCLUtq>; Wed, 12 Mar 2003 15:49:46 -0500
Date: Wed, 12 Mar 2003 21:00:26 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] 3/6 (4): add SOCKET_CARDBUS_CONFIG flag
Message-ID: <20030312210026.F27656@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030312205659.C27656@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030312205659.C27656@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 12, 2003 at 08:56:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pcmcia-4.diff

  Cardbus uses socket->cb_config to detect when the cardbus card has
  been initialised.  Since cb_config will eventually die, we need a
  solution - introduce the SOCKET_CARDBUS_CONFIG flag, which is set
  once we have initialised the cardbus socket.

diff -ur orig/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- orig/drivers/pcmcia/cs.c	Sun Mar  2 16:25:15 2003
+++ linux/drivers/pcmcia/cs.c	Sat Mar  1 19:20:22 2003
@@ -621,8 +621,10 @@
 		send_event(s, CS_EVENT_PM_RESUME, CS_EVENT_PRI_LOW);
 	} else if (s->state & SOCKET_SETUP_PENDING) {
 #ifdef CONFIG_CARDBUS
-	    if (s->state & SOCKET_CARDBUS)
+	    if (s->state & SOCKET_CARDBUS) {
 		cb_alloc(s);
+		s->state |= SOCKET_CARDBUS_CONFIG;
+	    }
 #endif
 	    send_event(s, CS_EVENT_CARD_INSERTION, CS_EVENT_PRI_LOW);
 	    s->state &= ~SOCKET_SETUP_PENDING;
@@ -1072,7 +1074,7 @@
 	config->Vcc = s->socket.Vcc;
 	config->Vpp1 = config->Vpp2 = s->socket.Vpp;
 	config->Option = s->cap.cb_dev->subordinate->number;
-	if (s->cb_config) {
+	if (s->state & SOCKET_CARDBUS_CONFIG) {
 	    config->Attributes = CONF_VALID_CLIENT;
 	    config->IntType = INT_CARDBUS;
 	    config->AssignedIRQ = s->irq.AssignedIRQ;
diff -ur orig/drivers/pcmcia/cs_internal.h linux/drivers/pcmcia/cs_internal.h
--- orig/drivers/pcmcia/cs_internal.h	Sat Mar  1 20:27:30 2003
+++ linux/drivers/pcmcia/cs_internal.h	Sat Mar  1 19:19:50 2003
@@ -176,6 +176,7 @@
 #define SOCKET_IO_REQ(i)	(0x1000<<(i))
 #define SOCKET_REGION_INFO	0x4000
 #define SOCKET_CARDBUS		0x8000
+#define SOCKET_CARDBUS_CONFIG	0x10000
 
 #define CHECK_HANDLE(h) \
     (((h) == NULL) || ((h)->client_magic != CLIENT_MAGIC))

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

