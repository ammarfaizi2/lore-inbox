Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161722AbWKHWGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161722AbWKHWGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161483AbWKHWGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:06:03 -0500
Received: from mta6.adelphia.net ([68.168.78.190]:12539 "EHLO
	mta6.adelphia.net") by vger.kernel.org with ESMTP id S1161722AbWKHWGB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:06:01 -0500
Date: Wed, 8 Nov 2006 15:36:02 -0600
From: Corey Minyard <minyard@acm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Frederic Lelievre <Frederic.Lelievre@ca.kontron.com>
Subject: [PATCH] IPMI: retry messages on certain error returns
Message-ID: <20061108213602.GA19762@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some errors more from the IPMI send message command are retryable,
but are not being retried by the IPMI code.  Make sure they get
retried.

Signed-off-by: Corey Minyard <minyard@acm.org>
Cc: Frederic Lelievre <Frederic.Lelievre@ca.kontron.com>

Index: linux-2.6.18/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.18.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.18/drivers/char/ipmi/ipmi_msghandler.c
@@ -3468,7 +3468,9 @@ void ipmi_smi_msg_received(ipmi_smi_t   
                    report the error immediately. */
 		if ((msg->rsp_size >= 3) && (msg->rsp[2] != 0)
 		    && (msg->rsp[2] != IPMI_NODE_BUSY_ERR)
-		    && (msg->rsp[2] != IPMI_LOST_ARBITRATION_ERR))
+		    && (msg->rsp[2] != IPMI_LOST_ARBITRATION_ERR)
+		    && (msg->rsp[2] != IPMI_BUS_ERR)
+		    && (msg->rsp[2] != IPMI_NAK_ON_WRITE_ERR))
 		{
 			int chan = msg->rsp[3] & 0xf;
 
Index: linux-2.6.18/include/linux/ipmi_msgdefs.h
===================================================================
--- linux-2.6.18.orig/include/linux/ipmi_msgdefs.h
+++ linux-2.6.18/include/linux/ipmi_msgdefs.h
@@ -80,6 +80,8 @@
 #define IPMI_INVALID_COMMAND_ERR	0xc1
 #define IPMI_ERR_MSG_TRUNCATED		0xc6
 #define IPMI_LOST_ARBITRATION_ERR	0x81
+#define IPMI_BUS_ERR			0x82
+#define IPMI_NAK_ON_WRITE_ERR		0x83
 #define IPMI_ERR_UNSPECIFIED		0xff
 
 #define IPMI_CHANNEL_PROTOCOL_IPMB	1
