Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269881AbTGOXcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 19:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269884AbTGOXcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 19:32:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57224 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269881AbTGOXcZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 19:32:25 -0400
Message-ID: <3F149276.10600@pobox.com>
Date: Tue, 15 Jul 2003 19:47:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Christopher Wedgwood <cw@sgi.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org, wildos@sgi.com
Subject: Re: [PATCH] (2.4.22-pre6 BK) New (IDE) driver: SGI IOC4
References: <20030715222744.GA7478@taniwha.engr.sgi.com>
In-Reply-To: <20030715222744.GA7478@taniwha.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Wedgwood wrote:
> +static inline void
> +IDE_DBG(int debuglevel, char *format, ...)
> +{
> +	va_list ap;
> +	char tempstr[256];
> +
> +	if (sgiioc4_debug >= debuglevel) {
> +		va_start(ap, format);
> +		vsprintf(tempstr, format, ap);
> +		printk(tempstr);
> +		va_end(ap);
> +	}
> +}

I'm impressed that varargs static inline works.  (not complaining, just 
shocked :))


> +static inline void
> +xide_delay(long ticks)
> +{
> +	if (!ticks)
> +		return;
> +
> +	current->state = TASK_INTERRUPTIBLE;
> +	schedule_timeout(ticks);
> +	return;
> +}

ITYM TASK_UNINTERRUPTIBLE, because you definitely don't handle being 
interrupted... :)



> +unsigned int __init
> +pci_init_sgiioc4(struct pci_dev *dev, const char *name)
> +{
> +	unsigned int class_rev;
> +
> +	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
> +	class_rev &= 0xff;

this appears to be dead code.


> +	pci_enable_device(dev);

you _definitely_ want to check for errors.


> +void
> +sgiioc4_maskproc(ide_drive_t * drive, int mask)
> +{
> +	ide_hwif_t *hwif = HWIF(drive);
> +	if (IDE_CONTROL_REG)
> +		hwif->OUTB(mask ? (drive->ctl | 2) : (drive->ctl & ~2),
> +			   IDE_CONTROL_REG);
> +}

I'm pretty sure you have a control reg :)  Test should not be necessary.


> +void __init
> +ide_init_sgiioc4(ide_hwif_t * hwif)
> +{
> +	hwif->autodma = 1;
> +	hwif->index = 0;	/* Channel 0 */
> +	hwif->channel = 0;
> +	hwif->atapi_dma = 1;
> +	hwif->ultra_mask = 0x0;	/* Disable Ultra DMA */
> +	hwif->mwdma_mask = 0x2;	/* Multimode-2 DMA  */
> +	hwif->swdma_mask = 0x2;
> +	hwif->identify = NULL;
> +	hwif->tuneproc = NULL;	/* Sets timing for PIO mode */
> +	hwif->speedproc = NULL;	/* Sets timing for DMA &/or PIO modes */
> +	hwif->selectproc = NULL;	/* Use the default selection routine to select drive */
> +	hwif->reset_poll = NULL;	/* No HBA specific reset_poll needed */
> +	hwif->pre_reset = NULL;	/* No HBA specific pre_set needed */
> +	hwif->resetproc = &sgiioc4_resetproc;	/* Reset the IOC4 DMA engine, clear interrupts etc */
> +	hwif->intrproc = NULL;	/* Enable or Disable interrupt from drive */
> +	hwif->maskproc = &sgiioc4_maskproc;	/* Mask on/off NIEN register */
> +	hwif->quirkproc = NULL;
> +	hwif->busproc = NULL;

style:  Under Linux we normally don't explicitly set to NULL.



> +static int
> +sgiioc4_ide_dma_lostirq(ide_drive_t * drive)
> +{
> +	if (HWIF(drive)->resetproc != NULL)
> +		HWIF(drive)->resetproc(drive);
> +	return __ide_dma_lostirq(drive);
> +}

don't you know if you have a resetproc?  :)


> +static u8
> +sgiioc4_INB(unsigned long port)
> +{
> +	u8 reg = (u8) inb(port);
> +
> +	if ((port & 0xFFF) == 0x11C) {	/* Status register of IOC4 */
> +		if (reg & 0x50) {	/* Not busy...check for interrupt */

hmmm, you probably want OK_STAT macro invocation that's used throughout 
the IDE code.


> +/* Creates a dma map for the scatter-gather list entries */
> +void __init
> +ide_dma_sgiioc4(ide_hwif_t * hwif, unsigned long dma_base)
> +{
> +	int num_ports = sizeof (ioc4_dma_regs_t);
> +
> +	IDE_DBG(0, "%s: BM-DMA at 0x%04lx-0x%04lx\n", hwif->name, dma_base,
> +		dma_base + num_ports - 1);
> +	if (check_region(dma_base, num_ports)) {
> +		IDE_DBG(0,
> +			"ide_dma_sgiioc4(%s) -- Error, Port Addresses 0x%p to 0x%p ALREADY in use\n",
> +			hwif->name, dma_base, dma_base + num_ports - 1);
> +		return;
> +	}
> +	request_region(dma_base, num_ports, hwif->name);

deprecated from the get-go...  eliminate check_region, and test 
request_region return value.


> +	hwif->dma_base = dma_base;
> +	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
> +						  IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,	/* 1 Page */
> +						  &hwif->dmatable_dma);
> +	if (hwif->dmatable_cpu == NULL)
> +		goto dma_alloc_failure;
> +
> +	hwif->sg_table = kmalloc(sizeof (struct scatterlist) * IOC4_PRD_ENTRIES,
> +				 GFP_KERNEL);
> +	if (hwif->sg_table == NULL) {
> +		pci_free_consistent(hwif->pci_dev,
> +				    IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
> +				    hwif->dmatable_cpu, hwif->dmatable_dma);
> +		goto dma_alloc_failure;
> +	}
> +
> +
> +	hwif->dma_base2 = (unsigned long) pci_alloc_consistent(hwif->pci_dev,
> +							       IOC4_IDE_CACHELINE_SIZE,
> +							       (dma_addr_t*)&(hwif->dma_status));
> +	if (!(hwif->dma_base2)) {
> +		IDE_DBG(0,
> +			"ide_dma_sgiioc4(%s) - Couldnot allocate map for Ending DMA \n",
> +			hwif->name);
> +	}

no error handling for this last alloc, unlike the previous two?


> +/* Sets the ATAPI Drive to do DMA in Multimode-2 */
> +void
> +sgiioc4_config_drive_for_dma(ide_drive_t * drive)
> +{
> +	u8 status_val;
> +	ide_hwif_t *hwif = HWIF(drive);
> +
> +	hwif->OUTB(drive->select.all, IDE_SELECT_REG);
> +	hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
> +	hwif->OUTB(0x0, IDE_DATA_REG);
> +	hwif->OUTB(0x0, IDE_SECTOR_REG);
> +	hwif->OUTB(0x0, IDE_LCYL_REG);
> +	hwif->OUTB(0x0, IDE_HCYL_REG);
> +	hwif->OUTB(0x22, IDE_NSECTOR_REG);
> +	hwif->OUTB(0x03, IDE_FEATURE_REG);
> +	hwif->OUTB(0xEF, IDE_COMMAND_REG);
> +
> +	do {
> +		xide_delay(HZ);
> +		status_val = hwif->INB(IDE_STATUS_REG);
> +	} while (status_val & 0x80);
> +
> +	if (status_val == 0x50) {
> +		IDE_DBG(1, "Successfully set %s in Multimode-2 DMA mode \n",
> +			drive->name);
> +		drive->using_dma = 1;
> +	} else {		/* Go to PIO mode if this occurs */
> +		IDE_DBG(0,
> +			"Couldnot set %s in Multimode-2 DMA mode | status 0x%x | Drive %s using PIO \n",
> +			drive->name, status_val, drive->name);
> +		drive->using_dma = 0;
> +	}
> +	return;
> +}

isn't there a standard function to do this?

This is the standard method of setting device transfer mode.


> +/* Creates the scatter gather list, DMA Table */
> +unsigned int
> +sgiioc4_build_dma_table(ide_drive_t * drive, struct request *rq, int ddir)
> +{
> +	ide_hwif_t *hwif = HWIF(drive);
> +	unsigned int *table = hwif->dmatable_cpu;
> +	unsigned int count = 0, i = 1;
> +	struct scatterlist *sg;
> +
> +	if (rq->cmd == IDE_DRIVE_TASKFILE)
> +		hwif->sg_nents = i = sgiioc4_ide_raw_build_sglist(hwif, rq);
> +	else
> +		hwif->sg_nents = i = sgiioc4_ide_build_sglist(hwif, rq, ddir);
> +	if (!i)
> +		return 0;	/* sglist of length Zero */
> +
> +	sg = hwif->sg_table;
> +	while (i && sg_dma_len(sg)) {
> +		dma_addr_t cur_addr;
> +		int cur_len;
> +		cur_addr = sg_dma_address(sg);
> +		cur_len = sg_dma_len(sg);
> +
> +		while (cur_len) {
> +			if (count++ >= IOC4_PRD_ENTRIES) {
> +				printk("%s: DMA table too small\n",
> +				       drive->name);
> +				goto use_pio_instead;
> +			} else {
> +				uint32_t xcount, bcount =
> +				    0x10000 - (cur_addr & 0xffff);
> +
> +				if (bcount > cur_len)
> +					bcount = cur_len;
> +
> +				/* put the addr, length in the IOC4 dma-table format */
> +				*table = 0x0;
> +				table++;
> +				*table = cpu_to_be32(cur_addr);
> +				table++;
> +				*table = 0x0;
> +				table++;
> +
> +				xcount = bcount & 0xffff;
> +				*table = cpu_to_be32(xcount);
> +				table++;
> +
> +				cur_addr += bcount;
> +				cur_len -= bcount;
> +			}
> +		}
> +
> +		sg++;
> +		i--;
> +	}
> +
> +	if (count) {
> +		table--;
> +		*table |= cpu_to_be32(0x80000000);
> +		return count;
> +	}
> +      use_pio_instead:
> +	pci_unmap_sg(hwif->pci_dev,
> +		     hwif->sg_table, hwif->sg_nents, hwif->sg_dma_direction);
> +	hwif->sg_dma_active = 0;
> +	return 0;		/* revert to PIO for this request */
> +}

hrm... did all this code really need duplicating from ide-dma.c?


> +static int
> +sgiioc4_clearirq(ide_drive_t * drive)
> +{
> +	u32 intr_reg;
> +	ide_hwif_t *hwif = HWIF(drive);
> +	ide_ioreg_t other_ir =
> +	    hwif->io_ports[IDE_IRQ_OFFSET] + (IOC4_INTR_REG << 2);
> +
> +	/* Code to check for PCI error conditions */
> +	intr_reg = hwif->INL(other_ir);
> +	if (intr_reg & 0x03) {
> +		/* Valid IOC4-IDE interrupt */
> +		u8 stat = hwif->INB(IDE_STATUS_REG);
> +		int count = 0;
> +		do {
> +			xide_delay(count);
> +			stat = hwif->INB(IDE_STATUS_REG);	/* Removes Interrupt from IDE Device */
> +		} while ((stat & 0x80) && (count++ < 1024));
> +
> +		if (intr_reg & 0x02) {
> +			/* Error when transferring DMA data on PCI bus */
> +			uint32_t pci_err_addr_low, pci_err_addr_high,
> +			    pci_stat_cmd_reg;
> +
> +			pci_err_addr_low =
> +			    hwif->INL(hwif->io_ports[IDE_IRQ_OFFSET]);
> +			pci_err_addr_high =
> +			    hwif->INL(hwif->io_ports[IDE_IRQ_OFFSET] + 4);
> +			pci_read_config_dword(hwif->pci_dev, PCI_COMMAND,
> +					      &pci_stat_cmd_reg);
> +			IDE_DBG(0,
> +				"sgiioc4_clearirq(%s) : PCI Bus Error when doing DMA : status-cmd reg is 0x%x \n",
> +				drive->name, pci_stat_cmd_reg);
> +			IDE_DBG(0,
> +				"sgiioc4_clearirq(%s) : PCI Error Address is 0x%x%x \n",
> +				drive->name, pci_err_addr_high,
> +				pci_err_addr_low);
> +			/* Clear the PCI Error indicator */
> +			pci_write_config_dword(hwif->pci_dev, PCI_COMMAND,
> +					       0x00000146);
> +		}
> +		hwif->OUTL(0x03, other_ir);	/* Clear the Interrupt, Error bits on the IOC4 */
> +
> +		intr_reg = hwif->INL(other_ir);
> +	}
> +	return intr_reg;
> +}

nice... this code is actually applicable to several other PCI host 
controllers, too.




> +/* Weeds out non-IDE interrupts to the IOC4 */
> +#define ide_ack_intr(hwif)      ((hwif)->hw.ack_intr ? (hwif)->hw.ack_intr(hwif) : 1)

does this deal with shared interrupts too?



