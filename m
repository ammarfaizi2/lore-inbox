Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbQLEQft>; Tue, 5 Dec 2000 11:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQLEQf3>; Tue, 5 Dec 2000 11:35:29 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:9220 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S129183AbQLEQfZ>; Tue, 5 Dec 2000 11:35:25 -0500
Date: Tue, 5 Dec 2000 18:49:08 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matt_Domsch@Dell.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_read_bases trivial fixup
Message-ID: <20001205184908.A22920@jurassic.park.msu.ru>
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9A32@ausxmrr501.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9A32@ausxmrr501.us.dell.com>; from Matt_Domsch@Dell.com on Tue, Dec 05, 2000 at 07:55:58AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 07:55:58AM -0600, Matt_Domsch@Dell.com wrote:
> In -test11, tmp was declared.  Somehow by 12-pre4, it got lost.  This puts
> it back.  It's needed in the BITS_PER_LONG == 64 case.

BITS_PER_LONG == 64 case is broken anyway.
Better fix would be

--- linux/drivers/pci/pci.c.orig	Mon Dec  4 12:49:28 2000
+++ linux/drivers/pci/pci.c	Tue Dec  5 18:30:45 2000
@@ -573,10 +573,10 @@ static void pci_read_bases(struct pci_de
 			res->start |= ((unsigned long) l) << 32;
 			res->end = res->start + sz;
 			pci_write_config_dword(dev, reg+4, ~0);
-			pci_read_config_dword(dev, reg+4, &tmp);
+			pci_read_config_dword(dev, reg+4, &sz);
 			pci_write_config_dword(dev, reg+4, l);
-			if (l)
-				res->end = res->start + (((unsigned long) ~l) << 32);
+			if (sz)
+				res->end = res->start + (((unsigned long) ~sz) << 32);
 #else
 			if (l) {
 				printk(KERN_ERR "PCI: Unable to handle 64-bit address for device %s\n", dev->slot_name);


Ivan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
