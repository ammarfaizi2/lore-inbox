Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVLBUgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVLBUgH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 15:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVLBUgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 15:36:06 -0500
Received: from mexforward.lss.emc.com ([168.159.213.200]:7536 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751062AbVLBUgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 15:36:05 -0500
Message-ID: <C2EEB4E538D3DC48BF57F391F422779321AE79@srmanning.eng.emc.com>
From: "goggin, edward" <egoggin@emc.com>
To: "'Andrew Morton'" <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: RE: [SCSI BUG 2.6.15-rc3-mm1] scheduling while atomic on boot tim
	e
Date: Fri, 2 Dec 2005 15:35:41 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.12.2.23
X-PerlMx-Spam: Gauge=, SPAM=1%, Reasons='EMC_FROM_00+ -3, __CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __IMS_MSGID 0, __IMS_MUA 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is caused by my patch to scsi_next_command()
(on or about 11/11) causing it to call put_device() and
invoke the kobject's release() function while in soft
interrupt.  My patch should be removed ... although I
don't have an alternate solution in mind for the original
problem which was an "oops with USB Storage on 2.6.14".

> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org 
> [mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Andrew Morton
> Sent: Friday, December 02, 2005 2:32 PM
> To: Wu Fengguang
> Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
> Subject: Re: [SCSI BUG 2.6.15-rc3-mm1] scheduling while 
> atomic on boot time
> 
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > My server occasionally crashes on boot time, this has been 
> happening in many
> > recent kernel versions(at least from 2.6.14-rcx). It is 
> rare enough, I setup
> > netconsole and rebooted numerous times, but still failed to 
> catch it. Luckily
> > it happened again this time, and does not panic. Here is the logs. 
> > 
> > Thanks,
> > Wu
> > 
> > Error messages:
> > [4294676.927000] scheduling while atomic: ksoftirqd/0/0x00000200/3
> > [4294676.927000]  [dump_stack+21/32] dump_stack+0x15/0x20
> > [4294676.927000]  [schedule+3563/3584] schedule+0xdeb/0xe00
> > [4294676.927000]  [__down+138/272] __down+0x8a/0x110
> > [4294676.927000]  [__sched_text_start+10/16] <6>scsi[0]: 
> scanning scsi channel 1 [Phy 1] for non-raid devices
> > [4294676.927000] __down_failed+0xa/0x10
> > [4294676.927000]  [.text.lock.main+43/71] .text.lock.main+0x2b/0x47
> > [4294676.928000]  [device_del+62/112] device_del+0x3e/0x70
> > [4294676.928000]  [scsi_target_reap+137/176] 
> scsi_target_reap+0x89/0xb0
> > [4294676.928000]  [scsi_device_dev_release+251/400] 
> scsi_device_dev_release+0xfb/0x190
> > [4294676.928000]  [device_release+23/80] device_release+0x17/0x50
> > [4294676.928000]  [kobject_cleanup+116/128] 
> kobject_cleanup+0x74/0x80
> > [4294676.928000]  [kobject_release+11/16] kobject_release+0xb/0x10
> > [4294676.929000]  [kref_put+52/160] kref_put+0x34/0xa0
> > [4294676.929000]  [kobject_put+20/32] kobject_put+0x14/0x20
> > [4294676.929000]  [put_device+17/32] put_device+0x11/0x20
> > [4294676.929000]  [scsi_next_command+48/64] 
> scsi_next_command+0x30/0x40
> > [4294676.929000]  [scsi_end_request+165/192] 
> scsi_end_request+0xa5/0xc0
> > [4294676.929000]  [scsi_io_completion+540/1152] 
> scsi_io_completion+0x21c/0x480
> > [4294676.929000]  [scsi_generic_done+43/64] 
> scsi_generic_done+0x2b/0x40
> > [4294676.930000]  [scsi_finish_command+146/240] 
> scsi_finish_command+0x92/0xf0
> > [4294676.930000]  [scsi_softirq+215/320] scsi_softirq+0xd7/0x140
> > [4294676.930000]  [__do_softirq+216/240] __do_softirq+0xd8/0xf0
> > [4294676.930000]  [do_softirq+74/96] do_softirq+0x4a/0x60
> > [4294676.930000]  =======================
> 
> Which device driver are you using?
> 
> This is just a warning - it won't necessarily cause a crash 
> and in this
> case it didn't appear to do so.
> 
> I seem to recall diagnosing this exact locking problem a 
> month or so ago,
> and cc'ing linux-scsi on that analysis.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
