Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSHVWl7>; Thu, 22 Aug 2002 18:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317911AbSHVWl7>; Thu, 22 Aug 2002 18:41:59 -0400
Received: from rtknat.rentrak.com ([208.26.192.4]:25061 "EHLO vader.zolan.org")
	by vger.kernel.org with ESMTP id <S317637AbSHVWl6>;
	Thu, 22 Aug 2002 18:41:58 -0400
Date: Thu, 22 Aug 2002 15:46:02 -0700 (PDT)
From: jerry@linuxscripts.com
X-X-Sender: jerry@vader.zolan.org
To: linux-kernel@vger.kernel.org
Subject: APM/Sound on a Dell Inspiron 3500 fix.
Message-ID: <Pine.LNX.4.44.0208221518430.4469-100000@vader.zolan.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:  
When doing a suspend/resume cycle on a Dell Inspiron 3500 the 
sound begins to skip.

Full Description:
Due to research I have done on the web, it appears this is a problem for 
everyone running Linux on their Dell Inspiron 3500, and specifically this 
model.  Using the Microsoft Sound System support from the kernel (2.4.18 
with the Preemptible Patch)  Problem occurs without the patch as well. The 
sound works fine until a suspend.  When resuming the sound begins to skip.  
A simple unload/reload of the sound modules (ad1848, sound, soundcore) 
does not fix the problem.  However, after playing around for quite some 
time I have noticed that an unload of these modules, then a load of the 
(sb and uart401), then an unload of the (sb and uart401), then a reload of 
the (ad1848) clears the problem up.

My entire sound system is compiled as a module.  My initial load of the 
modules is:
/sbin/modprobe ad1848 io=0x530 irq=5 dma=0 dma2=1

I have apmd run a workaround script on a resume to fix the problem.

My workaround script to fix the problem is:
#!/bin/sh
/sbin/modprobe -r ad1848
/sbin/modprobe sb io=0x220 irq=5 dma=0 dma16=1
/sbin/modprobe uart401
/sbin/modprobe -r sb
/sbin/modprobe ad1848 io=0x530 irq=5 dma=0 dma2=1

Here is an output of lspci:
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:04.0 CardBus bridge: Texas Instruments PCI1220 (rev 02)
00:04.1 CardBus bridge: Texas Instruments PCI1220 (rev 02)
00:07.0 Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
01:00.0 VGA compatible controller: Neomagic Corporation [MagicMedia 256AV] (rev 20)
01:00.1 Multimedia audio controller: Neomagic Corporation [MagicMedia 256AV Audio] (rev 20)

The NM256AV/NM256ZX audio support instantly goes into skipping mode before 
the first suspend.

I have no interrupts conflicting.  I am using devfs, but people with 
kernel 2.2 have the same problem.  I am using framebuffers thought problem 
happens with and without them compiled into the kernel.  I have 
re-compiled the kernel countless times in countless ways and always the 
same problem.  Following is my apm and sound setup.

APM settings
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y

Sound settings
CONFIG_SOUND=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_SOUND_ADLIB=m
CONFIG_SOUND_SOUND_VMIDI=m
CONFIG_SOUND_SOUND_MSS=m
CONFIG_SOUND_SOUND_NM256=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
CONFIG_SOUND_YMFPCI_LEGACY=y

I only use the modules that I had mentioned above even though more are 
compiled.


**My worthless point of view**
It seems to me that the problem would be with this laptop's apm on bios 
level.  However, it seems that the sb module does some sort of 
re-initialize to the sound device that the ad1848 fails to do.  I'm not 
sure what the correct fix is, but I, and others with the same laptop, 
would be happy if someone could take this information and maybe come up 
with a better solution to the problem.

Thanks,

Jerry Kilpatrick


Kilpatrick  -- Clan Colquhoun -- Motto: If I Can
MacLean     -- Clan MacLean   -- Motto: Virtue Mine Honour

