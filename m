Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVATPeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVATPeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVATPeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:34:08 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:19108 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262165AbVATPaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:30:20 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 20 Jan 2005 16:28:31 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: saa7134 module
Message-ID: <20050120152831.GA13077@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- fix saa7134 module loading issues.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/saa7134/saa7134-core.c |   47 ++++++++++++++++++++-
 1 files changed, 45 insertions(+), 2 deletions(-)

Index: linux-2.6.10/drivers/media/video/saa7134/saa7134-core.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/saa7134/saa7134-core.c	2005-01-10 12:40:58.613644368 +0100
+++ linux-2.6.10/drivers/media/video/saa7134/saa7134-core.c	2005-01-10 12:40:59.759428971 +0100
@@ -222,6 +222,49 @@ static void dump_statusregs(struct saa71
 }
 #endif
 
+/* ----------------------------------------------------------- */
+/* delayed request_module                                      */
+
+static int need_empress;
+static int need_dvb;
+
+static int pending_call(struct notifier_block *self, unsigned long state,
+			void *module)
+{
+	if (module != THIS_MODULE || state != MODULE_STATE_LIVE)
+		return NOTIFY_DONE;
+
+        if (need_empress)
+                request_module("saa7134-empress");
+        if (need_dvb)
+                request_module("saa7134-dvb");
+	return NOTIFY_DONE;
+}
+
+static int pending_registered;
+static struct notifier_block pending_notifier = {
+	.notifier_call = pending_call,
+};
+
+static void request_module_depend(char *name, int *flag)
+{
+	switch (THIS_MODULE->state) {
+	case MODULE_STATE_COMING:
+		if (!pending_registered) {
+			register_module_notifier(&pending_notifier);
+			pending_registered = 1;
+		}
+		*flag = 1;
+		break;
+	case MODULE_STATE_LIVE:
+		request_module(name);
+		break;
+	default:
+		/* nothing */;
+		break;
+	}
+}
+
 /* ------------------------------------------------------------------ */
 
 /* nr of (saa7134-)pages for the given buffer size */
@@ -941,11 +984,11 @@ static int __devinit saa7134_initdev(str
 	if (dev->tda9887_conf)
 		request_module("tda9887");
   	if (card_is_empress(dev)) {
-		request_module("saa7134-empress");
 		request_module("saa6752hs");
+		request_module_depend("saa7134-empress",&need_empress);
 	}
   	if (card_is_dvb(dev))
-		request_module("saa7134-dvb");
+		request_module_depend("saa7134-dvb",&need_dvb);
 
 	v4l2_prio_init(&dev->prio);
 

-- 
#define printk(args...) fprintf(stderr, ## args)
