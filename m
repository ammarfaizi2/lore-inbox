Return-Path: <linux-kernel-owner+w=401wt.eu-S964907AbXASVLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbXASVLQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 16:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbXASVLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 16:11:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:24389 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964907AbXASVLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 16:11:15 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=XgvGadl1pXjd2ZSOlIrboVo3T3NlDuZ0A8ZglM5iyg60PTI+QWJYwZBnokrtDBERN1zdMsHmNlVnKnb4B+ugp/wT5+DGMVg6gRZc5Xls3i519rN8raQcQqrqWD45bfOkO+q7TWNLewzeLqluY89dGLt5JheHJfrdLZnTA8I15B4=
Date: Sat, 20 Jan 2007 00:10:51 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: adaplas@pol.net, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Recognize video=gx1fb:... option
Message-ID: <20070119211051.GC5013@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Beisert reported that the following option doesn't work for him

	video=gx1fb:1024x768-16@60

though sisfb was able to parse similar option correctly.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/video/geode/gx1fb_core.c |   29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -401,6 +401,30 @@ static void gx1fb_remove(struct pci_dev 
 	framebuffer_release(info);
 }
 
+#ifndef MODULE
+static void __init gx1fb_setup(char *options)
+{
+	char *this_opt;
+
+	if (!options || !*options)
+		return;
+
+	while ((this_opt = strsep(&options, ","))) {
+		if (!*this_opt)
+			continue;
+
+		if (!strncmp(this_opt, "mode:", 5))
+			strlcpy(mode_option, this_opt + 5, sizeof(mode_option));
+		else if (!strncmp(this_opt, "crt:", 4))
+			crt_option = !!simple_strtoul(this_opt + 4, NULL, 0);
+		else if (!strncmp(this_opt, "panel:", 6))
+			strlcpy(panel_option, this_opt + 6, sizeof(panel_option));
+		else
+			strlcpy(mode_option, this_opt, sizeof(mode_option));
+	}
+}
+#endif
+
 static struct pci_device_id gx1fb_id_table[] = {
 	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_VIDEO,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
@@ -420,8 +444,11 @@ static struct pci_driver gx1fb_driver = 
 static int __init gx1fb_init(void)
 {
 #ifndef MODULE
-	if (fb_get_options("gx1fb", NULL))
+	char *option = NULL;
+
+	if (fb_get_options("gx1fb", &option))
 		return -ENODEV;
+	gx1fb_setup(option);
 #endif
 	return pci_register_driver(&gx1fb_driver);
 }

