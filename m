Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUGBRbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUGBRbz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 13:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUGBRbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 13:31:55 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:40410 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S264704AbUGBRbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 13:31:46 -0400
Date: Fri, 2 Jul 2004 18:30:21 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       <cova@ferrara.linux.it>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: question about SATA and IDE DVD/CD drives.
In-Reply-To: <40E5950F.2090308@pobox.com>
Message-ID: <Pine.LNX.4.44.0407021805580.2190-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2004, Jeff Garzik wrote:
> Tigran Aivazian wrote:
> > On Fri, 2 Jul 2004, Jeff Garzik wrote:
> > 
> >>Enable CONFIG_IDE, and disable CONFIG_BLK_DEV_IDE_SATA, and that will 
> >>fix things I bet.
> > 
> > 
> > Tried this as well on the latest snapshot (2.6.7-bk9) and it failed as 
> > well. Namely, SATA disk works fine but IDE subsystem doesn't see the DVD 
> > drive.
> > 
> > Are you sure that I only need to enable CONFIG_IDE and not some of the
> > other IDE options (disk, cdrom, chipset-specific etc)?
> 
> Sorry, I was summarizing...  you definitely need a "personality" driver 
> such as the ide-cdrom driver in order to make use of your DVD drive.

Tried it as well, namely:

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_SCSI_SATA=y
CONFIG_SCSI_ATA_PIIX=y

and still the same result, i.e. SATA takes the disk but IDE only says 
this:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

and DVD drive is still not seen.

I also tried enabling CONFIG_IDE_GENERIC but then it (IDE) reserves both 
io ranges and so SATA doesn't work (i.e. ata_piix probe fails with error 
-16).

I also tried not enabling CONFIG_IDE_GENERIC but instead enable PCI:

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y

Same result as the first one, i.e. SATA disk is OK but IDE DVD is not.

(btw there is a bug whereby one cannot disable CONFIG_SCSI_QLA2XXX for 
some reason)

I also tried passing ide0=noprobe to the IDE driver to make it leave ide0 
alone. Didn't work either, namely IDE took over both ide0 and ide1 and 
SATA failed to register both io regions.

So I still have a dilemma of either having a slow hdd or not being able to 
access DVD. 

Kind regards
Tigran

PS. Btw, I still get oops on cat /proc/iomem:

Unable to handle kernel paging request at ffffffff00000000 RIP: 
<ffffffff801cf084>{strnlen+13}
PML4 103027 PGD 0 
Oops: 0000 [1] SMP 
CPU 0 
Modules linked in: iptable_filter ip_tables
Pid: 2190, comm: cat Not tainted 2.6.7-bk9
RIP: 0010:[<ffffffff801cf084>] <ffffffff801cf084>{strnlen+13}
RSP: 0018:0000010028cbbd60  EFLAGS: 00010297
RAX: ffffffff00000000 RBX: 0000010023a00014 RCX: 000000000000000a
RDX: 0000010028cbbeb8 RSI: fffffffffffffffe RDI: ffffffff00000000
RBP: 0000000000000000 R08: 00000000fffffffe R09: 0000000000000004
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000010023a00fff
R13: ffffffff00000000 R14: 00000000ffffffff R15: 0000010028cbbdc8
FS:  0000002a958624c0(0000) GS:ffffffff803fc600(0000) 
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff00000000 CR3: 0000000000101000 CR4: 00000000000006e0
Process cat (pid: 2190, threadinfo 0000010028cba000, task 
000001003ec95450)
Stack: ffffffff801cf9c1 0000010000000001 fffffffffffffff4 0000000000001000 
       0000010023a00000 ffffffff802c018d 0000010002395400 0000010000002000 
       0000000000002000 0000000000000400 
Call Trace:<ffffffff801cf9c1>{vsnprintf+752} 
<ffffffff80183aa1>{seq_printf+165} 
       <ffffffff80174944>{link_path_walk+2374} 
<ffffffff80173b04>{permission+38} 
       <ffffffff80170198>{cp_new_stat+233} <ffffffff80135a66>{r_show+113} 
       <ffffffff80183592>{seq_read+273} <ffffffff80167673>{vfs_read+201} 
       <ffffffff801678c4>{sys_read+73} <ffffffff8010e9d2>{system_call+126} 
       

Code: 80 3f 00 74 13 48 83 ee 01 48 83 c0 01 48 83 fe ff 74 05 80 
RIP <ffffffff801cf084>{strnlen+13} RSP <0000010028cbbd60>
CR2: ffffffff00000000


