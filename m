Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLAMdy>; Fri, 1 Dec 2000 07:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQLAMdp>; Fri, 1 Dec 2000 07:33:45 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:3076 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S129210AbQLAMd3>; Fri, 1 Dec 2000 07:33:29 -0500
Date: Fri, 1 Dec 2000 14:56:19 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Phillip Ezolt <ezolt@perf.zko.dec.com>, axp-list@redhat.com,
        rth@twiddle.net, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, clinux@zk3.dec.com,
        wcarr@perf.zko.dec.com
Subject: Re: Alpha SCSI error on 2.4.0-test11
Message-ID: <20001201145619.A553@jurassic.park.msu.ru>
In-Reply-To: <20001201004049.A980@jurassic.park.msu.ru> <Pine.OSF.3.96.1001130171941.32335D-100000@perf.zko.dec.com> <20001130233742.A21823@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001130233742.A21823@athlon.random>; from andrea@suse.de on Thu, Nov 30, 2000 at 11:37:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 11:37:42PM +0100, Andrea Arcangeli wrote:
> test12-pre2 crashes at boot on my DS20. This patch workaround the problem
> but I would be _very_ surprised if this is the right fix :) It's obviously not
> meant for inclusion.
...
> -			struct resource_list *ln = list->next;
> +			struct resource_list *ln;
>  
> +			if (!list)
> +				return;
> +			ln = list->next;

Argh. I believe that crash could happen only if some broken device has
empty I/O or memory range and IORESOURCE_[IO,MEM] bit set.

Andrea, could you try this?

Ivan.

--- linux/drivers/pci/setup-res.c~	Thu Nov 30 12:14:31 2000
+++ linux/drivers/pci/setup-res.c	Fri Dec  1 13:49:34 2000
@@ -136,6 +136,7 @@ pdev_sort_resources(struct pci_dev *dev,
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *r;
 		struct resource_list *list, *tmp;
+		unsigned long r_size;
 
 		/* PCI-PCI bridges may have I/O ports or
 		   memory on the primary bus */
@@ -144,7 +145,9 @@ pdev_sort_resources(struct pci_dev *dev,
 			continue;
 
 		r = &dev->resource[i];
-		if (!(r->flags & type_mask) || r->parent)
+		r_size = r->end - r->start;
+		
+		if (!(r->flags & type_mask) || !r_size || r->parent)
 			continue;
 		for (list = head; ; list = list->next) {
 			unsigned long size = 0;
@@ -152,7 +155,7 @@ pdev_sort_resources(struct pci_dev *dev,
 
 			if (ln)
 				size = ln->res->end - ln->res->start;
-			if (r->end - r->start > size) {
+			if (r_size > size) {
 				tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
 				tmp->next = ln;
 				tmp->res = r;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
