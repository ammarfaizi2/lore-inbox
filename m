Return-Path: <linux-kernel-owner+w=401wt.eu-S964851AbXALTg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbXALTg2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 14:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbXALTg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 14:36:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:24031 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964851AbXALTg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 14:36:27 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=lbGXHlA58hYWqzYJDJGb9EUU+zVk7+iJNA0RiAlmm0PGEOXmePA5pNDitMw5XNf7xS5hrGCfw4lm8LaDaqfqGhB77yK2t+IDgHfBkAfuSr2/BlS9J35NE43cT8EgFNJkvAyZZyuv9vqoQYQOasUej3jIVX1XZpymUCXkVMBqFu0=
Date: Fri, 12 Jan 2007 22:36:27 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Juergen Beisert <juergen127@kreuzholzen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel command line for a specific framebuffer console driver
Message-ID: <20070112193627.GA4999@martell.zuzino.mipt.ru>
References: <200701121343.43100.juergen127@kreuzholzen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701121343.43100.juergen127@kreuzholzen.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 01:43:42PM +0100, Juergen Beisert wrote:
> does someone know how to forward a kernel command line option to configure the
> AMD Geode GX1 framebuffer?
>
> I tried with "video=gx1fb:1024x768-16@60" but it does not work. On another
> machine with an SIS framebuffer the line "video=sisfb:1280x1024-8@60" works
> as expected.
>
> Any ideas?

Yes. You try this patch and report whether it works or not.

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

