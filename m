Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbSBBXlO>; Sat, 2 Feb 2002 18:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbSBBXlF>; Sat, 2 Feb 2002 18:41:05 -0500
Received: from hs-gate.handshake.de ([193.141.176.10]:49668 "EHLO
	hs-gate.handshake.de") by vger.kernel.org with ESMTP
	id <S282978AbSBBXk6>; Sat, 2 Feb 2002 18:40:58 -0500
From: columbus@hit.handshake.de (Christoph Bartelmus)
X-ZC-PGP-Key-Avail: 
X-Mailer: CrossPoint/OpenXP v3.40RC3@2412012358 R/A18112
Message-ID: <8IBS9f7Xz9B@hit-columbus.hit.handshake.de>
Organization: Handshake e.V.
X-Gateway: ZCONNECT UR hit.handshake.de [DUUCP vom 25.09.2000]
Subject: PROBLEM: serial port driver grabs occupied port
Date: 02 Feb 2002 23:21:00 GMT
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there's a problem with linux/drivers/char/serial.c that appears when using  
the LIRC serial port drivers (see http://www.lirc.org). Here's how to  
reproduce the problem:

1. Load the lirc_serial module (included in the LIRC package). This module  
uses request_region() for the used serial port's IO space.

2. Load the kernel serial module. In rs_init() the available serial ports  
are initialized. For the port already claimed by the lirc_serial module  
check_region() fails and state->type for this port stays PORT_UNKNOWN.

Now the problem:
3. Open the /dev/ttySx for the port that is occupied by the lirc_serial  
module. rs_open() does not check the state of the serial port and returns  
no error. Now you can use setserial to hijack the port... lirc_serial  
stops working.

The patch below fixes the problem for me (tested with 2.2.19 and 2.2.20).  
There's one problem with this patch though. Once state->type ist  
PORT_UNKNOWN for a port there's no way to reclaim the port with e.g.  
setserial unless you remove the serial port module and load it again.

Christoph

PS: I'm not subscribed, cc me if replying.

--- Schnipp ---
--- linux/drivers/char/serial.c	Sun Mar 25 18:37:31 2001
+++ serial.c	Tue Jan 15 18:20:59 2002
@@ -928,6 +928,11 @@
 	unsigned short ICP;
 #endif

+	if(state->type == PORT_UNKNOWN)
+	{
+		return -ENODEV;
+	}
+
 	page = get_free_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
@@ -1738,7 +1743,10 @@
 	info->xmit_fifo_size = state->xmit_fifo_size =
 		new_serial.xmit_fifo_size;

-	release_region(state->port,8);
+	if(old_state.type != PORT_UNKNOWN)
+	{
+		release_region(state->port,8);
+	}
 	if (change_port || change_irq) {
 		/*
 		 * We need to shutdown the serial port at the old
@@ -1750,8 +1758,14 @@
 		info->hub6 = state->hub6 = new_serial.hub6;
 	}
 	if (state->type != PORT_UNKNOWN)
+	{
+		retval=check_region(state->port,8);
+		if(retval<0)
+		{
+			return retval;
+		}
 		request_region(state->port,8,"serial(set)");
-
+	}
 	
 check_and_exit:
 	if (!state->port || !state->type)
@@ -3586,3 +3600,4 @@
 	return kmem_start;
 }
 #endif
+
--- Schnipp ---
