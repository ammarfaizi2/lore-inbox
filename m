Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270868AbUJVJIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270868AbUJVJIa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270877AbUJVJGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:06:33 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:49542 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270886AbUJVJDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:03:08 -0400
Date: Fri, 22 Oct 2004 05:01:45 -0400
From: Tabris <tabris@tabris.net>
To: linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: DVD/ide-cd related Oops 2.6.[89]-mm
Message-ID: <20041022090145.GA6408@tabriel.tabris.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I have a DVD I bought today that about 80% of the way through
causes an error, 'cmd 0x28 timed out', resets ATAPI 2 or 3 times... and
then produces the Oops attached below.

	This has happened in 2.6.8-rc1-mm1+idefix2 (a mebbe 5 liner 
patch to fix LBA 48 FLUSH CACHE on non-LBA48 capable drives from
Jens. was merged into rc2-mm, possibly in rc1-mm2 or mm3), and also
2.6.9-rc4-mm1+revert_optimize-profile+undecoded_slave-fixup

	undecoded slave fixup is a oneliner patch in ide-probe to 
recognize both of my Maxtor drives that appear to have the same serial
number, D3000000. This fix was discussed a month ago or so, as I had run
into it, but nothing official came of it, and it was never merged to -mm.
Patch attached.

	Btw, the oops does not occur with another DVD I have. However, I
did go to the store and get another copy of the problematic DVD, and the
same problem occurred.
--
tabris


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-cd.Oops.log"

ide-cd: cmd 0x28 timed out
hdd: DMA timeout retry
hdd: timeout waiting for DMA
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0xd0 { Busy }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete

Unable to handle kernel NULL pointer dereference at virtual addr 00000030
 printing eip:
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: binfmt_misc nfsd exportfs sg sr_mod lp parport_pc parport nfs lockd sunrpc snd_seq_oss snd_seq_midi_event snd_seq_ snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore w83781d i2c_sensor i2c_viapro i2c_dev i2c_core raw ide_cd cdrom floppy thermal processor fan button battery ac 3c59x mii quota-vs xfs ext2 mbcache rtc
CPU:	0
EIP:	0060:{<e0a8a079>]	Not Tainted VLI
EFLAGS:	00210012
EIP is at cdrom_read_intr+0x1a0/0x2f0 [ide_cd]
eax: 00008000	ebx: 00000040	ecx:cff01f40	edx: 00000000
esi: 00008000	edi: 00000000	ebp: c03f8d34	esp: cff01f28
ds: 007b	es: 007b	ss:0068

process artsd (pid: 7326, threadinfo=cff00000 task=cd1b1ae0)
stack:	c47bc3a4 c47bc3b8 c47bc3b4 00000040 00000002 00000001 00000058 0000000f
	c1579ca0 c03f8d34 00200282 c022769f 00000000 cff00000 e0a89ed0 c03f8ad0
	c1577640 00000000 0000000f 00000000 c01347c4 000003c0 0000000f c03afe00 

Call Trace:
ide_intr+0xff/0x200
cdrom_read_intr+0x0/0x2f0 [ide_cd]
handle_IRQ_event+0x34/0x60
__do_IRQ+0xf9/0x1a0
common_interrupt+0x18/0x20

 <0>Kernel Panic - not syncing: Fatal exception in interrupt

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ide-probe+undecoded_slave-Maxtor-fixup

Signed-off by tabris@tabris.net

--- ide-probe.c~	2004-10-22 04:49:47.045203783 -0400
+++ ide-probe.c	2004-10-22 04:49:28.889442288 -0400
@@ -730,6 +730,7 @@ static void probe_hwif(ide_hwif_t *hwif)
 			    /* And beware of confused Maxtor drives that go "M0000000000"
 			      "The SN# is garbage in the ID block..." [Eric] */
 			    strncmp(drive->id->serial_no, "M0000000000000000000", 20) &&
+			    strncmp(drive->id->serial_no, "D3000000", 8) &&
 			    strncmp(hwif->drives[0].id->serial_no, drive->id->serial_no, 20) == 0) {
 				printk(KERN_WARNING "ide-probe: ignoring undecoded slave\n");
 				drive->present = 0;

--VS++wcV0S1rZb1Fb--
