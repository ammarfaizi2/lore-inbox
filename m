Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVHIN1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVHIN1d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbVHIN1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:27:33 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:26287 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S932541AbVHIN1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:27:32 -0400
Date: Tue, 9 Aug 2005 15:27:26 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: christoph@lameter.com
Cc: linux-kernel@vger.kernel.org, b.zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH] ide-disk oopses on boot
Message-ID: <20050809132725.GA20397@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,
  back in June your '[PATCH] NUMA aware block device control structure 
allocation' patch went in, changing ide-disk.c's code:

-   g = alloc_disk(1 << PARTN_BITS);
+   g = alloc_disk_node(1 << PARTN_BITS,
+                       pcibus_to_node(drive->hwif->pci_dev->bus));

  Problem is that pci_dev may be NULL - and it is NULL for example with
kernel I've just built, with amd IDE driver built as a module while with
ide-disk built into the kernel.

  I think that you probably want to guard your code by 
'if (drive->hwif->pci_dev)', as besides my silly configuration mistake 
also ISA devices have a chance to have pci_dev NULL.  Not that there are 
any such users if nobody hit it in the last 6 weeks...

  I've just built amd IDE driver into the kernel, where it belongs anyway,
but just in case please apply this patch...
						Thanks,
							Petr Vandrovec


Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>

--- linux-2.6.13-rc6-00dd.dist/drivers/ide/ide-disk.c	2005-08-09 13:14:26.000000000 +0200
+++ linux-2.6.13-rc6-00dd/drivers/ide/ide-disk.c	2005-08-09 15:11:51.000000000 +0200
@@ -1219,8 +1219,12 @@
 	if (!idkp)
 		goto failed;
 
-	g = alloc_disk_node(1 << PARTN_BITS,
-			pcibus_to_node(drive->hwif->pci_dev->bus));
+	if (drive->hwif->pci_dev) {
+		g = alloc_disk_node(1 << PARTN_BITS,
+				pcibus_to_node(drive->hwif->pci_dev->bus));
+	} else {
+		g = alloc_disk(1 << PARTN_BITS);
+	}
 	if (!g)
 		goto out_free_idkp;
 


