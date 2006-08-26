Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWHZQpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWHZQpI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 12:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422839AbWHZQpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 12:45:08 -0400
Received: from main.gmane.org ([80.91.229.2]:28135 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422687AbWHZQpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 12:45:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Peter" <sw98234@hotmail.com>
Subject: wrt: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Date: Sat, 26 Aug 2006 16:12:52 +0000 (UTC)
Message-ID: <ecpru4$9t3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pool-70-106-95-181.pskn.east.verizon.net
X-Archive: encrypt
User-Agent: pan 0.109 (Beable)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.17.11 with reiser4 patch only. Voluntary preempt.

Recently, I have been receiving this sequence of errors:

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hdb: DMA disabled

Previously, with a different hdb drive, the above hda/b were reversed, but
the output the same.

Diagnostics on the drives are fine. Removing the b drive removes the
messages. System functions fine anyway, and no data is lost as a result
of the errors. The persistence of it is frustrating!

With so many moving parts in a kernel, applications, drivers, and a user's
system, it's hard to pin down the root of the problem. I have a mix of
filesystems, drivers, etc. While I cannot recall exactly when I started
noticing these problems, I would venture it was in the 2.6.16 series. I
have two thoughts about these errors.

1) In my case, hda and hdb are different in capabilities.
/dev/hda:

 Model=Maxtor 6Y200P0, FwRev=YAR41BW0, SerialNo=Y65WFMPE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):  ATA/ATAPI-1 ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6 ATA/ATAPI-7

/dev/hdb:

 Model=Maxtor 5T030H3, FwRev=TAH71DP0, SerialNo=T3H1876C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 (maybe): CurCHS=65535/16/0, CurSects=0, LBA=yes, LBAsects=60030432
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 0:  ATA/ATAPI-1 ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6

could it be that the dma or io handler is having trouble when each device
has different capabilities on the same ide channel? Or, could it be that
reiserfs or reiser4 is turning off dma because it is timing out somehow?

2) VMWare. I have noticed recently that the errors are occurring during or
after VMWare is run.

from dmesg:

/dev/vmnet: open called by PID 9443 (vmware-vmx)
eth0: Promiscuous mode enabled.
device eth0 entered promiscuous mode
bridge-eth0: enabled promiscuous mode
/dev/vmnet: port on hub 0 successfully opened
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown

I have tried compiling with all three preemption models, including with
the ck, beyond, and other variant patchsets. Currently, I am testing with
NO preemption and the errors are fewer but still there.

MOBO bios has dma enabled including for UDMA and prefetch is set to on.
Again, it's interesting to note I did not observe this error with only one
drive on ide0. I cannot pin down any more details at the moment, but if
anyone wants to explore this further (I know this has been an issue for
years), I am happy to try and help.

-- 
Peter
+++++
Do not reply to this email, it is a spam trap and not monitored.
I can be reached via this list, or via 
jabber: pete4abw at jabber.org
ICQ: 73676357

