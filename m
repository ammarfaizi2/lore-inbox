Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263346AbTIWURI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTIWUQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:16:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:18826 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262188AbTIWUPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:15:30 -0400
Date: Tue, 23 Sep 2003 13:15:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, alan@lxorguk.ukuu.org.uk
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030923131515.H20572@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>; from dychen@stanford.edu on Mon, Sep 15, 2003 at 09:35:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Yu Chen (dychen@stanford.edu) wrote:
> [FILE:  2.6.0-test5/sound/oss/ymfpci.c]
> START -->
> 2530:	if ((codec = kmalloc(sizeof(ymfpci_t), GFP_KERNEL)) == NULL) {
> 2531:		printk(KERN_ERR "ymfpci: no core\n");
> 2532:		return -ENOMEM;
> 2533:	}
> 2534:	memset(codec, 0, sizeof(*codec));
> 2535:
>         ... DELETED 11 lines ...
> 2547:		goto out_free;
> 2548:	}
> 2549:
> 2550:	if ((codec->reg_area_virt = ioremap(base, 0x8000)) == NULL) {
> 2551:		printk(KERN_ERR "ymfpci: unable to map registers\n");
> GOTO -->
> 2552:		goto out_release_region;
> 2553:	}
> 2554:
> 2555:	pci_set_master(pcidev);
> 2556:
> 2557:	printk(KERN_INFO "ymfpci: %s at 0x%lx IRQ %d\n",
>         ... DELETED 78 lines ...
> 2636: out_release_region:
> 2637:	release_mem_region(pci_resource_start(pcidev, 0), 0x8000);
> 2638: out_free:
> 2639:	if (codec->ac97_codec[0])
> 2640:		ac97_release_codec(codec->ac97_codec[0]);
> END -->
> 2641:	return -ENODEV;

Yes, this looks like a bug.  Patch below.  Alan, this look ok?

thanks,
-chris

===== sound/oss/ymfpci.c 1.38 vs edited =====
--- 1.38/sound/oss/ymfpci.c	Tue Aug 26 09:25:41 2003
+++ edited/sound/oss/ymfpci.c	Tue Sep 23 12:42:45 2003
@@ -2638,6 +2638,7 @@
  out_free:
 	if (codec->ac97_codec[0])
 		ac97_release_codec(codec->ac97_codec[0]);
+	kfree(codec);
 	return -ENODEV;
 }
 
