Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261964AbTCZT2J>; Wed, 26 Mar 2003 14:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbTCZT0u>; Wed, 26 Mar 2003 14:26:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15371 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261987AbTCZTYw>; Wed, 26 Mar 2003 14:24:52 -0500
Date: Wed, 26 Mar 2003 19:36:01 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PULL] (3/9) PCMCIA changes
Message-ID: <20030326193601.E8871@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030326193427.B8871@flint.arm.linux.org.uk> <20030326193511.C8871@flint.arm.linux.org.uk> <20030326193537.D8871@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030326193537.D8871@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 26, 2003 at 07:35:37PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.889.359.2 -> 1.889.359.3
#	drivers/pcmcia/cs_internal.h	1.5     -> 1.6    
#	 drivers/pcmcia/cs.c	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/17	rmk@flint.arm.linux.org.uk	1.889.359.3
# [PCMCIA] pcmcia-4: introduce SOCKET_CARDBUS_CONFIG
# 
# Cardbus uses socket->cb_config to detect when the cardbus card has
# been initialised.  Since cb_config will eventually die, we need a
# solution - introduce the SOCKET_CARDBUS_CONFIG flag, which is set
# once we have initialised the cardbus socket.
# --------------------------------------------
#
diff -Nru a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
--- a/drivers/pcmcia/cs.c	Wed Mar 26 19:19:46 2003
+++ b/drivers/pcmcia/cs.c	Wed Mar 26 19:19:46 2003
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
diff -Nru a/drivers/pcmcia/cs_internal.h b/drivers/pcmcia/cs_internal.h
--- a/drivers/pcmcia/cs_internal.h	Wed Mar 26 19:19:46 2003
+++ b/drivers/pcmcia/cs_internal.h	Wed Mar 26 19:19:46 2003
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

