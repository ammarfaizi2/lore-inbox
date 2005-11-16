Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbVKPDvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbVKPDvA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbVKPDus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:50:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:28318 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965226AbVKPDuh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:50:37 -0500
To: torvalds@osdl.org
Subject: [PATCH 4/8] isaectomy: in2000
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Message-Id: <E1EcEJh-0007dw-8i@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 16 Nov 2005 03:50:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1132110514 -0500

switched to ioremap(), cleaned the probing up a bit.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 drivers/scsi/in2000.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

e44467683e39fd741741d07d49515e3b20e3e104
diff --git a/drivers/scsi/in2000.c b/drivers/scsi/in2000.c
--- a/drivers/scsi/in2000.c
+++ b/drivers/scsi/in2000.c
@@ -1898,6 +1898,21 @@ static int int_tab[] in2000__INITDATA = 
 	10
 };
 
+static int probe_bios(u32 addr, u32 *s1, uchar *switches)
+{
+	void __iomem *p = ioremap(addr, 0x34);
+	if (!p)
+		return 0;
+	*s1 = readl(p + 0x10);
+	if (*s1 == 0x41564f4e || readl(p + 0x30) == 0x61776c41) {
+		/* Read the switch image that's mapped into EPROM space */
+		*switches = ~readb(p + 0x20);
+		iounmap(p);
+		return 1;
+	}
+	iounmap(p);
+	return 0;
+}
 
 static int __init in2000_detect(struct scsi_host_template * tpnt)
 {
@@ -1930,6 +1945,7 @@ static int __init in2000_detect(struct s
 
 	detect_count = 0;
 	for (bios = 0; bios_tab[bios]; bios++) {
+		u32 s1 = 0;
 		if (check_setup_args("ioport", &val, buf)) {
 			base = val;
 			switches = ~inb(base + IO_SWITCHES) & 0xff;
@@ -1941,13 +1957,9 @@ static int __init in2000_detect(struct s
  * for the obvious ID strings. We look for the 2 most common ones and
  * hope that they cover all the cases...
  */
-		else if (isa_readl(bios_tab[bios] + 0x10) == 0x41564f4e || isa_readl(bios_tab[bios] + 0x30) == 0x61776c41) {
+		else if (probe_bios(bios_tab[bios], &s1, &switches)) {
 			printk("Found IN2000 BIOS at 0x%x ", (unsigned int) bios_tab[bios]);
 
-/* Read the switch image that's mapped into EPROM space */
-
-			switches = ~((isa_readb(bios_tab[bios] + 0x20) & 0xff));
-
 /* Find out where the IO space is */
 
 			x = switches & (SW_ADDR0 | SW_ADDR1);
@@ -2037,7 +2049,7 @@ static int __init in2000_detect(struct s
 
 /* Older BIOS's had a 'sync on/off' switch - use its setting */
 
-		if (isa_readl(bios_tab[bios] + 0x10) == 0x41564f4e && (switches & SW_SYNC_DOS5))
+		if (s1 == 0x41564f4e && (switches & SW_SYNC_DOS5))
 			hostdata->sync_off = 0x00;	/* sync defaults to on */
 		else
 			hostdata->sync_off = 0xff;	/* sync defaults to off */

