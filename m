Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVEQWUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVEQWUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVEQWSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:18:52 -0400
Received: from mail0.lsil.com ([147.145.40.20]:40081 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262022AbVEQWN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:13:58 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57060CCE95@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>
Subject: RE: [PATCH 2.6.12-rc4-mm1 4/4] megaraid_sas: updating the driver
Date: Tue, 17 May 2005 18:12:56 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan, thank you for the feedback.

>On Mon, 2005-05-16 at 02:59 -0400, Bagalkote, Sreenivas wrote:
>> + *		This program is free software; you can redistribute it
>> and/or
>
>your mailer corrupts patches

Sorry about that.

>> +
>> +/**
>> + * MegaRAID SAS supported controllers
>> + */
>> +#define	PCI_DEVICE_LSI_1064			0x0411
>> +
>> +#define PCI_DEVICE_ID_DELL_PERC5		0x0015
>> +#define PCI_DEVICE_ID_DELL_SAS5			0x0054
>> +
>> +#define PCI_SUBSYSTEM_DELL_PERC5E		0x1F01
>> +#define PCI_SUBSYSTEM_DELL_PERC5I		0x1F02
>> +#define PCI_SUBSYSTEM_DELL_PERC5I_INTEGRATED	0x1F03
>> +#define PCI_SUBSYSTEM_DELL_SAS5I		0x1F05
>> +#define PCI_SUBSYSTEM_DELL_SAS5I_INTEGRATED	0x1F06
>> +
>> +#define PCI_SUB_DEVICEID_FSC			0x1081
>> +#define PCI_SUB_VENDORID_FSC			0x1734
>
>these really need to go into the generic pci id header

Does pci_ids.h accept subsystem device ids too?

>> +/*
>> + * SAS controller information
>> + */
>> +struct megasas_ctrl_info {
>> +
>> +	/*
>> +	 * PCI device information
>> +	 */
>> +	struct {
>> +
>> +		u16	vendor_id;
>> +		u16	device_id;
>> +		u16	sub_vendor_id;
>> +		u16	sub_device_id;
>> +		u8	reserved[24];
>> +
>> +	} __attribute__ ((packed)) pci;
>
>I hope you're not going to store pci config space into this; you really
>need to use the pci-> versions of these. Not doing so doesn't allow the
>kernel to compensate for quirks (like chipsets byteswapping config
>space ;)

No, I don't. I use this fw returned structure to get the maximum IO size.

>
>> +	u32	current_fw_time;
>
>what is this for ?

I don't look at any other values. Please see my comment above.

>
>> + * All MFI register set macros accept megasas_register_set*
>> + */
>> +#define RD_OB_MSG_0(regs)	readl((void*)(&(regs)->outbound_msg_0))
>> +#define WR_IN_MSG_0(v, regs)	
>writel((v),(void*)(&(regs)->inbound_msg_0))
>> +#define WR_IN_DOORBELL(v, regs)
>> writel((v),(void*)(&(regs)->inbound_doorbell))
>> +#define WR_IN_QPORT(v, regs)
>> writel((v),(void*)(&(regs)->inbound_queue_port))
>> +
>> +#define RD_OB_INTR_STATUS(regs)
>> readl((void*)(&(regs)->outbound_intr_status))
>> +#define WR_OB_INTR_STATUS(v, regs)
>> writel((v),(&(regs)->outbound_intr_status))
>
>why these (wrapped) abstractions ?

I will remove them.

>
>> +#define MFI_ENABLE_INTR(regs)
>> writel(1,(void*)(&(regs)->outbound_intr_mask))
>
>
>> +
>> +#define MFI_DISABLE_INTR(regs)				
>		\
>> +{								
>	\
>> +	u32 disable = ~0x00000001;				
>	\
>> +	u32 mask = readl((void*)(&(regs)->outbound_intr_mask));	\
>> +	mask &= disable;					
>	\
>> +	writel(mask, (void*)(&(regs)->outbound_intr_mask));	
>	\
>> +}
>
>you most likely want a PCI posting flush in this macro.
>Also I would actually suggest you make this an (inline) function.. much
>nicer. It's 4 lines already after all.
>

I will convert them into inline functions. I didn't understand your comment
about "PCI posting flush". Are you referring to memory barriers?

>
>> +
>> +
>> +struct megasas_register_set {
>> +
>> +	u32	reserved_0[4];			/*0000h*/
>> +
>> +	u32	inbound_msg_0;			/*0010h*/
>> +	u32	inbound_msg_1;			/*0014h*/
>> +	u32	outbound_msg_0;			/*0018h*/
>> +	u32	outbound_msg_1;			/*001Ch*/
>> +
>> +	u32	inbound_doorbell;		/*0020h*/
>> +	u32	inbound_intr_status;		/*0024h*/
>> +	u32	inbound_intr_mask;		/*0028h*/
>> +
>> +	u32	outbound_doorbell;		/*002Ch*/
>> +	u32	outbound_intr_status;		/*0030h*/
>> +	u32	outbound_intr_mask;		/*0034h*/
>> +
>> +	u32	reserved_1[2];			/*0038h*/
>> +
>> +	u32	inbound_queue_port;		/*0040h*/
>> +	u32	outbound_queue_port;		/*0044h*/
>> +
>> +	u32	reserved_2;			/*004Ch*/
>> +
>> +	u32	index_registers[1004];		/*0050h*/
>> +
>> +} __attribute__ ((packed));
>
>I guess these are shared with the hardware... isn't it better to use
>le32/be32 types then to have them have declared endianness ?
>

You are saying I should use __le32 instead of u32 (our HW is little
endian) for all these data types. Have I understood you correctly?

>
>> +
>> +struct megasas_sge32 {
>> +
>> +	u32	phys_addr;
>> +	u32	length;
>> +
>> +} __attribute__ ((packed));
>
>same here and for all other hardware-shared structs
>

Please see my question above.

>> +
>> +/*
>> + * Various conversion macros from SCSI command
>> + */
>
>ehhhh why? to make the driver unreadable ?
>

Same driver runs on 2.4 kernels. These macros minimize the differences
between both versions.

>> +#define SCP2HOST(scp)		(scp)->device->host	
>// to host
>> +#define SCP2HOSTDATA(scp)	SCP2HOST(scp)->hostdata	// to soft state
>> +#define SCP2CHANNEL(scp)	(scp)->device->channel	// to channel
>> +#define SCP2TARGET(scp)		(scp)->device->id	
>// to target
>> +#define SCP2LUN(scp)		(scp)->device->lun	
>// to LUN
>> +
>> +#define SCSIHOST2ADAP(host)	(((caddr_t *)(host->hostdata))[0])
>
>please don't use caddr_t in kerenl mode
>

Okay.

>> +#define SCP2ADAPTER(scp)	(struct
>> megasas_instance*)SCSIHOST2ADAP(SCP2HOST(scp))
>
>please if you think you need casts consider an inline function which
>supports proper typing of it's argument. Casting is a *great* way to
>hide bugs otherwise
>

Okay. I will make it an inline function.

Thanks,
Sreenivas
