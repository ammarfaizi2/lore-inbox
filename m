Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbVHEJqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbVHEJqF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVHEJpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:45:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26309 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262932AbVHEJot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:44:49 -0400
Subject: Re: areca-raid-linux-scsi-driver.patch added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, bunk@stusta.de, erich@areca.com.tw
In-Reply-To: <200508050912.j759CfQp004898@shell0.pdx.osdl.net>
References: <200508050912.j759CfQp004898@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 11:44:26 +0200
Message-Id: <1123235067.3239.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 02:11 -0700, akpm@osdl.org wrote:


> +/************************************/
> +#if defined __KERNEL__

this looks wrong; __KERNEL__ is always set

> +#include <linux/config.h>


> +#if defined( CONFIG_MODVERSIONS ) && ! defined( MODVERSIONS )
> +#define MODVERSIONS
> +#endif
> +	/* modversions.h should be before should be before module.h */
> +#if defined( MODVERSIONS )
> +#include <config/modversions.h>
> +#endif

please remove this entire chunk; module.h will do this already for you,
and it's just plain WRONG to do it yourself on 2.6



> +#include <linux/module.h>
> +#include <linux/version.h>
> +	/* Now your module include files & source code follows */
> +#include <asm/dma.h>
> +#include <asm/io.h>
> +#include <asm/system.h>
> +#include <asm/uaccess.h>

it's common practice to sort the includes such that the asm/ ones come
after the linux/ ones


> +static u_int8_t arcmsr_adapterCnt = 0;
> +static struct _HCBARC arcmsr_host_control_block;
> +static PHCBARC pHCBARC = &arcmsr_host_control_block;


this looks like an evil typedef; please use struct hcbarc consistently,
and do not use the P convention to typedef pointers!

> +/*
> +**********************************************************************************
> +** notifier block to get a notify on system shutdown/halt/reboot
> +**********************************************************************************
> +*/

this comment looks misplaced

> +static int arcmsr_fops_ioctl(struct inode *inode, struct file *filep,
> +			     unsigned int ioctl_cmd, unsigned long arg);
> +static int arcmsr_fops_close(struct inode *inode, struct file *filep);
> +static int arcmsr_fops_open(struct inode *inode, struct file *filep);
> +static int arcmsr_halt_notify(struct notifier_block *nb, unsigned long event,
> +			      void *buf);
> +static int arcmsr_initialize(PACB pACB, struct pci_dev *pPCI_DEV);
> +static int arcmsr_iop_ioctlcmd(PACB pACB, int ioctl_cmd, void *arg);
> +static int arcmsr_proc_info(struct Scsi_Host *host, char *buffer, char **start,
> +			    off_t offset, int length, int inout);


> +	.use_clustering = DISABLE_CLUSTERING,

why this?


> +static irqreturn_t arcmsr_doInterrupt(int irq, void *dev_id,
> +				      struct pt_regs *regs)
> +{
> +	irqreturn_t handle_state;
> +	PACB pACB, pACBtmp;
> +	int i = 0;
> +
> +#if ARCMSR_DEBUG0
> +	printk("arcmsr_doInterrupt.................. 1\n");
> +#endif


please use pr_debug for this, that way you can get rid of all the #if's



> +	}
> +	if (!pci_set_dma_mask(pPCI_DEV, (dma_addr_t) 0xffffffffffffffffULL)) {	/*64bit */
> +		printk("ARECA RAID: 64BITS PCI BUS DMA ADDRESSING SUPPORTED\n");
> +	} else if (pci_set_dma_mask(pPCI_DEV, (dma_addr_t) 0x00000000ffffffffULL)) {	/*32bit */


there are nice symbolic constants for these, please use them 





> +
> +/*
> +**********************************************************************
> +**
> +**  Linux scsi mid layer command complete
> +**
> +**********************************************************************
> +*/
> +static void arcmsr_cmd_done(struct scsi_cmnd *pcmd)
> +{
> +	pcmd->scsi_done(pcmd);
> +	return;
> +}

why this abstraction?


> +
> +/*
> +************************************************************************
> +**
> +**
> +************************************************************************
> +*/
> +static void arcmsr_flush_adapter_cache(PACB pACB)
> +{
> +#if ARCMSR_DEBUG0
> +	printk("arcmsr_flush_adapter_cache..............\n");
> +#endif
> +	CHIP_REG_WRITE32(&pACB->pmu->inbound_msgaddr0,
> +			 ARCMSR_INBOUND_MESG0_FLUSH_CACHE);


you probably want to take care of PCI posting on this one

> +	while (1) {
> +		if (pACB->pccbwait2go[i] == NULL) {
> +			pACB->pccbwait2go[i] = pCCB;
> +			atomic_inc(&pACB->ccbwait2gocount);
> +			spin_unlock_irqrestore(&pACB->wait2go_lockunlock, flag);
> +			return;
> +		}
> +		i++;
> +		i %= ARCMSR_MAX_OUTSTANDING_CMD;
> +	}

hmmmm this looks like a really long busy wait potentially.. especially
since irq's are off and the adapter can't send you any completion
interrupts

> +static u_int8_t arcmsr_wait_msgint_ready(PACB pACB)
> +{
> +	uint32_t Index;
> +	uint8_t Retries = 0x00;
> +	do {
> +		for (Index = 0; Index < 500000; Index++) {
> +			if (CHIP_REG_READ32(&pACB->pmu->outbound_intstatus) &
> +			    ARCMSR_MU_OUTBOUND_MESSAGE0_INT) {
> +				CHIP_REG_WRITE32(&pACB->pmu->outbound_intstatus, ARCMSR_MU_OUTBOUND_MESSAGE0_INT);	/*clear interrupt */
> +				return 0x00;
> +			}
> +			/* one us delay */
> +			udelay(10);
> +		}		/*max 5 seconds */

5 seconds of busy waiting is really really not nimce


> +	} while (Retries++ < 24);	/*max 2 minutes */

eh wait make that 2 minutes!



> +
> +				while (1) {
> +					int64_t span4G, length0;
> +					PSG64ENTRY pdma_sg = (PSG64ENTRY) psge;
> +
> +					span4G =
> +					    (int64_t) address_lo + tmplength;
> +					pdma_sg->addresshigh = address_hi;
> +					pdma_sg->address = address_lo;
> +					if (span4G > 0x100000000ULL) {
> +						/*see if cross 4G boundary */

the linux block layer will guarantee that that doesn't happen afaik


> +	rc = pci_set_dma_mask(pPCI_DEV, (dma_addr_t) 0x00000000ffffffffULL);	/*32bit */


> +	/* Attempt to claim larger area for request queue pCCB). */
> +	dma_coherent =
> +	    dma_alloc_coherent(&pPCI_DEV->dev,
> +			       ARCMSR_MAX_FREECCB_NUM * sizeof(struct _CCB) +
> +			       0x20, &dma_coherent_handle, GFP_KERNEL);
...
> +	rc = pci_set_dma_mask(pPCI_DEV, (dma_addr_t) 0xffffffffffffffffULL);	/*set dma 64bit again if could */


this is wrong! For this purpose there is a DIFFERENT mask that needs setting, and then you are guarenteed that all coherent allocations are 32
bit, no need to fiddle with the async pci mask at all




> +
> +#if defined(__SMP__) && !defined(CONFIG_SMP)
> +# define CONFIG_SMP
> +#endif

this is wrong; __SMP__ doesn't exist, nor should your driver care.


> +/*
> +*********************************************************************
> +*/
> +#if BITS_PER_LONG == 64
> +typedef uint64_t CPT2INT, *PCPT2INT;
> +#else
> +typedef uint32_t CPT2INT, *PCPT2INT;
> +#endif

this is very suspect and most likely wrong. You don't want to use this.


> +**********************************************************************************
> +*/
> +#define CHIP_REG_READ8(a)		                    (uint8_t)(readb((uint8_t *)(a)))
> +#define CHIP_REG_READ16(a)		                   (uint16_t)(readw((uint16_t *)(a)))
> +#define CHIP_REG_READ32(a)		                   (uint32_t)(readl((uint32_t *)(a)))
> +#define CHIP_REG_WRITE8(a,d)		               writeb((uint8_t)(d),(uint8_t *)(a))
> +#define CHIP_REG_WRITE16(a,d)		               writew((uint16_t)(d),(uint16_t *)(a))
> +#define CHIP_REG_WRITE32(a,d)	                   writel((uint32_t)(d),(uint32_t *)(a))

why these trivial abstractions ?

> +#define PCIVendorIDARECA                                             0x17D3	/* Vendor ID    */
> +#define PCIDeviceIDARC1110                                           0x1110	/* Device ID    */
> +#define PCIDeviceIDARC1120                                           0x1120	/* Device ID        */
> +#define PCIDeviceIDARC1130                                           0x1130	/* Device ID        */
> +#define PCIDeviceIDARC1160                                           0x1160	/* Device ID        */
> +#define PCIDeviceIDARC1170                                           0x1170	/* Device ID        */
> +#define PCIDeviceIDARC1210                                           0x1210	/* Device ID    */
> +#define PCIDeviceIDARC1220                                           0x1220	/* Device ID        */
> +#define PCIDeviceIDARC1230                                           0x1230	/* Device ID        */
> +#define PCIDeviceIDARC1260                                           0x1260	/* Device ID        */
> +#define PCIDeviceIDARC1270                                           0x1270	/* Device ID        */

these need to go into the global pci id header
> +/*
> +**********************************************************************************
> +**
> +**********************************************************************************
> +*/
> +#define dma_addr_hi32(a)           ((uint32_t) (0xffffffff & (((uint64_t)(a))>>32)))

it is better to do ((a>> 16)>>16) for this; that way it's always defined C and you need less casts and other magic

> +*********************************************************************
> +**                 Adapter Control Block
> +**
> +*********************************************************************
> +*/
> +typedef struct _ACB {
> +	struct pci_dev *pPCI_DEV;
> +	struct Scsi_Host *pScsiHost;
> +#if BITS_PER_LONG == 64
> +	uint64_t vir2phy_offset;	/* Offset is used in making arc cdb physical to virtual calculations */
> +#else
> +	uint32_t vir2phy_offset;	/* Offset is used in making arc cdb physical to virtual calculations */
> +#endif

then... why not use a long ???




