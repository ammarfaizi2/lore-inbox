Return-Path: <linux-kernel-owner+w=401wt.eu-S1751725AbXAVLwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbXAVLwZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 06:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbXAVLwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 06:52:25 -0500
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:21599 "EHLO
	mtagate5.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbXAVLwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 06:52:23 -0500
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.20-rc5 1/7] ehea: Fixed wrong dereferencation
Date: Mon, 22 Jan 2007 12:52:20 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1551
To: Jeff Garzik <jeff@garzik.org>
Cc: Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <ossthema@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       Stefan Roscher <roscher@de.ibm.com>,
       Stefan Roscher <ossrosch@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200701221252.20814.osstklei@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not only check the pointer against 0 but also the dereferenced value

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


 drivers/net/ehea/ehea.h      |    2 +-
 drivers/net/ehea/ehea_main.c |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)


diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
--- linux-2.6.20-rc5/drivers/net/ehea/ehea.h	2007-01-12 19:54:26.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea.h	2007-01-19 13:56:41.000000000 +0100
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0043"
+#define DRV_VERSION	"EHEA_0044"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c	2007-01-12 19:54:26.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-01-19 13:58:01.000000000 +0100
@@ -2471,14 +2471,16 @@ static int __devinit ehea_probe(struct i
 
 	adapter_handle = (u64*)get_property(dev->ofdev.node, "ibm,hea-handle",
 					    NULL);
-	if (!adapter_handle) {
+	if (adapter_handle)
+		adapter->handle = *adapter_handle;
+
+	if (!adapter->handle) {
 		dev_err(&dev->ofdev.dev, "failed getting handle for adapter"
 			" '%s'\n", dev->ofdev.node->full_name);
 		ret = -ENODEV;
 		goto out_free_ad;
 	}
 
-	adapter->handle = *adapter_handle;
 	adapter->pd = EHEA_PD_ID;
 
 	dev->ofdev.dev.driver_data = adapter;

