Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292036AbSBTRSo>; Wed, 20 Feb 2002 12:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292043AbSBTRSf>; Wed, 20 Feb 2002 12:18:35 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:44006 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292036AbSBTRSQ>; Wed, 20 Feb 2002 12:18:16 -0500
Date: Wed, 20 Feb 2002 10:35:39 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2
Message-ID: <20020220103539.B32211@vger.timpanogas.org>
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Wed, Feb 20, 2002 at 10:33:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Here's the code fragment in question:

/*
 * ----------------------------------------------------------------------------
 * ( U N ) M A P   P S B   A D D R   S P A C E
 * ----------------------------------------------------------------------------
 */
static int
MapPsbAddrSpace(Sci_p up, memarea_t *as)
{
	char *id = as->id ? as->id : "UNKNOWN";

	if (!as->ioaddr) {
		osif_warn("Tried to map phaddr 0x%x space %s unit %d\n",
			  as->ioaddr, id, up->os.unit_no);
		return -1;
	}

	if (as->vaddr) {
		osif_warn("Tried to map already mapped space %s unit %d\n",
			  id,up->os.unit_no);
		return -1;
	}

#if 1
	osif_note("Mapping address space %s: phaddr %x sz %u out of %u",
		id, as->ioaddr, as->msize, as->rsize);
#endif
#ifdef CPU_ARCH_IS_ALPHA
#warning This looks quite suspect out
	if ((as->vaddr = (vkaddr_t)(dense_mem((unsigned)as->ioaddr)+(unsigned)as->ioaddr)) == 0) { 
#else


=====> we are failing at this point 

	if ((as->vaddr = (vkaddr_t)ioremap((unsigned)as->ioaddr, as->msize)) == 0) { 
#endif
		osif_warn("Failed to map address space %s \n",
			  id,up->os.unit_no);
		return -1;
	}
    as->ph_base_addr = virt_to_phys(bus_to_virt(as->ioaddr));

#if 1
	osif_note("Mapping address space %s: vaddr %lx", id, as->vaddr);
#endif
	return 0;
}


Jeff


On Wed, Feb 20, 2002 at 10:33:20AM -0700, Jeff V. Merkey wrote:
> 
> 
> On 2.4.18-rc2 with the Dolphin SCI adapters installed and running
> with 2 GB of physical memory installed in the system, ioremap() fails 
> to properly map the SCI adapter PREFETCH space.  This error does not 
> occur opn 2.4.18-rc2 when the physical memory installed in the system 
> is less than 1 GB.  This error is proceeded by a failure in the PCI 
> subsystem to properly allocate resources and reports the following 
> message in the /var/log/messages file:
> 
> 
> Feb 20 09:49:38 lnx1 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdbb1, last bus=2
> Feb 20 09:49:38 lnx1 kernel: PCI: Using configuration type 1
> Feb 20 09:49:38 lnx1 kernel: PCI: Probing PCI hardware
> Feb 20 09:49:38 lnx1 kernel: PCI: Unable to handle 64-bit address for device 00:05.0
> Feb 20 09:49:38 lnx1 kernel: PCI: Unable to handle 64-bit address for device 00:05.1
> Feb 20 09:49:38 lnx1 kernel: PCI: Discovered primary peer bus 02 [IRQ]
> Feb 20 09:49:38 lnx1 kernel: PCI: Using IRQ router ServerWorks [1166/0200] at 00:0f.0
> Feb 20 09:49:38 lnx1 kernel: PCI->APIC IRQ transform: (B0,I2,P0) -> 18
> Feb 20 09:49:38 lnx1 kernel: PCI->APIC IRQ transform: (B0,I6,P0) -> 31
> Feb 20 09:49:38 lnx1 kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 10
> Feb 20 09:49:38 lnx1 kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 30
> Feb 20 09:49:38 lnx1 kernel: PCI->APIC IRQ transform: (B2,I2,P0) -> 24
> 
> =====>
> 
> Feb 20 09:49:38 lnx1 kernel: PCI: Cannot allocate resource region 0 of device 00:05.0
> Feb 20 09:49:38 lnx1 kernel: PCI: Cannot allocate resource region 0 of device 00:05.1
> Feb 20 09:49:38 lnx1 kernel: PCI: Failed to allocate resource 1(0-ffffffff) for 00:05.0
> Feb 20 09:49:38 lnx1 kernel: PCI: Failed to allocate resource 1(0-ffffffff) for 00:05.1
> 
> This message does not occur on systems running 2.4.18-rc2 if they have 
> less than 1 GB of physical memory installed.  The address ranges being 
> mapped are as follows, and the SCI adapter reports the attached errors:
> 
> 
> Feb 20 09:49:45 lnx1 sci: Reading IRM driver configuration informaiton from /opt/DIS/sbin/../lib/modules/pcisci.conf
> Feb 20 09:49:45 lnx1 kernel: SCI Driver : Linux SMP support disabled
> Feb 20 09:49:45 lnx1 kernel: SCI Driver : using MTRR
> Feb 20 09:49:45 lnx1 kernel: PCI SCI Bridge - device id 0xd667 found
> Feb 20 09:49:45 lnx1 kernel: 1 supported PCI-SCI bridges (PSB's) found on the system
> Feb 20 09:49:45 lnx1 kernel: Define PSB 1 key: Bus:  2 DevFn: 16
> Feb 20 09:49:45 lnx1 kernel: Key 1: Key: (Bus:  2,DevFn: 16), Device No. 1, irq 24
> Feb 20 09:49:45 lnx1 kernel: Mapping address space non cacheable CSR space: phaddr febe0000 sz 131072 out of 131072
> Feb 20 09:49:45 lnx1 kernel: Mapping address space non cacheable CSR space: vaddr f8914000
> Feb 20 09:49:45 lnx1 kernel: Mapping address space non cacheable IO space: phaddr fd000000 sz 16777216 out of 16777216
> Feb 20 09:49:45 lnx1 kernel: Mapping address space non cacheable IO space: vaddr f8935000
> Feb 20 09:49:45 lnx1 kernel: SCI Adapter 0 : User request to reduce prefetchspace size from 0x20000000 to 0x1c000000
> 
> =====>
> 
> Feb 20 09:49:45 lnx1 kernel: Mapping address space PREFETCH space: phaddr c0000000 sz 469762048 out of 469762048
> Feb 20 09:49:45 lnx1 kernel: Failed to map address space PREFETCH space 
> Feb 20 09:49:45 lnx1 kernel: SCI Driver : Adapter init failed!!
> Feb 20 09:49:45 lnx1 kernel: SCI Driver : init failed!
> Feb 20 09:49:45 lnx1 sci: ERROR: IRM Driver failed to load
> Feb 20 09:49:45 lnx1 sci: Check /var/log/scilog for details
> Feb 20 09:49:45 lnx1 rc: Starting sci:  failed
> 
> 
> /proc/iomem on the system is reporting the following attached 
> hardware devices and their address mappings:
> 
> 
> 00000000-0009f3ff : System RAM
> 0009f400-0009f7ff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000cc000-000ccfff : Extension ROM
> 000f0000-000fffff : System ROM
> 00100000-3fffffff : System RAM
>   00100000-002881d5 : Kernel code
>   002881d6-00319977 : Kernel data
> b1fff000-b1ffffff : ServerWorks CNB20HE Host Bridge
> b2000000-b3ffffff : ServerWorks CNB20HE Host Bridge
> b4100000-bc1fffff : PCI Bus #01
>   b8000000-bbffffff : ATI Technologies Inc Rage 128 PF
> 
> =========>  we are mapping this address range
> c0000000-dfffffff : Dolphin Interconnect Solutions AS PSB66 SCI-Adapter D33x
> fc400000-fc4fffff : PCI Bus #01
>   fc4fc000-fc4fffff : ATI Technologies Inc Rage 128 PF
> fc900000-fc9fffff : Intel Corp. 82557 [Ethernet Pro 100]
> fcac0000-fcadffff : Intel Corp. 82543GC Gigabit Ethernet Controller
> fcae0000-fcaeffff : Intel Corp. 82543GC Gigabit Ethernet Controller
> fcafe000-fcafefff : Intel Corp. 82557 [Ethernet Pro 100]
>   fcafe000-fcafefff : eepro100
> fcaff000-fcafffff : ServerWorks OSB4/CSB5 OHCI USB Controller
> fd000000-fdffffff : Dolphin Interconnect Solutions AS PSB66 SCI-Adapter D33x
> febe0000-febfffff : Dolphin Interconnect Solutions AS PSB66 SCI-Adapter D33x
> fec00000-fec01fff : reserved
> fee00000-fee00fff : reserved
> fff80000-ffffffff : reserved
> 
> The specific code that is failing is attached.  Any ideas as to what
> is broken here?  Looks like the mapping code is busted if the system
> has over 1 GB of physical memory with certain hardware.  The window 
> size we are attempting to map is 512 MB.  This works with less than
> 1 GB of memory and I have attempted 4GB and 64GB compile options and 
> it does not work.  
> 
> Jeff
> 
