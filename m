Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293207AbSCFHZb>; Wed, 6 Mar 2002 02:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293283AbSCFHZU>; Wed, 6 Mar 2002 02:25:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13191 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293207AbSCFHZE>;
	Wed, 6 Mar 2002 02:25:04 -0500
Date: Tue, 05 Mar 2002 23:22:44 -0800 (PST)
Message-Id: <20020305.232244.51840122.davem@redhat.com>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Newsgroups: lists.linux.kernel
Subject: Re: Does kmalloc always return address below 4GB?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <slrna89ue7.4at.kraxel@bytesex.org>
In-Reply-To: <200203051639.IAA05629@adam.yggdrasil.com>
	<slrna89ue7.4at.kraxel@bytesex.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gerd Knorr <kraxel@bytesex.org>
   Date: 5 Mar 2002 17:00:55 GMT
   
   >  computer with >4GB of RAM (CONFIG_HIGHEM) talking to a PCI card
   >  that only does 32-bit addressing:
   >  
   >  		pci_set_dma_mask(pcidev, 0xffffffff);
   >  		addr = vmalloc(nbytes);
   >  		/* On an x86 with >4GB of RAM, addr will be <4GB, but
   >  	           __pa(addr) might be >4GB, and the system lacks
   >  	           PCI address mapping harware. */
   
   use vmalloc_32(), this one returns lowmem.

You can't use vmalloc() pointers as arguments to pci_map_single.
That is the point of what he's mentioning.
   
   >  		dma_addr = pci_map_single(pcidev, addr, nbytes, direction);
   
   This is illegal because addr is a kernel _virtual_ address.  You have to
   get the page using vmalloc_to_page() and feed this to pci_map_page()
   then. 

There is no such requirement that pci_map_page() only be used.
If you know you haven't got a HIGHMEM page, it is legal to
pass this to pci_map_single().
