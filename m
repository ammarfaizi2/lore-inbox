Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756406AbWKVSrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406AbWKVSrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756405AbWKVSrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:47:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:5217 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756406AbWKVSrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:47:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=tkbyhwCzGwhe6YCcQyp/z06GsE6y49oCbzDwO3pzso2u8EM1E94vj4JBJXKAajt0AUGeCi0rT4udXe5S2G4nxgVloZwQTi9RQGgBlUFkxc1spJNwc1PorH6aFtxRDvICI40mg5FaB2JxMdkOQTS84ilPfGEF58kQztsTmyuaOq4=
Date: Thu, 23 Nov 2006 03:41:11 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>, akpm@osdl.org
Subject: [PATCH] tlclk: fix platform_device_register_simple() error check
Message-ID: <20061122184111.GC2985@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>,
	akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of platform_device_register_simple() should be
checked by IS_ERR().

This patch also fix misc_register() error case. Because misc_register()
returns error code.

Cc: Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/char/tlclk.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: work-fault-inject/drivers/char/tlclk.c
===================================================================
--- work-fault-inject.orig/drivers/char/tlclk.c
+++ work-fault-inject/drivers/char/tlclk.c
@@ -792,15 +792,14 @@ static int __init tlclk_init(void)
 	ret = misc_register(&tlclk_miscdev);
 	if (ret < 0) {
 		printk(KERN_ERR "tlclk: misc_register returns %d.\n", ret);
-		ret = -EBUSY;
 		goto out3;
 	}
 
 	tlclk_device = platform_device_register_simple("telco_clock",
 				-1, NULL, 0);
-	if (!tlclk_device) {
+	if (IS_ERR(tlclk_device)) {
 		printk(KERN_ERR "tlclk: platform_device_register failed.\n");
-		ret = -EBUSY;
+		ret = PTR_ERR(tlclk_device);
 		goto out4;
 	}
 
