Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUCOJdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 04:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbUCOJdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 04:33:07 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41424 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262468AbUCOJdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 04:33:02 -0500
Date: Mon, 15 Mar 2004 10:32:56 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, mjander@embedded.cl, perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [patch] 2.6.4-mm2: ALSA au88x0.c doesn't compile with gcc 2.95
Message-ID: <20040315093256.GS14833@fs.tum.de>
References: <20040314172809.31bd72f7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314172809.31bd72f7.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following compile error with gcc 2.95 comes from Linus' tree:

<--  snip  -->

...
  CC      sound/pci/au88x0/au8810.o
In file included from sound/pci/au88x0/au8810.c:17:
sound/pci/au88x0/au88x0.c: In function `snd_vortex_workaround':
sound/pci/au88x0/au88x0.c:89: parse error before `int'
sound/pci/au88x0/au88x0.c:93: `rc' undeclared (first use in this function)
sound/pci/au88x0/au88x0.c:93: (Each undeclared identifier is reported only once
sound/pci/au88x0/au88x0.c:93: for each function it appears in.)
make[3]: *** [sound/pci/au88x0/au8810.o] Error 1

<--  snip  -->


gcc 2.95 doesn't allow declarations mixed with code.

The fix is simple:

--- linux-2.6.4-mm2-full/sound/pci/au88x0/au88x0.c.old	2004-03-15 10:26:56.000000000 +0100
+++ linux-2.6.4-mm2-full/sound/pci/au88x0/au88x0.c	2004-03-15 10:27:32.000000000 +0100
@@ -71,6 +71,8 @@
 static void __devinit snd_vortex_workaround(struct pci_dev *vortex, int fix)
 {
 	struct pci_dev *via = NULL;
+	int rc;
+
 	/* autodetect if workarounds are required */
 	while ((via = pci_find_device(PCI_VENDOR_ID_VIA,
 				      PCI_DEVICE_ID_VIA_8365_1, via))) {
@@ -86,8 +88,6 @@
 	if (fix == 255)
 		return;
 
-	int rc;
-
 	/* fix vortex latency */
 	if (fix & 0x01) {
 		if (!(rc = pci_write_config_byte(vortex, 0x40, 0xff))) {


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

