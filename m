Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271310AbTG2Hkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 03:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271302AbTG2Hko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 03:40:44 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:4723 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S271310AbTG2HkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 03:40:13 -0400
Date: Tue, 29 Jul 2003 10:39:48 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Cc: gibbs@scsiguy.com, Jani Forssell <jani.forssell@viasys.com>
Subject: 2.4.21-jam1, aic7xxx-6.2.36: solid hangs, crashes on boot
Message-ID: <20030729073948.GD204266@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org, gibbs@scsiguy.com,
	Jani Forssell <jani.forssell@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After about a year of stable operation, a server begun acting up. First it
begun hanging up solid during the nightly oracle backup (that had run
successfully for a year), the I got some aic7xxx-related crashes on boot.

Initially, the box ran 2.4.20pre7 kernel with aic7xxx version 6.4.8. When
the hangs started happening, I upgraded to 2.4.21-jam1 (basically 2.4.21
vanilla + -aa patch + some minor stuff) that includes aic7xxx version 6.2.36.
It did not help.

I enabled kmsgdump and nmi watchdog, but when the box hangs, it hangs solid:
no ctrl-alt-del, no caps lock led, no alt-sysrq-b, no kmsgdump, nmi watchdog
doesn't trigger. Only the cursor on the console blinks, but no messages from
the kernel appear. (Apart from "spurious 8259A interrupt: IRQ7." that
always happens sometime after boot on this box, but way before the hang.)

After upgrading to 2.4.21-jam1, the box usually boots up fine, but twice
I've gotten the crash below. 

After a reset, the box boots up fine (fsck goes through, no corruption), but
it seems little more prone to lock up soon after a hang-and-reset. I made it
hang three times on a row by just compiling kernel, but then on fourth boot,
no amount of IO abuse got it on its knees -- until after a week it hung
during the nightly backup.

Any ideas on how to to debug this kind of hang? Does it sound kernel/driver
or hw related? Are the two crashes related to the hang? Is the hang related
to aic7xxx?

One more detail: with the 2.4.20pre7/aic7xxx-6.2.8 kernel, I got "Panic:
 HOST_MSG_LOOP with invalid SCB 0" crashes every now and then. Justin Gibbs
said: "it looks like memory mapped I/O simply does not work reliably on this
board", and recommended forcing programmed I/O (by undefining MMAPIO from
aic7xxx_osm_pci.c). That seemed to cure the problems -- until now. 

linux-2.2.18pre18 + aic7xxx-5.1.31 was rock stable on this box.


-- v --

v@iki.fi


Hardware:
---------------------------------------------------------------------------
Intel 815EEA2LU (i815 Chipset)
Celeron 1.3GHz (Tualatin)
Adaptec AHA-2940 / AIC-7871
  - Disk (rootfs) SEAGATE  Model: ST19171W Rev: 0024
  - Tape Drive    HP       Model: C1537A Rev: L708
30GB IDE disk (scratch)
---------------------------------------------------------------------------



Dump of crash on boot:
---------------------------------------------------------------------------
<4> 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4>Pending list: 
<4>  4 SCB_CONTROL[0x74] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>  0 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>Kernel Free SCB list: 8 7 6 9 1 2 5 
<4>DevQ(0:0:0): 0 waiting
<4>DevQ(0:2:0): 0 waiting
<4>
<4><<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
<4>scsi0:0:0:0: Device is active, asserting ATN
<4>Recovery code sleeping
<4>Recovery code awake
<4>Timer Expired
<4>aic7xxx_abort returns 0x2003
<4>scsi0:0:0:0: Attempting to queue an ABORT message
<4>CDB: 0x28 0x0 0x0 0xbe 0x12 0x96 0x0 0x0 0x18 0x0
<4>scsi0:0:0:0: Command not found
<4>aic7xxx_abort returns 0x2002
<4>scsi0:0:0:0: Attempting to queue an ABORT message
<4>CDB: 0x0 0x0 0x0 0x0 0x0 0x0
<4>scsi0: At time of recovery, card was not paused
<4>>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
<4>scsi0: Dumping Card State in Command phase, at SEQADDR 0x36
<4>Card was paused
<4>ACCUM = 0x80, SINDEX = 0xac, DINDEX = 0xc0, ARG_2 = 0x0
<4>HCNT = 0x0 SCBPTR = 0x0
<4>SCSISIGI[0x96] ERROR[0x0] SCSIBUSL[0x80] LASTPHASE[0x80] 
<4>SCSISEQ[0x12] SBLKCTL[0x2] SCSIRATE[0x0] SEQCTL[0x10] 
<4>SEQ_FLAGS[0x0] SSTAT0[0x5] SSTAT1[0x3] SSTAT2[0x0] 
<4>SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xac] SXFRCTL0[0x88] 
<4>DFCNTRL[0x6] DFSTATUS[0x48] 
<4>STACK: 0x0 0x166 0x196 0x35
<4>SCB count = 10
<4>Kernel NEXTQSCB = 8
<4>Card NEXTQSCB = 4
<4>QINFIFO entries: 4 3 
<4>Waiting Queue entries: 
<4>Disconnected Queue entries: 1:0 
<4>QOUTFIFO entries: 
<4>Sequencer Free SCB List: 3 2 6 4 7 5 8 9 10 11 12 13 14 15 
<4>Sequencer SCB Info: 
<4>  0 SCB_CONTROL[0x0] SCB_SCSIID[0x0] SCB_LUN[0x0] SCB_TAG[0x0] 
<4>  1 SCB_CONTROL[0x64] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x0] 
<4>  2 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  3 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  4 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  5 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  6 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  7 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4>  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4>Pending list: 
<4>  3 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>  4 SCB_CONTROL[0x74] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>  0 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>Kernel Free SCB list: 7 6 9 1 2 5 
<4>DevQ(0:0:0): 0 waiting
<4>DevQ(0:2:0): 0 waiting
<4>
<4><<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
<4>scsi0:0:0:0: Cmd aborted from QINFIFO
<4>aic7xxx_abort returns 0x2002
<4>scsi0:0:0:0: Attempting to queue an ABORT message
<4>CDB: 0x2a 0x0 0x0 0x0 0x0 0x3f 0x0 0x0 0x10 0x0
<4>scsi0:0:0:0: Command not found
<4>aic7xxx_abort returns 0x2002
<4>scsi0:0:0:0: Attempting to queue an ABORT message
<4>CDB: 0x0 0x0 0x0 0x0 0x0 0x0
<4>scsi0: At time of recovery, card was not paused
<4>>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
<4>scsi0: Dumping Card State in Command phase, at SEQADDR 0x1a3
<4>Card was paused
<4>ACCUM = 0x80, SINDEX = 0xa2, DINDEX = 0xc0, ARG_2 = 0x0
<4>HCNT = 0x0 SCBPTR = 0x0
<4>SCSISIGI[0x96] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0x80] 
<4>SCSISEQ[0x12] SBLKCTL[0x2] SCSIRATE[0x0] SEQCTL[0x10] 
<4>SEQ_FLAGS[0x0] SSTAT0[0x5] SSTAT1[0x3] SSTAT2[0x0] 
<4>SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xac] SXFRCTL0[0x80] 
<4>DFCNTRL[0x34] DFSTATUS[0x68] 
<4>STACK: 0xaf 0x0 0x166 0x196
<4>SCB count = 10
<4>Kernel NEXTQSCB = 3
<4>Card NEXTQSCB = 8
<4>QINFIFO entries: 8 4 
<4>Waiting Queue entries: 
<4>Disconnected Queue entries: 1:0 
<4>QOUTFIFO entries: 
<4>Sequencer Free SCB List: 3 2 6 4 7 5 8 9 10 11 12 13 14 15 
<4>Sequencer SCB Info: 
<4>  0 SCB_CONTROL[0x0] SCB_SCSIID[0x0] SCB_LUN[0x0] SCB_TAG[0x0] 
<4>  1 SCB_CONTROL[0x64] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x0] 
<4>  2 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  3 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  4 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  5 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  6 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  7 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4>  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4>Pending list: 
<4>  4 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>  8 SCB_CONTROL[0x74] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>  0 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>Kernel Free SCB list: 7 6 9 1 2 5 
<4>DevQ(0:0:0): 0 waiting
<4>DevQ(0:2:0): 0 waiting
<4>
<4><<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
<4>scsi0:0:0:0: Cmd aborted from QINFIFO
<4>aic7xxx_abort returns 0x2002
<4>scsi0:0:0:0: Attempting to queue an ABORT message
<4>CDB: 0x2a 0x0 0x0 0x0 0x4 0x2f 0x0 0x0 0x10 0x0
<4>scsi0:0:0:0: Command not found
<4>aic7xxx_abort returns 0x2002
<4>scsi0:0:0:0: Attempting to queue an ABORT message
<4>CDB: 0x0 0x0 0x0 0x0 0x0 0x0
<4>scsi0: At time of recovery, card was not paused
<4>>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
<4>scsi0: Dumping Card State in Command phase, at SEQADDR 0x1a4
<4>Card was paused
<4>ACCUM = 0x80, SINDEX = 0xa9, DINDEX = 0xc0, ARG_2 = 0x0
<4>HCNT = 0x0 SCBPTR = 0x0
<4>SCSISIGI[0x96] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0x80] 
<4>SCSISEQ[0x12] SBLKCTL[0x2] SCSIRATE[0x0] SEQCTL[0x10] 
<4>SEQ_FLAGS[0x0] SSTAT0[0x5] SSTAT1[0x3] SSTAT2[0x0] 
<4>SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xac] SXFRCTL0[0x80] 
<4>DFCNTRL[0x34] DFSTATUS[0x48] 
<4>STACK: 0xb0 0x0 0x166 0x196
<4>SCB count = 10
<4>Kernel NEXTQSCB = 4
<4>Card NEXTQSCB = 3
<4>QINFIFO entries: 3 8 
<4>Waiting Queue entries: 
<4>Disconnected Queue entries: 1:0 
<4>QOUTFIFO entries: 
<4>Sequencer Free SCB List: 3 2 6 4 7 5 8 9 10 11 12 13 14 15 
<4>Sequencer SCB Info: 
<4>  0 SCB_CONTROL[0x0] SCB_SCSIID[0x0] SCB_LUN[0x0] SCB_TAG[0x0] 
<4>  1 SCB_CONTROL[0x64] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x0] 
<4>  2 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  3 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  4 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  5 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  6 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  7 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4>  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4>Pending list: 
<4>  8 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>  3 SCB_CONTROL[0x74] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>  0 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>Kernel Free SCB list: 7 6 9 1 2 5 
<4>DevQ(0:0:0): 0 waiting
<4>DevQ(0:2:0): 0 waiting
<4>
<4><<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
<4>scsi0:0:0:0: Cmd aborted from QINFIFO
<4>aic7xxx_abort returns 0x2002
<4>scsi0:0:0:0: Attempting to queue an ABORT message
<4>CDB: 0x2a 0x0 0x0 0x4 0x0 0x5f 0x0 0x0 0x10 0x0
<4>scsi0:0:0:0: Command not found
<4>aic7xxx_abort returns 0x2002
<4>scsi0:0:0:0: Attempting to queue an ABORT message
<4>CDB: 0x0 0x0 0x0 0x0 0x0 0x0
<4>scsi0: At time of recovery, card was not paused
<4>>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
<4>scsi0: Dumping Card State in Command phase, at SEQADDR 0x16f
<4>Card was paused
<4>ACCUM = 0x80, SINDEX = 0xac, DINDEX = 0xc0, ARG_2 = 0x0
<4>HCNT = 0x0 SCBPTR = 0x0
<4>SCSISIGI[0x96] ERROR[0x0] SCSIBUSL[0x80] LASTPHASE[0x80] 
<4>SCSISEQ[0x12] SBLKCTL[0x2] SCSIRATE[0x0] SEQCTL[0x10] 
<4>SEQ_FLAGS[0x0] SSTAT0[0x5] SSTAT1[0x3] SSTAT2[0x0] 
<4>SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xac] SXFRCTL0[0x88] 
<4>DFCNTRL[0x6] DFSTATUS[0x48] 
<4>STACK: 0x35 0x0 0x166 0x196
<4>SCB count = 10
<4>Kernel NEXTQSCB = 8
<4>Card NEXTQSCB = 4
<4>QINFIFO entries: 4 3 
<4>Waiting Queue entries: 
<4>Disconnected Queue entries: 1:0 
<4>QOUTFIFO entries: 
<4>Sequencer Free SCB List: 3 2 6 4 7 5 8 9 10 11 12 13 14 15 
<4>Sequencer SCB Info: 
<4>  0 SCB_CONTROL[0x0] SCB_SCSIID[0x0] SCB_LUN[0x0] SCB_TAG[0x0] 
<4>  1 SCB_CONTROL[0x64] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x0] 
<4>  2 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  3 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  4 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  5 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  6 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  7 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4>  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4>Pending list: 
<4>  3 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>  4 SCB_CONTROL[0x74] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>  0 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>Kernel Free SCB list: 7 6 9 1 2 5 
<4>DevQ(0:0:0): 0 waiting
<4>DevQ(0:2:0): 0 waiting
<4>
<4><<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
<4>scsi0:0:0:0: Cmd aborted from QINFIFO
<4>aic7xxx_abort returns 0x2002
<4>scsi0:0:0:0: Attempting to queue an ABORT message
<4>CDB: 0x2a 0x0 0x0 0x4 0x3 0xcf 0x0 0x0 0x8 0x0
<4>scsi0:0:0:0: Command not found
<4>aic7xxx_abort returns 0x2002
<4>scsi0:0:0:0: Attempting to queue an ABORT message
<4>CDB: 0x0 0x0 0x0 0x0 0x0 0x0
<4>scsi0: At time of recovery, card was not paused
<4>>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
<4>scsi0: Dumping Card State in Command phase, at SEQADDR 0xa5
<4>Card was paused
<4>ACCUM = 0x80, SINDEX = 0xac, DINDEX = 0xc0, ARG_2 = 0x0
<4>HCNT = 0x0 SCBPTR = 0x0
<4>SCSISIGI[0x96] ERROR[0x0] SCSIBUSL[0x80] LASTPHASE[0x80] 
<4>SCSISEQ[0x12] SBLKCTL[0x2] SCSIRATE[0x0] SEQCTL[0x10] 
<4>SEQ_FLAGS[0x0] SSTAT0[0x5] SSTAT1[0x3] SSTAT2[0x0] 
<4>SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xac] SXFRCTL0[0x88] 
<4>DFCNTRL[0x6] DFSTATUS[0x48] 
<4>STACK: 0x0 0x166 0x196 0x35
<4>SCB count = 10
<4>Kernel NEXTQSCB = 3
<4>Card NEXTQSCB = 8
<4>QINFIFO entries: 8 4 
<4>Waiting Queue entries: 
<4>Disconnected Queue entries: 1:0 
<4>QOUTFIFO entries: 
<4>Sequencer Free SCB List: 3 2 6 4 7 5 8 9 10 11 12 13 14 15 
<4>Sequencer SCB Info: 
<4>  0 SCB_CONTROL[0x0] SCB_SCSIID[0x0] SCB_LUN[0x0] SCB_TAG[0x0] 
<4>  1 SCB_CONTROL[0x64] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x0] 
<4>  2 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  3 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  4 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  5 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  6 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  7 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4>  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4>Pending list: 
<4>  4 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>  8 SCB_CONTROL[0x74] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>  0 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>Kernel Free SCB list: 7 6 9 1 2 5 
<4>DevQ(0:0:0): 0 waiting
<4>DevQ(0:2:0): 0 waiting
<4>
<4><<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
<4>scsi0:0:0:0: Cmd aborted from QINFIFO
<4>aic7xxx_abort returns 0x2002
<4>scsi0:0:0:0: Attempting to queue a TARGET RESET message
<4>CDB: 0x28 0x0 0x0 0xbe 0x12 0x5e 0x0 0x0 0x20 0x0
<4>aic7xxx_dev_reset returns 0x2003
<4>Recovery SCB completes
<4>Recovery SCB completes
<4>scsi0:A:0:0: ahc_intr - referenced scb not valid during seqint 0x71 scb(0)
<4>>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
<4>scsi0: Dumping Card State in Message-in phase, at SEQADDR 0x1bc
<4>Card was paused
<4>ACCUM = 0xc0, SINDEX = 0x71, DINDEX = 0x8c, ARG_2 = 0x0
<4>HCNT = 0x0 SCBPTR = 0x0
<4>SCSISIGI[0xe6] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0xe0] 
<4>SCSISEQ[0x12] SBLKCTL[0x2] SCSIRATE[0x42] SEQCTL[0x10] 
<4>SEQ_FLAGS[0x40] SSTAT0[0x2] SSTAT1[0x3] SSTAT2[0x10] 
<4>SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xac] SXFRCTL0[0x88] 
<4>DFCNTRL[0x0] DFSTATUS[0x29] 
<4>STACK: 0xff 0x0 0x166 0x18e
<4>SCB count = 10
<4>Kernel NEXTQSCB = 0
<4>Card NEXTQSCB = 193
<4>QINFIFO entries: 
<4>Waiting Queue entries: 
<4>Disconnected Queue entries: 
<4>QOUTFIFO entries: 
<4>Sequencer Free SCB List: 1 3 2 6 4 7 5 8 9 10 11 12 13 14 15 
<4>Sequencer SCB Info: 
<4>  0 SCB_CONTROL[0x80] SCB_SCSIID[0x0] SCB_LUN[0x0] SCB_TAG[0x0] 
<4>  1 SCB_CONTROL[0x0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  2 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  3 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  4 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  5 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  6 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  7 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
<4>  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4>  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4> 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
<4>Pending list: 
<4>  8 SCB_CONTROL[0x70] SCB_SCSIID[0x7] SCB_LUN[0x0] 
<4>Kernel Free SCB list: 3 4 7 6 9 1 2 5 
<4>DevQ(0:0:0): 0 waiting
<4>DevQ(0:2:0): 0 waiting
<4>
<4><<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
<0>Kernel panic: for safety
<0>In interrupt handler - not syncing
<4> <0>Dumping messages in 0 seconds : last chance for Alt-SysRq...
---------------------------------------------------------------------------




/proc/scsi/aic7xxx>cat 0
---------------------------------------------------------------------------
Adaptec AIC7xxx driver version: 6.2.36
Adaptec 2940 SCSI adapter
aic7870: Wide Channel A, SCSI Id=7, 16/253 SCBs
Allocated SCBs: 10, SG List Length: 102

Serial EEPROM:
0x0238 0x0218 0x0238 0x0238 0x0238 0x0238 0x0238 0x0238 
0x0238 0x0238 0x0238 0x0238 0x0238 0x0238 0x0238 0x0238 
0x0096 0x005c 0x2807 0xff10 0xffff 0xffff 0xffff 0xffff 
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x00ff 0x4c5e 

Target 0 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
        Goal: 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
        Curr: 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
        Channel A Target 0 Lun 0 Settings
                Commands Queued 14441
                Commands Active 0
                Command Openings 8
                Max Tagged Openings 8
                Device Queue Frozen Count 0
Target 1 Negotiation Settings
        User: 10.000MB/s transfers (10.000MHz, offset 127)
Target 2 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
        Goal: 10.000MB/s transfers (10.000MHz, offset 15)
        Curr: 10.000MB/s transfers (10.000MHz, offset 15)
        Channel A Target 2 Lun 0 Settings
                Commands Queued 1
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Target 3 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
Target 4 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
Target 5 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
Target 6 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
Target 7 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
Target 8 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
Target 9 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
Target 10 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
Target 11 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
Target 12 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
Target 13 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
Target 14 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
Target 15 Negotiation Settings
        User: 20.000MB/s transfers (10.000MHz, offset 127, 16bit)
---------------------------------------------------------------------------
