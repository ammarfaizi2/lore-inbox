Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVCJIVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVCJIVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 03:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVCJITF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 03:19:05 -0500
Received: from relay.rost.ru ([80.254.111.11]:1668 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S262393AbVCJIQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 03:16:17 -0500
Date: Thu, 10 Mar 2005 11:16:10 +0300
From: Andrey Panin <pazke@donpac.ru>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch to enable the USB handoff on Dell 650
Message-ID: <20050310081610.GC9262@pazke>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20050201100241.07c6c504@localhost.localdomain> <20050202071847.GA786@pazke> <20050304121740.07a3af47@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304121740.07a3af47@localhost.localdomain>
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 063, 03 04, 2005 at 12:17:40 -0800, Pete Zaitcev wrote:
> On Wed, 2 Feb 2005 10:18:47 +0300 Andrey Panin <pazke@donpac.ru> wrote:
> 
> > > +++ linux-2.6.11-rc2-lem/arch/i386/kernel/dmi_scan.c	2005-01-31 20:42:16.163592792 -0800
> 
> > > +static __init int enable_usb_handoff(struct dmi_blacklist *d)
> > > +{
> 
> > Please don't add new quirks into dmi_scan.c. Use dmi_check_system()
> > where possible.
> 
> Do you have a suggestion for a good place where to add a suitable
> call for dmi_check_system for the USB handoff? Please observe that
> it does not belong with the USB code, in fact we have this code
> there already. It has to happen before any device drivers are
> initiated.
 
What about this patch ?

diff -urdpNX /usr/share/dontdiff linux-2.6.11.vanilla/drivers/pci/quirks.c linux-2.6.11/drivers/pci/quirks.c
--- linux-2.6.11.vanilla/drivers/pci/quirks.c	2005-03-02 10:37:31.000000000 +0300
+++ linux-2.6.11/drivers/pci/quirks.c	2005-03-10 10:45:19.000000000 +0300
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 
 #undef DEBUG
 
@@ -886,6 +887,40 @@ static int __init usb_handoff_early(char
 }
 __setup("usb-handoff", usb_handoff_early);
 
+static int __init enable_usb_handoff(struct dmi_system_id *d)
+{
+	/*
+	 * A printk is probably unnecessary. There's no way this causes
+	 * any harm (famous last words). But seriously, we only add systems
+	 * to the list if we know that they need handoff for sure.
+	 */
+	usb_early_handoff = 1;
+	return 0;
+}
+
+static __initdata struct dmi_system_id usb_handoff_dmi_table[] = {
+	/*
+	 *	Boxes which need USB taken over from BIOS explicitly.
+	 */
+	{
+		.callback = enable_usb_handoff,
+		.ident = "Dell PW650",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Precision WorkStation 650"),
+		},
+	}
+};
+
+static int __init usb_handoff_dmi_init(void)
+{
+	dmi_check_system(usb_handoff_dmi_table);
+	return 0;
+}
+
+core_initcall(usb_handoff_dmi_init);
+
+
 static void __devinit quirk_usb_handoff_uhci(struct pci_dev *pdev)
 {
 	unsigned long base = 0;

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net
