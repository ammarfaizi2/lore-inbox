Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264418AbTL3G0l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 01:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbTL3G0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 01:26:40 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:61342 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S264418AbTL3G0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 01:26:31 -0500
Message-ID: <65025.68.105.173.45.1072765590.squirrel@mail.mainstreetsoftworks.com>
Date: Tue, 30 Dec 2003 01:26:30 -0500 (EST)
Subject: Re: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
From: "Brad House" <brad_mssw@gentoo.org>
To: <jgarzik@pobox.com>
In-Reply-To: <20031230052041.GA7007@gtf.org>
References: <65095.68.105.173.45.1072761027.squirrel@mail.mainstreetsoftworks.com>
        <20031230052041.GA7007@gtf.org>
X-Priority: 3
Importance: Normal
Cc: <brad_mssw@gentoo.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, I don't think this driver is as complex as others may
be to port.  But then again, I'm probably wrong b/c I'm mainly
a userland guy, not a kernel guy :/
But, nonetheless, I've made some changes:

>>  			/* Calculate Scatter-Gather info */
>>  			mbox->m_out.numsgelements = mega_build_sglist(adapter, scb,
>> -					(u32 *)&mbox->m_out.xferaddr, (u32 *)&seg);
>> +					(dma_addr_t *)&mbox->m_out.xferaddr, (u32 *)&seg);
>
> Casting just hides a bug.

Well, the  xferaddr is actually a dma_addr_t now, so that cast really
does nothing, the only reason it's there is because they previously
casted it as (u32 *).  I removed the cast just so it couldn't obscure
warnings, and it didn't.

Also, I use  dma_addr_t even though it may have nothing to do with dma
where it's used. I'm more familiar with userland stuff, so I wasn't sure
what to use. In userland I'd use  uintptr_t.

> The real fix is to pass a full 64-bit address

I did find a few instances where they recast the addresses,
which was improper, but it does appear that the original address
in the original driver was coming in as 64bit (dma_addr_t as originally
written), but were passing it around and casting it as a u32, so I
think the interfaces allowed for it to work, they just wrote it
unware of 64bit systems.

Also, they tried to stuff the address returned here :
ext_inq = pci_alloc_consistent(adapter->dev,
                                sizeof(mraid_ext_inquiry), &dma_handle);
(the dma_handle) into a u32 which I just fixed.

> into the s/g list, if it supports 64-bit addresses.  if it doesn't, you
> need to make sure the driver doesn't set highmem_io, make sure the
> driver doesn't set a 64-bit DMA mask, and make sure the driver does set
> a 32-bit DMA mask.

The driver already does this it appears, without me needing to do it,
Part of which is covered by this:
 /* Set the Mode of addressing to 64 bit if we can */
                if((adapter->flag & BOARD_64BIT)&&(sizeof(dma_addr_t) ==
8)) {
                        pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
                        adapter->has_64bit_addr = 1;
                }
                else  {
                        pci_set_dma_mask(pdev, 0xffffffff);
                        adapter->has_64bit_addr = 0;
                }


>
> Not that easy.  You gotta know the hardware (and firmware)...

The thing is the symptoms were that systems with > 4GB of RAM oddly
enough would cause major data corruption, but reducing it to 4GB would
solve the problem (mostly, still some oddities supposedly).  It seemed
like an addressing issue, and it was pretty blatant that the addresses
were being truncated, and that's what I was trying to solve.
Like I said, it partially works at this time, so I doubt there is anything
seriously wrong with the driver other than what I've fixed here, but
I could definately be wrong :/

I did find some more issues of casting though, which I've inlined below and
is located at :
http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/megaraid_64bit_patch-2.diff

-Brad


diff -ruN linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.c
linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.c
--- linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.c	2003-12-29
23:51:43.000000000 -0500
+++ linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.c	2003-12-30
01:32:55.253327136 -0500
@@ -742,7 +742,7 @@
 	 * if not succeeded, then issue MEGA_MBOXCMD_ADAPTERINQ command and
 	 * update enquiry3 structure
 	 */
-	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
+	mbox->m_out.xferaddr = adapter->buf_dma_handle;

 	inquiry3 = (mega_inquiry3 *)adapter->mega_buffer;

@@ -765,7 +765,7 @@

 		inq = &ext_inq->raid_inq;

-		mbox->m_out.xferaddr = (u32)dma_handle;
+		mbox->m_out.xferaddr = dma_handle;

 		/*issue old 0x04 command to adapter */
 		mbox->m_out.cmd = MEGA_MBOXCMD_ADPEXTINQ;
@@ -1292,7 +1292,7 @@

 			/* Calculate Scatter-Gather info */
 			mbox->m_out.numsgelements = mega_build_sglist(adapter, scb,
-					(u32 *)&mbox->m_out.xferaddr, (u32 *)&seg);
+					&mbox->m_out.xferaddr, (u32 *)&seg);

 			return scb;

@@ -2262,7 +2262,7 @@
  * Note: For 64 bit cards, we need a minimum of one SG element for
read/write
  */
 static int
-mega_build_sglist(adapter_t *adapter, scb_t *scb, u32 *buf, u32 *len)
+mega_build_sglist(adapter_t *adapter, scb_t *scb, dma_addr_t *buf, u32 *len)
 {
 	struct scatterlist	*sgl;
 	struct page	*page;
@@ -2292,12 +2292,12 @@
 		if( adapter->has_64bit_addr ) {
 			scb->sgl64[0].address = scb->dma_h_bulkdata;
 			scb->sgl64[0].length = cmd->request_bufflen;
-			*buf = (u32)scb->sgl_dma_addr;
+			*buf = scb->sgl_dma_addr;
 			*len = (u32)cmd->request_bufflen;
 			return 1;
 		}
 		else {
-			*buf = (u32)scb->dma_h_bulkdata;
+			*buf = scb->dma_h_bulkdata;
 			*len = (u32)cmd->request_bufflen;
 		}

@@ -2962,8 +2962,8 @@
 			mbox->m_out.numsectors);
 	len += sprintf(page+len, "  LBA          = 0x%02x\n",
 			mbox->m_out.lba);
-	len += sprintf(page+len, "  DTA          = 0x%08x\n",
-			mbox->m_out.xferaddr);
+	len += sprintf(page+len, "  DTA          = 0x%lx\n",
+			(unsigned long)mbox->m_out.xferaddr);
 	len += sprintf(page+len, "  Logical Drive= 0x%02x\n",
 			mbox->m_out.logdrv);
 	len += sprintf(page+len, "  No of SG Elmt= 0x%02x\n",
@@ -3599,7 +3599,7 @@
 		return len;
 	}

-	mc.xferaddr = (u32)disk_array_dma_handle;
+	mc.xferaddr = disk_array_dma_handle;

 	if( adapter->flag & BOARD_40LD ) {
 		mc.cmd = FC_NEW_CONFIG;
@@ -4048,7 +4048,7 @@
 	megacmd_t	mc;
 	megastat_t	*ustats;
 	int		num_ldrv;
-	u32		uxferaddr = 0;
+	dma_addr_t	uxferaddr = 0;
 	struct pci_dev	*pdev;

 	ustats = NULL; /* avoid compilation warnings */
@@ -4078,13 +4078,13 @@
 	switch( uioc.opcode ) {

 	case GET_DRIVER_VER:
-		if( put_user(driver_ver, (u32 *)uioc.uioc_uaddr) )
+		if( put_user(driver_ver, uioc.uioc_uaddr) )
 			return (-EFAULT);

 		break;

 	case GET_N_ADAP:
-		if( put_user(hba_count, (u32 *)uioc.uioc_uaddr) )
+		if( put_user(hba_count, uioc.uioc_uaddr) )
 			return (-EFAULT);

 		/*
@@ -4291,7 +4291,7 @@
 			memset(&mc, 0, sizeof(megacmd_t));

 			mc.cmd = MEGA_MBOXCMD_PASSTHRU;
-			mc.xferaddr = (u32)pthru_dma_hndl;
+			mc.xferaddr = pthru_dma_hndl;

 			/*
 			 * Issue the command
@@ -4374,7 +4374,7 @@

 			memcpy(&mc, MBOX(uioc), sizeof(megacmd_t));

-			mc.xferaddr = (u32)data_dma_hndl;
+			mc.xferaddr = data_dma_hndl;

 			/*
 			 * Issue the command
@@ -4636,7 +4636,7 @@

 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);

-	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
+	mbox->m_out.xferaddr = adapter->buf_dma_handle;

 	raw_mbox[0] = IS_BIOS_ENABLED;
 	raw_mbox[2] = GET_BIOS;
@@ -4675,7 +4675,7 @@

 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);

-	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
+	mbox->m_out.xferaddr = adapter->buf_dma_handle;

 	/*
 	 * Non-ROMB firware fail this command, so all channels
@@ -4730,7 +4730,7 @@

 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);

-	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
+	mbox->m_out.xferaddr = adapter->buf_dma_handle;

 	adapter->boot_ldrv_enabled = 0;
 	adapter->boot_ldrv = 0;
@@ -4936,7 +4936,7 @@

 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);

-	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
+	mbox->m_out.xferaddr = adapter->buf_dma_handle;

 	raw_mbox[0] = MAIN_MISC_OPCODE;
 	raw_mbox[2] = GET_MAX_SG_SUPPORT;
@@ -4981,7 +4981,7 @@

 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);

-	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
+	mbox->m_out.xferaddr = adapter->buf_dma_handle;

 	/*
 	 * Try to get the initiator id. This command will succeed iff the
@@ -5091,7 +5091,7 @@
 		mc.cmd = MEGA_MBOXCMD_ADPEXTINQ;
 	}

-	mc.xferaddr = (u32)dma_handle;
+	mc.xferaddr = dma_handle;

 	if ( mega_internal_command(adapter, LOCK_INT, &mc, NULL) != 0 ) {
 		return -1;
@@ -5174,13 +5174,13 @@
 	pthru->cdb[5] = 0;


-	pthru->dataxferaddr = (u32)buf_dma_handle;
+	pthru->dataxferaddr = buf_dma_handle;
 	pthru->dataxferlen = 256;

 	memset(&mc, 0, sizeof(megacmd_t));

 	mc.cmd = MEGA_MBOXCMD_PASSTHRU;
-	mc.xferaddr = (u32)pthru_dma_handle;
+	mc.xferaddr = pthru_dma_handle;

 	rval = mega_internal_command(adapter, LOCK_INT, &mc, pthru);

diff -ruN linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.h
linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.h
--- linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.h	2003-12-29
23:51:43.000000000 -0500
+++ linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.h	2003-12-30
01:32:55.257326528 -0500
@@ -125,7 +125,7 @@
 	/* 0x1 */ u8 cmdid;
 	/* 0x2 */ u16 numsectors;
 	/* 0x4 */ u32 lba;
-	/* 0x8 */ u32 xferaddr;
+	/* 0x8 */ dma_addr_t xferaddr;
 	/* 0xC */ u8 logdrv;
 	/* 0xD */ u8 numsgelements;
 	/* 0xE */ u8 resvd;
@@ -173,7 +173,7 @@
 	u8 reqsensearea[MAX_REQ_SENSE_LEN];
 	u8 numsgelements;
 	u8 scsistatus;
-	u32 dataxferaddr;
+	dma_addr_t dataxferaddr;
 	u32 dataxferlen;
 } __attribute__ ((packed)) mega_passthru;

@@ -201,7 +201,7 @@
 	u8 reqsenselen;
 	u8 reqsensearea[MAX_REQ_SENSE_LEN];
 	u8 rsvd4;
-	u32 dataxferaddr;
+	dma_addr_t dataxferaddr;
 	u32 dataxferlen;
 } __attribute__ ((packed)) mega_ext_passthru;

@@ -211,7 +211,7 @@
 } __attribute__ ((packed)) mega_sgl64;

 typedef struct {
-	u32 address;
+	dma_addr_t address;
 	u32 length;
 } __attribute__ ((packed)) mega_sglist;

@@ -561,7 +561,7 @@
 	u8	opcode;
 	u8	subopcode;
 	u32	lba;
-	u32	xferaddr;
+	dma_addr_t	xferaddr;
 	u8	logdrv;
 	u8	rsvd[3];
 	u8	numstatus;
@@ -1016,7 +1016,7 @@
 static int mega_print_inquiry(char *, char *);

 static int mega_build_sglist (adapter_t *adapter, scb_t *scb,
-			      u32 *buffer, u32 *length);
+			      dma_addr_t *buffer, u32 *length);
 static inline int mega_busywait_mbox (adapter_t *);
 static int __mega_busywait_mbox (adapter_t *);
 static void mega_rundoneq (adapter_t *);





