Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVBASDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVBASDo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 13:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVBASDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 13:03:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47554 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262089AbVBASCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 13:02:46 -0500
Date: Tue, 1 Feb 2005 10:02:41 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-poweredge@dell.com
Cc: zaitcev@redhat.com, linux-precision@dell.com, linux-kernel@vger.kernel.org
Subject: Patch to enable the USB handoff on Dell 650
Message-ID: <20050201100241.07c6c504@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, guys,

I was looking at this:
  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=138892

  I have added usb-handoff as a kernel option in grub.conf for
  2.4.21-20.EL (smp) and re-enabled USB Emulation and Controller in the
  BIOS, and the machine now seems to boot normally.  I only had time to
  try booting it twice, but previously it would fail almost every time,
  so two successive successful boots seems very good.  Thanks for your
  quick responses and working solution!

Can someone with the Dell PW650 (which, I think, should be same as PE600)
test this patch for me? I do not want to send this for inclusion into
Linus' kernel before it's tested.

In theory we probably will want USB handoff to be enabled by default, but
I am not sure this time is now, so let us use DMI lists until then.

Thanks,
-- Pete

--- linux-2.6.11-rc2/arch/i386/kernel/dmi_scan.c	2005-01-22 14:53:59.000000000 -0800
+++ linux-2.6.11-rc2-lem/arch/i386/kernel/dmi_scan.c	2005-01-31 20:42:16.163592792 -0800
@@ -243,6 +243,19 @@
 }  
 #endif
 
+static __init int enable_usb_handoff(struct dmi_blacklist *d)
+{
+	extern int usb_early_handoff;
+
+	/*
+	 * A printk is probably unnecessary. There's no way this causes
+	 * any harm (famous last words). But seriously, we only add systems
+	 * to the list if we know that they need handoff for sure.
+	 */
+	usb_early_handoff = 1;
+	return 0;
+}
+
 /*
  *	Process the DMI blacklists
  */
@@ -376,6 +389,14 @@
 
 #endif
 
+	/*
+	 *	Boxes which need USB taken over from BIOS explicitly.
+	 */
+	{ enable_usb_handoff, "Dell PW650", {
+			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			MATCH(DMI_PRODUCT_NAME, "Precision WorkStation 650"),
+			NO_MATCH, NO_MATCH }},
+
 	{ NULL, }
 };
 
