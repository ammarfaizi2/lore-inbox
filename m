Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVEPIdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVEPIdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 04:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVEPIcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 04:32:02 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8102 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261456AbVEPHkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 03:40:12 -0400
Subject: Re: [PATCH 2.6.12-rc4-mm1 4/4] megaraid_sas: updating the driver
From: Arjan van de Ven <arjan@infradead.org>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57060CCE7D@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E57060CCE7D@exa-atlanta>
Content-Type: text/plain
Date: Mon, 16 May 2005 09:40:07 +0200
Message-Id: <1116229207.6274.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 02:59 -0400, Bagalkote, Sreenivas wrote:
> + *		This program is free software; you can redistribute it
> and/or

your mailer corrupts patches
> +
> +/**
> + * MegaRAID SAS supported controllers
> + */
> +#define	PCI_DEVICE_LSI_1064			0x0411
> +
> +#define PCI_DEVICE_ID_DELL_PERC5		0x0015
> +#define PCI_DEVICE_ID_DELL_SAS5			0x0054
> +
> +#define PCI_SUBSYSTEM_DELL_PERC5E		0x1F01
> +#define PCI_SUBSYSTEM_DELL_PERC5I		0x1F02
> +#define PCI_SUBSYSTEM_DELL_PERC5I_INTEGRATED	0x1F03
> +#define PCI_SUBSYSTEM_DELL_SAS5I		0x1F05
> +#define PCI_SUBSYSTEM_DELL_SAS5I_INTEGRATED	0x1F06
> +
> +#define PCI_SUB_DEVICEID_FSC			0x1081
> +#define PCI_SUB_VENDORID_FSC			0x1734

these really need to go into the generic pci id header
> +/*
> + * SAS controller information
> + */
> +struct megasas_ctrl_info {
> +
> +	/*
> +	 * PCI device information
> +	 */
> +	struct {
> +
> +		u16	vendor_id;
> +		u16	device_id;
> +		u16	sub_vendor_id;
> +		u16	sub_device_id;
> +		u8	reserved[24];
> +
> +	} __attribute__ ((packed)) pci;

I hope you're not going to store pci config space into this; you really
need to use the pci-> versions of these. Not doing so doesn't allow the
kernel to compensate for quirks (like chipsets byteswapping config
space ;)

> +	u32	current_fw_time;

what is this for ?

> + * All MFI register set macros accept megasas_register_set*
> + */
> +#define RD_OB_MSG_0(regs)	readl((void*)(&(regs)->outbound_msg_0))
> +#define WR_IN_MSG_0(v, regs)	writel((v),(void*)(&(regs)->inbound_msg_0))
> +#define WR_IN_DOORBELL(v, regs)
> writel((v),(void*)(&(regs)->inbound_doorbell))
> +#define WR_IN_QPORT(v, regs)
> writel((v),(void*)(&(regs)->inbound_queue_port))
> +
> +#define RD_OB_INTR_STATUS(regs)
> readl((void*)(&(regs)->outbound_intr_status))
> +#define WR_OB_INTR_STATUS(v, regs)
> writel((v),(&(regs)->outbound_intr_status))

why these (wrapped) abstractions ?

> +#define MFI_ENABLE_INTR(regs)
> writel(1,(void*)(&(regs)->outbound_intr_mask))


> +
> +#define MFI_DISABLE_INTR(regs)						\
> +{									\
> +	u32 disable = ~0x00000001;					\
> +	u32 mask = readl((void*)(&(regs)->outbound_intr_mask));	\
> +	mask &= disable;						\
> +	writel(mask, (void*)(&(regs)->outbound_intr_mask));		\
> +}

you most likely want a PCI posting flush in this macro.
Also I would actually suggest you make this an (inline) function.. much
nicer. It's 4 lines already after all.


> +
> +
> +struct megasas_register_set {
> +
> +	u32	reserved_0[4];			/*0000h*/
> +
> +	u32	inbound_msg_0;			/*0010h*/
> +	u32	inbound_msg_1;			/*0014h*/
> +	u32	outbound_msg_0;			/*0018h*/
> +	u32	outbound_msg_1;			/*001Ch*/
> +
> +	u32	inbound_doorbell;		/*0020h*/
> +	u32	inbound_intr_status;		/*0024h*/
> +	u32	inbound_intr_mask;		/*0028h*/
> +
> +	u32	outbound_doorbell;		/*002Ch*/
> +	u32	outbound_intr_status;		/*0030h*/
> +	u32	outbound_intr_mask;		/*0034h*/
> +
> +	u32	reserved_1[2];			/*0038h*/
> +
> +	u32	inbound_queue_port;		/*0040h*/
> +	u32	outbound_queue_port;		/*0044h*/
> +
> +	u32	reserved_2;			/*004Ch*/
> +
> +	u32	index_registers[1004];		/*0050h*/
> +
> +} __attribute__ ((packed));

I guess these are shared with the hardware... isn't it better to use
le32/be32 types then to have them have declared endianness ?


> +
> +struct megasas_sge32 {
> +
> +	u32	phys_addr;
> +	u32	length;
> +
> +} __attribute__ ((packed));

same here and for all other hardware-shared structs

> +
> +/*
> + * Various conversion macros from SCSI command
> + */

ehhhh why? to make the driver unreadable ?

> +#define SCP2HOST(scp)		(scp)->device->host	// to host
> +#define SCP2HOSTDATA(scp)	SCP2HOST(scp)->hostdata	// to soft state
> +#define SCP2CHANNEL(scp)	(scp)->device->channel	// to channel
> +#define SCP2TARGET(scp)		(scp)->device->id	// to target
> +#define SCP2LUN(scp)		(scp)->device->lun	// to LUN
> +
> +#define SCSIHOST2ADAP(host)	(((caddr_t *)(host->hostdata))[0])

please don't use caddr_t in kerenl mode

> +#define SCP2ADAPTER(scp)	(struct
> megasas_instance*)SCSIHOST2ADAP(SCP2HOST(scp))

please if you think you need casts consider an inline function which
supports proper typing of it's argument. Casting is a *great* way to
hide bugs otherwise



