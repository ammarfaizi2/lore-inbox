Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269143AbTCDEMn>; Mon, 3 Mar 2003 23:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269145AbTCDEMn>; Mon, 3 Mar 2003 23:12:43 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:51369 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S269143AbTCDEMm>; Mon, 3 Mar 2003 23:12:42 -0500
Date: Mon, 3 Mar 2003 23:23:08 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] crash in pcmcia_access_configuration_register
Message-ID: <Pine.LNX.4.50.0303032306120.5835-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

As promised, here's the patch to fix an oops in the kernel PCMCIA driver.
The patch should be applied both to 2.4 and 2.5 series.

How to reproduce the bug:

1) Compile and install HostAP (http://hostap.epitest.fi/) - any recent
version (CVS version is OK).

2) Insert a card supported by HostAP.

3) Remove (physically) the card.  The kernel oopses.

Explanation:

While doing a reset, HostAP used AccessConfigurationRegister request to
preserve the value of the configuration register.  The reset is triggered
by the removal of the card.

I do believe that HostAP can be improved to avoid reset if the socket
configuration has been released.  Nevertheless, oops is not a reputable
behavior when the driver merely requests a configuration register.

The pcmcia-cs driver already has a slightly different protection, but the
following patch is simpler and addresses the problem right before it
happens.

====================================
--- drivers/pcmcia/cs.c
+++ drivers/pcmcia/cs.c
@@ -882,6 +882,10 @@ int pcmcia_access_configuration_register
 	c = &s->config[reg->Function];
     } else
 	c = CONFIG(handle);
+
+    if (c == NULL)
+	return CS_NO_CARD;
+
     if (!(c->state & CONFIG_LOCKED))
 	return CS_CONFIGURATION_LOCKED;

====================================

-- 
Regards,
Pavel Roskin
