Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWF3I0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWF3I0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 04:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWF3I0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 04:26:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:21185 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751474AbWF3I0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 04:26:11 -0400
Message-ID: <44A4E01D.8020604@tw.ibm.com>
Date: Fri, 30 Jun 2006 16:26:05 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: castet.matthieu@free.fr
CC: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org> <449E5445.60008@free.fr> <44A4CE21.30009@tw.ibm.com> <1151654134.44a4d8f6dc320@imp5-g19.free.fr>
In-Reply-To: <1151654134.44a4d8f6dc320@imp5-g19.free.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

castet.matthieu@free.fr wrote:
> 
> 
>>Could you please test the current libata-upstream tree and
>>turn on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h.
>>
> 
> Is there a easy way to get libata-upstream tree ?
> Do I need to install git for that or there are some snapshots somewhere ?
> 
> 

Hi Matthieu,

Tejun has a patch against 2.6.17:
http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625-1.tar.bz2

> 
>>If possible, could you also submit the libata log related to the
>>early/lost irq.
> 
> Where are this infos ?
> 

Please send the info related to set xfer mode and timeout
(any other timeouts seems caused by lost irq are also great.)

> IRRC, libata counts lost irq, but display only a message each 1000 losts irq.
> 

Yes, so we need ATA_DEBUG and ATA_VERBOSE_DEBUG being turned on to
see the following debug printk of ata_host_intr().

VPRINTK("ata%u: protocol %d task_state %d\n",
		ap->id, qc->tf.protocol, ap->hsm_task_state);

After recompiling the kernel, this will print something like
"ata_host_intr: ata3: protocol 6 task_state 5"
in the dmesg each time ata_host_intr() is entered.

If the irq is ignored due to device busy (early irq), then
ata_hsm_move() will be skipped and later we might see ata_scsi_timed_out() triggered.

Thanks,

Albert
---
A sample libata timeout transacation looks like:

Jun 27 18:10:55 xlinux19 kernel: ata_scsi_dump_cdb: CDB (3:0,0,0) 1b 00 00 00 02 00 00 00 00
Jun 27 18:10:55 xlinux19 kernel: ata_scsi_translate: ENTER
Jun 27 18:10:55 xlinux19 kernel: ata3: ata_dev_select: ENTER, ata3: device 0, wait 1
Jun 27 18:10:55 xlinux19 kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
Jun 27 18:10:55 xlinux19 kernel: ata_tf_load_pio: device 0xA0
Jun 27 18:10:55 xlinux19 kernel: ata_exec_command_pio: ata3: cmd 0xA0
Jun 27 18:10:56 xlinux19 kernel: ata_scsi_translate: EXIT
Jun 27 18:10:56 xlinux19 kernel: ata_host_intr: ata3: protocol 6 task_state 5
Jun 27 18:10:56 xlinux19 kernel: ata_hsm_move: ata3: protocol 6 task_state 5 (dev_stat 0x58)
Jun 27 18:10:56 xlinux19 kernel: atapi_send_cdb: send cdb
                            (time out here.)
Jun 27 18:10:56 xlinux19 kernel: ata_scsi_timed_out: ENTER
Jun 27 18:10:56 xlinux19 kernel: ata_scsi_timed_out: EXIT, ret=0
Jun 27 18:10:56 xlinux19 kernel: ata_scsi_error: ENTER
Jun 27 18:10:56 xlinux19 kernel: ata_port_flush_task: ENTER
Jun 27 18:10:56 xlinux19 kernel: ata_port_flush_task: flush #1
Jun 27 18:10:56 xlinux19 kernel: __ata_port_freeze: ata3 port frozen
Jun 27 18:10:56 xlinux19 kernel: ata_eh_autopsy: ENTER
Jun 27 18:10:56 xlinux19 kernel: ata_eh_autopsy: EXIT
Jun 27 18:10:56 xlinux19 kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Jun 27 18:10:56 xlinux19 kernel: ata3.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
Jun 27 18:10:56 xlinux19 kernel: ata_eh_recover: ENTER

