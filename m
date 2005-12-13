Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbVLMIoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVLMIoJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVLMIoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:44:09 -0500
Received: from proxy.seznam.cz ([212.80.76.5]:37896 "EHLO proxy.seznam.cz")
	by vger.kernel.org with ESMTP id S964805AbVLMIoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:44:07 -0500
Message-ID: <439E89A9.6070007@feix.cz>
Date: Tue, 13 Dec 2005 09:43:21 +0100
From: Michal Feix <michal@feix.cz>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [SCSI] SCSI block devices larger then 2TB
References: <4396B795.1000108@feix.cz> <20051207123519.GA17414@infradead.org> <Pine.LNX.4.62.0512121057070.267@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0512121057070.267@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Current aic79xxx driver doesn't see SCSI devices larger, then 2TB. It
>>> fails with READ CAPACITY(16) command. As far as I can understand, we
>>> already have LBD support in kernel for some time now. So it's only the
>>> drivers, that need to be fixed? LSI driver is the only one I found
>>> working with devices over 2TB; I couldn't test any other driver, as I
>>> don't have the hardware. Is it really so bad, that only LSI chipset
>> and
>>> maybe few others are capable of seeng such devices?
>>
>>
>> I definitly works fine with Qlogic parallel scsi and fibrechannel and
>> emulex
>> fibre channel controllers aswell as lsi/engenio megaraid controllers.
>>
>> It looks like aci79xx is just broken in that repsect. Unfortunately the
>> driver doesn't have a proper maintainer, we scsi developers put in fixes
>> and cleanups but we don't have the full documentation to fix such
>> complicated
>> issue.  If you have a support contract with Adaptec complain to them.
> 
> I was at a BOF at LISA last week on this subject, the guy running it 
> said that the common ultra320 chip used for parallel scsi doesn't 
> implment READ CAPACITY(16), but instead implemnets a propriatary READ 
> CAPACITY(12) which allows you to break the 2TB limit.
> 
> I asked him to send the patch that he's been maintaining seperatly (and 
> providing to his customers, he's a storage hardware vendor) to the list 
> to get integrated.
> 
> I'll see if I have any notes with his address on them, or you could 
> check the BOF schedule online to see if it got listed there.

Looks like there's more work to be done inside aic79xx driver. After I 
gave up on making my Adaptec host adapter sees my 6TB SCSI array as a 
whole, I hit another bug. When the array was sliced into 3 smaller 
blocks which fits the 2TB limit, I can see the array as 3 separate SCSI 
blokc devices, but it works only with Ultra160 speed and lower. When I 
choose Ultra320 on my SCSI array, the driver starts dumping following 
errors:

scsi1: Dumping Card State at program address 0x24 Mode 0x0
Card was paused
HS_MAILBOX[0x0] INTCTL[0x80]:(SWTMINTMASK) SEQINTSTAT[0x0]
SAVED_MODE[0x11] DFFSTAT[0x33]:(CURRFIFO_NONE|FIFO0FREE|FIFO1FREE)
SCSISIGI[0x24]:(P_DATAOUT_DT|BSYI) SCSIPHASE[0x0]
SCSIBUS[0x0] LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE)
SCSISEQ0[0x0] SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI)
SEQCTL0[0x0] SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0]
SSTAT0[0x0] SSTAT1[0x8]:(BUSFREE) SSTAT2[0x0] SSTAT3[0x0]
PERRDIAG[0x0] SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO)
LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80]:(PACKETIZED)
LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0xe1]:(LQOSTOP0|LQOPKT)

SCB Count = 4 CMDS_PENDING = 1 LASTSCB 0xffff CURRSCB 0x3 NEXTSCB 0xff00
qinstart = 58 qinfifonext = 58
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
   3 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x7]
Total 1
Kernel Free SCB list: 2 1 0
Sequencer Complete DMA-inprog list:
Sequencer Complete list:
Sequencer DMA-Up and Complete list:

scsi1: FIFO0 Free, LONGJMP == 0x8251, SCB 0x3
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS)
SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0]
SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR = 0x00, SHCNT = 0x0
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]:(SG_CACHE_AVAIL)
scsi1: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS)
SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0]
SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR = 0x00, SHCNT = 0x0
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]:(SG_CACHE_AVAIL)
LQIN: 0x8 0x0 0x0 0x3 0x0 0x1 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
0x0 0x0 0x0 0x0
scsi1: LQISTATE = 0x1, LQOSTATE = 0x0, OPTIONMODE = 0x52
scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1

SIMODE0[0xc]:(ENOVERRUN|ENIOERR)
CCSCBCTL[0x4]:(CCSCBDIR)
scsi1: REG0 == 0x7960, SINDEX = 0x102, DINDEX = 0x102
scsi1: SCBPTR == 0x3, SCB_NEXT == 0xff00, SCB_NEXT2 == 0xffdf
CDB 0 0 0 0 0 0
STACK: 0x13 0x0 0x0 0x0 0x0 0x0 0x0 0x0
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi1:0:0:2: Unable to deliver message
aic79xx_abort returns 0x2003
scsi1:0:0:2: Attempting to queue a TARGET RESET message:CDB: 0x0 0x0 0x0 
0x0 0x0 0x0
scsi1: At time of recovery, card was not paused
 >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State at program address 0x4 Mode 0x22
Card was paused
HS_MAILBOX[0x0] INTCTL[0x80]:(SWTMINTMASK) SEQINTSTAT[0x0]
SAVED_MODE[0x11] DFFSTAT[0x33]:(CURRFIFO_NONE|FIFO0FREE|FIFO1FREE)
SCSISIGI[0x24]:(P_DATAOUT_DT|BSYI) SCSIPHASE[0x0]
SCSIBUS[0x0] LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE)
SCSISEQ0[0x0] SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI)
SEQCTL0[0x0] SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0]
SSTAT0[0x0] SSTAT1[0x8]:(BUSFREE) SSTAT2[0x0] SSTAT3[0x0]
PERRDIAG[0x0] SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO)
LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80]:(PACKETIZED)
LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0xe1]:(LQOSTOP0|LQOPKT)

SCB Count = 4 CMDS_PENDING = 1 LASTSCB 0xffff CURRSCB 0x3 NEXTSCB 0xff00
qinstart = 58 qinfifonext = 58
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
   3 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x7]
Total 1
Kernel Free SCB list: 2 1 0
Sequencer Complete DMA-inprog list:
Sequencer Complete list:
Sequencer DMA-Up and Complete list:

scsi1: FIFO0 Free, LONGJMP == 0x8251, SCB 0x3
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS)
SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0]
SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR = 0x00, SHCNT = 0x0
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]:(SG_CACHE_AVAIL)
scsi1: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS)
SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0]
SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR = 0x00, SHCNT = 0x0
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]:(SG_CACHE_AVAIL)
LQIN: 0x8 0x0 0x0 0x3 0x0 0x1 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
0x0 0x0 0x0 0x0
scsi1: LQISTATE = 0x1, LQOSTATE = 0x0, OPTIONMODE = 0x52
scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1

SIMODE0[0xc]:(ENOVERRUN|ENIOERR)
CCSCBCTL[0x4]:(CCSCBDIR)
scsi1: REG0 == 0x3, SINDEX = 0x102, DINDEX = 0x102
scsi1: SCBPTR == 0xff03, SCB_NEXT == 0xff00, SCB_NEXT2 == 0x0
CDB 3 1 0 0 0 0
STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi1:0:0:2: Unable to deliver message
aic79xx_dev_reset returns 0x2003
scsi: Device offlined - not ready after error recovery: host 1 channel 0 
id 0 lun 2
scsi1 (0:2): rejecting I/O to offline device

This happens randomly after booting on various slices on the array.

After forcing Ultra160 as maximum speed on the SCSI array, driver works 
fine. If somebody is interested - the Array is Axus YI-16SAEU4 Ultra320 
SCSI to SATA II RAID Subsystem. Host is SuperServer 5015P-8R with 
integrated Adaptec AIC7902 Ultra320 SCSI adapter.

-- 
Michal Feix
michal@feix.cz
