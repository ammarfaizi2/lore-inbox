Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261962AbTCLTby>; Wed, 12 Mar 2003 14:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261964AbTCLTby>; Wed, 12 Mar 2003 14:31:54 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:22945 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S261962AbTCLTbw>;
	Wed, 12 Mar 2003 14:31:52 -0500
Date: Wed, 12 Mar 2003 22:41:33 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org, greg@kroah.com,
       david-b@pacbell.net
Subject: [2.4] Memleak in drivers/usb/hub.c::usb_reset_device
Message-ID: <20030312194133.GA27968@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There seems to be a memleak in drivers/usb/hub.c::usb_reset_device()
   on error exit path. See the patch.
   Found with help of smatch + enhanced unfree script.

Bye,
    Oleg
===== drivers/usb/hub.c 1.19 vs edited =====
--- 1.19/drivers/usb/hub.c	Sat Sep 21 00:12:53 2002
+++ edited/drivers/usb/hub.c	Wed Mar 12 22:38:43 2003
@@ -1057,8 +1057,10 @@
 	}
 	ret = usb_get_descriptor(dev, USB_DT_DEVICE, 0, descriptor,
 			sizeof(*descriptor));
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(descriptor);
 		return ret;
+	}
 
 	le16_to_cpus(&descriptor->bcdUSB);
 	le16_to_cpus(&descriptor->idVendor);
