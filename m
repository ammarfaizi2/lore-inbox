Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbTASIw6>; Sun, 19 Jan 2003 03:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbTASIw6>; Sun, 19 Jan 2003 03:52:58 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:33259 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265657AbTASIw5>;
	Sun, 19 Jan 2003 03:52:57 -0500
Date: Sun, 19 Jan 2003 10:01:51 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301190901.KAA17983@harpo.it.uu.se>
To: ALESSANDRO.SUARDI@oracle.com
Subject: Re: Why kernel 2.5.58 only mounts / (not home etc)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2003 16:48:44 -0800 (GMT-08:00), Alessandro Suardi wrote:
>As I reported in the same thread as the breakage of modules in 2.5.59,
> module autoloading doesn't work for me since 2.5.58. Using Rusty's
> module-init-tools 0.9.8 or 0.9.9-pre. Same utils work flawlessly under
> 2.4.21-pre3.
>
>I can't run PPP, mount iso9660 CDs, run IrDA - anything modular needs
> manual modprobing in both 2.5.58 and 2.5.59 + Kai's fix.

Module autoloading works fine for me, including PPP and getting
all isofs/cdrom/ide-scsi/etc stuff loaded when mounting a CD.

Relevant .config:

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y

Sample /etc/modprobe.conf:

# ethernet
alias eth0 tulip

# sound
alias sound-slot-0 emu10k1
alias char-major-14 emu10k1

# ide-scsi
alias scsi_hostadapter ide-scsi

# AGP
install agpgart /sbin/modprobe --ignore-install agpgart && /sbin/modprobe intel-agp
remove agpgart /sbin/modprobe -r intel-agp ; /sbin/modprobe -r --ignore-remove agpgart

# /dev/rtc
install char-major-10-135 /bin/true

# parport
alias parport_lowlevel parport_pc
options parport_pc io=0x378 irq=7 dma=3

# ftape3
options ftape ft_fdc_base=0x360 ft_fdc_irq=6 ft_fdc_dma=2

#
# STANDARD STUFF
#
alias block-major-11 sr_mod
alias char-major-6 lp
install char-major-10 /bin/true
alias char-major-10-182 perfctr
alias char-major-21 sg
alias char-major-27 zftape
alias char-major-108 ppp_generic
alias iso9660 isofs
install net-pf-4 /bin/true
install net-pf-5 /bin/true
alias net-pf-17 af_packet
alias ppp-compress-21 bsd_comp
alias ppp-compress-24 ppp_deflate
alias ppp-compress-26 ppp_deflate
alias tty-ldisc-3 ppp_async

If you're running a RedHat system, you'll also need the following
patch to /etc/rc.d/rc.sysinit. Without it the kernel's modprobe and
hotplug functionalities will be disabled by rc.sysinit.

--- /etc/rc.d/rc.sysinit.~1~	2002-08-22 23:10:52.000000000 +0200
+++ /etc/rc.d/rc.sysinit	2003-01-14 03:04:57.000000000 +0100
@@ -334,7 +334,7 @@
     IN_INITLOG=
 fi
 
-if ! grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/ksyms ]; then
+if ! grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/modules ]; then
     USEMODULES=y
 fi
 

(RedHat users should also comment out or remove the /sbin/update line in
/etc/inittab, but that's unrelated to the use of modules.)

/Mikael
