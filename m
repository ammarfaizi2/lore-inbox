Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbVIBVqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbVIBVqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161068AbVIBVpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:45:43 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:17798 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1161062AbVIBVpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:45:02 -0400
Date: Fri, 2 Sep 2005 23:44:55 +0200
Message-Id: <200509022144.j82LitUL031342@wscnet.wsc.cz>
In-reply-to: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Subject: [PATCH 2/6] include, sound: pci_find_device remove (s/core/memalloc.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, alsa-devel@alsa-project.org,
       perex@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Generated in 2.6.13-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 memalloc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -567,8 +567,8 @@ static int snd_mem_proc_write(struct fil
 		char *endp;
 		int vendor, device, size, buffers;
 		long mask;
-		int i, alloced;
-		struct pci_dev *pci;
+		int i, alloced = 0;
+		struct pci_dev *pci = NULL;
 
 		if ((token = gettoken(&p)) == NULL ||
 		    (vendor = simple_strtol(token, NULL, 0)) <= 0 ||
@@ -588,13 +588,12 @@ static int snd_mem_proc_write(struct fil
 		vendor &= 0xffff;
 		device &= 0xffff;
 
-		alloced = 0;
-		pci = NULL;
-		while ((pci = pci_find_device(vendor, device, pci)) != NULL) {
+		while ((pci = pci_get_device(vendor, device, pci)) != NULL) {
 			if (mask > 0 && mask < 0xffffffff) {
 				if (pci_set_dma_mask(pci, mask) < 0 ||
 				    pci_set_consistent_dma_mask(pci, mask) < 0) {
 					printk(KERN_ERR "snd-page-alloc: cannot set DMA mask %lx for pci %04x:%04x\n", mask, vendor, device);
+					pci_dev_put(pci);
 					return (int)count;
 				}
 			}
@@ -604,6 +603,7 @@ static int snd_mem_proc_write(struct fil
 				if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 							size, &dmab) < 0) {
 					printk(KERN_ERR "snd-page-alloc: cannot allocate buffer pages (size = %d)\n", size);
+					pci_dev_put(pci);
 					return (int)count;
 				}
 				snd_dma_reserve_buf(&dmab, snd_dma_pci_buf_id(pci));
