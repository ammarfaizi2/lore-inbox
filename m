Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269001AbUJEMuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269001AbUJEMuE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 08:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269015AbUJEMuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 08:50:04 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:40721 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S269001AbUJEMt5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 08:49:57 -0400
Date: Tue, 5 Oct 2004 22:49:14 +1000
To: Vojtech Pavlik <vojtech@suse.cz>, linux-usb-devel@lists.sourceforge.net
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [HID] Fix hiddev devfs oops
Message-ID: <20041005124914.GA1009@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

There is a long-standing devfs_unregister oops in hid/hiddev.  It's
caused by hid calling hiddev_exit before unregistering itself which
in turn calls hiddev_disconnect.

hiddev_exit removes the directory which contains the hiddev devices.
Therefore it needs to be called after the hiddev devices have been
disconnected.

This patch fixes that.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Marcelo, the same fix is needed in 2.4 as well.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="p-2.6"

===== drivers/usb/input/hid-core.c 1.94 vs edited =====
--- 1.94/drivers/usb/input/hid-core.c	2004-08-25 22:01:29 +10:00
+++ edited/drivers/usb/input/hid-core.c	2004-10-05 22:44:03 +10:00
@@ -1859,8 +1859,8 @@
 
 static void __exit hid_exit(void)
 {
-	hiddev_exit();
 	usb_deregister(&hid_driver);
+	hiddev_exit();
 }
 
 module_init(hid_init);

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="p-2.4"

===== drivers/usb/hid-core.c 1.30 vs edited =====
--- 1.30/drivers/usb/hid-core.c	2004-08-08 18:59:53 +10:00
+++ edited/drivers/usb/hid-core.c	2004-10-05 22:33:52 +10:00
@@ -1459,8 +1459,8 @@
 
 static void __exit hid_exit(void)
 {
-	hiddev_exit();
 	usb_deregister(&hid_driver);
+	hiddev_exit();
 }
 
 module_init(hid_init);

--VbJkn9YxBvnuCH5J--
