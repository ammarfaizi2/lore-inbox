Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTKESjd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 13:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTKESjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 13:39:32 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:56247 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263102AbTKESjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 13:39:24 -0500
Date: Wed, 5 Nov 2003 19:34:00 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: "Alexandra N. Kossovsky" <sasha@oktet.ru>
Cc: linux-kernel@vger.kernel.org, ShuChen <shuchen@realtek.com.tw>,
       netdev@oss.sgi.com
Subject: Re: r8169 with big-endian (patch)
Message-ID: <20031105193400.A12375@electric-eye.fr.zoreil.com>
References: <20031105104625.D26209@oktet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031105104625.D26209@oktet.ru>; from sasha@oktet.ru on Wed, Nov 05, 2003 at 10:46:26AM +0300
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Alexandra N. Kossovsky <sasha@oktet.ru> :
[...]
> Here is the patch to make RTL-8169 PCI Gbit ethernet card to work with
> big-endian host. The patch is against 2.4.22 kernel.

Please Cc: such patches to netdev@oss.sgi.com as well as jgarzik@pobox.com.

[...]
> @@ -664,19 +675,21 @@
>  	}
>  
>  	tp->TxDescArrays =
> -	    kmalloc(NUM_TX_DESC * sizeof (struct TxDesc) + 256, GFP_KERNEL);
> +	    pci_alloc_consistent(tp->pci_dev,
> +				 NUM_TX_DESC * sizeof (struct TxDesc) + 256, 
> +				 &tp->TxDescDmaAddrs);
> -	TxPhyAddr = virt_to_bus(tp->TxDescArrays);
> -	diff = 256 - (TxPhyAddr - ((TxPhyAddr >> 8) << 8));
> -	TxPhyAddr += diff;
> +	diff = 256 - (tp->TxDescDmaAddrs - ((tp->TxDescDmaAddrs >> 8) << 8));
> +	tp->TxDescDmaAddr = tp->TxDescDmaAddrs + diff;
>  	tp->TxDescArray = (struct TxDesc *) (tp->TxDescArrays + diff);

Remove the alignment stuff. pci_alloc_consistent() does it for you,
see Documentation/DMA-mapping.txt:
[...]
The cpu return address and the DMA bus master address are both
guaranteed to be aligned to the smallest PAGE_SIZE order which
is greater than or equal to the requested size.  This invariant


@@ -684,12 +697,18 @@
[...]
-       tp->RxBufferRings = kmalloc(RX_BUF_SIZE * NUM_RX_DESC, GFP_KERNEL);
+       tp->RxBufferRings = pci_alloc_consistent(tp->pci_dev,
+                                                RX_BUF_SIZE * NUM_RX_DESC,
+                                                &tp->RxBufferDmas);

You don't want consistent mapping for the data buffer.
Either you pci_map_single() the whole kmalloced() area and you sync it
when needed or you turn this code into usual, per skb, pci_map_single()
calls and you remove the big Rx data buffer.

--
Ueimor
