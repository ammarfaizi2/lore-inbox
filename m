Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264483AbTDXVh4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbTDXVh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:37:56 -0400
Received: from kathmandu.sun.com ([192.18.98.36]:43683 "EHLO kathmandu.sun.com")
	by vger.kernel.org with ESMTP id S264483AbTDXVhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:37:52 -0400
Message-ID: <3EA85C5C.7060402@sun.com>
Date: Thu, 24 Apr 2003 14:51:24 -0700
From: Duncan Laurie <duncan@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Olivier Bornet <Olivier.Bornet@puck.ch>
Subject: Re: problem with Serverworks CSB5 IDE
References: <20030423212713.GD21689@puck.ch> <1051136469.2062.108.camel@dhcp22.swansea.linux.org.uk> <20030423232909.GE21689@puck.ch> <20030423232909.GE21689@puck.ch> <20030424080023.GG21689@puck.ch>
In-Reply-To: <20030424080023.GG21689@puck.ch>
Content-Type: multipart/mixed;
 boundary="------------090702040006030002030303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090702040006030002030303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Olivier Bornet wrote:
> Hi all,
> 
> I reply to myself, after having test this solution.
> 
> 
>>At this time, I have compiled and installed a 2.4.20-ac2 + some cobalt
>>patches. Is the bug also fixed in 2.4.20-ac2, or must I rebuild the
>>2.4.20 with the check commented out ?
> 
> 
> The 2.4.20-ac2 patched kernel help a little : the system don't crash
> anymore. But the disk is marked as defective, and is removed from the
> raid1 metadevice.
> 
> One other problem with the -ac2 is the speed for the rebuild : it seems
> to be 2 times slower than with the Ducan patch. (about 2 hours instead
> of 1 hour).
> 
> So, my solution is to use the patch from Ducan. I hope it (or a
> derivative form of it) will be included in the next kernel releases.
> 
> Good day, and thanks all for the help.
>

Here is a 2.4.21-rc1 version of the patch, with a few modificaions
due to the changes in IDE..

Actually UDMA mode detection is not working at all for CSB5 in
2.4.21-rc1 because svwks_revision variable is set in __init function
so was reading as 0 in svwks_ratemask().  This made it think UDMA
mode 2 was the max supported, when in reality new revisions do UDMA
mode 5 and old revisions are mode 4 max.

The bad_ata100 list has been extended to include the whole family
of Barracuda ATA IV drives; we only shipped the 80gb and 40gb models
from that series so the others were not listed before.

-duncan

--------------090702040006030002030303
Content-Type: text/plain;
 name="serverworks-2.4.21-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serverworks-2.4.21-rc1.diff"

diff -ruN linux-2.4.21-rc1.orig/drivers/ide/pci/serverworks.c linux-2.4.21-rc1/drivers/ide/pci/serverworks.c
--- linux-2.4.21-rc1.orig/drivers/ide/pci/serverworks.c	Thu Apr 24 14:16:28 2003
+++ linux-2.4.21-rc1/drivers/ide/pci/serverworks.c	Thu Apr 24 14:41:26 2003
@@ -203,11 +203,22 @@
 }
 #endif  /* defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS) */
 
+static int check_in_drive_lists (ide_drive_t *drive, const char **list)
+{
+	while (*list)
+		if (!strcmp(*list++, drive->id->model))
+			return 1;
+	return 0;
+}
+
 static u8 svwks_ratemask (ide_drive_t *drive)
 {
 	struct pci_dev *dev     = HWIF(drive)->pci_dev;
 	u8 mode;
 
+	if (!svwks_revision)
+		pci_read_config_byte(dev, PCI_REVISION_ID, &svwks_revision);
+
 	if (dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
 		u32 reg = 0;
 		if (isa_dev)
@@ -221,13 +232,15 @@
 		/* Check the OSB4 DMA33 enable bit */
 		return ((reg & 0x00004000) == 0x00004000) ? 1 : 0;
 	} else if (svwks_revision < SVWKS_CSB5_REVISION_NEW) {
-		return 1;
+		return 2;
 	} else if (svwks_revision >= SVWKS_CSB5_REVISION_NEW) {
 		u8 btr = 0;
 		pci_read_config_byte(dev, 0x5A, &btr);
-		mode = btr;
+		mode = btr & 0x3;
 		if (!eighty_ninty_three(drive))
 			mode = min(mode, (u8)1);
+		if (mode == 3 && check_in_drive_lists(drive, svwks_bad_ata100))
+			mode = 2;
 	}
 	if (((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
 	     (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) &&
diff -ruN linux-2.4.21-rc1.orig/drivers/ide/pci/serverworks.h linux-2.4.21-rc1/drivers/ide/pci/serverworks.h
--- linux-2.4.21-rc1.orig/drivers/ide/pci/serverworks.h	Thu Apr 24 14:16:28 2003
+++ linux-2.4.21-rc1/drivers/ide/pci/serverworks.h	Thu Apr 24 14:41:41 2003
@@ -11,6 +11,16 @@
 #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
 #define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
 
+/* Seagate Barracuda ATA IV Family drives in UDMA mode 5
+ * can overrun their FIFOs when used with the CSB5 */
+const char *svwks_bad_ata100[] = {
+	"ST320011A",
+	"ST340016A",
+	"ST360021A",
+	"ST380021A",
+	NULL
+};
+
 #define DISPLAY_SVWKS_TIMINGS	1
 
 #if defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS)

--------------090702040006030002030303--

