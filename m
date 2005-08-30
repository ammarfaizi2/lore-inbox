Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVH3Dj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVH3Dj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 23:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVH3Dj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 23:39:26 -0400
Received: from mail.dvmed.net ([216.237.124.58]:46531 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750766AbVH3DjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 23:39:25 -0400
Message-ID: <4313D4D6.7080108@pobox.com>
Date: Mon, 29 Aug 2005 23:39:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Dan Malek <dan@embeddededge.com>, Pantelis Antoniou <panto@intracom.gr>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
References: <20050830024840.GA5381@dmt.cnet>
In-Reply-To: <20050830024840.GA5381@dmt.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> +static int voltage_set(int slot, int vcc, int vpp)
> +{
> +	u_int reg = 0;
> +
> +	switch(vcc) {
> +	case 0: break;
> +	case 33:
> +		reg |= BCSR1_PCVCTL4;
> +		break;
> +	case 50: 
> +		reg |= BCSR1_PCVCTL5;
> +		break;
> +	default: 
> +		return 1;
> +	}
> +
> +	switch(vpp) {
> +	case 0: break;
> +	case 33: 
> +	case 50:
> +		if(vcc == vpp)
> +			reg |= BCSR1_PCVCTL6;
> +		else
> +			return 1;
> +		break;
> +	case 120: 
> +		reg |= BCSR1_PCVCTL7;
> +	default:
> +		return 1;
> +	}
> +
> +	if(!((vcc == 50) || (vcc == 0)))
> +		return 1;
> +
> +	/* first, turn off all power */
> +
> +	*((uint *)RPX_CSR_ADDR) &= ~(BCSR1_PCVCTL4 | BCSR1_PCVCTL5
> +				     | BCSR1_PCVCTL6 | BCSR1_PCVCTL7);
> +
> +	/* enable new powersettings */
> +
> +	*((uint *)RPX_CSR_ADDR) |= reg;

Should use bus read/write functions, such as foo_readl() or iowrite32().

Don't use weird types in kernel code such as 'uint'.  Use the more 
explicitly-sized u32.


> +	return 0;
> +}
> +
> +#define socket_get(_slot_) PCMCIA_SOCKET_KEY_5V
> +#define hardware_enable(_slot_)  /* No hardware to enable */
> +#define hardware_disable(_slot_) /* No hardware to disable */
> +
> +#endif /* CONFIG_RPXCLASSIC */
> +
> +/* FADS Boards from Motorola                                               */
> +
> +#if defined(CONFIG_FADS)
> +
> +#define PCMCIA_BOARD_MSG "FADS"
> +
> +static int voltage_set(int slot, int vcc, int vpp)
> +{
> +	uint reg = 0;
> +
> +	switch(vcc) {
> +		case 0:
> +			break;
> +		case 33:
> +			reg |= BCSR1_PCCVCC0;
> +			break;
> +		case 50:
> +			reg |= BCSR1_PCCVCC1;
> +			break;
> +		default:
> +			return 1;
> +	}
> +
> +	switch(vpp) {
> +		case 0:
> +			break;
> +		case 33:
> +		case 50:
> +			if(vcc == vpp)
> +				reg |= BCSR1_PCCVPP1;
> +			else
> +				return 1;
> +			break;
> +		case 120:
> +			if ((vcc == 33) || (vcc == 50))
> +				reg |= BCSR1_PCCVPP0;
> +			else
> +				return 1;
> +		default:
> +			return 1;
> +	}
> +
> +	/* first, turn off all power */
> +	*((uint *)BCSR1) &= ~(BCSR1_PCCVCC_MASK | BCSR1_PCCVPP_MASK);
> +
> +	/* enable new powersettings */
> +	*((uint *)BCSR1) |= reg;

ditto

> +	return 0;
> +}
> +
> +#define socket_get(_slot_) PCMCIA_SOCKET_KEY_5V
> +
> +static void hardware_enable(int slot)
> +{
> +	*((uint *)BCSR1) &= ~BCSR1_PCCEN;
> +}

ditto

> +static void hardware_disable(int slot)
> +{
> +	*((uint *)BCSR1) |=  BCSR1_PCCEN;
> +}

etc.


> +/* ------------------------------------------------------------------------- */
> +/* Motorola MBX860                                                           */
> +
> +#if defined(CONFIG_MBX)
> +
> +#define PCMCIA_BOARD_MSG "MBX"
> +
> +static int voltage_set(int slot, int vcc, int vpp)
> +{
> +	unsigned char reg = 0;
> +
> +	switch(vcc) {
> +		case 0:
> +			break;
> +		case 33:
> +			reg |= CSR2_VCC_33;
> +			break;
> +		case 50:
> +			reg |= CSR2_VCC_50;
> +			break;
> +		default:
> +			return 1;
> +	}
> +
> +	switch(vpp) {
> +		case 0:
> +			break;
> +		case 33:
> +		case 50:
> +			if(vcc == vpp)
> +				reg |= CSR2_VPP_VCC;
> +			else
> +				return 1;
> +			break;
> +		case 120:
> +			if ((vcc == 33) || (vcc == 50))
> +				reg |= CSR2_VPP_12;
> +			else
> +				return 1;
> +		default:
> +			return 1;
> +	}
> +
> +	/* first, turn off all power */
> +	*((unsigned char *)MBX_CSR2_ADDR) &= ~(CSR2_VCC_MASK | CSR2_VPP_MASK);
> +
> +	/* enable new powersettings */
> +	*((unsigned char *)MBX_CSR2_ADDR) |= reg;

ditto.

also, use u8 not unsigned char.


> +	return 0;
> +}
> +
> +#define socket_get(_slot_) PCMCIA_SOCKET_KEY_5V
> +#define hardware_enable(_slot_)  /* No hardware to enable */
> +#define hardware_disable(_slot_) /* No hardware to disable */
> +
> +#endif /* CONFIG_MBX */
> +
> +#if defined(CONFIG_PRxK)
> +#include <asm/cpld.h>
> +extern volatile fpga_pc_regs *fpga_pc;
> +
> +#define PCMCIA_BOARD_MSG "MPC855T"
> +
> +static int voltage_set(int slot, int vcc, int vpp)
> +{
> +	unsigned char reg = 0;
> +	unsigned char regread;
> +	cpld_regs *ccpld = get_cpld();
> +
> +	switch(vcc) {
> +		case 0:
> +			break;
> +		case 33:
> +			reg |= PCMCIA_VCC_33;
> +			break;
> +		case 50:
> +			reg |= PCMCIA_VCC_50;
> +			break;
> +		default:
> +			return 1;
> +	}
> +
> +	switch(vpp) {
> +		case 0:
> +			break;
> +		case 33:
> +		case 50:
> +			if(vcc == vpp)
> +				reg |= PCMCIA_VPP_VCC;
> +			else
> +				return 1;
> +			break;
> +		case 120:
> +			if ((vcc == 33) || (vcc == 50))
> +				reg |= PCMCIA_VPP_12;
> +			else
> +				return 1;
> +		default:
> +			return 1;
> +	}
> +
> +	reg = reg >> (slot << 2);
> +	regread = ccpld->fpga_pc_ctl;
> +	if (reg != (regread & ((PCMCIA_VCC_MASK | PCMCIA_VPP_MASK) >> (slot << 2)))) {
> +		/* enable new powersettings */
> +		regread = regread & ~((PCMCIA_VCC_MASK | PCMCIA_VPP_MASK) >> (slot << 2));
> +		ccpld->fpga_pc_ctl = reg | regread;
> +		mdelay(100);

should be msleep() AFAICS


> +	return 0;
> +}
> +
> +#define socket_get(_slot_) PCMCIA_SOCKET_KEY_LV
> +#define hardware_enable(_slot_)  /* No hardware to enable */
> +#define hardware_disable(_slot_) /* No hardware to disable */
> +
> +#endif /* CONFIG_PRxK */
> +
> +static void m8xx_shutdown(void)
> +{
> +	u_int m, i;
> +	pcmcia_win_t *w;
> +
> +	for(i = 0; i < PCMCIA_SOCKETS_NO; i++){
> +		w = (void *) &((immap_t *)IMAP_ADDR)->im_pcmcia.pcmc_pbr0;
> +
> +		((immap_t *)IMAP_ADDR)->im_pcmcia.pcmc_pscr = 
> +			M8XX_PCMCIA_MASK(i); 
> +		((immap_t *)IMAP_ADDR)->im_pcmcia.pcmc_per 
> +			&= ~M8XX_PCMCIA_MASK(i);
> + 
> +		/* turn off interrupt and disable CxOE */
> +		M8XX_PGCRX(i) = M8XX_PGCRX_CXOE;
> +		
> +		/* turn off memory windows */
> +		for(m = 0; m < PCMCIA_MEM_WIN_NO; m++) {
> +			w->or = 0;  /* set to not valid */
> +			w++;
> +		}
> +		
> +		/* turn off voltage */
> +		voltage_set(i, 0, 0);
> +		
> +		/* disable external hardware */
> +		hardware_disable(i);
> +	}
> +
> +	free_irq(pcmcia_schlvl, NULL);

don't you want to free_irq() first?



> +}
> +
> +/* copied from tcic.c */
> +
> +static int m8xx_drv_suspend(struct device *dev, u32 state, u32 level)
> +{
> +        int ret = 0;
> +        if (level == SUSPEND_SAVE_STATE)
> +                ret = pcmcia_socket_dev_suspend(dev, state);
> +        return ret;
> +}
> +                                                                                       
> +static int m8xx_drv_resume(struct device *dev, u32 level)
> +{
> +        int ret = 0;
> +        if (level == RESUME_RESTORE_STATE)
> +                ret = pcmcia_socket_dev_resume(dev);
> +        return ret;
> +}
> +                                                                                       
> +static struct device_driver m8xx_driver = {
> +        .name = "m8xx-pcmcia",
> +        .bus = &platform_bus_type,
> +        .suspend = m8xx_drv_suspend,
> +        .resume = m8xx_drv_resume,
> +};
> +
> +static struct platform_device m8xx_device = {
> +        .name = "m8xx-pcmcia",
> +        .id = 0,
> +};
> +
> +static u_int pending_events[PCMCIA_SOCKETS_NO];
> +static spinlock_t pending_event_lock = SPIN_LOCK_UNLOCKED;
> +
> +static irqreturn_t m8xx_interrupt(int irq, void *dev, struct pt_regs *regs)
> +{
> +	socket_info_t *s;
> +	event_table_t *e;
> +	u_int i, events, pscr, pipr, per;
> +
> +	dprintk("Interrupt!\n");
> +	/* get interrupt sources */
> +
> +	pscr = ((immap_t *)IMAP_ADDR)->im_pcmcia.pcmc_pscr;
> +	pipr = ((immap_t *)IMAP_ADDR)->im_pcmcia.pcmc_pipr;
> +	per = ((immap_t *)IMAP_ADDR)->im_pcmcia.pcmc_per;
> +
> +	for(i = 0; i < PCMCIA_SOCKETS_NO; i++) {
> +		s = &socket[i];
> +		e = &s->events[0]; 
> +		events = 0;
> +
> +		while(e->regbit) {
> +			if(pscr & e->regbit)
> +				events |= e->eventbit;
> +	    
> +				e++;
> +		}
> +
> +		/* 
> +		 * report only if both card detect signals are the same 
> +		 * not too nice done, 
> +		 * we depend on that CD2 is the bit to the left of CD1...
> +		 */
> +		if(events & SS_DETECT)
> +			if(((pipr & M8XX_PCMCIA_CD2(i)) >> 1) ^
> +				(pipr & M8XX_PCMCIA_CD1(i)))
> +			{
> +				events &= ~SS_DETECT;
> +			}
> +
> +#ifdef PCMCIA_GLITCHY_CD
> +		/*
> +		 * I've experienced CD problems with my ADS board.
> +		 * We make an extra check to see if there was a
> +		 * real change of Card detection.
> +		 */
> +	  
> +		if((events & SS_DETECT) && 
> +		   ((pipr &
> +		     (M8XX_PCMCIA_CD2(i) | M8XX_PCMCIA_CD1(i))) == 0) &&
> +		   (s->state.Vcc | s->state.Vpp)) {
> +			events &= ~SS_DETECT;
> +			/*printk( "CD glitch workaround - CD = 0x%08x!\n",
> +				(pipr & (M8XX_PCMCIA_CD2(i) 
> +					 | M8XX_PCMCIA_CD1(i))));*/
> +		}
> +#endif
> +	  
> +		/* call the handler */
> +
> +		dprintk("slot %u: events = 0x%02x, pscr = 0x%08x, "
> +			"pipr = 0x%08x\n", 
> +			i, events, pscr, pipr);
> +  
> +		if(events) {
> +			spin_lock(&pending_event_lock);
> +			pending_events[i] |= events;
> +			spin_unlock(&pending_event_lock);
> +			/* 
> +			 * Turn off RDY_L bits in the PER mask on 
> +			 * CD interrupt receival.
> +			 *
> +			 * They can generate bad interrupts on the
> +			 * ACS4,8,16,32.   - marcelo
> +			 */
> +			per &= ~M8XX_PCMCIA_RDY_L(0);
> +			per &= ~M8XX_PCMCIA_RDY_L(1);
> +
> +			((immap_t *)IMAP_ADDR)->im_pcmcia.pcmc_per = per;
> +
> +			if (events)
> +				pcmcia_parse_events(&socket[i].socket, events);
> +		}
> +	}
> +	
> +	/* clear the interrupt sources */
> +	((immap_t *)IMAP_ADDR)->im_pcmcia.pcmc_pscr = pscr;

more direct memory writes which should be foo_writel()


> +	dprintk("Interrupt done.\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int m8xx_suspend(struct pcmcia_socket *sock)
> +{
> +	return m8xx_set_socket(sock, &dead_socket);
> +}
> +
> +static struct pccard_operations m8xx_services = {
> +	.init	= m8xx_sock_init,	
> +	.suspend = m8xx_suspend,
> +	.get_status = m8xx_get_status,
> +	.get_socket = m8xx_get_socket,
> +	.set_socket = m8xx_set_socket,
> +	.set_io_map = m8xx_set_io_map,
> +	.set_mem_map = m8xx_set_mem_map,
> +};
> +
> +static int __init m8xx_init(void)
> +{
> +	pcmcia_win_t *w;
> +	u_int i,m;
> +
> +	pcmcia_info("%s\n", version);
> +
> +	if (driver_register(&m8xx_driver))
> +		return -1;
> +
> +	pcmcia_info(PCMCIA_BOARD_MSG " using " PCMCIA_SLOT_MSG 
> +		    " with IRQ %u.\n", pcmcia_schlvl); 
> +
> +	/* Configure Status change interrupt */
> +
> +	if(request_irq(pcmcia_schlvl, m8xx_interrupt, 0, 
> +			  "m8xx_pcmcia", NULL)) {
> +		pcmcia_error("Cannot allocate IRQ %u for SCHLVL!\n", 
> +			     pcmcia_schlvl);
> +		return -1;
> +	}
> +
> +	w = (void *) &((immap_t *)IMAP_ADDR)->im_pcmcia.pcmc_pbr0;
> +
> +	((immap_t *)IMAP_ADDR)->im_pcmcia.pcmc_pscr = 
> +		M8XX_PCMCIA_MASK(0)| M8XX_PCMCIA_MASK(1); 
> +	((immap_t *)IMAP_ADDR)->im_pcmcia.pcmc_per 
> +		&= ~(M8XX_PCMCIA_MASK(0)| M8XX_PCMCIA_MASK(1));

ditto etc.

