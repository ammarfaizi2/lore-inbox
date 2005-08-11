Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVHKCSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVHKCSU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 22:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVHKCSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 22:18:20 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:57758 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932212AbVHKCSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 22:18:20 -0400
Date: Wed, 10 Aug 2005 19:18:00 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, kiran@scalex86.org,
       BartlomiejZolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ide-disk.c oops caused by hwif == NULL
In-Reply-To: <1123685998.28913.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0508101912330.16655@schroedinger.engr.sgi.com>
References: <200508100459.j7A4xTn7016128@hera.kernel.org> 
 <Pine.LNX.4.62.0508101310300.18940@numbat.sonytel.be> 
 <Pine.LNX.4.62.0508100604020.12126@schroedinger.engr.sgi.com>
 <1123685998.28913.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to make sure to avoid all confusion. The title of this thread should 
be

"[PATCH] Fix ide-disk.c oops caused by hwif->pci_dev == NULL"
 
And this is the patch that was acknowledged by Andrew and that fixes the 
issue AFAIK. This patch needs to be included in 2.6.13. Lets make sure 
that we are all on the same page on this patch now:

---

From: Christoph Lameter <christoph@lameter.com>

There is one additional place where pcibus_to_node is used with the hwif
that we did not cover.

- Move hwif_to_node to ide.h

- Use hwif_to_node in ide-disk.c

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ide/ide-disk.c  |    2 +-
 drivers/ide/ide-probe.c |    9 ---------
 include/linux/ide.h     |    9 +++++++++
 3 files changed, 10 insertions(+), 10 deletions(-)

diff -puN drivers/ide/ide-disk.c~fix-ide-diskc-oops-caused-by-hwif-==-null drivers/ide/ide-disk.c
--- devel/drivers/ide/ide-disk.c~fix-ide-diskc-oops-caused-by-hwif-==-null	2005-08-09 20:16:45.000000000 -0700
+++ devel-akpm/drivers/ide/ide-disk.c	2005-08-09 20:16:45.000000000 -0700
@@ -1220,7 +1220,7 @@ static int ide_disk_probe(struct device 
 		goto failed;
 
 	g = alloc_disk_node(1 << PARTN_BITS,
-			pcibus_to_node(drive->hwif->pci_dev->bus));
+			hwif_to_node(drive->hwif));
 	if (!g)
 		goto out_free_idkp;
 
diff -puN drivers/ide/ide-probe.c~fix-ide-diskc-oops-caused-by-hwif-==-null drivers/ide/ide-probe.c
--- devel/drivers/ide/ide-probe.c~fix-ide-diskc-oops-caused-by-hwif-==-null	2005-08-09 20:16:45.000000000 -0700
+++ devel-akpm/drivers/ide/ide-probe.c	2005-08-09 20:16:45.000000000 -0700
@@ -960,15 +960,6 @@ static void save_match(ide_hwif_t *hwif,
 }
 #endif /* MAX_HWIFS > 1 */
 
-static inline int hwif_to_node(ide_hwif_t *hwif)
-{
-	if (hwif->pci_dev)
-		return pcibus_to_node(hwif->pci_dev->bus);
-	else
-		/* Add ways to determine the node of other busses here */
-		return -1;
-}
-
 /*
  * init request queue
  */
diff -puN include/linux/ide.h~fix-ide-diskc-oops-caused-by-hwif-==-null include/linux/ide.h
--- devel/include/linux/ide.h~fix-ide-diskc-oops-caused-by-hwif-==-null	2005-08-09 20:16:45.000000000 -0700
+++ devel-akpm/include/linux/ide.h	2005-08-09 20:16:45.000000000 -0700
@@ -1501,4 +1501,13 @@ extern struct bus_type ide_bus_type;
 #define ide_id_has_flush_cache_ext(id)	\
 	(((id)->cfs_enable_2 & 0x2400) == 0x2400)
 
+static inline int hwif_to_node(ide_hwif_t *hwif)
+{
+	if (hwif->pci_dev)
+		return pcibus_to_node(hwif->pci_dev->bus);
+	else
+		/* Add ways to determine the node of other busses here */
+		return -1;
+}
+
 #endif /* _IDE_H */
_
