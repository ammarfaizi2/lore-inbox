Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292577AbSBTXGP>; Wed, 20 Feb 2002 18:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292572AbSBTXF6>; Wed, 20 Feb 2002 18:05:58 -0500
Received: from web21307.mail.yahoo.com ([216.136.128.232]:36951 "HELO
	web21307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292576AbSBTXFq>; Wed, 20 Feb 2002 18:05:46 -0500
Message-ID: <20020220230545.2531.qmail@web21307.mail.yahoo.com>
Date: Wed, 20 Feb 2002 15:05:45 -0800 (PST)
From: Christine Ames <clgisotti@yahoo.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> David Stroupe wrote:
> > 
> > I am creating a PCI driver for a custom card and
want to write 0xffff to
> > a location offset from the base by 0x48 and
> > have the following code:
> > 
> > <snip>
> > unsigned int io_addr;
> > unsigned int io_size;
> > void* base;
> > pci_enable_device (pdev)
> > io_addr = pci_resource_start(pdev, 0);
> > io_size = pci_resource_len(pdev, 0);
> > if ((pci_resource_flags(pdev, 0) &
IORESOURCE_MEM)){
> >        if(check_mem_region(io_addr, io_size))
> >             DBG("Already In Use");//this is never
reached
> >         request_mem_region(io_addr, io_size ,
"Card Driver");

> In 2.4 and later, check request_mem_region return 
> value, and never call
> check_mem_region.

Gasp!  Are you sure we should never call 
check_mem_region, Jeff?

This check has worked for me under kernels 2.4.7 & 
2.4.7-10.  If check_mem_region returns < 0 my driver
bails with a message to the effect that my chip's 
memory region is already in use...

Could this lead to screw-ups?  
Should I lose the check?
(my pci initialization code follows)

> 
> >         base=ioremap(io_addr, io_size);
> >         if(base==0)
> >            DBG("memory mapped wrong\n");//this is
never reached
> >         writew(0xffff, base + 0x48);
> > <snip>
> > 
> > The card is found, io_addr = 0xe9011000 and
io_size = 0x200.
> > 
> > The write is unsuccessful or at least the data
never reaches the card.
> >  What am I doing incorrectly?
> 
> Looks correct to me... maybe you need to do
> 	readw(base + 0x48)
> to flush the transaction?
> 

David, I realize this is a "no-brainer" but, if Jeff's

comments don't help double-check that your I/O space
begins at PCI BAR 0 (as opposed to PCI BARs 1-5).

<snip>
// enable the device
  if( pci_enable_device( pdev )) {
    printk( KERN_ERR "init_pci_device:
pci_enable_device failed\n" );
    return 0;
  }

// set dma mask for device
// since we handle 32-bit dma, I don't think this is
necessary...
  if( pci_set_dma_mask( pdev, DMA_MASK ) != 0 ) {
    printk( KERN_ERR "init_pci_device:
pci_set_dma_mask failed\n");
    return 0;
  }
    
// enable bus master bit in PCI_COMMAND register
  pci_set_master( pdev );

  #ifdef DEBUG
    debug_display_pci_dev( pdev );
  #endif // DEBUG

// access I/O space
// registers begin at BAR 4
  phys_addr = pdev->resource[ 4 ].start;

// make sure nobody else is using the same device
  if( check_mem_region( phys_addr, REG_MAP_SIZE ) < 0
) {
    printk( KERN_ERR "init_pci_device: memory region
already in use!\n" );
    return 0;
  }

  if( request_mem_region( phys_addr, REG_MAP_SIZE,
pdc_ptr->name ) == NULL ) {
    printk( KERN_ERR "init_pci_device: memory region
not available!\n" );
    return 0;
  }

// remap physical pci space into virtual memory space
  pdc_ptr->regs = ioremap_nocache( phys_addr,
REG_MAP_SIZE );

// initialize pdev private driver data
  pdev->driver_data = pdc_ptr;

  return 1;
<snip>


--Christine



__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
