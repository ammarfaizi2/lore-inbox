Return-Path: <linux-kernel-owner+w=401wt.eu-S1750837AbXACPom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbXACPom (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbXACPom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:44:42 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:43776 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbXACPol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:44:41 -0500
X-Originating-Ip: 74.109.98.100
Date: Wed, 3 Jan 2007 10:39:29 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Get rid of "double zeroing" of allocated pages
Message-ID: <Pine.LNX.4.64.0701031033470.27478@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.244, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, SARE_SUB_GETRID 0.56)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Simplify the few instances where a call to "get_zeroed_page()" is
closely followed by an unnecessary call to memset() to clear that
page.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  there appeared to be only three of these in the tree, and i'm not
quite sure about the instance in drivers/scsi/53c7xx.c, since that
snippet of code allocates a zeroed page, but calls memset() with a
hardcoded size of 4096.  not sure what *that's* all about, so maybe i
shouldn't be messing with it.


 drivers/atm/eni.c                  |    1 -
 drivers/media/video/zoran_driver.c |    1 -
 drivers/scsi/53c7xx.c              |    1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index 5aab7bd..8fccf01 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -912,7 +912,6 @@ static int start_rx(struct atm_dev *dev)
 		free_page((unsigned long) eni_dev->free_list);
 		return -ENOMEM;
 	}
-	memset(eni_dev->rx_map,0,PAGE_SIZE);
 	eni_dev->rx_mult = DEFAULT_RX_MULT;
 	eni_dev->fast = eni_dev->last_fast = NULL;
 	eni_dev->slow = eni_dev->last_slow = NULL;
diff --git a/drivers/media/video/zoran_driver.c b/drivers/media/video/zoran_driver.c
index 862a984..e10a9ee 100644
--- a/drivers/media/video/zoran_driver.c
+++ b/drivers/media/video/zoran_driver.c
@@ -562,7 +562,6 @@ jpg_fbuffer_alloc (struct file *file)
 			jpg_fbuffer_free(file);
 			return -ENOBUFS;
 		}
-		memset((void *) mem, 0, PAGE_SIZE);
 		fh->jpg_buffers.buffer[i].frag_tab = (u32 *) mem;
 		fh->jpg_buffers.buffer[i].frag_tab_bus =
 		    virt_to_bus((void *) mem);
diff --git a/drivers/scsi/53c7xx.c b/drivers/scsi/53c7xx.c
index 640536e..9c37943 100644
--- a/drivers/scsi/53c7xx.c
+++ b/drivers/scsi/53c7xx.c
@@ -3099,7 +3099,6 @@ allocate_cmd (Scsi_Cmnd *cmd) {
         real = get_zeroed_page(GFP_ATOMIC);
         if (real == 0)
         	return NULL;
-        memset((void *)real, 0, 4096);
         cache_push(virt_to_phys((void *)real), 4096);
         cache_clear(virt_to_phys((void *)real), 4096);
         kernel_set_cachemode((void *)real, 4096, IOMAP_NOCACHE_SER);
