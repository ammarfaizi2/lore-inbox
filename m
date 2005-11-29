Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVK2HGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVK2HGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 02:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVK2HGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 02:06:52 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:13485 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751333AbVK2HGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 02:06:51 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] add boot option to control Intel combined mode behavior (to allow DMA in combined mode configs!)
Date: Mon, 28 Nov 2005 23:06:38 -0800
User-Agent: KMail/1.8.92
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+3/iDCfyPzrkZYO"
Message-Id: <200511282306.38515.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_+3/iDCfyPzrkZYO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

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
one of intel_combined_mode=ide or intel_combined_mode=libata is passed 
on the boot line.  Either of those options may require you to access 
your devices via different device nodes (/dev/hd* in the ide case 
and /dev/sd* in the libata case), though of course if you have udev 
installed nicely you may not notice anything. :)

Let me know if the documentation is too cryptic, I'd be happy to expand 
on it if necessary.  I think most users will want to boot with 
'intel_combined_mode=libata' and add 'options libata atapi_enabled=1' 
to their modules.conf to get good DVD playing and disk behavior 
(haven't tested CD or DVD writing though).

 Documentation/kernel-parameters.txt |    7 +++++++
 drivers/pci/quirks.c                |   30 ++++++++++++++++++++++++++++

I'd much rather things behave sanely by default (i.e. DMA for devices on 
both ports), but apparently that's difficult given the various chip 
bugs and hardware configs out there (not to mention that people's 
drives may suddenly change from /dev/hdc to /dev/sdb), so this boot 
option may be the correct long term fix.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

Thanks,
Jesse

--Boundary-00=_+3/iDCfyPzrkZYO
Content-Type: text/x-diff;
  charset="us-ascii";
  name="intel-combined-mode-boot-option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="intel-combined-mode-boot-option.patch"

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 5dffcfe..5f8104f 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -633,6 +633,13 @@ running once the system is up.
 	inport.irq=	[HW] Inport (ATI XL and Microsoft) busmouse driver
 			Format: <irq>
 
+	intel_combined_mode=
+			[HW] control which driver uses IDE ports in combined
+			mode, legacy IDE driver, both or libata exclusively
+			(in the latter case, libata.atapi_enabled=1 may be
+			useful as well)
+			Format: ide,combined,libata
+
 	inttest=	[IA64]
 
 	io7=		[HW] IO7 for Marvel based alpha systems
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3a4f49f..9be5ae0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1099,6 +1099,23 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
 #endif
 
 #ifdef CONFIG_SCSI_SATA_INTEL_COMBINED
+enum ide_combined_type { COMBINED = 0, IDE = 1, LIBATA = 2 };
+/* Defaults to combined */
+static enum ide_combined_type intel_combined_mode_type;
+
+static int __init intel_ide_combined_setup(char *str)
+{
+	if (!strncmp(str, "ide", 3))
+		intel_combined_mode_type = IDE;
+	else if (!strncmp(str, "libata", 6))
+		intel_combined_mode_type = LIBATA;
+	else /* "combined" or anything else defaults to old behavior */
+		intel_combined_mode_type = COMBINED;
+
+	return 1;
+}
+__setup("intel_combined_mode=", intel_ide_combined_setup);
+
 static void __devinit quirk_intel_ide_combined(struct pci_dev *pdev)
 {
 	u8 prog, comb, tmp;
@@ -1164,6 +1181,19 @@ static void __devinit quirk_intel_ide_co
 	if (prog & comb)
 		return;
 
+	/* Don't reserve any so the IDE driver can get them (but only if
+	 * intel_combined_mode=ide).
+	 */
+	if (intel_combined_mode_type == IDE)
+		return;
+
+	/* Grab them both for libata if intel_combined_mode=libata. */
+	if (intel_combined_mode_type == LIBATA) {
+		request_region(0x1f0, 8, "libata");	/* port 0 */
+		request_region(0x170, 8, "libata");	/* port 1 */
+		return;
+	}
+
 	/* SATA port is in legacy mode.  Reserve port so that
 	 * IDE driver does not attempt to use it.  If request_region
 	 * fails, it will be obvious at boot time, so we don't bother

--Boundary-00=_+3/iDCfyPzrkZYO--
