Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbTCTJ4a>; Thu, 20 Mar 2003 04:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbTCTJ4a>; Thu, 20 Mar 2003 04:56:30 -0500
Received: from portal.beam.ltd.uk ([62.49.82.227]:33693 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id <S261354AbTCTJ40>;
	Thu, 20 Mar 2003 04:56:26 -0500
Message-ID: <3E7992D7.1060000@beam.ltd.uk>
Date: Thu, 20 Mar 2003 10:07:19 +0000
From: Terry Barnaby <terry@beam.ltd.uk>
Organization: Beam Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, mmadore@aslab.com
Subject: Re: Reproducible SCSI Error with Adaptec 7902
References: <3E71B629.60204@beam.ltd.uk> <1999490000.1047653585@aslan.scsiguy.com> <3E71F9CB.706@beam.ltd.uk> <525730000.1047663245@aslan.btc.adaptec.com> <3E76EBD6.7070908@beam.ltd.uk> <3733590000.1048040125@aslan.scsiguy.com>
In-Reply-To: <3733590000.1048040125@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have continued to try and get to the bottom of the problem we have
with the Seagate ST336607LW drive with an Adaptec 7902 SCSI controller
under Linux on an SMP machine. We have recently tried the latest
Adaptec Linux driver (1.3.4) from Justin Gibbs who is one of the Adaptec
SCSI driver developers. This has stopped the drive locking up but now
lists SCSI errors in the log files. I enclose a portion of this log
file. I have run the error logs past Justin and he has stated:

"The drive has unexpectedly dropped off the bus during a connection.
Without a SCSI bus trace it is impossible to know why the drive might
have done this or if perhaps a glitch on the BSY line is causing the
controller to detect a spurious busfree."

My current conclusions are:

1. The Seagate ST336607LW drive has a bug where in certain circumstances
	the drive can lock up, with LED on. In this state it will not
	respond to a hardware reset and a power off/on cycle is needed to
	reset the drive. There is a difference between the way the Linux
	Adaptec AIC79XX 1.1.0 driver and the 1.3.4 driver handles a SCSI
	error condition that triggers this behaviour.

2. There is a problem with one of the following: The Seagate ST336607LW drive,
	the Adaptec 7902 SCSI controller on the SuperMicro X5DA8 Motherboard or
	the Linux AIC79XX driver that causes a SCSI bus fault.

I am now giving up with Seagate ST336607LW drive and intend to try a
Maxtor Atlas 10K IV drive instead.
I include this information to hopefully assist others who may encounter this
problem and to list the bugs so that those who are in a position to fix them
know about it.

Terry

-------------------------------------------------------------------------

The System:
System: Dual Xeon 2.4GHz system using SuperMicro X5DA8 Motherboard.
SCSI: Adaptec 7902 onboard dual channel SCSI controller
Disks: 2 off Quantum Atlas 10K2 18G (160LW), 1 of Quantum 9G (80LW)
Disks: 1 off Seagate ST336607LW 36G (320LW)
System: RedHat 7.3 with updates to 18/02/03
Kernel: 2.4.18-24.7.xsmp
Adaptec Driver: AIC79XX 1.0.0, 1.1.0 and 1.3.4

The problem with Adaptec Drivers 1.0.0 and 1.1.0
If I start off a disk to disk copy of a large amount of information,
after about 10mins the SCSI disk will lock up. I get the kernel message
"Saw underflow (16384 of 20480 bytes). Treated as error" followed by various
SCSI error messages. The SCSI disks LED remains on and it is impossible to
access the SCSI disk. Resetimg the system does not clear the SCSI disk LED and the SCSI
disk is not seen in the Adaptec BIOS on startup. A power off/on cycle
will clear the condition.

The problem with Adaptec Drivers 1.3.4
If I start off a disk to disk copy of a large amount of information,
after about 10mins I will get error messages in the system log /var/log/messages.
Log entries listed below:

Portion of Linux's /var/log/messages

Mar 16 05:20:39 beam kernel: kjournald starting.  Commit interval 5 seconds
Mar 16 05:20:39 beam kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,55), internal journal
Mar 16 05:20:39 beam kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar 16 05:30:29 beam kernel: kjournald starting.  Commit interval 5 seconds
Mar 16 05:30:29 beam kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,50), internal journal
Mar 16 05:30:29 beam kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar 16 05:33:11 beam kernel: scsi0: Unexpected PKT busfree condition
Mar 16 05:33:11 beam kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Mar 16 05:33:11 beam kernel: scsi0: Dumping Card State at program address 0x8f Mode 0x11
Mar 16 05:33:11 beam kernel: Card was paused
Mar 16 05:33:11 beam kernel: HS_MAILBOX[0x40] INTCTL[0xc0] SEQINTSTAT[0x0] SAVED_MODE[0x11]
Mar 16 05:33:11 beam kernel: DFFSTAT[0x0] SCSISIGI[0x26] SCSIPHASE[0x1] SCSIBUS[0x0]
Mar 16 05:33:11 beam kernel: LASTPHASE[0x1] SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x10]
Mar 16 05:33:11 beam kernel: SEQINTCTL[0x88] SEQ_FLAGS[0xc0] SEQ_FLAGS2[0x0] SSTAT0[0x0]
Mar 16 05:33:11 beam kernel: SSTAT1[0x19] SSTAT2[0x0] SSTAT3[0x80] PERRDIAG[0x0]
Mar 16 05:33:11 beam kernel: SIMODE1[0xa4] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x1]
Mar 16 05:33:11 beam kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x81]
Mar 16 05:33:11 beam kernel:
Mar 16 05:33:11 beam kernel: SCB Count = 240 CMDS_PENDING = 49 LASTSCB 0x46 CURRSCB 0x46 NEXTSCB 0xff80
Mar 16 05:33:11 beam kernel: qinstart = 30076 qinfifonext = 30076
Mar 16 05:33:11 beam kernel: QINFIFO:
Mar 16 05:33:11 beam kernel: WAITING_TID_QUEUES:
Mar 16 05:33:11 beam kernel: Pending list:
Mar 16 05:33:11 beam kernel:  38 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x26]
Mar 16 05:33:11 beam kernel:  32 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x20]
Mar 16 05:33:11 beam kernel:  79 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x4f]
Mar 16 05:33:11 beam kernel: 219 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xdb]
Mar 16 05:33:11 beam kernel: 216 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xd8]
Mar 16 05:33:11 beam kernel:  15 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xf]
Mar 16 05:33:11 beam kernel: 134 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x86]
Mar 16 05:33:11 beam kernel:  85 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x55]
Mar 16 05:33:11 beam kernel: 136 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x88]
Mar 16 05:33:11 beam kernel: 215 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xd7]
Mar 16 05:33:11 beam kernel:  12 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xc]
Mar 16 05:33:11 beam kernel: 106 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x6a]
Mar 16 05:33:11 beam kernel:  65 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x41]
Mar 16 05:33:11 beam kernel: 162 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xa2]
Mar 16 05:33:11 beam kernel: 112 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x70]
Mar 16 05:33:11 beam kernel:  66 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x42]
Mar 16 05:33:11 beam kernel: 137 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x89]
Mar 16 05:33:11 beam kernel: 146 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x92]
Mar 16 05:33:11 beam kernel: 203 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xcb]
Mar 16 05:33:11 beam kernel: 167 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xa7]
Mar 16 05:33:11 beam kernel: 133 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x85]
Mar 16 05:33:11 beam kernel: 117 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x75]
Mar 16 05:33:11 beam kernel: 154 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x9a]
Mar 16 05:33:11 beam kernel: 196 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xc4]
Mar 16 05:33:11 beam kernel: 138 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x8a]
Mar 16 05:33:11 beam kernel:  89 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x59]
Mar 16 05:33:11 beam kernel:  55 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x37]
Mar 16 05:33:11 beam kernel:   6 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x6]
Mar 16 05:33:11 beam kernel: 199 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xc7]
Mar 16 05:33:11 beam kernel: 166 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xa6]
Mar 16 05:33:11 beam kernel: 110 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x6e]
Mar 16 05:33:11 beam kernel: 155 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x9b]
Mar 16 05:33:11 beam kernel: 213 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xd5]
Mar 16 05:33:11 beam kernel: 212 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xd4]
Mar 16 05:33:11 beam kernel: 201 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xc9]
Mar 16 05:33:11 beam kernel:  56 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x38]
Mar 16 05:33:11 beam kernel:  10 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xa]
Mar 16 05:33:11 beam kernel:  16 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x10]
Mar 16 05:33:11 beam kernel:  13 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xd]
Mar 16 05:33:11 beam kernel:  68 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x44]
Mar 16 05:33:11 beam kernel: 206 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xce]
Mar 16 05:33:11 beam kernel: 198 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xc6]
Mar 16 05:33:11 beam kernel: 152 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x98]
Mar 16 05:33:11 beam kernel:  40 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x28]
Mar 16 05:33:11 beam kernel:  50 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x32]
Mar 16 05:33:11 beam kernel: 205 SCB_CONTROL[0x64] SCB_SCSIID[0x7] SCB_TAG[0xcd]
Mar 16 05:33:11 beam kernel: 142 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x8e]
Mar 16 05:33:11 beam kernel: 188 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0xbc]
Mar 16 05:33:11 beam kernel:  18 SCB_CONTROL[0x60] SCB_SCSIID[0x37] SCB_TAG[0x12]
Mar 16 05:33:11 beam kernel: Total 49
Mar 16 05:33:11 beam kernel: Kernel Free SCB list: 70 5 153 27 101 64 214 121 195 73 113 164 140 184 
63 120 192 163 190 127 30 41 180 171 143 218 14 128 46 35 179 156 197 147 118 4 108 204 31 45 130 
125 183 7 72 139 58 42 44 48 178 209 202 67 114 62 194 175 129 71 29 111 39 177 200 191 126 100 104 
26 33 157 36 189 78 93 141 9 43 145 207 22 150 1 19 222 86 69 59 105 165 8 149 119 11 107 132 208 2 
217 57 54 131 116 51 211 135 172 144 221 61 76 159 109 193 74 148 115 75 151 84 52 88 210 53 25 124 
223 47 123 186 181 185 187 83 90 80 182 77 81 176 87 173 95 91 174 82 170 94 168 97 92 169 98 160 99 
96 161 102 34 103 158 28 37 0 220 17 23 20 239 232 233 234 235 228 229 230 231 224 225 226 227 49 24 
60 3 21 122 238 237 236
Mar 16 05:33:11 beam kernel: Sequencer Complete DMA-inprog list:
Mar 16 05:33:11 beam kernel: Sequencer Complete list:
Mar 16 05:33:11 beam kernel: Sequencer DMA-Up and Complete list:
Mar 16 05:33:11 beam kernel:
Mar 16 05:33:11 beam kernel: scsi0: FIFO0 Active, LONGJMP == 0x8283, SCB 0xbc, LJSCB 0x8c
Mar 16 05:33:11 beam kernel: SEQIMODE[0x3f] SEQINTSRC[0x10] DFCNTRL[0x4] DFSTATUS[0x89]
Mar 16 05:33:11 beam kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]
Mar 16 05:33:11 beam kernel: SOFFCNT[0x3f] MDFFSTAT[0x2] SHADDR = 0x00, SHCNT = 0x0
Mar 16 05:33:11 beam kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]
Mar 16 05:33:11 beam kernel: scsi0: FIFO1 Active, LONGJMP == 0x25c, SCB 0x12, LJSCB 0x12
Mar 16 05:33:11 beam kernel: SEQIMODE[0x3f] SEQINTSRC[0x40] DFCNTRL[0xc] DFSTATUS[0x89]
Mar 16 05:33:11 beam kernel: SG_CACHE_SHADOW[0x23] SG_STATE[0x0] DFFSXFRCTL[0x0]
Mar 16 05:33:11 beam kernel: SOFFCNT[0x3f] MDFFSTAT[0x16] SHADDR = 0x02b85c000, SHCNT = 0x0
Mar 16 05:33:11 beam kernel: HADDR = 0x02b85c000, HCNT = 0x0 CCSGCTL[0x0]
Mar 16 05:33:11 beam kernel: LQIN: 0x5 0x0 0x0 0xbc 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x20 0x0 
0x0 0x0 0x2 0x0
Mar 16 05:33:11 beam kernel: scsi0: LQISTATE = 0x25, LQOSTATE = 0x0, OPTIONMODE = 0x42
Mar 16 05:33:11 beam kernel: scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
Mar 16 05:33:11 beam kernel: SIMODE0[0xc]
Mar 16 05:33:11 beam kernel: CCSCBCTL[0x0]
Mar 16 05:33:11 beam kernel: scsi0: REG0 == 0x60, SINDEX = 0x122, DINDEX = 0x108
Mar 16 05:33:11 beam kernel: scsi0: SCBPTR == 0x12, SCB_NEXT == 0xffc0, SCB_NEXT2 == 0xfffc
Mar 16 05:33:11 beam kernel: CDB 2a 0 0 80 20 e8
Mar 16 05:33:11 beam kernel: STACK: 0x2e 0x10 0x2e 0x10 0x1 0x25c 0x28f 0x255
Mar 16 05:33:11 beam kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Mar 16 05:33:11 beam kernel: DevQ(0:0:0): 0 waiting
Mar 16 05:33:11 beam kernel: DevQ(0:1:0): 0 waiting
Mar 16 05:33:11 beam kernel: DevQ(0:2:0): 0 waiting
Mar 16 05:33:11 beam kernel: DevQ(0:3:0): 0 waiting
Mar 16 05:37:55 beam kernel: kjournald starting.  Commit interval 5 seconds
Mar 16 05:37:55 beam kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,55), internal journal
Mar 16 05:37:55 beam kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar 16 05:47:40 beam kernel: kjournald starting.  Commit interval 5 seconds
Mar 16 05:47:40 beam kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,50), internal journal
Mar 16 05:47:40 beam kernel: EXT3-fs: mounted filesystem with ordered data mode.

Justin T. Gibbs wrote:
>>1. Would it be possible for you to look at the error message to see
>>what it is related to.
> 
> 
> The drive has unexpectedly dropped off the bus during a connection.
> Without a SCSI bus trace it is impossible to know why the drive might
> have done this or if perhaps a glitch on the BSY line is causing the
> controller to detect a spurious busfree.
> 
> 
>>2. Would it be possible to determine what may have locked up the drive
>>with the previous SCSI driver. I could feed this back to Seagate.
> 
> 
> I have my hands too full trying to replicate problems seen with the
> latest driver and debug their cause to go back and try and figure
> out what an old driver version might have done to upset a drive.
> 
> --
> Justin
> 

-- 
Dr Terry Barnaby                     BEAM Ltd
Phone: +44 1454 324512               Northavon Business Center, Dean Rd
Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
                       "Tandems are twice the fun !"

