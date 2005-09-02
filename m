Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbVIBVpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbVIBVpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161068AbVIBVpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:45:42 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:16518 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1161063AbVIBVpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:45:07 -0400
Date: Fri, 2 Sep 2005 23:44:55 +0200
Message-Id: <200509022144.j82LitTO031347@wscnet.wsc.cz>
In-reply-to: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Subject: [PATCH 5/6] include, sound: pci_find_device remove (s/pci/cs46xx/cs46xx_lib.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, alsa-devel@alsa-project.org,
       perex@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Generated in 2.6.13-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 include/sound/cs46xx.h        |    1 -
 sound/pci/cs46xx/cs46xx_lib.c |   13 +++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/sound/cs46xx.h b/include/sound/cs46xx.h
--- a/include/sound/cs46xx.h
+++ b/include/sound/cs46xx.h
@@ -1715,7 +1715,6 @@ struct _snd_cs46xx {
 	void (*active_ctrl)(cs46xx_t *, int);
   	void (*mixer_init)(cs46xx_t *);
 
-	struct pci_dev *acpi_dev;
 	int acpi_port;
 	snd_kcontrol_t *eapd_switch; /* for amplifier hack */
 	int accept_valid;	/* accept mmap valid (for OSS) */
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -3548,7 +3548,7 @@ static void clkrun_hack(cs46xx_t *chip, 
 {
 	u16 control, nval;
 	
-	if (chip->acpi_dev == NULL)
+	if (!chip->acpi_port)
 		return;
 
 	chip->amplifier += change;
@@ -3571,15 +3571,20 @@ static void clkrun_hack(cs46xx_t *chip, 
  */
 static void clkrun_init(cs46xx_t *chip)
 {
+	struct pci_dev *pdev;
 	u8 pp;
 
-	chip->acpi_dev = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
-	if (chip->acpi_dev == NULL)
+	chip->acpi_port = 0;
+	
+	pdev = pci_get_device(PCI_VENDOR_ID_INTEL,
+		PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
+	if (pdev == NULL)
 		return;		/* Not a thinkpad thats for sure */
 
 	/* Find the control port */		
-	pci_read_config_byte(chip->acpi_dev, 0x41, &pp);
+	pci_read_config_byte(pdev, 0x41, &pp);
 	chip->acpi_port = pp << 8;
+	pci_dev_put(pdev);
 }
 
 
