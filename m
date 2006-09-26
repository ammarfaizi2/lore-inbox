Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWIZT3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWIZT3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWIZT3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:29:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:63806 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932395AbWIZT3r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:29:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=TumOyPi3//6TPYmyDVqmJjS3m/QUH/g8tyPAwwUz8l17WYODMOVmjVV0jxuThlWeNuXnYlYI1qDv80cp01PzvK73OqUQ/G8ipGM75QpFgJWGScOILifzA3PdyMqSBiFGjS0ONj8R2yOgwE1nBGPeABl/R1ZpFM73G+VrTcL9Rrk=
Date: Tue, 26 Sep 2006 21:29:39 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: pata_serverworks oopses in latest -git
Message-Id: <20060926212939.69b52f0d.diegocg@gmail.com>
In-Reply-To: <45194DAD.6060904@garzik.org>
References: <20060926140016.54d532ba.diegocg@gmail.com>
	<1159275010.11049.215.camel@localhost.localdomain>
	<45194DAD.6060904@garzik.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 26 Sep 2006 11:56:29 -0400,
Jeff Garzik <jeff@garzik.org> escribió:

> Diego, does the attached patch help?

Yes and no :) It fixes that problem but I hit another oops, but this
time it's triggered because it hits the BUG() at:

static int serverworks_pre_reset(struct ata_port *ap) {
[...]
        BUG();
        return -1;      /* kill compiler warning */
}

Before: 
[   19.530190] ata3: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
<BOOM>

After:
[   19.530190] ata3: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
[   19.530250] ata4: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
[   19.530282] scsi2 : pata_serverworks
[   19.530394] ------------[ cut here ]------------
[   19.530401] kernel BUG at drivers/ata/pata_serverworks.c:161!
[   19.530407] invalid opcode: 0000 [#1]
[   19.530411] PREEMPT SMP
[   19.530416] Modules linked in: pata_serverworks sworks_agp e100 snd_page_alloc pcspkr i2c_piix4 i2c_core agpgart nls_utf8 ntfs psmouse parport_pc evdev tsdev lp parport usbhid ext3 jbd mbcache sd_mod ohci_hcd usbcore sata_sil libata scsi_mod thermal processor fan vga16fb vgastate
[   19.530457] CPU:    1
[   19.530459] EIP:    0060:[<f8a3f0e3>]    Not tainted VLI
[   19.530462] EFLAGS: 00010246   (2.6.18custom1 #4)
[   19.530477] EIP is at serverworks_pre_reset+0x63/0x80 [pata_serverworks]
[   19.530484] eax: 00000000   ebx: 00000211   ecx: 00000002   edx: f8a41680
[   19.530491] esi: c191b000   edi: f1304308   ebp: f1304484   esp: dff7de4c
[   19.530497] ds: 007b   es: 007b   ss: 0068
[   19.530504] Process scsi_eh_2 (pid: 3950, ti=dff7d000 task=dfcb92f0 task.ti=dff7d000)
[   19.530509] Stack: f1304404 f8a3f080 00000000 00000000 f886298a f1304308 dfcb82d0 f12f4f1c
[   19.530524]        c01354e4 f12f4e50 00000000 00800f00 00000003 002f4f10 00000020 f1304490
[   19.530538]        c0120a51 f1304404 00800f00 c02d7f80 00000004 34354e50 dff73339 f12f4f10
[   19.530553] Call Trace:
[   19.530560]  [<f8a3f080>] serverworks_pre_reset+0x0/0x80 [pata_serverworks]
[   19.530572]  [<f886298a>] ata_do_eh+0x7fa/0x1780 [libata]
[   19.530646]  [<c01354e4>] attach_pid+0x34/0xc0
[   19.530661]  [<c0120a51>] copy_process+0x1001/0x12e0
[   19.530679]  [<f8860476>] ata_bmdma_drive_eh+0xb6/0x180 [libata]
[   19.530706]  [<f885af40>] ata_std_postreset+0x0/0x1a0 [libata]
[   19.530730]  [<f88590e0>] ata_std_softreset+0x0/0x120 [libata]
[   19.530754]  [<f8a3f080>] serverworks_pre_reset+0x0/0x80 [pata_serverworks]
[   19.530767]  [<f8a3f130>] serverworks_error_handler+0x30/0x40 [pata_serverworks]
[   19.530778]  [<f8a3f080>] serverworks_pre_reset+0x0/0x80 [pata_serverworks]
[   19.530788]  [<f88590e0>] ata_std_softreset+0x0/0x120 [libata]
[   19.530813]  [<f885af40>] ata_std_postreset+0x0/0x1a0 [libata]
[   19.530837]  [<f8861c57>] ata_scsi_error+0x1d7/0x5f0 [libata]
[   19.530864]  [<c02ccdba>] schedule+0x33a/0x920
[   19.530876]  [<f88789a0>] scsi_error_handler+0x0/0x7a0 [scsi_mod]
[   19.530946]  [<f8878a49>] scsi_error_handler+0xa9/0x7a0 [scsi_mod]
[   19.530981]  [<f88789a0>] scsi_error_handler+0x0/0x7a0 [scsi_mod]
[   19.531007]  [<c01385a6>] kthread+0x116/0x120
[   19.531021]  [<c0138490>] kthread+0x0/0x120
[   19.531029]  [<c0101005>] kernel_thread_helper+0x5/0x10
[   19.531038] Code: 2a 39 d8 75 f3 8b 4a 04 0f b7 46 28 39 c1 74 03 41 75 e5 89 3c 24 89 f6 ff 52 08 89 47 78 89 7c 24 14 59 5b 5e 5f e9 1d a1 e1 ff <0f> 0b a1 00 84 f9 a3 f8 5a b8 ff ff ff ff 5b 5e 5f c3 8d 74 26
[   19.531103] EIP: [<f8a3f0e3>] serverworks_pre_reset+0x63/0x80 [pata_serverworks] SS:ESP 0068:dff7de4c
