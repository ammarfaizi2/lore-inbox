Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSJBSzH>; Wed, 2 Oct 2002 14:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262669AbSJBSzH>; Wed, 2 Oct 2002 14:55:07 -0400
Received: from adsl-157-199-164.dab.bellsouth.net ([66.157.199.164]:22708 "EHLO
	midgaard.us") by vger.kernel.org with ESMTP id <S262668AbSJBSzE>;
	Wed, 2 Oct 2002 14:55:04 -0400
Date: Wed, 2 Oct 2002 14:44:37 -0400
From: Andreas Boman <aboman@nerdfest.org>
To: Mike Anderson <andmike@us.ibm.com>
Cc: akpm@digeo.com, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       dougg@gear.torque.net
Subject: Re: 2.4.39 "Sleeping function called from illegal context at slab.c:1374"
Message-ID: <20021002184437.GA17474@midgaard.us>
Mail-Followup-To: Mike Anderson <andmike@us.ibm.com>, akpm@digeo.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dougg@gear.torque.net
References: <3D99885B.533C320D@aitel.hist.no> <3D99EF62.3A3E6932@digeo.com> <20021001215907.GA8273@midgaard.us> <3D9A207A.14BFF440@digeo.com> <20021002162443.GA1317@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002162443.GA1317@beaverton.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Anderson (andmike@us.ibm.com) wrote:
> Andrew Morton [akpm@digeo.com] wrote:
> > That is known - sg_init() is blatantly calling vmalloc under
> > write_lock_irqsave().
> 
> I had not already seen a patch for this.
> 
> During Douglas Gilbert's time-off he connects when he can so it maybe a
> bit until he can address this. 
> 
> In the interim a quick patch below should fix the problem, and still
> provide for safe additions.
> 
> I have done just minor testing on 2.5.40 using the sg_utils.

This seems to have fixed that particular warning, and got me a new one:

 Debug: sleeping function called from illegal context at /usr/src/linux-2.5.40/include/asm/semaphore.h:119
 debb7e38 debb7e5c c016f69b c0356860 00000077 df354680 e0907020 e0907028 
        e0907020 debb7e78 c0241e06 e09070bc dfd563c8 e0907020 e0907028 debb6000 
        debb7e94 c0240348 e0907020 c01f483f e0907020 00000000 00000000 debb7ee4 
 Call Trace:
  [driverfs_create_dir+75/240]driverfs_create_dir+0x4b/0xf0
  [device_make_dir+70/144]device_make_dir+0x46/0x90
  [device_register+184/368]device_register+0xb8/0x170
  [sprintf+31/48]sprintf+0x1f/0x30
  [<e08fe86a>]sg_attach+0x23a/0x450 [sg]
  [<e09023ce>].rodata.str1.1+0x6a/0x2b0 [sg]
  [<e0902387>].rodata.str1.1+0x23/0x2b0 [sg]
  [<e0903ca0>]sg_fops+0x0/0x58 [sg]
  [<e0903be0>]sg_template+0x0/0x94 [sg]
  [scsi_register_device+269/336]scsi_register_device+0x10d/0x150
  [<e08fecd3>]init_sg+0x23/0x60 [sg]
  [<e0903be0>]sg_template+0x0/0x94 [sg]
  [sys_init_module+1311/1648]sys_init_module+0x51f/0x670
  [<e08fc060>]E __insmod_sg_O/lib/modules/2.5.40anb4/kernel/drivers/scsi/sg.o_M3D9B4C96_V132392+0x60/0x80 [sg]
  [<e0902614>]__ksymtab+0x0/0x28 [sg]
  [<e08fc060>]E __insmod_sg_O/lib/modules/2.5.40anb4/kernel/drivers/scsi/sg.o_M3D9B4C96_V132392+0x60/0x80 [sg]
  [syscall_call+7/11]syscall_call+0x7/0xb

modprobe cdrom and sr_mod follow without problems, but  then when i modprobe
ide-scsi:

 scsi1 : SCSI host adapter emulation for IDE ATAPI devices
 scsi_eh_offline_sdevs: Device set offline - notready or command retry failedafter error recovery: host1 channel 0 id 0 lun 0
   Vendor:           Model:                   Rev:     
   Type:   Direct-Access                      ANSI SCSI revision: 00
 hda: lost interrupt
 ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
 hda: DMA disabled
 hda: ATAPI reset complete

and the box is dead again.

