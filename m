Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWAZWtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWAZWtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWAZWtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:49:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60934 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964970AbWAZWtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:49:13 -0500
Date: Thu, 26 Jan 2006 23:49:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [4/10] remove ISA legacy functions: drivers/scsi/in2000.c
Message-ID: <20060126224911.GH3668@stusta.de>
References: <20060126223126.GD3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126223126.GD3668@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

switched to ioremap(), cleaned the probing up a bit.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

