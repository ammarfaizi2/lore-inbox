Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132828AbRDITd7>; Mon, 9 Apr 2001 15:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132829AbRDITdj>; Mon, 9 Apr 2001 15:33:39 -0400
Received: from [199.217.175.51] ([199.217.175.51]:41484 "EHLO
	core.federated.com") by vger.kernel.org with ESMTP
	id <S132828AbRDITda>; Mon, 9 Apr 2001 15:33:30 -0400
From: Jim Studt <jim@federated.com>
Message-Id: <200104091933.OAA05314@core.federated.com>
Subject: aic7xxx and 2.4.3 failures
To: linux-kernel@vger.kernel.org
Date: Mon, 9 Apr 2001 14:33:27 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a trio of identical PIII machines all failing with aic7xxx under
2.4.3.  I've tried both aic7xxx 6.1.9 and 6.1.10 in addition to the one
in 2.4.3 (6.1.5?).  These machines work fine under 2.2.18pre21.

I'm looking for any ideas or suggestions on how to fix this.
(Ok, honestly I'm hoping someone will say `you fool, read this message',
but I don't have high hopes for that.)

A typical startup with 6.1.9 proceeds like this...  (6.1.10 hangs silently
after emitting the scsi0 and scsi1 adapter summaries, maybe it is
going through the same gyrations silently.) 

SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
PCI: Assigned IRQ 11 for device 00:0c.0
PCI: The same IRQ used for device 00:0c.1
PCI: Found IRQ 11 for device 00:0c.1
PCI: The same IRQ used for device 00:0c.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.9
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Wide Channel A, SCSI Id=7, 32/255 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.9
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Wide Channel B, SCSI Id=7, 32/255 SCBs

scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 8195
scsi0:0:0:0: Attempting to queue a TARGET RESET message
aic7xxx_dev_reset returns 8195
Recovery SCB completes
scsi0:0:0:0: Attempting to queue an ABORT message
ahc_intr: HOST_MSG_LOOP bad phase 0x0
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 0 lun 0

It repeats this for each ID for which a device exists.  There actually
is a unit 0 and 1 on this bus.  The error stream is slightly different
for unused IDs...


scsi0:0:2:0: Attempting to queue an ABORT message
scsi0:0:2:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:2:0: Attempting to queue an ABORT message
scsi0:0:2:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:2:0: Attempting to queue a TARGET RESET message
scsi0:0:2:0: Is not an active device
aic7xxx_dev_reset returns 8194
scsi0:0:2:0: Attempting to queue an ABORT message
scsi0:0:2:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:2:0: Attempting to queue an ABORT message
scsi0:0:2:0: Command already completed
aic7xxx_abort returns 8194
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 2 lun 0

After failing on all 32 potential IDs at something like 47 seconds per
ID the boot proceeds and fails to mount the root partition which is on
these disks.

Other potentially useful information gathered from 2.2.18pre21...
/proc/pci says....
00:0c.1 SCSI storage controller: Adaptec 7896
	Subsystem: Adaptec: Unknown device 0053
	Flags: bus master, medium devsel, latency 64, IRQ 11
	BIST result: 00
	I/O ports at 2800
	Memory at f4102000 (64-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 1

dotdot-new:~# cat /proc/scsi/aic7xxx/0
Adaptec AIC7xxx driver version: 5.1.31/3.2.4
Compile Options:
  TCQ Enabled By Default : Disabled
  AIC7XXX_PROC_STATS     : Enabled
  AIC7XXX_RESET_DELAY    : 15

Adapter Configuration:
           SCSI Adapter: Adaptec AIC-7896/7 Ultra2 SCSI host adapter
                           Ultra-2 LVD/SE Wide Controller Channel A at PCI 0/12/0
    PCI MMAPed I/O Base: 0xf4101000
 Adapter SEEPROM Config: SEEPROM found and used.
      Adaptec SCSI BIOS: Enabled
                    IRQ: 11
                   SCBs: Active 0, Max Active 2,
                         Allocated 15, HW 32, Page 255
             Interrupts: 3366
      BIOS Control Word: 0x18a6
   Adapter Control Word: 0x1c5e
   Extended Translation: Enabled
Disconnect Enable Flags: 0xffff
     Ultra Enable Flags: 0x0000
 Tag Queue Enable Flags: 0x0000
Ordered Queue Tag Flags: 0x0000
Default Tag Queue Depth: 8
    Tagged Queue By Device array for aic7xxx host instance 0:
      {255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255}
    Actual queue depth per device for aic7xxx host instance 0:
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}

-- 
                                     Jim Studt, President
                                     The Federated Software Group, Inc.
