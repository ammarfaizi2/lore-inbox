Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbRCBX1u>; Fri, 2 Mar 2001 18:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130142AbRCBX13>; Fri, 2 Mar 2001 18:27:29 -0500
Received: from [209.102.105.34] ([209.102.105.34]:40466 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S130139AbRCBX1Z>;
	Fri, 2 Mar 2001 18:27:25 -0500
Date: Fri, 2 Mar 2001 15:27:10 -0800
From: Tim Wright <timw@splhi.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: mj@suse.cz, linux-kernel@vger.kernel.org, hulinsky@fel.cvut.cz
Subject: Re: [PATCH] 2.4.2-acX does not recognize any bus on Intel Serverworks based motherboard
Message-ID: <20010302152710.D1438@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Petr Vandrovec <vandrove@vc.cvut.cz>, mj@suse.cz,
	linux-kernel@vger.kernel.org, hulinsky@fel.cvut.cz
In-Reply-To: <20010302193444.A2154@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010302193444.A2154@vana.vc.cvut.cz>; from vandrove@vc.cvut.cz on Fri, Mar 02, 2001 at 07:34:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has come up before a few times. The concensus seems to be that the PCI
fixup code for Serverworks chipsets is currently broken (and it's less simple to
fix than it should be due to lack of documentation - there have been some
educated guesses but it would be nicer to know for sure). The suggestion was
to simply kill the fixup code and believe the BIOS (i.e. kill the relevant
lines in the pcibios_fixups[] array in arch/i386/kernel/pci-pc.c). That has
worked on the systems I'm using that use the Serverworks chipset.

Tim

On Fri, Mar 02, 2001 at 07:34:44PM +0100, Petr Vandrovec wrote:
> Hi Martin,
>   what's idea behind 'pcibios_last_bus >= 0xff' ? On friend's STL2 Intel
> motherboard Serverworks bridge contains 0x01 in reg. 0x44 (first bus behind
> bridge) and 0xFF in reg. 0x45 (last bus behind bridge).
>   This sets pcibios_last_bus to 0xFF in serverworks fixup code. After this
> pcibios_fixup_peer_bridges() refuses to do anything, so devices connected
> to secondary bus are not visible to system.
>   With patch below system sees all devices again - patch is for 2.4.2-ac9.
> 					Thanks,
> 						Petr Vandrovec
> 						vandrove@vc.cvut.cz
> 
> 
> diff -urdN linux/arch/i386/kernel/pci-pc.c linux/arch/i386/kernel/pci-pc.c
> --- linux/arch/i386/kernel/pci-pc.c	Fri Mar  2 17:55:05 2001
> +++ linux/arch/i386/kernel/pci-pc.c	Fri Mar  2 17:56:50 2001
> @@ -784,7 +784,7 @@
>  	struct pci_dev dev;
>  	u16 l;
>  
> -	if (pcibios_last_bus <= 0 || pcibios_last_bus >= 0xff)
> +	if (pcibios_last_bus <= 0 || pcibios_last_bus > 0xff)
>  		return;
>  	DBG("PCI: Peer bridge fixup\n");
>  	for (n=0; n <= pcibios_last_bus; n++) {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
