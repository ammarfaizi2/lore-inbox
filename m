Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270378AbTGMUhf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270379AbTGMUhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:37:35 -0400
Received: from rzcomm7.rz.tu-bs.de ([134.169.9.53]:9437 "EHLO
	rzcomm7.rz.tu-bs.de") by vger.kernel.org with ESMTP id S270378AbTGMUhd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:37:33 -0400
Date: Sun, 13 Jul 2003 22:52:14 +0200
From: Torsten Wolf <t.wolf@tu-bs.de>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: 2.4.21 DMA and cdrecord woes
Message-ID: <20030713205214.GB2037@b147.apm.etc.tu-bs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt http://www.mutt.org/
Organization: TU Braunschweig
X-Editor: Vim http://www.vim.org/
X-OpenPGP-Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xEE27B69C
X-Fingerprint: 24EE 9FD9 5333 0206 541F  4602 C6A4 5F61 EE27 B69C
X-Uptime: 22:00:30 up 3 min,  7 users,  load average: 0.90, 0.44, 0.17
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel 2.4.21 on my Epox 8KHA+ (VIA KT266A) with via82cxx.o loaded
allows me to write CDs with cdrdao from hd[abc] (writer is hdd) via
ide-scsi emulation without problems. With cdrecord I get buffer
underruns, which I've never encountered before on this machine. DMA is
switched on (according to /proc/ide/hd[abcd]/settings and the error
I get is:

%----------------------------------------------------------------------
Track 01:  321 of  693 MB written (fifo 100%) [buf98%]  12.6x.cdrecord: Input/output error.
write_g1: scsi sendcmd: no error
CDB:  2A 00 00 02 83 BC 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x24 Qual 0x00 (invalid field in cdb) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.046s timeout 40s

write track data: error after 337502208 bytes
cdrecord: A write error occured.
%----------------------------------------------------------------------

while /var/log/messages yields 

%----------------------------------------------------------------------
kernel: hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: hdd: drive not ready for command
%----------------------------------------------------------------------

When using hdb as the source drive this error can be easily reproduced
via copying a file from hdb to hdc.

According to the author of cdrecord this should be a kernel issue. He
assumes, that SCSI commands are modified even though cdrdao works fine.
So I remembered, what I had to do to get CD-writing work with older
kernels. With e.g. 2.4.16 and 2.4.18 I had to switch off compiled in 
via82cxx support, to be able to use hdc as the source drive, while hda
and hdb worked fine. With these kernels, (generic) DMA was available and
switched on. However, with 2.4.21 and without via82cxx support, DMA does
not work at all:

%----------------------------------------------------------------------
hdparm -d 1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)
%----------------------------------------------------------------------

This sounds similar to <20030602120021$201d@gated-at.bofh.it>. My
lspic-output yields

%----------------------------------------------------------------------
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
 Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
 Flags: bus master, medium devsel, latency 32
 I/O ports at dc00 [size=16]
 Capabilities: [c0] Power Management version 2
%----------------------------------------------------------------------

So what should I do now? Wait for the via82cxx & cdrecord problem to be
fixed? Or should generic DMA support be restored for the VIA chipset?
Please tell me, how I could help to fix this problem.

Best wishes,
Torsten
