Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSE0JOk>; Mon, 27 May 2002 05:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSE0JOj>; Mon, 27 May 2002 05:14:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:48378 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314707AbSE0JOi>; Mon, 27 May 2002 05:14:38 -0400
Subject: Re: PROBLEM: memory corruption with i815 chipset variant
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: Alessandro Morelli <alex@alphac.it>, linux-kernel@vger.kernel.org
In-Reply-To: <3CF1F4C0.5080201@epfl.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 11:17:00 +0100
Message-Id: <1022494620.11859.207.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 09:56, Nicolas Aspert wrote:
> OK, I have a patch almost ready to do that except, I am not sure about 
> what to do for those 3 bits...
> 
> The *usual* call is :
> 	pci_write_config_dword(agp_bridge.dev, INTEL_ATTBASE,
> 			       agp_bridge.gatt_bus_addr);
> 
> Where 'gatt_bus_addr' is returned from a 'virt_to_phys' on 
> 'gatt_table_real'.
> 
> Should I mask those three bits out when writing or write
> 'gatt_bus_addr >> 3' instead ? I am not too sure about the assumptions 
> that can be made about what returns 'virt_to_phys' ...

virt_to_phys returns you the CPU physical (after the MMU) address of the
memory in question. You'd want to check the documentation but assuming
the base is still written as an address in bytes then you'd want to do 
something like

	if(agp_bridge.gatt_bus_addr & ~0x1FFFFFFF)
		panic("gatt bus addr too high");
	pci_read_config_dword(agp_bridge.dev, INTEL_ATTBASE, &addr);
	addr&=~0x1FFFFFFF;
	addr|=agp_bridge.gatt_bus_addr;
	pci_write_config_dword(agp_bridge.dev, INTEL_ATTBASE, &addr);

