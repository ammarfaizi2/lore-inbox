Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVC2TvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVC2TvC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVC2TuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:50:22 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:39651 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261335AbVC2TuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:50:07 -0500
Date: Tue, 29 Mar 2005 13:50:02 -0600 (CST)
From: Patrick Gefre <pfg@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Patrick Gefre <pfg@sgi.com>
Message-Id: <20050329195002.30693.4700.sendpatchset@attica.americas.sgi.com>
In-Reply-To: <20050329194956.30693.94506.sendpatchset@attica.americas.sgi.com>
References: <20050329194956.30693.94506.sendpatchset@attica.americas.sgi.com>
Subject: [PATCH 2.6.12 2/2] Altix ioc4 serial - set a better timeout/threshold
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Set the timeout and threshold to better values.


Signed-off-by: Patrick Gefre <pfg@sgi.com>




Index: linux-2.5-ioc4/drivers/serial/ioc4_serial.c
===================================================================
--- linux-2.5-ioc4.orig/drivers/serial/ioc4_serial.c	2005-03-24 13:56:48.230417236 -0600
+++ linux-2.5-ioc4/drivers/serial/ioc4_serial.c	2005-03-24 13:58:35.560294893 -0600
@@ -1272,8 +1272,9 @@
 	 * and set the rx threshold to that amount.  There are 4 chars
 	 * per ring entry, so we'll divide the number of chars that will
 	 * arrive in timeout by 4.
+	 * So .... timeout * baud / 10 / HZ / 4, with HZ = 100.
 	 */
-	threshold = timeout * port->ip_baud / 10 / HZ / 4;
+	threshold = timeout * port->ip_baud / 4000;
 	if (threshold == 0)
 		threshold = 1;	/* otherwise we'll intr all the time! */
 
@@ -1285,8 +1286,10 @@
 
 	writel(port->ip_sscr, &port->ip_serial_regs->sscr);
 
-	/* Now set the rx timeout to the given value */
-	timeout = timeout * IOC4_SRTR_HZ / HZ;
+	/* Now set the rx timeout to the given value
+	 * again timeout * IOC4_SRTR_HZ / HZ
+	 */
+	timeout = timeout * IOC4_SRTR_HZ / 100;
 	if (timeout > IOC4_SRTR_CNT)
 		timeout = IOC4_SRTR_CNT;
 
@@ -1380,7 +1383,7 @@
 	if (port->ip_tx_lowat == 0)
 		port->ip_tx_lowat = 1;
 
-	set_rx_timeout(port, port->ip_rx_timeout);
+	set_rx_timeout(port, 2);
 
 	return 0;
 }

-- 

