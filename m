Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbTD1XTX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 19:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbTD1XTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 19:19:23 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23441
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261369AbTD1XTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 19:19:22 -0400
Subject: Re: Request for Comment on PCI Express Configuration Support design
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mj@ucw.cz'" <mj@ucw.cz>
In-Reply-To: <12B638FEE763F74696D8544752E7204803254E84@bgsmsx101.iind.intel.com>
References: <12B638FEE763F74696D8544752E7204803254E84@bgsmsx101.iind.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051569148.17369.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Apr 2003 23:32:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-28 at 17:59, Seshadri, Harinarayanan wrote:
> which is essentially a Memory Mapped scheme to access this extended
> configuration region. Currently in Linux, the PCI Subsystem supports only
> type 1/ type 2 PCI configuration access, which is traditionally accessed
> through CF8/CFC mechanism. 

(and BIOS, and IBM NUMA-Q/440)

> 	To support access to the extended configuration region of the PCI
> Express devices (Although legacy CF8/CFC scheme will still work, but the
> configuration access space will be limited to 256 bytes only), we need to
> modify the PCI subsystem. At the time of PCI initialization/device
> enumeration the pci_root_ops and hence pci_dev->ops structure is set to
> pci_express_ops for PCI Express devices (identified by the existence of the
> PCI Express capability structure). 

Is this property dependant on the device or on the root bridge ? IE if I
have something like

	PCIEXPRESS(root)---->PCIEXress/Cardbus bridge--->Ethernet card

Can I use the mmio interface to talk to the card - I'd assume so
(obviously it only has 256 bytes of data)

> 		static unsigned long __init pciexp_map_region(unsigned long
> phys)
> 		{
> 			unsigned long base, offset, mapped_area;
> 			base  = ((unsigned long)phys) & PAGE_MASK;
> 			offset = ((unsigned long) phys) - base;
> 			mapped_area = (unsigned long) ioremap(base,
> PAGE_SIZE);
> 			return ( mapped_area? (mapped_area + offset): 0UL);
> 		}

ioremap is bright enough to do unaligned maps for you

> 		This will enable any existing pci driver to access the
> complete 4k config space (which include legacy 256 byte configuration region
> as well) using standard interface like pci_config_read/write call. 

Looks pretty sound to me. The code was intended to support multiple
config mechanisms.

Alan

