Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbTL3FUr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 00:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265516AbTL3FUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 00:20:47 -0500
Received: from havoc.gtf.org ([63.247.75.124]:50852 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265501AbTL3FUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 00:20:41 -0500
Date: Tue, 30 Dec 2003 00:20:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Brad House <brad_mssw@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
Message-ID: <20031230052041.GA7007@gtf.org>
References: <65095.68.105.173.45.1072761027.squirrel@mail.mainstreetsoftworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65095.68.105.173.45.1072761027.squirrel@mail.mainstreetsoftworks.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 12:10:27AM -0500, Brad House wrote:
> In an attempt to fix a Gentoo user's problem, and get rid
> of compilation warnings for 64bit (on AMD64 mainly) megaraid
> compilation, I have created this patch, and needs some
> extensive testing.
> 
> The only thing I wasn't sure about was what unsigned integer
> was guaranteed to be the exact size of a pointer, and it seemed
> that looking in include/asm-x86_64/types.h that  dma_addr_t
> was the only one that fit the bill.

It's not this simple, unfortuantely...


> diff -ruN linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.c
> linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.c
> --- linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.c	2003-12-29
> 23:51:43.000000000 -0500
> +++ linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.c	2003-12-29
> 23:54:01.005469936 -0500
> @@ -1292,7 +1292,7 @@
> 
>  			/* Calculate Scatter-Gather info */
>  			mbox->m_out.numsgelements = mega_build_sglist(adapter, scb,
> -					(u32 *)&mbox->m_out.xferaddr, (u32 *)&seg);
> +					(dma_addr_t *)&mbox->m_out.xferaddr, (u32 *)&seg);

Casting just hides a bug.  The real fix is to pass a full 64-bit address
into the s/g list, if it supports 64-bit addresses.  if it doesn't, you
need to make sure the driver doesn't set highmem_io, make sure the
driver doesn't set a 64-bit DMA mask, and make sure the driver does set
a 32-bit DMA mask.


>  			return scb;
> 
> @@ -2262,7 +2262,7 @@
>   * Note: For 64 bit cards, we need a minimum of one SG element for
> read/write
>   */
>  static int
> -mega_build_sglist(adapter_t *adapter, scb_t *scb, u32 *buf, u32 *len)
> +mega_build_sglist(adapter_t *adapter, scb_t *scb, dma_addr_t *buf, u32 *len)
>  {
>  	struct scatterlist	*sgl;
>  	struct page	*page;
> @@ -2962,8 +2962,8 @@
>  			mbox->m_out.numsectors);
>  	len += sprintf(page+len, "  LBA          = 0x%02x\n",
>  			mbox->m_out.lba);
> -	len += sprintf(page+len, "  DTA          = 0x%08x\n",
> -			mbox->m_out.xferaddr);
> +	len += sprintf(page+len, "  DTA          = 0x%08lx\n",
> +			(unsigned long int)mbox->m_out.xferaddr);

just use 'unsigned long'.  Further, the printk() mask is wrong as it's
obviously longer than 8 chars on 64-bit.


>  	len += sprintf(page+len, "  Logical Drive= 0x%02x\n",
>  			mbox->m_out.logdrv);
>  	len += sprintf(page+len, "  No of SG Elmt= 0x%02x\n",
> @@ -4048,7 +4048,7 @@
>  	megacmd_t	mc;
>  	megastat_t	*ustats;
>  	int		num_ldrv;
> -	u32		uxferaddr = 0;
> +	dma_addr_t	uxferaddr = 0;
>  	struct pci_dev	*pdev;
> 
>  	ustats = NULL; /* avoid compilation warnings */
> diff -ruN linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.h
> linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.h
> --- linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.h	2003-12-29
> 23:51:43.000000000 -0500
> +++ linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.h	2003-12-29
> 23:54:01.005469936 -0500
> @@ -125,7 +125,7 @@
>  	/* 0x1 */ u8 cmdid;
>  	/* 0x2 */ u16 numsectors;
>  	/* 0x4 */ u32 lba;
> -	/* 0x8 */ u32 xferaddr;
> +	/* 0x8 */ dma_addr_t xferaddr;
>  	/* 0xC */ u8 logdrv;
>  	/* 0xD */ u8 numsgelements;
>  	/* 0xE */ u8 resvd;
> @@ -173,7 +173,7 @@
>  	u8 reqsensearea[MAX_REQ_SENSE_LEN];
>  	u8 numsgelements;
>  	u8 scsistatus;
> -	u32 dataxferaddr;
> +	dma_addr_t dataxferaddr;
>  	u32 dataxferlen;
>  } __attribute__ ((packed)) mega_passthru;
> 
> @@ -201,7 +201,7 @@
>  	u8 reqsenselen;
>  	u8 reqsensearea[MAX_REQ_SENSE_LEN];
>  	u8 rsvd4;
> -	u32 dataxferaddr;
> +	dma_addr_t dataxferaddr;
>  	u32 dataxferlen;
>  } __attribute__ ((packed)) mega_ext_passthru;
> 
> @@ -211,7 +211,7 @@
>  } __attribute__ ((packed)) mega_sgl64;
> 
>  typedef struct {
> -	u32 address;
> +	dma_addr_t address;
>  	u32 length;
>  } __attribute__ ((packed)) mega_sglist;
> 
> @@ -561,7 +561,7 @@
>  	u8	opcode;
>  	u8	subopcode;
>  	u32	lba;
> -	u32	xferaddr;
> +	dma_addr_t	xferaddr;
>  	u8	logdrv;
>  	u8	rsvd[3];
>  	u8	numstatus;
> @@ -1016,7 +1016,7 @@
>  static int mega_print_inquiry(char *, char *);
> 
>  static int mega_build_sglist (adapter_t *adapter, scb_t *scb,
> -			      u32 *buffer, u32 *length);
> +			      dma_addr_t *buffer, u32 *length);
>  static inline int mega_busywait_mbox (adapter_t *);
>  static int __mega_busywait_mbox (adapter_t *);
>  static void mega_rundoneq (adapter_t *);


Not that easy.  You gotta know the hardware (and firmware)...

	Jeff



