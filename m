Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbTD1Qwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 12:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbTD1Qwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 12:52:43 -0400
Received: from fmr04.intel.com ([143.183.121.6]:13780 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261204AbTD1QwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 12:52:25 -0400
Message-ID: <12B638FEE763F74696D8544752E7204803254E84@bgsmsx101.iind.intel.com>
From: "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mj@ucw.cz'" <mj@ucw.cz>
Cc: "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Subject: Request for Comment on PCI Express Configuration Support design
Date: Mon, 28 Apr 2003 09:59:27 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
	With the announcement of several PCI Express chipsets I would like
to propose a design to enable Linux to provide native PCI Express
configuration support.  Since the Specification is published, I felt it
would be a good idea to start discussion of a potential design and get
community feedback.   The goal being to have an agreed to design/code
available when Hardware becomes available to try out.   I have included a
proposed design for your review, any and all feedback is welcome

	PCI Express extends the PCI configuration space size from the
traditional 256 bytes to 4096 bytes. Some of the PCI express specific
features like Advanced error reporting and Virtual channel support
structures reside in the extended configuration space. The PCI Express
Specification also defines an "enhanced configuration access mechanism"
which is essentially a Memory Mapped scheme to access this extended
configuration region. Currently in Linux, the PCI Subsystem supports only
type 1/ type 2 PCI configuration access, which is traditionally accessed
through CF8/CFC mechanism. 

	To support access to the extended configuration region of the PCI
Express devices (Although legacy CF8/CFC scheme will still work, but the
configuration access space will be limited to 256 bytes only), we need to
modify the PCI subsystem. At the time of PCI initialization/device
enumeration the pci_root_ops and hence pci_dev->ops structure is set to
pci_express_ops for PCI Express devices (identified by the existence of the
PCI Express capability structure). 

			static struct pci_ops pci_express_conf = {
				.read =         pci_express_conf_read,
			        	.write =
pci_express_conf_write,
				};
			static int __init pci_direct_init(void)
			{
				------
				local_irq_save(flags);
			#ifdef CONFIG_PCI_EXP_ENHANCED
				/*
				 *	Check if platform we are running is
pci express capable
				 */
				 if( is_pci_exp_platform() != 0){
					 if
(pci_sanity_check(&pci_express_conf)){
						local_irq_restore(flags);
						printk(KERN_INFO "PCI:Using
config type PCIExp\n");
						pci_root_ops =
&pci_express_conf;
						return 0;
					} 
	             	
				}
			#endif /* CONFIG_PCI_EXP_ENHANCED */
			----
			----
			}	
		The pci_express_ops devops structure, can be similar to the
pci_direct_conf1 devops structure but will implement the memory mapped
configuration access internally.
		 static int __pci_express_conf_write (int seg, int bus, int
dev, int fn,
							int reg, int len,
u32 value)
		{
			unsigned long flags;
			unsigned long base_address, temp;
			unsigned char * virt_addr;
	 
			if (!value || (bus > 255) || (dev > 31) || (fn > 7)
|| (reg > 4095))
				return -EINVAL;

			if ( mmcfg_base_address == 0){
			/*
				 * We should never been here. Init code
would have checked this already
				 * If not Something seriously wrong happened

				 * Lets bail out here 
			 */	
				printk(KERN_INFO "PCIExpress not supported
in this platform\n");
		
				/* error in reading base_address */
				return(-1);
			}

			base_address = 
				mmcfg_base_address | (bus << 20) |
((PCI_DEVFN (dev,fn)) <<12);
			virt_addr = (char *)pciexp_map_region(base_address);
			spin_lock_irqsave(&pci_config_lock, flags);
		
			switch (len) {
				case 1:
					writeb(value,(unsigned
long)virt_addr+reg);
					break;
				case 2:
					writew(value,(unsigned
long)virt_addr+reg);
		       			break;
				case 4:
					writel(value,(unsigned
long)virt_addr+reg);
					break;
				default:
					break;
			     	}
	 
			spin_unlock_irqrestore(&pci_config_lock, flags);

			pciexp_unmap_region((unsigned long)virt_addr);
			return 0;
		}
	 
		static int __pci_express_conf_read (int seg, int bus, int
dev, int fn, 
						int reg, int len, u32
*value)
		{
			unsigned long flags;
			unsigned long base_address;
			char * virt_addr;
	 
			if (!value || (bus > 255) || (dev > 31) || (fn > 7)
|| (reg > 4095))
		                 return -EINVAL;
			
			if ( mmcfg_base_address == 0) {
		 		printk(KERN_INFO 
					"PCIExpress not supported in this
platform\n");
					/* error in reading base_address */
				return(-1);
			}
			base_address= 
				mmcfg_base_address | (bus << 20) |
((PCI_DEVFN (dev,fn)) <<12);
			virt_addr = (char *)pciexp_map_region(base_address);
			spin_lock_irqsave(&pci_config_lock, flags);
			switch (len) {
			        case 1:
	       			*value = (u8)readb((unsigned long)
virt_addr+reg);
			                break;
			        case 2:
	       			*value = (u16)readw((unsigned long)
virt_addr+reg);
			                break;
			        case 4:
	       			 *value = (u32)readl((unsigned long)
virt_addr+reg);
			                break;
			}
	 
		        spin_unlock_irqrestore(&pci_config_lock, flags);
		        pciexp_unmap_region((unsigned long)virt_addr);
		        return 0;
		}
		static unsigned long __init pciexp_map_region(unsigned long
phys)
		{
			unsigned long base, offset, mapped_area;
			base  = ((unsigned long)phys) & PAGE_MASK;
			offset = ((unsigned long) phys) - base;
			mapped_area = (unsigned long) ioremap(base,
PAGE_SIZE);
			return ( mapped_area? (mapped_area + offset): 0UL);
		}

		static void __init pciexp_unmap_region(u_long vaddr)
		{
			if (vaddr)
				iounmap((void *) (vaddr & PAGE_MASK));
		}

		This will enable any existing pci driver to access the
complete 4k config space (which include legacy 256 byte configuration region
as well) using standard interface like pci_config_read/write call. 
	Any suggestions, feedback, comments or alternative designs are
welcome.

	Thanks 
	--hari
	Email :- harinarayanan.seshadri@intel.com

