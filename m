Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271167AbTGPWRN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271171AbTGPWOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:14:51 -0400
Received: from codepoet.org ([166.70.99.138]:42114 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S271167AbTGPWOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:14:22 -0400
Date: Wed, 16 Jul 2003 16:29:15 -0600
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.22-pre6 race condition during boot hoses up stat("/")?
Message-ID: <20030716222914.GA15938@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently obtained a P4 and have started building the kernel
with SMP enabled (for hyper-threading).  I have started noticing
some sortof wierd race with mounting root with an Intel ICH5 ide
controller...

Normally doing a stat("/", &buf) gives me the correct st_rdev for
my root device.  But every few boots I find that st_rdev is
instead set to the st_rdev of the last IDE device under /proc/ide
that happens to be using the ide-disk driver..  

Busybox has a find_real_root_device_name() function which depends
upon stat("/") giving the correct st_rdev, and this bug causes it
to do wierd things.

So for example, when booting I see this:

PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA,
hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA,
hdd:DMA
hda: IC35L080AVVA07-0, ATA DISK drive
hdb: WDC AC32500H, ATA DISK drive

My root_fs is on /dev/hda2.

But when running the debugger I see....

38              if (stat("/", &rootStat) != 0) 
(gdb) 
(gdb) p rootStat.st_rdev
$1 = 832
(gdb) p (832 >> 8) & 0xff
$2 = 3
(gdb) p 832 & 0xff
$3 = 64

Which works out to major 3, minor 64, or /dev/hdb!!!

I've attempted to track down where such a problem could
occur, but so far I've come up empty. 

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
