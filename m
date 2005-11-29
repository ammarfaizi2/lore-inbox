Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVK2WPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVK2WPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 17:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVK2WPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 17:15:15 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:64743 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964780AbVK2WPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 17:15:14 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] add boot option to control Intel combined mode behavior (to allow DMA in combined mode configs!)
Date: Tue, 29 Nov 2005 14:15:06 -0800
User-Agent: KMail/1.8.92
Cc: linux-kernel@vger.kernel.org
References: <200511282306.38515.jbarnes@virtuousgeek.org> <438CCE0D.7090304@pobox.com>
In-Reply-To: <438CCE0D.7090304@pobox.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rLNjDkl9lvqh1Vx"
Message-Id: <200511291415.07306.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_rLNjDkl9lvqh1Vx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, November 29, 2005 1:54 pm, Jeff Garzik wrote:
> Seems like it should work.  I presume you tested this?

Yep, worked like a charm.  As it stands, I can't play DVDs on my laptop, 
but with this patch I can set combined_mode=libata and 
libata.atapi_enabled=1 and DVDs are no longer choppy.  It's great!

> Remove the 'intel_' prefix from the kernel parameter, since this
> concept applies to other controllers as well.  Otherwise, seems OK.

Ok, how does this one look?

Thanks,
Jesse

Combined mode sucks.  Especially when both libata and the legacy IDE 
drivers try to drive ports on the same device, since that makes DMA 
rather difficult.

This patch addresses the problem by allowing the user to control which 
driver binds to the ports in a combined mode configuration.  In many 
cases, they'll probably want the libata driver to control both ports 
since it can use DMA for talking with ATAPI devices (when 
libata.atapi_enabled=1 of course).  It also allows the user to get old 
school behavior by letting the legacy IDE driver bind to both ports.  
But neither is forced, the patch doesn't change current behavior unless 
one of combined_mode=ide or combined_mode=libata is passed 
on the boot line.  Either of those options may require you to access 
your devices via different device nodes (/dev/hd* in the ide case 
and /dev/sd* in the libata case), though of course if you have udev 
installed nicely you may not notice anything. :)

Let me know if the documentation is too cryptic, I'd be happy to expand 
on it if necessary.  I think most users will want to boot with 
'combined_mode=libata' and add 'options libata atapi_enabled=1' 
to their modules.conf to get good DVD playing and disk behavior 
(haven't tested CD or DVD writing though).

I'd much rather things behave sanely by default (i.e. DMA for devices on 
both ports), but apparently that's difficult given the various chip 
bugs and hardware configs out there (not to mention that people's 
drives may suddenly change from /dev/hdc to /dev/sdb), so this boot 
option may be the correct long term fix.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

--Boundary-00=_rLNjDkl9lvqh1Vx
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="combined-mode-boot-option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="combined-mode-boot-option.patch"

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 5dffcfe..61a56b1 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -633,6 +633,14 @@ running once the system is up.
 	inport.irq=	[HW] Inport (ATI XL and Microsoft) busmouse driver
 			Format: <irq>
 
+	combined_mode=	[HW] control which driver uses IDE ports in combined
+			mode: legacy IDE driver, libata, or both
+			(in the libata case, libata.atapi_enabled=1 may be
+			useful as well).  Note that using the ide or libata
+			options may affect your device naming (e.g. by
+			changing hdc to sdb).
+			Format: combined (default), ide, or libata
+
 	inttest=	[IA64]
 
 	io7=		[HW] IO7 for Marvel based alpha systems
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3a4f49f..f28ebdd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1098,6 +1098,23 @@ static void __init quirk_alder_ioapic(st
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic );
 #endif
 
+enum ide_combined_type { COMBINED = 0, IDE = 1, LIBATA = 2 };
+/* Defaults to combined */
+static enum ide_combined_type combined_mode;
+
+static int __init combined_setup(char *str)
+{
+	if (!strncmp(str, "ide", 3))
+		combined_mode = IDE;
+	else if (!strncmp(str, "libata", 6))
+		combined_mode = LIBATA;
+	else /* "combined" or anything else defaults to old behavior */
+		combined_mode = COMBINED;
+
+	return 1;
+}
+__setup("combined_mode=", combined_setup);
+
 #ifdef CONFIG_SCSI_SATA_INTEL_COMBINED
 static void __devinit quirk_intel_ide_combined(struct pci_dev *pdev)
 {
@@ -1164,6 +1181,19 @@ static void __devinit quirk_intel_ide_co
 	if (prog & comb)
 		return;
 
+	/* Don't reserve any so the IDE driver can get them (but only if
+	 * combined_mode=ide).
+	 */
+	if (combined_mode == IDE)
+		return;
+
+	/* Grab them both for libata if combined_mode=libata. */
+	if (combined_mode == LIBATA) {
+		request_region(0x1f0, 8, "libata");	/* port 0 */
+		request_region(0x170, 8, "libata");	/* port 1 */
+		return;
+	}
+
 	/* SATA port is in legacy mode.  Reserve port so that
 	 * IDE driver does not attempt to use it.  If request_region
 	 * fails, it will be obvious at boot time, so we don't bother

--Boundary-00=_rLNjDkl9lvqh1Vx--
