Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318304AbSG3QM2>; Tue, 30 Jul 2002 12:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318317AbSG3QM2>; Tue, 30 Jul 2002 12:12:28 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:39949 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318304AbSG3QM0>;
	Tue, 30 Jul 2002 12:12:26 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Marcin Dalecki <dalecki@evision.ag>
Date: Tue, 30 Jul 2002 18:15:13 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: IDE from current bk tree, UDMA and two channels...
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <986F8B232B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jul 02 at 16:25, Marcin Dalecki wrote:
> > Second problem is that read operation which ends with
> > "drive ready, seek complete, data request" (why it happened in first
> > place?) will just read one sector from drive (it was DMA transfer,
> > so drive->mult_count == 0), and then it returns from ata_error
> > with ATA_OP_CONTINUES. But what continues? Drive told us that
> > current operation is done, and no new operation was started, so
> > there is very low chance that some IRQ will ever come, and timer was
> > just removed by ata_irq_request(), so channel will never awake.
> 
> What should continue is the retry of the operation, since otherwise
> it will be abondoned in do_ide_request(). However I will recheck.

It looks to me like that we only issue idle immediate and reset
to the drive. And even if we reset drive, we do not reissue
command, not even talking about resetting handler. And because of 
ide_dma_intr -> ata_error will report ATA_OP_CONTINUES, ata_irq_request 
will think that handler reissued command, and it will leave IDE_BUSY set.
So we are left with IDE_BUSY set, idle hardware, no handler and no timer 
active, and with one request on the fly lost somewhere in the system.
Probably code which reissued hardware was dropped sometime in the past
changes?

Another problem I found: ata_error calls ata_status_poll, which can
call back to ata_error. Hardwiring BUSY_STAT bit to 1 (== unplugging
drive from system, for example) can cause this loop, as far as I can see.
Fortunately on my system it reads 0x7F from status register after disk
unplug, but it still does not look correct.
 
> > And last thing: problem does not happen when only one of channels is
> > active, it is triggered only when both channels are active, and
> > channel #1 is always one which dies. Channel #0 uses IRQ14, channel #1
> > IRQ15, so there should be no sharing involved.
> 
> Do you do unmasking of IRQs? Holding them a bit longer could have some
> impact as well...

It was happening with default configuration, with unmaskirq=1. Now I tried

hdparm -u 0 /dev/hda; hdparm -u 0 /dev/hdc
vmware-config.pl -default & fsck -f /dev/hdc1

and it again died. vmware-config.pl is used as simple compile test,
it happens with 'ls -lRta /' too, but with 'vmware-config.pl' it happens
much faster.

Stack trace when this problem happens is:

ide_dma_intr + b8/cc (here I added printstate() call)
ata_irq_request + 11e/1cc
handle_IRQ_event + 29/4c
do_IRQ + df/190
common_interrupt + 18/20
madvise_willneed + 10/94
radix_tree_lookup + 18/60
do_page_cache_readahead + 92/13c
do_generic_file_read + 57/2a8
generic_file_read + 11c/138
file_read_actor + 0/8c
vfs_read + b4/134
sys_read + 2a/3c
syscall_call + 7/b

It is UP machine (with SMP non-preemptible kernel). Stack trace does not 
look like that it was caused by some race.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
