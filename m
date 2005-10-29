Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbVJ2RSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbVJ2RSS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 13:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVJ2RSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 13:18:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61335 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750844AbVJ2RSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 13:18:17 -0400
Date: Sat, 29 Oct 2005 10:18:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Boxer Gnome <aiko.sex@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: boot ok,but reboot hang, from 2.6.10 to 2.6.14
In-Reply-To: <174467f50510290001s6ea2398an@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0510291002260.3348@g5.osdl.org>
References: <174467f50510280544g5fffdfaeq@mail.gmail.com> 
 <Pine.LNX.4.64.0510280733000.4664@g5.osdl.org>  <174467f50510281926tfcbcc4bi@mail.gmail.com>
  <Pine.LNX.4.64.0510282104500.3348@g5.osdl.org>  <174467f50510282358o61c5d977u@mail.gmail.com>
 <174467f50510290001s6ea2398an@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Oct 2005, Boxer Gnome wrote:
>
> Sorry,I typed a little error.
> 
> the"The 2.6.10-rc1-rc8 was still ok" should is "The 2.6.10-rc1-bk8 was still ok"

Ok, thanks, you've been a hero.

This cuts the changes down quite significantly. The shortlog between 
rc1-bk8 and rc1-bk9 is (if I did everything right - since that's from the 
BK days and I obviously don't have BK installed anywhere, I had to convert 
things into git to make sense of it) appended.

I _suspect_ it's the IDE changes: perhaps the fact that we enable IDE 
"stroke" by default now, which unclips the IDE disk. Maybe the BIOS is 
unhappy with that.

In your "dmesg" for a modern kernel, do you get a message like

	...: Host Protected Area detected.
		current capacity is .. sectors (.. MB)
		native  capacity is .. sectors (.. MB)

if so, that's probably it, and you could try this patch.

If that doesn't help, I can help you bisect the problem down to a smaller 
patch, if you're willing to try some patches I'd send by email?

		Linus

---
Hacky patch for you to try with current kernel:

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 234f5de..71bead5 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -498,6 +498,8 @@ static inline void idedisk_check_hpa(ide
 			 capacity, sectors_to_MB(capacity),
 			 set_max, sectors_to_MB(set_max));
 
+	return;
+
 	if (lba48)
 		set_max = idedisk_set_max_address_ext(drive, set_max);
 	else

---
shortlog between rc1-bk8 and rc1-bk9:

Andi Kleen:
      x86_64: Fix safe_smp_processor_id after genapic
      x86_64: Fix warning in genapic

Andrew Morton:
      key_init ordering fix
      swapper_space warning suppression
      ext3 reservation: default to on
      convert pipefs to fs_initcall()

Antonino Daplas:
      fbdev: Convert MODULE_PARM to module_param in i810fb
      fbdev: Remove module parameter 'disabled' from savagefb
      fbdev: Convert MODULE_PARM to module_param in intelfb
      fbdev: Convert MODULE_PARM to module_param in neofb
      fbdev: Fix io access in neofb
      fbdev: Add __iomem annotations to sstfb
      fbdev: Add __iomem annotations to tdfxfb
      fbdev: Do not memset the framebuffer memory in asiliantfb
      fbdev: Add __iomem annotations to cyber2000fb
      fbdev: Add __iomem annotations to pm2fb
      fbdev: Add __iomem annotations to hgafb
      fbdev: Add __iomem annotations to cirrusfb
      fbdev: Add __iomem annotations to vfb
      fbdev: Check if cursor image has changed in intelfb
      fbdev: Maintainership

Bartlomiej Zolnierkiewicz:
      [ide] PIO bugfix
      [ide] remove hwif from /proc/ide/ as part of ide_unregister_hwif()
      [ide] hpt34x: kill hpt34x.h
      [ide] pmac: kill CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
      [ide] setup-pci: small ide_get_or_set_dma_base() cleanup
      [ide] setup-pci: simplify autodma logic
      [ide] kill IDEPCI_FLAG_FORCE_MASTER
      [ide] make destroy_proc_ide_interfaces static
      [ide] ide-disk: enable stroke by default

Benjamin Herrenschmidt:
      ppc32: Fix boot on PowerMac
      ppc64: Enable maple IDE fixup

Chris Wright:
      uninline __sigqueue_alloc

Daniel Jacobowitz:
      Unwind information fix for the vsyscall DSO

Dmitry Torokhov:
      ik8.c: export power_status parameter through sysfs

Hirokazu Takata:
      m32r: fix a typo of delay.c

James Nelson:
      Documentation/cpqarray.txt update
      Documentation/mkdev.ida removal

Linus Torvalds:
      Make x86 semaphore routines use register calling convention.
      Merge bk://bart.bkbits.net/ide-2.6
      Merge bk://bk.arm.linux.org.uk/linux-2.6-rmk

Marcel Holtmann:
      Fix deprecated MODULE_PARM for CAPI subsystem

Matt Porter:
      ppc32: fix ppc4xx_progress warnings

Mingming Cao:
      ext3 block reservation patch set -- ext3 preallocation cleanup
      ext3 block reservations

Olof Johansson:
      ppc64: setup cpu_sibling_map on iSeries

Paolo \'Blaisorblade\' Giarrusso:
      uml: fix mainline lazyness about TTY layer patch

Pavel Machek:
      Add typechecking to suspend types and powerdown types

Robert Love:
      make dnotify a configure-time option

Russell King:
      [ARM] Use cpu_vm_mask to indicate whether the MM is mapped.
      [ARM] Use cpu_vm_mask to determine whether to flush TLB/caches.
      [ARM] Add disable_irq_nosync() and CPU number headings
      [ARM] Remove extraneous spaces.
      [ARM] include/asm-arm/arch-integrator/time.h is unused, remove it.
      [ARM] Fix wrong variable name in icside.c

Stephen C. Tweedie:
      ext3: online resizing

Stephen Rothwell:
      ppc64 iSeries: fix for generic irq changes

Toshihiro Iwamoto:
      direct IO write memory leak fix

