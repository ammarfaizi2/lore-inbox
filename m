Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVKXNFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVKXNFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 08:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVKXNFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 08:05:30 -0500
Received: from bernhard.xss.co.at ([193.80.108.69]:63430 "EHLO
	bernhard.xss.co.at") by vger.kernel.org with ESMTP id S1750756AbVKXNF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 08:05:28 -0500
Message-ID: <4385BA96.1080804@xss.co.at>
Date: Thu, 24 Nov 2005 14:05:26 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4.31 + aic79xx] SCSI error: Infinite interrupt loop, INTSTAT
 = 0
References: <43838ECC.5060204@xss.co.at> <20051124053952.GI11266@alpha.home.local>
In-Reply-To: <20051124053952.GI11266@alpha.home.local>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Willy,

many thanks for your reply!

Willy Tarreau schrieb:
> Hello Andreas,
> 
> On Tue, Nov 22, 2005 at 10:34:04PM +0100, Andreas Haumer wrote:
> 
[...]
> 
> I'm running linux-2.4.31 in 32 bit mode.
> 
> 
>> just for the record, I've checked 2.4.32 and the driver is exactly the
>> same as in 2.4.31.
> 
Ok.

> 
> root@setup:~ {521} $ lspci
> 
>> (...)
> 
> 01:03.0 SCSI storage controller: Adaptec ASC-29320ALP U320 (rev 10)
> 01:04.0 SCSI storage controller: Adaptec ASC-29320ALP U320 (rev 10)
> 02:06.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
> 02:06.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
> 
>> (...)
> 
>> I've never tried an adaptec U320 yet, only a few 29160 in various servers.
> 
I have tried the external RAID with the following controllers now:

Adaptec 29160 - works fine (with the aic7xxx driver)
Adaptec 29320ALP - does not work (tried with two different cards)
Adaptec 29320A - does not work

>> (...) 
> 
> Today I tried to integrate the external EonStor RAID and first
> it seemd to work fine, too. The system did find the devices
> and I could create a new volume group with several logical
> volumes out of them.
> 
> But as soon as I try to create a filesystem on the new logical
> volumes or do some other work with the devices, the SCSI driver
> goes berserk:
> 
> 
>> So could we say when you have very low traffic (device identification,
>> write a few sectors to create the volume), everything's OK, and when
>> you write larger amounts of data, the problem strikes ?
> 

The probability for SCSI timeouts and bus resets is higher with
higher bus activity. I did a lot of testing in the past few days
and sometimes (but not always) I get timeouts and bus resets even
when scanning the partition table in the initial ramdisk...

>> It may be possible that you have a termination and/or cable problem
>> and that the driver does not correctly recover from such a condition.
> 
I can not completely rule out bad SCSI cabling, but:

* I replaced cables
  -> problem remains the same
* I tried with three different 29320 controller boards (LP and non-LP)
  -> problem remains the same
* I tried with the original setup (cables, RAID device, server, software),
  but used a 29160 controller and it worked. But of course at a lower data
  transfer speed on the SCSI bus and with a different SCSI driver (aic7xxx)!

This is not a cheap setup: high quality SCSI cables and VHDCI connectors,
not-so-cheap external RAID and server, everything connected to an 2200VA
UPS, air conditioned computer room. SCSI bus termination is internal and
automatically handled by the RAID subsystem.
I can't rule out bad hardware, but to me it seems unlikely. I have set up
several similar systems in the past year (same server, same RAID subsystem)
and never had any problems.
This is the first one where I want to use those Adaptec 29320 controllers,
though... ;-)

[...]
> 
> I found some messages reporting similar problems on this
> list, a few weeks ago (beginning of October 2005). There
> was also a patch for the aic79xx driver mentioned, but I
> haven't found any report about it since then, so I don't
> know the status of the patch (it was for the 2.6 kernel,
> anyway, as far as I remember)
> 
> 
>> would you please send a link to this patch, or even the
>> whole thread if there were responses ?
> 
This was a thread crossposted on both linux-kernel and linux-scsi,
starting on September 28th, 2005 going until October 4th, 2005.
Subject was "Infinite interrupt loop, INTSTAT = 0"
(See http://marc.theaimsgroup.com/?l=linux-scsi&m=112791530210044&w=2)

A patch was posted by James Bottomley on October 3rd, 2004
(See http://marc.theaimsgroup.com/?l=linux-scsi&m=112837144508743&w=2)

> 
> What can I do to make the external RAID usable?
> Dump the Adaptec cards and replace them with something better?
> 
> 
>> I've heard several people tell me that they have no problem with LSI
>> logic cards, but as I don't have problems either with AIC79xx, I don't
>> know how that should be interpreted.
> 
I also have good experience with LSI Logic cards (Fusion MPT driver).
Yesterday I ordered several of them, I hope I'll get them soon so I
can do further tests.

> 
> Patch the driver?
> 
> 
>> There is a large patch from the driver's author on his site. In fact,
>> it's not really a patch, it's the whole driver directory. I've used
>> it for a long time now (a few years) in my kernels without any problem.
>> You may want to try it :
> 
>>   http://people.freebsd.org/~gibbs/linux/
> 
>> You can also get it as a patch from my tree :
> 
>>   http://w.ods.org/kernel/2.4-wt/2.4.31-wt1/patches-2.4.31-wt1/pool/aic79xx-20040522-linux-2.4.30-pre3.rediff
> 
I downloaded the driver from Justin's site (aic79xx-linux-2.4-20040522-tar.gz)
and compiled the driver for kernel 2.4.31. Compilation went well and without
errors or warnings. Driver version is 2.0.12 for the aic79xx driver.

With the new driver (v2.0.12) the problem basically remains the same, though the
messages are a little bit different:
[...]
Nov 24 13:15:37 setup kernel: SCSI subsystem driver Revision: 1.00
Nov 24 13:15:37 setup kernel: scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 2.0.12
Nov 24 13:15:37 setup kernel:         <Adaptec 29320A Ultra320 SCSI adapter>
Nov 24 13:15:37 setup kernel:         aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs
Nov 24 13:15:37 setup kernel:
Nov 24 13:15:37 setup kernel: scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 2.0.12
Nov 24 13:15:38 setup kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Nov 24 13:15:38 setup kernel:         aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs
Nov 24 13:15:38 setup kernel:
Nov 24 13:15:38 setup kernel: scsi2 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 2.0.12
Nov 24 13:15:38 setup kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Nov 24 13:15:38 setup kernel:         aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs
Nov 24 13:15:38 setup kernel:
Nov 24 13:15:38 setup kernel: blk: queue f7ae9a18, I/O limit 4095Mb (mask 0xffffffff)
Nov 24 13:15:38 setup kernel: (scsi1:A:0): 320.000MB/s transfers (160.000MHz DT|IU|RTI|QAS, 16bit)
Nov 24 13:15:38 setup kernel: (scsi2:A:5): 320.000MB/s transfers (160.000MHz DT|IU|RTI|QAS, 16bit)
Nov 24 13:15:38 setup kernel:   Vendor: MAXTOR    Model: ATLAS10K5_73SCA   Rev: JNZH
Nov 24 13:15:38 setup kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 24 13:15:38 setup kernel: blk: queue f7ae9818, I/O limit 4095Mb (mask 0xffffffff)
Nov 24 13:15:38 setup kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
Nov 24 13:15:38 setup kernel:   Vendor: MAXTOR    Model: ATLAS10K5_73SCA   Rev: JNZH
Nov 24 13:15:38 setup kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 24 13:15:38 setup kernel: blk: queue f7ae9618, I/O limit 4095Mb (mask 0xffffffff)
Nov 24 13:15:38 setup kernel: scsi2:A:5:0: Tagged Queuing enabled.  Depth 32
Nov 24 13:15:38 setup kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Nov 24 13:15:38 setup kernel: Attached scsi disk sdb at scsi2, channel 0, id 5, lun 0
Nov 24 13:15:38 setup kernel: SCSI device sda: 143666192 512-byte hdwr sectors (73557 MB)
Nov 24 13:15:38 setup kernel: Partition check:
Nov 24 13:15:38 setup kernel:  /dev/scsi/host1/bus0/target0/lun0: p1 p2
Nov 24 13:15:38 setup kernel: SCSI device sdb: 143666192 512-byte hdwr sectors (73557 MB)
Nov 24 13:15:38 setup kernel:  /dev/scsi/host2/bus0/target5/lun0: p1 p2
[...]
Messages for SW-RAID, LVM and network setup omitted.
[...]
Nov 24 13:17:27 setup kernel: scsi singledevice 0 0 0 0
Nov 24 13:17:27 setup kernel: blk: queue eef37618, I/O limit 4095Mb (mask 0xffffffff)
Nov 24 13:17:27 setup kernel:   Vendor: IFT scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
Nov 24 13:17:27 setup kernel:       Model: A16U-G2421        Rev: 342A
Nov 24 13:17:27 setup kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 24 13:17:27 setup kernel: blk: queue eef37418, I/O limit 4095Mb (mask 0xffffffff)
Nov 24 13:17:27 setup kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
Nov 24 13:17:27 setup kernel: Attached scsi disk sdc at scsi0, channel 0, id 0, lun 0
Nov 24 13:17:32 setup kernel: (scsi0:A:0): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
Nov 24 13:17:32 setup kernel: SCSI device sdc: 4096000000 512-byte hdwr sectors (2097152 MB)
Nov 24 13:17:32 setup kernel:  /dev/scsi/host0/bus0/target0/lun0: p1
Nov 24 13:18:56 setup kernel: scsi0: Recovery Initiated - Card was not paused
Nov 24 13:18:56 setup kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Nov 24 13:18:56 setup kernel: scsi0: Dumping Card State at program address 0x22 Mode 0x33
Nov 24 13:18:56 setup kernel: Card was paused
Nov 24 13:18:56 setup kernel: HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11]
Nov 24 13:18:56 setup kernel: DFFSTAT[0x24] SCSISIGI[0x24] SCSIPHASE[0x0] SCSIBUS[0x0]
Nov 24 13:18:56 setup kernel: LASTPHASE[0x1] SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x0]
Nov 24 13:18:56 setup kernel: SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x4] SSTAT0[0x0]
Nov 24 13:18:56 setup kernel: SSTAT1[0x8] SSTAT2[0x0] SSTAT3[0x80] PERRDIAG[0xc0]
Nov 24 13:18:56 setup kernel: SIMODE1[0xa4] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80]
Nov 24 13:18:56 setup kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0xe1]
Nov 24 13:18:56 setup kernel:
Nov 24 13:18:56 setup kernel: SCB Count = 32 CMDS_PENDING = 32 LASTSCB 0x1f CURRSCB 0x5 NEXTSCB 0xff80
Nov 24 13:18:56 setup kernel: qinstart = 236 qinfifonext = 236
Nov 24 13:18:56 setup kernel: QINFIFO:
Nov 24 13:18:56 setup kernel: WAITING_TID_QUEUES:
Nov 24 13:18:56 setup kernel: Pending list:
Nov 24 13:18:56 setup kernel:   5 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:   6 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:   7 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  30 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  26 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  31 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  25 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  29 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  27 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  28 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  21 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  20 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  22 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  18 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  14 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  23 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  17 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  16 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  24 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  19 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  10 FIFO_USE[0x1] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  15 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  11 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  12 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:  13 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:   4 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:   3 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:   1 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:   2 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:   0 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:   8 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel:   9 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:56 setup kernel: Total 32
Nov 24 13:18:56 setup kernel: Kernel Free SCB list:
Nov 24 13:18:56 setup kernel: Sequencer Complete DMA-inprog list:
Nov 24 13:18:56 setup kernel: Sequencer Complete list:
Nov 24 13:18:56 setup kernel: Sequencer DMA-Up and Complete list:
Nov 24 13:18:56 setup kernel: Sequencer On QFreeze and Complete list:
Nov 24 13:18:56 setup kernel:
Nov 24 13:18:56 setup kernel: scsi0: FIFO0 Active, LONGJMP == 0x261, SCB 0x13
Nov 24 13:18:56 setup kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0xc] DFSTATUS[0x89]
Nov 24 13:18:56 setup kernel: SG_CACHE_SHADOW[0xcb] SG_STATE[0x0] DFFSXFRCTL[0x0]
Nov 24 13:18:56 setup kernel: SOFFCNT[0x0] MDFFSTAT[0x16] SHADDR = 0x03287b000, SHCNT = 0x0
Nov 24 13:18:56 setup kernel: HADDR = 0x03287b000, HCNT = 0x0 CCSGCTL[0x10]
Nov 24 13:18:56 setup kernel: scsi0: FIFO1 Free, LONGJMP == 0x80ff, SCB 0x4
Nov 24 13:18:56 setup kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]
Nov 24 13:18:56 setup kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]
Nov 24 13:18:56 setup kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0
Nov 24 13:18:56 setup kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]
Nov 24 13:18:56 setup kernel: LQIN: 0x4 0x0 0x0 0x13 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x10 0x0 0x0 0x0 0x0 0x0
Nov 24 13:18:56 setup kernel: scsi0: LQISTATE = 0x2a, LQOSTATE = 0x0, OPTIONMODE = 0x52
Nov 24 13:18:56 setup kernel: scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
Nov 24 13:18:56 setup kernel: SIMODE0[0xc]
Nov 24 13:18:56 setup kernel: CCSCBCTL[0x4]
Nov 24 13:18:56 setup kernel: scsi0: REG0 == 0x6, SINDEX = 0x102, DINDEX = 0x102
Nov 24 13:18:56 setup kernel: scsi0: SCBPTR == 0x5, SCB_NEXT == 0xff80, SCB_NEXT2 == 0xff2b
Nov 24 13:18:56 setup kernel: CDB 2a 0 1 6c 0 3f
Nov 24 13:18:56 setup kernel: STACK: 0x1e 0x0 0x0 0x0 0x0 0x0 0x0 0x0
Nov 24 13:18:57 setup kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Nov 24 13:18:57 setup kernel: scsi0: Host Status: Failed(0)
Nov 24 13:18:57 setup kernel: DevQ(0:0:0): 0 waiting
Nov 24 13:18:57 setup kernel: (scsi0:A:0:0): SCB 0x5 - timed out
Nov 24 13:18:57 setup kernel: (scsi0:A:0:0): BDR message in message buffer
Nov 24 13:18:58 setup kernel: scsi0: Recovery Initiated - Card was not paused
Nov 24 13:18:58 setup kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Nov 24 13:18:58 setup kernel: scsi0: Dumping Card State at program address 0x9 Mode 0x33
Nov 24 13:18:58 setup kernel: Card was paused
Nov 24 13:18:58 setup kernel: HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11]
Nov 24 13:18:58 setup kernel: DFFSTAT[0x24] SCSISIGI[0x34] SCSIPHASE[0x0] SCSIBUS[0x0]
Nov 24 13:18:58 setup kernel: LASTPHASE[0x1] SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x0]
Nov 24 13:18:58 setup kernel: SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x4] SSTAT0[0x0]
Nov 24 13:18:58 setup kernel: SSTAT1[0x8] SSTAT2[0x0] SSTAT3[0x80] PERRDIAG[0xc0]
Nov 24 13:18:58 setup kernel: SIMODE1[0xa4] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80]
Nov 24 13:18:58 setup kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0xe1]
Nov 24 13:18:58 setup kernel:
Nov 24 13:18:58 setup kernel: SCB Count = 32 CMDS_PENDING = 32 LASTSCB 0x1f CURRSCB 0x5 NEXTSCB 0xff80
Nov 24 13:18:58 setup kernel: qinstart = 236 qinfifonext = 236
Nov 24 13:18:58 setup kernel: QINFIFO:
Nov 24 13:18:58 setup kernel: WAITING_TID_QUEUES:
Nov 24 13:18:58 setup kernel: Pending list:
Nov 24 13:18:58 setup kernel:   5 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:   6 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:   7 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  30 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  26 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  31 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  25 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  29 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  27 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  28 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  21 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  20 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  22 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  18 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  14 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  23 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  17 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  16 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  24 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  19 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  10 FIFO_USE[0x1] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  15 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  11 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  12 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:  13 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:   4 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:   3 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:   1 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:   2 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:   0 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:   8 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel:   9 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7]
Nov 24 13:18:58 setup kernel: Total 32
Nov 24 13:18:58 setup kernel: Kernel Free SCB list:
Nov 24 13:18:58 setup kernel: Sequencer Complete DMA-inprog list:
Nov 24 13:18:58 setup kernel: Sequencer Complete list:
Nov 24 13:18:58 setup kernel: Sequencer DMA-Up and Complete list:
Nov 24 13:18:58 setup kernel: Sequencer On QFreeze and Complete list:
Nov 24 13:18:58 setup kernel:
Nov 24 13:18:58 setup kernel: scsi0: FIFO0 Active, LONGJMP == 0x261, SCB 0x13
Nov 24 13:18:58 setup kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0xc] DFSTATUS[0x89]
Nov 24 13:18:59 setup kernel: SG_CACHE_SHADOW[0xcb] SG_STATE[0x0] DFFSXFRCTL[0x0]
Nov 24 13:18:59 setup kernel: SOFFCNT[0x0] MDFFSTAT[0x16] SHADDR = 0x03287b000, SHCNT = 0x0
Nov 24 13:18:59 setup kernel: HADDR = 0x03287b000, HCNT = 0x0 CCSGCTL[0x10]
Nov 24 13:18:59 setup kernel: scsi0: FIFO1 Free, LONGJMP == 0x80ff, SCB 0x4
Nov 24 13:18:59 setup kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]
Nov 24 13:18:59 setup kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]
Nov 24 13:18:59 setup kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0
Nov 24 13:18:59 setup kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]
Nov 24 13:18:59 setup kernel: LQIN: 0x4 0x0 0x0 0x13 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x10 0x0 0x0 0x0 0x0 0x0
Nov 24 13:18:59 setup kernel: scsi0: LQISTATE = 0x2a, LQOSTATE = 0x0, OPTIONMODE = 0x52
Nov 24 13:18:59 setup kernel: scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
Nov 24 13:18:59 setup kernel: SIMODE0[0xc]
Nov 24 13:18:59 setup kernel: CCSCBCTL[0x4]
Nov 24 13:18:59 setup kernel: scsi0: REG0 == 0x6, SINDEX = 0x102, DINDEX = 0x102
Nov 24 13:18:59 setup kernel: scsi0: SCBPTR == 0x5, SCB_NEXT == 0xff80, SCB_NEXT2 == 0xff2b
Nov 24 13:18:59 setup kernel: CDB 2a 0 1 6c 0 3f
Nov 24 13:18:59 setup kernel: STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
Nov 24 13:18:59 setup kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Nov 24 13:18:59 setup kernel: scsi0: Host Status: Failed(0) host_self_blocked
Nov 24 13:18:59 setup kernel: DevQ(0:0:0): 0 waiting
Nov 24 13:18:59 setup kernel: (scsi0:A:0:0): SCB 0x5 - timed out
Nov 24 13:18:59 setup kernel: Recovery SCB completes
Nov 24 13:18:59 setup kernel: scsi0: Issued Channel A Bus Reset. 32 SCBs aborted
Nov 24 13:19:13 setup kernel: (scsi0:A:0): 3.300MB/s transfers
Nov 24 13:19:13 setup kernel: scsi0: Returning to Idle Loop
Nov 24 13:19:38 setup kernel: (scsi0:A:0): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
Nov 24 13:20:08 setup kernel: scsi0: Recovery Initiated - Card was not paused
[...]

And so on...

I have now run out of test hardware. For further testing
I'll have to wait until the new LSI Logic controllers arrive,
hopefully until tomorrow.

Any other idea?

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDhbqSxJmyeGcXPhERAr2VAJ9VnlWM8jMR/UXNaDqVeg/aZr7bEwCgm5ED
fld7SP7skPCRwQ9N0z/QNKw=
=xonw
-----END PGP SIGNATURE-----
