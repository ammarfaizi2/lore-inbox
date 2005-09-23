Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVIWULp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVIWULp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 16:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVIWULp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 16:11:45 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:37833 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751215AbVIWULn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 16:11:43 -0400
From: Brett Russ <russb@emc.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Pasi Pirhonen <upi@papat.org>,
       Michael Madore <Michael.Madore@aslab.com>,
       Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       "Mr. Berkley Shands" <bshands@exegy.com>,
       Jim Edwards <jim@networkdesigning.com>, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>
References: <20050923194222.C13101CD3F@lns1058.lss.emc.com>
In-Reply-To: <20050923194222.C13101CD3F@lns1058.lss.emc.com>
Subject: Re: [PATCH 2.6.14-rc2] libata: Marvell SATA support (DMA mode)
Message-Id: <20050923201027.AEAF81CD3D@lns1058.lss.emc.com>
Date: Fri, 23 Sep 2005 16:10:27 -0400 (EDT)
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.23.24
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__HAS_MSGID 0, __MIME_TEXT_ONLY 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> Caveats...there is an outstanding panic in the scsi layer when hitting
> error conditions.  I've also seen a hang, also apparently during error
> conditions.  I will reply to this message with details of the panics
> and will cc the scsi list as well.  Basically, error handling has a
> bug.

Below are the promised details of the outstanding scsi panics and some
questions/theories.

Reference original mail for the patch to the existing Marvell SATA
driver in 2.6.14-rc2 here:
http://lkml.org/lkml/2005/9/23/171

The below panic was using 2.6.13 with only pci_intx and marvell
patches applied.  It got much further this time, it didn't panic until
after fully booting, bringing up all md's, mounting all filesystems,
and spending a minute or so at the shell:


[  288.540014] ------------[ cut here ]------------
[  288.600686] kernel BUG at drivers/scsi/scsi.c:294!
[  288.663563] invalid operand: 0000 [#1]
[  288.712723] Modules linked in: af_packet ipt_state ip_conntrack iptable_filter ip_tables rtc ipmi_devintf ipmi_msghandler tg3 e1000 e100 mii raid1 md_mod sata_mv
[  288.902502] CPU:    0
[  288.902504] EIP:    0060:[<c0226ccb>]    Not tainted VLI
[  288.902506] EFLAGS: 00010046   (2.6.13vanil-f46a2649ea0c62415719bcf31e6e6e49)
[  289.096864] EIP is at scsi_put_command+0x8b/0xa0
[  289.157441] eax: de7ef320   ebx: de7ef320   ecx: de7ef32c   edx: de7ef32c
[  289.246613] esi: de7be000   edi: 00000296   ebp: df521400   esp: df649c5c
[  289.335784] ds: 007b   es: 007b   ss: 0068
[  289.389518] Process scsi_eh_13 (pid: 72, threadinfo=df648000 task=de7e8a20)
[  289.478688] Stack: df649cd6 df9792a0 df96f4c0 de7ef320 00000292 df96f4c0 c022cc76 de7ef320
[  289.588438]        d4c5119c c022cd9d de7ef320 00000001 00000000 00000000 00000001 00000000
[  289.698188]        de7ef320 c022d16a de7ef320 00000001 00000000 00000000 00000400 c02bbd1a
[  289.807938] Call Trace:
[  289.842238]  [<c022cc76>] scsi_next_command+0x16/0x30
[  289.908544]  [<c022cd9d>] scsi_end_request+0xbd/0xf0
[  289.973708]  [<c022d16a>] scsi_io_completion+0x1da/0x510
[  290.043448]  [<c023aa1d>] sd_rw_intr+0x10d/0x310
[  290.104037]  [<c0103308>] apic_timer_interrupt+0x1c/0x24
[  290.173775]  [<c02276fe>] scsi_finish_command+0x8e/0xd0
[  290.242368]  [<c0237db9>] ata_scsi_qc_complete+0x29/0x50
[  290.312104]  [<c0235d77>] ata_qc_complete+0x37/0xc0
[  290.376126]  [<e0806d46>] mv_host_intr+0x136/0x1c0 [sata_mv]
[  290.450437]  [<e0806e67>] mv_interrupt+0x97/0x120 [sata_mv]
[  290.523605]  [<c012e8a9>] handle_IRQ_event+0x39/0x70
[  290.588768]  [<c012e986>] __do_IRQ+0xa6/0x100
[  290.645930]  [<c0104da9>] do_IRQ+0x19/0x30
[  290.699659]  [<c01032e6>] common_interrupt+0x1a/0x20
[  290.764825]  [<c022dc45>] scsi_request_fn+0x275/0x3a0
[  290.831133]  [<c02081ca>] blk_run_queue+0x3a/0x40
[  290.892866]  [<c022cd9d>] scsi_end_request+0xbd/0xf0
[  290.958032]  [<c022d2d5>] scsi_io_completion+0x345/0x510
[  291.027770]  [<c023aa1d>] sd_rw_intr+0x10d/0x310
[  291.088362]  [<c02276fe>] scsi_finish_command+0x8e/0xd0
[  291.156953]  [<c0237db9>] ata_scsi_qc_complete+0x29/0x50
[  291.226690]  [<c0235d77>] ata_qc_complete+0x37/0xc0
[  291.290712]  [<e0807152>] mv_eng_timeout+0x92/0xc0 [sata_mv]
[  291.365023]  [<c0237847>] ata_scsi_error+0x17/0x30
[  291.427899]  [<c022c056>] scsi_error_handler+0x76/0x170
[  291.496493]  [<c022bfe0>] scsi_error_handler+0x0/0x170
[  291.563944]  [<c0100c2d>] kernel_thread_helper+0x5/0x18
[  291.632539] Code: 5c 24 08 8b 74 24 0c 89 44 24 1c 8b 7c 24 10 8b 6c 24 14 83 c4 18 e9 35 9c fd ff 89 43 0c
 31 db 89 48 04 89 4e 14 89 51 04 eb b7 <0f> 0b 26 01 2c c8 2b c0 eb 95 8d 74 26 00 8d bc 27 00 00 00 00
[  291.880619]  <0>Kernel panic - not syncing: Fatal exception in interrupt
[  291.968646]  <0>Rebooting in 10 seconds.. 



The panics (I've seen several varieties, but they all start the same)
are all empty list related:

__blk_put_request(): BUG_ON(!list_empty(&req->queuelist));
scsi_put_command(): BUG_ON(list_empty(&cmd->list));
blkdev.h: BUG_ON(list_empty(&req->queuelist));


There are some things that don't make sense and/or concern me:

1) as you can see in the stack trace, all problems seem to originate
from mv_eng_timeout().  It does bother me that this function is being
called at all, but I've seen this problem on 3 unique systems so far.
All activity within that is performed while holding spin lock irqsave,
so presumably interrupts are disabled.  However, further up the stack
I see a ton of activity, including issuing a new command and it
subsequently *interrupting* and so on.  My concerns are:

a) it seems this is way too much to be doing while holding a lock
b) how can we take the interrupt if we're within an irq disabled lock


2) Next, this path is directly related to the "hack" that appears in
all libata drivers, including mine.  This hack is the following code
in mv_eng_timeout:

/* hack alert!  We cannot use the supplied completion
 * function from inside the ->eh_strategy_handler() thread.
 * libata is the only user of ->eh_strategy_handler() in
 * any kernel, so the default scsi_done() assumes it is
 * not being called from the SCSI EH.
 */
qc->scsidone = scsi_finish_command;
ata_qc_complete(qc, ATA_ERR); 


I'm researching the scsi error handling path now, but 1) above
especially concerns me.


Thanks,
BR
