Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbTCTVtS>; Thu, 20 Mar 2003 16:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262284AbTCTVtS>; Thu, 20 Mar 2003 16:49:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:48512 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261376AbTCTVtQ>;
	Thu, 20 Mar 2003 16:49:16 -0500
Date: Thu, 20 Mar 2003 13:59:11 -0800
From: Bob Miller <rem@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@m17n.org, gniibe@m17n.org,
       kkojima@rr.iij4u.or.jp
Subject: Re: [PATCH] reduce stack usage in arch/sh/kernel/pci-sh7751
Message-ID: <20030320215910.GA16501@doc.pdx.osdl.net>
References: <20030320120833.2ddbfcc1.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320120833.2ddbfcc1.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 12:08:33PM -0800, Randy.Dunlap wrote:
> Hi,
> 
> This has already been done for arch/i386 and arch/x86_64 (same function
> as is patched here).  Please apply to 2.5.65.
> 
> Thanks,
> --
> ~Randy
> 
> 
> patch_name:	sh-pci-dev-stack.patch
> patch_version:	2003-03-20.11:47:35
> author:		Randy.Dunlap <rddunlap@osdl.org>
> description:	reduce stack usage in
> 		arch/sh/kernel/pci-sh7751::pcibios_fixup_peer_bridges()
> product:	Linux
> product_versions: 2.5.65
> changelog:	change pci_dev and pci_bus data to pointers & kmalloc() them;
> 		same patch as already applied to i386 and x86_64;
> maintainer:	Niibe Yutaka: gniibe@m17n.org,
> 		Kazumoto Kojima: kkojima@rr.iij4u.or.jp
> 		(list: linux-sh@m17n.org)
> diffstat:	=
>  arch/sh/kernel/pci-sh7751.c |   27 +++++++++++++++++++--------
>  1 files changed, 19 insertions(+), 8 deletions(-)
> 
> 
> diff -Naur ./arch/sh/kernel/pci-sh7751.c%SHSTK ./arch/sh/kernel/pci-sh7751.c
> --- ./arch/sh/kernel/pci-sh7751.c%SHSTK	Mon Mar 17 13:44:19 2003
> +++ ./arch/sh/kernel/pci-sh7751.c	Thu Mar 20 11:46:08 2003
> @@ -199,28 +199,39 @@
>  static void __init pcibios_fixup_peer_bridges(void)
>  {
>  	int n;
> -	struct pci_bus bus;
> -	struct pci_dev dev;
> +	struct pci_bus *bus;
> +	struct pci_dev *dev;
>  	u16 l;
>  
>  	if (pcibios_last_bus <= 0 || pcibios_last_bus >= 0xff)
>  		return;
>  	PCIDBG(2,"PCI: Peer bridge fixup\n");
> +
> +	bus = kmalloc(sizeof(*bus), GFP_ATOMIC);
> +	dev = kmalloc(sizeof(*dev), GFP_ATOMIC);
> +	if (!bus || !dev) {
> +		printk(KERN_ERR "Out of memory in %s\n", __FUNCTION__);
> +		goto exit;
> +	}
> +
If the kmalloc() for bus succeeds but for dev fails this will leak the
memory given to bus.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
