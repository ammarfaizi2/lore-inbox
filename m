Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWCHU1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWCHU1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWCHU1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:27:24 -0500
Received: from mxsf38.cluster1.charter.net ([209.225.28.165]:8416 "EHLO
	mxsf38.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932225AbWCHU1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:27:23 -0500
X-IronPort-AV: i="4.02,176,1139202000"; 
   d="scan'208"; a="1384481570:sNHT99864124"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.15913.86630.804012@smtp.charter.net>
Date: Wed, 8 Mar 2006 15:27:21 -0500
From: "John Stoffel" <john@stoffel.org>
To: Dan Aloni <da-x@monatomic.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_mv: stabilize for 5081 and other fixes
In-Reply-To: <20060308194627.GA22346@localdomain>
References: <20060308194627.GA22346@localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dan" == Dan Aloni <da-x@monatomic.org> writes:

Dan> With the patch below I've managed to stabilize the sata_mv driver 
Dan> running a Marvell 5081 SATA controller. Prior to these changes it
Dan> would cause sporadic memory corruptions right after insmod. I prefer 
Dan> this driver over Marvell's own driver which have all sorts of weird
Dan> bugs.

Cool!  Now I can think about SATA more seriously.  Now for some
comments on the patch itself, from a non-kernel hacker, so feel free
to blow me off.

Dan> --- drivers/scsi/sata_mv.c	2006-03-08 11:30:10.000000000 +0200
Dan> +++ drivers/scsi/sata_mv.c	2006-03-08 20:59:55.000000000 +0200
Dan> @@ -72,9 +72,10 @@
Dan>  	 */
Dan>  	MV_CRQB_Q_SZ		= (32 * MV_MAX_Q_DEPTH),
Dan>  	MV_CRPB_Q_SZ		= (8 * MV_MAX_Q_DEPTH),
Dan> -	MV_MAX_SG_CT		= 176,
Dan> +	MV_MAX_SG_CT		= 256,
Dan>  	MV_SG_TBL_SZ		= (16 * MV_MAX_SG_CT),
Dan> -	MV_PORT_PRIV_DMA_SZ	= (MV_CRQB_Q_SZ + MV_CRPB_Q_SZ + MV_SG_TBL_SZ),
Dan> +	MV_PORT_PRIV_DMA1_SZ	= (MV_CRQB_Q_SZ + MV_CRPB_Q_SZ),
Dan> +	MV_PORT_PRIV_DMA2_SZ	= (MV_SG_TBL_SZ),
 
I don't like these names for the reagions.  DMA1 and DMA2 mean
nothing.  Should be be something a little more descriptive?  And a
comment why you split them up would be good too.

Dan> +#pragma pack(1)

I don't see these used anywhere else in the kernel, they should
probably go.  

Dan> +
Dan>  /* Command ReQuest Block: 32B */
Dan>  struct mv_crqb {
Dan> -	u32			sg_addr;
Dan> -	u32			sg_addr_hi;
Dan> -	u16			ctrl_flags;
Dan> +	volatile u32			sg_addr;
Dan> +	volatile u32			sg_addr_hi;
Dan> +	volatile u16			ctrl_flags;
Dan>  	u16			ata_cmd[11];
Dan>  };
 
Dan>  /* Command ResPonse Block: 8B */
Dan>  struct mv_crpb {
Dan> -	u16			id;
Dan> -	u16			flags;
Dan> -	u32			tmstmp;
Dan> +	volatile u16			id;
Dan> +	volatile u16			flags;
Dan> +	volatile u32			tmstmp;
Dan>  };
 
Dan>  /* EDMA Physical Region Descriptor (ePRD); A.K.A. SG */
Dan>  struct mv_sg {
Dan> -	u32			addr;
Dan> -	u32			flags_size;
Dan> -	u32			addr_hi;
Dan> -	u32			reserved;
Dan> +	volatile u32			addr;
Dan> +	volatile u16			size;
Dan> +	volatile u16			flags;
Dan> +	volatile u32			addr_hi;
Dan> +	volatile u32			reserved;
Dan>  };
 
Dan> +#pragma pack(0)
Dan> +
Dan>  struct mv_port_priv {
Dan>  	struct mv_crqb		*crqb;
Dan>  	dma_addr_t		crqb_dma;
Dan> @@ -294,8 +300,8 @@
Dan>  };
 
Dan>  struct mv_port_signal {
Dan> -	u32			amps;
Dan> -	u32			pre;
Dan> +	volatile u32			amps;
Dan> +	volatile u32			pre;
Dan>  };
 
Dan>  struct mv_host_priv;
Dan> @@ -365,7 +371,7 @@
Dan>  	.eh_strategy_handler	= ata_scsi_error,
Dan>  	.can_queue		= MV_USE_Q_DEPTH,
Dan>  	.this_id		= ATA_SHT_THIS_ID,
Dan> -	.sg_tablesize		= MV_MAX_SG_CT / 2,
Dan> +	.sg_tablesize		= MV_MAX_SG_CT,
Dan>  	.max_sectors		= ATA_MAX_SECTORS,
Dan>  	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
Dan>  	.emulated		= ATA_SHT_EMULATED,
Dan> @@ -509,10 +515,7 @@
Dan>  	.reset_bus		= mv_reset_pci_bus,
Dan>  };
 
Dan> -/*
Dan> - * module options
Dan> - */
Dan> -static int msi;	      /* Use PCI msi; either zero (off, default) or non-zero */
Dan> +static int msi;              /* Use PCI msi; either zero (off, default) or non-zero */
 
 
Dan>  /*
Dan> @@ -770,7 +773,8 @@
 
Dan>  static inline void mv_priv_free(struct mv_port_priv *pp, struct device *dev)
Dan>  {
Dan> -	dma_free_coherent(dev, MV_PORT_PRIV_DMA_SZ, pp->crpb, pp->crpb_dma);
Dan> +	dma_free_coherent(dev, MV_PORT_PRIV_DMA1_SZ, pp->crpb, pp->crpb_dma);
Dan> +	dma_free_coherent(dev, MV_PORT_PRIV_DMA2_SZ, pp->sg_tbl, pp->sg_tbl_dma);
Dan>  }

Could you name these something like MV_PORT_CRPB_SZ and
MV_PORT_SGTBL_SZ instead?  Seems to make more sense here, and shows
exactly what they refer to.

 
Dan>  /**
Dan> @@ -788,8 +792,8 @@
Dan>  	struct device *dev = ap->host_set->dev;
Dan>  	struct mv_port_priv *pp;
Dan>  	void __iomem *port_mmio = mv_ap_base(ap);
Dan> -	void *mem;
Dan> -	dma_addr_t mem_dma;
Dan> +	void *mem, *mem2;
Dan> +	dma_addr_t mem_dma, mem_dma2;
Dan>  	int rc = -ENOMEM;
 
Dan>  	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
Dan> @@ -797,11 +801,17 @@
Dan>  		goto err_out;
Dan>  	memset(pp, 0, sizeof(*pp));
 
Dan> -	mem = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA_SZ, &mem_dma,
Dan> +	mem = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA1_SZ, &mem_dma,
Dan>  				 GFP_KERNEL);
Dan>  	if (!mem)
Dan>  		goto err_out_pp;
Dan> -	memset(mem, 0, MV_PORT_PRIV_DMA_SZ);
Dan> +	memset(mem, 0, MV_PORT_PRIV_DMA1_SZ);
Dan> +
Dan> +	mem2 = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA2_SZ, &mem_dma2,
Dan> +				 GFP_KERNEL);
Dan> +	if (!mem2)
Dan> +		goto err_out_pp_2;
Dan> +	memset(mem2, 0, MV_PORT_PRIV_DMA2_SZ);
 
Dan>  	rc = ata_pad_alloc(ap, dev);
Dan>  	if (rc)
Dan> @@ -820,14 +830,12 @@
Dan>  	 */
pp-> crpb = mem;
pp-> crpb_dma = mem_dma;
Dan> -	mem += MV_CRPB_Q_SZ;
Dan> -	mem_dma += MV_CRPB_Q_SZ;
 
Dan>  	/* Third item:
Dan>  	 * Table of scatter-gather descriptors (ePRD), 16 bytes each
Dan>  	 */
Dan> -	pp->sg_tbl = mem;
Dan> -	pp->sg_tbl_dma = mem_dma;
Dan> +	pp->sg_tbl = mem2;
Dan> +	pp->sg_tbl_dma = mem_dma2;
 
Dan>  	writelfl(EDMA_CFG_Q_DEPTH | EDMA_CFG_RD_BRST_EXT |
Dan>  		 EDMA_CFG_WR_BUFF_LEN, port_mmio + EDMA_CFG_OFS);
Dan> @@ -853,7 +861,9 @@
Dan>  	return 0;
 
Dan>  err_out_priv:
Dan> -	mv_priv_free(pp, dev);
Dan> +	dma_free_coherent(dev, MV_PORT_PRIV_DMA2_SZ, pp->sg_tbl, pp->sg_tbl_dma);
Dan> +err_out_pp_2:
Dan> +	dma_free_coherent(dev, MV_PORT_PRIV_DMA1_SZ, pp->crpb, pp->crpb_dma);
Dan>  err_out_pp:
Dan>  	kfree(pp);
Dan>  err_out:
Dan> @@ -915,13 +925,15 @@
 
pp-> sg_tbl[i].addr = cpu_to_le32(addr & 0xffffffff);
pp-> sg_tbl[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
Dan> -			pp->sg_tbl[i].flags_size = cpu_to_le32(len);
Dan> +			pp->sg_tbl[i].flags = cpu_to_le16(0);
Dan> +			pp->sg_tbl[i].size = cpu_to_le16(len);
Dan> +			pp->sg_tbl[i].reserved = 0;
 
Dan>  			sg_len -= len;
Dan>  			addr += len;
 
Dan>  			if (!sg_len && ata_sg_is_last(sg, qc))
Dan> -				pp->sg_tbl[i].flags_size |= cpu_to_le32(EPRD_FLAG_END_OF_TBL);
Dan> +				pp->sg_tbl[i].flags |= cpu_to_le16(EPRD_FLAG_END_OF_TBL);
 
Dan>  			i++;
Dan>  		}

John
