Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSGQVcI>; Wed, 17 Jul 2002 17:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSGQVcI>; Wed, 17 Jul 2002 17:32:08 -0400
Received: from slider.rack66.net ([212.3.252.135]:45836 "EHLO
	slider.rack66.net") by vger.kernel.org with ESMTP
	id <S316770AbSGQVcG>; Wed, 17 Jul 2002 17:32:06 -0400
Date: Wed, 17 Jul 2002 23:35:43 +0200
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: Martin Diehl <lists@mdiehl.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       fischer@norbit.de, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] aha152x fix
Message-ID: <20020717213543.GA27707@debian>
Mail-Followup-To: Martin Diehl <lists@mdiehl.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	fischer@norbit.de, Marcelo Tosatti <marcelo@conectiva.com.br>
References: <1026860430.1688.95.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.21.0207170156360.6083-100000@notebook.diehl.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0207170156360.6083-100000@notebook.diehl.home>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 10:02:39AM +0200, Martin Diehl wrote:
> 
> > On Tue, 2002-07-16 at 22:10, Filip Van Raemdonck wrote:
> > > 
> > > 
> > > Below is a patch which makes it work again. Note that this is just reverting
> > > a minimal part of the last applied patch to aha152x.c; so this may only be
> > > fixing the symptom and not the problem.
> 
> I can confirm Filip's patch putting back in place the old unlock/lock
> makes things working again. Tested with an AVA1505AE (ISA, configured to
> non-pnp fixed irq/io) on UP box running SMP kernel.

Actually, I'm not sure if it works. I hadn't tried anything more than
loading the card module yesterday since it was getting late, but I am now
getting oopses and almost immediate hard hangs whenever I try to access
the hard drive on that card.
Or rather, whenever I load a driver that hooks into that device. I've had
it when I mounted sda1 (thus loading sd_mod), after rebooting when I tried
to use sg0 (equivalent to sda, also then loading sg module), and when I got
suspicious even when I only just modprobed sd_mod, not doing anything on
the drive yet.

Actually, hold on...
I just rmmodded the aha152x module and then modprobe sd_mod and all was/is
fine now, except that obviously I can't get to my harddrive now - sd_mod is
just an unused driver.

I'm pasting an oops below.

I'm not really certain if this problem is related to the other one, maybe
this is caused by some unrelated change which went into the last aha152x
patch. But that's hard to figure out, if I need my two line fix before I
can load the driver :-<


Regards,

Filip


Jul 17 23:12:10 lucretia kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Jul 17 23:12:10 lucretia kernel: SCSI device sda: 2154176 512-byte hdwr sectors (1103 MB)
Jul 17 23:12:10 lucretia kernel:  sda:<1>Unable to handle kernel NULL pointer dereference at virtual address 0000001b
Jul 17 23:12:10 lucretia kernel:  printing eip:
Jul 17 23:12:10 lucretia kernel: c88f01b7
Jul 17 23:12:10 lucretia kernel: *pde = 00000000
Jul 17 23:12:10 lucretia kernel: Oops: 0000
Jul 17 23:12:10 lucretia kernel: CPU:    0
Jul 17 23:12:10 lucretia kernel: EIP:    0010:[rtc:__insmod_rtc_O/lib/modules/2.4.19-rc1/kernel/drivers/char/r+-73289/96]    Not tainted
Jul 17 23:12:10 lucretia kernel: EFLAGS: 00010002
Jul 17 23:12:10 lucretia kernel: eax: 00000000   ebx: c0cdb600   ecx: c0366000   edx: c2fb8dfc
Jul 17 23:12:10 lucretia kernel: esi: c3aab000   edi: c0cdb600   ebp: c0851c84   esp: c0851c78
Jul 17 23:12:10 lucretia kernel: ds: 0018   es: 0018   ss: 0018
Jul 17 23:12:10 lucretia kernel: Process modprobe (pid: 457, stackpage=c0851000)
Jul 17 23:12:10 lucretia kernel: Stack: 00000293 c380f3f8 c0cdb600 c0851ca0 c88f02c2 c0cdb600 00000000 00000000
Jul 17 23:12:10 lucretia kernel:        00000000 c88e1a94 c0851cc4 c88e154c c0cdb600 c88e1a94 c0cdb600 c380f3f8
Jul 17 23:12:10 lucretia kernel:        c0cdb70c 00000000 c3aab000 c0851cf4 c88e7bed c0cdb600 c0cdb600 00000296
Jul 17 23:12:10 lucretia kernel: Call Trace: [rtc:__insmod_rtc_O/lib/modules/2.4.19-rc1/kernel/drivers/char/r+-73022/96] [rtc:__insmod_rtc_O/lib/modules/2.4.19-rc1/kernel/drivers/char/r+-132460/96] [rtc:__insmod_rtc_O/lib/modules/2.4.19-rc1/kernel/drivers/char/r+-133812/96] [rtc:__insmod_rtc_O/lib/modules/2.4.19-rc1/kernel/drivers/char/r+-132460/96] [rtc:__insmod_rtc_O/lib/modules/2.4.19-rc1/kernel/drivers/char/r+-107539/96]
Jul 17 23:12:10 lucretia kernel:    [scsi_mod:scsi_hosts_Rfba6a71c+131632/65472080] [generic_unplug_device+34/52] [__run_task_queue+75/92] [block_sync_page+25/32] [__lock_page+145/192] [lock_page+23/28]
Jul 17 23:12:10 lucretia kernel:    [read_cache_page+198/288] [read_dev_sector+49/172] [blkdev_readpage+0/24] [handle_ide_mess+41/392] [msdos_partition+126/732] [get_empty_inode+137/156]
Jul 17 23:12:10 lucretia kernel:    [check_partition+265/388] [grok_partitions+193/260] [scsi_mod:scsi_hosts_Rfba6a71c+131632/65472080] [register_disk+37/44] [scsi_mod:scsi_hosts_Rfba6a71c+128360/65475352] [scsi_mod:scsi_hosts_Rfba6a71c+131704/65472008]
Jul 17 23:12:10 lucretia kernel:    [scsi_mod:scsi_hosts_Rfba6a71c+131632/65472080] [rtc:__insmod_rtc_O/lib/modules/2.4.19-rc1/kernel/drivers/char/r+-127803/96] [scsi_mod:scsi_hosts_Rfba6a71c+131632/65472080] [rtc:__insmod_rtc_O/lib/modules/2.4.19-rc1/kernel/drivers/char/r+-127540/96] [scsi_mod:scsi_hosts_Rfba6a71c+131632/65472080] [scsi_mod:scsi_hosts_Rfba6a71c+129673/65474039]
Jul 17 23:12:10 lucretia kernel:    [scsi_mod:scsi_hosts_Rfba6a71c+131632/65472080] [sys_init_module+1291/1444] [scsi_mod:scsi_hosts_Rfba6a71c+121840/65481872] [system_call+51/56]
Jul 17 23:12:10 lucretia kernel:
Jul 17 23:12:10 lucretia kernel: Code: 0f b6 50 1b 8b 14 95 bc 04 32 c0 2b 82 a0 00 00 00 69 c0 a3


-- 
Please don't send proprietary format documents, I can't (and don't want to)
open them.  Appreciated are open-source formats like .txt or .rtf. Dvi, ps or
tex files are welcome.
