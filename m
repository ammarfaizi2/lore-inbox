Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVCLPdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVCLPdj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 10:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVCLPdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 10:33:39 -0500
Received: from av3-1-sn4.m-sp.skanova.net ([81.228.10.114]:12488 "EHLO
	av3-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261939AbVCLPct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:32:49 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DVD-RAM support for pktcdvd
From: Peter Osterlund <petero2@telia.com>
Date: 12 Mar 2005 16:32:45 +0100
Message-ID: <m31xak98wy.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it possible to use the packet writing driver with
DVD-RAM discs. The pktcdvd driver is not needed for writing to DVD-RAM
discs but it can improve write performance. Polgár István reports:

	I wrote 178716Kb data to DVD-RAM without pktcdvd driver within
	4.54 minutes. With pktcdvd driver it took me 2.33 minutes.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/Documentation/cdrom/packet-writing.txt |    8 ++++++++
 linux-petero/drivers/block/pktcdvd.c                |    9 +++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-dvd-ram drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-dvd-ram	2005-03-11 22:24:02.000000000 +0100
+++ linux-petero/drivers/block/pktcdvd.c	2005-03-11 22:24:02.000000000 +0100
@@ -1421,8 +1421,8 @@ static int pkt_set_write_settings(struct
 	char buffer[128];
 	int ret, size;
 
-	/* doesn't apply to DVD+RW */
-	if (pd->mmc3_profile == 0x1a)
+	/* doesn't apply to DVD+RW or DVD-RAM */
+	if ((pd->mmc3_profile == 0x1a) || (pd->mmc3_profile == 0x12))
 		return 0;
 
 	memset(buffer, 0, sizeof(buffer));
@@ -1536,6 +1536,7 @@ static int pkt_good_disc(struct pktcdvd_
 			break;
 		case 0x1a: /* DVD+RW */
 		case 0x13: /* DVD-RW */
+		case 0x12: /* DVD-RAM */
 			return 0;
 		default:
 			printk("pktcdvd: Wrong disc profile (%x)\n", pd->mmc3_profile);
@@ -1601,6 +1602,9 @@ static int pkt_probe_settings(struct pkt
 		case 0x13: /* DVD-RW */
 			printk("pktcdvd: inserted media is DVD-RW\n");
 			break;
+		case 0x12: /* DVD-RAM */
+			printk("pktcdvd: inserted media is DVD-RAM\n");
+			break;
 		default:
 			printk("pktcdvd: inserted media is CD-R%s\n", di.erasable ? "W" : "");
 			break;
@@ -1893,6 +1897,7 @@ static int pkt_open_write(struct pktcdvd
 	switch (pd->mmc3_profile) {
 		case 0x13: /* DVD-RW */
 		case 0x1a: /* DVD+RW */
+		case 0x12: /* DVD-RAM */
 			DPRINTK("pktcdvd: write speed %ukB/s\n", write_speed);
 			break;
 		default:
diff -puN Documentation/cdrom/packet-writing.txt~packet-dvd-ram Documentation/cdrom/packet-writing.txt
--- linux/Documentation/cdrom/packet-writing.txt~packet-dvd-ram	2005-03-11 22:24:02.000000000 +0100
+++ linux-petero/Documentation/cdrom/packet-writing.txt	2005-03-11 22:24:02.000000000 +0100
@@ -62,6 +62,14 @@ generates aligned writes.
 	# mount /dev/pktcdvd/dev_name /cdrom -t udf -o rw,noatime
 
 
+Packet writing for DVD-RAM media
+--------------------------------
+
+DVD-RAM discs are random writable, so using the pktcdvd driver is not
+necessary. However, using the pktcdvd driver can improve performance
+in the same way it does for DVD+RW media.
+
+
 Notes
 -----
 
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
